Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963C23D3D0C;
	Sat, 29 Aug 2026 16:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788019220; cv=none; b=lL+cj7/eEMewwgGb7s0BWk/zLPyuAO6WVDmdBwplvF6ayEtmOx8Ia7W3Q2Y3F9pFvlfxjBmH3PNJkJkZOFCt9BxSic4ggR+o2uJDn47tTLGKxqBiCO0k2xdeK5/DkNYz33Bi6A/hcWXRzwehYagLHWyJzpXzU0DxsN1QGzy/Fx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788019220; c=relaxed/simple;
	bh=uZKY6mc+5pft/q3cAwuIhr586hkZ+KFWPhywxEQWTm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jnY4uLbcmGvkxo1dpzuvkntjt8GJwATaQm9nfJmktWlgmY9BQLLYp1OuyGlC0u9SMhEOejvmcSt+coAm7U0ILcKNpixkxBVvUAA69BM5O1TIFSzJ4S0r3Joy01uxIfkrwAAvFQjzFYG2ey50+Nv/eU5OEJ+DrP0+tzYGyF7+DJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=nEBid52v; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=UOcV+bAb; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="nEBid52v";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="UOcV+bAb"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788019200; bh=ngSOMec2hvD+GVCYRJ3MZdS
	rfGEKoGbtHjfNNfZkYJQ=; b=nEBid52vwa0/EWjmDOfvg46s7w1WtEjCIFoHvCySUmJGYfHpXo
	sqKNBamw+oTs34uCFOf7wwpoAuIToyCYdpJQIGezZPs6Wy4c1eciAtZbhCLCHJx0BMXrnO6+R3M
	kMn1nhlte/16mWBgrJuoW3ayVgAcHsCKAMgrQDZvdRddXT7djDY6n/Pmf9zN0ux1BqU5kLsowOc
	N3hzcCzvnSwZTwA/LyC2+ngbfOMuJbrNoPyMv5k/S+THX69bHQ51DtI6x3FmlEcnPgpi7gGMdi+
	g+MbjL4mJOwl6U6waoApFeaYFzhy9aRlvokn4sfpYOFc+RsIhhwmul5dXADdpXS345Q==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1788019200; bh=ngSOMec2hvD+GVCYRJ3MZdS
	rfGEKoGbtHjfNNfZkYJQ=; b=UOcV+bAboLjOfbOpVDv/yGqnZ7Ztft6UikMqkbMh//vxc0a5yO
	mNRTACcNOENGVn2vzWHs85dzGMo/XBo6hFAQ==;
From: Bradley Morgan <include@grrlz.net>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brads@mainlining.org
Subject: [PATCH 4/5] cpufreq: schedutil: convert to kthread_create_worker
Date: Sat, 29 Aug 2026 16:00:01 +0000
Message-ID: <20260829160001.6245-1-include@grrlz.net>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bradley Morgan <brads@mainlining.org>

Embedding a kthread_worker and running kthread_worker_fn yourself is
the old way. Convert cpufreq_schedutil to kthread_create_worker(),
dropping the separate thread pointer.

This is part of removing the worker->task self-assignment in
kthread_worker_fn().

Signed-off-by: Bradley Morgan <brads@mainlining.org>
---
 kernel/sched/cpufreq_schedutil.c | 33 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 49ccd6f1c185..5023c24d8a21 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -31,8 +31,7 @@ struct sugov_policy {
 	struct			irq_work irq_work;
 	struct			kthread_work work;
 	struct			mutex work_lock;
-	struct			kthread_worker worker;
-	struct task_struct	*thread;
+	struct			kthread_worker *worker;
 	bool			work_in_progress;
 
 	bool			limits_changed;
@@ -586,7 +585,7 @@ static void sugov_irq_work(struct irq_work *irq_work)
 
 	sg_policy = container_of(irq_work, struct sugov_policy, irq_work);
 
-	kthread_queue_work(&sg_policy->worker, &sg_policy->work);
+	kthread_queue_work(sg_policy->worker, &sg_policy->work);
 }
 
 /************************** sysfs interface ************************/
@@ -669,7 +668,6 @@ static void sugov_policy_free(struct sugov_policy *sg_policy)
 
 static int sugov_kthread_create(struct sugov_policy *sg_policy)
 {
-	struct task_struct *thread;
 	struct sched_attr attr = {
 		.size		= sizeof(struct sched_attr),
 		.sched_policy	= SCHED_DEADLINE,
@@ -692,32 +690,29 @@ static int sugov_kthread_create(struct sugov_policy *sg_policy)
 		return 0;
 
 	kthread_init_work(&sg_policy->work, sugov_work);
-	kthread_init_worker(&sg_policy->worker);
-	thread = kthread_create(kthread_worker_fn, &sg_policy->worker,
-				"sugov:%d",
-				cpumask_first(policy->related_cpus));
-	if (IS_ERR(thread)) {
-		pr_err("failed to create sugov thread: %pe\n", thread);
-		return PTR_ERR(thread);
+	sg_policy->worker = kthread_create_worker(0, "sugov:%d",
+						cpumask_first(policy->related_cpus));
+	if (IS_ERR(sg_policy->worker)) {
+		pr_err("failed to create sugov thread: %pe\n", sg_policy->worker);
+		return PTR_ERR(sg_policy->worker);
 	}
 
-	ret = sched_setattr_nocheck(thread, &attr);
+	ret = sched_setattr_nocheck(sg_policy->worker->task, &attr);
 	if (ret) {
-		kthread_stop(thread);
+		kthread_destroy_worker(sg_policy->worker);
 		pr_warn("%s: failed to set SCHED_DEADLINE\n", __func__);
 		return ret;
 	}
 
-	sg_policy->thread = thread;
 	if (policy->dvfs_possible_from_any_cpu)
-		set_cpus_allowed_ptr(thread, policy->related_cpus);
+		set_cpus_allowed_ptr(sg_policy->worker->task, policy->related_cpus);
 	else
-		kthread_bind_mask(thread, policy->related_cpus);
+		kthread_bind_mask(sg_policy->worker->task, policy->related_cpus);
 
 	init_irq_work(&sg_policy->irq_work, sugov_irq_work);
 	mutex_init(&sg_policy->work_lock);
 
-	wake_up_process(thread);
+	wake_up_process(sg_policy->worker->task);
 
 	return 0;
 }
@@ -728,8 +723,8 @@ static void sugov_kthread_stop(struct sugov_policy *sg_policy)
 	if (sg_policy->policy->fast_switch_enabled)
 		return;
 
-	kthread_flush_worker(&sg_policy->worker);
-	kthread_stop(sg_policy->thread);
+	kthread_flush_worker(sg_policy->worker);
+	kthread_destroy_worker(sg_policy->worker);
 	mutex_destroy(&sg_policy->work_lock);
 }
 
-- 
2.47.3

