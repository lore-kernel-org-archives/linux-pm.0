From: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFC] Revert "cpufreq: dt: Identify cpu-sharing for platforms without operating-points-v2"
Date: Thu, 16 Jun 2016 14:35:24 +0900
Message-ID: <20160616053524.19921-1-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

This is not an actual request for revert, but rather for comments about
the observed behavior since I am not really familiar with cpufreq.

I am observing a serious performance regression on Jetson TK1 since 4.7-rc1:
namely, moving windows under X would become unsufferably slow, and graphical
performance under X in general is seriously degraded. After bisecting, I
found the regression to be visible since commit 1530b9963eeb ("cpufreq: dt: 
Identify cpu-sharing for platforms without operating-points-v2")

If I revert this commit, I noticed that the CPU frequency immediately jumps to
a higher frequency once I start moving windows (resulting in a smooth and
responsive action), whereas enabling this commit causes the CPU frequency to
remain low (typically 204 Mhz) in that case, resulting in CPU-bound slowness.

What happens is that with 1530b9963eeb applied, dev_pm_opp_get_sharing_cpus()
returns zero causing the fallback variable to remain false, whereas without it
opp_v1 is set to true.

It is not clear to me whether this is a cpufreq issue or a Tegra issue, so I am
posting this in the hope to get clarifications from either side.

Thanks!

---
 drivers/cpufreq/cpufreq-dt.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 3957de801ae8..eef245cd4b7f 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -146,7 +146,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	struct clk *cpu_clk;
 	struct dev_pm_opp *suspend_opp;
 	unsigned int transition_latency;
-	bool fallback = false;
+	bool opp_v1 = false;
 	const char *name;
 	int ret;
 
@@ -166,16 +166,14 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	/* Get OPP-sharing information from "operating-points-v2" bindings */
 	ret = dev_pm_opp_of_get_sharing_cpus(cpu_dev, policy->cpus);
 	if (ret) {
-		if (ret != -ENOENT)
-			goto out_put_clk;
-
 		/*
 		 * operating-points-v2 not supported, fallback to old method of
-		 * finding shared-OPPs for backward compatibility if the
-		 * platform hasn't set sharing CPUs.
+		 * finding shared-OPPs for backward compatibility.
 		 */
-		if (dev_pm_opp_get_sharing_cpus(cpu_dev, policy->cpus))
-			fallback = true;
+		if (ret == -ENOENT)
+			opp_v1 = true;
+		else
+			goto out_put_clk;
 	}
 
 	/*
@@ -215,7 +213,7 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 		goto out_free_opp;
 	}
 
-	if (fallback) {
+	if (opp_v1) {
 		cpumask_setall(policy->cpus);
 
 		/*
-- 
2.8.3
