From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 01/17] cpufreq: remove dangling comment
Date: Fri,  2 Jan 2015 12:34:22 +0530
Message-ID: <cef9460fd71b96ccce8923d78fb77f7a67cfc406.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:46876 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711AbbABHE6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Jan 2015 02:04:58 -0500
Received: by mail-pd0-f174.google.com with SMTP id fp1so23134894pdb.5
        for <linux-pm@vger.kernel.org>; Thu, 01 Jan 2015 23:04:58 -0800 (PST)
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1420181916.git.viresh.kumar@linaro.org>
References: <cover.1420181916.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org, Viresh Kumar <viresh.kumar@linaro.org>

It doesn't make any sense at all and is a leftover of some earlier commit.
Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6d97dffeaaf7..891672b913c8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2000,10 +2000,6 @@ int cpufreq_driver_target(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 
-/*
- * when "event" is CPUFREQ_GOV_LIMITS
- */
-
 static int __cpufreq_governor(struct cpufreq_policy *policy,
 					unsigned int event)
 {
-- 
2.2.0

