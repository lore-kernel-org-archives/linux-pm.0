From: Sonny Rao <sonnyrao@chromium.org>
Subject: [PATCH] [RFC] cpufreq: can't raise max frequency with cpu_thermal
Date: Tue, 18 Dec 2012 00:29:44 -0800
Message-ID: <1355819384-25983-1-git-send-email-sonnyrao@chromium.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f202.google.com ([209.85.212.202]:55246 "EHLO
	mail-wi0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754502Ab2LRI3s (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Dec 2012 03:29:48 -0500
Received: by mail-wi0-f202.google.com with SMTP id hn17so19731wib.5
        for <linux-pm@vger.kernel.org>; Tue, 18 Dec 2012 00:29:47 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.kachhap@linaro.org>, Doug Anderson <dianders@chromium.org>, Sameer Nanda <snanda@chromium.org>, Sonny Rao <sonnyrao@chromium.org>

The cpu_thermal generic thermal management code has a bug where once
max cpu frequency has been lowered in sysfs (scaling_max_freq) it is
not possible to raise the max back up later.  The bug is that the
notifer gets called by __cpufreq_set_policy() before the user policy
max is raised, and is incorrectly trying to enforce the max frequency
policy even when we are trying to change the policy.  It is also not
clear why this driver is looking at the user policy since it is
primarily supposed to enforce thermal policy, not user set policy.

Signed-off-by: Sonny Rao <sonnyrao@chromium.org>
---
 drivers/thermal/cpu_cooling.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 836828e..63bc708 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -219,10 +219,6 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 	if (cpumask_test_cpu(policy->cpu, &notify_device->allowed_cpus))
 		max_freq = notify_device->cpufreq_val;
 
-	/* Never exceed user_policy.max*/
-	if (max_freq > policy->user_policy.max)
-		max_freq = policy->user_policy.max;
-
 	if (policy->max != max_freq)
 		cpufreq_verify_within_limits(policy, 0, max_freq);
 
-- 
1.7.7.3

