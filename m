Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF935200D
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895884; cv=none; b=Ey33kD/P+wWlyyRXDjHMzia+KPs/qMIVJcfyCFNmtX0tr5YySf10QAP/N4n6rXNTQw8Dr6Onk1CVEU7qc0z8/Q0oqhPmqNRif0RRKwHpWaauyPR4veeq1vey5bnLp24X9sfArd2NqSRlENLbTy6U/kYs7hnWNftuLauDaA8ZcfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895884; c=relaxed/simple;
	bh=lJMS7DtNGk/pMe7Ndp0KvMi1nBPDmFzaVObIfvYxv5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNcBC/MTlCvcbZFPoBMEEK37i2AfxIbNxH5+JK24wB/PfIIRgl0N4BOcVN+MKQuMCnnKkl6o50wYhA4CCNbm8qKI8lUNWzO8kNRYAdL0zDad9okkUVAzBjlq8jY/NpQkYJApD00SulqhINj/XXUKyZBcy5gd0IeWsUfzVZ0MEUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=aTWBywJR; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=QvFNNM4M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="aTWBywJR";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="QvFNNM4M"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F050E6B5CC;
	Mon,  8 Jun 2026 05:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kwneYnQQfIiXba2kL2tD1NmAgBcR5Q/1RGc24ytmuU=;
	b=aTWBywJRjCZ9eN5dG5OWorDNTfr0c31BORuT93+j0y/jXyQI83a02/i/s2AbjwkpHf+HIz
	JaBnxfBVe3GlKaDFJCHW4A2io21+6kAYT8BN3xC7kPXaFHkTqaYiJ1bvJTdxepFzHCkOm8
	XXlDe/sNIWKQG/VMq7/Ly4KeRKCR/6U=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kwneYnQQfIiXba2kL2tD1NmAgBcR5Q/1RGc24ytmuU=;
	b=QvFNNM4MvUH24FI0sSFF/gBtUZxYmAULrJuVS74KGToonhFtUJDMNQ7ZGIE357NNZAHYYX
	1UqEBQGiA2tmlBx1lfAboz7k5l2dntiZlkh679sd5GaGehdH+jd30CsUF5qTlRbdCLXsgv
	CpLHiHQxPQyL+5qQAupKxczq8m0WlMc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 917A1779A7;
	Mon,  8 Jun 2026 05:18:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ky51IohQJmpOdQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 08 Jun 2026 05:18:00 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v3 03/11] x86/msr: Switch rdmsr_on_cpu() users to rdmsrq_on_cpu()
Date: Mon,  8 Jun 2026 07:17:33 +0200
Message-ID: <20260608051741.3207435-4-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608051741.3207435-1-jgross@suse.com>
References: <20260608051741.3207435-1-jgross@suse.com>
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_TWELVE(0.00)[18];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid,intel.com:email]
X-Spam-Level: 
X-Spam-Score: -2.80

In order to prepare retiring rdmsr_on_cpu() switch rdmsr_on_cpu() users
to rdmsrq_on_cpu().

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
---
V2:
- instead of changing rdmsr_on_cpu(), use rdmsrq_on_cpu() (Ingo Molnar)
---
 arch/x86/include/asm/msr.h                   |  2 +-
 arch/x86/kernel/cpu/mce/amd.c                |  6 ++--
 arch/x86/kernel/cpu/mce/inject.c             |  8 ++---
 drivers/cpufreq/amd_freq_sensitivity.c       |  6 ++--
 drivers/cpufreq/p4-clockmod.c                | 32 ++++++++++----------
 drivers/cpufreq/speedstep-centrino.c         | 27 +++++++++--------
 drivers/hwmon/coretemp.c                     | 12 ++++----
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 25 ++++++++-------
 8 files changed, 58 insertions(+), 60 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index fddadbc625be..d5985d6fdaf9 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -292,7 +292,7 @@ static inline int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 				struct msr __percpu *msrs)
 {
-	rdmsr_on_cpu(0, msr_no, raw_cpu_ptr(&msrs->l), raw_cpu_ptr(&msrs->h));
+	rdmsrq_on_cpu(0, msr_no, raw_cpu_ptr(&msrs->q));
 }
 static inline void wrmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 				struct msr __percpu *msrs)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6605a0224659..1305d9a2ee32 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -969,13 +969,13 @@ store_threshold_limit(struct threshold_block *b, const char *buf, size_t size)
 
 static ssize_t show_error_count(struct threshold_block *b, char *buf)
 {
-	u32 lo, hi;
+	struct msr val;
 
 	/* CPU might be offline by now */
-	if (rdmsr_on_cpu(b->cpu, b->address, &lo, &hi))
+	if (rdmsrq_on_cpu(b->cpu, b->address, &val.q))
 		return -ENODEV;
 
-	return sprintf(buf, "%u\n", ((hi & THRESHOLD_MAX) -
+	return sprintf(buf, "%u\n", ((val.h & THRESHOLD_MAX) -
 				     (THRESHOLD_MAX - b->threshold_limit)));
 }
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index d02c4f556cd0..bee9c35762b8 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -316,18 +316,18 @@ static struct notifier_block inject_nb = {
  */
 static int toggle_hw_mce_inject(unsigned int cpu, bool enable)
 {
-	u32 l, h;
+	struct msr val;
 	int err;
 
-	err = rdmsr_on_cpu(cpu, MSR_K7_HWCR, &l, &h);
+	err = rdmsrq_on_cpu(cpu, MSR_K7_HWCR, &val.q);
 	if (err) {
 		pr_err("%s: error reading HWCR\n", __func__);
 		return err;
 	}
 
-	enable ? (l |= BIT(18)) : (l &= ~BIT(18));
+	enable ? (val.l |= BIT(18)) : (val.l &= ~BIT(18));
 
-	err = wrmsr_on_cpu(cpu, MSR_K7_HWCR, l, h);
+	err = wrmsr_on_cpu(cpu, MSR_K7_HWCR, val.l, val.h);
 	if (err)
 		pr_err("%s: error writing HWCR\n", __func__);
 
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index 13fed4b9e02b..739d54dc9f2b 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -51,10 +51,8 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
 	if (!policy->freq_table)
 		return freq_next;
 
-	rdmsr_on_cpu(policy->cpu, MSR_AMD64_FREQ_SENSITIVITY_ACTUAL,
-		&actual.l, &actual.h);
-	rdmsr_on_cpu(policy->cpu, MSR_AMD64_FREQ_SENSITIVITY_REFERENCE,
-		&reference.l, &reference.h);
+	rdmsrq_on_cpu(policy->cpu, MSR_AMD64_FREQ_SENSITIVITY_ACTUAL, &actual.q);
+	rdmsrq_on_cpu(policy->cpu, MSR_AMD64_FREQ_SENSITIVITY_REFERENCE, &reference.q);
 	actual.h &= 0x00ffffff;
 	reference.h &= 0x00ffffff;
 
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 69c19233fcd4..d96e8b665f39 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -51,24 +51,24 @@ static unsigned int cpufreq_p4_get(unsigned int cpu);
 
 static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 {
-	u32 l, h;
+	struct msr val;
 
 	if ((newstate > DC_DISABLE) || (newstate == DC_RESV))
 		return -EINVAL;
 
-	rdmsr_on_cpu(cpu, MSR_IA32_THERM_STATUS, &l, &h);
+	rdmsrq_on_cpu(cpu, MSR_IA32_THERM_STATUS, &val.q);
 
-	if (l & 0x01)
+	if (val.l & 0x01)
 		pr_debug("CPU#%d currently thermal throttled\n", cpu);
 
 	if (has_N44_O17_errata[cpu] &&
 	    (newstate == DC_25PT || newstate == DC_DFLT))
 		newstate = DC_38PT;
 
-	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &l, &h);
+	rdmsrq_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &val.q);
 	if (newstate == DC_DISABLE) {
 		pr_debug("CPU#%d disabling modulation\n", cpu);
-		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
+		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.l & ~(1<<4), val.h);
 	} else {
 		pr_debug("CPU#%d setting duty cycle to %d%%\n",
 			cpu, ((125 * newstate) / 10));
@@ -77,9 +77,9 @@ static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 		 * bits 3-1	: duty cycle
 		 * bit  0	: reserved
 		 */
-		l = (l & ~14);
-		l = l | (1<<4) | ((newstate & 0x7)<<1);
-		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, l, h);
+		val.l = (val.l & ~14);
+		val.l = val.l | (1<<4) | ((newstate & 0x7)<<1);
+		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.l, val.h);
 	}
 
 	return 0;
@@ -205,18 +205,18 @@ static int cpufreq_p4_cpu_init(struct cpufreq_policy *policy)
 
 static unsigned int cpufreq_p4_get(unsigned int cpu)
 {
-	u32 l, h;
+	struct msr val;
 
-	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &l, &h);
+	rdmsrq_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &val.q);
 
-	if (l & 0x10) {
-		l = l >> 1;
-		l &= 0x7;
+	if (val.l & 0x10) {
+		val.l = val.l >> 1;
+		val.l &= 0x7;
 	} else
-		l = DC_DISABLE;
+		val.l = DC_DISABLE;
 
-	if (l != DC_DISABLE)
-		return stock_freq * l / 8;
+	if (val.l != DC_DISABLE)
+		return stock_freq * val.l / 8;
 
 	return stock_freq;
 }
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index 3e6e85a92212..cefee19d1100 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -322,11 +322,11 @@ static unsigned extract_clock(unsigned msr, unsigned int cpu, int failsafe)
 /* Return the current CPU frequency in kHz */
 static unsigned int get_cur_freq(unsigned int cpu)
 {
-	unsigned l, h;
+	struct msr val;
 	unsigned clock_freq;
 
-	rdmsr_on_cpu(cpu, MSR_IA32_PERF_STATUS, &l, &h);
-	clock_freq = extract_clock(l, cpu, 0);
+	rdmsrq_on_cpu(cpu, MSR_IA32_PERF_STATUS, &val.q);
+	clock_freq = extract_clock(val.l, cpu, 0);
 
 	if (unlikely(clock_freq == 0)) {
 		/*
@@ -335,8 +335,8 @@ static unsigned int get_cur_freq(unsigned int cpu)
 		 * P-state transition (like TM2). Get the last freq set 
 		 * in PERF_CTL.
 		 */
-		rdmsr_on_cpu(cpu, MSR_IA32_PERF_CTL, &l, &h);
-		clock_freq = extract_clock(l, cpu, 1);
+		rdmsrq_on_cpu(cpu, MSR_IA32_PERF_CTL, &val.q);
+		clock_freq = extract_clock(val.l, cpu, 1);
 	}
 	return clock_freq;
 }
@@ -417,7 +417,8 @@ static void centrino_cpu_exit(struct cpufreq_policy *policy)
  */
 static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 {
-	unsigned int	msr, oldmsr = 0, h = 0, cpu = policy->cpu;
+	unsigned int	msr, cpu = policy->cpu;
+	struct msr oldmsr = { .q = 0 };
 	int			retval = 0;
 	unsigned int		j, first_cpu;
 	struct cpufreq_frequency_table *op_points;
@@ -459,22 +460,22 @@ static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 		msr = op_points->driver_data;
 
 		if (first_cpu) {
-			rdmsr_on_cpu(good_cpu, MSR_IA32_PERF_CTL, &oldmsr, &h);
-			if (msr == (oldmsr & 0xffff)) {
+			rdmsrq_on_cpu(good_cpu, MSR_IA32_PERF_CTL, &oldmsr.q);
+			if (msr == (oldmsr.l & 0xffff)) {
 				pr_debug("no change needed - msr was and needs "
-					"to be %x\n", oldmsr);
+					"to be %x\n", oldmsr.l);
 				retval = 0;
 				goto out;
 			}
 
 			first_cpu = 0;
 			/* all but 16 LSB are reserved, treat them with care */
-			oldmsr &= ~0xffff;
+			oldmsr.l &= ~0xffff;
 			msr &= 0xffff;
-			oldmsr |= msr;
+			oldmsr.l |= msr;
 		}
 
-		wrmsr_on_cpu(good_cpu, MSR_IA32_PERF_CTL, oldmsr, h);
+		wrmsr_on_cpu(good_cpu, MSR_IA32_PERF_CTL, oldmsr.l, oldmsr.h);
 		if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
 			break;
 
@@ -490,7 +491,7 @@ static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 		 */
 
 		for_each_cpu(j, covered_cpus)
-			wrmsr_on_cpu(j, MSR_IA32_PERF_CTL, oldmsr, h);
+			wrmsr_on_cpu(j, MSR_IA32_PERF_CTL, oldmsr.l, oldmsr.h);
 	}
 	retval = 0;
 
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 6a0d94711ead..1259c78c95c6 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -356,15 +356,15 @@ static ssize_t show_label(struct device *dev,
 static ssize_t show_crit_alarm(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
-	u32 eax, edx;
+	struct msr val;
 	struct temp_data *tdata = container_of(devattr, struct temp_data,
 						sd_attrs[ATTR_CRIT_ALARM]);
 
 	mutex_lock(&tdata->update_lock);
-	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
+	rdmsrq_on_cpu(tdata->cpu, tdata->status_reg, &val.q);
 	mutex_unlock(&tdata->update_lock);
 
-	return sprintf(buf, "%d\n", (eax >> 5) & 1);
+	return sprintf(buf, "%d\n", (val.l >> 5) & 1);
 }
 
 static ssize_t show_tjmax(struct device *dev,
@@ -398,7 +398,7 @@ static ssize_t show_ttarget(struct device *dev,
 static ssize_t show_temp(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
-	u32 eax, edx;
+	struct msr val;
 	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_TEMP]);
 	int tjmax;
 
@@ -407,14 +407,14 @@ static ssize_t show_temp(struct device *dev,
 	tjmax = get_tjmax(tdata, dev);
 	/* Check whether the time interval has elapsed */
 	if (time_after(jiffies, tdata->last_updated + HZ)) {
-		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
+		rdmsrq_on_cpu(tdata->cpu, tdata->status_reg, &val.q);
 		/*
 		 * Ignore the valid bit. In all observed cases the register
 		 * value is either low or zero if the valid bit is 0.
 		 * Return it instead of reporting an error which doesn't
 		 * really help at all.
 		 */
-		tdata->temp = tjmax - ((eax >> 16) & 0xff) * 1000;
+		tdata->temp = tjmax - ((val.l >> 16) & 0xff) * 1000;
 		tdata->last_updated = jiffies;
 	}
 
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 540109761f0a..2e7de8cf756d 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -125,8 +125,9 @@ sys_set_trip_temp(struct thermal_zone_device *tzd,
 {
 	struct zone_device *zonedev = thermal_zone_device_priv(tzd);
 	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
-	u32 l, h, mask, shift, intr;
+	u32 mask, shift, intr;
 	int tj_max, val, ret;
+	struct msr v;
 
 	if (temp == THERMAL_TEMP_INVALID)
 		temp = 0;
@@ -141,8 +142,7 @@ sys_set_trip_temp(struct thermal_zone_device *tzd,
 	if (trip_index >= MAX_NUMBER_OF_TRIPS || val < 0 || val > 0x7f)
 		return -EINVAL;
 
-	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			   &l, &h);
+	ret = rdmsrq_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, &v.q);
 	if (ret < 0)
 		return ret;
 
@@ -155,20 +155,19 @@ sys_set_trip_temp(struct thermal_zone_device *tzd,
 		shift = THERM_SHIFT_THRESHOLD0;
 		intr = THERM_INT_THRESHOLD0_ENABLE;
 	}
-	l &= ~mask;
+	v.l &= ~mask;
 	/*
 	* When users space sets a trip temperature == 0, which is indication
 	* that, it is no longer interested in receiving notifications.
 	*/
 	if (!temp) {
-		l &= ~intr;
+		v.l &= ~intr;
 	} else {
-		l |= val << shift;
-		l |= intr;
+		v.l |= val << shift;
+		v.l |= intr;
 	}
 
-	return wrmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			l, h);
+	return wrmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, v.l, v.h);
 }
 
 /* Thermal zone callback registry */
@@ -277,7 +276,8 @@ static int pkg_temp_thermal_trips_init(int cpu, int tj_max,
 				       struct thermal_trip *trips, int num_trips)
 {
 	unsigned long thres_reg_value;
-	u32 mask, shift, eax, edx;
+	u32 mask, shift;
+	struct msr val;
 	int ret, i;
 
 	for (i = 0; i < num_trips; i++) {
@@ -290,12 +290,11 @@ static int pkg_temp_thermal_trips_init(int cpu, int tj_max,
 			shift = THERM_SHIFT_THRESHOLD0;
 		}
 
-		ret = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-				   &eax, &edx);
+		ret = rdmsrq_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, &val.q);
 		if (ret < 0)
 			return ret;
 
-		thres_reg_value = (eax & mask) >> shift;
+		thres_reg_value = (val.l & mask) >> shift;
 
 		trips[i].temperature = thres_reg_value ?
 			tj_max - thres_reg_value * 1000 : THERMAL_TEMP_INVALID;
-- 
2.54.0

