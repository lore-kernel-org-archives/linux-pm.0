Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD544B44C8
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955913; cv=none; b=KHz9aS+t5Od3H8lS3nC/kJHZMNzX1qVzaOBBlF/kXTdVXmOnrl0RBN+WbbN57GprCFefFbOiepzk183gclRfgyKmhbG7RMX7D7UmgFHirKWLt6tUU2uPCLglN3S87hv/In9sgU486BtMcX6w/rwlOMpNPJoUzfSoysvDVE4N4k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955913; c=relaxed/simple;
	bh=Z3OZRU9tUVQEa8ii3OJE37iSt72mrOcOAJir4arnI9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9SmXGgnhxBsSJjgw6cMJSuKn+z3x0L368K0Wm3NFNa2dbsQW/nm11Ey/EhQnzjpYopiqzwq+NgcVnchJr7m5h0DfOsAjL4ZzNrvj820LBIVuBMnyMxcE0Zd0wli/UFXa1ra5Wo0zjO4fph8frdzi4wQgPRhEV7p0UL4HU5u4DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E4VReeLy; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4VReeLy"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ccf3ca626so362835e9.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955907; x=1791560707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+I4t9viO/Urz7W8GjoAm6BBP/QuCZzvUO0dNV1Sy8FM=;
        b=E4VReeLycefPNhQ803uS0/gDXk7hq5EYzlHG9ChmZBJ5kWgPTDZfQV9PgBHbKzNRm6
         len2DahbQHHyrgnmSgWpgr90v+RLNBux0apXoL6I7E2E9wPElH2yaA8RMOSz5be5rfDN
         X98kFQENYwbuJKfUqiFjWcL/RnASHt2jXi9Y0fdwN6IwjWuJhw/FidqPWLnXTt0OkIUf
         I8BtnB53Pus7va0tMPxB6KHGZVE3vkuMl2/2h67i1r+rLqO3F8n/pcpubEN9rWMzldbI
         JGp+o30wUkihX7p1HJIUGha+Zheg9FmcR619Zks/mrkHxEa2wyub62N07xqmX+qhAZCr
         ny6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955907; x=1791560707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+I4t9viO/Urz7W8GjoAm6BBP/QuCZzvUO0dNV1Sy8FM=;
        b=urwKxiPb6lnyIcNtqeGngSKS4QshebQ7WS6NNAhx8q84uNixP4RVK5BtyMHlEW/pGn
         dKTpcQD6Ok9305geLZ+6pc2tbDhoWgLjoYhIkpbOxrCP1IRuBr80+EKc0C0kLbWCJYU+
         IfiXz/eLUTg6eApfUemCazHhr7ZA8xRCpugLzc16Jl3nPVgpaZ2BAo2yoxqWTioPwbx1
         gP+LHr7qWKfJWo6svG0G2sdIo0wHMtve2+vj3xYqeRCZu5Yo7ybniCceVMzIdkpyM1q1
         sK21p5Kc9m0l6XB4WhBUVGiqRvOJMOmzC37X15V95lId4KW9B+3Em1SGFmeuixwlgWrG
         Ex8g==
X-Forwarded-Encrypted: i=1; AKwUvBxtwmJuKW0unaJwl6Th902WfBPsV5BQ3N3xQM4CGM/mQLTxIzQt/OYuiLGhk22r450rajxdUYD6jA==@vger.kernel.org
X-Gm-Message-State: AFuF++mVMUjCCYBgmj549ILVGOv1qCRLTAfduCVANZyiFmqC6cUklMEI
	kB9rb0zh6M4Cr6rL5ArIgCEb3xx+xl8QHu1gQRRbL+SRVzaPcHmK7YkAkFQh5U/woMw=
X-Gm-Gg: AYBFou1nOX8ibFNUD2j7EZ21NZrmQqIBnVR3muV9ugf+eWMkHD1jYVhK1GSYtkcpJE8
	d2klW13yLtIu8nefSmXqEVi0TS1kBPNI2nhDKI89AH8dOu+4dQpwoAkmBBx4VCDkTQcsk+UZb6+
	vvYGfd4SUt1A/RJi/0nBhnWFCCIf+Utlj4cNXCTfuAU7mdc+bMbDJh4Axg/zHCYjFAuzy/Dd+k8
	cHWs8W1uAuFaIHm54lyqkLh0lBEEXUIqH8q52/JzJW8zi/dl7ci0iF1IAc/sngliz1azTalzmx9
	mCv06TsFBpkkluVhRe/m+ENab883dnHAVvPXl/0KSFZHw8qsSpCWRtZC6ZYdM0Xd/s+4FL00/Mg
	yG3HEtUkK/Hj1wqMkTd6+wogSaaGrGj7zPYl05+pyUqhJ+pp0GQF1JrPRWVnIDzycHrga8C5OUU
	oky0kqufIqMGT9BYVucC31Pdyj2To+ORIasnMMOR5rjLJ9+hYLURURUGEsfrT5xNH6DQ6BriKGs
	hRBTs4r5q1BdGq4
X-Received: by 2002:a05:600c:c16e:b0:49f:ffdc:939d with SMTP id 5b1f17b1804b1-4a02755fd8bmr52292735e9.9.1790955907438;
        Fri, 02 Oct 2026 08:45:07 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:06 -0700 (PDT)
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
Subject: [PATCH 04/18 v2] sched/eevdf: Compare min slice during wake_affine
Date: Fri,  2 Oct 2026 17:44:01 +0200
Message-ID: <20261002154415.2270586-5-vincent.guittot@linaro.org>
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

Add a new level in wake affine where we check on which CPU the task
would most probably run 1st between this and prev CPUs.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ad72b8536d6c..eeac0aaba3cd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8422,6 +8422,9 @@ static int wake_wide(struct task_struct *p)
  * wake_affine_idle() - only considers 'now', it check if the waking CPU is
  *			cache-affine and is (or	will be) idle.
  *
+ * wake_affine_slice() - only considers 'now', it check if the waking CPU can
+ *			 be preempted becaus using longerslice.
+ *
  * wake_affine_weight() - considers the weight to reflect the average
  *			  scheduling latency of the CPUs. This seems to work
  *			  for the overloaded case.
@@ -8457,6 +8460,20 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	return nr_cpumask_bits;
 }
 
+static int
+wake_affine_slice(struct task_struct *p, int this_cpu, int prev_cpu)
+{
+	struct sched_entity *se = &p->se;
+
+	if (se->slice < get_rq_min_slice(cpu_rq(prev_cpu)))
+		return prev_cpu;
+
+	if (se->slice < get_rq_min_slice(cpu_rq(this_cpu)))
+		return this_cpu;
+
+	return nr_cpumask_bits;
+}
+
 static int
 wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
 		   int this_cpu, int prev_cpu, int sync)
@@ -8508,6 +8525,9 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 	if (sched_feat(WA_IDLE))
 		target = wake_affine_idle(this_cpu, prev_cpu, sync);
 
+	if (sched_feat(PREEMPT_SHORT) && target == nr_cpumask_bits)
+		target = wake_affine_slice(p, this_cpu, prev_cpu);
+
 	if (sched_feat(WA_WEIGHT) && target == nr_cpumask_bits)
 		target = wake_affine_weight(sd, p, this_cpu, prev_cpu, sync);
 
-- 
2.53.0

