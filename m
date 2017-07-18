From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 4/5] ACPI / boot: Not all platform require acpi_reduced_hw_init()
Date: Tue, 18 Jul 2017 18:04:19 +0300
Message-ID: <20170718150420.61600-5-andriy.shevchenko@linux.intel.com>
References: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170718150420.61600-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Hanjun Guo <guohanjun@huawei.com>, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Some platform might take care of legacy devices on theirs own.
Let's allow them to do that by exporting a weak function.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 2 +-
 include/linux/acpi.h        | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 0186d3bae610..71c0feae60a4 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1348,7 +1348,7 @@ static int __init dmi_ignore_irq0_timer_override(const struct dmi_system_id *d)
  *
  * We initialize the Hardware-reduced ACPI model here:
  */
-static void __init acpi_reduced_hw_init(void)
+void __init __weak acpi_reduced_hw_init(void)
 {
 	if (acpi_gbl_reduced_hardware) {
 		/*
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 7443af1d16e7..5a19b2090db1 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -230,6 +230,8 @@ struct acpi_subtable_proc {
 
 void __iomem *__acpi_map_table(unsigned long phys, unsigned long size);
 void __acpi_unmap_table(void __iomem *map, unsigned long size);
+
+void acpi_reduced_hw_init(void);
 int early_acpi_boot_init(void);
 int acpi_boot_init (void);
 void acpi_boot_table_init (void);
@@ -682,6 +684,7 @@ static inline struct device *acpi_get_first_physical_node(struct acpi_device *ad
 static inline void acpi_early_init(void) { }
 static inline void acpi_subsystem_init(void) { }
 
+static inline void acpi_reduced_hw_init(void) { }
 static inline int early_acpi_boot_init(void)
 {
 	return 0;
-- 
2.11.0
