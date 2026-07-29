Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA99451998;
	Wed, 29 Jul 2026 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350415; cv=none; b=CzhdYAAdOnxN/weuHkRIerN/DLTRfkEf0wBKHO0znWaHY8eYDKAqxVK+229rC0Dc3BLKm78RTu1FQksuW3AtJvNluauYTe7XwGZZ7Viht0O7z6+M/U6qxCkIylUJdImGnQ+0oIbBHU2mONwDiTN9PR8Ut93LaL4iiOvH39paYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350415; c=relaxed/simple;
	bh=37N/mRjik54MLq7pSe87pazmvervw8jaPQQtTqGyo0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMfHKw1xLyQ7uWilswBtV4JenwOLeY0ElF1LHz58yZYAiEV+KkpgExuoFbqFuZ/3VD8zrAJFuIjjz6rXItP6tSEosAF61B5k9zRVxQuItHS8qbbB0LNE+2d5Sc5HkDyJqx4/zkhyxw7Sl6L6vuH7duadr4O1R9EN5tSZuGkpQWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9uTx88o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9uTx88o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4F81F000E9;
	Wed, 29 Jul 2026 18:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785350413;
	bh=gdSZlcZLOrT3qLd/7Xc6VhHCdWDOoqN5SFhYE+390ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X9uTx88of3pNOkBye0J4bMIvkXzb14bxgNRlOeov8NwnqbLMrpv/9IGtkRBQvlaF2
	 UMW0NbL1J/1rOC+ytlAbhig7nnpmnUcNwun4uNeLACyFyeD0K4FfZ29m8JdTg56mXw
	 tgsZCJwfbFujJxGtAPVge4cjJMDNpl+q6dP+k64dOHoleY1LSq5K3DOtqkskgQtEQQ
	 gddFWvJMQo5D+9Dkd6tHUQOMEy2rTycSJFaeqN+KMr8MYTZfz02VjFcmq9P2lwaUY+
	 EEUM/s72j59qiRKhW4K3umBrsBtmC5LpvNVpF8ER5IADRjeD+TFBLiVYu7k/wtQZRn
	 qO0thK9BbmcuA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jing Wu <realwujing@gmail.com>, linux-pm@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, Doug Smythies <dsmythies@telus.net>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 linux-kernel@vger.kernel.org
Subject:
 [PATCH v1] cpufreq: intel_pstate: Adjust policy->cur in active mode to policy
Date: Wed, 29 Jul 2026 20:40:08 +0200
Message-ID: <5144014.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To:
 <20260729-bug-intel-pstate-policy-cur-v1-1-51f61e5cbd74@gmail.com>
References: <20260729-bug-intel-pstate-policy-cur-v1-1-51f61e5cbd74@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

On Wednesday, July 29, 2026 10:59:24 AM CEST Jing Wu wrote:
> When cpu->policy is CPUFREQ_POLICY_PERFORMANCE, intel_pstate_set_policy()
> pins the CPU to a fixed pstate (max(min_pstate, max_perf_ratio)) and
> programs it directly, precisely because, per the existing comment,
> "NOHZ_FULL CPUs need this as the governor callback may not be invoked
> on them". Two lines later it still unconditionally clobbers policy->cur
> down to policy->min, discarding the pinned value it just computed and
> applied.
> 
> arch_freq_get_on_cpu() falls back to cpufreq_quick_get(), i.e.
> policy->cur, whenever its APERF/MPERF sample goes stale. A CPU whose
> tick keeps running refreshes that sample constantly and rarely hits
> the fallback, but an isolated CPU covered by nohz_full with a single
> runnable task never gets another tick, so it permanently reports the
> floor through this fallback - even though it is genuinely pinned to,
> and running at, the frequency computed just above.
> 
> Set policy->cur to the exact pinned frequency (pstate * scaling) in
> the CPUFREQ_POLICY_PERFORMANCE branch instead, and only fall back to
> policy->min for the general case, where the frequency genuinely isn't
> known without a fresh sample.
> 
> Fixes: d51847acb018 ("cpufreq: intel_pstate: set stale CPU frequency to minimum")
> Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Signed-off-by: Jing Wu <realwujing@gmail.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 5a0eeb84d3821..b2c60c4931dcd 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -2908,8 +2908,23 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  		 */
>  		intel_pstate_clear_update_util_hook(policy->cpu);
>  		intel_pstate_set_pstate(cpu, pstate);
> +
> +		/*
> +		 * Report the exact pinned frequency instead of the floor:
> +		 * the CPU is pinned to pstate here and nothing else changes
> +		 * it, unlike the general case below.
> +		 */
> +		policy->cur = pstate * cpu->pstate.scaling;
>  	} else {
>  		intel_pstate_set_update_util_hook(policy->cpu);
> +
> +		/*
> +		 * Keep policy->cur within limits here: outside of the pinned
> +		 * CPUFREQ_POLICY_PERFORMANCE case above, it is never updated
> +		 * by the intel_pstate driver, but it is used as a stale
> +		 * frequency value.
> +		 */
> +		policy->cur = policy->min;
>  	}
>  
>  	if (hwp_active) {
> @@ -2922,11 +2937,6 @@ static int intel_pstate_set_policy(struct cpufreq_policy *policy)
>  			intel_pstate_clear_update_util_hook(policy->cpu);
>  		intel_pstate_hwp_set(policy->cpu);
>  	}
> -	/*
> -	 * policy->cur is never updated with the intel_pstate driver, but it
> -	 * is used as a stale frequency value. So, keep it within limits.
> -	 */
> -	policy->cur = policy->min;
>  
>  	mutex_unlock(&intel_pstate_limits_lock);
>  
> 
> ---

Good idea overall, but it takes a bit more to do this.  In particular, the HWP
case needs some more care.

Also, I don't think that this really is a fix.  The code works as intended,
although what it does is sometimes confusing.

Below is my version of this change (on top of linux-next), please let me know
if it works for you.

Thanks!

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] cpufreq: intel_pstate: Adjust policy->cur in active mode to policy

Since arch_freq_get_on_cpu() on x86 falls back to cpufreq_quick_get(),
which effectively causes policy->cur to be returned when intel_pstate
is used, adjust intel_pstate_set_policy() to set policy->cur to reflect
the P-state that is actually going to be requested in the "performance"
policy case instead of setting it to policy->min (which is confusing
because it causes scaling_cur_freq to show the minimum frequency while
the CPU is likely running at the maximum one).

For this purpose, rearrange intel_pstate_set_policy() to handle the HWP
case separately, to avoid calling intel_pstate_set_pstate() pointlessly
with HWP enabled, and use the observation that with HWP enabled in the
active mode, the utilization update hook is only needed when HWP boost
is used and the policy is not "performance".

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2870,6 +2870,7 @@ static void intel_pstate_set_pstate(stru
 
 static int intel_pstate_set_policy(struct cpufreq_policy *policy)
 {
+	unsigned int freq = policy->min;
 	struct cpudata *cpu;
 
 	if (!policy->cpuinfo.max_freq)
@@ -2885,7 +2886,23 @@ static int intel_pstate_set_policy(struc
 
 	intel_pstate_update_perf_limits(cpu, policy->min, policy->max);
 
-	if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
+	if (hwp_active) {
+		/*
+		 * The active mode only requires an update util hook if HWP
+		 * boost is used and the policy is not "performance".
+		 */
+		if (hwp_boost && cpu->policy != CPUFREQ_POLICY_PERFORMANCE) {
+			intel_pstate_set_update_util_hook(policy->cpu);
+		} else {
+			intel_pstate_clear_update_util_hook(policy->cpu);
+			if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
+				freq = cpu->max_perf_ratio * cpu->pstate.scaling;
+				if (cpu->pstate.scaling != cpu->pstate.perf_ctl_scaling)
+					freq = rounddown(freq, cpu->pstate.perf_ctl_scaling);
+			}
+		}
+		intel_pstate_hwp_set(policy->cpu);
+	} else if (cpu->policy == CPUFREQ_POLICY_PERFORMANCE) {
 		int pstate = max(cpu->pstate.min_pstate, cpu->max_perf_ratio);
 
 		/*
@@ -2894,25 +2910,17 @@ static int intel_pstate_set_policy(struc
 		 */
 		intel_pstate_clear_update_util_hook(policy->cpu);
 		intel_pstate_set_pstate(cpu, pstate);
+		freq = pstate * cpu->pstate.scaling;
 	} else {
 		intel_pstate_set_update_util_hook(policy->cpu);
 	}
-
-	if (hwp_active) {
-		/*
-		 * When hwp_boost was active before and dynamically it
-		 * was turned off, in that case we need to clear the
-		 * update util hook.
-		 */
-		if (!hwp_boost)
-			intel_pstate_clear_update_util_hook(policy->cpu);
-		intel_pstate_hwp_set(policy->cpu);
-	}
 	/*
-	 * policy->cur is never updated with the intel_pstate driver, but it
-	 * is used as a stale frequency value. So, keep it within limits.
+	 * policy->cur is never updated in the intel_pstate driver, but it is
+	 * used as a stale frequency value, so set it to reflect the actual
+	 * requested P-state in the "performance" policy case and to the min
+	 * otherwise.
 	 */
-	policy->cur = policy->min;
+	policy->cur = freq;
 
 	mutex_unlock(&intel_pstate_limits_lock);
 



