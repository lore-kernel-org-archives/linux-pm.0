From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH v2] PM / sleep: add configurable delay for pm_test
Date: Sun, 22 Feb 2015 00:26:54 -0800
Message-ID: <20150222082654.GB24441@norris-Latitude-E6410>
References: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36787 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbbBVI06 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 22 Feb 2015 03:26:58 -0500
Content-Disposition: inline
In-Reply-To: <1409788535-28264-1-git-send-email-computersforpeace@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Cernekee <cernekee@gmail.com>, Chirantan Ekbote <chirantan@chromium.org>

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
---
v2: - make this a module param instead of an explicit sysfs file
    - drop the for loop; mdelay() does the same loop internally
    - decrease +36 lines of code and +2 lines of doc, to +6 lines of code and
      +2 lines of doc

 kernel/power/suspend.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

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

