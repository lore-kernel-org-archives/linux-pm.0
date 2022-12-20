Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7857BC4332F
	for <linux-pm@archiver.kernel.org>; Tue, 20 Dec 2022 10:13:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiLTKND (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 20 Dec 2022 05:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbiLTKNC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Dec 2022 05:13:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4475B2653;
        Tue, 20 Dec 2022 02:13:01 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B99772F4;
        Tue, 20 Dec 2022 02:13:41 -0800 (PST)
Received: from pierre123.nice.arm.com (pierre123.nice.arm.com [10.34.100.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A2F863F71A;
        Tue, 20 Dec 2022 02:12:59 -0800 (PST)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     james.clark@arm.com, Ionela.Voinescu@arm.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: CPPC: Add u64 casts to avoid overflowing
Date:   Tue, 20 Dec 2022 11:12:25 +0100
Message-Id: <20221220101225.3190672-1-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The fields of the _CPC object are unsigned 32-bits values.
To avoid overflows while using _CPC's values, add 'u64' casts.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cppc_cpufreq.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 432dfb4e8027..022e3555407c 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -487,7 +487,8 @@ static unsigned int get_perf_level_count(struct cpufreq_policy *policy)
 	cpu_data = policy->driver_data;
 	perf_caps = &cpu_data->perf_caps;
 	max_cap = arch_scale_cpu_capacity(cpu);
-	min_cap = div_u64(max_cap * perf_caps->lowest_perf, perf_caps->highest_perf);
+	min_cap = div_u64((u64)max_cap * perf_caps->lowest_perf,
+			  perf_caps->highest_perf);
 	if ((min_cap == 0) || (max_cap < min_cap))
 		return 0;
 	return 1 + max_cap / CPPC_EM_CAP_STEP - min_cap / CPPC_EM_CAP_STEP;
@@ -519,10 +520,10 @@ static int cppc_get_cpu_power(struct device *cpu_dev,
 	cpu_data = policy->driver_data;
 	perf_caps = &cpu_data->perf_caps;
 	max_cap = arch_scale_cpu_capacity(cpu_dev->id);
-	min_cap = div_u64(max_cap * perf_caps->lowest_perf,
-			perf_caps->highest_perf);
-
-	perf_step = CPPC_EM_CAP_STEP * perf_caps->highest_perf / max_cap;
+	min_cap = div_u64((u64)max_cap * perf_caps->lowest_perf,
+			  perf_caps->highest_perf);
+	perf_step = div_u64((u64)CPPC_EM_CAP_STEP * perf_caps->highest_perf,
+			    max_cap);
 	min_step = min_cap / CPPC_EM_CAP_STEP;
 	max_step = max_cap / CPPC_EM_CAP_STEP;
 
-- 
2.25.1

