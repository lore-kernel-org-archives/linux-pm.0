Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5C7374722
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895923; cv=none; b=VR1RC36Rel5WDnhBoOvn74fbR97xh2qLzakFpFX1SPFEGxaXZlIRea4qhJzY0n6uf0OQup1lmswp9grwXlqseA28u0962prBOteAPEy2VnrO4W81WLRh4O7+b+OzVEjApk7c37WfDRrJ+epxujw+ume0D2PhAKK3wTphwFoRXvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895923; c=relaxed/simple;
	bh=yF2aJGuW4C3Wk0R8NDU9KHmIGXQt3uaaMYvATdg25fQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IygvveCYWINIMdSzLCWGtPe9caCd5xoF8RxI2TptXtPGndXwfNQbKZjPo6NjAkfN0nvhTRfDs+eMk872ccMLoZdTrR9b5OEix6B82tO4nslSxSGx9OlYM/k9tOsYFBQ+QpEzKpjuizmTKnBkPRJgWF7q7cR+DZgdxrkgE3jN8iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u13yacLN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=u13yacLN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u13yacLN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="u13yacLN"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 800C175E2B;
	Mon,  8 Jun 2026 05:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ5HvPF/NnTLnukz+znQM5nqpiu+pMYzNU9ukdfU4ow=;
	b=u13yacLN1TwlvBS3ljQTEDq3DW728/ugNcR6Yi/lHiz8OiKEN1IHW55eod9EV70w24uIMm
	r0UEaschRmSff/uLhuk3Lk/0U+mFLiykawYPTqm9m3BCveq+yXh5CZEWX+zduUpwx4mdy7
	FutzenhS40Trfeazri2ZKRd7GYZgOrw=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=u13yacLN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1780895920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QQ5HvPF/NnTLnukz+znQM5nqpiu+pMYzNU9ukdfU4ow=;
	b=u13yacLN1TwlvBS3ljQTEDq3DW728/ugNcR6Yi/lHiz8OiKEN1IHW55eod9EV70w24uIMm
	r0UEaschRmSff/uLhuk3Lk/0U+mFLiykawYPTqm9m3BCveq+yXh5CZEWX+zduUpwx4mdy7
	FutzenhS40Trfeazri2ZKRd7GYZgOrw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34C54779A7;
	Mon,  8 Jun 2026 05:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eD3NC7BQJmrwdQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 08 Jun 2026 05:18:40 +0000
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
Subject: [PATCH v3 10/11] x86/msr: Switch wrmsr_safe_on_cpu() users to wrmsrq_safe_on_cpu()
Date: Mon,  8 Jun 2026 07:17:40 +0200
Message-ID: <20260608051741.3207435-11-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608051741.3207435-1-jgross@suse.com>
References: <20260608051741.3207435-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 800C175E2B
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email,suse.com:mid];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

In order to prepare retiring wrmsr_safe_on_cpu() switch
wrmsr_safe_on_cpu() users to wrmsrq_safe_on_cpu().

Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
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

