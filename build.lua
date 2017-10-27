#!/usr/bin/env texlua

module = "adelaide-exam"

unpackfiles = {}
typesetfiles = {}
sourcefiles = {"*.cls"}
installfiles = {"*.cls"}

kpse.set_program_name("kpsewhich")
buildscript = kpse.lookup("l3build.lua")
dofile(buildscript)
