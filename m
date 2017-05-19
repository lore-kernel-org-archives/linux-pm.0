From: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
Subject: [PATCH] ACPI: processor: fix LPI when built as module
Date: Fri, 19 May 2017 11:28:37 +0200
Message-ID: <20170519092837.30991-1-yousaf.kaukab@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:48034 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752816AbdESJ3Q (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 19 May 2017 05:29:16 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com
Cc: sudeep.holla@arm.com, catalin.marinas@arm.com, lorenzo.pieralisi@arm.com, Mian Yousaf Kaukab <yousaf.kaukab@suse.com>

Low Power Idle(LPI) support added acpi_processor_ffh_lpi_probe() and
acpi_processor_ffh_lpi_enter() as __weak functions and arch code is
supposed to provide the actual callbacks. This breaks if
ACPI_PROCESSOR is configured as a module.

Add CONFIG_ARCH_HAS_ACPI_LPI configuration option to fix this.

Signed-off-by: Mian Yousaf Kaukab <yousaf.kaukab@suse.com>
---
 arch/arm64/Kconfig            | 1 +
 arch/arm64/kernel/cpuidle.c   | 2 ++
 drivers/acpi/Kconfig          | 3 +++
 drivers/acpi/processor_idle.c | 9 +++++++--
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 848a34116c67..de2f2779cdf5 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -10,6 +10,7 @@ config ARM64
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
+	select ARCH_HAS_ACPI_LPI if ACPI
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE if (MEMORY_ISOLATION && COMPACTION) || CMA
diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index fd691087dc9a..002d9cb890bd 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -51,9 +51,11 @@ int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 {
 	return arm_cpuidle_init(cpu);
 }
+EXPORT_SYMBOL(acpi_processor_ffh_lpi_probe);
 
 int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	return CPU_PM_CPU_IDLE_ENTER(arm_cpuidle_suspend, lpi->index);
 }
+EXPORT_SYMBOL(acpi_processor_ffh_lpi_enter);
 #endif
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1ce52f84dc23..7e5a7bce9d72 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -224,6 +224,9 @@ config ACPI_PROCESSOR_IDLE
 	bool
 	select CPU_IDLE
 
+config ARCH_HAS_ACPI_LPI
+	def_bool n
+
 config ACPI_MCFG
 	bool
 
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 5c8aa9cf62d7..321fe9acd8e8 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1211,15 +1211,20 @@ static int acpi_processor_get_lpi_info(struct acpi_processor *pr)
 	return 0;
 }
 
-int __weak acpi_processor_ffh_lpi_probe(unsigned int cpu)
+#ifdef CONFIG_ARCH_HAS_ACPI_LPI
+int acpi_processor_ffh_lpi_probe(unsigned int cpu);
+int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi);
+#else
+static int acpi_processor_ffh_lpi_probe(unsigned int cpu)
 {
 	return -ENODEV;
 }
 
-int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
+static int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
 {
 	return -ENODEV;
 }
+#endif /* CONFIG_ARCH_HAS_ACPI_LPI */
 
 /**
  * acpi_idle_lpi_enter - enters an ACPI any LPI state
-- 
2.11.0
