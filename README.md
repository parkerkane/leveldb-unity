leveldb for Unity3D
===================

[leveldb] bindings for [Unity3D]. Uses [leveldb-sharp] by Mirco Bauer.

`Makefile` automatically generates `unitypackage` file which includes binaries for Android and iOS.

Requirements
------------

 - OS X (tested with 10.9)
 - [Android NDK]
 
How to build
------------
 
 	$ git clone https://github.com/parkerkane/leveldb-unity.git --recursive
 	$ cd leveldb-unity/
 	$ NDK=/path/to/android/ndk/ make

Compiled unity package file is now in `build` folder

Todo
----

 - OSX support
 - Windows support
 - Windows Phone support

License
-------
```
Copyright (c) 2012 Mirco Bauer <meebey@meebey.net>
Copyright (c) 2011 The LevelDB Authors

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

   * Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.
   * Redistributions in binary form must reproduce the above
     copyright notice, this list of conditions and the following disclaimer
     in the documentation and/or other materials provided with the
     distribution.
   * Neither the name of Google Inc. nor the names of its
     contributors may be used to endorse or promote products derived from
     this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
```

[leveldb]: https://code.google.com/p/leveldb/
[Unity3D]: https://unity3d.com/
[Android NDK]: https://developer.android.com/tools/sdk/ndk/index.html
[leveldb-sharp]: https://github.com/meebey/leveldb-sharp
