From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 4/4] tile: Update comments for generic idle conversion
Date: Fri, 23 May 2014 10:54:25 +0200
Message-ID: <1400835265-21956-5-git-send-email-geert+renesas@glider.be>
References: <1400835265-21956-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1400835265-21956-1-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Chris Metcalf <cmetcalf@tilera.com>
List-Id: linux-pm@vger.kernel.org

As of commit 0dc8153cfebac68c9523b8852b14f10b31209f08 ("tile: Use generic
idle loop"), this applies to arch_cpu_idle() instead of cpu_idle().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Metcalf <cmetcalf@tilera.com>
---
 arch/tile/include/asm/thread_info.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/tile/include/asm/thread_info.h b/arch/tile/include/asm/thread_info.h
index 729aa107f64e..80ba7d40ecc0 100644
--- a/arch/tile/include/asm/thread_info.h
+++ b/arch/tile/include/asm/thread_info.h
@@ -94,7 +94,7 @@ register unsigned long stack_pointer __asm__("sp");
 /* Sit on a nap instruction until interrupted. */
 extern void smp_nap(void);
 
-/* Enable interrupts racelessly and nap forever: helper for cpu_idle(). */
+/* Enable interrupts racelessly and nap forever: helper for arch_cpu_idle(). */
 extern void _cpu_idle(void);
 
 #else /* __ASSEMBLY__ */
-- 
1.9.1
