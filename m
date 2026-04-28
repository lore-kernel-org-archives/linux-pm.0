Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816063FE37C
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372938; cv=none; b=CxO7DS04AY7g/umqkJLfjJKt3RM6OD2MJXfTB1UXYloQvkK4J+FpVHDJdpO+CrIGjVyicFUhid1Mb8d7PAMk1/YhwnpNkDS93C9pGv6ZlQFHdW52q+K0n2hGKp6lA1RcILjYnQx4uSWygR0x5CeuyXvEsQauXshApwGN0LUAdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372938; c=relaxed/simple;
	bh=72AHQxfJrwwJKFQEY0i6jGLfTYk1v5uS2Q0NFKxEFs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O0E80jEYKxm8Cb+URa8Zzs+WUJSYIWszEmX5pYykOWqYM9XNC5h3WP9m2fS46UNv6R2amzSzSV3peMEIxT0Q9qAqO/QRE9Vd2hgCwVyIBRgwauCpjMBgNiKCet6g0WeQRDziPt9r1z8pAy9iMusQg/wkQMAKIY43kqejL710ESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uRgnDMjU; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uRgnDMjU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uRgnDMjU";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uRgnDMjU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D53E05BCC9;
	Tue, 28 Apr 2026 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTefs2fih6mLOnzscVIJhlCanTBuCmTp3V2G2oJoZrw=;
	b=uRgnDMjUcVyoYsoK5YtT/rP+7bTY74FCZV+paBNhtdTHWoVEFgn/QJfzfEoc5QRnl0wd/B
	13YtiuMOI7h/5jiA+7YhWJ8nvP+H7+4UnWoKQjMT8rHvjV4aVGxjqZURZvGnT5sTLH+LON
	Ua09wLOu1BsqtCVg/0uJ67KC+q1lkzM=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=uRgnDMjU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PTefs2fih6mLOnzscVIJhlCanTBuCmTp3V2G2oJoZrw=;
	b=uRgnDMjUcVyoYsoK5YtT/rP+7bTY74FCZV+paBNhtdTHWoVEFgn/QJfzfEoc5QRnl0wd/B
	13YtiuMOI7h/5jiA+7YhWJ8nvP+H7+4UnWoKQjMT8rHvjV4aVGxjqZURZvGnT5sTLH+LON
	Ua09wLOu1BsqtCVg/0uJ67KC+q1lkzM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72DC3593B0;
	Tue, 28 Apr 2026 10:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wnPqGgWP8Gl0PQAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 28 Apr 2026 10:42:13 +0000
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
Subject: [PATCH RFC 01/11] x86/msr: Switch rdmsr_on_cpu() to return a 64-bit quantity
Date: Tue, 28 Apr 2026 12:41:55 +0200
Message-ID: <20260428104205.916924-2-jgross@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428104205.916924-1-jgross@suse.com>
References: <20260428104205.916924-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D53E05BCC9

In order to prepare retiring rdmsrq_on_cpu() switch rdmsr_on_cpu() to
have the same interface as rdmsrq_on_cpu().

Switch all rdmsr_on_cpu() callers to use the new interface.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h                   |  8 ++---
 arch/x86/kernel/cpu/mce/amd.c                |  6 ++--
 arch/x86/kernel/cpu/mce/inject.c             |  8 ++---
 arch/x86/lib/msr-smp.c                       |  5 ++-
 drivers/cpufreq/amd_freq_sensitivity.c       |  4 +--
 drivers/cpufreq/p4-clockmod.c                | 32 ++++++++++----------
 drivers/cpufreq/speedstep-centrino.c         | 27 +++++++++--------
 drivers/hwmon/coretemp.c                     | 12 ++++----
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 22 ++++++++------
 9 files changed, 63 insertions(+), 61 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 9c2ea29e12a9..fcdaeddf4337 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -256,7 +256,7 @@ int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
 
 #ifdef CONFIG_SMP
-int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
+int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
@@ -269,9 +269,9 @@ int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 #else  /*  CONFIG_SMP  */
-static inline int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
+static inline int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
-	rdmsr(msr_no, *l, *h);
+	rdmsrq(msr_no, *q);
 	return 0;
 }
 static inline int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
@@ -292,7 +292,7 @@ static inline int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 				struct msr __percpu *msrs)
 {
-	rdmsr_on_cpu(0, msr_no, raw_cpu_ptr(&msrs->l), raw_cpu_ptr(&msrs->h));
+	rdmsr_on_cpu(0, msr_no, raw_cpu_ptr(&msrs->q));
 }
 static inline void wrmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 				struct msr __percpu *msrs)
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 6605a0224659..580e90e74e9e 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -969,13 +969,13 @@ store_threshold_limit(struct threshold_block *b, const char *buf, size_t size)
 
 static ssize_t show_error_count(struct threshold_block *b, char *buf)
 {
-	u32 lo, hi;
+	struct msr val;
 
 	/* CPU might be offline by now */
-	if (rdmsr_on_cpu(b->cpu, b->address, &lo, &hi))
+	if (rdmsr_on_cpu(b->cpu, b->address, &val.q))
 		return -ENODEV;
 
-	return sprintf(buf, "%u\n", ((hi & THRESHOLD_MAX) -
+	return sprintf(buf, "%u\n", ((val.h & THRESHOLD_MAX) -
 				     (THRESHOLD_MAX - b->threshold_limit)));
 }
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index d02c4f556cd0..fa13a8a4946b 100644
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
+	err = rdmsr_on_cpu(cpu, MSR_K7_HWCR, &val.q);
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
 
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index b8f63419e6ae..6e04aabda863 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -31,7 +31,7 @@ static void __wrmsr_on_cpu(void *info)
 	wrmsr(rv->msr_no, reg->l, reg->h);
 }
 
-int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
+int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
 	int err;
 	struct msr_info rv;
@@ -40,8 +40,7 @@ int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h)
 
 	rv.msr_no = msr_no;
 	err = smp_call_function_single(cpu, __rdmsr_on_cpu, &rv, 1);
-	*l = rv.reg.l;
-	*h = rv.reg.h;
+	*q = rv.reg.q;
 
 	return err;
 }
diff --git a/drivers/cpufreq/amd_freq_sensitivity.c b/drivers/cpufreq/amd_freq_sensitivity.c
index 13fed4b9e02b..63896478dcab 100644
--- a/drivers/cpufreq/amd_freq_sensitivity.c
+++ b/drivers/cpufreq/amd_freq_sensitivity.c
@@ -52,9 +52,9 @@ static unsigned int amd_powersave_bias_target(struct cpufreq_policy *policy,
 		return freq_next;
 
 	rdmsr_on_cpu(policy->cpu, MSR_AMD64_FREQ_SENSITIVITY_ACTUAL,
-		&actual.l, &actual.h);
+		&actual.q);
 	rdmsr_on_cpu(policy->cpu, MSR_AMD64_FREQ_SENSITIVITY_REFERENCE,
-		&reference.l, &reference.h);
+		&reference.q);
 	actual.h &= 0x00ffffff;
 	reference.h &= 0x00ffffff;
 
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 69c19233fcd4..393c4a5d2021 100644
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
+	rdmsr_on_cpu(cpu, MSR_IA32_THERM_STATUS, &val.q);
 
-	if (l & 0x01)
+	if (val.l & 0x01)
 		pr_debug("CPU#%d currently thermal throttled\n", cpu);
 
 	if (has_N44_O17_errata[cpu] &&
 	    (newstate == DC_25PT || newstate == DC_DFLT))
 		newstate = DC_38PT;
 
-	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &l, &h);
+	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &val.q);
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
+	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &val.q);
 
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
index 3e6e85a92212..b74c85128377 100644
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
+	rdmsr_on_cpu(cpu, MSR_IA32_PERF_STATUS, &val.q);
+	clock_freq = extract_clock(val.l, cpu, 0);
 
 	if (unlikely(clock_freq == 0)) {
 		/*
@@ -335,8 +335,8 @@ static unsigned int get_cur_freq(unsigned int cpu)
 		 * P-state transition (like TM2). Get the last freq set 
 		 * in PERF_CTL.
 		 */
-		rdmsr_on_cpu(cpu, MSR_IA32_PERF_CTL, &l, &h);
-		clock_freq = extract_clock(l, cpu, 1);
+		rdmsr_on_cpu(cpu, MSR_IA32_PERF_CTL, &val.q);
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
+			rdmsr_on_cpu(good_cpu, MSR_IA32_PERF_CTL, &oldmsr.q);
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
index 6a0d94711ead..fa02960ffff5 100644
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
+	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &val.q);
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
+		rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &val.q);
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
index 540109761f0a..fc7dbba4f9ca 100644
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
@@ -142,7 +143,7 @@ sys_set_trip_temp(struct thermal_zone_device *tzd,
 		return -EINVAL;
 
 	ret = rdmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			   &l, &h);
+			   &v.q);
 	if (ret < 0)
 		return ret;
 
@@ -155,20 +156,20 @@ sys_set_trip_temp(struct thermal_zone_device *tzd,
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
 
 	return wrmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			l, h);
+			    v.l, v.h);
 }
 
 /* Thermal zone callback registry */
@@ -277,7 +278,8 @@ static int pkg_temp_thermal_trips_init(int cpu, int tj_max,
 				       struct thermal_trip *trips, int num_trips)
 {
 	unsigned long thres_reg_value;
-	u32 mask, shift, eax, edx;
+	u32 mask, shift;
+	struct msr val;
 	int ret, i;
 
 	for (i = 0; i < num_trips; i++) {
@@ -291,11 +293,11 @@ static int pkg_temp_thermal_trips_init(int cpu, int tj_max,
 		}
 
 		ret = rdmsr_on_cpu(cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-				   &eax, &edx);
+				   &val.q);
 		if (ret < 0)
 			return ret;
 
-		thres_reg_value = (eax & mask) >> shift;
+		thres_reg_value = (val.l & mask) >> shift;
 
 		trips[i].temperature = thres_reg_value ?
 			tj_max - thres_reg_value * 1000 : THERMAL_TEMP_INVALID;
-- 
2.53.0

