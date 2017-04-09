From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v2] cpufreq: Bring CPUs up even if cpufreq_online failed
Date: Sun,  9 Apr 2017 13:45:16 +0800
Message-ID: <1491716716-22222-1-git-send-email-yu.c.chen@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:37943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbdDIFpa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 9 Apr 2017 01:45:30 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chen Yu <yu.c.chen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Stable # 4 . 9+" <stable@vger.kernel.org>

There is a report that after
commit 27622b061eb4 ("cpufreq: Convert to hotplug state machine"),
the normal CPU offline/online cycle failed on some platforms.
According to the ftrace result, this problem was triggered on
platforms using acpi-freq as the default cpufreq driver,
and due to the lack of some ACPI freq method(_PCT eg), the
cpufreq_online failed and returned a negative value, thus the CPU
hotplug statemachine rollbacked the CPU online process. Actually
from the user's perspective the failure of cpufreq_online should
not prevent that CPU from being brought up, although cpufreq might
not work on that CPU. BTW, during system bootup the cpufreq_online
is not invoked via cpuhotplug statemachine but by the cpufreq device
creation process, thus the APs can be brought up although cpufreq_online
failed in that stage.

This patch ignores the return value of cpufreq_online/offline and
let the cpufreq framework to deal with the failure that, cpufreq_online()
will do a proper rollback in that case. And if the _PCT is missing,
the acpi cpufreq driver will print a warning if the corresponding
debug options have been enabled.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=194581
Fixes: 27622b061eb4 ("cpufreq: Convert to hotplug state machine")
Reported-and-tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Stable <stable@vger.kernel.org> # 4.9+
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2:
 - According to Rafael and Sebastian's suggestion, remove
   the error log in cpuhp_cpufreq_online/offline, and let
   the cpufreq_online and cpufreq_offline to print the warning
   and do the necessary rollback if they failed.
---
 drivers/cpufreq/cpufreq.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index bc96d42..0e3f649 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2398,6 +2398,20 @@ EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
  *********************************************************************/
 static enum cpuhp_state hp_online;
 
+static int cpuhp_cpufreq_online(unsigned int cpu)
+{
+	cpufreq_online(cpu);
+
+	return 0;
+}
+
+static int cpuhp_cpufreq_offline(unsigned int cpu)
+{
+	cpufreq_offline(cpu);
+
+	return 0;
+}
+
 /**
  * cpufreq_register_driver - register a CPU Frequency driver
  * @driver_data: A struct cpufreq_driver containing the values#
@@ -2460,8 +2474,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 	}
 
 	ret = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN, "cpufreq:online",
-					cpufreq_online,
-					cpufreq_offline);
+					cpuhp_cpufreq_online,
+					cpuhp_cpufreq_offline);
 	if (ret < 0)
 		goto err_if_unreg;
 	hp_online = ret;
-- 
2.7.4
