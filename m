From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 03/20] cpufreq: Throw warning when we try to get policy for an invalid CPU
Date: Thu, 19 Feb 2015 17:02:05 +0530
Message-ID: <94d5e5e04cb8278ae9798a6a2837063152dd60aa.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:46933 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbbBSLdd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Feb 2015 06:33:33 -0500
Received: by pdjy10 with SMTP id y10so8220531pdj.13
        for <linux-pm@vger.kernel.org>; Thu, 19 Feb 2015 03:33:33 -0800 (PST)
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1424345053.git.viresh.kumar@linaro.org>
References: <cover.1424345053.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

Simply returning here with an error is not enough. It shouldn't be allowed at
all to try calling cpufreq_cpu_get() for an invalid CPU.

Add a WARN here to make it clear that it wouldn't be acceptable at all.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4884caf92bff..9da8ed5bdd21 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -229,7 +229,7 @@ struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu)
 	struct cpufreq_policy *policy = NULL;
 	unsigned long flags;
 
-	if (cpu >= nr_cpu_ids)
+	if (WARN_ON(cpu >= nr_cpu_ids))
 		return NULL;
 
 	if (!down_read_trylock(&cpufreq_rwsem))
-- 
2.3.0.rc0.44.ga94655d

