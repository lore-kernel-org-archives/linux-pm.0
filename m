Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9A93BB69D
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783077769; cv=none; b=EuhI7bYJNBrfyq/0+jzlYelXA5+7yFS7okRSSDuMt9UU6TRQPbUnsLlDg40+thqiAdyHt9HaydsLOxM4WOHlPBMw2TlZ/v7TRv23pmWrc72bPSAvGqraX876CpIdfrFQUfv8SEWWn90vBCjlI515NP/aOebrvcehwlNUyChswrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783077769; c=relaxed/simple;
	bh=KLPh0BwNOdUQmEQY2/HZE8OLYt2UhyohcczNBETMmds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOhQyHhfifA+bK7uxF3kUqqIdKxZNDTfEQz5bIBibUphPFGoQ1omLtXWyIR8k5izrvXS4v7tgEhvPjjDLkWM4oK/knP1gfc3+CQpHgbvc/bqCHQzCANHXn+eRblGNpr3fbKqugl2SQa06K1IE+Un/BnCDOlqbENMDFTzZ3tQ9Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vYfs5E8Q; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=vYfs5E8Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vYfs5E8Q";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="vYfs5E8Q"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6FB687586A;
	Fri,  3 Jul 2026 11:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783077755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wB+1rVAgNN1Vo7FTUuc1IHwfiXaLYQJR/5FTXToOVMI=;
	b=vYfs5E8QG5SO5rqFGaq1ZSI1Q7rVMrlmSjYDnjTxNNXFlTA+jxOZy5YlPxv1pfuSVz/JE4
	hKt2FKhsAkErSkbE7p04qD0uq7YTAxLt8TXMOWAGyrjowdOxnZnKuDEr7sW3pQpiTAyo6Z
	XbI6IE0oqpDTJeQKMe5jb+wN2A693oY=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1783077755; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wB+1rVAgNN1Vo7FTUuc1IHwfiXaLYQJR/5FTXToOVMI=;
	b=vYfs5E8QG5SO5rqFGaq1ZSI1Q7rVMrlmSjYDnjTxNNXFlTA+jxOZy5YlPxv1pfuSVz/JE4
	hKt2FKhsAkErSkbE7p04qD0uq7YTAxLt8TXMOWAGyrjowdOxnZnKuDEr7sW3pQpiTAyo6Z
	XbI6IE0oqpDTJeQKMe5jb+wN2A693oY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36A94779AA;
	Fri,  3 Jul 2026 11:22:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H/GbC3ubR2qfYgAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 03 Jul 2026 11:22:35 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 01/32] thermal/intel: Stop using 32-bit MSR interfaces
Date: Fri,  3 Jul 2026 13:22:32 +0200
Message-ID: <20260703112232.1762925-1-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-2-jgross@suse.com>
References: <20260629060526.3638272-2-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -2.80

The 32-bit MSR interfaces rdmsr(), wrmsr(), rdmsr_safe() and
wrmsr_safe() are planned to be removed. Use the related 64-bit variants
instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- make bit modifications more readable (Ingo Molnar)
---
 drivers/thermal/intel/intel_tcc.c            | 10 +--
 drivers/thermal/intel/therm_throt.c          | 76 ++++++++++----------
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 32 ++++-----
 3 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
index 59f70bb5ffa5..d1fa3c63d554 100644
--- a/drivers/thermal/intel/intel_tcc.c
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -185,7 +185,7 @@ int intel_tcc_get_tjmax(int cpu)
 	int val, err;
 
 	if (cpu < 0)
-		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &msrval.l, &msrval.h);
+		err = rdmsrq_safe(MSR_IA32_TEMPERATURE_TARGET, &msrval.q);
 	else
 		err = rdmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &msrval.q);
 	if (err)
@@ -212,7 +212,7 @@ int intel_tcc_get_offset(int cpu)
 	int err;
 
 	if (cpu < 0)
-		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &val.l, &val.h);
+		err = rdmsrq_safe(MSR_IA32_TEMPERATURE_TARGET, &val.q);
 	else
 		err = rdmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &val.q);
 	if (err)
@@ -245,7 +245,7 @@ int intel_tcc_set_offset(int cpu, int offset)
 		return -EINVAL;
 
 	if (cpu < 0)
-		err = rdmsr_safe(MSR_IA32_TEMPERATURE_TARGET, &val.l, &val.h);
+		err = rdmsrq_safe(MSR_IA32_TEMPERATURE_TARGET, &val.q);
 	else
 		err = rdmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &val.q);
 	if (err)
@@ -259,7 +259,7 @@ int intel_tcc_set_offset(int cpu, int offset)
 	val.l |= offset << 24;
 
 	if (cpu < 0)
-		return wrmsr_safe(MSR_IA32_TEMPERATURE_TARGET, val.l, val.h);
+		return wrmsrq_safe(MSR_IA32_TEMPERATURE_TARGET, val.q);
 	else
 		return wrmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, val.q);
 }
@@ -288,7 +288,7 @@ int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
 		return tjmax;
 
 	if (cpu < 0)
-		err = rdmsr_safe(msr, &val.l, &val.h);
+		err = rdmsrq_safe(msr, &val.q);
 	else
 		err = rdmsrq_safe_on_cpu(cpu, msr, &val.q);
 	if (err)
diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 45a8ef4a608b..1dfd4491c9f6 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -722,8 +722,8 @@ void __init therm_lvt_init(void)
 void intel_init_thermal(struct cpuinfo_x86 *c)
 {
 	unsigned int cpu = smp_processor_id();
+	struct msr val;
 	int tm2 = 0;
-	u32 l, h;
 
 	if (!intel_thermal_supported(c))
 		return;
@@ -733,9 +733,9 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	 * be some SMM goo which handles it, so we can't even put a handler
 	 * since it might be delivered via SMI already:
 	 */
-	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
+	rdmsrq(MSR_IA32_MISC_ENABLE, val.q);
 
-	h = lvtthmr_init;
+	val.h = lvtthmr_init;
 	/*
 	 * The initial value of thermal LVT entries on all APs always reads
 	 * 0x10000 because APs are woken up by BSP issuing INIT-SIPI-SIPI
@@ -746,11 +746,11 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	 * BIOS has programmed on AP based on BSP's info we saved since BIOS
 	 * is always setting the same value for all threads/cores.
 	 */
-	if ((h & APIC_DM_FIXED_MASK) != APIC_DM_FIXED)
+	if ((val.h & APIC_DM_FIXED_MASK) != APIC_DM_FIXED)
 		apic_write(APIC_LVTTHMR, lvtthmr_init);
 
 
-	if ((l & MSR_IA32_MISC_ENABLE_TM1) && (h & APIC_DM_SMI)) {
+	if ((val.l & MSR_IA32_MISC_ENABLE_TM1) && (val.h & APIC_DM_SMI)) {
 		if (system_state == SYSTEM_BOOTING)
 			pr_debug("CPU%d: Thermal monitoring handled by SMI\n", cpu);
 		return;
@@ -759,59 +759,55 @@ void intel_init_thermal(struct cpuinfo_x86 *c)
 	/* early Pentium M models use different method for enabling TM2 */
 	if (cpu_has(c, X86_FEATURE_TM2)) {
 		if (c->x86 == 6 && (c->x86_model == 9 || c->x86_model == 13)) {
-			rdmsr(MSR_THERM2_CTL, l, h);
-			if (l & MSR_THERM2_CTL_TM_SELECT)
+			rdmsrq(MSR_THERM2_CTL, val.q);
+			if (val.l & MSR_THERM2_CTL_TM_SELECT)
 				tm2 = 1;
-		} else if (l & MSR_IA32_MISC_ENABLE_TM2)
+		} else if (val.l & MSR_IA32_MISC_ENABLE_TM2)
 			tm2 = 1;
 	}
 
 	/* We'll mask the thermal vector in the lapic till we're ready: */
-	h = THERMAL_APIC_VECTOR | APIC_DM_FIXED | APIC_LVT_MASKED;
-	apic_write(APIC_LVTTHMR, h);
+	val.h = THERMAL_APIC_VECTOR | APIC_DM_FIXED | APIC_LVT_MASKED;
+	apic_write(APIC_LVTTHMR, val.h);
 
 	thermal_intr_init_core_clear_mask();
 	thermal_intr_init_pkg_clear_mask();
 
-	rdmsr(MSR_IA32_THERM_INTERRUPT, l, h);
-	if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
-		wrmsr(MSR_IA32_THERM_INTERRUPT,
-			(l | (THERM_INT_LOW_ENABLE
-			| THERM_INT_HIGH_ENABLE)) & ~THERM_INT_PLN_ENABLE, h);
-	else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
-		wrmsr(MSR_IA32_THERM_INTERRUPT,
-			l | (THERM_INT_LOW_ENABLE
-			| THERM_INT_HIGH_ENABLE | THERM_INT_PLN_ENABLE), h);
+	rdmsrq(MSR_IA32_THERM_INTERRUPT, val.q);
+	if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable) {
+		val.l |= THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE;
+		val.l &= ~THERM_INT_PLN_ENABLE;
+	} else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
+		val.l |= THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE |
+			 THERM_INT_PLN_ENABLE;
 	else
-		wrmsr(MSR_IA32_THERM_INTERRUPT,
-		      l | (THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE), h);
+		val.l |= THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE;
+	wrmsrq(MSR_IA32_THERM_INTERRUPT, val.q);
 
 	if (cpu_has(c, X86_FEATURE_PTS)) {
-		rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
-		if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
-			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-				(l | (PACKAGE_THERM_INT_LOW_ENABLE
-				| PACKAGE_THERM_INT_HIGH_ENABLE))
-				& ~PACKAGE_THERM_INT_PLN_ENABLE, h);
-		else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
-			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-				l | (PACKAGE_THERM_INT_LOW_ENABLE
-				| PACKAGE_THERM_INT_HIGH_ENABLE
-				| PACKAGE_THERM_INT_PLN_ENABLE), h);
+		rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
+		if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable) {
+			val.l |= PACKAGE_THERM_INT_LOW_ENABLE |
+				 PACKAGE_THERM_INT_HIGH_ENABLE;
+			val.l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
+		} else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
+			val.l |= PACKAGE_THERM_INT_LOW_ENABLE |
+				 PACKAGE_THERM_INT_HIGH_ENABLE |
+				 PACKAGE_THERM_INT_PLN_ENABLE;
 		else
-			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			      l | (PACKAGE_THERM_INT_LOW_ENABLE
-				| PACKAGE_THERM_INT_HIGH_ENABLE), h);
+			val.l |= PACKAGE_THERM_INT_LOW_ENABLE |
+				 PACKAGE_THERM_INT_HIGH_ENABLE;
+		wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
 
 		if (cpu_has(c, X86_FEATURE_HFI)) {
-			rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
-			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			      l | PACKAGE_THERM_INT_HFI_ENABLE, h);
+			rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
+			wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+			       val.q | PACKAGE_THERM_INT_HFI_ENABLE);
 		}
 	}
 
-	rdmsr(MSR_IA32_MISC_ENABLE, l, h);
-	wrmsr(MSR_IA32_MISC_ENABLE, l | MSR_IA32_MISC_ENABLE_TM1, h);
+	rdmsrq(MSR_IA32_MISC_ENABLE, val.q);
+	wrmsrq(MSR_IA32_MISC_ENABLE, val.q | MSR_IA32_MISC_ENABLE_TM1);
 
 	pr_info_once("CPU0: Thermal monitoring enabled (%s)\n",
 		      tm2 ? "TM2" : "TM1");
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 688e04c63761..43fd5bdf1d8d 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -51,8 +51,7 @@ MODULE_PARM_DESC(notify_delay_ms,
 struct zone_device {
 	int				cpu;
 	bool				work_scheduled;
-	u32				msr_pkg_therm_low;
-	u32				msr_pkg_therm_high;
+	u64				msr_pkg_therm;
 	struct delayed_work		work;
 	struct thermal_zone_device	*tzone;
 	struct cpumask			cpumask;
@@ -186,28 +185,28 @@ static bool pkg_thermal_rate_control(void)
 static inline void enable_pkg_thres_interrupt(void)
 {
 	u8 thres_0, thres_1;
-	u32 l, h;
+	struct msr val;
 
-	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
 	/* only enable/disable if it had valid threshold value */
-	thres_0 = (l & THERM_MASK_THRESHOLD0) >> THERM_SHIFT_THRESHOLD0;
-	thres_1 = (l & THERM_MASK_THRESHOLD1) >> THERM_SHIFT_THRESHOLD1;
+	thres_0 = (val.l & THERM_MASK_THRESHOLD0) >> THERM_SHIFT_THRESHOLD0;
+	thres_1 = (val.l & THERM_MASK_THRESHOLD1) >> THERM_SHIFT_THRESHOLD1;
 	if (thres_0)
-		l |= THERM_INT_THRESHOLD0_ENABLE;
+		val.l |= THERM_INT_THRESHOLD0_ENABLE;
 	if (thres_1)
-		l |= THERM_INT_THRESHOLD1_ENABLE;
-	wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+		val.l |= THERM_INT_THRESHOLD1_ENABLE;
+	wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
 }
 
 /* Disable threshold interrupt on local package/cpu */
 static inline void disable_pkg_thres_interrupt(void)
 {
-	u32 l, h;
+	struct msr val;
 
-	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
 
-	l &= ~(THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_ENABLE);
-	wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	val.l &= ~(THERM_INT_THRESHOLD0_ENABLE | THERM_INT_THRESHOLD1_ENABLE);
+	wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
 }
 
 static void pkg_temp_thermal_threshold_work_fn(struct work_struct *work)
@@ -357,8 +356,7 @@ static int pkg_temp_thermal_device_add(unsigned int cpu)
 		goto out_unregister_tz;
 
 	/* Store MSR value for package thermal interrupt, to restore at exit */
-	rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm_low,
-	      zonedev->msr_pkg_therm_high);
+	rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, zonedev->msr_pkg_therm);
 
 	cpumask_set_cpu(cpu, &zonedev->cpumask);
 	raw_spin_lock_irq(&pkg_temp_lock);
@@ -426,8 +424,8 @@ static int pkg_thermal_cpu_offline(unsigned int cpu)
 	if (lastcpu) {
 		zones[topology_logical_die_id(cpu)] = NULL;
 		/* After this point nothing touches the MSR anymore. */
-		wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-		      zonedev->msr_pkg_therm_low, zonedev->msr_pkg_therm_high);
+		wrmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT,
+		       zonedev->msr_pkg_therm);
 	}
 
 	/*
-- 
2.54.0

