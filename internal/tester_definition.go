package internal

import (
	testerutils "github.com/codecrafters-io/tester-utils"
)

var testerDefinition = testerutils.TesterDefinition{
	AntiCheatTestCases:    []testerutils.TestCase{},
	ExecutableFileName: "your_git.sh",
	TestCases: []testerutils.TestCase{
		{
			Slug:                    "init",
			TestFunc:                testInit,
		},
		{
			Slug:                    "read_blob",
			TestFunc:                testReadBlob,
		},
		{
			Slug:                    "create_blob",
			TestFunc:                testCreateBlob,
		},
		{
			Slug:                    "read_tree",
			TestFunc:                testReadTree,
		},
		{
			Slug:                    "write_tree",
			TestFunc:                testWriteTree,
		},
		{
			Slug:                    "create_commit",
			TestFunc:                testCreateCommit,
		},
		{
			Slug:                    "clone_repository",
			TestFunc:                testCloneRepository,
		},
	},
}
