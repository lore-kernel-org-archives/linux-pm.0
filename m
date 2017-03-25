From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] cpufreq: Bring CPUs up even if cpufreq_online failed
Date: Sat, 25 Mar 2017 12:20:11 +0800
Message-ID: <1490415611-16945-1-git-send-email-yu.c.chen@intel.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Chen Yu <yu.c.chen@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "Stable # 4 . 9+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

There is a report that after
commit 27622b061eb4 ("cpufreq: Convert to hotplug state machine"),
the normal CPU offline/online cycle failed on some platforms.
According to the ftrace result, this problem was triggered on
platforms using acpi-freq as the default cpufreq driver,
and due to the lack of some ACPI freq method(_PCT eg), the
cpufreq_online failed and returned a negative value, thus the cpu
hotplug statemachine rollbacked the CPU online process. Actually
the failure of cpufreq_online should not impact the whole CPU
online process according to the original semantics before above patch.
BTW, during system bootup the cpufreq_online is not invoked via
cpuhotplug statemachine but by the cpufreq device creation process,
thus the APs can be brought up although cpufreq_online failed in that
stage.

This patch ignores the return value of cpufreq_online/offline and
prints a warning if there is a failure.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=194581
Fixes: 27622b061eb4 ("cpufreq: Convert to hotplug state machine")
Reported-and-tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: Stable <stable@vger.kernel.org> # 4.9+
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpufreq/cpufreq.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b8ff617..1c13873 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2391,6 +2391,28 @@ EXPORT_SYMBOL_GPL(cpufreq_boost_enabled);
  *********************************************************************/
 static enum cpuhp_state hp_online;
 
+static int cpuhp_cpufreq_online(unsigned int cpu)
+{
+	int ret = cpufreq_online(cpu);
+
+	if (ret)
+		pr_err("Failed to bring cpufreq online for CPU%u. (%d)\n",
+			cpu, ret);
+
+	return 0;
+}
+
+static int cpuhp_cpufreq_offline(unsigned int cpu)
+{
+	int ret = cpufreq_offline(cpu);
+
+	if (ret)
+		pr_err("Failed to put cpufreq offline for CPU%u. (%d)\n",
+			cpu, ret);
+
+	return 0;
+}
+
 /**
  * cpufreq_register_driver - register a CPU Frequency driver
  * @driver_data: A struct cpufreq_driver containing the values#
@@ -2453,8 +2475,8 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
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
