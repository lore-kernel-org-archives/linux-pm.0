From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH RESEND] cpufreq: Use list_is_last() to check last entry of the policy list
Date: Wed, 27 Jan 2016 12:02:26 +0530
Message-ID: <1453876346-21869-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1453715167-26165-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e33.co.us.ibm.com ([32.97.110.151]:42607 "EHLO
	e33.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753813AbcA0Gc7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2016 01:32:59 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Tue, 26 Jan 2016 23:32:58 -0700
In-Reply-To: <1453715167-26165-1-git-send-email-ego@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Juri Lelli <Lelli" <juri.lelli@arm.com>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently next_policy() explicitly checks if a policy is the last
policy in the cpufreq_policy_list. Use the standard list_is_last
primitive instead.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
The earlier version one was based on an Juri's experimental branch. 
I have based this one on linux-pm.git linux-next branch.

 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c35e7da..e979ec7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -48,11 +48,11 @@ static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
 					  bool active)
 {
 	do {
-		policy = list_next_entry(policy, policy_list);
-
 		/* No more policies in the list */
-		if (&policy->policy_list == &cpufreq_policy_list)
+		if (list_is_last(&policy->policy_list, &cpufreq_policy_list))
 			return NULL;
+
+		policy = list_next_entry(policy, policy_list);
 	} while (!suitable_policy(policy, active));
 
 	return policy;
-- 
1.9.3

