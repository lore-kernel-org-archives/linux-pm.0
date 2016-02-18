From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 5/12] cpufreq: ondemand: Drop one more callback from struct od_ops
Date: Thu, 18 Feb 2016 02:24:32 +0100
Message-ID: <4653996.VftfsaIoaX@vostro.rjw.lan>
References: <2938006.67J0esUvOA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2938006.67J0esUvOA@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ->powersave_bias_init_cpu callback in struct od_ops is only used
in one place and that invocation may be replaced with a direct call
to the function pointed to by that callback, so change the code
accordingly and drop the callback.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq_governor.h |    1 -
 drivers/cpufreq/cpufreq_ondemand.c |    3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

Index: linux-pm/drivers/cpufreq/cpufreq_governor.h
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_governor.h
+++ linux-pm/drivers/cpufreq/cpufreq_governor.h
@@ -205,7 +205,6 @@ static inline struct dbs_governor *dbs_g
 
 /* Governor specific operations */
 struct od_ops {
-	void (*powersave_bias_init_cpu)(int cpu);
 	unsigned int (*powersave_bias_target)(struct cpufreq_policy *policy,
 			unsigned int freq_next, unsigned int relation);
 };
Index: linux-pm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-pm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-pm/drivers/cpufreq/cpufreq_ondemand.c
@@ -416,13 +416,12 @@ static void od_start(struct cpufreq_poli
 	struct od_cpu_dbs_info_s *dbs_info = &per_cpu(od_cpu_dbs_info, cpu);
 
 	dbs_info->sample_type = OD_NORMAL_SAMPLE;
-	od_ops.powersave_bias_init_cpu(cpu);
+	ondemand_powersave_bias_init_cpu(cpu);
 }
 
 define_get_cpu_dbs_routines(od_cpu_dbs_info);
 
 static struct od_ops od_ops = {
-	.powersave_bias_init_cpu = ondemand_powersave_bias_init_cpu,
 	.powersave_bias_target = generic_powersave_bias_target,
 };
 
