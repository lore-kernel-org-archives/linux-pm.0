Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3421E4EFFB3
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955930; cv=none; b=esEMvR17aNOtq7aZ1NY5cKs8VE9FcfPWx2BuxJ1zN4mZHfCC/vIGAHG7FRhx1p9EHo/i0ib340CfMRwXB+2JUafxXpM8iYEmXlZv73CvuU5efa2NZLFlgLEWumkpDPmaOX5cPuz6O24goddbAvnmetOgfQ3218dZO8lYMjpNlJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955930; c=relaxed/simple;
	bh=7hap95mxpTk9UW2dteAHIfeOd/zesefXqWk9LTMKroo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGSGTkliG8fbl6/0cTR+42+W0KdFFoSpOxgEV6N65XQd3MGN/cI4UjlvBvYvK6qmS4Xuj4OjWrN0SEIrr8pm7o9K4h2TxhoqvOe4romWQv6n8Qpp4wx3/wfBFQ9phUHsdSIRT44h3OWx0OMkcqvZQFF0nnwQAUU1sZjOMEs+eQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=URjfrTFZ; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="URjfrTFZ"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d8239so397575e9.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955918; x=1791560718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=twXh4IEgj3c3B1TaynWUaOppTXyXcqyaqn780+9h4uM=;
        b=URjfrTFZ6whKeYOtnT6bgy/phAiKcEU8+0ayAowX5eEOCCPIGiHWql8sKIgXngMD7i
         ufOthwVxd+AFRBM7mjZxdpW/kylWZGbpXj9OLJ+8Cewx4V7yHaNTF/z6qsu5U1EHmTEO
         heVzGF9ch3FTUhDnBFdLARcW2E1Iehg7Q/GAdjbV7kDAkKhP27UetrMclj2GoKzSQ27O
         Cc/UjrIRhlWeDvF3a+vZUHsxHIf14eA+SaiXqxA/0avHW76Fg+HY2YbvcQ6uikl8c/Xa
         v6WU124ZDeY+feYX0qB3hlfLw9iGVOar9CEhCiciKO1bUKbDKJ0DMGnJn08tdldVTb60
         qy4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955918; x=1791560718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=twXh4IEgj3c3B1TaynWUaOppTXyXcqyaqn780+9h4uM=;
        b=JDtMLQXyxJrPk7dp5pa+6yty183Eerqt+6/1DJoW3CD+cokx6dJEN2xru7aD0u6bbh
         mywPhia6l/kJ8CL+DUz5ihy7i8Dc4JY/zpfuaTSZT+B8S6wIQk/5jC/lzXGrvY4ljv8P
         fvGPG6n/qSCoBgUPgxq5Zkimg+iWY4hh5iXAXXMKfH0VVBKztyixI96fuwOtFQxW5AQh
         Y5fdia/737qG5/iDxNxSHO5AivCy6cBmMXkN9oRSatv3RABrV4c+hSnH/6l4I96+77Gg
         mlc4w7VWIOk9hSIJGivW/UvXb9xSr1diF9h6sVEX1ZnQKciGrZMitWD4OoLemDcugkFU
         GQbw==
X-Forwarded-Encrypted: i=1; AKwUvBybfMdUOHvoGnPPcocqTF8xs9mxpfWpK+vPWV75HGWM8OozCIpDoYcg3hE3YkwSR7JUJTx++MXFLQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nhf9oOXIgDjofwlPrtPLf4AscqdMsnprTeHC7ZUm08nVgdnAQc
	2gfHVmd2nU35qXwOScc+DNGXktaaS3V4DSTlFdyDTd4G3Po/XXwGhcS3n253MO6tMlLMlO4A5b8
	05NUN
X-Gm-Gg: AYBFou3EAoO5tx6z3DxscRucrUNhNDt6jYplP7kuOpZvu0kOIaF/5LDUaRUJgPd7U1T
	a6X3C0jt61GcDVq9dI/rqQxR87uqXcXr9gur5ZR/K4PAcsIYloKAiyl1U8adxycCg8k8c9gs1jr
	y/rCMvlhx/YMR5QUVaXcaYRqzC3/KBB2G3kPr+bNP5ku9wV0Nw7fvvSE5pHL+4/xQwDmpvszclF
	raDdfqbyflBTYbB2EyMdKTqhJ5PDIk39TKF3tCHZ7KV3cqbtAa7j5GqVgI5MYO7HtUAyCa+Evmc
	oxhjdtsB3BflaYduTMb+OdsLqLrxmmj/BK6d4GHkTLCHxCoLQQLExEAyv+8gQUXBNhUQnRH6k+s
	GdgFdz0soIbNodWDPxRPq4GsqeKOKyw6zrw2mQWX1sirS5cCv2E91GBqbjsen5kFzyV6cT9jSEl
	f2EmdUJeKBp249F0bOgxsatciBG33wfwneqeJyp/XXAxHIZetcTplFN88HqFFgcdjYfY5/9RkY2
	6Tw8QrJs7h9Fay7
X-Received: by 2002:a05:600c:34d1:b0:4a0:1cfd:321 with SMTP id 5b1f17b1804b1-4a027579e86mr63230245e9.12.1790955918295;
        Fri, 02 Oct 2026 08:45:18 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:17 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 10/18 v2] sched/fair: Add force push task mechanism for fair
Date: Fri,  2 Oct 2026 17:44:07 +0200
Message-ID: <20261002154415.2270586-11-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the task is alone on the CPU, it's never put back in the enqueued
list; In this special case, we use the tick to run the check used to push
runnable task on a btter CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 71 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 483ed5807dfc..6ed3e5bb7fd6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9955,6 +9955,71 @@ static void fair_add_pushable_prev(struct rq *rq, struct task_struct *prev, stru
 		__fair_add_pushable_task(rq, prev);
 }
 
+static int active_load_balance_cpu_stop(void *data);
+
+/*
+ * See if the alone task running on the CPU should migrate on a better than
+ * the local one.
+ */
+static inline bool tick_pushable_task(struct task_struct *p, struct rq *rq, struct rq_flags *rf)
+{
+	int new_cpu, cpu = cpu_of(rq);
+
+	if (!sched_push_task_enabled())
+		return false;
+
+	if (!rf)
+		return false;
+
+	if (WARN_ON(!p))
+		return false;
+
+	if (WARN_ON(!task_current(rq, p)))
+		return false;
+
+	if (is_migration_disabled(p))
+		return false;
+
+	/* If there are several task, wait for being put back */
+	if (rq->nr_running > 1)
+		return false;
+
+	if (!fair_check_pushable_task(rq, p, NULL))
+		return false;
+
+	if (!raw_spin_trylock(&p->pi_lock))
+		return false;
+
+	new_cpu = select_task_rq_fair(p, cpu, 0);
+
+	raw_spin_unlock(&p->pi_lock);
+
+	if (new_cpu == cpu)
+		return false;
+
+	/*
+	 * ->active_balance synchronizes accesses to
+	 * ->active_balance_work.  Once set, it's cleared
+	 * only after active load balance is finished.
+	 */
+	if (!rq->active_balance) {
+		rq->active_balance = 1;
+		rq->push_cpu = new_cpu;
+	} else {
+		return false;
+	}
+
+	preempt_disable();
+	rq_unlock(rq, rf);
+	stop_one_cpu_nowait(cpu,
+			    active_load_balance_cpu_stop, rq,
+			    &rq->active_balance_work);
+	preempt_enable();
+	rq_lock(rq, rf);
+
+	return true;
+}
+
 /*
  * select_task_rq_fair: Select a target runqueue for the task.
  * There are 2 ways to select the target runqueue:
@@ -15373,8 +15438,10 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, struct rq_fl
 
 	task_tick_cache(rq, curr);
 
-	update_misfit_status(curr, rq);
-	check_update_overutilized_status(task_rq(curr));
+	if (!tick_pushable_task(curr, rq, rf)) {
+		update_misfit_status(curr, rq);
+		check_update_overutilized_status(task_rq(curr));
+	}
 
 	task_tick_core(rq, curr);
 }
-- 
2.53.0

