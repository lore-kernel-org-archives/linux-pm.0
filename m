From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v3] PM / sleep: add configurable delay for pm_test
Date: Sun, 22 Feb 2015 21:16:49 -0800
Message-ID: <20150223051649.GC24441@norris-Latitude-E6410>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
 <20150222082654.GB24441@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:38749 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbbBWFQz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Feb 2015 00:16:55 -0500
Content-Disposition: inline
In-Reply-To: <20150222082654.GB24441@norris-Latitude-E6410>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Cernekee <cernekee@chromium.org>, Chirantan Ekbote <chirantan@chromium.org>

When CONFIG_PM_DEBUG=y, we provide a sysfs file (/sys/power/pm_test) for
selecting one of a few suspend test modes, where rather than entering a
full suspend state, the kernel will perform some subset of suspend
steps, wait 5 seconds, and then resume back to normal operation.

This mode is useful for (among other things) observing the state of the
system just before entering a sleep mode, for debugging or analysis
purposes. However, a constant 5 second wait is not sufficient for some
sorts of analysis; for example, on an SoC, one might want to use
external tools to probe the power states of various on-chip controllers
or clocks.

This patch turns this 5 second delay into a configurable module
parameter, so users can determine how long to wait in this
pseudo-suspend state before resuming the system.

Example (wait 30 seconds);

  # echo 30 > /sys/module/suspend/parameters/pm_test_delay
  # echo core > /sys/power/pm_test
  # time echo mem  > /sys/power/state
  ...
  [   17.583625] suspend debug: Waiting for 30 second(s).
  ...
  real	0m30.381s
  user	0m0.017s
  sys	0m0.080s

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Reviewed-by: Kevin Cernekee <cernekee@chromium.org>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
v3: - document in a few more places

v2: - make this a module param instead of an explicit sysfs file
    - drop the for loop; mdelay() does the same loop internally
    - decrease +36 lines of code and +2 lines of doc, to +6 lines of code and
      +2 lines of doc

 Documentation/kernel-parameters.txt        |  7 +++++++
 Documentation/power/basic-pm-debugging.txt | 10 ++++++----
 kernel/power/suspend.c                     | 13 +++++++++++--
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 176d4fe4f076..0b8a1fd0d08d 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -3433,6 +3433,13 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			improve throughput, but will also increase the
 			amount of memory reserved for use by the client.
 
+	suspend.pm_test_delay=
+			[SUSPEND]
+			Sets the number of seconds to remain in a suspend test
+			mode before resuming the system (see
+			/sys/power/pm_test). Only available when CONFIG_PM_DEBUG
+			is set. Default value is 5.
+
 	swapaccount=[0|1]
 			[KNL] Enable accounting of swap in memory resource
 			controller if no parameter or 1 is given or disable
diff --git a/Documentation/power/basic-pm-debugging.txt b/Documentation/power/basic-pm-debugging.txt
index edeecd447d23..b96098ccfe69 100644
--- a/Documentation/power/basic-pm-debugging.txt
+++ b/Documentation/power/basic-pm-debugging.txt
@@ -75,12 +75,14 @@ you should do the following:
 # echo platform > /sys/power/disk
 # echo disk > /sys/power/state
 
-Then, the kernel will try to freeze processes, suspend devices, wait 5 seconds,
-resume devices and thaw processes.  If "platform" is written to
+Then, the kernel will try to freeze processes, suspend devices, wait a few
+seconds (5 by default, but configurable by the suspend.pm_test_delay module
+parameter), resume devices and thaw processes.  If "platform" is written to
 /sys/power/pm_test , then after suspending devices the kernel will additionally
 invoke the global control methods (eg. ACPI global control methods) used to
-prepare the platform firmware for hibernation.  Next, it will wait 5 seconds and
-invoke the platform (eg. ACPI) global methods used to cancel hibernation etc.
+prepare the platform firmware for hibernation.  Next, it will wait a
+configurable number of seconds and invoke the platform (eg. ACPI) global
+methods used to cancel hibernation etc.
 
 Writing "none" to /sys/power/pm_test causes the kernel to switch to the normal
 hibernation/suspend operations.  Also, when open for reading, /sys/power/pm_test
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index c347e3ce3a55..aee23dab0a55 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -28,6 +28,7 @@
 #include <linux/ftrace.h>
 #include <trace/events/power.h>
 #include <linux/compiler.h>
+#include <linux/moduleparam.h>
 
 #include "power.h"
 
@@ -204,12 +205,20 @@ static bool platform_suspend_again(suspend_state_t state)
 		suspend_ops->suspend_again() : false;
 }
 
+#ifdef CONFIG_PM_DEBUG
+static unsigned int pm_test_delay = 5;
+module_param(pm_test_delay, uint, 0644);
+MODULE_PARM_DESC(pm_test_delay,
+		 "Number of seconds to wait before resuming from suspend test");
+#endif
+
 static int suspend_test(int level)
 {
 #ifdef CONFIG_PM_DEBUG
 	if (pm_test_level == level) {
-		printk(KERN_INFO "suspend debug: Waiting for 5 seconds.\n");
-		mdelay(5000);
+		printk(KERN_INFO "suspend debug: Waiting for %d second(s).\n",
+				pm_test_delay);
+		mdelay(pm_test_delay * 1000);
 		return 1;
 	}
 #endif /* !CONFIG_PM_DEBUG */
-- 
2.3.0

