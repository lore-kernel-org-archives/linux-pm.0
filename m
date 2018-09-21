From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 05/12][v4] x86-32, hibernate: Enable CONFIG_ARCH_HIBERNATION_HEADER on 32bit system
Date: Fri, 21 Sep 2018 14:27:29 +0800
Message-ID: <93afbc94001d7aa85d2cabdf2f80ce72ca80168d.1537448058.git.yu.c.chen@intel.com>
References: <cover.1537448058.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1537448058.git.yu.c.chen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Zhimin Gu <kookoo.gu@intel.com>, Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

From: Zhimin Gu <kookoo.gu@intel.com>

Enable CONFIG_ARCH_HIBERNATION_HEADER for 32bit system so that

1. arch_hibernation_header_save/restore() are invoked across
   hibernation on 32bit system.
2. The checksum handling as well as 'magic' number checking
   for 32bit system are enabled.

Controlled by CONFIG_X86_64 in hibernate.c

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Zhimin Gu <kookoo.gu@intel.com>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 arch/x86/Kconfig           |  2 +-
 arch/x86/power/hibernate.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1a0be022f91d..e8de5de1057f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2422,7 +2422,7 @@ menu "Power management and ACPI options"
 
 config ARCH_HIBERNATION_HEADER
 	def_bool y
-	depends on X86_64 && HIBERNATION
+	depends on HIBERNATION
 
 source "kernel/power/Kconfig"
 
diff --git a/arch/x86/power/hibernate.c b/arch/x86/power/hibernate.c
index f63793b8de3f..a04ca13bf592 100644
--- a/arch/x86/power/hibernate.c
+++ b/arch/x86/power/hibernate.c
@@ -53,7 +53,6 @@ int pfn_is_nosave(unsigned long pfn)
 	return pfn >= nosave_begin_pfn && pfn < nosave_end_pfn;
 }
 
-#ifdef CONFIG_X86_64
 
 #define MD5_DIGEST_SIZE 16
 
@@ -140,7 +139,11 @@ static bool hibernation_e820_mismatch(void *buf)
 }
 #endif
 
+#ifdef CONFIG_X86_64
 #define RESTORE_MAGIC	0x23456789ABCDEF01UL
+#else
+#define RESTORE_MAGIC	0x12345678UL
+#endif
 
 /**
  *	arch_hibernation_header_save - populate the architecture specific part
@@ -154,6 +157,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	if (max_size < sizeof(struct restore_data_record))
 		return -EOVERFLOW;
 	rdr->magic = RESTORE_MAGIC;
+#ifdef CONFIG_X86_64
 	rdr->jump_address = (unsigned long)restore_registers;
 	rdr->jump_address_phys = __pa_symbol(restore_registers);
 
@@ -175,6 +179,7 @@ int arch_hibernation_header_save(void *addr, unsigned int max_size)
 	 * have any of the PCID bits set.
 	 */
 	rdr->cr3 = restore_cr3 & ~CR3_PCID_MASK;
+#endif
 
 	return hibernation_e820_save(rdr->e820_digest);
 }
@@ -193,9 +198,11 @@ int arch_hibernation_header_restore(void *addr)
 		return -EINVAL;
 	}
 
+#ifdef CONFIG_X86_64
 	restore_jump_address = rdr->jump_address;
 	jump_address_phys = rdr->jump_address_phys;
 	restore_cr3 = rdr->cr3;
+#endif
 
 	if (hibernation_e820_mismatch(rdr->e820_digest)) {
 		pr_crit("Hibernate inconsistent memory map detected!\n");
@@ -205,6 +212,7 @@ int arch_hibernation_header_restore(void *addr)
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
 int relocate_restore_code(void)
 {
 	pgd_t *pgd;
-- 
2.17.1
