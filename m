Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62CD47A0B0
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643359; cv=none; b=pDPgAgc7FE6nheXV84Yl6I1Jsd9pmlgbnA6WfRSufP75OtqDGSYzCtUpC6HjS1l7gIr2a0I8gm/R74j2wVy77QmmRuVrqzH7UR+w6jUyZn6lwp6eOTfvwt/kVJw4SLf9oGxhwpJJVSSRm262omHr4W9Rp3zr1BTsm6N7FHVCit0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643359; c=relaxed/simple;
	bh=kR4LNuPs6sRNL3Cz/R3SgtN14fjPcG0Vz5lrtcDtJPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmHduOHv+VPEYPrYiQv1uATafvti9+NIExT2BK68nVmvmSeVPQs4Mn3EojUfnmbthtZKejP29VsYCUIBeRbB8fCnq9ZUw51QNaK+uUCTaXrthgB+7kFWptFk5jV4uzETrIf06P0jCE5XyqxVrZAHwsEnPN/75MXm3a38ZccRwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5718C758EE;
	Fri,  5 Jun 2026 07:09:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCBE8779A8;
	Fri,  5 Jun 2026 07:09:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGTSNBt2Imo2HgAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 07:09:15 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
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
Subject: [PATCH 8/8] x86/msr: Switch all callers of wrmsrq_safe_on_cpu() to use wrmsr_safe_on_cpu()
Date: Fri,  5 Jun 2026 09:08:26 +0200
Message-ID: <20260605070826.2995913-9-jgross@suse.com>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5718C758EE
X-Rspamd-Action: no action

Now that wrmsr_safe_on_cpu() has the same interface as
wrmsrq_safe_on_cpu(), the callers of wrmsrq_safe_on_cpu() can be
switched to wrmsr_safe_on_cpu() and wrmsrq_safe_on_cpu() can be
removed.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h                       |  5 -----
 arch/x86/kernel/acpi/cppc.c                      |  2 +-
 arch/x86/lib/msr-smp.c                           | 16 ----------------
 drivers/cpufreq/amd-pstate.c                     |  2 +-
 .../x86/intel/speed_select_if/isst_if_common.c   |  9 ++++-----
 5 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index cb14ede8f587..a5596d268053 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -262,7 +262,6 @@ void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
 int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
-int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 #else  /*  CONFIG_SMP  */
@@ -294,10 +293,6 @@ static inline int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
 	return wrmsrq_safe(msr_no, q);
 }
-static inline int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
-{
-	return wrmsrq_safe(msr_no, q);
-}
 static inline int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8])
 {
 	return rdmsr_safe_regs(regs);
diff --git a/arch/x86/kernel/acpi/cppc.c b/arch/x86/kernel/acpi/cppc.c
index 86bf2dafdf72..327fdcecfa3b 100644
--- a/arch/x86/kernel/acpi/cppc.c
+++ b/arch/x86/kernel/acpi/cppc.c
@@ -74,7 +74,7 @@ int cpc_write_ffh(int cpunum, struct cpc_reg *reg, u64 val)
 		val &= mask;
 		rd_val &= ~mask;
 		rd_val |= val;
-		err = wrmsrq_safe_on_cpu(cpunum, reg->address, rd_val);
+		err = wrmsr_safe_on_cpu(cpunum, reg->address, rd_val);
 	}
 	return err;
 }
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index b2859435f4af..9ae9ff11f1f1 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -169,22 +169,6 @@ int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 }
 EXPORT_SYMBOL(wrmsr_safe_on_cpu);
 
-int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
-{
-	int err;
-	struct msr_info rv;
-
-	memset(&rv, 0, sizeof(rv));
-
-	rv.msr_no = msr_no;
-	rv.reg.q = q;
-
-	err = smp_call_function_single(cpu, __wrmsr_safe_on_cpu, &rv, 1);
-
-	return err ? err : rv.err;
-}
-EXPORT_SYMBOL(wrmsrq_safe_on_cpu);
-
 /*
  * These variants are significantly slower, but allows control over
  * the entire 32-bit GPR set.
diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 36c9c1e98115..355c5fb9313a 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -446,7 +446,7 @@ static int shmem_set_epp(struct cpufreq_policy *policy, u8 epp)
 
 static inline int msr_cppc_enable(struct cpufreq_policy *policy)
 {
-	return wrmsrq_safe_on_cpu(policy->cpu, MSR_AMD_CPPC_ENABLE, 1);
+	return wrmsr_safe_on_cpu(policy->cpu, MSR_AMD_CPPC_ENABLE, 1);
 }
 
 static int shmem_cppc_enable(struct cpufreq_policy *policy)
diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index b15a798454dc..9d730e6f155d 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -192,8 +192,8 @@ void isst_resume_common(void)
 			if (cb->registered)
 				isst_mbox_resume_command(cb, sst_cmd);
 		} else {
-			wrmsrq_safe_on_cpu(sst_cmd->cpu, sst_cmd->cmd,
-					   sst_cmd->data);
+			wrmsr_safe_on_cpu(sst_cmd->cpu, sst_cmd->cmd,
+					  sst_cmd->data);
 		}
 	}
 }
@@ -500,9 +500,8 @@ static long isst_if_msr_cmd_req(u8 *cmd_ptr, int *write_only, int resume)
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-		ret = wrmsrq_safe_on_cpu(msr_cmd->logical_cpu,
-					 msr_cmd->msr,
-					 msr_cmd->data);
+		ret = wrmsr_safe_on_cpu(msr_cmd->logical_cpu,
+					msr_cmd->msr, msr_cmd->data);
 		*write_only = 1;
 		if (!ret && !resume)
 			ret = isst_store_cmd(0, msr_cmd->msr,
-- 
2.54.0

