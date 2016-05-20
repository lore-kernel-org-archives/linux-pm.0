From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU offline/online locked
Date: Fri, 20 May 2016 03:41:32 +0200
Message-ID: <2278154.xyiFOocWfq@vostro.rjw.lan>
References: <19792191.esL3UuyORb@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:58818 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751646AbcETBh7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 21:37:59 -0400
In-Reply-To: <19792191.esL3UuyORb@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Loops over online CPUs in cpufreq_stats_init() and cpufreq_stats_exit()
should be carried out with CPU offline/online locked or races are
possible otherwise, so make that happen.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: On a second thought, add the policy notifier in cpufreq_stats_init()
  with CPU offline/online locked too.

---
 drivers/cpufreq/cpufreq_stats.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_stats.c
+++ linux-pm/drivers/cpufreq/cpufreq_stats.c
@@ -317,10 +317,13 @@ static int __init cpufreq_stats_init(voi
 	unsigned int cpu;
 
 	spin_lock_init(&cpufreq_stats_lock);
+
+	get_online_cpus();
+
 	ret = cpufreq_register_notifier(&notifier_policy_block,
 				CPUFREQ_POLICY_NOTIFIER);
 	if (ret)
-		return ret;
+		goto out;
 
 	for_each_online_cpu(cpu)
 		cpufreq_stats_create_table(cpu);
@@ -332,21 +335,28 @@ static int __init cpufreq_stats_init(voi
 				CPUFREQ_POLICY_NOTIFIER);
 		for_each_online_cpu(cpu)
 			cpufreq_stats_free_table(cpu);
-		return ret;
 	}
 
-	return 0;
+ out:
+	put_online_cpus();
+
+	return ret;
 }
 static void __exit cpufreq_stats_exit(void)
 {
 	unsigned int cpu;
 
+	get_online_cpus();
+
 	cpufreq_unregister_notifier(&notifier_policy_block,
 			CPUFREQ_POLICY_NOTIFIER);
 	cpufreq_unregister_notifier(&notifier_trans_block,
 			CPUFREQ_TRANSITION_NOTIFIER);
+
 	for_each_online_cpu(cpu)
 		cpufreq_stats_free_table(cpu);
+
+	put_online_cpus();
 }
 
 MODULE_AUTHOR("Zou Nan hai <nanhai.zou@intel.com>");

