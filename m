Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1101DF261
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860023; cv=none; b=huSp+1zkggOzrCjePzbVXXXW9vNBFkUmAsIbkcSFIkIdGxDRA2yBHGNUVU8dkuwYnIoGJfHDFnwe2n121T66/CXMnqUFikzQl1KGPjEcoe5UCArvludbFLPa3+QQzQhr3Sjb83CRWtYhdGT80+9qnQ+s20kEzby9/2jhZAnQtyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860023; c=relaxed/simple;
	bh=yuTHinju3Wqelxa/OJT5FyWbi37H9Z2sU6ewl9V4gcs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pDg8B2do9Q/GMEKkSQCqa1t1cxUCmmcqTYEqRnmxOJmnzNdDC7DhGPDJ+i3Jl6zJp2QRYyk5msW+7F76jODQFn7YOXRCKTroUJgKiwIGVj7HWwzXj9PhLHmSDbywSGUfrznn5owR/yZy4mzhLJbrb04NpU/ccHQ9PL1p4WKDP78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=plue465z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="plue465z"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48896199cbaso31619065e9.1
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860020; x=1778464820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXuQ4QLl0TdDDNVQh+o+wnNBMRXQls3OjNZ9KPeuMHc=;
        b=plue465zBI+B0ijjGdWgG/nGsterW1nuAyFv7cZ0aYyqiE/RNoo45pzryl8ecTvuGU
         1ObE34mubfkvzbqjS0K+43KiQll7sXvEbBnClJ6zBkDyAHHC1DLKlo/fSxWOXfEObTNC
         Xlru6qqd67zoG1xBbQW6QCbQPkZqvmJZHBixlRoCaFhV18fg/bo6oPrB157qbtOmKLgR
         bWiHiRFAbhh9YByrhh2thk7oECgW6Ei733p9IT5t9V/RchLUKunUQypBUS7lH6EKSWnd
         KYV6cgjbXVF3OedMR88qHBnjDQq72EbbIZvBOpXL6zK8bIxWKXP67KMBtQ/Bt1JEma/p
         FXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860020; x=1778464820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YXuQ4QLl0TdDDNVQh+o+wnNBMRXQls3OjNZ9KPeuMHc=;
        b=jupC3HsxCWrcZXx1xQlYL+M3LewnaYtgaoxNgozU8ueCTRcqiIxGr22nwMmjQdXGwi
         aTmZi8935W4/NxWR3tLqT57GeoZCHBOpfCCVyCOsU8Yuq8pjOnMDW+Ma7vQmiU1/3aqc
         D310SsN0lg5sqJqsC5goR3RfCUxb3BzjtY4snwNWu/cGwpZy65V88CGQiaEETef1WZJ8
         arYpM7n9cywryZJFKvqxS265NzgEoVTsy+JlGjJs3/NzIIuEiLdngpHmstf2l4lJHOJz
         fpZrGu8x7f+E2BWkJrG/1txCDuK4RnUmCqGFQ1FMawFYnE0NDS1sCY+oyvpFg+skG5Hh
         x6VQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AXfLdsRf+z8W/uaS9gYcv/nYwjstWQayOAyw7C0F+Su3b6T9kSVq+qhjgd3hdCZWmF/dCvacNAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzASZ5/X+XGHG/aSIUsvJu5XuKrZAmjFgJBNJJ9yyOh4rq7PHcO
	ijXag9fRb6yscRr8xYsLIDLnbLLm/9yl5+eMbFKBRRMoEwuISWdkEB3QdLZeP51by04=
X-Gm-Gg: AeBDieuKgwlHSqXBAsbd+GRcDW1IJ3cK8s23B6veJRvPlk82ANzCPSUbGhpYZezkH0a
	cNX/RJMVzXE7xZacO6Ea9B3BkbF3vv51fw1tukUujFb5rWs90eUW8PQfLEZiik344x1/uskWayU
	GONuF6hsSdalCMKvBR5vK1W1M8M9usFw4X6zObdBfILHoEUtypp8LFDupj828Qzoc+YhJ6J9kFw
	BtucWcoan8z5LSJq/GHONOVJTgcam39XsvBWzziGuiQViqZHMj7WgTHnvcvdHfmsi/Qta04asI2
	/VMhBuVkqLCD4kzSy7q/EJfJ3RkGmbt8bNGXRvgjeuF9bfsAntZTgQWIfmYbfjN0cxGlfDzY65M
	uuGBB2TNms5xRH7woI2AOKGUF21izKiO7ROjV30YHYbw+Vxj2gbPYOmCSdnC3lvRW7Hl+NdC77q
	oBxxQaV5+fBtoIoW48MPZRwq89XT4niVw=
X-Received: by 2002:a05:600c:5303:b0:48a:53ea:13eb with SMTP id 5b1f17b1804b1-48a9852c5c0mr138385405e9.5.1777860020476;
        Sun, 03 May 2026 19:00:20 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:19 -0700 (PDT)
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
Subject: [PATCH v2 04/13] sched/fair: Remove magic hardcoded margin in fits_capacity()
Date: Mon,  4 May 2026 02:59:54 +0100
Message-Id: <20260504020003.71306-5-qyousef@layalina.io>
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

Replace hardcoded margin value in fits_capacity() with better dynamic
logic.

80% margin is a magic value that has served its purpose for now, but it
no longer fits the variety of systems that exist today. If a system is
over powered specifically, this 80% will mean we leave a lot of capacity
unused before we decide to upmigrate on HMP system.

On many systems the little cores are under powered and ability to
migrate faster away from them is desired.

Redefine misfit migration to mean the utilization threshold at which the
task would become misfit at the next load balance event assuming it
becomes an always running task.

To calculate this threshold, we use the new approximate_util_avg()
function to find out the threshold, based on arch_scale_cpu_capacity()
the task will be misfit if it continues to run for a TICK_USEC which is
our worst case scenario for when misfit migration will kick in.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h |  1 +
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 49cd5d217161..47ec8ea7c52e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8921,6 +8921,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
+		rq->fits_capacity_threshold = SCHED_CAPACITY_SCALE;
 		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f179faf7a6a1..4e1ed3c7f96e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -97,11 +97,15 @@ int __weak arch_asym_cpu_priority(int cpu)
 }
 
 /*
- * The margin used when comparing utilization with CPU capacity.
- *
- * (default: ~20%)
+ * fits_capacity() must ensure that a task will not be 'stuck' on a CPU with
+ * lower capacity for too long. This the threshold is the util value at which
+ * if a task becomes always busy it could miss misfit migration load balance
+ * event. So we consider a task is misfit before it reaches this point.
  */
-#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
+static inline bool fits_capacity(unsigned long util, int cpu)
+{
+	return util < cpu_rq(cpu)->fits_capacity_threshold;
+}
 
 /*
  * The margin used when comparing CPU capacities.
@@ -5180,14 +5184,13 @@ static inline int util_fits_cpu(unsigned long util,
 				unsigned long uclamp_max,
 				int cpu)
 {
-	unsigned long capacity = capacity_of(cpu);
 	unsigned long capacity_orig;
 	bool fits, uclamp_max_fits;
 
 	/*
 	 * Check if the real util fits without any uclamp boost/cap applied.
 	 */
-	fits = fits_capacity(util, capacity);
+	fits = fits_capacity(util, cpu);
 
 	if (!uclamp_is_used())
 		return fits;
@@ -10299,12 +10302,33 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
+	struct rq *rq = cpu_rq(cpu);
+	u64 limit;
 
 	if (!capacity)
 		capacity = 1;
 
-	cpu_rq(cpu)->cpu_capacity = capacity;
-	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
+	rq->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(rq);
+
+	/*
+	 * Calculate the util at which the task must be considered a misfit.
+	 *
+	 * We must ensure that a task experiences the same ramp-up time to
+	 * reach max performance point of the system regardless of the CPU it
+	 * is running on (due to invariance, time will stretch and task will
+	 * take longer to achieve the same util value compared to a task
+	 * running on a big CPU) and a delay in misfit migration which depends
+	 * on TICK doesn't end up hurting it as it can happen after we would
+	 * have crossed this threshold.
+	 *
+	 * To ensure that invaraince is taken into account, we don't scale time
+	 * and use it as-is, approximate_util_avg() will then let us know the
+	 * our threshold.
+	 */
+	limit = approximate_runtime(arch_scale_cpu_capacity(cpu)) * USEC_PER_MSEC;
+	limit -= TICK_USEC; /* sd->balance_interval is more accurate */
+	rq->fits_capacity_threshold = approximate_util_avg(0, limit);
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a445add5cc3a..24008f1ec812 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1236,6 +1236,7 @@ struct rq {
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
 
+	unsigned long		fits_capacity_threshold;
 	unsigned long		misfit_task_load;
 
 	/* For active balancing */
-- 
2.34.1

