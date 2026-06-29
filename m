Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498FC3914EB
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 06:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713146; cv=none; b=ZU8Y524my1tj6db4/5sQV2lJFdVGdNff3eQi91vKiIBKv+YCDtKzW7Rgif8fAr8fXBNkFNCWCyIBRa1ktZLegG1byMG5/ZQ+eDPQ6F+ncu5IFsnDCNS2R1i7ZUwbABGsaq/vHZ1179Ebp0YSNKQzyijp8hKuPiq2A1/B9/e636Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713146; c=relaxed/simple;
	bh=4wX7C6PgInYXs0oHztQdVly3MYT8YulFSIy+jg8ox80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hb9LMsCe+QBXO8en7ssxhcZugcEVim8Q/oMep1rOyqeR7V522b2zg2bspUNFRtu/6mQZo8EM/iwtT3AK6u3N1eGvbgBEVhQjQER+FVqLGSyhF7u9nFg1VzkrEf/m7fbYqnnrCPJBvsVl4bx7qnO1xJoSaxLxDiVaML+i44LtX+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A56F275D13;
	Mon, 29 Jun 2026 06:05:43 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7BDE1779A8;
	Mon, 29 Jun 2026 06:05:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b0G/HDcLQmq+EQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 29 Jun 2026 06:05:43 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 02/32] powercap: Stop using 32-bit MSR interfaces
Date: Mon, 29 Jun 2026 08:04:53 +0200
Message-ID: <20260629060526.3638272-3-jgross@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629060526.3638272-1-jgross@suse.com>
References: <20260629060526.3638272-1-jgross@suse.com>
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
X-Rspamd-Queue-Id: A56F275D13
X-Rspamd-Action: no action

The 32-bit MSR interfaces rdmsr_safe() and wrmsr_safe() are planned to
be removed. Use the related 64-bit variants instead.

Drop a pointless initializer.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/powercap/intel_rapl_common.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/powercap/intel_rapl_common.c b/drivers/powercap/intel_rapl_common.c
index 1006d183d508..3cee4ccb7997 100644
--- a/drivers/powercap/intel_rapl_common.c
+++ b/drivers/powercap/intel_rapl_common.c
@@ -752,17 +752,17 @@ EXPORT_SYMBOL_NS_GPL(rapl_default_check_unit, "INTEL_RAPL");
 
 static void power_limit_irq_save_cpu(void *info)
 {
-	u32 l, h = 0;
+	struct msr val;
 	struct rapl_package *rp = (struct rapl_package *)info;
 
 	/* save the state of PLN irq mask bit before disabling it */
-	rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
+	rdmsrq_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &val.q);
 	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED)) {
-		rp->power_limit_irq = l & PACKAGE_THERM_INT_PLN_ENABLE;
+		rp->power_limit_irq = val.l & PACKAGE_THERM_INT_PLN_ENABLE;
 		rp->power_limit_irq |= PACKAGE_PLN_INT_SAVED;
 	}
-	l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
-	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	val.l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
+	wrmsrq_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
 }
 
 /* REVISIT:
@@ -792,7 +792,7 @@ static void package_power_limit_irq_save(struct rapl_package *rp)
  */
 static void package_power_limit_irq_restore(struct rapl_package *rp)
 {
-	u32 l, h;
+	struct msr val;
 
 	if (rp->lead_cpu < 0)
 		return;
@@ -804,14 +804,14 @@ static void package_power_limit_irq_restore(struct rapl_package *rp)
 	if (!(rp->power_limit_irq & PACKAGE_PLN_INT_SAVED))
 		return;
 
-	rdmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &l, &h);
+	rdmsrq_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, &val.q);
 
 	if (rp->power_limit_irq & PACKAGE_THERM_INT_PLN_ENABLE)
-		l |= PACKAGE_THERM_INT_PLN_ENABLE;
+		val.l |= PACKAGE_THERM_INT_PLN_ENABLE;
 	else
-		l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
+		val.l &= ~PACKAGE_THERM_INT_PLN_ENABLE;
 
-	wrmsr_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, l, h);
+	wrmsrq_safe(MSR_IA32_PACKAGE_THERM_INTERRUPT, val.q);
 }
 
 void rapl_default_set_floor_freq(struct rapl_domain *rd, bool mode)
-- 
2.54.0

