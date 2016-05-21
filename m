From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 0272/1529] Fix typo
Date: Sat, 21 May 2016 14:12:54 +0200
Message-ID: <20160521121254.14459-1-andrea.gelmini@gelma.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36359 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752012AbcEUMND (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2016 08:13:03 -0400
Received: by mail-lb0-f196.google.com with SMTP id r5so6885433lbj.3
        for <linux-pm@vger.kernel.org>; Sat, 21 May 2016 05:13:02 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: andrea.gelmini@gelma.net
Cc: trivial@kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, linux-pm@vger.kernel.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 9414f84..a986358 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -792,7 +792,7 @@ int acpi_unregister_ioapic(acpi_handle handle, u32 gsi_base)
 EXPORT_SYMBOL(acpi_unregister_ioapic);
 
 /**
- * acpi_ioapic_registered - Check whether IOAPIC assoicatied with @gsi_base
+ * acpi_ioapic_registered - Check whether IOAPIC associated with @gsi_base
  *			    has been registered
  * @handle:	ACPI handle of the IOAPIC deivce
  * @gsi_base:	GSI base associated with the IOAPIC
-- 
2.8.2.534.g1f66975

