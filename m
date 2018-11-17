From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 6/7] powerpc: change CONFIG_PPC_STD_MMU to CONFIG_PPC_BOOK3S
Date: Sat, 17 Nov 2018 10:25:04 +0000 (UTC)
Message-ID: <ba5bd02921ca792a47b61457ccf53fe7af767e6d.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Today we have:

config PPC_BOOK3S
        def_bool y
        depends on PPC_BOOK3S_32 || PPC_BOOK3S_64

config PPC_STD_MMU
        def_bool y
        depends on PPC_BOOK3S

PPC_STD_MMU is therefore redundant with PPC_BOOK3S. Lets remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/mm/Makefile | 2 +-
 arch/powerpc/mm/fault.c  | 4 ++--
 arch/powerpc/mm/mem.c    | 4 ++--
 arch/powerpc/xmon/xmon.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 5cc9643d2e0c..1adc3d8a89cc 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -18,7 +18,7 @@ obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
 obj-$(CONFIG_PPC_BOOK3S_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
-obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
+obj-$(CONFIG_PPC_BOOK3S)	+= tlb_hash$(BITS).o
 ifdef CONFIG_PPC_BOOK3S_64
 obj-$(CONFIG_PPC_4K_PAGES)	+= hash64_4k.o
 obj-$(CONFIG_PPC_64K_PAGES)	+= hash64_64k.o
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 1697e903bbf2..01b9bcc7fa85 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -341,7 +341,7 @@ static inline void cmo_account_page_fault(void)
 static inline void cmo_account_page_fault(void) { }
 #endif /* CONFIG_PPC_SMLPAR */
 
-#ifdef CONFIG_PPC_STD_MMU
+#ifdef CONFIG_PPC_BOOK3S
 static void sanity_check_fault(bool is_write, unsigned long error_code)
 {
 	/*
@@ -378,7 +378,7 @@ static void sanity_check_fault(bool is_write, unsigned long error_code)
 }
 #else
 static void sanity_check_fault(bool is_write, unsigned long error_code) { }
-#endif /* CONFIG_PPC_STD_MMU */
+#endif /* CONFIG_PPC_BOOK3S */
 
 /*
  * Define the correct "is_write" bit in error_code based
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 0a64fffabee1..065c37d54b49 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -503,7 +503,7 @@ EXPORT_SYMBOL(flush_icache_user_range);
 void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		      pte_t *ptep)
 {
-#ifdef CONFIG_PPC_STD_MMU
+#ifdef CONFIG_PPC_BOOK3S
 	/*
 	 * We don't need to worry about _PAGE_PRESENT here because we are
 	 * called with either mm->page_table_lock held or ptl lock held
@@ -541,7 +541,7 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 	}
 
 	hash_preload(vma->vm_mm, address, is_exec, trap);
-#endif /* CONFIG_PPC_STD_MMU */
+#endif /* CONFIG_PPC_BOOK3S */
 #if (defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_FSL_BOOK3E)) \
 	&& defined(CONFIG_HUGETLB_PAGE)
 	if (is_vm_hugetlb_page(vma))
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 79fa45df1eee..4e71b854838f 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1058,7 +1058,7 @@ cmds(struct pt_regs *excp)
 		case 'P':
 			show_tasks();
 			break;
-#ifdef CONFIG_PPC_STD_MMU
+#ifdef CONFIG_PPC_BOOK3S
 		case 'u':
 			dump_segments();
 			break;
-- 
2.13.3
