Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649166;
	b=kvDenH6p240TnXBUlB2P8VvWMaeZpI7ef4tF0GYfgvL46kkQaU2cBwb8lmEaflXs7EA2
	 CLMMpVGRYKuJi7cWuOXLsgwcn2SZealMczRaB+Pefg0/fVQZ70EdyNhOFls2QZY+frlhF
	 LwkS373fewO47o8dLVuXNhM+YdBqpvQoHqGEjKTca84MIafMYPY6dbKs+9VKwrFEPAdcJ
	 mlF2f62ONZW+3LtJNiKu2Mc18VHA75YhKSuAvSHtn+MvCmlyx1zHUt5ynfSIFyM71yDAD
	 hVTrJgcGFIdYLFbYvKCD/nJe5W/P2JDbQVfQdmv7o3YupVwes3Tj9zJaXVrfkui/aFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649166;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=H7LYOW6vZbnMx3LsrUUJ2jpsiL4+pnJKUDw/S3sy4dg=;
	b=utulo4jtax9/lbCmKYFC5jT7nBrBmGHoShB77xU9MZLdSoW06Dpl5iA/7i6IBAvE04AE
	 BNAVV+nhkHAg5TQvi6KKFGl76C3fGmXMUMIAJaP8dVKIsgLYLEpeuXu6ukj8/avhclT0X
	 tCm+tFdYGRAmmyGtDzy7bHWwLXlWmbxFW5I53jjL7BhZnci/sGeB9WTfOKlbN3BEXz9NA
	 t3yOj6Aie6WSDpvs5O99jVu6ymvstfMJ8wgP7ivdYoLToALFC7O3sa3srbWHrPuRJ3XBA
	 YxAoGqFep+tb/0omjBHu7ZA2536CpcoyuDPUm7/4sJSX23SafiJK5I6Q9dsAg+7PMwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+Q8Fe6U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC33606D807
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 19:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b+Q8Fe6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AB91F00A18;
	Mon,  2 Nov 2026 19:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649165;
	bh=H7LYOW6vZbnMx3LsrUUJ2jpsiL4+pnJKUDw/S3sy4dg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b+Q8Fe6U05w8mi4yxGxmgroTxKSnYRWcDi5vcZiOOeFs5nX51vAgKuGLEz73NrEhl
	 ER0kxys1VPDsXglXQl34JLnjTfieeLCYwk+tP8AUMxpxGIVgCQJkGTurdS2dwmIk3C
	 67eGZHWRFDJo1BnBirCgXMVk3irN6VdMaVZxdQ1va2MlzmUraKwa2ZXiKSyiLR3xXb
	 o31VmtUh60z7Xs/qThkwAZe5TgJfeb6I1KNZgk5U7pYp/akk4OP/Pp6xqr/TUvMl0A
	 j/MTFvElm3CP28nkLn2jZYaJed6M4PdxvaBsNwLtMtRgB3aU/AZQYD29a021+pwD2P
	 obtl26Q7cq5TQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject:
 [PATCH v1 2/4] cpufreq: Force passing target frequency to driver during
 resume
Date: Mon, 02 Nov 2026 20:50:11 +0100
Message-ID: <1991839.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <5162355.31r3eYUQgx@rafael.j.wysocki>
References: <5162355.31r3eYUQgx@rafael.j.wysocki>
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
control logic from being updated due to the target_freq == policy->cur
check in __cpufreq_driver_target() [1].

To address this, adjust the existing mechanism to force the
invocation of the driver callback in __cpufreq_driver_target()
and make cpufreq_resume_policy() use it.  Among other things,
this involves renaming update_limits in struct cpufreq_policy to
force_target and moving the driver CPUFREQ_NEED_UPDATE_LIMITS flag
check from __cpufreq_driver_target() to cpufreq_set_policy(), where
it is used as a condition for setting policy->force_target.

Fixes: 2f0aea936360 ("cpufreq: suspend governors on system suspend/hibernate")
Link: https://lore.kernel.org/linux-pm/20261027143725.3763827-1-zakbrightonknight@gmail.com/ [1]
Reported-by: Zak Brighton Knight <zakbrightonknight@gmail.com>
Reported-by: Doug Smythies <dsmythies@telus.net>
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c | 19 ++++++++++++++-----
 include/linux/cpufreq.h   |  4 ++--
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1c1962a4beb4..efa663b1456f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2011,6 +2011,13 @@ static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool start)
 	if (!start)
 		return;
 
+	/*
+	 * Force executing the driver callback in the next invocation of
+	 * __cpufreq_driver_target() in case policy->cur has become stale
+	 * while suspended.
+	 */
+	policy->force_target = true;
+
 	if (cpufreq_start_governor(policy))
 		pr_err("%s: Failed to start governor for CPU%u's policy\n",
 		       __func__, policy->cpu);
@@ -2397,11 +2404,10 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
 	 * calls.
 	 */
 	if (target_freq == policy->cur) {
-		if (!(cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS) ||
-		    !policy->update_limits)
+		if (!policy->force_target)
 			return 0;
 
-		policy->update_limits = false;
+		policy->force_target = false;
 	}
 
 	if (cpufreq_driver->target) {
@@ -2655,6 +2661,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      struct cpufreq_governor *new_gov,
 			      unsigned int new_pol)
 {
+	bool need_update_limits = cpufreq_driver->flags & CPUFREQ_NEED_UPDATE_LIMITS;
 	struct cpufreq_policy_data new_data;
 	struct cpufreq_governor *old_gov;
 	unsigned int freq;
@@ -2694,7 +2701,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 			      CPUFREQ_RELATION_H);
 	if (freq != policy->max) {
 		WRITE_ONCE(policy->max, freq);
-		policy->update_limits = true;
+		if (need_update_limits)
+			policy->force_target = true;
 	}
 
 	freq = __resolve_freq(policy, new_data.min, new_data.min, new_data.max,
@@ -2702,7 +2710,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	freq = min(freq, policy->max);
 	if (freq != policy->min) {
 		WRITE_ONCE(policy->min, freq);
-		policy->update_limits = true;
+		if (need_update_limits)
+			policy->force_target = true;
 	}
 
 	trace_cpu_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 20a6863b640a..be1eaa43aeb0 100644
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
-- 
2.51.0




