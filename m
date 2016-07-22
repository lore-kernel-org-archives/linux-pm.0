From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH] cpufreq: export cpufreq_driver_resolve_freq()
Date: Thu, 21 Jul 2016 19:24:38 -0700
Message-ID: <1469154278-7373-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Steve Muckle <smuckle@linaro.org>
List-Id: linux-pm@vger.kernel.org

Export cpufreq_driver_resolve_freq() since governors may be compiled as
modules.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b696baeb249d..fa0a92d6121e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -514,6 +514,7 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 					       CPUFREQ_RELATION_L);
 	return policy->freq_table[policy->cached_resolved_idx].frequency;
 }
+EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
-- 
2.7.3
