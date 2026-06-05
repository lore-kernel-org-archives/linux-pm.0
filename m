Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16E8478E20
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 07:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780643354; cv=none; b=j8t161r60G26zOvMNmRkb5YMmppKj3uGSJdOmIznr/7sY5nvHx98sjQeOieFQ9S4E/LYqGwMkfP0K2YgSc+tWhWL60lzPQzPGI5aXSJAikzPJ9olYeMGfiNhqlqmImFkkbcGsErC4FKm69unJDVjqRimMf4ZvpSSmpwLQmX/WEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780643354; c=relaxed/simple;
	bh=GDMo7lbcb1mJpxgta+Gar8rljE9EwtvAD8d8qfl9X+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezPax5dVAihy6EWV6YnhjiNfNZVSRi0ZUh4KdnAEbXUcT9PVZRfnouBOv2SHHYqqK4aQtwwCfjt5ctUxbnrah5G3ipcwS1rgdEpukGIdjWwEV2rOBxXqzu6KRUTwApTNfvfa61tcUfHFncmoS9bb+jbC/mVl9Cd1a1l1ozoNLyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uYPjt1bJ; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uYPjt1bJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uYPjt1bJ";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uYPjt1bJ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 92C856AEE5;
	Fri,  5 Jun 2026 07:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780643350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcFeF1Q9UyCw26jXyLsfZkRQPSfwwfM5ook6w5QqpCs=;
	b=uYPjt1bJIUH/2BxYT5wOJnAPpuigGXe4v8B5UF4FXUme5prl+vx9HyzUghOR3cBHSnmaA1
	GGgvmZszW7z3tt1LL3Kad6PTUmKs0dlGfJMogfJkWa88db12YntTDTOhSTVb+D9JYGQ+yD
	VlW/Oawi0uska0Nb4fp9bsZ5ff434i8=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780643350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mcFeF1Q9UyCw26jXyLsfZkRQPSfwwfM5ook6w5QqpCs=;
	b=uYPjt1bJIUH/2BxYT5wOJnAPpuigGXe4v8B5UF4FXUme5prl+vx9HyzUghOR3cBHSnmaA1
	GGgvmZszW7z3tt1LL3Kad6PTUmKs0dlGfJMogfJkWa88db12YntTDTOhSTVb+D9JYGQ+yD
	VlW/Oawi0uska0Nb4fp9bsZ5ff434i8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49DAF779A8;
	Fri,  5 Jun 2026 07:09:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yYL3EBZ2ImowHgAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 07:09:10 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH 7/8] x86/msr: Switch wrmsr_safe_on_cpu() to use a 64-bit quantity
Date: Fri,  5 Jun 2026 09:08:25 +0200
Message-ID: <20260605070826.2995913-8-jgross@suse.com>
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
X-Spam-Flag: NO
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	R_RATELIMIT(0.00)[to_ip_from(RLfdszjqhz8kzzb9uwpzdm8png)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Score: -6.80

In order to prepare retiring wrmsrq_safe_on_cpu() switch
wrmsr_safe_on_cpu() to have the same interface as wrmsrq_safe_on_cpu().

Switch all wrmsr_safe_on_cpu() callers to use the new interface.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/msr.h        | 6 +++---
 arch/x86/kernel/msr.c             | 4 ++--
 arch/x86/lib/msr-smp.c            | 5 ++---
 drivers/thermal/intel/intel_tcc.c | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index f2d14c670140..cb14ede8f587 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -261,7 +261,7 @@ int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 void rdmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 void wrmsr_on_cpus(const struct cpumask *mask, u32 msr_no, struct msr __percpu *msrs);
 int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
-int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
+int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q);
 int rdmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
 int wrmsr_safe_regs_on_cpu(unsigned int cpu, u32 regs[8]);
@@ -290,9 +290,9 @@ static inline int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 {
 	return rdmsrq_safe(msr_no, q);
 }
-static inline int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
+static inline int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
-	return wrmsr_safe(msr_no, l, h);
+	return wrmsrq_safe(msr_no, q);
 }
 static inline int wrmsrq_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index c9429a718810..db4b5c07ba22 100644
--- a/arch/x86/kernel/msr.c
+++ b/arch/x86/kernel/msr.c
@@ -109,7 +109,7 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
 	const u32 __user *tmp = (const u32 __user *)buf;
-	u32 data[2];
+	u64 data;
 	u32 reg = *ppos;
 	int cpu = iminor(file_inode(file));
 	int err = 0;
@@ -134,7 +134,7 @@ static ssize_t msr_write(struct file *file, const char __user *buf,
 
 		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
 
-		err = wrmsr_safe_on_cpu(cpu, reg, data[0], data[1]);
+		err = wrmsr_safe_on_cpu(cpu, reg, data);
 		if (err)
 			break;
 
diff --git a/arch/x86/lib/msr-smp.c b/arch/x86/lib/msr-smp.c
index fa22ac662c1d..b2859435f4af 100644
--- a/arch/x86/lib/msr-smp.c
+++ b/arch/x86/lib/msr-smp.c
@@ -154,7 +154,7 @@ int rdmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 *q)
 }
 EXPORT_SYMBOL(rdmsr_safe_on_cpu);
 
-int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
+int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u64 q)
 {
 	int err;
 	struct msr_info rv;
@@ -162,8 +162,7 @@ int wrmsr_safe_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h)
 	memset(&rv, 0, sizeof(rv));
 
 	rv.msr_no = msr_no;
-	rv.reg.l = l;
-	rv.reg.h = h;
+	rv.reg.q = q;
 	err = smp_call_function_single(cpu, __wrmsr_safe_on_cpu, &rv, 1);
 
 	return err ? err : rv.err;
diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
index 9a8f2f101efc..8c80f9bfbea4 100644
--- a/drivers/thermal/intel/intel_tcc.c
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -261,7 +261,7 @@ int intel_tcc_set_offset(int cpu, int offset)
 	if (cpu < 0)
 		return wrmsr_safe(MSR_IA32_TEMPERATURE_TARGET, val.l, val.h);
 	else
-		return wrmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, val.l, val.h);
+		return wrmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, val.q);
 }
 EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, "INTEL_TCC");
 
-- 
2.54.0

