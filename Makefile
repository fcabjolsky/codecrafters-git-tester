.PHONY: release build test test_with_git copy_course_file

current_version_number := $(shell git tag --list "v*" | sort -V | tail -n 1 | cut -c 2-)
next_version_number := $(shell echo $$(($(current_version_number)+1)))

release:
	git tag v$(next_version_number)
	git push origin main v$(next_version_number)

build:
	go build -o dist/main.out ./cmd/tester

test:
	go test -v ./internal/



test_with_git: build
	CODECRAFTERS_SUBMISSION_DIR=$(shell ./get_project_path.sh) \
	CODECRAFTERS_TEST_CASES_JSON='[{"slug":"init","tester_log_prefix":"stage-1","title":"Stage #1: Initialize the .git directory"},{"slug":"read_blob","tester_log_prefix":"stage-2","title":"Stage #2: Read a blob object"},{"slug":"create_blob","tester_log_prefix":"stage-3","title":"Stage #3: Create a blob object"},{"slug":"read_tree","tester_log_prefix":"stage-4","title":"Stage #4: Read a tree object"},{"slug":"write_tree","tester_log_prefix":"stage-5","title":"Stage #5: Write a tree object"},{"slug":"create_commit","tester_log_prefix":"stage-6","title":"Stage #6: Create a commit"},{"slug":"clone_repository","tester_log_prefix":"stage-7","title":"Stage #7: Clone a repository"}]' \
	dist/main.out

test_stage: build
	CODECRAFTERS_SUBMISSION_DIR=$(shell ./get_project_path.sh) \
	CODECRAFTERS_TEST_CASES_JSON='$(shell echo '[{},{"slug":"init","tester_log_prefix":"stage-1","title":"Stage #1: Initialize the .git directory"},{"slug":"read_blob","tester_log_prefix":"stage-2","title":"Stage #2: Read a blob object"},{"slug":"create_blob","tester_log_prefix":"stage-3","title":"Stage #3: Create a blob object"},{"slug":"read_tree","tester_log_prefix":"stage-4","title":"Stage #4: Read a tree object"},{"slug":"write_tree","tester_log_prefix":"stage-5","title":"Stage #5: Write a tree object"},{"slug":"create_commit","tester_log_prefix":"stage-6","title":"Stage #6: Create a commit"},{"slug":"clone_repository","tester_log_prefix":"stage-7","title":"Stage #7: Clone a repository"}]' | jq -c '[.[$(STAGE)]]')' \
	dist/main.out

test_to_stage: build
	CODECRAFTERS_SUBMISSION_DIR=$(shell ./get_project_path.sh) \
															CODECRAFTERS_TEST_CASES_JSON='$(shell echo '[{"slug":"init","tester_log_prefix":"stage-1","title":"Stage #1: Initialize the .git directory"},{"slug":"read_blob","tester_log_prefix":"stage-2","title":"Stage #2: Read a blob object"},{"slug":"create_blob","tester_log_prefix":"stage-3","title":"Stage #3: Create a blob object"},{"slug":"read_tree","tester_log_prefix":"stage-4","title":"Stage #4: Read a tree object"},{"slug":"write_tree","tester_log_prefix":"stage-5","title":"Stage #5: Write a tree object"},{"slug":"create_commit","tester_log_prefix":"stage-6","title":"Stage #6: Create a commit"},{"slug":"clone_repository","tester_log_prefix":"stage-7","title":"Stage #7: Clone a repository"}]' | jq -c '.[0:$(TO)]')' \
	dist/main.out


copy_course_file:
	hub api \
		repos/rohitpaulk/codecrafters-server/contents/codecrafters/store/data/git.yml \
		| jq -r .content \
		| base64 -d \
		> internal/test_helpers/course_definition.yml

update_tester_utils:
	go get -u github.com/codecrafters-io/tester-utils
