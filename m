From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 02/18] docs: fix location of request_firmware & friends
Date: Mon,  7 May 2018 06:35:38 -0300
Message-ID: <9e40d0b3a085a937b42ec60a3b2409cf820ca713.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1525684985.git.mchehab+samsung@kernel.org>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masanari Iida <standby24x7@gmail.com>, linux-pm@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-pm@vger.kernel.org

commit 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
and other commits renamed the old firmware_class.c file and split it
into separate files, but documentation was not changed accordingly,
causing Sphinx errors.

Change the location accordingly at the documentation files.

While here, add a missing entry at request_firmware.rst for
release_firmware() function.

Fixes: 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
Cc: Kees Cook <keescook@chromium.org>
Cc: Luis R. Rodriguez <mcgrof@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/dell_rbu.txt                      |  4 ++--
 .../driver-api/firmware/fallback-mechanisms.rst |  2 +-
 .../driver-api/firmware/request_firmware.rst    | 17 +++++++++++------
 Documentation/driver-api/infrastructure.rst     |  2 +-
 Documentation/power/suspend-and-cpuhotplug.txt  |  2 +-
 5 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
index 0fdb6aa2704c..befeff80e7ec 100644
--- a/Documentation/dell_rbu.txt
+++ b/Documentation/dell_rbu.txt
@@ -121,8 +121,8 @@ read back the image downloaded.
 
 .. note::
 
-   This driver requires a patch for firmware_class.c which has the modified
-   request_firmware_nowait function.
+   This driver requires a patch for drivers/base/firmware_loader/main.c
+   which has the modified request_firmware_nowait() function.
 
    Also after updating the BIOS image a user mode application needs to execute
    code which sends the BIOS update request to the BIOS. So on the next reboot
diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
index f353783ae0be..7aed31b5a439 100644
--- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
+++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
@@ -72,7 +72,7 @@ the firmware requested, and establishes it in the device hierarchy by
 associating the device used to make the request as the device's parent.
 The sysfs directory's file attributes are defined and controlled through
 the new device's class (firmware_class) and group (fw_dev_attr_groups).
-This is actually where the original firmware_class.c file name comes from,
+This is actually where drivers/base/firmware_loader/fallback.c comes from,
 as originally the only firmware loading mechanism available was the
 mechanism we now use as a fallback mechanism.
 
diff --git a/Documentation/driver-api/firmware/request_firmware.rst b/Documentation/driver-api/firmware/request_firmware.rst
index cf4516dfbf96..8e34d29ea02d 100644
--- a/Documentation/driver-api/firmware/request_firmware.rst
+++ b/Documentation/driver-api/firmware/request_firmware.rst
@@ -17,19 +17,24 @@ an error is returned.
 
 request_firmware
 ----------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware
 
 request_firmware_direct
 -----------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware_direct
 
 request_firmware_into_buf
 -------------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware_into_buf
 
+release_firmware
+----------------
+.. kernel-doc:: drivers/base/firmware_loader/main.c
+   :functions: release_firmware
+
 Asynchronous firmware requests
 ==============================
 
@@ -41,7 +46,7 @@ in atomic contexts.
 
 request_firmware_nowait
 -----------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: request_firmware_nowait
 
 Special optimizations on reboot
@@ -54,8 +59,8 @@ this can be done with firmware_request_cache() insted of requesting for the
 firmare to be loaded.
 
 firmware_request_cache()
------------------------
-.. kernel-doc:: drivers/base/firmware_class.c
+------------------------
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :functions: firmware_request_cache
 
 request firmware API expected driver use
diff --git a/Documentation/driver-api/infrastructure.rst b/Documentation/driver-api/infrastructure.rst
index 6d9ff316b608..bee1b9a1702f 100644
--- a/Documentation/driver-api/infrastructure.rst
+++ b/Documentation/driver-api/infrastructure.rst
@@ -28,7 +28,7 @@ Device Drivers Base
 .. kernel-doc:: drivers/base/node.c
    :internal:
 
-.. kernel-doc:: drivers/base/firmware_class.c
+.. kernel-doc:: drivers/base/firmware_loader/main.c
    :export:
 
 .. kernel-doc:: drivers/base/transport_class.c
diff --git a/Documentation/power/suspend-and-cpuhotplug.txt b/Documentation/power/suspend-and-cpuhotplug.txt
index 31abd04b9572..6f55eb960a6d 100644
--- a/Documentation/power/suspend-and-cpuhotplug.txt
+++ b/Documentation/power/suspend-and-cpuhotplug.txt
@@ -168,7 +168,7 @@ update on the CPUs, as discussed below:
 
 [Please bear in mind that the kernel requests the microcode images from
 userspace, using the request_firmware() function defined in
-drivers/base/firmware_class.c]
+drivers/base/firmware_loader/main.c]
 
 
 a. When all the CPUs are identical:
-- 
2.17.0
