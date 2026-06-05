Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE883EA972
	for <linux-pm@vger.kernel.org>; Fri,  5 Jun 2026 14:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780670656; cv=none; b=VMaw8e5JBSOjk0HgRVCL63zniJAhnKXSCjhvgs4Z+JdF9atQ+ChLL9M7JWIWkvHizUgcD6mlrDAa0e2OuK4yHFt4qYPiDGq6J92wiIOGFMu4Ow5MPydOX75L0j9KLj2OLsKDulHHa1wH/nTUZRDrnFLaYAiFrV4B2bkyMQ6g6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780670656; c=relaxed/simple;
	bh=zoSxGzUQzMWz79F1rbRGs8AzOD+cnP/TCIMQzgBNKrM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyuJna3y7THIY207WY+nFi9JylG9VaHLvjjOYMCE/O1DTPk/ntxAQLhnYQPdrk527o7z28wgqWmUf6Fi9Hn/9BIh+CbRqCRaiv6oKIv2ImwZxDD89TChtgkLpwlExBwceuGNlh3JHWXOZ3TcGKTkRgESFb2PvwlHV2IhsXpisyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03C346A868;
	Fri,  5 Jun 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A89D0779A8;
	Fri,  5 Jun 2026 14:44:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zGAPKLjgImqvXAAAD6G6ig
	(envelope-from <jgross@suse.com>); Fri, 05 Jun 2026 14:44:08 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v2 09/10] x86/msr: Switch wrmsr_safe_on_cpu() users to wrmsrq_safe_on_cpu()
Date: Fri,  5 Jun 2026 16:43:13 +0200
Message-ID: <20260605144314.3031049-10-jgross@suse.com>
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
X-Rspamd-Queue-Id: 03C346A868
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

In order to prepare retiring wrmsr_safe_on_cpu() switch
wrmsr_safe_on_cpu() users to wrmsrq_safe_on_cpu().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
V2:
- instead of changing wrmsr_safe_on_cpu(), use wrmsrq_safe_on_cpu()
  (Ingo Molnar)
---
 arch/x86/kernel/msr.c             | 4 ++--
 drivers/thermal/intel/intel_tcc.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/msr.c b/arch/x86/kernel/msr.c
index 60334317f30b..34bdb752f892 100644
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
+		err = wrmsrq_safe_on_cpu(cpu, reg, data);
 		if (err)
 			break;
 
diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
index c6772a5e073a..59f70bb5ffa5 100644
--- a/drivers/thermal/intel/intel_tcc.c
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -261,7 +261,7 @@ int intel_tcc_set_offset(int cpu, int offset)
 	if (cpu < 0)
 		return wrmsr_safe(MSR_IA32_TEMPERATURE_TARGET, val.l, val.h);
 	else
-		return wrmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, val.l, val.h);
+		return wrmsrq_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, val.q);
 }
 EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, "INTEL_TCC");
 
-- 
2.54.0

