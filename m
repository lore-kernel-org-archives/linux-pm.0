From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 02/16] cpufreq: stats: return -EEXIST when stats are already allocated
Date: Tue,  6 Jan 2015 21:09:01 +0530
Message-ID: <4612a6b926f3e1064093e4f79eaabd48fe4dcdf1.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:58637 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754083AbbAFPjf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Jan 2015 10:39:35 -0500
Received: by mail-pd0-f178.google.com with SMTP id r10so30592669pdi.37
        for <linux-pm@vger.kernel.org>; Tue, 06 Jan 2015 07:39:34 -0800 (PST)
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420558386.git.viresh.kumar@linaro.org>
References: <cover.1420558386.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

__cpufreq_stats_create_table() is called from:

- cpufreq notifier on creation of a new policy. Stats will always be NULL here.
- cpufreq_stats_init() for all CPUs as cpufreq-stats might have been initialized
  after cpufreq driver. For any policy, 'stats' will be NULL for the first cpu
  only and will be valid for all other CPUs managed by the same policy.

While we return for other CPUs, we don't return the right error value. Its not
that we would fail with -EBUSY. But generally, this is what these return values
mean:
- EBUSY: we are busy right now, try again. And the retry attempt might be
  immediate.
- EEXIST: We already have what you are trying to create and there is no need to
  create it again, and so no more tries are required.

Reviewed-by: Prarit Bhargava <prarit@redhat.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 80801f880dd8..d2299ca2fc2c 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -192,8 +192,10 @@ static int __cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	if (unlikely(!table))
 		return 0;
 
+	/* stats already initialized */
 	if (per_cpu(cpufreq_stats_table, cpu))
-		return -EBUSY;
+		return -EEXIST;
+
 	stat = kzalloc(sizeof(*stat), GFP_KERNEL);
 	if ((stat) == NULL)
 		return -ENOMEM;
-- 
2.2.0

