Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B0E1DDC2B;
	Thu,  9 Jul 2026 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783601234; cv=none; b=FjYjh83CmoiUuiBx56tmACJXiBy8AP4CNdZjywLqGqF3N2WIzRavTIoAKBvIQj+mt1bfAQHe2q5N3X+L1o+nSx1Vdcg8cegnoVMDDCV7enuHpzjyU4pr7saqbX+MCeq1MpxgbJtG/E5THcjvqkzUDjuETMsmMHG9xjEfCsthuW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783601234; c=relaxed/simple;
	bh=faE+GwtK97BinEI5nLBJ0WSq+DAr3ZIIgQ50dMdrZaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXNkr1Vm4JURwqVVFMNreGRWJYhK0nF9EJXSCLesyaFDxAHTRKf7SHkHKcygPGWmbpCmH4U1/fbeyw0wBF2j9zRj1OS9XrdzXqSF304Sa8NVT5Hq124Xf4aM7CoZTBmcXOxbH7WDchN8v3h6l6y/UeSLDa2FA6drJGcUSEey/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfH6M9I8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfH6M9I8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4530D1F00A3A;
	Thu,  9 Jul 2026 12:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783601233;
	bh=NxvdMpy73qwOhoP0zaphQF6YlJGN+AiR4ARaplTTyLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EfH6M9I8uOniE9Mo9F/UO7YcIfrZpaSWyX8Vnh3qkWwSVa9Ojl7h1T9eRoyHD3gcI
	 4SEB7XMTbbSWJFEiWwFJFprDflgqVE0MTBdsfXQDhawksymHjodIKt7mijXdq1c1Pf
	 Jp2qy4515D2g0Ax0tgWCAgZcf18WfT8rvB9GLMnHIVGpLyGE0Q+9qpyJJyPxOocGXP
	 LObjXjxsCcsUrqSGdMpBzyzhCIaElAc8q9IJRUw2gi97OQFjSoqnW7MZVzFf7hh77v
	 YK7ifwd0azWnc+vgRBlEmyV0y+1lSK4CqqKID74s/+5oFl3RK4L9h19kLyMmWVHFCM
	 XLZAbNNBUU4FQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Sudeep Holla <Sudeep.Holla@arm.com>
Subject: [PATCH v1 16/17] intel_idle: Prepare for adding ACPI _LPI support
Date: Thu, 09 Jul 2026 14:43:43 +0200
Message-ID: <1932965.atdPhlSkOF@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
In-Reply-To: <4746278.LvFx2qVVIh@rafael.j.wysocki>
References: <4746278.LvFx2qVVIh@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In preparation for adding ACPI _LPI support to intel_idle, move some
code used for processing ACPI idle states information coming from
_CST objects to separate functions because that code will be also
used for processing idle states information coming from _LPI.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/idle/intel_idle.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index d74b478db280..fedaa8142121 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1837,6 +1837,16 @@ static bool __init intel_idle_acpi_cst_extract(void)
 	return false;
 }
 
+static void __init intel_idle_complete_state_init(struct cpuidle_state *state)
+{
+	if (intel_idle_state_needs_timer_stop(state))
+		state->flags |= CPUIDLE_FLAG_TIMER_STOP;
+
+	state->enter = intel_idle;
+	state->enter_dead = intel_idle_enter_dead;
+	state->enter_s2idle = intel_idle_s2idle;
+}
+
 static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 {
 	int cstate, limit = min_t(int, CPUIDLE_STATE_MAX, acpi_state_table.count);
@@ -1879,18 +1889,23 @@ static void __init intel_idle_init_cstates_acpi(struct cpuidle_driver *drv)
 		if (disabled_states_mask & BIT(cstate))
 			state->flags |= CPUIDLE_FLAG_OFF;
 
-		if (intel_idle_state_needs_timer_stop(state))
-			state->flags |= CPUIDLE_FLAG_TIMER_STOP;
-
 		if (cx->type > ACPI_STATE_C1 && !boot_cpu_has(X86_FEATURE_NONSTOP_TSC))
 			mark_tsc_unstable("TSC halts in idle");
 
-		state->enter = intel_idle;
-		state->enter_dead = intel_idle_enter_dead;
-		state->enter_s2idle = intel_idle_s2idle;
+		intel_idle_complete_state_init(state);
 	}
 }
 
+static bool __init intel_idle_acpi_hint_match(unsigned int flags, u32 acpi_hint,
+					      u32 table_hint)
+{
+	if (flags & CPUIDLE_FLAG_PARTIAL_HINT_MATCH) {
+		acpi_hint &= ~MWAIT_SUBSTATE_MASK;
+		table_hint &= ~MWAIT_SUBSTATE_MASK;
+	}
+	return acpi_hint == table_hint;
+}
+
 static bool __init intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
 {
 	int cstate, limit;
@@ -1909,14 +1924,8 @@ static bool __init intel_idle_off_by_default(unsigned int flags, u32 mwait_hint)
 	 */
 	for (cstate = 1; cstate < limit; cstate++) {
 		u32 acpi_hint = acpi_state_table.states[cstate].address;
-		u32 table_hint = mwait_hint;
-
-		if (flags & CPUIDLE_FLAG_PARTIAL_HINT_MATCH) {
-			acpi_hint &= ~MWAIT_SUBSTATE_MASK;
-			table_hint &= ~MWAIT_SUBSTATE_MASK;
-		}
 
-		if (acpi_hint == table_hint)
+		if (intel_idle_acpi_hint_match(flags, acpi_hint, mwait_hint))
 			return false;
 	}
 	return true;
-- 
2.51.0




