From: Michael Turquette <mturquette@baylibre.com>
Subject: [PATCH 8/8] sched: prefer cpufreq_scale_freq_capacity
Date: Sun, 13 Mar 2016 22:22:12 -0700
Message-ID: <1457932932-28444-9-git-send-email-mturquette+renesas@baylibre.com>
References: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:35544 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933518AbcCNF0b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 01:26:31 -0400
Received: by mail-pa0-f51.google.com with SMTP id td3so121785048pab.2
        for <linux-pm@vger.kernel.org>; Sun, 13 Mar 2016 22:26:31 -0700 (PDT)
In-Reply-To: <1457932932-28444-1-git-send-email-mturquette+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: peterz@infradead.org, rjw@rjwysocki.net
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Juri.Lelli@arm.com, steve.muckle@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, vincent.guittot@linaro.org, Michael Turquette <mturquette+renesas@baylibre.com>

arch_scale_freq_capacity is weird. It specifies an arch hook for an
implementation that could easily vary within an architecture or even a
chip family.

This patch helps to mitigate this weirdness by defaulting to the
cpufreq-provided implementation, which should work for all cases where
CONFIG_CPU_FREQ is set.

If CONFIG_CPU_FREQ is not set, then try to use an implementation
provided by the architecture. Failing that, fall back to
SCHED_CAPACITY_SCALE.

It may be desirable for cpufreq drivers to specify their own
implementation of arch_scale_freq_capacity in the future. The same is
true for platform code within an architecture. In both cases an
efficient implementation selector will need to be created and this patch
adds a comment to that effect.

Signed-off-by: Michael Turquette <mturquette+renesas@baylibre.com>
---
 kernel/sched/sched.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 469d11d..37502ea 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1368,7 +1368,21 @@ static inline int hrtick_enabled(struct rq *rq)
 #ifdef CONFIG_SMP
 extern void sched_avg_update(struct rq *rq);
 
-#ifndef arch_scale_freq_capacity
+/*
+ * arch_scale_freq_capacity can be implemented by cpufreq, platform code or
+ * arch code. We select the cpufreq-provided implementation first. If it
+ * doesn't exist then we default to any other implementation provided from
+ * platform/arch code. If those do not exist then we use the default
+ * SCHED_CAPACITY_SCALE value below.
+ *
+ * Note that if cpufreq drivers or platform/arch code have competing
+ * implementations it is up to those subsystems to select one at runtime with
+ * an efficient solution, as we cannot tolerate the overhead of indirect
+ * functions (e.g. function pointers) in the scheduler fast path
+ */
+#ifdef CONFIG_CPU_FREQ
+#define arch_scale_freq_capacity cpufreq_scale_freq_capacity
+#elif !defined(arch_scale_freq_capacity)
 static __always_inline
 unsigned long arch_scale_freq_capacity(struct sched_domain *sd, int cpu)
 {
-- 
2.1.4

