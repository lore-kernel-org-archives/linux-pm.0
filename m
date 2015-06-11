From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 10/12] cpufreq: governor: Don't WARN on invalid states
Date: Thu, 11 Jun 2015 16:21:53 +0530
Message-ID: <70b94233535af5a1fa391f3199ef8915b40fb7b7.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36808 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680AbbFKKww (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 06:52:52 -0400
Received: by pabqy3 with SMTP id qy3so2227267pab.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2015 03:52:52 -0700 (PDT)
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1434019473.git.viresh.kumar@linaro.org>
References: <cover.1434019473.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, ke.wang@spreadtrum.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

The last commit returned errors on invalid state requests for a
governor. But we are already issuing a WARN for an invalid state in
cpufreq_governor_dbs().

Lets stop warning on that until the time cpufreq core is fixed to
serialize state changes of the governor.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index ee2e19a1218a..c26f535d3d91 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -542,7 +542,7 @@ int cpufreq_governor_dbs(struct cpufreq_policy *policy,
 	else
 		dbs_data = cdata->gdbs_data;
 
-	if (WARN_ON(!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT))) {
+	if (!dbs_data && (event != CPUFREQ_GOV_POLICY_INIT)) {
 		ret = -EINVAL;
 		goto unlock;
 	}
-- 
2.4.0

