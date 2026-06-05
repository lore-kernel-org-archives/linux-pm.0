Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8075944DB6D
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 07:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643348; cv=none; b=HVNn070XFcEfAiCeT73946gWmv2nThKuJvDANSYGWPDfck2lbI/0HIY1xm0qlEbate7Jw6I5ZLiAo8gFkpLm7YIF1Wx2RL/NWVgjgeRZkmYM+bk4/yb53z1oCRfBkC1qUrNxl2teOzohQ5UZ1uurtsQbxLpkmkjCKGY2LOpTQ6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643348; c=relaxed/simple;
	bh=RY2rv12IFW45zFsFv/658LwvQ7uI0iEPKcBPzuml9TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MO5B171xUGKaXxtqtk1d/cKgLy7ZXYFxYS+Bt+Mfu02hp16UuudFO6Yd5ZK5imQUJmOp/QfstKeh/bjRWmBHgUdDLmHbVLyg0tdVNNhLR0dS0D1UvGWmxGJ7su0FEiIBgYTP2KbB5IF9FyK27aKnDDCCnvJzz/aL6z0Igdaeg1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0265C75814;
	Fri,  5 Jun 2026 07:09:05 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C4C4779A8;
	Fri,  5 Jun 2026 07:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xz1uFRB2ImopHgAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 07:09:04 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-acpi@vger.kernel.org,
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
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Huang Rui <ray.huang@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6/8] x86/msr: Switch all callers of rdmsrq_safe_on_cpu() to use rdmsr_safe_on_cpu()
Date: Fri,  5 Jun 2026 09:08:24 +0200
Message-ID: <20260605070826.2995913-7-jgross@suse.com>
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
X-Rspamd-Queue-Id: 0265C75814
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

Now that rdmsr_safe_on_cpu() has the same interface as
rdmsrq_safe_on_cpu(), the callers of rdmsrq_safe_on_cpu() can be
switched to rdmsr_safe_on_cpu() and rdmsrq_safe_on_cpu() can be
removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/events/intel/pt.c                             |  2 +-
 arch/x86/events/intel/uncore_discovery.c               |  2 +-
 arch/x86/include/asm/msr.h                             |  5 -----
 arch/x86/kernel/acpi/cppc.c                            |  6 +++---
 arch/x86/lib/msr-smp.c                                 | 10 ----------
 drivers/cpufreq/amd-pstate-ut.c                        |  2 +-
 drivers/cpufreq/amd-pstate.c                           |  3 +--
 drivers/cpufreq/intel_pstate.c                         |  6 +++---
 .../x86/intel/speed_select_if/isst_if_common.c         |  4 ++--
 drivers/powercap/intel_rapl_msr.c                      |  2 +-
 10 files changed, 13 insertions(+), 29 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index b5726b50e77d..7c92146b06ea 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -1840,7 +1840,7 @@ static __init int pt_init(void)
 	for_each_online_cpu(cpu) {
 		u64 ctl;
 
-		ret = rdmsrq_safe_on_cpu(cpu, MSR_IA32_RTIT_CTL, &ctl);
+		ret = rdmsr_safe_on_cpu(cpu, MSR_IA32_RTIT_CTL, &ctl);
 		if (!ret && (ctl & RTIT_CTL_TRACEEN))
 			prior_warn++;
 	}
diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel/uncore_discovery.c
index 583cbd06b9b8..0853a9e02fda 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -405,7 +405,7 @@ static bool uncore_discovery_msr(struct uncore_discovery_domain *domain)
 		if (__test_and_set_bit(die, die_mask))
 			continue;
 
-		if (rdmsrq_safe_on_cpu(cpu, domain->discovery_base, &base))
+		if (rdmsr_safe_on_cpu(cpu, domain->discovery_base, &base))
 			continue;
 
 		if (!base)
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index b3b43bc04b69..f2d14c670140 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -262,7 +262,6 @@ void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
-int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
@@ -295,10 +294,6 @@ static inline int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 {
 	return wrmsr_safe(msr_no, l, h);
 }
-static inline int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
-{
-	return rdmsrq_safe(msr_no, q);
-}
 static inline int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
 	return wrmsrq_safe(msr_no, q);
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index be4c5e9e5ff6..86bf2dafdf72 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -49,7 +49,7 @@ int cpc_read_ffh(int cpunum, struct cpc_reg *reg, u64 *val)
 {
 	int err;
 
-	err = rdmsrq_safe_on_cpu(cpunum, reg->address, val);
+	err = rdmsr_safe_on_cpu(cpunum, reg->address, val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
 				       reg->bit_offset);
@@ -65,7 +65,7 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 	u64 rd_val;
 	int err;
 
-	err = rdmsrq_safe_on_cpu(cpunum, reg->address, &rd_val);
+	err = rdmsr_safe_on_cpu(cpunum, reg->address, &rd_val);
 	if (!err) {
 		u64 mask = GENMASK_ULL(reg->bit_offset + reg->bit_width - 1,
 				       reg->bit_offset);
@@ -147,7 +147,7 @@ int amd_get_highest_perf(unsigned int cpu, u32 *highest_perf)
 	int ret;
 
 	if (cpu_feature_enabled(X86_FEATURE_CPPC)) {
-		ret = rdmsrq_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &val);
+		ret = rdmsr_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &val);
 		if (ret)
 			goto out;
 
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index 0dc3921e0259..fa22ac662c1d 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -186,16 +186,6 @@ int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 }
 EXPORT_SYMBOL(wrmsrq_safe_on_cpu);
 
-int rdmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
-{
-	int err;
-
-	err = rdmsr_safe_on_cpu(cpu, msr_no, q);
-
-	return err;
-}
-EXPORT_SYMBOL(rdmsrq_safe_on_cpu);
-
 /*
  * These variants are significantly slower, but allows control over
  * the entire 32-bit GPR set.
diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index 735b29f76438..b59cb8d95f55 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -170,7 +170,7 @@ static int amd_pstate_ut_check_perf(u32 index)
 			lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
 			lowest_perf = cppc_perf.lowest_perf;
 		} else {
-			ret = rdmsrq_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
+			ret = rdmsr_safe_on_cpu(cpu, MSR_AMD_CPPC_CAP1, &cap1);
 			if (ret) {
 				pr_err("%s read CPPC_CAP1 ret=%d error!\n", __func__, ret);
 				return ret;
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index c98ead520224..36c9c1e98115 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -467,8 +467,7 @@ static int msr_init_perf(struct amd_cpudata *cpudata)
 	u64 cap1, numerator, cppc_req;
 	u8 min_perf;
 
-	int ret = rdmsrq_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1,
-				     &cap1);
+	int ret = rdmsr_safe_on_cpu(cpudata->cpu, MSR_AMD_CPPC_CAP1, &cap1);
 	if (ret)
 		return ret;
 
diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3adc033a3492..f91c6b264f93 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2178,13 +2178,13 @@ static int core_get_tdp_ratio(int cpu, u64 plat_info)
 		int err;
 
 		/* Get the TDP level (0, 1, 2) to get ratios */
-		err = rdmsrq_safe_on_cpu(cpu, MSR_CONFIG_TDP_CONTROL, &tdp_ctrl);
+		err = rdmsr_safe_on_cpu(cpu, MSR_CONFIG_TDP_CONTROL, &tdp_ctrl);
 		if (err)
 			return err;
 
 		/* TDP MSR are continuous starting at 0x648 */
 		tdp_msr = MSR_CONFIG_TDP_NOMINAL + (tdp_ctrl & 0x03);
-		err = rdmsrq_safe_on_cpu(cpu, tdp_msr, &tdp_ratio);
+		err = rdmsr_safe_on_cpu(cpu, tdp_msr, &tdp_ratio);
 		if (err)
 			return err;
 
@@ -2221,7 +2221,7 @@ static int core_get_max_pstate(int cpu)
 		return tdp_ratio;
 	}
 
-	err = rdmsrq_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO, &tar);
+	err = rdmsr_safe_on_cpu(cpu, MSR_TURBO_ACTIVATION_RATIO, &tar);
 	if (!err) {
 		int tar_levels;
 
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 1c48bf6d5457..b15a798454dc 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -511,8 +511,8 @@ static long isst_if_msr_cmd_req(u8 *cmd_ptr, int *write_only, int resume)
 	} else {
 		u64 data;
 
-		ret = rdmsrq_safe_on_cpu(msr_cmd->logical_cpu,
-					 msr_cmd->msr, &data);
+		ret = rdmsr_safe_on_cpu(msr_cmd->logical_cpu,
+					msr_cmd->msr, &data);
 		if (!ret) {
 			msr_cmd->data = data;
 			*write_only = 0;
diff --git a/drivers/powercap/intel_rapl_msr.c b/drivers/powercap/intel_rapl_msr.c
index a34543e66446..a6bdbe44c8dd 100644
--- a/drivers/powercap/intel_rapl_msr.c
+++ b/drivers/powercap/intel_rapl_msr.c
@@ -180,7 +180,7 @@ static int rapl_msr_read_raw(int cpu, struct reg_action *ra, bool pmu_ctx)
 		goto out;
 	}
 
-	if (rdmsrq_safe_on_cpu(cpu, ra->reg.msr, &ra->value)) {
+	if (rdmsr_safe_on_cpu(cpu, ra->reg.msr, &ra->value)) {
 		pr_debug("failed to read msr 0x%x on cpu %d\n", ra->reg.msr, cpu);
 		return -EIO;
 	}
-- 
2.54.0

