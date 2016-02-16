From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 2/2] cpufreq: ondemand: Drop unused callback from struct od_ops
Date: Tue, 16 Feb 2016 21:01:40 +0100
Message-ID: <2785243.lPbWKikLZB@vostro.rjw.lan>
References: <76641630.CimCW8476L@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:55861 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752086AbcBPUAX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Feb 2016 15:00:23 -0500
In-Reply-To: <76641630.CimCW8476L@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ->freq_increase callback in struct od_ops is never invoked,
so drop it.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.h |    1 -
 drivers/cpufreq/cpufreq_ondemand.c |    1 -
 2 files changed, 2 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -417,7 +417,6 @@ define_get_cpu_dbs_routines(od_cpu_dbs_i
 static struct od_ops od_ops = {
 	.powersave_bias_init_cpu = ondemand_powersave_bias_init_cpu,
 	.powersave_bias_target = generic_powersave_bias_target,
-	.freq_increase = dbs_freq_increase,
 };
 
 static struct dbs_governor od_dbs_gov = {
Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -220,7 +220,6 @@ struct od_ops {
 	void (*powersave_bias_init_cpu)(int cpu);
 	unsigned int (*powersave_bias_target)(struct cpufreq_policy *policy,
 			unsigned int freq_next, unsigned int relation);
-	void (*freq_increase)(struct cpufreq_policy *policy, unsigned int freq);
 };
 
 extern struct mutex dbs_data_mutex;

