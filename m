From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 7/7] powerpc/kconfig: remove PPC_STD_MMU_32 and PPC_STD_MMU
Date: Sat, 17 Nov 2018 10:25:07 +0000 (UTC)
Message-ID: <4745d9467c7d399972dbd12265d0c434cb41e1ea.1542395798.git.christophe.leroy@c-s.fr>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

PPC_STD_MMU_32 and PPC_STD_MMU are not used anymore. Remove them.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/Kconfig                   |  2 +-
 arch/powerpc/platforms/Kconfig.cputype | 10 +---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ac9703e8e722..8ea7c2c02cbf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1096,7 +1096,7 @@ config PHYSICAL_START_BOOL
 
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if PHYSICAL_START_BOOL
-	default "0x02000000" if PPC_STD_MMU && CRASH_DUMP && !NONSTATIC_KERNEL
+	default "0x02000000" if PPC_BOOK3S && CRASH_DUMP && !NONSTATIC_KERNEL
 	default "0x00000000"
 
 config PHYSICAL_ALIGN
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a106e78558c0..7e130035bbba 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -312,14 +312,6 @@ config SPE
 
 	  If in doubt, say Y here.
 
-config PPC_STD_MMU
-	def_bool y
-	depends on PPC_BOOK3S
-
-config PPC_STD_MMU_32
-	def_bool y
-	depends on PPC_STD_MMU && PPC32
-
 config ARCH_ENABLE_SPLIT_PMD_PTLOCK
 	def_bool y
 	depends on PPC_BOOK3S_64
@@ -354,7 +346,7 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
 
 config PPC_MMU_NOHASH
 	def_bool y
-	depends on !PPC_STD_MMU
+	depends on !PPC_BOOK3S
 
 config PPC_BOOK3E_MMU
 	def_bool y
-- 
2.13.3
