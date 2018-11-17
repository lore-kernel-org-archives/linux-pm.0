From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/7] powerpc/32: Remove #ifdef CONFIG_PPC_STD_MMU_32 in
 asm/book3s/32/pgtable.h
Date: Sat, 17 Nov 2018 10:25:00 +0000 (UTC)
Message-ID: <dd270cafe06cc37079d4924cac8030823d4b7610.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

asm/book3s/32/pgtable.h is only included when CONFIG_PPC_BOOK3S_32 is set.
Whenever CONFIG_PPC_BOOK3S_32 is set, CONFIG_PPC_STD_MMU_32 is set as well.

This patch removes useless CONFIG_PPC_STD_MMU_32 #ifdefs

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c21d33704633..b849b45429d5 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -524,7 +524,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, pte_t pte, int percpu)
 {
-#if defined(CONFIG_PPC_STD_MMU_32) && defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
+#if defined(CONFIG_SMP) && !defined(CONFIG_PTE_64BIT)
 	/* First case is 32-bit Hash MMU in SMP mode with 32-bit PTEs. We use the
 	 * helper pte_update() which does an atomic update. We need to do that
 	 * because a concurrent invalidation can clear _PAGE_HASHPTE. If it's a
@@ -537,7 +537,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	else
 		pte_update(ptep, ~_PAGE_HASHPTE, pte_val(pte));
 
-#elif defined(CONFIG_PPC32) && defined(CONFIG_PTE_64BIT)
+#elif defined(CONFIG_PTE_64BIT)
 	/* Second case is 32-bit with 64-bit PTE.  In this case, we
 	 * can just store as long as we do the two halves in the right order
 	 * with a barrier in between. This is possible because we take care,
@@ -560,7 +560,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
 	: "r" (pte) : "memory");
 
-#elif defined(CONFIG_PPC_STD_MMU_32)
+#else
 	/* Third case is 32-bit hash table in UP mode, we need to preserve
 	 * the _PAGE_HASHPTE bit since we may not have invalidated the previous
 	 * translation in the hash yet (done in a subsequent flush_tlb_xxx())
@@ -568,9 +568,6 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	 */
 	*ptep = __pte((pte_val(*ptep) & _PAGE_HASHPTE)
 		      | (pte_val(pte) & ~_PAGE_HASHPTE));
-
-#else
-#error "Not supported "
 #endif
 }
 
-- 
2.13.3
