Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A03F54B2
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 10:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372950; cv=none; b=QBCpW18a3Ru3uQm16eEK7Nj+ZAZGW1EgqwZACSCLzKhrCm7YW8lnuweK0sEKsvTid+Wsswvifc17rGZVo3BC5dSRiZG0rznNozMpkHrwPEoFHB5Z8Ij6ELe5t+hO855B1MYAyleCMgMhaik5Hlw0rMsVCcp4s9RsM+DysR3tg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372950; c=relaxed/simple;
	bh=Gf8ackZertnXPafoInOrAzwvVe6JAibp1NNSXkytflc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FW7Oo/aqDKrHZ6LxnXPdpyKWCn7ySq+vqEPPYZ2F8YmZOhuHiNEXIVV9OHgT4CTe2OD4YMIA0oIVsh+7Dk4gFcTHFQpJGjluYrDOw1zQn84eNJN4PXR1oG2M9r3z5bhtWAdpRm4LxvXRrF2VOY5kMJIueY+dGxrgb8BLW9ddKEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qNpMgEHL; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qNpMgEHL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qNpMgEHL";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qNpMgEHL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2C396A7E7;
	Tue, 28 Apr 2026 10:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1xUW08oHEWrSvUzNmtNUMunFqMW5zGF+ipBd00CVKM=;
	b=qNpMgEHL1+qmM3JcVfUThjrXdMAHorhVZDn0+PG/stOsoqVkVr50LbFPseTXrysMnS2YD8
	qkqZLNXvstg0RdXi9jYgBCaRPjXyBPmq/E2f2yBANl231RfwC64X/t7lXaOehazlxut76R
	o2QyMCi9BZ74NZ9AaW8fY5vyMtJOMKQ=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R1xUW08oHEWrSvUzNmtNUMunFqMW5zGF+ipBd00CVKM=;
	b=qNpMgEHL1+qmM3JcVfUThjrXdMAHorhVZDn0+PG/stOsoqVkVr50LbFPseTXrysMnS2YD8
	qkqZLNXvstg0RdXi9jYgBCaRPjXyBPmq/E2f2yBANl231RfwC64X/t7lXaOehazlxut76R
	o2QyMCi9BZ74NZ9AaW8fY5vyMtJOMKQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B40B593B0;
	Tue, 28 Apr 2026 10:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OkiSBRGP8GmPPQAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 28 Apr 2026 10:42:25 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Tony Luck <tony.luck@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH RFC 03/11] x86/msr: Switch wrmsr_on_cpu() to use a 64-bit quantity
Date: Tue, 28 Apr 2026 12:41:57 +0200
Message-ID: <20260428104205.916924-4-jgross@suse.com>
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
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

In order to prepare retiring wrmsrq_on_cpu() switch wrmsr_on_cpu() to
have the same interface as wrmsrq_on_cpu().

Switch all wrmsr_on_cpu() callers to use the new interface.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/events/intel/ds.c                   | 11 ++++-------
 arch/x86/include/asm/msr.h                   |  8 ++++----
 arch/x86/kernel/cpu/mce/inject.c             |  2 +-
 arch/x86/lib/msr-smp.c                       |  5 ++---
 drivers/cpufreq/p4-clockmod.c                |  4 ++--
 drivers/cpufreq/speedstep-centrino.c         |  4 ++--
 drivers/thermal/intel/x86_pkg_temp_thermal.c |  2 +-
 7 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7f0d515c07c5..06d6d06c7a75 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -780,9 +780,7 @@ void init_debug_store_on_cpu(int cpu)
 	if (!ds)
 		return;
 
-	wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA,
-		     (u32)((u64)(unsigned long)ds),
-		     (u32)((u64)(unsigned long)ds >> 32));
+	wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA, (u64)(unsigned long)ds);
 }
 
 void fini_debug_store_on_cpu(int cpu)
@@ -790,7 +788,7 @@ void fini_debug_store_on_cpu(int cpu)
 	if (!per_cpu(cpu_hw_events, cpu).ds)
 		return;
 
-	wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA, 0, 0);
+	wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA, 0);
 }
 
 static DEFINE_PER_CPU(void *, insn_buffer);
@@ -1095,8 +1093,7 @@ void init_arch_pebs_on_cpu(int cpu)
 	 * contiguous physical buffer (__alloc_pages_node() with order)
 	 */
 	arch_pebs_base = virt_to_phys(cpuc->pebs_vaddr) | PEBS_BUFFER_SHIFT;
-	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, (u32)arch_pebs_base,
-		     (u32)(arch_pebs_base >> 32));
+	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, arch_pebs_base);
 	x86_pmu.pebs_active = 1;
 }
 
@@ -1105,7 +1102,7 @@ inline void fini_arch_pebs_on_cpu(int cpu)
 	if (!x86_pmu.arch_pebs)
 		return;
 
-	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0, 0);
+	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0);
 }
 
 /*
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 8c96fc5c6169..a004440b4c0a 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -257,7 +257,7 @@ int msr_clear_bit(u32 msr, u8 bit);
 
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
-int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
+int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
@@ -273,9 +273,9 @@ static inline int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 	rdmsrq(msr_no, *q);
 	return 0;
 }
-static inline int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
+static inline int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
-	wrmsr(msr_no, l, h);
+	wrmsrq(msr_no, q);
 	return 0;
 }
 static inline int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
@@ -291,7 +291,7 @@ static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 static inline void wrmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 				struct msr __percpu *msrs)
 {
-	wrmsr_on_cpu(0, msr_no, raw_cpu_read(msrs->l), raw_cpu_read(msrs->h));
+	wrmsrq_on_cpu(0, msr_no, raw_cpu_read(msrs->q));
 }
 static inline int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no,
 				    u32 *l, u32 *h)
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index 78649651c987..2d75098211b3 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -327,7 +327,7 @@ static int toggle_hw_mce_inject(unsigned int cpu, bool enable)
 
 	enable ? (val.l |= BIT(18)) : (val.l &= ~BIT(18));
 
-	err = wrmsr_on_cpu(cpu, MSR_K7_HWCR, val.l, val.h);
+	err = wrmsr_on_cpu(cpu, MSR_K7_HWCR, val.q);
 	if (err)
 		pr_err("%s: error writing HWCR\n", __func__);
 
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 7c96f003bfe0..0b4f3c4e4f82 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -46,7 +46,7 @@ int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 }
 EXPORT_SYMBOL(rdmsr_on_cpu);
 
-int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
+int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
 	int err;
 	struct msr_info rv;
@@ -54,8 +54,7 @@ int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 	memset(&rv, 0, sizeof(rv));
 
 	rv.msr_no = msr_no;
-	rv.reg.l = l;
-	rv.reg.h = h;
+	rv.reg.q = q;
 	err = smp_call_function_single(cpu, __wrmsr_on_cpu, &rv, 1);
 
 	return err;
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index 393c4a5d2021..409c0210e48a 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -68,7 +68,7 @@ static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 	rdmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &val.q);
 	if (newstate == DC_DISABLE) {
 		pr_debug("CPU#%d disabling modulation\n", cpu);
-		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.l & ~(1<<4), val.h);
+		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.q & ~(1ULL << 4));
 	} else {
 		pr_debug("CPU#%d setting duty cycle to %d%%\n",
 			cpu, ((125 * newstate) / 10));
@@ -79,7 +79,7 @@ static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 		 */
 		val.l = (val.l & ~14);
 		val.l = val.l | (1<<4) | ((newstate & 0x7)<<1);
-		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.l, val.h);
+		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.q);
 	}
 
 	return 0;
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index b74c85128377..121cddb1430f 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -475,7 +475,7 @@ static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 			oldmsr.l |= msr;
 		}
 
-		wrmsr_on_cpu(good_cpu, MSR_IA32_PERF_CTL, oldmsr.l, oldmsr.h);
+		wrmsr_on_cpu(good_cpu, MSR_IA32_PERF_CTL, oldmsr.q);
 		if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
 			break;
 
@@ -491,7 +491,7 @@ static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 		 */
 
 		for_each_cpu(j, covered_cpus)
-			wrmsr_on_cpu(j, MSR_IA32_PERF_CTL, oldmsr.l, oldmsr.h);
+			wrmsr_on_cpu(j, MSR_IA32_PERF_CTL, oldmsr.q);
 	}
 	retval = 0;
 
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index fc7dbba4f9ca..e52d35015486 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -169,7 +169,7 @@ sys_set_trip_temp(struct thermal_zone_device *tzd,
 	}
 
 	return wrmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT,
-			    v.l, v.h);
+			    v.q);
 }
 
 /* Thermal zone callback registry */
-- 
2.53.0

