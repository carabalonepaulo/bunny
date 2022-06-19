switch("verbosity", "0")
switch("hints", "off")

const ResDir = ".\\resources\\"
const DebugDir = ".\\bin\\debug\\"
const ReleaseDir = ".\\bin\\release\\"
const SrcDir = ".\\src\\"
const Main = "main"

task build, "build project":
    rmDir(DebugDir)
    mkDir(DebugDir)
    exec("xcopy /q /s /i /y " & ResDir & " " & DebugDir)
    exec("nim c --gc:orc --out:" & DebugDir & Main & " " & SrcDir & Main)

task release, "build project (release)":
    rmDir(ReleaseDir)
    mkDir(ReleaseDir)
    exec("xcopy /q /s /i /y " & ResDir & " " & ReleaseDir)
    exec("nim c -d:release --gc:orc --opt:speed --checks:off --assertions:off --out:" & ReleaseDir & Main & " " & SrcDir & Main)