From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0116/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:41:52 +0800
Message-ID: <20160802104152.21485-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org, jarkko.sakkinen@linux.intel.com, jgunthorpe@obsidianresearch.com, hpa@zytor.com, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, jslaby@suse.cz, peter@korsgaard.com, lee.jones@linaro.org
List-Id: linux-pm@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 9009295..3ea0bee 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -815,7 +815,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 	return sprintf(buf, "%u\n", policy->cpuinfo.max_freq);
 }
 
-cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
+cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, S_IRUSR);
 cpufreq_freq_attr_ro(cpuinfo_min_freq);
 cpufreq_freq_attr_ro(cpuinfo_max_freq);
 cpufreq_freq_attr_ro(cpuinfo_transition_latency);
-- 
2.9.2
