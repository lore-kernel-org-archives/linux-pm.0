Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF83955C8
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 06:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713157; cv=none; b=efIFGfGWXGShv87XwGLBzpIQFL2Hpz3a5oyci2+welr2ZwNftkw8/6Sfo5kbMGDzrvWPoPpTrFs5q9jTztwgmjH7xP0sVDQcW8MetkTwzadtAJqakQQM+Lcvm0dy4fD0skWgFApqRpUA6+Qvkj90ZjgdPp/T0XegkH7dJweQTKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713157; c=relaxed/simple;
	bh=kU+tbFNURgODrMKqtaWQ7xYYsb0OCQv3o/JiLcMbYXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tT2QiTYSl49cCur08T2IR1GhwHF90c7SGp0y8UBOqx+cErgRmTIhTantxjL66l4LVqKHrCcPORc+Sg/8ih22rFMwJdXD6untJTzj3iuCiWOMKSyfUrNpvL+8sQ5APUpsZjxNhmr8xDBi3tWd/kiiEXrzI6/I0Ym6MC1OQ+WXLQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 16BA57023D;
	Mon, 29 Jun 2026 06:05:55 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAB2C779A8;
	Mon, 29 Jun 2026 06:05:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Dhk7KEILQmrJEQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:05:54 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 04/32] acpi: Stop using 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:04:55 +0200
Message-ID: <20260629060526.3638272-5-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Rspamd-Queue-Id: 16BA57023D
X-Rspamd-Action: no action

The 32-bit MSR interfaces rdmsr(), wrmsr(), rdmsr_safe() and
wrmsr_safe() are planned to be removed. Use the related 64-bit variants
instead.

In processor_throttling.c drop needless initializers.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/acpi/sleep.c        | 20 ++++++++------------
 drivers/acpi/processor_perflib.c    | 11 ++++++-----
 drivers/acpi/processor_throttling.c | 14 ++------------
 3 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index 91fa262f0e30..8dfe98784bf9 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -61,6 +61,7 @@ int x86_acpi_suspend_lowlevel(void)
 {
 	struct wakeup_header *header =
 		(struct wakeup_header *) __va(real_mode_header->wakeup_header);
+	struct msr val;
 
 	if (header->signature != WAKEUP_HEADER_SIGNATURE) {
 		printk(KERN_ERR "wakeup header does not match\n");
@@ -82,13 +83,10 @@ int x86_acpi_suspend_lowlevel(void)
 	 * with 2-MB L2 Cache and Intel® Processor A100 and A110 on 90
 	 * nm process with 512-KB L2 Cache Specification Update".
 	 */
-	if (!rdmsr_safe(MSR_EFER,
-			&header->pmode_efer_low,
-			&header->pmode_efer_high) &&
-	    !wrmsr_safe(MSR_EFER,
-			header->pmode_efer_low,
-			header->pmode_efer_high))
+	if (!rdmsrq_safe(MSR_EFER, &val.q) && !wrmsrq_safe(MSR_EFER, val.q))
 		header->pmode_behavior |= (1 << WAKEUP_BEHAVIOR_RESTORE_EFER);
+	header->pmode_efer_low = val.l;
+	header->pmode_efer_high = val.h;
 #endif /* !CONFIG_64BIT */
 
 	header->pmode_cr0 = read_cr0();
@@ -96,14 +94,12 @@ int x86_acpi_suspend_lowlevel(void)
 		header->pmode_cr4 = __read_cr4();
 		header->pmode_behavior |= (1 << WAKEUP_BEHAVIOR_RESTORE_CR4);
 	}
-	if (!rdmsr_safe(MSR_IA32_MISC_ENABLE,
-			&header->pmode_misc_en_low,
-			&header->pmode_misc_en_high) &&
-	    !wrmsr_safe(MSR_IA32_MISC_ENABLE,
-			header->pmode_misc_en_low,
-			header->pmode_misc_en_high))
+	if (!rdmsrq_safe(MSR_IA32_MISC_ENABLE, &val.q) &&
+	    !wrmsrq_safe(MSR_IA32_MISC_ENABLE, val.q))
 		header->pmode_behavior |=
 			(1 << WAKEUP_BEHAVIOR_RESTORE_MISC_ENABLE);
+	header->pmode_misc_en_low = val.l;
+	header->pmode_misc_en_high = val.h;
 	header->realmode_flags = acpi_realmode_flags;
 	header->real_magic = 0x12345678;
 
diff --git a/drivers/acpi/processor_perflib.c b/drivers/acpi/processor_perflib.c
index fdf55c285c9a..9e25d6124efd 100644
--- a/drivers/acpi/processor_perflib.c
+++ b/drivers/acpi/processor_perflib.c
@@ -287,7 +287,8 @@ static int acpi_processor_get_performance_control(struct acpi_processor *pr)
  */
 static void amd_fixup_frequency(struct acpi_processor_px *px, int i)
 {
-	u32 hi, lo, fid, did;
+	struct msr val;
+	u32 fid, did;
 	int index = px->control & 0x00000007;
 
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
@@ -295,16 +296,16 @@ static void amd_fixup_frequency(struct acpi_processor_px *px, int i)
 
 	if ((boot_cpu_data.x86 == 0x10 && boot_cpu_data.x86_model < 10) ||
 	    boot_cpu_data.x86 == 0x11) {
-		rdmsr(MSR_AMD_PSTATE_DEF_BASE + index, lo, hi);
+		rdmsrq(MSR_AMD_PSTATE_DEF_BASE + index, val.q);
 		/*
 		 * MSR C001_0064+:
 		 * Bit 63: PstateEn. Read-write. If set, the P-state is valid.
 		 */
-		if (!(hi & BIT(31)))
+		if (!(val.h & BIT(31)))
 			return;
 
-		fid = lo & 0x3f;
-		did = (lo >> 6) & 7;
+		fid = val.l & 0x3f;
+		did = (val.l >> 6) & 7;
 		if (boot_cpu_data.x86 == 0x10)
 			px->core_frequency = (100 * (fid + 0x10)) >> did;
 		else
diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
index c0f92b93747d..d1605e0ab61f 100644
--- a/drivers/acpi/processor_throttling.c
+++ b/drivers/acpi/processor_throttling.c
@@ -698,20 +698,13 @@ static int acpi_processor_get_throttling_fadt(struct acpi_processor *pr)
 #ifdef CONFIG_X86
 static int acpi_throttling_rdmsr(u64 *value)
 {
-	u64 msr_high, msr_low;
-	u64 msr = 0;
 	int ret = -1;
 
 	if ((this_cpu_read(cpu_info.x86_vendor) != X86_VENDOR_INTEL) ||
 		!this_cpu_has(X86_FEATURE_ACPI)) {
 		pr_err("HARDWARE addr space,NOT supported yet\n");
 	} else {
-		msr_low = 0;
-		msr_high = 0;
-		rdmsr_safe(MSR_IA32_THERM_CONTROL,
-			(u32 *)&msr_low, (u32 *) &msr_high);
-		msr = (msr_high << 32) | msr_low;
-		*value = (u64) msr;
+		rdmsrq_safe(MSR_IA32_THERM_CONTROL, value);
 		ret = 0;
 	}
 	return ret;
@@ -720,15 +713,12 @@ static int acpi_throttling_rdmsr(u64 *value)
 static int acpi_throttling_wrmsr(u64 value)
 {
 	int ret = -1;
-	u64 msr;
 
 	if ((this_cpu_read(cpu_info.x86_vendor) != X86_VENDOR_INTEL) ||
 		!this_cpu_has(X86_FEATURE_ACPI)) {
 		pr_err("HARDWARE addr space,NOT supported yet\n");
 	} else {
-		msr = value;
-		wrmsr_safe(MSR_IA32_THERM_CONTROL,
-			msr & 0xffffffff, msr >> 32);
+		wrmsrq_safe(MSR_IA32_THERM_CONTROL, value);
 		ret = 0;
 	}
 	return ret;
-- 
2.54.0

