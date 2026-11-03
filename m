Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735391;
	b=gnVzc+pEXvJwlfFpTElENqLBu/bNaZVglKDf+e3RS7DmbLmnEZB0XHLcVBYJZWtvxYDm
	 jBx/6Yj8fsGfrOjcRm7hg/xU5A20FDUPF28+c0pz514WCE4xO7MXzUUS2NOi/XxjcB1Ep
	 vxzVVCVt8aO53YMD4/mnbaretfN+tWM7Dh305SyjoMQsRSFxucejb9utBroYq/JIJGLDc
	 3YT54Mu9ZvFby2Ns642eYQ50nOzrfJtEM6eEbod7DJGxvEPHZmW4Y6OLA72WjytAhAJv+
	 VPk+VbgjBbddEOWSKiJlreFM01HABaRiLlv2kWSZwvGg6PujKdJSzcP1iU4DFbaKyVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735391;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=tw/Q+3p76f6puc1Xj/3FP5Ba2tRzI6xmcfUfz/rM498=;
	b=GXaGqwYhgJN8zNMBO20LQQgeJ9JAEl72GMFNSWhUhpdx4AU5vf49DmnyiCAD7oPYFrg7
	 mUC5M8YJeokXlBIZJed0PHV0pIkiQZB1PSmZSsscvWSCVj4RGDMJm22Evgxcy2M22Vdwy
	 uUOlLUAXx94Vy9kDGjIflg4VW6SxsThQAItV6/BMhBGQEwGY/gFoORhktE68H/oMXpbsG
	 WYv71Nm5GPrwrZp6MRYuLfsNSJSBsnsjdD9YQ7/fp5hrY5kS1QrK4pMPC6s6rzSqYX2j/
	 g/bDlJ7Ka+eG3OgqBrpCSQ6Oq2uPrr1PCpZm74KswQR1uSy2tZxqee2n3kHI4/LS1Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ER9aFe+j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E2B606A334
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 19:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ER9aFe+j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EDC1F00919;
	Tue,  3 Nov 2026 19:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735390;
	bh=tw/Q+3p76f6puc1Xj/3FP5Ba2tRzI6xmcfUfz/rM498=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ER9aFe+j3mwDTqLAv+dBaPwUFxdp3uc9ZGd7x7pITeBbqq4P16uVJflnXLyjOxaRS
	 5ri2gNdjTT5E/0ohNWqLT0M37kFFqyD9nGd+jzCCuzZ3oedyIhwrZjQP5EYn/YmmA4
	 IEFDWPIamp2bftNmrNBxx1pr7GzY5P+MiD8+VzPUbhDSFtgO4TfPoCWMdCMZnECPa/
	 XNqL4o2dLgEsEfNALRrDKSUHRWWi6jwn8QIRtHwQCl72Xpn08DcTX0zSE0rkMOMKUy
	 3vubIlQkh3blTvZBvym6Gk+gMJsBNk2a9Y3to6mxbT8QwCIO+TT80A6P75PVvwCR9S
	 oZ8Zw18/TVvBQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v2 1/3] cpufreq: Improve suspend-resume synchronization
Date: Tue, 03 Nov 2026 20:45:38 +0100
Message-ID: <4796894.LvFx2qVVIh@rafael.j.wysocki>
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

The suspend-resume synchronization in the cpufreq core is not perfect
because the global cpufreq_suspended variable is set at the end of
cpufreq_suspend() after stopping governors for all of the active
policies, so the governor .limits() callback may run via
cpufreq_governor_limits() after stopping the governor and before
setting cpufreq_suspended which is questionable.  Likewise, the
governor .limits() callback may run between clearing cpufreq_suspended
in cpufreq_resume() and starting the governor.

Address this by adding a per-policy "suspended" flag that is always
read under the policy rwsem and is updated under it when the governor
is stopped in cpufreq_suspend() and when the governor is restarted in
cpufreq_resume().

Also make cpufreq_resume() use the cpus_read_lock guard to reflect
what is done in cpufreq_suspend() and call cpufreq_exit_governor() for
policies that were suspended during a system suspend transition and
are inactive during the subsequent system resume (to avoid leaking an
inactive policy with a stopped governor that has not exited yet).

Fixes: 8e30444e1530 ("cpufreq: fix cpufreq suspend/resume for intel_pstate")
Fixes: b1b12babe3b7 ("cpufreq: update 'cpufreq_suspended' after stopping governors")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Retain all of the cpufreq_suspended checks to avoid carrying out
     governor operations after suspending cpufreq during system
     shutdown and during hibernation resume on systems with SMT (Sashiko)

   * Rearrange cpufreq_resume() to walk all cpufreq policies and call
     cpufreq_resume_policy() for all of them

   * Call cpufreq_exit_governor() in cpufreq_resume_policy() for
     policies that were suspended during a system suspend transition and
     are inactive during the subsequent system resume (Sashiko)

   * Update cpufreq_suspended under cpus_read_lock in cpufreq_resume()
     for more symmetry with cpufreq_suspend()

   * Update changelog

---
 drivers/cpufreq/cpufreq.c |   86 +++++++++++++++++++++++++++++++++-------------
 include/linux/cpufreq.h   |    3 +
 2 files changed, 66 insertions(+), 23 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -35,6 +35,9 @@
 static LIST_HEAD(cpufreq_policy_list);
 
 /* Macros to iterate over CPU policies */
+#define for_each_policy(__policy)	\
+	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list)
+
 #define for_each_suitable_policy(__policy, __active)			 \
 	list_for_each_entry(__policy, &cpufreq_policy_list, policy_list) \
 		if ((__active) == !policy_is_inactive(__policy))
@@ -1956,6 +1959,14 @@ int cpufreq_generic_suspend(struct cpufr
 }
 EXPORT_SYMBOL(cpufreq_generic_suspend);
 
+static void cpufreq_suspend_policy(struct cpufreq_policy *policy)
+{
+	guard(cpufreq_policy_write)(policy);
+
+	cpufreq_stop_governor(policy);
+	policy->suspended = true;
+}
+
 /**
  * cpufreq_suspend() - Suspend CPUFreq governors.
  *
@@ -1978,11 +1989,8 @@ void cpufreq_suspend(void)
 	pr_debug("%s: Suspending Governors\n", __func__);
 
 	for_each_active_policy(policy) {
-		if (has_target()) {
-			scoped_guard(cpufreq_policy_write, policy) {
-				cpufreq_stop_governor(policy);
-			}
-		}
+		if (has_target())
+			cpufreq_suspend_policy(policy);
 
 		if (cpufreq_driver->suspend && cpufreq_driver->suspend(policy))
 			pr_err("%s: Failed to suspend driver: %s\n", __func__,
@@ -1994,6 +2002,32 @@ suspend:
 	cpus_read_unlock();
 }
 
+static void cpufreq_resume_policy(struct cpufreq_policy *policy, bool start)
+{
+	guard(cpufreq_policy_write)(policy);
+
+	if (!policy->suspended)
+		return;
+
+	policy->suspended = false;
+
+	if (policy_is_inactive(policy)) {
+		/*
+		 * The policy was active when it was suspended, so its governor
+		 * is still there.  Let the governor go.
+		 */
+		cpufreq_exit_governor(policy);
+		return;
+	}
+
+	if (!start)
+		return;
+
+	if (cpufreq_start_governor(policy))
+		pr_err("%s: Failed to start governor for CPU%u's policy\n",
+		       __func__, policy->cpu);
+}
+
 /**
  * cpufreq_resume() - Resume CPUFreq governors.
  *
@@ -2003,11 +2037,12 @@ suspend:
 void cpufreq_resume(void)
 {
 	struct cpufreq_policy *policy;
-	int ret;
 
 	if (!cpufreq_driver)
 		return;
 
+	guard(cpus_read_lock)();
+
 	if (unlikely(!cpufreq_suspended))
 		return;
 
@@ -2018,19 +2053,18 @@ void cpufreq_resume(void)
 
 	pr_debug("%s: Resuming Governors\n", __func__);
 
-	for_each_active_policy(policy) {
-		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
-			pr_err("%s: Failed to resume driver: %s\n", __func__,
-				cpufreq_driver->name);
-		} else if (has_target()) {
-			scoped_guard(cpufreq_policy_write, policy) {
-				ret = cpufreq_start_governor(policy);
-			}
+	for_each_policy(policy) {
+		int ret = 0;
 
+		if (cpufreq_driver->resume && !policy_is_inactive(policy)) {
+			ret = cpufreq_driver->resume(policy);
 			if (ret)
-				pr_err("%s: Failed to start governor for CPU%u's policy\n",
-				       __func__, policy->cpu);
+				pr_err("%s: Failed to resume driver: %s\n", __func__,
+				       cpufreq_driver->name);
 		}
+
+		if (has_target())
+			cpufreq_resume_policy(policy, ret == 0);
 	}
 }
 
@@ -2412,12 +2446,17 @@ __weak struct cpufreq_governor *cpufreq_
 	return NULL;
 }
 
+static bool cpufreq_is_suspended(struct cpufreq_policy *policy)
+{
+	return cpufreq_suspended || policy->suspended;
+}
+
 static int cpufreq_init_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	/* Don't start any governor operations if we are entering suspend */
-	if (cpufreq_suspended)
+	/* Don't start any governor operations for suspended policies. */
+	if (cpufreq_is_suspended(policy))
 		return 0;
 	/*
 	 * Governor might not be initiated here if ACPI _PPC changed
@@ -2460,7 +2499,7 @@ static int cpufreq_init_governor(struct
 
 static void cpufreq_exit_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2475,7 +2514,7 @@ int cpufreq_start_governor(struct cpufre
 {
 	int ret;
 
-	if (cpufreq_suspended)
+	if (cpufreq_is_suspended(policy))
 		return 0;
 
 	if (!policy->governor)
@@ -2499,7 +2538,7 @@ int cpufreq_start_governor(struct cpufre
 
 void cpufreq_stop_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2510,7 +2549,7 @@ void cpufreq_stop_governor(struct cpufre
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (cpufreq_is_suspended(policy) || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2747,7 +2786,8 @@ static void cpufreq_policy_refresh(struc
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
+	    (cpufreq_is_suspended(policy) ||
+	     WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		return;
 
 	refresh_frequency_limits(policy);
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -149,6 +149,9 @@ struct cpufreq_policy {
 	/* Pending policy->min/max update for the driver */
 	bool			update_limits;
 
+	/* The policy has been suspended. */
+	bool			suspended;
+
 	 /* Cached frequency lookup from cpufreq_driver_resolve_freq. */
 	unsigned int cached_target_freq;
 	unsigned int cached_resolved_idx;



