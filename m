Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF02391E6D
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713147; cv=none; b=IAjRh5pCDTsGSaV6qdJ1h+sPBnOS+4w11Z56nBsbfDiFIO/L/3G2AqgOu+UF9suFpuBya3Wna2B4kkBqj7UTtbXhnH1ebDrgjfTj87Nnqyjo38hrtbFYafWFaq+U5qcCeq9QPg2dscbHtJ2QlrtOkIP+XqWzshKplE0p9dJF/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713147; c=relaxed/simple;
	bh=oIOwFBwDUI7sOUE8di9KBBy9GXkAos31x3zpj5Iq3fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tErGvT/ifzwGx7EvwQhqqmasaiT5v3If/25Y/IAQ0u9wbmCO5abvKWYexP34ljLUz/3OncYn9Yyhc6iJe31ca5tTLWeWAYLTB6YP1Hrk5tF0IRnByzmRFE71qI9/EpwDh7+fxdro3zEy5OShHiZtPsk2LBMscDCzj63wuympyt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E3A872F04;
	Mon, 29 Jun 2026 06:05:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6C69779A8;
	Mon, 29 Jun 2026 06:05:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IyrZMjELQmo5EQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:05:37 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 01/32] thermal/intel: Stop using 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:04:52 +0200
Message-ID: <20260629060526.3638272-2-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1E3A872F04
X-Rspamd-Action: no action

The 32-bit MSR interfaces rdmsr(), wrmsr(), rdmsr_safe() and
wrmsr_safe() are planned to be removed. Use the related 64-bit variants
instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/thermal/intel/intel_tcc.c            | 10 +--
 drivers/thermal/intel/therm_throt.c          | 68 +++++++++-----------
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 32 +++++----
 3 files changed, 52 insertions(+), 58 deletions(-)

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
index 45a8ef4a608b..0b46a727ca7a 100644
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
+	rdmsrq(MSR_IA32_THERM_INTERRUPT, val.q);
 	if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
-		wrmsr(MSR_IA32_THERM_INTERRUPT,
-			(l | (THERM_INT_LOW_ENABLE
-			| THERM_INT_HIGH_ENABLE)) & ~THERM_INT_PLN_ENABLE, h);
+		val.l = (val.l | THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE) &
+			~THERM_INT_PLN_ENABLE;
 	else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
-		wrmsr(MSR_IA32_THERM_INTERRUPT,
-			l | (THERM_INT_LOW_ENABLE
-			| THERM_INT_HIGH_ENABLE | THERM_INT_PLN_ENABLE), h);
+		val.l |= THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE |
+			 THERM_INT_PLN_ENABLE;
 	else
-		wrmsr(MSR_IA32_THERM_INTERRUPT,
-		      l | (THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE), h);
+		val.l |= THERM_INT_LOW_ENABLE | THERM_INT_HIGH_ENABLE;
+	wrmsrq(MSR_IA32_THERM_INTERRUPT, val.q);
 
 	if (cpu_has(c, X86_FEATURE_PTS)) {
-		rdmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+		rdmsrq(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
 		if (cpu_has(c, X86_FEATURE_PLN) && !int_pln_enable)
-			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-				(l | (PACKAGE_THERM_INT_LOW_ENABLE
-				| PACKAGE_THERM_INT_HIGH_ENABLE))
-				& ~PACKAGE_THERM_INT_PLN_ENABLE, h);
+			val.l = (val.l | PACKAGE_THERM_INT_LOW_ENABLE |
+				 PACKAGE_THERM_INT_HIGH_ENABLE) &
+				~PACKAGE_THERM_INT_PLN_ENABLE;
 		else if (cpu_has(c, X86_FEATURE_PLN) && int_pln_enable)
-			wrmsr(MSR_IA32_PACKAGE_THERM_INTERRUPT,
-				l | (PACKAGE_THERM_INT_LOW_ENABLE
-				| PACKAGE_THERM_INT_HIGH_ENABLE
-				| PACKAGE_THERM_INT_PLN_ENABLE), h);
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

