From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] cpufreq: simplify for_each_suitable_policy() macro
Date: Sun, 21 Feb 2016 12:53:12 -0600
Message-ID: <1456080792-22770-1-git-send-email-ebiggers3@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33094 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbcBUSxa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2016 13:53:30 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers3@gmail.com>

Signed-off-by: Eric Biggers <ebiggers3@gmail.com>
---
 drivers/cpufreq/cpufreq.c | 44 +++-----------------------------------------
 1 file changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e979ec7..3aa7b2b 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -38,48 +38,10 @@ static inline bool policy_is_inactive(struct cpufreq_policy *policy)
 	return cpumask_empty(policy->cpus);
 }
 
-static bool suitable_policy(struct cpufreq_policy *policy, bool active)
-{
-	return active == !policy_is_inactive(policy);
-}
-
-/* Finds Next Acive/Inactive policy */
-static struct cpufreq_policy *next_policy(struct cpufreq_policy *policy,
-					  bool active)
-{
-	do {
-		/* No more policies in the list */
-		if (list_is_last(&policy->policy_list, &cpufreq_policy_list))
-			return NULL;
-
-		policy = list_next_entry(policy, policy_list);
-	} while (!suitable_policy(policy, active));
-
-	return policy;
-}
-
-static struct cpufreq_policy *first_policy(bool active)
-{
-	struct cpufreq_policy *policy;
-
-	/* No policies in the list */
-	if (list_empty(&cpufreq_policy_list))
-		return NULL;
-
-	policy = list_first_entry(&cpufreq_policy_list, typeof(*policy),
-				  policy_list);
-
-	if (!suitable_policy(policy, active))
-		policy = next_policy(policy, active);
-
-	return policy;
-}
-
 /* Macros to iterate over CPU policies */
-#define for_each_suitable_policy(__policy, __active)	\
-	for (__policy = first_policy(__active);		\
-	     __policy;					\
-	     __policy = next_policy(__policy, __active))
+#define for_each_suitable_policy(__policy, __active)			 \
+	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
+		if ((__active) == !policy_is_inactive(__policy))
 
 #define for_each_active_policy(__policy)		\
 	for_each_suitable_policy(__policy, true)
-- 
2.7.1

