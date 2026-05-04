Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9052B1DA60D
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 02:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777860032; cv=none; b=hkm+fHVVafi+BIw52E1OLKUCt0EndTZrWpShNwwKjSpVrmEO5NQN7WZ/1NMYMlfNhRA6bOZd2RgUjSAv5Xj1gq+fO+xHICOBSB6G9zVMlBQxPA58NC1flFUKOVVaNoCco8mFaSSgnmynY30eOR+e2Nm2NGA6uOqdVoNffwtxMGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777860032; c=relaxed/simple;
	bh=cy+j8MjibedIQhzLoAyze5sRnjwPgv9zPirmIRVcZHs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ot0xNhf5nVIrfb9KUVYQeDRIQJPTnk+cOiHEPNrcTsdjb4o8V2y06AxiUk30PwsqZDSVm6Vc/43G8s1uTizfFLm5C+ngusuJCMfP+56XvzicZO8l0sC1NX7HrslsRw1K1Zy17t/Vin55PcYNqmXCIcxdCuJNqYvpS7YWe42Xzbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b=jcGdBuXs; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20251104.gappssmtp.com header.i=@layalina-io.20251104.gappssmtp.com header.b="jcGdBuXs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48896199cbaso31619805e9.1
        for <linux-pm@vger.kernel.org>; Sun, 03 May 2026 19:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20251104.gappssmtp.com; s=20251104; t=1777860029; x=1778464829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4EWfVx8oSxQ1texlxFkhY6RzzwUwZhmXsmzRm5cdpY=;
        b=jcGdBuXsp9SuXwDOyIky7sIacjKO5wGQ/j/lwIw93PsQUsZXQzONXUHSJC5gTXmSSq
         sidD5aKeJlCpN92f4gxAuhHlySh7Y6siU5sEVmcdxZBV0vLAf+vUK5a8soo8x5j0ge+n
         sITaoiwNUoPifxVjNoXzthagJ4sTjcfCSn0FOUqoEz0EjQtjliILUAPzMv+8GHzgkjNh
         JhH5wMsUImrr08ZvPO0OofC3lBnfinE6kEZ82sMXpKR4+CloB6lo0YaPrbv2tL4/W7kA
         Ys+oKHqGoIgv9ld7wYvZIYqnIFmNq0+W5QdE830XopfOy6uxz9VwDVhUc1ZO0Yzie0SE
         HpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777860029; x=1778464829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O4EWfVx8oSxQ1texlxFkhY6RzzwUwZhmXsmzRm5cdpY=;
        b=lRZGwNQSi2lm6veJ+fCzVvVDYsh5TfQEwXRPPT+XaC2Z399Tzd+f0CRNfsseZP28l/
         VnUbWA3i0FG0GMGs5uSLyhem41fGlvjTYCVv3Yc0Dh0ymvNBsR3rfOwYzmZBDBfregNI
         Iyo9KPFH3DT6pf0bEOHDOkk0IAohwFW39wNxCYXEe9+qsRqY3nGBRl1rdpSE2SPJlFK8
         7OG5jew0YdAwAxWNeSd5Tjlt791Va3iQEQGDfaZc31L1wnNTF6N8DG5NJMgQTugulAbL
         65iyEtJfbdkmQMTj3GBubOrHoaOqN1aq1Ui8HlxJVlpYVtYIYIo0hOlnbP3cXQVbPfNT
         g/Zw==
X-Forwarded-Encrypted: i=1; AFNElJ/HvhyVIraAV1FSXIrTZD+U7A7pox7JcvAwd3Oyz8BJ7D6af9EpdwisO0ZIYORTd1q8yZFYBk0amw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHAPBgzCEH3iut+TlW9S881RyThx8by5vI5SSUogfHEOC2Vqv
	NsskdHnEWg5DSmIfOrPqbya1Lxel3VZ9pxwYwCk69vwLGFfdRKdAoCfgRrUCk9ZcnYA=
X-Gm-Gg: AeBDiev9SzJgXZJSnfYNCtNgO1JJwU25CaprQfcu8NM8iSUnfBSbz+1wCN6Aq0w+V5Y
	uZjmZlWbyl+cUDBQp08f75z49qoYY1jIjqMTnCyQF5oBRVNX7muacwr9vd3+r7OX3EnwVuAWhKh
	BFrFfFN6Q73qHxTeuHKzLRBpMSwTsyM4/FE6kEIWS0NanvWm3yuVeXzYSTXg4SexbD9jiMq148S
	av6Pnv3czjQsKqP+ZuchI8q3ys8Ny9cSajRPOMosojjQNyTJcopAKDDtHqdjFur500XGutZMQAe
	zeYj7ZgKugFDSlcLKgvPXIYZj4EzaarMtvasHO8Mv+cMLht8+eF7KxOmrUehx4jfCHC67+HWs7C
	RcBxx6PB9mzyn/dUtMGoy6+eRc5eMmikWPRuPNDeSWxAII4JAzQgrNxPfFYbO3TVhXc7Ztmk6BC
	WtzeZ0KwbJrtfenWfSvFZJ7bxRtAH+5Vw=
X-Received: by 2002:a05:600d:16:b0:48a:563c:c8e2 with SMTP id 5b1f17b1804b1-48a9852d292mr93129285e9.3.1777860028909;
        Sun, 03 May 2026 19:00:28 -0700 (PDT)
Received: from airbuntu.. ([146.70.179.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8fee5033sm68064215e9.22.2026.05.03.19.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 19:00:28 -0700 (PDT)
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
Subject: [PATCH v2 07/13] sched/fair: util_est: Take into account periodic tasks
Date: Mon,  4 May 2026 02:59:57 +0100
Message-Id: <20260504020003.71306-8-qyousef@layalina.io>
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

The new faster rampup is great for performance. But terrible for power.
We want the faster rampup to be only applied for tasks that are
transitioning from one periodic/steady state to another periodic/steady
state. But if they are stably periodic, then the faster rampup doesn't
make sense as util_avg describes their computational demand accurately
and we can rely on that to make accurate decision. And preserve the
power savings from being exact with the resources we give to this task
(ie: smaller DVFS headroom).

We detect periodic tasks based on util_avg across util_est_update()
calls. If it is rising, then the task is going through a transition.

We rely on util_avg being stable for periodic tasks with very little
variations around one stable point.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   |  2 ++
 kernel/sched/fair.c   | 35 ++++++++++++++++++++++++-----------
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b61da16861e7..70517497e80b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -907,6 +907,8 @@ struct task_struct {
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
+	unsigned long			util_avg_dequeued;
+
 	struct sched_statistics         stats;
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe14fd4a2d53..82189bdc85b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4409,6 +4409,8 @@ static void __sched_fork(u64 clone_flags, struct task_struct *p)
 #endif
 #endif
 
+	p->util_avg_dequeued		= 0;
+
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->stats, 0, sizeof(p->stats));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c6363ec5de9d..d9729da3901a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5041,6 +5041,11 @@ static inline unsigned long task_util(struct task_struct *p)
 	return READ_ONCE(p->se.avg.util_avg);
 }
 
+static inline unsigned long task_util_dequeued(struct task_struct *p)
+{
+	return READ_ONCE(p->util_avg_dequeued);
+}
+
 static inline unsigned long task_runnable(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.runnable_avg);
@@ -5108,18 +5113,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * quickly to settle down to our new util_avg.
 	 */
 	if (!task_sleep) {
-		u64 delta = p->se.delta_exec;
-		unsigned int prev_ewma = ewma & ~UTIL_AVG_UNCHANGED;
+		if (task_util(p) > task_util_dequeued(p) &&
+		    task_util(p) - task_util_dequeued(p) > UTIL_EST_MARGIN) {
+			u64 delta = p->se.delta_exec;
+			unsigned int prev_ewma = ewma & ~UTIL_AVG_UNCHANGED;
 
-		do_div(delta, 1000);
-		ewma = approximate_util_avg(prev_ewma, delta);
-		/*
-		 * Keep accumulating delta_exec if it is too small to cause
-		 * a change.
-		 */
-		if (ewma != prev_ewma)
-			p->se.delta_exec = 0;
-		goto done;
+			do_div(delta, 1000);
+			ewma = approximate_util_avg(prev_ewma, delta);
+			/*
+			 * Keep accumulating delta_exec if it is too small to cause
+			 * a change.
+			 */
+			if (ewma != prev_ewma)
+				p->se.delta_exec = 0;
+			goto done_running;
+		}
+		return;
 	} else {
 		p->se.delta_exec = 0;
 	}
@@ -5134,6 +5143,9 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	/* Get utilization at dequeue */
 	dequeued = task_util(p);
 
+	if (!task_on_rq_migrating(p))
+		p->util_avg_dequeued = dequeued;
+
 	/*
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
@@ -5180,6 +5192,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
 	ewma |= UTIL_AVG_UNCHANGED;
+done_running:
 	WRITE_ONCE(p->se.avg.util_est, ewma);
 
 	trace_sched_util_est_se_tp(&p->se);
-- 
2.34.1

