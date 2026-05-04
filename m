Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B61D63F0
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860038; cv=none; b=obx0ssghBHQkynF7a5Cp7pycBQ9z6aw+SBDCCCwg5WA7m0Y0r2FSC+GPgDzSvYG6AVmd7PvepQFh6Z0HzWFbTu/KUe0lYciku07TmaOI0At5mYcRB+YAIZ/5uBkVtzCeFXhXLP+et4J0FjUHC6uClcBCm5S06a3ONos6aLLluBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860038; c=relaxed/simple;
	bh=wGdqoMCD5vTrbqsOUB8F7aBwoPsyejH6Chsf2+bq9wM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UidFWmj8hBytL5CpMLgPWfij6AgUnHSdkV0v1b1l1smM3vpZtIsgGD0yWH3qZkej0Wrr620t6jbQUykZXv5/e5vZu+ZUM29Ufyz0A3qxII7WLYF26cQR6Z/zlyzq+15pHENjUgkfWARX7EFRLm7HRAREYynZe++hq81pdBypjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=j2tDzcKE; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="j2tDzcKE"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488ab2db91aso42882005e9.3
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860035; x=1778464835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZ4hUF0n3D9SeY8kArGM+n8pM6V04xy5DPkrbpzYAFs=;
        b=j2tDzcKEd4qXcved1R5PyKlafIv7KeOT+NGROurXmoZ6M0vXHAZ7p5WjSszAmwAQOq
         Ph0t8Nrt6v5QBRmb15xIetAQo+fosUZ/vyl8Sw2XYXNcPzBZjL59STKhoxAh3Bu0lrRq
         9DgGAqpcuG3muZ3CuauACsa+z6p95OCYTn8w99a3tK3MdmtbMXLCmaL7o51m9n+SD260
         ARhNz75iSSha2YQmtHD+Lsg6UWlVMhtTvjFOnW5fn2firVOSExY2TogNf+OaGPrJmt0O
         aHima//XBgxBrnH3U5IIqMZ2HiU2oOB9Td4S0n3ZL1NjVxOpzPhyi1Kmt/bxJfagjYi9
         6miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860035; x=1778464835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hZ4hUF0n3D9SeY8kArGM+n8pM6V04xy5DPkrbpzYAFs=;
        b=TFMStz0NWn/0MQUS8sXUHVxFyDnwQIKhFBNgNRPr1R9ESz0lqcKvph1eNVlzLDjIDV
         +ASgsm5nj67H7jyl9Rd31q/tFHLdmUAOvdfy6Om2QS152aaNt85DlcY6XK473umpXhJW
         uBzeVb5JeY7CMHGExf4Z6FrdQrr+XWflfBsjX6YLeGDaq/1DBk6wWNWCBBx/i/Ub55/6
         nHqvaXeeOJWaW7pJ+EdQ6hSV9F9SS+P0SKaSvrxL8BzfxA76yEIVH8WA77sJPHxfvlEY
         XzizwwkMzc8HtueJHsAuKzd9C5oKLVCU28yEUDT2N22oT8OMqw/0wJu5M6bZaua6U2Bc
         zpXQ==
X-Forwarded-Encrypted: i=1; AFNElJ+0rLC4LMdjVedMNWamU/y0cpqSI2KsyTaadk4mOz+FN4Fyr3n3qwskPP4ytWTVNeDGf0mhzkdzog==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXB32OLUZ/gne+8H5pCOa7y1TA8c4Q2Sgx50SjMpPWlDqV/o2q
	XIC9Uxvflpln1ZG1jALoCRm2w975EuL7yIHHSspuXb1sj2+eBmvfLSfABv88x6CsOJM=
X-Gm-Gg: AeBDietyrZl91g9E2tjpSvzyrKvXqrgpZoXqpyklKXFV/YD47KoADFUb+CgX4NlPMiK
	MhhlYrsPqdsXxCrwRoU/qp4Thn8PoltDy9QE6kZ0Z0slYk78vXVkHc3SGhDA9EuhigXGnS0oQ/x
	5t+PgLmiQoORlQQhb4qbRRT83/cojepgQuvFhgl6VxRcXtPtRTLNDgcpgWcNQMek8H+AFaNlW/c
	R16AHab3HoN6JYjaS5qmYHHBi/GD9vr0V302dSJ06uyhdwGqv9BI2X8ymOT9fdkd40UNwlzF73+
	k6hsAgeFrPKb8+Msjd3f9i1SFE56n+3YRNNapZOOXVLYw4MhIZhmNM45ZvpOs3P0jyhAm/7qRP9
	k8TJgcIdaJpqZ0T/6xLyE22UHSYCv1Ik/9/pKTbOpWA/JTU7S+GTk5dmqGBryMxK9Ey7n1VVyhL
	6n2kFKVPppWUXK4bSUg7rOtFDKUh/sm8P8Y+mDtWeYRg==
X-Received: by 2002:a05:600c:859a:b0:48a:525b:e157 with SMTP id 5b1f17b1804b1-48a9865f870mr86414375e9.13.1777860035117;
        Sun, 03 May 2026 19:00:35 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:34 -0700 (PDT)
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
Subject: [PATCH v2 09/13] sched/qos: Add rampup multiplier QoS
Date: Mon,  4 May 2026 02:59:59 +0100
Message-Id: <20260504020003.71306-10-qyousef@layalina.io>
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

Bursty tasks are hard to predict. To use resources efficiently, the
system would like to be exact as much as possible. But this poses
a challenge for these bursty tasks that need to get access to more
resources quickly.

The new SCHED_QOS_RAMPUP_MULTIPLIER allows userspace to do that. As the
name implies, it only helps them to transition to a higher performance
state when they get _busier_. That is perfectly periodic tasks by
definition are not going through a transition and will run at a constant
performance level. It is the tasks that need to transition from one
periodic state to another periodic state that is at a higher level that
this rampup_multiplier will help with. It also slows down the ewma decay
of util_est which should help those bursty tasks to keep their faster
rampup.

This should work complimentary with uclamp. uclamp tells the system
about min and max perf requirements which can be applied immediately.

rampup_multiplier is about reactiveness to change in behavior;
specifically when a task gets a sudden burst of work and gets busier.

In practice this is found to be a much better control than uclamp_min as
it is relative parameter and doesn't require absolute description. It
allows the task to go through the motion faster without knowing exactly
how busy it can get at any particular point of time.

The intention is for this rampup multiplier to be applied only during
a burst. It has no effect on perfectly periodic tasks.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 Documentation/scheduler/sched-qos.rst | 22 +++++++++
 include/linux/sched.h                 |  7 +++
 include/uapi/linux/sched.h            |  6 ++-
 kernel/sched/core.c                   | 66 +++++++++++++++++++++++++++
 kernel/sched/debug.c                  |  1 +
 kernel/sched/fair.c                   |  6 ++-
 kernel/sched/syscalls.c               | 55 +++++++++++++++++++++-
 7 files changed, 158 insertions(+), 5 deletions(-)

diff --git a/Documentation/scheduler/sched-qos.rst b/Documentation/scheduler/sched-qos.rst
index 0911261cb124..f68856f23b6b 100644
--- a/Documentation/scheduler/sched-qos.rst
+++ b/Documentation/scheduler/sched-qos.rst
@@ -42,3 +42,25 @@ need for extension will arise; and when this happen the task should be
 simpler to add the kernel extension and allow userspace to use readily by
 setting the newly added flag without having to update the whole of
 sched_attr.
+
+2. QoS Tags
+===========
+
+SCHED_QOS_RAMPUP_MULTIPLIER
+---------------------------
+
+Controls how fast util signal rises. Affects frequency selection when schedutil
+is in use. And affects how fast tasks migrate between clusters on HMP systems.
+
+It affects bursty tasks only. Perfectly periodic tasks are well described by
+util_avg and the rampup multiplier will have no effect on them.
+
+When set to 0, util_est will be disabled to help further with power saving.
+This behavior can be controlled via UTIL_EST_RAMPUP_ZERO sched_feature.
+
+Value is not capped to retain flexibility, but it tapers off very quickly to
+notice a difference above 16. Roughly it takes ~200ms to reach a util_avg of
+1000 starting from 0. With 16 it should take ~12.5ms. A range of 0-8 is
+advised for general use.
+
+Cookie must always be set to 0.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 70517497e80b..38f0f507960a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -443,6 +443,11 @@ struct sched_info {
 #endif /* CONFIG_SCHED_INFO */
 };
 
+struct sched_qos {
+	DECLARE_BITMAP(user_defined, SCHED_QOS_MAX);
+	unsigned int rampup_multiplier;
+};
+
 /*
  * Integer metrics need fixed point arithmetic, e.g., sched/fair
  * has a few: load, load_avg, util_avg, freq, and capacity.
@@ -954,6 +959,8 @@ struct task_struct {
 
 	struct sched_info		sched_info;
 
+	struct sched_qos		sched_qos;
+
 	struct list_head		tasks;
 	struct plist_node		pushable_tasks;
 	struct rb_node			pushable_dl_tasks;
diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 3cdba44bc1cb..2247fe805abc 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -104,6 +104,9 @@ struct clone_args {
 };
 
 enum sched_qos_type {
+	SCHED_QOS_NONE,
+	SCHED_QOS_RAMPUP_MULTIPLIER,
+	SCHED_QOS_MAX,
 };
 #endif
 
@@ -148,7 +151,8 @@ enum sched_qos_type {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_QOS)
 
 /* Only for sched_getattr() own flag param, if task is SCHED_DEADLINE */
 #define SCHED_GETATTR_FLAG_DL_DYNAMIC	0x01
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 82189bdc85b7..2b06701191c5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -186,6 +186,8 @@ __read_mostly int sysctl_resched_latency_warn_once = 1;
  */
 __read_mostly unsigned int sysctl_sched_nr_migrate = SCHED_NR_MIGRATE_BREAK;
 
+unsigned int sysctl_sched_qos_default_rampup_multiplier	= 1;
+
 __read_mostly int scheduler_running;
 
 #ifdef CONFIG_SCHED_CORE
@@ -4567,6 +4569,47 @@ static int sysctl_schedstats(const struct ctl_table *table, int write, void *buf
 #endif /* CONFIG_SCHEDSTATS */
 
 #ifdef CONFIG_SYSCTL
+static void sched_qos_sync_sysctl(void)
+{
+	struct task_struct *g, *p;
+
+	guard(rcu)();
+	for_each_process_thread(g, p) {
+		struct rq_flags rf;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &rf);
+		if (!test_bit(SCHED_QOS_RAMPUP_MULTIPLIER, p->sched_qos.user_defined))
+			p->sched_qos.rampup_multiplier = sysctl_sched_qos_default_rampup_multiplier;
+		task_rq_unlock(rq, p, &rf);
+	}
+}
+
+static int sysctl_sched_qos_handler(const struct ctl_table *table, int write,
+				    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	unsigned int old_rampup_mult;
+	int result;
+
+	old_rampup_mult = sysctl_sched_qos_default_rampup_multiplier;
+
+	result = proc_dointvec(table, write, buffer, lenp, ppos);
+	if (result)
+		goto undo;
+	if (!write)
+		return 0;
+
+	if (old_rampup_mult != sysctl_sched_qos_default_rampup_multiplier) {
+		sched_qos_sync_sysctl();
+	}
+
+	return 0;
+
+undo:
+	sysctl_sched_qos_default_rampup_multiplier = old_rampup_mult;
+	return result;
+}
+
 static const struct ctl_table sched_core_sysctls[] = {
 #ifdef CONFIG_SCHEDSTATS
 	{
@@ -4613,6 +4656,13 @@ static const struct ctl_table sched_core_sysctls[] = {
 		.extra2		= SYSCTL_FOUR,
 	},
 #endif /* CONFIG_NUMA_BALANCING */
+	{
+		.procname	= "sched_qos_default_rampup_multiplier",
+		.data           = &sysctl_sched_qos_default_rampup_multiplier,
+		.maxlen         = sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler   = sysctl_sched_qos_handler,
+	},
 };
 static int __init sched_core_sysctl_init(void)
 {
@@ -4622,6 +4672,21 @@ static int __init sched_core_sysctl_init(void)
 late_initcall(sched_core_sysctl_init);
 #endif /* CONFIG_SYSCTL */
 
+static void sched_qos_fork(struct task_struct *p)
+{
+	/*
+	 * We always force reset sched_qos on fork. These sched_qos are treated
+	 * as finite resources to help improve quality of life. Inheriting them
+	 * by default can easily lead to a situation where the QoS hint become
+	 * meaningless because all tasks in the system have it.
+	 *
+	 * Every task must request the QoS explicitly if it needs it. No
+	 * accidental inheritance is allowed to keep the default behavior sane.
+	 */
+	bitmap_zero(p->sched_qos.user_defined, SCHED_QOS_MAX);
+	p->sched_qos.rampup_multiplier = sysctl_sched_qos_default_rampup_multiplier;
+}
+
 /*
  * fork()/clone()-time setup:
  */
@@ -4641,6 +4706,7 @@ int sched_fork(u64 clone_flags, struct task_struct *p)
 	p->prio = current->normal_prio;
 
 	uclamp_fork(p);
+	sched_qos_fork(p);
 
 	/*
 	 * Revert to default priority/policy on fork if requested.
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 74c1617cf652..60a0d4b0e6a6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -1357,6 +1357,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	__PS("effective uclamp.min", uclamp_eff_value(p, UCLAMP_MIN));
 	__PS("effective uclamp.max", uclamp_eff_value(p, UCLAMP_MAX));
 #endif /* CONFIG_UCLAMP_TASK */
+	__PS("sched_qos.rampup_multiplier", p->sched_qos.rampup_multiplier);
 	P(policy);
 	P(prio);
 	if (task_has_dl_policy(p)) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d9729da3901a..8124bcc602d3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5119,7 +5119,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 			unsigned int prev_ewma = ewma & ~UTIL_AVG_UNCHANGED;
 
 			do_div(delta, 1000);
-			ewma = approximate_util_avg(prev_ewma, delta);
+			ewma = approximate_util_avg(prev_ewma, delta * p->sched_qos.rampup_multiplier);
 			/*
 			 * Keep accumulating delta_exec if it is too small to cause
 			 * a change.
@@ -5188,6 +5188,8 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * 0.25, thus making w=1/4 ( >>= UTIL_EST_WEIGHT_SHIFT)
 	 */
 	ewma <<= UTIL_EST_WEIGHT_SHIFT;
+	if (p->sched_qos.rampup_multiplier)
+		last_ewma_diff /= p->sched_qos.rampup_multiplier;
 	ewma  -= last_ewma_diff;
 	ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
@@ -10360,7 +10362,7 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 	 * on TICK doesn't end up hurting it as it can happen after we would
 	 * have crossed this threshold.
 	 *
-	 * To ensure that invaraince is taken into account, we don't scale time
+	 * To ensure that invariance is taken into account, we don't scale time
 	 * and use it as-is, approximate_util_avg() will then let us know the
 	 * our threshold.
 	 */
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 88feedd2f7c9..3bf9a8b32f7d 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -427,6 +427,38 @@ static void __setscheduler_uclamp(struct task_struct *p,
 				  const struct sched_attr *attr) { }
 #endif /* !CONFIG_UCLAMP_TASK */
 
+static inline int sched_qos_validate(struct task_struct *p,
+				     const struct sched_attr *attr)
+{
+	switch (attr->sched_qos_type) {
+	case SCHED_QOS_RAMPUP_MULTIPLIER:
+		if (attr->sched_qos_cookie)
+			return -EINVAL;
+		if (attr->sched_qos_value < 0)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void __setscheduler_sched_qos(struct task_struct *p,
+				     const struct sched_attr *attr)
+{
+	if ((attr->sched_flags & SCHED_FLAG_QOS) == 0)
+		return;
+
+	switch (attr->sched_qos_type) {
+	case SCHED_QOS_RAMPUP_MULTIPLIER:
+		set_bit(SCHED_QOS_RAMPUP_MULTIPLIER, p->sched_qos.user_defined);
+		p->sched_qos.rampup_multiplier = attr->sched_qos_value;
+	default:
+		break;
+	}
+}
+
 /*
  * Allow unprivileged RT tasks to decrease priority.
  * Only issue a capable test if needed and only once to avoid an audit
@@ -559,8 +591,11 @@ int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
-	if (attr->sched_flags & SCHED_FLAG_QOS)
-		return -EOPNOTSUPP;
+	if (attr->sched_flags & SCHED_FLAG_QOS) {
+		retval = sched_qos_validate(p, attr);
+		if (retval)
+			return retval;
+	}
 
 	/*
 	 * SCHED_DEADLINE bandwidth accounting relies on stable cpusets
@@ -697,6 +732,7 @@ int __sched_setscheduler(struct task_struct *p,
 			__setscheduler_dl_pi(newprio, policy, p, scope);
 		}
 		__setscheduler_uclamp(p, attr);
+		__setscheduler_sched_qos(p, attr);
 
 		if (scope->queued) {
 			/*
@@ -1108,6 +1144,21 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 		kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
 		kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
 #endif
+		if (copy_from_user(&kattr.sched_qos_type,
+				   &uattr->sched_qos_type,
+				   sizeof(kattr.sched_qos_type))) {
+
+			return -EFAULT;
+		}
+
+		switch (kattr.sched_qos_type) {
+		case SCHED_QOS_RAMPUP_MULTIPLIER:
+			kattr.sched_qos_value = p->sched_qos.rampup_multiplier;
+			kattr.sched_qos_cookie = 0;
+			break;
+		default:
+			break;
+		}
 	}
 
 	kattr.size = min(usize, sizeof(kattr));
-- 
2.34.1

