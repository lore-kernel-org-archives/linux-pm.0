Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34941B374
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372971; cv=none; b=jbwgARgzWRHdqPVQbDrUW1G4leJwuugCfPmZAxRntcP6CPfmO7Rkau+CSQ6+otgOVX40z9PaAdAchnh72Nn3upNEZMR0rUHfC9Q36pHuz2oZbUWbWmdV+BcgQQqzO7cn67mfpGwIFwcwTb3Us530D8sVghKh19FuG4LwszOIXVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372971; c=relaxed/simple;
	bh=Z5LeXVoxRbOMAkh8jnBl4Nrp2saT4QkR28KTYSf9DfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWpXb6wKJPjyJQSFZEj6pDFxTXSBdXjTVBucO0EFBWZcJOuoMFYT0tnQ+Zrh1rAB6ac8CWJeMtqthPXc9IipmzUutttguxlQdmkaMyl7932mA4l2ESoZAZDlGc+2vMnfSsqkQMI4bs15RKy8LvpSISuWg51/h7fIbHxVCw5M4uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qMOBuzyg; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qMOBuzyg; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qMOBuzyg";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qMOBuzyg"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8A5C46A7E7;
	Tue, 28 Apr 2026 10:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0r/pYyp4eZkeXTAZcnsS6zbk5dXl1PgnGRS20Z1KV10=;
	b=qMOBuzygBlWIZUfpMbrMo2ooRWeic53qUum2dzvnqRDl2OSGUvst9BoKnvXQKxDLptURpI
	qnVeggaYzOvzZODKTnJRw6JkWiXrZmHLy6FCoTQ5QHVbzUcGmBtqFlb69YZAyckemPeRxz
	Payw6WnR4iRYGXl3gXqYNLfDBgD61dc=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=qMOBuzyg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0r/pYyp4eZkeXTAZcnsS6zbk5dXl1PgnGRS20Z1KV10=;
	b=qMOBuzygBlWIZUfpMbrMo2ooRWeic53qUum2dzvnqRDl2OSGUvst9BoKnvXQKxDLptURpI
	qnVeggaYzOvzZODKTnJRw6JkWiXrZmHLy6FCoTQ5QHVbzUcGmBtqFlb69YZAyckemPeRxz
	Payw6WnR4iRYGXl3gXqYNLfDBgD61dc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42907593B0;
	Tue, 28 Apr 2026 10:42:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z0IsDyiP8GmnPgAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 28 Apr 2026 10:42:48 +0000
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
Subject: [PATCH RFC 07/11] x86/msr: Switch wrmsr_safe_on_cpu() to use a 64-bit quantity
Date: Tue, 28 Apr 2026 12:42:01 +0200
Message-ID: <20260428104205.916924-8-jgross@suse.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8A5C46A7E7

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
2.53.0

