#!/bin/bash


jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore /root/android_hack/my-release-key.keystore -storepass android $1 alias_name
