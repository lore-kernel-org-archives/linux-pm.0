From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 5/7] powerpc: change CONFIG_PPC_STD_MMU_32 to
 CONFIG_PPC_BOOK3S_32
Date: Sat, 17 Nov 2018 10:25:02 +0000 (UTC)
Message-ID: <1c200e524bc6533cff26461ad8decb9f848ceacd.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Today we have:

config PPC_BOOK3S_32
        bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
        [depends on PPC32 within a choice]

config PPC_BOOK3S
        def_bool y
        depends on PPC_BOOK3S_32 || PPC_BOOK3S_64

config PPC_STD_MMU
	def_bool y
	depends on PPC_BOOK3S

config PPC_STD_MMU_32
	def_bool y
	depends on PPC_STD_MMU && PPC32

PPC_STD_MMU_32 is therefore redundant with PPC_BOOK3S_32.

In order to make the code clearer, lets use preferably PPC_BOOK3S_32.
This will allow to remove CONFIG_PPC_STD_MMU_32 in a later patch.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/mmu.h     | 2 +-
 arch/powerpc/include/asm/tlb.h     | 2 +-
 arch/powerpc/kernel/setup-common.c | 4 ++--
 arch/powerpc/mm/Makefile           | 2 +-
 arch/powerpc/mm/pgtable_32.c       | 2 +-
 arch/powerpc/xmon/xmon.c           | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 47b651deff5b..8a6d3b129c6d 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -338,7 +338,7 @@ static inline void mmu_early_init_devtree(void) { }
 #endif /* __ASSEMBLY__ */
 #endif
 
-#if defined(CONFIG_PPC_STD_MMU_32)
+#if defined(CONFIG_PPC_BOOK3S_32)
 /* 32-bit classic hash table MMU */
 #include <asm/book3s/32/mmu-hash.h>
 #elif defined(CONFIG_40x)
diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/asm/tlb.h
index f0e571b2dc7c..e24c67d5ba75 100644
--- a/arch/powerpc/include/asm/tlb.h
+++ b/arch/powerpc/include/asm/tlb.h
@@ -40,7 +40,7 @@ extern void flush_hash_entry(struct mm_struct *mm, pte_t *ptep,
 static inline void __tlb_remove_tlb_entry(struct mmu_gather *tlb, pte_t *ptep,
 					  unsigned long address)
 {
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 	if (pte_val(*ptep) & _PAGE_HASHPTE)
 		flush_hash_entry(tlb->mm, ptep, address);
 #endif
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 93ee3703b42f..ffa1e00349dd 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -800,7 +800,7 @@ static __init void print_system_info(void)
 #ifdef CONFIG_PPC_BOOK3S_64
 	pr_info("ppc64_pft_size    = 0x%llx\n", ppc64_pft_size);
 #endif
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 	pr_info("Hash_size         = 0x%lx\n", Hash_size);
 #endif
 	pr_info("phys_mem_size     = 0x%llx\n",
@@ -830,7 +830,7 @@ static __init void print_system_info(void)
 	if (htab_hash_mask)
 		pr_info("htab_hash_mask    = 0x%lx\n", htab_hash_mask);
 #endif
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 	if (Hash)
 		pr_info("Hash              = 0x%p\n", Hash);
 	if (Hash_mask)
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index ca96e7be4d0e..5cc9643d2e0c 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -17,7 +17,7 @@ hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= pgtable-hash64.o hash_utils_64.o slb.o $(hash64-y) mmu_context_book3s64.o pgtable-book3s64.o
 obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o tlb-radix.o
-obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
+obj-$(CONFIG_PPC_BOOK3S_32)	+= ppc_mmu_32.o hash_low_32.o mmu_context_hash32.o
 obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(BITS).o
 ifdef CONFIG_PPC_BOOK3S_64
 obj-$(CONFIG_PPC_4K_PAGES)	+= hash64_4k.o
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index bda3c6f1bd32..10c4369cd02d 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -260,7 +260,7 @@ static void __init __mapin_ram_chunk(unsigned long offset, unsigned long top)
 		ktext = ((char *)v >= _stext && (char *)v < etext) ||
 			((char *)v >= _sinittext && (char *)v < _einittext);
 		map_kernel_page(v, p, ktext ? PAGE_KERNEL_TEXT : PAGE_KERNEL);
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 		if (ktext)
 			hash_preload(&init_mm, v, false, 0x300);
 #endif
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 36b8dc47a3c3..79fa45df1eee 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -273,7 +273,7 @@ Commands:\n\
   X	exit monitor and don't recover\n"
 #if defined(CONFIG_PPC64) && !defined(CONFIG_PPC_BOOK3E)
 "  u	dump segment table or SLB\n"
-#elif defined(CONFIG_PPC_STD_MMU_32)
+#elif defined(CONFIG_PPC_BOOK3S_32)
 "  u	dump segment registers\n"
 #elif defined(CONFIG_44x) || defined(CONFIG_PPC_BOOK3E)
 "  u	dump TLB\n"
@@ -3495,7 +3495,7 @@ void dump_segments(void)
 }
 #endif
 
-#ifdef CONFIG_PPC_STD_MMU_32
+#ifdef CONFIG_PPC_BOOK3S_32
 void dump_segments(void)
 {
 	int i;
-- 
2.13.3
