Return-Path: <SRS0=pp1W=TI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B0CC04A6B
	for <linux-pm@archiver.kernel.org>; Wed,  8 May 2019 17:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DAA21734
	for <linux-pm@archiver.kernel.org>; Wed,  8 May 2019 17:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbfEHRnR (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 8 May 2019 13:43:17 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:41828 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725910AbfEHRnR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 May 2019 13:43:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1476CA78;
        Wed,  8 May 2019 10:43:17 -0700 (PDT)
Received: from e107049-lin.arm.com (e107049-lin.cambridge.arm.com [10.1.195.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EBFD3F575;
        Wed,  8 May 2019 10:43:15 -0700 (PDT)
From:   douglas.raillard@arm.com
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
        quentin.perret@arm.com, douglas.raillard@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com
Subject: [RFC PATCH 5/7] sched/cpufreq: sugov_cpu_is_busy for shared policy
Date:   Wed,  8 May 2019 18:42:59 +0100
Message-Id: <20190508174301.4828-6-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190508174301.4828-1-douglas.raillard@arm.com>
References: <20190508174301.4828-1-douglas.raillard@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190508174259.KZnAeXZBA6BW-P-JqzzuWcIi1-IlKDrTAlOlSPhYynQ@z>

From: Douglas RAILLARD <douglas.raillard@arm.com>

Allow using sugov_cpu_is_busy() from sugov_update_shared(). This means
that the heuristic needs to return stable results across multiple calls
for a given CPU, even if there has been no utilization change since last
call.

sugov_cpu_is_busy() currently both checks business status and updates
the counters, so let's decouple the two actions.

Signed-off-by: Douglas RAILLARD <douglas.raillard@arm.com>
---
 kernel/sched/cpufreq_schedutil.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index a52c66559321..a12b7e5bc028 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -178,12 +178,17 @@ static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
 {
 	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
 	bool ret = idle_calls == sg_cpu->saved_idle_calls;
+	return ret;
+}
 
+static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu)
+{
+	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
 	sg_cpu->saved_idle_calls = idle_calls;
-	return ret;
 }
 #else
 static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
+static void sugov_cpu_is_busy_update(struct sugov_cpu *sg_cpu) {}
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /**
@@ -503,6 +508,7 @@ static void sugov_update_single(struct update_util_data *hook, u64 time,
 		return;
 
 	busy = sugov_cpu_is_busy(sg_cpu);
+	sugov_cpu_is_busy_update(sg_cpu);
 
 	util = sugov_get_util(sg_cpu);
 	max = sg_cpu->max;
-- 
2.21.0

