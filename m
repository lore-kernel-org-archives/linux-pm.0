Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793649170;
	b=uC/+KxO84fpnNTheFAEDKre0Z9rwNf/0mtp1yl/+VJ50/knBM/WWWdtvEpcqNNEqWLem
	 oTMlO67QsWVEATPYU5dGjwGogqHw3N+kF0c5N1fgNVwN6pDh6WOnOMi4yv1YPJgAG1GNa
	 2VkeCAIwk8zCwc1SjKSpIdeew+s964Fv7x0qI7+zVyfXs/RRSz81ZL2l47C5BtQqZ9Cbd
	 z2y7vEIeAO1QwSPnHZLim9tU/c/zh7SjehvXg8qyc8JNmnkfaWiAphukRXHD+EzQtS/IB
	 vtq7nRg9Qst1hhI/KYwB7WgDPB2nJ6EEWKtg3eaGBuU9Dash+h1bxTJkQ9CmAGjv8/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649170;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	bh=urB/b8zoTpngDyX/dZie8ECWCYpomdhWaljkDmbeHD4=;
	b=cn8hFHf8LlfbBmQ/LkxLXXXnnGI6HE+RTEfosHgISxoXrg7tIcwWZCFlUEDUydWI3xXb
	 OjDaLOcnhaWG1LPWTsZhNFnCSh7YNpRVhdLTxEYfvF9shGMXSSQx/gDZ4ajDxE/ACh6Ym
	 L8znCS6uQujCEGwS155WZ7RTqCNFvPbXqMBMYQCStrqxznCYNbZg2Ofrdv16iawlDKOSf
	 E22sqlj3JNYJcu5QrVMEJZrLcp87hQOMCCHQLDLkHBPlFL9CoOjRX1uoFiZDyRS5j+N0X
	 yxNFC93Mk2QdUd8fTUkHWe0HNdpQcOjQtXIAWdq2HEaZjoQ5vvVW/W7O303C1WfA3WA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MH983xyU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900C606A33F
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 19:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MH983xyU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FB01F00A17;
	Mon,  2 Nov 2026 19:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793649170;
	bh=urB/b8zoTpngDyX/dZie8ECWCYpomdhWaljkDmbeHD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MH983xyUTojxEpzeZ7vKB22vMztLfkXMjFa4f1p7KjD9pPizdJqV+C6LULcpk2rHb
	 nilcEwqLi95DIQO5cOxC68V7cSyq7Xx/rQUmGg8mhjDBpx/NVgm1Vw7uDa3GxDW7DR
	 tyzGA3psI27dHB2Ob9oLB6ZWee86c9gYjZEzUXcKOdvh7fckHJnJ33a26IOQ9/4ypv
	 kyR8k63ZNP5piTygJfTyY/Vr5PKtdASwyx0w93roTOLvFVe+ixb6r3ZEXaHRsEB0NS
	 qcpaeuhGjJmnpV+OibBW5OMba43Tvsu+7CJm+kjcgMhlw2h3EATS/OmMd4vxMRGY/Q
	 5ouplTL8vmu4w==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Doug Smythies <dsmythies@telus.net>, Zak <zakbrightonknight@gmail.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Mario Limonciello <superm1@kernel.org>
Subject: [PATCH v1 1/4] cpufreq: Improve suspend-resume synchronization
Date: Mon, 02 Nov 2026 20:49:24 +0100
Message-ID: <2450089.ElGaqSPkdT@rafael.j.wysocki>
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

The suspend-resume synchronization in the cpufreq core is not perfect
because the global cpufreq_suspended variable is accessed locklessly,
so updates of it may be subject to reordering with respect to other
operations and they may be missed by concurrent readers running in
parallel with the updater on other CPUs.

Address this by adding a per-policy "suspended" flag that is always
read under the policy rwsem and is updated under it after stopping the
governor in cpufreq_suspend() and before restarting the governor in
cpufreq_resume().

Also carry out the loops over active and inactive cpufreq policies
in cpufreq_resume() under the cpus_read_lock guard to reflect what
cpufreq_suspend() does.

Fixes: 8e30444e1530 ("cpufreq: fix cpufreq suspend/resume for intel_pstate")
Fixes: b1b12babe3b7 ("cpufreq: update 'cpufreq_suspended' after stopping governors")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/cpufreq.c | 69 ++++++++++++++++++++++++++-------------
 include/linux/cpufreq.h   |  3 ++
 2 files changed, 50 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 54dde8419bdc..1c1962a4beb4 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1956,6 +1956,14 @@ int cpufreq_generic_suspend(struct cpufreq_policy *policy)
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
@@ -1978,11 +1986,8 @@ void cpufreq_suspend(void)
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
@@ -1994,6 +1999,23 @@ void cpufreq_suspend(void)
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
@@ -2003,7 +2025,6 @@ void cpufreq_suspend(void)
 void cpufreq_resume(void)
 {
 	struct cpufreq_policy *policy;
-	int ret;
 
 	if (!cpufreq_driver)
 		return;
@@ -2018,20 +2039,24 @@ void cpufreq_resume(void)
 
 	pr_debug("%s: Resuming Governors\n", __func__);
 
+	guard(cpus_read_lock)();
+
 	for_each_active_policy(policy) {
-		if (cpufreq_driver->resume && cpufreq_driver->resume(policy)) {
-			pr_err("%s: Failed to resume driver: %s\n", __func__,
-				cpufreq_driver->name);
-		} else if (has_target()) {
-			scoped_guard(cpufreq_policy_write, policy) {
-				ret = cpufreq_start_governor(policy);
-			}
+		int ret = 0;
 
+		if (cpufreq_driver->resume) {
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
+
+	for_each_inactive_policy(policy)
+		policy->suspended = false;
 }
 
 /**
@@ -2416,8 +2441,8 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	/* Don't start any governor operations if we are entering suspend */
-	if (cpufreq_suspended)
+	/* Don't start any governor operations for suspended policies. */
+	if (policy->suspended)
 		return 0;
 	/*
 	 * Governor might not be initiated here if ACPI _PPC changed
@@ -2460,7 +2485,7 @@ static int cpufreq_init_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_exit_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (policy->suspended || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2475,7 +2500,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 {
 	int ret;
 
-	if (cpufreq_suspended)
+	if (policy->suspended)
 		return 0;
 
 	if (!policy->governor)
@@ -2499,7 +2524,7 @@ int cpufreq_start_governor(struct cpufreq_policy *policy)
 
 void cpufreq_stop_governor(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (policy->suspended || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2510,7 +2535,7 @@ void cpufreq_stop_governor(struct cpufreq_policy *policy)
 
 static void cpufreq_governor_limits(struct cpufreq_policy *policy)
 {
-	if (cpufreq_suspended || !policy->governor)
+	if (policy->suspended || !policy->governor)
 		return;
 
 	pr_debug("%s: for CPU %u\n", __func__, policy->cpu);
@@ -2747,7 +2772,7 @@ static void cpufreq_policy_refresh(struct cpufreq_policy *policy)
 	 * -> ask driver for current freq and notify governors about a change
 	 */
 	if (cpufreq_driver->get && has_target() &&
-	    (cpufreq_suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
+	    (policy->suspended || WARN_ON(!cpufreq_verify_current_freq(policy, false))))
 		return;
 
 	refresh_frequency_limits(policy);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d3d0d9d02aa4..20a6863b640a 100644
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
-- 
2.51.0




