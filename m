Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367204F30D5
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955935; cv=none; b=eazIYQHRuH6MVWjq3FwjvkwFkulCKR9stOQr/3kHa+SUXM1CLu/hsrqaeE+2ljjUePwdpLfHNQPcJUTC6MunweiWc4NgVbYo+unnrurGH6ZcBaiUGQaZvKpkn2omShHNy1zl/Xq38T2Kygvc/e4K/iFwpIrerLvcH5YzKMDjSAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955935; c=relaxed/simple;
	bh=Lkq2thXBra+9jyaZNWFz8y5q88bfRFP5x4L8/XdL6qY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pyaSxWAGtdHVyB3IEWu7VVsmqLa/lX7a0Nm5frD9bV3sVF82rBv8BHCmrHw2PeIAX12zQfPhSHm7aleY3piNweW+nO3VP6iRv0w4+rqb1wzVyeKqE4d8gyFZspsx+zlVSXru8n3fLu1pmPZrBW26I1b9jYxcyKgLMs94DlenVpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y21N3SuB; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y21N3SuB"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a00713639cso340265e9.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955929; x=1791560729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
        b=Y21N3SuBGYYsFcZBa3CwfSEgUBGXst6qWulZGmb721PRcYeEn3x/ZjZxsMYrCTCc6F
         +caem5jICeN2eB8TN39xvX3uxbLUYnAPQ1OV/gatVJs+pr8ilg8Stl3+P0dZXrDRuWjO
         eua2nVm4X1lgC2lB0ZUBfdG2n667K5wADLMyVbLRfJFHkaxCEDP3XWRxsG/a0XQHnwOy
         qG/VEmDMIc52XN/l33KN7Kmeiirj5JAufjWpomhVQ/Bfc/ucN0AbE/ZQFLzp0L3u+q/l
         YhR4oFl4b0VyoQqAb2eDhHjpKKdkHGjfUn+LpBgfH+/U26Sncz26gcakwiwcCL570amK
         WLuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955929; x=1791560729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
        b=i8kouit0OLnspWsK9PyqaJfTmnvQsrFjPn4+L8Lgw9OoB6ceRFpi9aqlhSEtIPTfJR
         W+TIL4QMw4Z3olT9TiFCc9P50I+JOVTmRJfJAB7l91b+8YKlbilMlUxX2Q6TUnBbb8Yn
         TkqGnJD+1XVwy1RJIrLLhumAUHmL+tywfM5AmX4ca34ocVhiGZ3wLej6cXf+WNrwbVjw
         /dVM3EL+3Dk1queHXiYpx8sPutlM1uO5Z8Xn7ijEoCyUMSui9ohFJntKqnkWSm82Kfsz
         Vph7aT3wf/hYjw6aTJnZNA+ayZ6bHZngU4jidP4Mo95SuzHBxV5ZQL3KfkpZLCBjHsrp
         BKpw==
X-Forwarded-Encrypted: i=1; AKwUvBzXF6sbpF5qObea3Fc68XOGsmZjLHNXe1LQ8cnW585CpeAxXq0DJG6moxVb5DFS4xR/TSoEykvFvA==@vger.kernel.org
X-Gm-Message-State: AFuF++mopZ9EYTRTf30VnD5SlxnWi0aSas4XmPe01+F8ULqK791/Inc/
	ymCB+ug9mMo2Qeh6HSDkQMMwRgK53zMvQunElhCLuFqXSTeTLBhufTvYRGUVrof8VYg=
X-Gm-Gg: AYBFou3sHPn1bDtmOg6nixBGpiG+HmQMqwtXuDchuq39MA1orV+ZoDuydfmgbug51+C
	y6EEcYeZ7l4ooE/Ur+klLzTIE0Rwo8DIeWnlrFiCZWsL9SgW66fBTaoeHvQlGPWnKaRfzNaKAaF
	xy2CSSq98HQ+/AxaPw9JwerLVCgUO3rKyGqi4bv7DnGy5gpXM22xZXLkCd6mhAIPb4pAl3OTFW+
	O7FyjOUVLoUqhQBa1u1pFBeAaZhGq+xzE1t2Ss0bY+c9DLHqYyiSN02v5HZbaWlD0jEm90SMR7g
	4fV/d5Oqg8nX6e6HFHUpbzc5eC5lVxO6krOzf7McffV5erhyBTE3v+9Eq6DHv6IgrkaKuLEIgT7
	lXcfe/2JjRYikEwEdiJfjBXYpZWJMKJtINfI+ZR6pZRDgbw9sNXwTGG18P/4TF8U2GGjnmiIher
	HXCM8jLy6/SKHYrHjCWJBFegYLJOVRecBb2zvsrug9jd6fV1uTfKcLGZP1rndH4wWKH66DWo2jt
	TBBxS2jjsb74Qwn
X-Received: by 2002:a05:600c:19c8:b0:4a0:2540:b46 with SMTP id 5b1f17b1804b1-4a027559795mr67180475e9.12.1790955929334;
        Fri, 02 Oct 2026 08:45:29 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:28 -0700 (PDT)
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
Subject: [PATCH 17/18 v2] energy model: Remove unused em_cpu_energy()
Date: Fri,  2 Oct 2026 17:44:14 +0200
Message-ID: <20261002154415.2270586-18-vincent.guittot@linaro.org>
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

Remove the unused function em_cpu_energy()

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 97 ------------------------------------
 1 file changed, 97 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 89cf109cbca6..c4f9558b58d1 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -244,97 +244,6 @@ em_pd_get_previous_state(struct em_perf_state *table,
 	return -1;
 }
 
-/**
- * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
- *		performance domain
- * @pd		: performance domain for which energy has to be estimated
- * @max_util	: highest utilization among CPUs of the domain
- * @sum_util	: sum of the utilization of all CPUs in the domain
- * @allowed_cpu_cap	: maximum allowed CPU capacity for the @pd, which
- *			  might reflect reduced frequency (due to thermal)
- *
- * This function must be used only for CPU devices. There is no validation,
- * i.e. if the EM is a CPU type and has cpumask allocated. It is called from
- * the scheduler code quite frequently and that is why there is not checks.
- *
- * Return: the sum of the energy consumed by the CPUs of the domain assuming
- * a capacity state satisfying the max utilization of the domain.
- */
-static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-				unsigned long max_util, unsigned long sum_util,
-				unsigned long allowed_cpu_cap)
-{
-	struct em_perf_table *em_table;
-	struct em_perf_state *ps;
-	int i;
-
-	lockdep_assert(rcu_read_lock_any_held());
-
-	if (!sum_util)
-		return 0;
-
-	/*
-	 * In order to predict the performance state, map the utilization of
-	 * the most utilized CPU of the performance domain to a requested
-	 * performance, like schedutil. Take also into account that the real
-	 * performance might be set lower (due to thermal capping). Thus, clamp
-	 * max utilization to the allowed CPU capacity before calculating
-	 * effective performance.
-	 */
-	max_util = min(max_util, allowed_cpu_cap);
-
-	/*
-	 * Find the lowest performance state of the Energy Model above the
-	 * requested performance.
-	 */
-	em_table = rcu_dereference_all(pd->em_table);
-	i = em_pd_get_efficient_state(em_table->state, pd, max_util);
-	ps = &em_table->state[i];
-
-	/*
-	 * The performance (capacity) of a CPU in the domain at the performance
-	 * state (ps) can be computed as:
-	 *
-	 *                     ps->freq * scale_cpu
-	 *   ps->performance = --------------------                  (1)
-	 *                         cpu_max_freq
-	 *
-	 * So, ignoring the costs of idle states (which are not available in
-	 * the EM), the energy consumed by this CPU at that performance state
-	 * is estimated as:
-	 *
-	 *             ps->power * cpu_util
-	 *   cpu_nrg = --------------------                          (2)
-	 *               ps->performance
-	 *
-	 * since 'cpu_util / ps->performance' represents its percentage of busy
-	 * time.
-	 *
-	 *   NOTE: Although the result of this computation actually is in
-	 *         units of power, it can be manipulated as an energy value
-	 *         over a scheduling period, since it is assumed to be
-	 *         constant during that interval.
-	 *
-	 * By injecting (1) in (2), 'cpu_nrg' can be re-expressed as a product
-	 * of two terms:
-	 *
-	 *             ps->power * cpu_max_freq
-	 *   cpu_nrg = ------------------------ * cpu_util           (3)
-	 *               ps->freq * scale_cpu
-	 *
-	 * The first term is static, and is stored in the em_perf_state struct
-	 * as 'ps->cost'.
-	 *
-	 * Since all CPUs of the domain have the same micro-architecture, they
-	 * share the same 'ps->cost', and the same CPU capacity. Hence, the
-	 * total energy of the domain (which is the simple sum of the energy of
-	 * all of its CPUs) can be factorized as:
-	 *
-	 *   pd_nrg = ps->cost * \Sum cpu_util                       (4)
-	 */
-	return ps->cost * sum_util;
-}
-
 /**
  * em_pd_nr_perf_states() - Get the number of performance states of a perf.
  *				domain
@@ -407,12 +316,6 @@ em_pd_get_previous_state(struct em_perf_state *table,
 {
 	return -1;
 }
-static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
-			unsigned long max_util, unsigned long sum_util,
-			unsigned long allowed_cpu_cap)
-{
-	return 0;
-}
 static inline int em_pd_nr_perf_states(struct em_perf_domain *pd)
 {
 	return 0;
-- 
2.53.0

