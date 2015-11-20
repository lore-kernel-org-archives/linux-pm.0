From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH 1/2] cpufreq, intel_pstate, Fix limits->max_policy_pct rounding error
Date: Fri, 20 Nov 2015 18:47:56 -0500
Message-ID: <1448063277-12446-2-git-send-email-prarit@redhat.com>
References: <1448063277-12446-1-git-send-email-prarit@redhat.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40405 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422692AbbKTXsF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 20 Nov 2015 18:48:05 -0500
In-Reply-To: <1448063277-12446-1-git-send-email-prarit@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Len Brown <len.brown@intel.com>, Alexandra Yates <alexandra.yates@intel.com>, Kristen Carlson Accardi <kristen@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

I have a Intel (6,63) processor with a "marketing" frequency (from
/proc/cpuinfo) of 2100MHz, and a max turbo frequency of 2600MHz.  I
can execute

cpupower frequency-set -g powersave --min 1200MHz --max 2100MHz

and the max_freq_pct is set to 80.  When adding load to the system I noticed
that the cpu frequency only reached 2000MHZ and not 2100MHz as expected.

This is because limits->max_policy_pct is calculated as 2100 * 100 /2600 = 80.7
and is rounded down to 80 when it should be rounded up to 81.  This patch
adds a DIV_ROUND_UP() which will return the correct value.

Cc: Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Alexandra Yates <alexandra.yates@intel.com>
Cc: Kristen Carlson Accardi <kristen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Prarit Bhargava <prarit@redhat.com>
---
 drivers/cpufreq/intel_pstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 001a532..eb75053 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1108,7 +1108,8 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 	limits = &powersave_limits;
 	limits->min_policy_pct = (policy->min * 100) / policy->cpuinfo.max_freq;
 	limits->min_policy_pct = clamp_t(int, limits->min_policy_pct, 0 , 100);
-	limits->max_policy_pct = (policy->max * 100) / policy->cpuinfo.max_freq;
+	limits->max_policy_pct = DIV_ROUND_UP(policy->max * 100,
+					      policy->cpuinfo.max_freq);
 	limits->max_policy_pct = clamp_t(int, limits->max_policy_pct, 0 , 100);
 
 	/* Normalize user input to [min_policy_pct, max_policy_pct] */
-- 
1.8.3.1

