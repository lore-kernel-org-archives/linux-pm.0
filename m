Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735385;
	b=IisT2fCBQFpxJGxEJQtzFlG0qb9tPXFxxLnwO+lrxDBGekAMdUMhuiWVlPEcfuHmPg0U
	 I+AE4viZPEge4XarnKL8NubnDXhvzTGhUi6YX0f6X026ImYnZGv+hmWgDW5rgLebw9ek8
	 WN+MV4bVqypXpjaLo1/NLjS0hHnNo1GYNZNoYHV8Z6brgS9j575aIBEjtYoFWyF4LAO4o
	 e0XYZGfzobTBoGEzZUCnm7w+iFhK/jTBBRtARLlTqNmKCnlcZCNfH+UIECMex6b3LT32d
	 RhOWZ5sI6X5yw9euRx+t1BS0n0vYnNUi6qr07i4QdT02qLJ6MliGHwFE6w5/HZSM2QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=TlLk2cJttZ2B2ugaVdz1VHE9EAUZdYiQ7Asgx+qQUvY=;
	b=HRFCoTUOp3aTGc8cKy3oZJ5zaHHQAKOSc6BqhaoB6T+mBwcXn4tbMfexFdnhZ2GdNGXv
	 0r1s4yxfw8rVfYBZ8Rn8gcEgU/ZcgfqspANZgxWS/DMLVVN2ygFm2o/0LogJCoR3qRG/L
	 OSvwrOzSk1dnJyVYIU1HY0HXHaGamAVQZCoIPc72PnxFb1+YFG7EvCNi2DJBw0GkbC7Ce
	 P4lFSg+lk2f0lg4pSg8v8PfZsw00hHadR/WwNb1RS+XF5M36KGwSnc9vOMe6lWRpZ6R7d
	 grnaBy2/T8KqKPwuMtOrcY3F0QeLsBmd3iJrrScqH3XHnWMxLUXdlo1dM0wULMGTQHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMEvNORw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFD2606A32E
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 19:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZMEvNORw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829F61F00A16;
	Tue,  3 Nov 2026 19:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735385;
	bh=TlLk2cJttZ2B2ugaVdz1VHE9EAUZdYiQ7Asgx+qQUvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMEvNORw2GAkshLjJ6Y7+MeRmtl1Rp/LiD3ZqKNRp8oL7eR/FmTnmvBDBcLZEZB55
	 aNuFqmi/ShVF1F8gS6c3UOANd4DtwiRi/FvtTHSRXnwDWbkvJ8ID5Z240vP58peOct
	 P5mjjF2bUlwbM/VDIsOZFsrTEWZbnQJU2PDwGPajf/W4SugIMZPxgnBmPUi8LFBNeN
	 Vp5ea6GuRa9lZCVnZ4o5jv7SB43nFternsyC2TIvQ6/v/bUgG5U0rcUZtRnASP6YuJ
	 Ob08b1j8ZhHvBqypzzwMwunroUNopEp/ajx2+Hhf4Awr1q6YLzuXUno0TWvRcEfkk0
	 oq4Hh5L9vIvAA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v2 2/3] cpufreq: Force passing target frequency to driver during
 resume
Date: Tue, 03 Nov 2026 20:47:48 +0100
Message-ID: <1995295.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <6065833.DvuYhMxLoT@rafael.j.wysocki>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
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

The policy->cur value preserved across a system suspend-resume cycle
may become stale in some cases and it may prevent the CPU performance
scaling logic from being updated due to the target_freq == policy->cur
check in __cpufreq_driver_target() [1].

To address this, adjust the existing mechanism to force the invocation
of the driver .target() callback in __cpufreq_driver_target() and make
cpufreq_resume_policy() use it.

This involves renaming update_limits in struct cpufreq_policy to
force_target and moving the driver CPUFREQ_NEED_UPDATE_LIMITS flag check
from __cpufreq_driver_target() to cpufreq_set_policy(), where it is used
as a condition for setting policy->force_target.

In cpufreq_resume_policy(), policy->force_target is set for drivers that
implement the .target() callback, but don't implement the .get() one,
which is the case when the driver callback needs to run if policy->cur
becomes stale while suspended.

Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/ [1]
Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reported-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Always clear policy->force_target if set in __cpufreq_driver_target()
     to avoid forcing the driver callback next time unnecessarily (Sashiko)

   * Replace an outdated comment in __cpufreq_driver_target()

   * Set policy->force_target only if .target() is present and .get() is not
     present because that is the only case in which it may matter

   * Update changelog

---
 drivers/cpufreq/cpufreq.c |   33 +++++++++++++++++++++------------
 include/linux/cpufreq.h   |    4 ++--
 2 files changed, 23 insertions(+), 14 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2023,6 +2023,15 @@ static void cpufreq_resume_policy(struct
 	if (!start)
 		return;
 
+	/*
+	 * Force executing the driver .target() callback, if present, in the
+	 * next invocation of __cpufreq_driver_target() in case policy->cur has
+	 * become stale while suspended, but do it only for drivers without a
+	 * .get() callback for which cpufreq_verify_current_freq() is a NOP.
+	 */
+	if (cpufreq_driver->target && !cpufreq_driver->get)
+		policy->force_target = true;
+
 	if (cpufreq_start_governor(policy))
 		pr_err("%s: Failed to start governor for CPU%u's policy\n",
 		       __func__, policy->cpu);
@@ -2400,17 +2409,14 @@ int __cpufreq_driver_target(struct cpufr
 		policy->cpu, policy->cur, target_freq, old_target_freq, relation);
 
 	/*
-	 * This might look like a redundant call as we are checking it again
-	 * after finding index. But it is left intentionally for cases where
-	 * exactly same freq is called again and so we can save on few function
-	 * calls.
+	 * Unless invoking the target callback is forced, skip the update if the
+	 * frequency is not really changing.
 	 */
-	if (target_freq == policy->cur) {
-		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
-		    !policy->update_limits)
-			return 0;
-
-		policy->update_limits = false;
+	if (policy->force_target) {
+		/* Avoid forcing the driver callback unnecessarily next time. */
+		policy->force_target = false;
+	} else if (target_freq == policy->cur) {
+		return 0;
 	}
 
 	if (cpufreq_driver->target) {
@@ -2669,6 +2675,7 @@ static int cpufreq_set_policy(struct cpu
 			      struct cpufreq_governor *new_gov,
 			      unsigned int new_pol)
 {
+	bool need_update_limits = cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS;
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
 	unsigned int freq;
@@ -2708,7 +2715,8 @@ static int cpufreq_set_policy(struct cpu
 			      CPUFREQ_RELATION_H);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
-		policy->update_limits = true;
+		if (need_update_limits)
+			policy->force_target = true;
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
@@ -2716,7 +2724,8 @@ static int cpufreq_set_policy(struct cpu
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
-		policy->update_limits = true;
+		if (need_update_limits)
+			policy->force_target = true;
 	}
 
 	trace_cpu_frequency_limits(policy);
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -146,8 +146,8 @@ struct cpufreq_policy {
 	/* Per policy boost supported flag. */
 	bool			boost_supported;
 
-	/* Pending policy->min/max update for the driver */
-	bool			update_limits;
+	/* Force passing target frequency to the driver. */
+	bool			force_target;
 
 	/* The policy has been suspended. */
 	bool			suspended;



