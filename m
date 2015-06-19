From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 09/10] cpufreq: governor: Don't WARN on invalid states
Date: Fri, 19 Jun 2015 17:18:09 +0530
Message-ID: <0aad2a5bf19a29dda47cfc071ff453c8117a0713.1434713657.git.viresh.kumar@linaro.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:36373 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751575AbbFSLtC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 07:49:02 -0400
Received: by paceq1 with SMTP id eq1so59353023pac.3
        for <linux-pm@vger.kernel.org>; Fri, 19 Jun 2015 04:49:01 -0700 (PDT)
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434713657.git.viresh.kumar@linaro.org>
References: <cover.1434713657.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

With previous commit, governors have started to return errors on invalid
state-transition requests. We already have a WARN for an invalid
state-transition request in cpufreq_governor_dbs(). This does trigger
today, as the sequence of events isn't guaranteed by cpufreq core.

Lets stop warning on that for now, and make sure we don't enter an
invalid state.

Reviewed-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 8d4c86fa43ec..af63402a94a9 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
