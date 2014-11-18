From: Ethan Zhao <ethan.zhao@oracle.com>
Subject: [PATCH 2/3] intel_pstate: allow driver to be built as a module
Date: Tue, 18 Nov 2014 17:37:01 +0900
Message-ID: <1416299826-15813-3-git-send-email-ethan.zhao@oracle.com>
References: <1416299826-15813-1-git-send-email-ethan.zhao@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416299826-15813-1-git-send-email-ethan.zhao@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dirk.j.brandewie@intel.com, viresh.kumar@linaro.org, rjw@rjwysocki.net, corbet@lwn.net
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, ethan.kernel@gmail.com, joe.jin@oracle.com, brian.maly@oracle.com, Ethan Zhao <ethan.zhao@oracle.com>
List-Id: linux-pm@vger.kernel.org

From: Brian Maly <brian.maly@oracle.com>

To provide the flexibility of module, allow this driver to
be configured and built as a module.

Signed-off-by: Brian Maly <brian.maly@oracle.com>
Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
---
 drivers/cpufreq/Kconfig.x86    | 2 +-
 drivers/cpufreq/intel_pstate.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 89ae88f..94c9e6b 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -3,7 +3,7 @@
 #
 
 config X86_INTEL_PSTATE
-       bool "Intel P state control"
+       tristate "Intel P state control"
        depends on X86
        help
           This driver provides a P state for Intel core processors.
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 5498eb0..7c5faea 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -590,7 +590,9 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 	if (pstate == cpu->pstate.current_pstate)
 		return;
 
+#ifndef MODULE
 	trace_cpu_frequency(pstate * cpu->pstate.scaling, cpu->cpu);
+#endif
 
 	cpu->pstate.current_pstate = pstate;
 
@@ -705,12 +707,14 @@ static void intel_pstate_timer_func(unsigned long __data)
 
 	intel_pstate_adjust_busy_pstate(cpu);
 
+#ifndef MODULE
 	trace_pstate_sample(fp_toint(sample->core_pct_busy),
 			fp_toint(intel_pstate_get_scaled_busy(cpu)),
 			cpu->pstate.current_pstate,
 			sample->mperf,
 			sample->aperf,
 			sample->freq);
+#endif
 
 	intel_pstate_set_sample_time(cpu);
 }
@@ -1054,6 +1058,7 @@ out:
 }
 device_initcall(intel_pstate_init);
 
+#ifndef MODULE
 static int __init intel_pstate_setup(char *str)
 {
 	if (!str)
@@ -1064,6 +1069,7 @@ static int __init intel_pstate_setup(char *str)
 	return 0;
 }
 early_param("intel_pstate", intel_pstate_setup);
+#endif
 
 MODULE_AUTHOR("Dirk Brandewie <dirk.j.brandewie@intel.com>");
 MODULE_DESCRIPTION("'intel_pstate' - P state driver Intel Core processors");
-- 
1.8.3.1
