From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: dt: Support platforms with separate clock lines for each CPU
Date: Wed, 10 Sep 2014 09:59:07 +0530
Message-ID: <fcb88cd21f31a467d2d49911c2505082837f72ea.1410323179.git.viresh.kumar@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, shawn.guo@linaro.org, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, t.figa@samsung.com, santosh.shilimkar@ti.com, thomas.petazzoni@free-electrons.com, pramod.gurav@smartplayin.com, rob.herring@linaro.org, mike.turquette@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

There has been lots of discussion over mailing lists about how to get CPU's
clock sharing information for platforms as CPUFreq core depends on that. It
doesn't look that there will be any immediate solution to that as there are
multiple views over how to get that from DT.

But there are platforms (already upstreamed) which depend on this requirement
and are waiting for a solution to sail through.

The common thing about them (Krait and Mvebu) is that all CPUs have independent
clock lines and that makes things easier for us.

So, this patch creates another Kconfig option to indicate if all CPUs share same
clock line or all have independent. The complex cases of multiple clusters
having separate clock lines, but having same for all CPUs within a cluster isn't
addressed yet.

This is a *short-term* solution for getting these platforms up an running and a
DT based solution should be upstreamed soon.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Yesterday again I was pinged by Thomas about the status of this work and the
thread isn't going anywhere. He is blocked with just this to get his platform
running on mainline.

Will it be possible to get this through as a temporary solution?

 drivers/cpufreq/Kconfig      |  9 +++++++++
 drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 3489f8f..a755227 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -196,6 +196,15 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
+config CPUFREQ_DT_INDEPENDENT_CLOCKS
+	bool "CPUs change clocks independently"
+	depends on CPUFREQ_DT
+	help
+	  Selecting this will make cpufreq-dt driver believe that all CPUs have
+	  independent clock lines and so all will have separate 'struct
+	  cpufreq_policy' instances for them. This must be replaced by proper DT
+	  bindings later on.
+
 menu "x86 CPU frequency scaling drivers"
 depends on X86
 source "drivers/cpufreq/Kconfig.x86"
diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index e002650..dbb6f22 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -266,9 +266,22 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	policy->driver_data = priv;
 
 	policy->clk = cpu_clk;
-	ret = cpufreq_generic_init(policy, freq_table, transition_latency);
-	if (ret)
+	ret = cpufreq_table_validate_and_show(policy, freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "%s: invalid frequency table: %d\n", __func__,
+			ret);
 		goto out_cooling_unregister;
+	}
+
+	policy->cpuinfo.transition_latency = transition_latency;
+
+#ifndef CONFIG_CPUFREQ_DT_INDEPENDENT_CLOCKS
+	/*
+	 * The driver only supports the SMP configuartion where all processors
+	 * share the clock and voltage and clock.
+	 */
+	cpumask_setall(policy->cpus);
+#endif
 
 	return 0;
 
-- 
2.0.3.693.g996b0fd
