From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH] pm: remove unused asm/suspend.h
Date: Tue, 12 May 2009 22:16:06 +0900
Message-ID: <20090512131606.7984.69575.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org


From: Magnus Damm <damm@igel.co.jp>

This patch removes unused asm/suspend.h files for
the following architectures:

 alpha, arm, ia64, m68k, mips, s390, um

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/alpha/include/asm/suspend.h |    6 ------
 arch/arm/include/asm/suspend.h   |    4 ----
 arch/ia64/include/asm/suspend.h  |    1 -
 arch/m68k/include/asm/suspend.h  |    6 ------
 arch/mips/include/asm/suspend.h  |    6 ------
 arch/s390/include/asm/suspend.h  |    5 -----
 arch/um/include/asm/suspend.h    |    4 ----
 7 files changed, 32 deletions(-)

--- 0001/arch/alpha/include/asm/suspend.h
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1,6 +0,0 @@
-#ifndef __ALPHA_SUSPEND_H
-#define __ALPHA_SUSPEND_H
-
-/* Dummy include. */
-
-#endif  /* __ALPHA_SUSPEND_H */
--- 0001/arch/arm/include/asm/suspend.h
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1,4 +0,0 @@
-#ifndef _ASMARM_SUSPEND_H
-#define _ASMARM_SUSPEND_H
-
-#endif
--- 0001/arch/ia64/include/asm/suspend.h
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1 +0,0 @@
-/* dummy (must be non-empty to prevent prejudicial removal...) */
--- 0001/arch/m68k/include/asm/suspend.h
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1,6 +0,0 @@
-#ifndef _M68K_SUSPEND_H
-#define _M68K_SUSPEND_H
-
-/* Dummy include. */
-
-#endif  /* _M68K_SUSPEND_H */
--- 0001/arch/mips/include/asm/suspend.h
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1,6 +0,0 @@
-#ifndef __ASM_SUSPEND_H
-#define __ASM_SUSPEND_H
-
-/* Somewhen...  Maybe :-)  */
-
-#endif /* __ASM_SUSPEND_H */
--- 0001/arch/s390/include/asm/suspend.h
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1,5 +0,0 @@
-#ifndef __ASM_S390_SUSPEND_H
-#define __ASM_S390_SUSPEND_H
-
-#endif
-
--- 0001/arch/um/include/asm/suspend.h
+++ /dev/null	2009-05-12 09:34:44.497006305 +0900
@@ -1,4 +0,0 @@
-#ifndef __UM_SUSPEND_H
-#define __UM_SUSPEND_H
-
-#endif
