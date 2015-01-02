From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 15/17] cpufreq: don't check if cpu > nr_cpu_ids
Date: Fri,  2 Jan 2015 12:34:36 +0530
Message-ID: <9c5002262cb37915c7aa117814831a9017bda2db.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:51362 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbbABHFv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:05:51 -0500
Received: by mail-pa0-f53.google.com with SMTP id kq14so23338426pab.26
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:05:51 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

I don't know for what kind of callers do we have this check for. The problem is
that such checks introduce an unnecessary delay for the good users.

So, I am dropping it for now, let me know if this is a bad change.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 09426671eb79..14d637a28dd8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -202,7 +202,7 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	struct cpufreq_policy *policy = NULL;
 	unsigned long flags;
 
-	if (cpufreq_disabled() || (cpu >= nr_cpu_ids))
+	if (cpufreq_disabled())
 		return NULL;
 
 	if (!down_read_trylock(&cpufreq_rwsem))
-- 
2.2.0

