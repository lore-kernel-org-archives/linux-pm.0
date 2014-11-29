From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] x86 / PM: Replace CONFIG_PM_RUNTIME in io_apic.c
Date: Sat, 29 Nov 2014 23:56:10 +0100
Message-ID: <5062650.1vTULtXiIc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56274 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751304AbaK2Weu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 29 Nov 2014 17:34:50 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
depending on CONFIG_PM_RUNTIME may now be changed to depend on
CONFIG_PM.

Replace CONFIG_PM_RUNTIME with CONFIG_PM in x86/kernel/apic/io_apic.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP
is selected) which currently is only in linux-next (via linux-pm).

---
 arch/x86/kernel/apic/io_apic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-pm/arch/x86/kernel/apic/io_apic.c
===================================================================
--- linux-pm.orig/arch/x86/kernel/apic/io_apic.c
+++ linux-pm/arch/x86/kernel/apic/io_apic.c
@@ -3968,7 +3968,7 @@ bool mp_should_keep_irq(struct device *d
 {
 	if (dev->power.is_prepared)
 		return true;
-#ifdef	CONFIG_PM_RUNTIME
+#ifdef	CONFIG_PM
 	if (dev->power.runtime_status == RPM_SUSPENDING)
 		return true;
 #endif

