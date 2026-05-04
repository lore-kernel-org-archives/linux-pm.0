Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4D11D63F0
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860026; cv=none; b=KzRYaieT6wZ+0mFUsMsPvCI8m7eCEENz5D0oGmVl4Bf2DLub396plOw7BhNjyk6tp3BsuG74uvmEDCSkpdLcbVbUs1rm5hwUTXwA3uI0DITu4pXccCPihtxA8ZqI3hVKHwLo5DxpHVWlhsUbyIMEZmXleOSXyd1bPFa/1b7RWig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860026; c=relaxed/simple;
	bh=IuHzjEG/NnEmcD2qU2tuLvD8m2QsjcoR5Ym0/Y230fc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iw7vQoQ4psUNTH81iJJzwC1dy1bdvC50C0QPR0Agxu71sG//KzSbPVOVapd+1VeOM4ic3woY6A5ceN7FDPDld0RRZAOEA6Iq5Xv80Cpiwc3ijYkW8Pvvimz8vWoXIPBFgrqAWPHldPMSeCBQJwHyAYU++Ezlt+tpd7Z4H/gBLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=CX7rq4KT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="CX7rq4KT"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso17474535e9.3
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860023; x=1778464823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnFztH0MgizY/YqzLaNQKaZjQRKlZC14r0DZS22NKYE=;
        b=CX7rq4KToXleeu61606KlTyNG488VDuyTyGE6Veq9xWkolXG86RgAp7YTCAhyxj3HQ
         EMhYYWQ2gms8AmOH1q4OyXjG+6UYWYKjPuHmJiuqf81h4+YCWm2AKs1NxlfIm6BhI/6R
         1/G/T1Cn3HPqjYxCKWgVQLwXjAlGwkNSgQMIDwBt4o1RL6Da7ZO6ZL0d+BTbqU/aR5Az
         E0kB8/U/chWFEj93ZcXIcXrj7OeX0zU+JAP9W7Uxu+rXvZuQyKtkce6uRh7/r11paMZ6
         972minOH2f9RNs6v3nmIdDvT+ePG6BpVtibxwPTpczOLLO7qCY3Gr2AURhUrCqjoxoo/
         QwDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860023; x=1778464823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pnFztH0MgizY/YqzLaNQKaZjQRKlZC14r0DZS22NKYE=;
        b=Lk6n5SiH9OBhGk0ZA4T/dJLHt1s62/9+tGu2VgXxBhP13MC4yUGRVGL0qtm7uu2YtK
         35C/gumRGGOIjQiotyqIrdiYG/R94Wf9OpD9bC483QcQVjbZSPDpuSNVu1H3u/G73JTP
         Pe+QhqjViqTs7gTNAov5gVAOZgMJBncqv9M0SrXUfC8k2RkLy4u+pDp6fhbEuU71N1Cq
         1BDYsFduME8CJtoEAOUqScjINUHCWtBoeb87fglVfgN+xzwhosdF3zxKhteIOO2GSZF1
         Gm6MTOJhiI9Yeo3B4vT8ZRXMFPF8tAbXBngwv3JfItZL0BoXLAaNAr0DZFyphgb8HFAP
         wAbQ==
X-Forwarded-Encrypted: i=1; AFNElJ+kna2XBIcxEsidpeVGzWo5Wp8blTLO55qy2OuntQPCdC1gWL29DO9TPsdZDuajGBd/cNfoDOTZ4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyctmPAkxln17WDKzycxvD6mUHXFbIp8SFd6PL5bFunSpjYtjRm
	lfyvGBaLTTHRm3TQagJUfzWsg99Wg8G8ZFq/VUCb0mkYIJxmqpqrTCWEQNySmpNmEe4=
X-Gm-Gg: AeBDietAvTs6Rd9D1CXTbqaHGuvbIjppOurZ4cRbe1MJ0A/nJiKZ/ENxzX4dYKSPjCR
	l2MjcNX4/i+1naRPZfRQEjA1ALSiJ2euACf0BSpugC3C4oJ2EytHmp9otCZ4IOvLeB6I7qyMPC7
	AIJMyAEO8laZhLe3X9+DoTI0vAO0VdhEktXN4qzgUIXexpUecsrvr5MpWvw55sDTqnODHLQCxPx
	LDtYqJ1J1X/H3OON+WIpjve+vmTwtgOItfwxTgbQ4Ch7CTpb5LzOvEAiDETkeEYVnUOxAPZ+e5S
	kejzJ96ZtaZNIOEifOliON1Ucu6X8Lr4WIf93U/5tnMPgl8boS4iZWLUKcbgS2EI1c1hIKFDmow
	bAC+ApN8aLZe0ITuMR+zITCASG3GYa/CddHJDbxC2xMmQ6jslCoK/RHf5CdlUMSIhW+VxSw2kS4
	sTxKPWAJbxNT/7ct3y57UULEULukZeHzQ=
X-Received: by 2002:a05:600c:16c9:b0:48d:35e:84a0 with SMTP id 5b1f17b1804b1-48d035e84damr45050035e9.28.1777860023099;
        Sun, 03 May 2026 19:00:23 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:22 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Stultz <jstultz@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	"Chen, Yu C" <yu.c.chen@intel.com>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 05/13] sched: cpufreq: Remove magic 1.25 headroom from sugov_apply_dvfs_headroom()
Date: Mon,  4 May 2026 02:59:55 +0100
Message-Id: <20260504020003.71306-6-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260504020003.71306-1-qyousef@layalina.io>
References: <20260504020003.71306-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 1.25 headroom in sugov_apply_dvfs_headroom() with better dynamic
logic.

Instead of the magical 1.25 headroom, use the new approximate_util_avg()
to provide headroom based on the dvfs_update_delay, which is the period
at which the cpufreq governor will send DVFS updates to the hardware, or
min(curr.se.slice, TICK_USEC) which is the max delay for util signal to
change and promote a cpufreq update; whichever is higher.

Add a new percpu dvfs_update_delay that can be cheaply accessed whenever
sugov_apply_dvfs_headroom() is called. We expect cpufreq governors that
rely on util to drive its DVFS logic/algorithm to populate these percpu
variables. schedutil is the only such governor at the moment.

The behavior of schedutil will change. Some systems will experience
faster dvfs rampup (because of higher TICK or rate_limit_us), others
will experience slower rampup.

The impact on performance should not be visible if not for the black
hole effect of utilization invariance. A problem that will be addressed
in later patches.

CONST_DVFS_HEADROOM sched_feat allows reverting back to the old behavior
for easy backward compatibility.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/core.c              |  1 +
 kernel/sched/cpufreq_schedutil.c | 39 +++++++++++++++++++++++++++-----
 kernel/sched/features.h          |  6 +++++
 kernel/sched/sched.h             |  9 ++++++++
 4 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 47ec8ea7c52e..3fbf560203f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -124,6 +124,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_exit_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_set_need_resched_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU_READ_MOSTLY(u64, dvfs_update_delay);
 DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
 
 #ifdef CONFIG_SCHED_PROXY_EXEC
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index f6de241fc62c..b529f5b96f6e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -215,13 +215,31 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * to run at adequate performance point.
  *
  * This function provides enough headroom to provide adequate performance
- * assuming the CPU continues to be busy.
+ * assuming the CPU continues to be busy. This headroom is based on the
+ * dvfs_update_delay of the cpufreq governor or min(curr.se.slice, TICK_US),
+ * whichever is higher.
  *
- * At the moment it is a constant multiplication with 1.25.
+ * XXX: Should we provide headroom when the util is decaying?
  */
-static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
+static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util,  int cpu)
 {
-	return util + (util >> 2);
+	struct rq *rq = cpu_rq(cpu);
+	u64 delay;
+
+	if (sched_feat(CONST_DVFS_HEADROOM))
+		return util + (util >> 2);
+
+	/*
+	 * What is the possible worst case scenario for updating util_avg, ctx
+	 * switch or TICK?
+	 */
+	if (rq->cfs.h_nr_queued > 1)
+		delay = min(rq->curr->se.slice/1000, TICK_USEC);
+	else
+		delay = TICK_USEC;
+	delay = max(delay, per_cpu(dvfs_update_delay, cpu));
+
+	return approximate_util_avg(util, delay);
 }
 
 unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
@@ -229,7 +247,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max)
 {
 	/* Add dvfs headroom to actual utilization */
-	actual = sugov_apply_dvfs_headroom(actual);
+	actual = sugov_apply_dvfs_headroom(actual, cpu);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
 		max = actual;
@@ -615,15 +633,21 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
 	struct sugov_policy *sg_policy;
 	unsigned int rate_limit_us;
+	int cpu;
 
 	if (kstrtouint(buf, 10, &rate_limit_us))
 		return -EINVAL;
 
 	tunables->rate_limit_us = rate_limit_us;
 
-	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
+	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook) {
+
 		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
 
+		for_each_cpu(cpu, sg_policy->policy->cpus)
+			per_cpu(dvfs_update_delay, cpu) = rate_limit_us;
+	}
+
 	return count;
 }
 
@@ -886,6 +910,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu = cpu;
 		sg_cpu->sg_policy = sg_policy;
+
+		per_cpu(dvfs_update_delay, cpu) = sg_policy->tunables->rate_limit_us;
+
 		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
 	}
 	return 0;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a25f97201ab9..6f7e5bba854f 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -129,3 +129,9 @@ SCHED_FEAT(LATENCY_WARN, false)
  */
 SCHED_FEAT(NI_RANDOM, true)
 SCHED_FEAT(NI_RATE, true)
+
+/*
+ * For backward compatibility. Use the constant 1.25 dvfs headroom in
+ * schedutil instead of the dynamic one.
+ */
+SCHED_FEAT(CONST_DVFS_HEADROOM, false)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 24008f1ec812..16ebd8eb48d5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3531,6 +3531,15 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
 u64 approximate_runtime(unsigned long util);
 
+/*
+ * Any governor that relies on util signal to drive DVFS, must populate these
+ * percpu dvfs_update_delay variables.
+ *
+ * It should describe the rate/delay at which the governor sends DVFS freq
+ * update to the hardware in us.
+ */
+DECLARE_PER_CPU_READ_MOSTLY(u64, dvfs_update_delay);
+
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
  * CPU original capacity and the runtime/deadline ratio of the task.
-- 
2.34.1

