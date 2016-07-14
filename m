From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 2/2][RFC v4] PM / Documentation: Add description for snapshot test mode
Date: Thu, 14 Jul 2016 21:15:55 +0800
Message-ID: <3eaa18eb6585fd910639e6aa81ed40edb2324ca3.1468500857.git.yu.c.chen@intel.com>
References: <cover.1468500857.git.yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:37824 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751295AbcGNNIb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 14 Jul 2016 09:08:31 -0400
In-Reply-To: <cover.1468500857.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>

Introduce snapshot test mode for hibernation debugging, and
update the document accordingly.

Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 Documentation/power/basic-pm-debugging.txt | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/power/basic-pm-debugging.txt b/Documentation/power/basic-pm-debugging.txt
index b96098c..5cc5b21 100644
--- a/Documentation/power/basic-pm-debugging.txt
+++ b/Documentation/power/basic-pm-debugging.txt
@@ -41,7 +41,7 @@ a) Test modes of hibernation
 To find out why hibernation fails on your system, you can use a special testing
 facility available if the kernel is compiled with CONFIG_PM_DEBUG set.  Then,
 there is the file /sys/power/pm_test that can be used to make the hibernation
-core run in a test mode.  There are 5 test modes available:
+core run in a test mode.  There are 6 test modes available:
 
 freezer
 - test the freezing of processes
@@ -62,6 +62,11 @@ core
   control methods(*), the disabling of nonboot CPUs and suspending of
   platform/system devices
 
+snapshot
+- test the freezing of processes, suspending of devices, platform global
+  control methods(*), the disabling of nonboot CPUs, suspending of
+  platform/system devices and the restoring of snapshot image
+
 (*) the platform global control methods are only available on ACPI systems
     and are only tested if the hibernation mode is set to "platform"
 
@@ -95,7 +100,7 @@ one and the "core" level tests the hardware and drivers as deeply as possible
 without creating a hibernation image.  Obviously, if the "devices" test fails,
 the "platform" test will fail as well and so on.  Thus, as a rule of thumb, you
 should try the test modes starting from "freezer", through "devices", "platform"
-and "processors" up to "core" (repeat the test on each level a couple of times
+, "processors" and "core" up to "snapshot" (repeat the test on each level a couple of times
 to make sure that any random factors are avoided).
 
 If the "freezer" test fails, there is a task that cannot be frozen (in that case
@@ -140,7 +145,11 @@ devices has failed (these devices are suspended on one CPU with interrupts off),
 the problem is most probably hardware-related and serious, so it should be
 reported.
 
-A failure of any of the "platform", "processors" or "core" tests may cause your
+If the "snapshot" test fails, which means that restoring of the pages from the
+swap device has failed, it might be caused by a broken swap device, or other memory
+management issues, so it should be reported.
+
+A failure of any of the "platform", "processors" "core" or "snapshot" tests may cause your
 system to hang or become unstable, so please beware.  Such a failure usually
 indicates a serious problem that very well may be related to the hardware, but
 please report it anyway.
-- 
2.7.4

