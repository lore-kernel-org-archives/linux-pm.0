Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978425;
	b=YsAVgfbnwrqWRdwyVgGtfeKVtNG3e+xM+CHta3wIkCY7odHLVwoXz5NIxPsway3oi2ue
	 dgKQBy8e8lJ25mksDrHGhrtLvW3PNkkaCCXsAVsJNSYTGYVBdbQnI88tUiv9Cr6/b2tnN
	 P57ATtMV5FC7uLpkpCVRP1GmPcHIjbkx3yWlfBiSnmmCDxKJ6FDvKFFwTU0KEKF5gXtrW
	 osH7Uhx3pI1+AMebdPmKG60GN97otw7vHh+2RRVQwzzld7ZB+uis/BSAQRfigTyUt0j9w
	 04WAOO07CfUDyR9qn9Q+1GUelN96LNg93I30x0Ha6dZgacN/HK0nATUoseBBD3c6eVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978425;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
	b=zdh1wSCKHpMMiph50UF2+674y8QTwIbql9/TQkUhOyDWT4DYPZ2K6eQHYeAv0wWj5Z5q
	 c/itLVEw2eDnO5/Vib8QvQBnNSq5toVoJ3zmk2o9pQMowUG93P6OA8bnRAwIYfHvmYkWt
	 x5pFk3cYzbnqB02hkEvQRii3z/DqVm3AjKuQOhas35lq7qWY4eOxJidjIMgE65jDZf0Fa
	 6wFqMGFGytFycdl4SedHAq6EM4jC3RZtqR4O57IN2Lsa4ygkLskcGKzo+In2kklFVjdh4
	 bqQz2KqZulWpf+jj3VEnNy68lRECohXOwHImyiUQa6w22+nWoe5w9/0VVYKMlNMZRlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CgcwZkLT;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83376083617
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E83376083617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CgcwZkLT
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e09aa5264so428796f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978423; x=1794583223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
        b=CgcwZkLTdJjTamyQPWN3H3LGgBGtJcrCenPRp9EWTeGzgs1B+CfX0P/y6VwDJChjBS
         lqIHhFuYol0h5rY581aHbOm55F8idncc2Q8hSqXmf3bTQGjREg6zkY0dBEK20zUNqYml
         a9Y+JuIE02bs36jTeo4OGb4iptafjfp8f/ZZgsbdGrtC0FN5DV0QNQo1hC7TLLwH5wda
         vNt182UXZYAPtTiFrcK0MqfYC2w907Ni2OmIDw8nxTUOwB9F1DM58BUYMOWGRO2WULH/
         M4+a/XkMlY4dYX8HbSi22esxPHlcOtF2U06U4rJE5rDzTA3+4L+jHv/6MNkjg1gXTibx
         XsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978423; x=1794583223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1AczkvEVMwyiADmz9Aen/RP9scTy6HPzxTwLuS0NkCE=;
        b=W9BkD63+Dv84BYXtzIBa+2bPjBuzOqc9TMdmWATUm8Td2qSdDtazbk3uc00N+N9jyr
         GsVXVGyzzjH8bRzovFpbwdNtP1hTt7IOCz4sH0Ba1ChGI1WVZh9fgznyYin5YJFL8DSY
         lTSRn2TysYizQLLW7feSEScCzCkU15B5p6hYtXZFrrCbm+R+GuS0rtQSQcZ5xqa2D4py
         zTEHgq+qu1S8tBSq5VdmIFdqqncuGlAbNWJF/HWhenYQc1cjJtIEdnAXz5bSTnY/rXfb
         7BeEbLMbjlxJFFfTTMSfWlykqRhadtOfdp5Q3wsJ3ZkjtLl3kj5rq1O6avHQLwTKhHV4
         bg9A==
X-Forwarded-Encrypted: i=1; AKwUvBxHb8l7vOId3Iyq/ch/R/6JV3zAgNdG6pzKpHz2SWc+2iQaqSDGtD7i+en4U5hywr/SRwuzRD/MjA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/smf/MySSlxcVsfUzFEvaM+n1QPHygOHhPAIkr0fLXZRkpL6pE
	nSRfMqmry8S7BdqcyU8tYRbyBVW5thbelH84y8ac3VlG02RkJyi1S3kIgpb5z+sr37g=
X-Gm-Gg: AYBFou3GOeOv2qI1rfRYeHsw8r2PtqfYHQVEugdaxTsgwf6Dm3QiiRoteeSOOIhcfen
	Wm1xqTeaGaI51N7GCiz71vRj7LoM4eqNo5HLQFKlEBGay0VpAk+DVGcM2lFjyE+3VxQH+amfbwo
	epSgxzWQuuXTFFGEsLHcdCUBKv68Md6ek8H6gaqF6SZtMTmS38kqCbPKfiDT3ueEKkmrHDp7Vgs
	Y5ULB9EkxoaVwlBOIm2mvzSP5V58c1AQJopEsPTqhKYiIpbNCOyFb/HNX14284gVAsEDrz02CWn
	V/msKXNz/y4CCWJVkLDnrVvjGgpyq8XW9ktShG45+G7zgd2/CHq0LPgVq1sOJMNtge0Y+LNYe2J
	00DJYW0APv4a6O/wMyv6LaQ1vtuRimj3ManBeyhBnsQPXxUOR3LbNHM1rInQupSxab8SCrzeyk/
	2L+wON5eqXI+UJ8bkFsQ76t5wKzL9X1ygPdKRNHXkHbxfUxE3gzCTz0l5yDy//ccxI5eyeaFltw
	uZbz9V0hQ7+4RCO7Nf8KlzYCaycvLNFREAoouQoXS2bKdfRgvf1tVgE2qwLjIMxRKO7sGtXG2cd
	hhELiDyDQDO8p4SLMTk8ICj8jxYmRLM/yAY6NtT/l7Y4qde2e+wXqoqVDSzt5UIexjWP
X-Received: by 2002:a05:600c:c491:b0:4a4:de70:2ad4 with SMTP id 5b1f17b1804b1-4b6dff83dc4mr53929695e9.22.1793978423274;
        Fri, 06 Nov 2026 07:20:23 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:22 -0800 (PST)
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
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 18/20 v3] energy model: Remove unused em_cpu_energy()
Date: Fri,  6 Nov 2026 16:19:45 +0100
Message-ID: <20261106151947.3991524-19-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
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

