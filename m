From: Rafal Bilski <rafalbilski@interia.pl>
Subject: [PATCH] e_powersaver: Fix linker error when ACPI processor is a module
Date: Sun, 19 May 2013 20:27:55 +0100
Message-ID: <1368991675-1711-1-git-send-email-rafalbilski@interia.pl>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:34728 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab3ESTuH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 19 May 2013 15:50:07 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Rafal Bilski <rafalbilski@interia.pl>

on i386:
CONFIG_ACPI_PROCESSOR=m
CONFIG_X86_E_POWERSAVER=y

drivers/built-in.o: In function `eps_cpu_init.part.8':
e_powersaver.c:(.text.unlikely+0x2243): undefined reference to `acpi_processor_register_performance'
e_powersaver.c:(.text.unlikely+0x22a2): undefined reference to `acpi_processor_unregister_performance'
e_powersaver.c:(.text.unlikely+0x246b): undefined reference to `acpi_processor_get_bios_limit'

X86_E_POWERSAVER should also depend on ACPI_PROCESSOR.

Signed-off-by: Rafal Bilski <rafalbilski@interia.pl>
---
 drivers/cpufreq/Kconfig.x86 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.x86 b/drivers/cpufreq/Kconfig.x86
index 2b8a8c3..6bd63d6 100644
--- a/drivers/cpufreq/Kconfig.x86
+++ b/drivers/cpufreq/Kconfig.x86
@@ -272,7 +272,7 @@ config X86_LONGHAUL
 config X86_E_POWERSAVER
 	tristate "VIA C7 Enhanced PowerSaver (DANGEROUS)"
 	select CPU_FREQ_TABLE
-	depends on X86_32
+	depends on X86_32 && ACPI_PROCESSOR
 	help
 	  This adds the CPUFreq driver for VIA C7 processors.  However, this driver
 	  does not have any safeguards to prevent operating the CPU out of spec
-- 
1.8.2.3

