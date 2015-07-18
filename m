From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 4/5] cpufreq: governor: Don't WARN on invalid states
Date: Sat, 18 Jul 2015 11:31:02 +0530
Message-ID: <c7f223f96fe2da64ca54669178cf76e444d7be2e.1437199001.git.viresh.kumar@linaro.org>
References: <2874468.iRvuV1Y9DI@vostro.rjw.lan>
 <cover.1437199001.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1437199001.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1437199001.git.viresh.kumar@linaro.org>
References: <cover.1437199001.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

With previous commit, governors have started to return errors on invalid
state-transition requests. We already have a WARN for an invalid
state-transition request in cpufreq_governor_dbs(). This does trigger
today, as the sequence of events isn't guaranteed by cpufreq core.

Lets stop warning on that for now, and make sure we don't enter an
invalid state.

Reviewed-and-tested-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index f225dc975415..939197ffa4ac 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -543,7 +543,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 	else
 		dbs_data = cdata->gdbs_data;
 
-	if (WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT))) {
+	if (!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT)) {
 		ret = -EINVAL;
 		goto unlock;
 	}
-- 
2.4.0
