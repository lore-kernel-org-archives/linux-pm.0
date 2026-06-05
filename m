Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6834534AC
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643326; cv=none; b=SZrZI2///MNjI7jvEnZ7lGZuckBm2++Ssey2T2XNpDY8GM8oYKCLp3acimYW8mASt0M6lpfSCdRDA++kv97lSV3AKP4t2c/kJGnCE+N7ccA4l55YMOyfk8i1zzIpq3Amzgnf0mnbYkPtjaxy1oBZ4MIe8d8/EOPG/pyxUsiiRzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643326; c=relaxed/simple;
	bh=43XmXWjuSra01MQPnCKH7CvkNgX2R5nVh2AxfG9stAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tk4G2XAsxMfVLYmxUWaNgmtYvS/xqVqHds5+8xGMTqUaD7idDaZioviqs39/lUSsAEJGK9J8b5Et3XnKnX+vxRUMnQlxncgIoBAHN8qPECERWdGu/Oq3/P3xA0Ml7J0vl9RJJ4Acc6JKz7qh7kzt03MYGoIcvJ+rOqZpOkVkTk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AEFC96B110;
	Fri,  5 Jun 2026 07:08:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 057F7779A8;
	Fri,  5 Jun 2026 07:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aYgvAPl1ImqSHQAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 07:08:41 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
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
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 2/8] x86/msr: Switch all callers of rdmsrq_on_cpu() to use rdmsr_on_cpu()
Date: Fri,  5 Jun 2026 09:08:20 +0200
Message-ID: <20260605070826.2995913-3-jgross@suse.com>
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
X-Rspamd-Queue-Id: AEFC96B110
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

Now that rdmsr_on_cpu() has the same interface as rdmsrq_on_cpu(), the
callers of rdmsrq_on_cpu() can be switched to rdmsr_on_cpu() and
rdmsrq_on_cpu() can be removed.

At the same time switch the only user of rdmsrl_on_cpu() to
rdmsr_on_cpu() and drop rdmsrl_on_cpu(), too.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/events/intel/uncore_snbep.c          |  2 +-
 arch/x86/include/asm/msr.h                    |  7 ------
 arch/x86/kernel/cpu/intel_epb.c               |  4 ++--
 arch/x86/kernel/cpu/mce/inject.c              |  4 ++--
 arch/x86/kernel/cpu/microcode/intel.c         |  2 +-
 arch/x86/lib/msr-smp.c                        | 15 -------------
 drivers/cpufreq/acpi-cpufreq.c                |  4 ++--
 drivers/cpufreq/amd-pstate.c                  |  8 +++----
 drivers/cpufreq/intel_pstate.c                | 22 +++++++++----------
 .../intel/uncore-frequency/uncore-frequency.c |  6 ++---
 10 files changed, 26 insertions(+), 48 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 215d33e260ed..fee94698b611 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3695,7 +3695,7 @@ static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
 {
 	u64 msr_value;
 
-	if (rdmsrq_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER, &msr_value) ||
+	if (rdmsr_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER, &msr_value) ||
 			!(msr_value & SKX_MSR_CPU_BUS_VALID_BIT))
 		return -ENXIO;
 
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index fcdaeddf4337..8c96fc5c6169 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -258,7 +258,6 @@ int msr_clear_bit(u32 msr, u8 bit);
 #ifdef CONFIG_SMP
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
-int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
@@ -279,11 +278,6 @@ static inline int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 	wrmsr(msr_no, l, h);
 	return 0;
 }
-static inline int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
-{
-	rdmsrq(msr_no, *q);
-	return 0;
-}
 static inline int wrmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
 	wrmsrq(msr_no, q);
@@ -329,7 +323,6 @@ static inline int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 /* Compatibility wrappers: */
 #define rdmsrl(msr, val) rdmsrq(msr, val)
 #define wrmsrl(msr, val) wrmsrq(msr, val)
-#define rdmsrl_on_cpu(cpu, msr, q) rdmsrq_on_cpu(cpu, msr, q)
 
 #endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_MSR_H */
diff --git a/arch/x86/kernel/cpu/intel_epb.c b/arch/x86/kernel/cpu/intel_epb.c
index 2c56f8730f59..cb5a3c299f26 100644
--- a/arch/x86/kernel/cpu/intel_epb.c
+++ b/arch/x86/kernel/cpu/intel_epb.c
@@ -139,7 +139,7 @@ static ssize_t energy_perf_bias_show(struct device *dev,
 	u64 epb;
 	int ret;
 
-	ret = rdmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	ret = rdmsr_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
 	if (ret < 0)
 		return ret;
 
@@ -161,7 +161,7 @@ static ssize_t energy_perf_bias_store(struct device *dev,
 	else if (kstrtou64(buf, 0, &val) || val > MAX_EPB)
 		return -EINVAL;
 
-	ret = rdmsrq_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
+	ret = rdmsr_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
 	if (ret < 0)
 		return ret;
 
diff --git a/arch/x86/kernel/cpu/mce/inject.c b/arch/x86/kernel/cpu/mce/inject.c
index fa13a8a4946b..78649651c987 100644
--- a/arch/x86/kernel/cpu/mce/inject.c
+++ b/arch/x86/kernel/cpu/mce/inject.c
@@ -590,7 +590,7 @@ static int inj_bank_set(void *data, u64 val)
 	u64 cap;
 
 	/* Get bank count on target CPU so we can handle non-uniform values. */
-	rdmsrq_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
+	rdmsr_on_cpu(m->extcpu, MSR_IA32_MCG_CAP, &cap);
 	n_banks = cap & MCG_BANKCNT_MASK;
 
 	if (val >= n_banks) {
@@ -614,7 +614,7 @@ static int inj_bank_set(void *data, u64 val)
 	if (cpu_feature_enabled(X86_FEATURE_SMCA)) {
 		u64 ipid;
 
-		if (rdmsrq_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val), &ipid)) {
+		if (rdmsr_on_cpu(m->extcpu, MSR_AMD64_SMCA_MCx_IPID(val), &ipid)) {
 			pr_err("Error reading IPID on CPU%d\n", m->extcpu);
 			return -EINVAL;
 		}
diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index a4c0a0cf928b..0b49ee6ddd2e 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -663,7 +663,7 @@ static void stage_microcode(void)
 
 		pkg_id = topology_logical_package_id(cpu);
 
-		err = rdmsrq_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
+		err = rdmsr_on_cpu(cpu, MSR_IA32_MCU_STAGING_MBOX_ADDR, &mmio_pa);
 		if (WARN_ON_ONCE(err))
 			return;
 
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 6e04aabda863..7c96f003bfe0 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -46,21 +46,6 @@ int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 }
 EXPORT_SYMBOL(rdmsr_on_cpu);
 
-int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
-{
-	int err;
-	struct msr_info rv;
-
-	memset(&rv, 0, sizeof(rv));
-
-	rv.msr_no = msr_no;
-	err = smp_call_function_single(cpu, __rdmsr_on_cpu, &rv, 1);
-	*q = rv.reg.q;
-
-	return err;
-}
-EXPORT_SYMBOL(rdmsrq_on_cpu);
-
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 {
 	int err;
diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 21639d9ac753..43bf1c21c4ca 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -79,11 +79,11 @@ static bool boost_state(unsigned int cpu)
 	case X86_VENDOR_INTEL:
 	case X86_VENDOR_CENTAUR:
 	case X86_VENDOR_ZHAOXIN:
-		rdmsrq_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &msr);
+		rdmsr_on_cpu(cpu, MSR_IA32_MISC_ENABLE, &msr);
 		return !(msr & MSR_IA32_MISC_ENABLE_TURBO_DISABLE);
 	case X86_VENDOR_HYGON:
 	case X86_VENDOR_AMD:
-		rdmsrq_on_cpu(cpu, MSR_K7_HWCR, &msr);
+		rdmsr_on_cpu(cpu, MSR_K7_HWCR, &msr);
 		return !(msr & MSR_K7_HWCR_CPB_DIS);
 	}
 	return false;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 62b5d995281d..8da4f0f034e2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -204,7 +204,7 @@ static u8 msr_get_epp(struct amd_cpudata *cpudata)
 	u64 value;
 	int ret;
 
-	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
+	ret = rdmsr_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &value);
 	if (ret < 0) {
 		pr_debug("Could not retrieve energy perf value (%d)\n", ret);
 		return ret;
@@ -378,7 +378,7 @@ static int amd_pstate_init_floor_perf(struct cpufreq_policy *policy)
 	if (!cpu_feature_enabled(X86_FEATURE_CPPC_PERF_PRIO))
 		return 0;
 
-	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, &value);
+	ret = rdmsr_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ2, &value);
 	if (ret) {
 		pr_err("failed to read CPPC REQ2 value. Error (%d)\n", ret);
 		return ret;
@@ -476,7 +476,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	ret = rdmsrl_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
+	ret = rdmsr_on_cpu(cpudata->cpu, MSR_AMD_CPPC_REQ, &cppc_req);
 	if (ret)
 		return ret;
 
@@ -877,7 +877,7 @@ static int amd_pstate_init_boost_support(struct amd_cpudata *cpudata)
 		goto exit_err;
 	}
 
-	ret = rdmsrq_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
+	ret = rdmsr_on_cpu(cpudata->cpu, MSR_K7_HWCR, &boost_val);
 	if (ret) {
 		pr_err_once("failed to read initial CPU boost state!\n");
 		ret = -EIO;
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 1f093e346430..4cd3686f194a 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -632,8 +632,8 @@ static s16 intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
 		 * MSR_HWP_REQUEST, so need to read and get EPP.
 		 */
 		if (!hwp_req_data) {
-			epp = rdmsrq_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST,
-					    &hwp_req_data);
+			epp = rdmsr_on_cpu(cpu_data->cpu, MSR_HWP_REQUEST,
+					   &hwp_req_data);
 			if (epp)
 				return epp;
 		}
@@ -886,7 +886,7 @@ static ssize_t show_base_frequency(struct cpufreq_policy *policy, char *buf)
 	if (ratio <= 0) {
 		u64 cap;
 
-		rdmsrq_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap);
+		rdmsr_on_cpu(policy->cpu, MSR_HWP_CAPABILITIES, &cap);
 		ratio = HWP_GUARANTEED_PERF(cap);
 	}
 
@@ -1187,7 +1187,7 @@ static void __intel_pstate_get_hwp_cap(struct cpudata *cpu)
 {
 	u64 cap;
 
-	rdmsrq_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
+	rdmsr_on_cpu(cpu->cpu, MSR_HWP_CAPABILITIES, &cap);
 	WRITE_ONCE(cpu->hwp_cap_cached, cap);
 	cpu->pstate.max_pstate = HWP_GUARANTEED_PERF(cap);
 	cpu->pstate.turbo_pstate = HWP_HIGHEST_PERF(cap);
@@ -1269,7 +1269,7 @@ static void intel_pstate_hwp_set(unsigned int cpu)
 	if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE)
 		min = max;
 
-	rdmsrq_on_cpu(cpu, MSR_HWP_REQUEST, &value);
+	rdmsr_on_cpu(cpu, MSR_HWP_REQUEST, &value);
 
 	value &= ~HWP_MIN_PERF(~0L);
 	value |= HWP_MIN_PERF(min);
@@ -2156,7 +2156,7 @@ static int core_get_min_pstate(int cpu)
 {
 	u64 value;
 
-	rdmsrq_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
+	rdmsr_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
 	return (value >> 40) & 0xFF;
 }
 
@@ -2164,7 +2164,7 @@ static int core_get_max_pstate_physical(int cpu)
 {
 	u64 value;
 
-	rdmsrq_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
+	rdmsr_on_cpu(cpu, MSR_PLATFORM_INFO, &value);
 	return (value >> 8) & 0xFF;
 }
 
@@ -2209,7 +2209,7 @@ static int core_get_max_pstate(int cpu)
 	int tdp_ratio;
 	int err;
 
-	rdmsrq_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
+	rdmsr_on_cpu(cpu, MSR_PLATFORM_INFO, &plat_info);
 	max_pstate = (plat_info >> 8) & 0xFF;
 
 	tdp_ratio = core_get_tdp_ratio(cpu, plat_info);
@@ -2241,7 +2241,7 @@ static int core_get_turbo_pstate(int cpu)
 	u64 value;
 	int nont, ret;
 
-	rdmsrq_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
+	rdmsr_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
 	nont = core_get_max_pstate(cpu);
 	ret = (value) & 255;
 	if (ret <= nont)
@@ -2264,7 +2264,7 @@ static int knl_get_turbo_pstate(int cpu)
 	u64 value;
 	int nont, ret;
 
-	rdmsrq_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
+	rdmsr_on_cpu(cpu, MSR_TURBO_RATIO_LIMIT, &value);
 	nont = core_get_max_pstate(cpu);
 	ret = (((value) >> 8) & 0xFF);
 	if (ret <= nont)
@@ -3318,7 +3318,7 @@ static int intel_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 		intel_pstate_get_hwp_cap(cpu);
 
-		rdmsrq_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
+		rdmsr_on_cpu(cpu->cpu, MSR_HWP_REQUEST, &value);
 		WRITE_ONCE(cpu->hwp_req_cached, value);
 
 		cpu->epp_cached = intel_pstate_get_epp(cpu, value);
diff --git a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
index 667f2c8b9594..b9878a4d391b 100644
--- a/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
+++ b/drivers/platform/x86/intel/uncore-frequency/uncore-frequency.c
@@ -52,7 +52,7 @@ static int uncore_read_control_freq(struct uncore_data *data, unsigned int *valu
 	if (data->control_cpu < 0)
 		return -ENXIO;
 
-	ret = rdmsrq_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, &cap);
+	ret = rdmsr_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, &cap);
 	if (ret)
 		return ret;
 
@@ -77,7 +77,7 @@ static int uncore_write_control_freq(struct uncore_data *data, unsigned int inpu
 	if (data->control_cpu < 0)
 		return -ENXIO;
 
-	ret = rdmsrq_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, &cap);
+	ret = rdmsr_on_cpu(data->control_cpu, MSR_UNCORE_RATIO_LIMIT, &cap);
 	if (ret)
 		return ret;
 
@@ -106,7 +106,7 @@ static int uncore_read_freq(struct uncore_data *data, unsigned int *freq)
 	if (data->control_cpu < 0)
 		return -ENXIO;
 
-	ret = rdmsrq_on_cpu(data->control_cpu, MSR_UNCORE_PERF_STATUS, &ratio);
+	ret = rdmsr_on_cpu(data->control_cpu, MSR_UNCORE_PERF_STATUS, &ratio);
 	if (ret)
 		return ret;
 
-- 
2.54.0

