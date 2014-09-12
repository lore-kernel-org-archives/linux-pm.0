From: Aaron Lu <aaron.lu@intel.com>
Subject: [LKP] Unable to change cpufreq governor
Date: Fri, 12 Sep 2014 13:22:54 +0800
Message-ID: <5412832E.7000406@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:11698 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752107AbaILFXR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 12 Sep 2014 01:23:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Linux-pm mailing list <linux-pm@vger.kernel.org>, lkp@01.org, Fengguang Wu <fengguang.wu@intel.com>

Hi Viresh,

The script used in LKP to change cpufreq governor triggered a lot of
errors on different test boxes with your branch:
https://git.linaro.org/people/vireshk/linux cpufreq/governor-fixes

[root@localhost cpufreq]# pwd
/sys/devices/system/cpu/cpu3/cpufreq
[root@localhost cpufreq]# echo ondemand > scaling_governor 
bash: echo: write error: Device or resource busy

This only occurs for acpi-cpufreq scaling driver.

After turned on the debug level:
[root@localhost ~]# echo 'module cpufreq +pft' > /sys/kernel/debug/dynamic_debug/control
And added a little more debug statements:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 051d566dc522..4175b1cf7995 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2009,7 +2009,7 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 					unsigned int event)
 {
-	int ret, state;
+	int ret, state, busy;
 
 	/* Only must be defined when default governor is known to have latency
 	   restrictions, like e.g. conservative or ondemand.
@@ -2046,9 +2046,12 @@ static int __cpufreq_governor(struct cpufreq_policy *policy,
 
 	mutex_lock(&cpufreq_governor_lock);
 	state = get_governor_state(policy);
+	pr_debug("state=%u\n", state);
 
 	/* Check if operation is permitted or not */
-	if (is_governor_busy(policy)
+	busy = is_governor_busy(policy);
+	pr_debug("busy=%d\n", busy);
+	if (busy
 	    || (state == CPUFREQ_GOV_START && event != CPUFREQ_GOV_LIMITS && event != CPUFREQ_GOV_STOP)
 	    || (state == CPUFREQ_GOV_STOP && event != CPUFREQ_GOV_START && event != CPUFREQ_GOV_POLICY_EXIT)
 	    || (state == CPUFREQ_GOV_POLICY_INIT && event != CPUFREQ_GOV_START && event != CPUFREQ_GOV_POLICY_EXIT)


the following output is printed with the above echo command:
[   61.869713] [1263] cpufreq_set_policy: cpufreq: setting new policy for CPU 3: 1600000 - 3401000 kHz
[   61.869732] [1263] cpufreq_set_policy: cpufreq: new min and max freqs are 1600000 - 3401000 kHz
[   61.869734] [1263] cpufreq_set_policy: cpufreq: governor switch
[   61.869736] [1263] __cpufreq_governor: cpufreq: __cpufreq_governor for CPU 3, event 2
[   61.869739] [1263] __cpufreq_governor: cpufreq: state=5
[   61.869741] [1263] __cpufreq_governor: cpufreq: busy=0

Please let me know if you need more information, thanks.

-Aaron
