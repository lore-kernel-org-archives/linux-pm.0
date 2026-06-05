Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7E3D7A19
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670633; cv=none; b=NDpCDvTf1SU5aKmU/zU9QoiFnmpka9nB1AjoZUgHaAR6liUTo4wGcCylk3RESekp8FElCwNmm2ITrbD4fXlYoCl/DX917C3ZnXD39YxJibOvXcnYTsQkvJ0GitM6Cpw25UV58y8Zpn7wzd4Ul3OTC5jiDJan9Lgqp1NvKd8NT+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670633; c=relaxed/simple;
	bh=d4vIem6l7fTXp/vMbKUi1yG/Tanij/jCUntbBgos64Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMoT3mH3WaoOHJFwV+7kMEL94orULsGHJo+iQ/ctpwKU6dHDNqlLjAWz1wMjs0Dv1LRhOfq0RhvkTDxKvfdPk/r62447VLSPGHPMaMwDUD2G+eax2+wCGobpSxj6Ffodcizt0uIIkmTdwADsHINc5M3bStsBbZ8jrwchzZSJW7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7476275992;
	Fri,  5 Jun 2026 14:43:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E26E8779A8;
	Fri,  5 Jun 2026 14:43:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eFg7NqHgImqXXAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 14:43:45 +0000
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
Subject: [PATCH v2 05/10] x86/msr: Switch wrmsr_on_cpu() users to wrmsrq_on_cpu()
Date: Fri,  5 Jun 2026 16:43:09 +0200
Message-ID: <20260605144314.3031049-6-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605144314.3031049-1-jgross@suse.com>
References: <20260605144314.3031049-1-jgross@suse.com>
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
X-Rspamd-Queue-Id: 7476275992
X-Rspamd-Action: no action

In order to prepare retiring wrmsr_on_cpu() switch wrmsr_on_cpu() users
to wrmsrq_on_cpu().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- instead of changing wrmsr_on_cpu(), use wrmsrq_on_cpu() (Ingo Molnar)
---
 arch/x86/events/intel/ds.c                   | 11 ++++-------
 arch/x86/include/asm/msr.h                   |  2 +-
 arch/x86/kernel/cpu/mce/inject.c             |  2 +-
 drivers/cpufreq/p4-clockmod.c                |  4 ++--
 drivers/cpufreq/speedstep-centrino.c         |  4 ++--
 drivers/thermal/intel/x86_pkg_temp_thermal.c |  2 +-
 6 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 7f0d515c07c5..5b9c01383f49 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -780,9 +780,7 @@ void init_debug_store_on_cpu(int cpu)
 	if (!ds)
 		return;
 
-	wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA,
-		     (u32)((u64)(unsigned long)ds),
-		     (u32)((u64)(unsigned long)ds >> 32));
+	wrmsrq_on_cpu(cpu, MSR_IA32_DS_AREA, (u64)(unsigned long)ds);
 }
 
 void fini_debug_store_on_cpu(int cpu)
@@ -790,7 +788,7 @@ void fini_debug_store_on_cpu(int cpu)
 	if (!per_cpu(cpu_hw_events, cpu).ds)
 		return;
 
-	wrmsr_on_cpu(cpu, MSR_IA32_DS_AREA, 0, 0);
+	wrmsrq_on_cpu(cpu, MSR_IA32_DS_AREA, 0);
 }
 
 static DEFINE_PER_CPU(void *, insn_buffer);
@@ -1095,8 +1093,7 @@ void init_arch_pebs_on_cpu(int cpu)
 	 * contiguous physical buffer (__alloc_pages_node() with order)
 	 */
 	arch_pebs_base = virt_to_phys(cpuc->pebs_vaddr) | PEBS_BUFFER_SHIFT;
-	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, (u32)arch_pebs_base,
-		     (u32)(arch_pebs_base >> 32));
+	wrmsrq_on_cpu(cpu, MSR_IA32_PEBS_BASE, arch_pebs_base);
 	x86_pmu.pebs_active = 1;
 }
 
@@ -1105,7 +1102,7 @@ inline void fini_arch_pebs_on_cpu(int cpu)
 	if (!x86_pmu.arch_pebs)
 		return;
 
-	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0, 0);
+	wrmsrq_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0);
 }
 
 /*
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 22f914f7affe..6e0d7a6335ff 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
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
index bee9c35762b8..6d30e7720f31 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -327,7 +327,7 @@ static int toggle_hw_mce_inject(unsigned int cpu, bool enable)
 
 	enable ? (val.l |= BIT(18)) : (val.l &= ~BIT(18));
 
-	err = wrmsr_on_cpu(cpu, MSR_K7_HWCR, val.l, val.h);
+	err = wrmsrq_on_cpu(cpu, MSR_K7_HWCR, val.q);
 	if (err)
 		pr_err("%s: error writing HWCR\n", __func__);
 
diff --git a/drivers/cpufreq/p4-clockmod.c b/drivers/cpufreq/p4-clockmod.c
index d96e8b665f39..c1690aa48193 100644
--- a/drivers/cpufreq/p4-clockmod.c
+++ b/drivers/cpufreq/p4-clockmod.c
@@ -68,7 +68,7 @@ static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 	rdmsrq_on_cpu(cpu, MSR_IA32_THERM_CONTROL, &val.q);
 	if (newstate == DC_DISABLE) {
 		pr_debug("CPU#%d disabling modulation\n", cpu);
-		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.l & ~(1<<4), val.h);
+		wrmsrq_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.q & ~(1ULL << 4));
 	} else {
 		pr_debug("CPU#%d setting duty cycle to %d%%\n",
 			cpu, ((125 * newstate) / 10));
@@ -79,7 +79,7 @@ static int cpufreq_p4_setdc(unsigned int cpu, unsigned int newstate)
 		 */
 		val.l = (val.l & ~14);
 		val.l = val.l | (1<<4) | ((newstate & 0x7)<<1);
-		wrmsr_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.l, val.h);
+		wrmsrq_on_cpu(cpu, MSR_IA32_THERM_CONTROL, val.q);
 	}
 
 	return 0;
diff --git a/drivers/cpufreq/speedstep-centrino.c b/drivers/cpufreq/speedstep-centrino.c
index cefee19d1100..9237ed8f2b1f 100644
--- a/drivers/cpufreq/speedstep-centrino.c
+++ b/drivers/cpufreq/speedstep-centrino.c
@@ -475,7 +475,7 @@ static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 			oldmsr.l |= msr;
 		}
 
-		wrmsr_on_cpu(good_cpu, MSR_IA32_PERF_CTL, oldmsr.l, oldmsr.h);
+		wrmsrq_on_cpu(good_cpu, MSR_IA32_PERF_CTL, oldmsr.q);
 		if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
 			break;
 
@@ -491,7 +491,7 @@ static int centrino_target(struct cpufreq_policy *policy, unsigned int index)
 		 */
 
 		for_each_cpu(j, covered_cpus)
-			wrmsr_on_cpu(j, MSR_IA32_PERF_CTL, oldmsr.l, oldmsr.h);
+			wrmsrq_on_cpu(j, MSR_IA32_PERF_CTL, oldmsr.q);
 	}
 	retval = 0;
 
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 2e7de8cf756d..144603c356a0 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -167,7 +167,7 @@ sys_set_trip_temp(struct thermal_zone_device *tzd,
 		v.l |= intr;
 	}
 
-	return wrmsr_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, v.l, v.h);
+	return wrmsrq_on_cpu(zonedev->cpu, MSR_IA32_PACKAGE_THERM_INTERRUPT, v.q);
 }
 
 /* Thermal zone callback registry */
-- 
2.54.0

