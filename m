Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977526;
	b=vIMSd+x00t8k4jFURaQHw0i4u/boNDB25O+PDkZSLdv4hIBGMk+OWK5JotDunB5ifOpm
	 LX9P/wcCROEprWebb382PiR2fh67WyXe69RmX5gO9r8ay9jyLNO7YuDmj3RVwuK875l5I
	 CIH9B/1b+oS0Z62t6DeMWU79Be5GObONkr/DvGZnKzUKgJ5u6QdoqoOVO/8uJIfTFZW7B
	 U+7po6wjUQ0f+cd6nIZgSFjE7w/nR68qIssKRNwMxcqN057jS6Ef0bfuCWDJtHs3RyJK7
	 hG84Agb7OXkU0Zx85OHfjlnHKPURvP7qgl3V2vHg5as7bKJnIzjyTpB0OBlBgT9DlnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=kgWH+ZaY7YxlLwuecxh9TBeKb0KjZCnaIXv+R7Uat6k=;
	b=gxv1h0eA9ZHtNC+570FCt+cfjDY9MYwGb0enYSQmvcesHmKybxVplmsNPYkEkrHjlnRl
	 dI1woeh97ZfBhApYTITvQSuVbJWliPeAozuX4GjktaqdDodntHLY875EVpfCGhZlxZ9bl
	 iIOV7rRxWltaU9xUDjmwY2qyL1FlVu4xCVNJ1mL6b0Xih3nllAWKrEXR9Z3n/IpCbpg7T
	 IvQepq0mK4z6roymihmP+GrDV+KBRAjSPuEr4FaCwpntR0qtIo369VxEaVW+ZhOSmDnFu
	 i6N3drrmS44myWSELbkm003zqJRtGncX6oAwFtKjl/BYehMJFrxJXGkk08FmXgOTo0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqeiG6q5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AE606D822;
	Fri,  6 Nov 2026 15:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KqeiG6q5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C8C1F008A2;
	Fri,  6 Nov 2026 15:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977526;
	bh=kgWH+ZaY7YxlLwuecxh9TBeKb0KjZCnaIXv+R7Uat6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KqeiG6q54+X2K0PAKzSxquCv03mcgDUWo8m+5GvmhY/+l/M8miW6/I17G+gpZgXoX
	 aza4iFS6/D98m0dTbtoidRWsj0SAeu1UWJHKJ0pShP1t6WGZUfWRSSkaaUw3dvSKjI
	 KxDFm/O9s7fBDT72pF2FvvaPOZ75smM9LAnOmog/Dy4eLvvKmgP5uDFfA7ybBW2TLv
	 c55KwiV4IbFh3o6rSDaB8hNyujJbPWwB54MckSfiaDikyKcuHd0eQ2pkJHyFCRO0hj
	 XYk2huni3KaemjI0lLYB8JyJlmhbc/ZL2hO0a3pHpDeMiFfY6+pAIxxJDiOUNphEOt
	 CD2rc87NoungA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Vincent Donnefort <vincent.donnefort@arm.com>
Subject:
 [PATCH v1 2/2] cpufreq: Fix updates of cached resolved frequency and index
Date: Fri, 06 Nov 2026 16:05:06 +0100
Message-ID: <3472677.aeNJFYEL58@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5176274.31r3eYUQgx@rafael.j.wysocki>
References: <5176274.31r3eYUQgx@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

The cached resolved frequency and index, cached_target_freq and
cached_resolved_idx, respectively, may be updated concurrently if
cpufreq_driver_resolve_freq() is called by the schedutil governor
while cpufreq_set_policy() is running for the same policy.  Those
concurrent updates are not synchronized in any way and the values
written by cpufreq_set_policy(), if it wins the race, may confuse
drivers using those policy fields [1].

To address this, use the observation that the only place where
cached_target_freq and cached_resolved_idx need to be updated is
cpufreq_driver_resolve_freq() because the only legitimate users of
them are .fast_switch() driver callbacks.  Although cached_resolved_idx
is also used in __cpufreq_driver_target(), that is in fact unnecessary
and it is better to use a local variable for storing the frequency
table index in that function.

Accordingly, rearrange __resolve_freq() and its callers so that
cached_target_freq and cached_resolved_idx are only updated in
cpufreq_driver_resolve_freq().

The cached_target_freq initialization in cpufreq_set_policy() is still
needed, but move it after stopping the old governor and before starting
the new one to avoid racing with cpufreq_driver_resolve_freq().

Fixes: f9ccdec24d91 ("cpufreq: Reuse cpufreq_driver_resolve_freq() in __cpufreq_driver_target()")
Fixes: 151717690694 ("cpufreq: Make policy min/max hard requirements")
Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Closes: https://lore.kernel.org/linux-pm/20261105140357.1331894-1-zhongqiu.han@oss.qualcomm.com/ [1]
Co-developed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c |   31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -477,7 +477,7 @@ EXPORT_SYMBOL_GPL(cpufreq_disable_fast_s
 static unsigned int __resolve_freq(struct cpufreq_policy *policy,
 				   unsigned int target_freq,
 				   unsigned int min, unsigned int max,
-				   unsigned int relation)
+				   unsigned int relation, unsigned int *idx_p)
 {
 	unsigned int idx;
 
@@ -487,9 +487,10 @@ static unsigned int __resolve_freq(struc
 		return target_freq;
 
 	idx = cpufreq_frequency_table_target(policy, target_freq, min, max, relation);
-	policy->cached_resolved_idx = idx;
-	policy->cached_target_freq = policy->freq_table[idx].frequency;
-	return policy->cached_target_freq;
+	if (idx_p)
+		*idx_p = idx;
+
+	return policy->freq_table[idx].frequency;
 }
 
 /**
@@ -520,7 +521,10 @@ unsigned int cpufreq_driver_resolve_freq
 	if (unlikely(min > max))
 		min = max;
 
-	return __resolve_freq(policy, target_freq, min, max, CPUFREQ_RELATION_LE);
+	policy->cached_target_freq = __resolve_freq(policy, target_freq, min, max,
+						    CPUFREQ_RELATION_LE,
+						    &policy->cached_resolved_idx);
+	return policy->cached_target_freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);
 
@@ -2398,12 +2402,13 @@ int __cpufreq_driver_target(struct cpufr
 			    unsigned int relation)
 {
 	unsigned int old_target_freq = target_freq;
+	unsigned int idx = 0;
 
 	if (cpufreq_disabled())
 		return -ENODEV;
 
 	target_freq = __resolve_freq(policy, target_freq, policy->min,
-				     policy->max, relation);
+				     policy->max, relation, &idx);
 
 	pr_debug("CPU %u: cur %u kHz -> target %u kHz (req %u kHz, rel %u)\n",
 		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
@@ -2433,7 +2438,7 @@ int __cpufreq_driver_target(struct cpufr
 	if (!cpufreq_driver->target_index)
 		return -EINVAL;
 
-	return __target_index(policy, policy->cached_resolved_idx);
+	return __target_index(policy, idx);
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
@@ -2712,7 +2717,7 @@ static int cpufreq_set_policy(struct cpu
 	 * concurrently by cpufreq_driver_resolve_freq() during the update.
 	 */
 	freq = __resolve_freq(policy, new_data.max, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_H);
+			      CPUFREQ_RELATION_H, NULL);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
 		if (need_update_limits)
@@ -2720,7 +2725,7 @@ static int cpufreq_set_policy(struct cpu
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
-			      CPUFREQ_RELATION_L);
+			      CPUFREQ_RELATION_L, NULL);
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
@@ -2732,8 +2737,6 @@ static int cpufreq_set_policy(struct cpu
 
 	cpufreq_update_pressure(policy);
 
-	policy->cached_target_freq = UINT_MAX;
-
 	pr_debug("new min and max freqs are %u - %u kHz\n",
 		 policy->min, policy->max);
 
@@ -2759,6 +2762,12 @@ static int cpufreq_set_policy(struct cpu
 		cpufreq_exit_governor(policy);
 	}
 
+	/*
+	 * Initialize cached_target_freq while no governor is running to avoid
+	 * racing with cpufreq_driver_resolve_freq(), which updates it.
+	 */
+	policy->cached_target_freq = UINT_MAX;
+
 	/* start new governor */
 	policy->governor = new_gov;
 	ret = cpufreq_init_governor(policy);



