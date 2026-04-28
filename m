Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1167407563
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372957; cv=none; b=OuJvm8IssDp5cTH0ySSEmOSLvAj+Kzp5uG1nK1XNqs7Hm4EhA0BSU+zJJyBOFmALHrMI7NNnr+tpo/DG0/Ta/gTxNXxRRFR3CzWrzdgwdPihpz7a9z0p2Amtfvt/x3aWhzn1qCKaDdxmZMfgI+jcw++1by9SPyHjAcgZTnI4IPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372957; c=relaxed/simple;
	bh=ggPkkNezF0ink7Dmb4Kx39NzjdeMv6er/ICeigdhgRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv6/h9oMAHcb1E5+l1d/WYIvkWMsNBLTNniXNamro3dmTdRQkSSOmq5xMwBq6epq+aoiJS7TbTpVbYYr/OmNn6kI0G2yWoU5Gdtsl4NrtAlksrCwumQ4djTzBYMTzpRKbW+EFCKEIqW/my+OTJryMx0gdxj1CwmU3kk+jgvD3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LJ/xLhtK; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=LJ/xLhtK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LJ/xLhtK";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="LJ/xLhtK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 60CD56A823;
	Tue, 28 Apr 2026 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZkpMjoZu6+stmVt3tJaw5TDStq/ADijiOMSGhT0sbQ=;
	b=LJ/xLhtKlnbRhWAiVzt7aXgVh4FxWM2qV+GkrQNDQk5VOHo+iZzaDM0BmyjTIK4Ik4tBvk
	s5yrxqDonr4yrvLi00wGhcnCBrYURIaMhnsvrb6SVp7ZfHd5W/6bpdNaxRtD96v6+Bsnrv
	IM2s67EAKO059dxeaxGIsUR6ndXCzI0=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="LJ/xLhtK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FZkpMjoZu6+stmVt3tJaw5TDStq/ADijiOMSGhT0sbQ=;
	b=LJ/xLhtKlnbRhWAiVzt7aXgVh4FxWM2qV+GkrQNDQk5VOHo+iZzaDM0BmyjTIK4Ik4tBvk
	s5yrxqDonr4yrvLi00wGhcnCBrYURIaMhnsvrb6SVp7ZfHd5W/6bpdNaxRtD96v6+Bsnrv
	IM2s67EAKO059dxeaxGIsUR6ndXCzI0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC9C4593B0;
	Tue, 28 Apr 2026 10:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ILGvOBaP8GmlPQAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 28 Apr 2026 10:42:30 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH RFC 04/11] x86/msr: Switch all callers of wrmsrq_on_cpu() to use wrmsr_on_cpu()
Date: Tue, 28 Apr 2026 12:41:58 +0200
Message-ID: <20260428104205.916924-5-jgross@suse.com>
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
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RCPT_COUNT_TWELVE(0.00)[20];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 60CD56A823
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Now that wrmsr_on_cpu() has the same interface as wrmsrq_on_cpu(), the
callers of wrmsrq_on_cpu() can be switched to wrmsr_on_cpu() and
wrmsrq_on_cpu() can be removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h                    |  8 +----
 arch/x86/kernel/cpu/intel_epb.c               |  4 +--
 arch/x86/lib/msr-smp.c                        | 16 ---------
 drivers/cpufreq/amd-pstate.c                  |  8 ++---
 drivers/cpufreq/intel_pstate.c                | 36 +++++++++----------
 drivers/platform/x86/amd/hfi/hfi.c            |  4 +--
 .../intel/uncore-frequency/uncore-frequency.c |  6 ++--
 7 files changed, 30 insertions(+), 52 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index a004440b4c0a..c0a3bfba6b56 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -258,7 +258,6 @@ int msr_clear_bit(u32 msr, u8 bit);
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
-int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
@@ -278,11 +277,6 @@ static inline int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 	wrmsrq(msr_no, q);
 	return 0;
 }
-static inline int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
-{
-	wrmsrq(msr_no, q);
-	return 0;
-}
 static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 				struct msr __percpu *msrs)
 {
@@ -291,7 +285,7 @@ static inline void rdmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 static inline void wrmsr_on_cpus(const struct cpumask *m, u32 msr_no,
 				struct msr __percpu *msrs)
 {
-	wrmsrq_on_cpu(0, msr_no, raw_cpu_read(msrs->q));
+	wrmsr_on_cpu(0, msr_no, raw_cpu_read(msrs->q));
 }
 static inline int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no,
 				    u32 *l, u32 *h)
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index cb5a3c299f26..7533f47bf63d 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -165,8 +165,8 @@ static ssize_t energy_perf_bias_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = wrmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
-			    (epb & ~EPB_MASK) | val);
+	ret = wrmsr_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS,
+			   (epb & ~EPB_MASK) | val);
 	if (ret < 0)
 		return ret;
 
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 0b4f3c4e4f82..42d42641f2aa 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -61,22 +61,6 @@ int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 }
 EXPORT_SYMBOL(wrmsr_on_cpu);
 
-int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
-{
-	int err;
-	struct msr_info rv;
-
-	memset(&rv, 0, sizeof(rv));
-
-	rv.msr_no = msr_no;
-	rv.reg.q = q;
-
-	err = smp_call_function_single(cpu, __wrmsr_on_cpu, &rv, 1);
-
-	return err;
-}
-EXPORT_SYMBOL(wrmsrq_on_cpu);
-
 static void __rwmsr_on_cpus(const struct cpumask *mask, u32 msr_no,
 			    struct msr __percpu *msrs,
 			    void (*msr_func) (void *info))
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index a6fc22f770c3..543b34006918 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -271,7 +271,7 @@ static int msr_update_perf(struct cpufreq_policy *policy, u8 min_perf,
 	if (fast_switch) {
 		wrmsrq(MSR_AMD_CPPC_REQ, value);
 	} else {
-		int ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+		int ret = wrmsr_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 
 		if (ret)
 			return ret;
@@ -319,7 +319,7 @@ static int msr_set_epp(struct cpufreq_policy *policy, u8 epp)
 	if (value == prev)
 		return 0;
 
-	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
+	ret = wrmsr_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, value);
 	if (ret) {
 		pr_err("failed to set energy perf value (%d)\n", ret);
 		return ret;
@@ -357,7 +357,7 @@ static int amd_pstate_set_floor_perf(struct cpufreq_policy *policy, u8 perf)
 		goto out_trace;
 	}
 
-	ret = wrmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, value);
+	ret = wrmsr_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, value);
 	if (ret) {
 		changed = false;
 		pr_err("failed to set CPPC REQ2 value. Error (%d)\n", ret);
@@ -900,7 +900,7 @@ static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
 
 static void amd_perf_ctl_reset(unsigned int cpu)
 {
-	wrmsrq_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
+	wrmsr_on_cpu(cpu, MSR_AMD_PERF_CTL, 0);
 }
 
 #define CPPC_MAX_PERF	U8_MAX
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index e5b30a53c49a..08214a0561e7 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -736,7 +736,7 @@ static int intel_pstate_set_epp(struct cpudata *cpu, u32 epp)
 	 * function, so it cannot run in parallel with the update below.
 	 */
 	WRITE_ONCE(cpu->hwp_req_cached, value);
-	ret = wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+	ret = wrmsr_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 	if (!ret)
 		cpu->epp_cached = epp;
 
@@ -1315,7 +1315,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 
 skip_epp:
 	WRITE_ONCE(cpu_data->hwp_req_cached, value);
-	wrmsrq_on_cpu(cpu, MSR_HWP_REQUEST, value);
+	wrmsr_on_cpu(cpu, MSR_HWP_REQUEST, value);
 }
 
 static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata);
@@ -1362,7 +1362,7 @@ static void intel_pstate_hwp_offline(struct cpudata *cpu)
 	if (boot_cpu_has(X86_FEATURE_HWP_EPP))
 		value |= HWP_ENERGY_PERF_PREFERENCE(HWP_EPP_POWERSAVE);
 
-	wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+	wrmsr_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 
 	mutex_lock(&hybrid_capacity_lock);
 
@@ -1411,7 +1411,7 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata);
 static void intel_pstate_hwp_reenable(struct cpudata *cpu)
 {
 	intel_pstate_hwp_enable(cpu);
-	wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, READ_ONCE(cpu->hwp_req_cached));
+	wrmsr_on_cpu(cpu->cpu, MSR_HWP_REQUEST, READ_ONCE(cpu->hwp_req_cached));
 }
 
 static int intel_pstate_suspend(struct cpufreq_policy *policy)
@@ -1919,7 +1919,7 @@ static void intel_pstate_notify_work(struct work_struct *work)
 		hybrid_update_capacity(cpudata);
 	}
 
-	wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
+	wrmsr_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 }
 
 static DEFINE_RAW_SPINLOCK(hwp_notify_lock);
@@ -1969,8 +1969,8 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 	if (!cpu_feature_enabled(X86_FEATURE_HWP_NOTIFY))
 		return;
 
-	/* wrmsrq_on_cpu has to be outside spinlock as this can result in IPC */
-	wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+	/* wrmsr_on_cpu has to be outside spinlock as this can result in IPC */
+	wrmsr_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
 	raw_spin_lock_irq(&hwp_notify_lock);
 	cancel_work = cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask);
@@ -1997,9 +1997,9 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 		if (cpu_feature_enabled(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))
 			interrupt_mask |= HWP_HIGHEST_PERF_CHANGE_REQ;
 
-		/* wrmsrq_on_cpu has to be outside spinlock as this can result in IPC */
-		wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, interrupt_mask);
-		wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
+		/* wrmsr_on_cpu has to be outside spinlock as this can result in IPC */
+		wrmsr_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, interrupt_mask);
+		wrmsr_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 	}
 }
 
@@ -2038,9 +2038,9 @@ static void intel_pstate_hwp_enable(struct cpudata *cpudata)
 {
 	/* First disable HWP notification interrupt till we activate again */
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
-		wrmsrq_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
+		wrmsr_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
-	wrmsrq_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
+	wrmsr_on_cpu(cpudata->cpu, MSR_PM_ENABLE, 0x1);
 
 	intel_pstate_enable_hwp_interrupt(cpudata);
 
@@ -2306,8 +2306,8 @@ static void intel_pstate_set_pstate(struct cpudata *cpu, int pstate)
 	 * the CPU being updated, so force the register update to run on the
 	 * right CPU.
 	 */
-	wrmsrq_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
-		      pstate_funcs.get_val(cpu, pstate));
+	wrmsr_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
+		     pstate_funcs.get_val(cpu, pstate));
 }
 
 static void intel_pstate_set_min_pstate(struct cpudata *cpu)
@@ -3164,7 +3164,7 @@ static void intel_cpufreq_hwp_update(struct cpudata *cpu, u32 min, u32 max,
 	if (fast_switch)
 		wrmsrq(MSR_HWP_REQUEST, value);
 	else
-		wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+		wrmsr_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 }
 
 static void intel_cpufreq_perf_ctl_update(struct cpudata *cpu,
@@ -3174,8 +3174,8 @@ static void intel_cpufreq_perf_ctl_update(struct cpudata *cpu,
 		wrmsrq(MSR_IA32_PERF_CTL,
 		       pstate_funcs.get_val(cpu, target_pstate));
 	else
-		wrmsrq_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
-			      pstate_funcs.get_val(cpu, target_pstate));
+		wrmsr_on_cpu(cpu->cpu, MSR_IA32_PERF_CTL,
+			     pstate_funcs.get_val(cpu, target_pstate));
 }
 
 static int intel_cpufreq_update_pstate(struct cpufreq_policy *policy,
@@ -3385,7 +3385,7 @@ static int intel_cpufreq_suspend(struct cpufreq_policy *policy)
 		 * written by it may not be suitable.
 		 */
 		value &= ~HWP_DESIRED_PERF(~0L);
-		wrmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
+		wrmsr_on_cpu(cpu->cpu, MSR_HWP_REQUEST, value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
 	}
 
diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index 83863a5e0fbc..580fbc3648bf 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -260,11 +260,11 @@ static int amd_hfi_set_state(unsigned int cpu, bool state)
 {
 	int ret;
 
-	ret = wrmsrq_on_cpu(cpu, MSR_AMD_WORKLOAD_CLASS_CONFIG, state ? 1 : 0);
+	ret = wrmsr_on_cpu(cpu, MSR_AMD_WORKLOAD_CLASS_CONFIG, state ? 1 : 0);
 	if (ret)
 		return ret;
 
-	return wrmsrq_on_cpu(cpu, MSR_AMD_WORKLOAD_HRST, 0x1);
+	return wrmsr_on_cpu(cpu, MSR_AMD_WORKLOAD_HRST, 0x1);
 }
 
 /**
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index b9878a4d391b..c4c24a355854 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -89,7 +89,7 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 		cap |= FIELD_PREP(UNCORE_MIN_RATIO_MASK, input);
 	}
 
-	ret = wrmsrq_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, cap);
+	ret = wrmsr_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, cap);
 	if (ret)
 		return ret;
 
@@ -213,8 +213,8 @@ static int uncore_pm_notify(struct notifier_block *nb, unsigned long mode,
 			if (!data || !data->valid || !data->stored_uncore_data)
 				return 0;
 
-			wrmsrq_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT,
-				      data->stored_uncore_data);
+			wrmsr_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT,
+				     data->stored_uncore_data);
 		}
 		break;
 	default:
-- 
2.53.0

