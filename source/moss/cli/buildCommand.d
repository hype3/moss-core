/*
 * This file is part of moss.
 *
 * Copyright © 2020 Serpent OS Developers
 *
 * This software is provided 'as-is', without any express or implied
 * warranty. In no event will the authors be held liable for any damages
 * arising from the use of this software.
 *
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 *
 * 1. The origin of this software must not be misrepresented; you must not
 *    claim that you wrote the original software. If you use this software
 *    in a product, an acknowledgment in the product documentation would be
 *    appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 *    misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 */

/**
 * Build command implementation
 */
module moss.cli.buildCommand;
import moss.cli;

import moss.format.binary;

static ExitStatus buildExecute(ref Processor p)
{
    import std.stdio;

    auto writer = new Writer("testpackage.stone");
    scope (exit)
    {
        writer.close();
    }

    writer.addRecord(RecordTag.Name, "some-package"); /* Should pass */
    writer.addRecord(RecordTag.Architecture, "some-architecture");

    stderr.writeln("Writer test");
    return ExitStatus.Failure;
}

const Command buildCommand = {
    primary: "build", secondary: "bi", blurb: "Build a package", usage: "build [spec]",
    exec: &buildExecute, helpText: `
Build a binary package from the given package specification file. It will
be built using the locally available build dependencies and the resulting
binary packages (.stone) will be emitted to the output directory, which
defaults to the current working directory.
`
};
