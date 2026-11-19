Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795118197;
	b=CaL+WCpP4Le4cMrF+IIm/yTLUz8GMtQRGOYgv+MdTmQGsiFYC6WNIltyhnGIPp/fBvIG
	 CPHs0gyZJHor5GQ77lqt/+BTn/Gwc+NcSKrfgNrFLsH/aG6IKQIrnnce49/CUyb6u/SFs
	 VCtikW7bRnhiaYwfD5x5ntc4KSPxO3Nhn57/4MlEnBfNfXfQncequ5XtrxxnmBmT5IL1F
	 u1Ea5aTxsEYF72ZiE6XF74t7OvXjQhG52byh4yfiukJvmO8jM176+bdB1mj5XK2y5wj6G
	 CW68FQww1zJLwSDhkYnhK5OZZ5+lPWC4NFDR/bdLsgz6n6LoS9GmaQal//3JCceJX4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795118197;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=zYEgrbruO7Uva7MBp+qA7G0y0dvY+OKo/D4TeQKsz4o=;
	b=28LPSq74Xi6GiKp7cad3HnbjO7JBPY+C3Rri4Z8s+uDLMoSN8FvrYRSr6uoSOrlSB9OA
	 SHTwxQ1s8DD2Z/C9HOtVtuFXd9rvANgMKADbibbD4bU++Ebf3OLTQ++tyW5d+0fzJYMpR
	 MlQb4n2WXjesaiafF8CJK4lAeJDfCxKlPUvgkZqo/iw1tXlirLM+36kfI4QIxEy9hdabx
	 FJKwXDHCpp6EAon+EMkBNwpbQIqnS/heVtKvnpjwbA4XylFAOeHar178p7VeQytkY3SGz
	 6GgptwGczIAgh0vxJHTW/9V6omjDwTqEDgboJ8TjuHNNEiTUPLXPfXnx/WE8IG+r+qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKVbvsdi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA07606A320;
	Thu, 19 Nov 2026 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jKVbvsdi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6FE1F000C4;
	Thu, 19 Nov 2026 19:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795118197;
	bh=zYEgrbruO7Uva7MBp+qA7G0y0dvY+OKo/D4TeQKsz4o=;
	h=From:To:Cc:Subject:Date;
	b=jKVbvsdi0POhljXjmBt1jvfC5D+GWRT8sm3KmDcV5i34NE1bE9mIWsTV6uEK7sTDZ
	 UokOPso16tjOpBsazkgXT1MUYsvWBFCRFvOXMK+D3sagf2jaFElUEvUtpDfrF8UFW2
	 9fqc2DGxDw7iZifNDnct1pCl8yCot9saV/Vg+18Lklgv9aY93m56xNe/4xCktJC7ol
	 V5rndPagqtdhaRmQsPoxdAHZ5olvYgWduFP6gJPQ2zyPa/Uu3n/xYnTGumgLGpjQwJ
	 N2IvNanthaLzrDNS/j5jN8MlTMTTGMAy2b+wcZeuLFm4E1/aTNKbAtbQxSIdLn+4sX
	 njojPwWU73Y3A==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Use dedicated lock in
 set_power_ctl_ee_state()
Date: Thu, 19 Nov 2026 20:56:34 +0100
Message-ID: <2862244.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
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

Commit eee2a44e4e2b ("cpufreq: Improve suspend-resume synchronization")
caused lockdep to complain about a possible circular locking dependency
because intel_pstate_resume() is now called under cpus_read_lock, and it
calls set_power_ctl_ee_state() that acquires intel_pstate_driver_lock
which can be held around CPU hotplug locking.

Fortunately, this cannot lead to a real deadlock because
intel_pstate_resume() does not run in parallel with the other holders
of intel_pstate_driver_lock, but in fact set_power_ctl_ee_state() need
not use that particular lock either.  Moreover, the original purpose of
that lock is different, so using it in set_power_ctl_ee_state() is
questionable.

Accordingly, introduce a dedicated mutex for protecting MSR_IA32_POWER_CTL
updates and power_ctl_ee_state accesses and make set_power_ctl_ee_state()
use it instead of intel_pstate_driver_lock.  Also take it directly in
intel_pstate_resume() around the EE state restore.

Fixes: eee2a44e4e2b ("cpufreq: Improve suspend-resume synchronization")
Reported-by: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
Closes: https://lore.kernel.org/linux-pm/efcb1647-46fd-442a-bbda-283560d9df53@intel.com/
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |   24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1351,13 +1351,14 @@ static void intel_pstate_hwp_offline(str
 /* Enable bit for Dynamic Efficiency Control (DEC) */
 #define POWER_CTL_DEC_ENABLE	27
 
+static DEFINE_MUTEX(power_ctl_update_lock);
 static int power_ctl_ee_state;
 
-static void set_power_ctl_ee_state(bool input)
+static void __set_power_ctl_ee_state(bool input)
 {
 	u64 power_ctl;
 
-	guard(mutex)(&intel_pstate_driver_lock);
+	lockdep_assert_held(&power_ctl_update_lock);
 
 	rdmsrq(MSR_IA32_POWER_CTL, power_ctl);
 	if (input) {
@@ -1370,6 +1371,13 @@ static void set_power_ctl_ee_state(bool
 	wrmsrq(MSR_IA32_POWER_CTL, power_ctl);
 }
 
+static void set_power_ctl_ee_state(bool input)
+{
+	guard(mutex)(&power_ctl_update_lock);
+
+	__set_power_ctl_ee_state(input);
+}
+
 static void intel_pstate_hwp_enable(struct cpudata *cpudata);
 
 static void intel_pstate_hwp_reenable(struct cpudata *cpu)
@@ -1398,11 +1406,13 @@ static int intel_pstate_resume(struct cp
 
 	pr_debug("CPU %d resuming\n", cpu->cpu);
 
-	/* Only restore if the system default is changed */
-	if (power_ctl_ee_state == POWER_CTL_EE_ENABLE)
-		set_power_ctl_ee_state(true);
-	else if (power_ctl_ee_state == POWER_CTL_EE_DISABLE)
-		set_power_ctl_ee_state(false);
+	scoped_guard(mutex, &power_ctl_update_lock) {
+		/* Only restore if the system default has changed */
+		if (power_ctl_ee_state == POWER_CTL_EE_ENABLE)
+			__set_power_ctl_ee_state(true);
+		else if (power_ctl_ee_state == POWER_CTL_EE_DISABLE)
+			__set_power_ctl_ee_state(false);
+	}
 
 	if (cpu->suspended && hwp_active) {
 		mutex_lock(&intel_pstate_limits_lock);



