Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F356C433EF
	for <linux-pm@archiver.kernel.org>; Wed,  6 Apr 2022 22:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236973AbiDFWK2 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 6 Apr 2022 18:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236957AbiDFWK1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 6 Apr 2022 18:10:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AE3F1D08F8;
        Wed,  6 Apr 2022 15:08:30 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBEA612FC;
        Wed,  6 Apr 2022 15:08:29 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.9.217])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id F14B83F5A1;
        Wed,  6 Apr 2022 15:08:27 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        amit.kachhap@gmail.com, linux-pm@vger.kernel.org
Subject: [RFC PATCH v3 2/5] cpuidle: Add Cpufreq Active Stats calls tracking idle entry/exit
Date:   Wed,  6 Apr 2022 23:08:06 +0100
Message-Id: <20220406220809.22555-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406220809.22555-1-lukasz.luba@arm.com>
References: <20220406220809.22555-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Cpufreq Active Stats tracks and accounts the activity of the CPU
for each performance level. It accounts the real residency, when the CPU
was not idle, at a given performance level. This patch adds needed calls
which provide the CPU idle entry/exit events to the Cpufreq Active Stats.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpuidle/cpuidle.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ef2ea1b12cd8..f19711b95afb 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -16,6 +16,7 @@
 #include <linux/notifier.h>
 #include <linux/pm_qos.h>
 #include <linux/cpu.h>
+#include <linux/cpufreq_stats.h>
 #include <linux/cpuidle.h>
 #include <linux/ktime.h>
 #include <linux/hrtimer.h>
@@ -231,6 +232,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	trace_cpu_idle(index, dev->cpu);
 	time_start = ns_to_ktime(local_clock());
 
+	cpufreq_active_stats_cpu_idle_enter(time_start);
+
 	stop_critical_timings();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
 		rcu_idle_enter();
@@ -243,6 +246,8 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	time_end = ns_to_ktime(local_clock());
 	trace_cpu_idle(PWR_EVENT_EXIT, dev->cpu);
 
+	cpufreq_active_stats_cpu_idle_exit(time_end);
+
 	/* The cpu is no longer idle or about to enter idle. */
 	sched_idle_set_state(NULL);
 
-- 
2.17.1

