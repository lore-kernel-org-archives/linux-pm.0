From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] x86: Make NUMA on 32-bit depend on EXPERIMENTAL
	again
Date: Wed, 12 Nov 2008 23:26:14 +0100
Message-ID: <200811122326.16107.rjw__23296.5774870992$1226528714$gmane$org@sisk.pl>
References: <20081109140726.GB1786@ucw.cz> <200811122257.50998.rjw@sisk.pl>
	<200811122322.36781.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200811122322.36781.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: kernel list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: x86: Make NUMA on 32-bit depend on EXPERIMENTAL again

My previous patch to make CONFIG_NUMA on x86_32 depend on BROKEN
turned out to be unnecessary, after all, since the source of the
hibernation vs CONFIG_NUMA problem turned out to be the fact that
we didn't take the NUMA KVA remapping into account in the
hibernation code.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/arch/x86/Kconfig
===================================================================
--- linux-2.6.orig/arch/x86/Kconfig
+++ linux-2.6/arch/x86/Kconfig
@@ -957,7 +957,7 @@ config ARCH_PHYS_ADDR_T_64BIT
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support (EXPERIMENTAL)"
 	depends on SMP
+	depends on X86_64 || (X86_32 && HIGHMEM64G && (X86_NUMAQ || X86_BIGSMP || X86_SUMMIT && ACPI) && EXPERIMENTAL)
-	depends on X86_64 || (X86_32 && HIGHMEM64G && (X86_NUMAQ || X86_BIGSMP || X86_SUMMIT && ACPI) && BROKEN)
 	default n if X86_PC
 	default y if (X86_NUMAQ || X86_SUMMIT || X86_BIGSMP)
 	help
