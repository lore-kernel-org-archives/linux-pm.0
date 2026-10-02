Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ACA4F3ED7
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955917; cv=none; b=scMSWJvH/Xmac/qy/dDENqskSyB8e72NMesL01JOwkmrPYHxnedJoD6Nrw8p0uHxWoL3RPV1t9RW7QG8c7G+AOrqK+1iRL3z0W0Lt+Qq8xItaH2IsHst62hRILZg2PeyRTXjFCit0plsfXZcrBePIxK1xw7eLt7AOLVXuMfrIaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955917; c=relaxed/simple;
	bh=/2VD4LC+odtHLOqq8yAYPNfVMXKOIt4UdVKHp/RrnnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbfJaQPO3QlQWGChWe5iGsmp7GWkBwwUXdhUL6NveZ4jEPtKTJd0DdBDrQBihUyPzLclyPGJll8nGFSd3qQUwvXxqPwsdDtPMDRBH4v/UIIKcbKT1cRu/e3JW+5xJOG1wwxX4d80XaXMRGel/H5ZXR/+6xwAFZqzMOjc0+Dzwys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wb/XAB/n; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wb/XAB/n"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a0280d4f56so242585e9.2
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955911; x=1791560711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZPyZg82TXoz+4EHOEjtMUqhGA+LRIEAnq1slizudzTs=;
        b=Wb/XAB/nJgpvpc8YrkhodzXvs8PU/n4yKh4z0eJ6JMJtLROViFLhjWTLqaZMOSRS1P
         rYmEM+kzLKvXwo9s1LnwYZYw/FDx34C97aMKwe9XXO/tiyfMchnrdbrqxdjm75161Xfo
         wH6EFzh0x/myKKZnALcG4RpWe2vtO8VVffzpSkS+Ac0sJjwIlUBSfqHa8DsR6T3r1Ouf
         u2S2gZBSidpwhSNBvdC22vK8IEFyaXkAURn3Y9g2TaARsY+LOJla+qgBPPr/kzZ9CLl8
         t2od+GnRTCvsraG3UWgTEp1p5JvuDTBpAJZfjRWjKEjobDCI5NI3OG7EXv7wVD0XFy8a
         VN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955911; x=1791560711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZPyZg82TXoz+4EHOEjtMUqhGA+LRIEAnq1slizudzTs=;
        b=dIK+yFKtdHd8C3mStlgzeH2lRux3ol5wtZFoBYLPUgGEqKOKEQ+w26wzIgpCZ9nwFF
         QQaMpvDD69fwd9KuTTyGOME4zg6Ys7d1azXpS5yYI9/LL5wHVJXR4UYAZiQcDNU0V59G
         Yv1/vW6Zp2GS5POxeOXHY5xYYMF60ACdca5rqsQogyYFvV5OiH1x+mEqdl3qnDjwRzA8
         WWVyvXSoBxl/3te6tbmmtO+xXNgN+UoftOqgHZU9FPEK10ycZq9WMab4fnHAov0jsKsV
         wuzzej0H6hSoQNd18d1oY5Nxx+mofg6sCNXagR3LPx5tcPANfQY8Y3ju6OzjZlZJ9Eiq
         juaA==
X-Forwarded-Encrypted: i=1; AKwUvBwJRHGsmLOOmWj5xwQ6ndL2DJkI9fbkhUqoHOPk4je6uVR1FtZaONw8FCKoaVcpzQbtq6JX+3uwRw==@vger.kernel.org
X-Gm-Message-State: AFuF++mwmLCfA12xea/WbPM99I56PGo+bZufXHd19SechOC6XhZGEp2J
	QNk16O7nLZ/6pkrjjPTYibEJwB5Dbv2qSMBkbVLTMiqE4WrYC5mSzRPI6XnRDo9RpRA=
X-Gm-Gg: AYBFou2ATPG88peRSecqw5OhdS0ePptsmKEX4jh+xrfJxrNz0zbyVKjUehdRSiSYN+d
	+KeQto1F1ffH4JudM9dxfxFPjtYa2Yf+CgdJujl7ydM8ae7DK34Dlq0xkQbdLuhWhZE3ST0zNB7
	nbm7Y6jobup4e4Z/4VKpXdtHWm8EM+jbRabyKIaB2JRZiXrn9WcG5zhwsJ0Eo+MyPMttEdgev+K
	+1m8l92g5T+zJ22KKegZPSApgyaorSDen/pNbhA8RKkHgqKvsiiSdwbMGRvFK0IjYV5+PliiJAp
	kb8KbU58W0D9zVQNLBi6sfysn6h9DSVODYO5AHiUnygyGRem8IQTtyE4XL4TG0Awrao8QmY/n8o
	5laLa8vrTM/HYViAqdZhT9kYA+5ksKUDwXyPZDOueaqeb9PMyG2oOe2UGs/3e3Nig4F3GpzrA7y
	ZK4B6twnbAu+oddNFB3jC1HY2ur+ge64P5yNrich7BaJ5GUIvy+juKsSH28pPwIIgSMhraWjgso
	V8B6yNBly2tck3R
X-Received: by 2002:a05:600c:138b:b0:49f:ce78:3562 with SMTP id 5b1f17b1804b1-4a02759b46fmr60064605e9.19.1790955911245;
        Fri, 02 Oct 2026 08:45:11 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:10 -0700 (PDT)
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
Subject: [PATCH 06/18 v2] sched/fair: Prepare select_task_rq_fair() to be called for new cases
Date: Fri,  2 Oct 2026 17:44:03 +0200
Message-ID: <20261002154415.2270586-7-vincent.guittot@linaro.org>
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

Update select_task_rq_fair() to be called out of the 3 current cases which
are :
- wake up
- exec
- fork

We wants to select a rq in some new cases like pushing a runnable task on a
better CPU than the local one. In such case, it's not a wakeup , nor an
exec nor a fork. We make sure to not distrub these cases but still
go through EAS and fast-path.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c |  2 +-
 kernel/sched/fair.c | 57 ++++++++++++++++++++++++++-------------------
 2 files changed, 34 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f38cf5a37a8a..837dc74c9a8d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3618,7 +3618,7 @@ static int select_fallback_rq(int cpu, struct task_struct *p)
 }
 
 /*
- * The caller (fork, wakeup) owns p->pi_lock, ->cpus_ptr is stable.
+ * The caller (fork, wakeup, push) owns p->pi_lock, ->cpus_ptr is stable.
  */
 static inline
 int select_task_rq(struct task_struct *p, int cpu, int *wake_flags)
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 19a0e67827f7..f12678850ce2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9800,46 +9800,55 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 }
 
 /*
- * select_task_rq_fair: Select target runqueue for the waking task in domains
- * that have the relevant SD flag set. In practice, this is SD_BALANCE_WAKE,
- * SD_BALANCE_FORK, or SD_BALANCE_EXEC.
+ * select_task_rq_fair: Select a target runqueue for the task.
+ * There are 2 ways to select the target runqueue:
+ * - The fast path which only looks for an idle CPU in the LLC or the smallest
+ *   asymmetric domain (i.e. the lowest domain with all compute capacities).
+ * - The slow path which looks for the idlest CPU in the highest domain with
+ *   the relevant SD flag set.
  *
- * Balances load by selecting the idlest CPU in the idlest group, or under
- * certain conditions an idle sibling CPU if the domain has SD_WAKE_AFFINE set.
+ * In practice, WF_EXEC and WF_FORK uses the slow path whereas WF_TTWU and no
+ * flag (Push) uses the fast path.
  *
- * Returns the target CPU number.
  */
 static int
-select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
+select_task_rq_fair(struct task_struct *p, int prev_cpu, int select_flags)
 {
-	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	int sync = (select_flags & WF_SYNC) && !(current->flags & PF_EXITING);
+	int want_sibling = !(select_flags & (WF_EXEC | WF_FORK));
+	int new_cpu, cpu = smp_processor_id();
 	struct sched_domain *tmp, *sd = NULL;
-	int cpu = smp_processor_id();
-	int new_cpu = prev_cpu;
-	int want_affine = 0;
 	/* SD_flags and WF_flags share the first nibble */
-	int sd_flag = wake_flags & 0xF;
+	int sd_flag = select_flags & 0xF;
+	int want_affine = 0;
 
 	/*
-	 * required for stable ->cpus_allowed
+	 * Required for stable ->cpus_allowed
 	 */
 	lockdep_assert_held(&p->pi_lock);
-	if (wake_flags & WF_TTWU) {
+
+	if (select_flags & WF_TTWU) {
 		record_wakee(p);
 
-		if ((wake_flags & WF_CURRENT_CPU) &&
+		if ((select_flags & WF_CURRENT_CPU) &&
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;
+	}
 
-		if (!is_rd_overutilized(this_rq()->rd)) {
-			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
-			if (new_cpu >= 0)
-				return new_cpu;
-			new_cpu = prev_cpu;
-		}
+	/*
+	 * We don't want EAS to be called for exec or fork but it should be
+	 * called for any other case such as wake up or push callback.
+	 */
+	if (!is_rd_overutilized(this_rq()->rd) && want_sibling) {
+		new_cpu = find_energy_efficient_cpu(p, prev_cpu);
+		if (new_cpu >= 0)
+			return new_cpu;
+	}
 
+	if (select_flags & WF_TTWU)
 		want_affine = !wake_wide(p) && cpumask_test_cpu(cpu, p->cpus_ptr);
-	}
+
+	new_cpu = prev_cpu;
 
 	for_each_domain(cpu, tmp) {
 		/*
@@ -9871,8 +9880,8 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		return sched_balance_find_dst_cpu(sd, p, cpu, prev_cpu, sd_flag);
 
 	/* Fast path */
-	if (wake_flags & WF_TTWU)
-		return select_idle_sibling(p, prev_cpu, new_cpu);
+	if (want_sibling)
+		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
 
 	return new_cpu;
 }
-- 
2.53.0

