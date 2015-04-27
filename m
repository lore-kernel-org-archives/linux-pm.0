From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Subject: [PATCH 1/3] x86, ACPI: Constify irq_domain_ops
Date: Mon, 27 Apr 2015 21:48:07 +0900
Message-ID: <1430138889-3310-1-git-send-email-k.kozlowski.k@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35428 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932661AbbD0MsZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Apr 2015 08:48:25 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sfi-devel@simplefirmware.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

The irq_domain_ops are not modified by the driver and the irqdomain core
code accepts pointer to a const data.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index dbe76a14c3c9..1de4071c7eca 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -439,7 +439,7 @@ static void mp_unregister_gsi(u32 gsi)
 		mp_unmap_irq(irq);
 }
 
-static struct irq_domain_ops acpi_irqdomain_ops = {
+static const struct irq_domain_ops acpi_irqdomain_ops = {
 	.map = mp_irqdomain_map,
 	.unmap = mp_irqdomain_unmap,
 };
-- 
2.1.0

