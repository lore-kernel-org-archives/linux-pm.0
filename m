Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5091451064
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 07:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643335; cv=none; b=DhzmqpIWUkwH9ovz0F5s/QY3dwWBJCRbNcTul7rx0imqODDQsaqWGcv+6X5tad1MojcslAVlg5DS5As/tkUPdoFBzHB7Ad60u0CjjfYkyX8jW4zGknOvZhr6iErrDNzEKTwEN9WomhCzbTnX1W1rv/hjiqKoRyMGX0DIMeAz3u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643335; c=relaxed/simple;
	bh=zSNBIIgR6mfJTe3YixCKaS8GuSKPaI7bdtFhdaHF6pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0H94TzefgguTwQNj6Tpc03dQTBqThJkKvMp3L7+/3R5pTqIB3+h7KIvga1sY932Hz+RXUu2pGPPhR+3YUuMGGEKRXmx5Xt6CvHtIUIAUzlhz3LuOnpPfQaSoP7bS5dUXiZwS3jO43wqMJiA9HWK2Gld36Wwn9JWIUqLoqIKf2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A35276B10F;
	Fri,  5 Jun 2026 07:08:47 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 19786779A8;
	Fri,  5 Jun 2026 07:08:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7Bn/BP91ImoWHgAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 07:08:47 +0000
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
Subject: [PATCH 3/8] x86/msr: Switch wrmsr_on_cpu() to use a 64-bit quantity
Date: Fri,  5 Jun 2026 09:08:21 +0200
Message-ID: <20260605070826.2995913-4-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605070826.2995913-1-jgross@suse.com>
References: <20260605070826.2995913-1-jgross@suse.com>
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
X-Rspamd-Queue-Id: A35276B10F
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

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
2.54.0

