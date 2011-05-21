From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/3] PM / Hibernate: Remove arch_prepare_suspend()
Date: Sat, 21 May 2011 14:10:34 +0200
Message-ID: <201105211410.34491.rjw__45466.9330655181$1305980027$gmane$org@sisk.pl>
References: <201105211408.28671.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105211408.28671.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Cc: Frank Hofmann <frank.hofmann@tomtom.com>, LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

All architectures supporting hibernation define
arch_prepare_suspend() as an empty function, so remove it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/frv/include/asm/suspend.h       |   20 --------------------
 arch/mips/include/asm/suspend.h      |    2 --
 arch/powerpc/include/asm/suspend.h   |    6 ------
 arch/s390/include/asm/suspend.h      |   10 ----------
 arch/sh/include/asm/suspend.h        |    1 -
 arch/unicore32/include/asm/suspend.h |    1 -
 arch/x86/include/asm/suspend_32.h    |    2 --
 arch/x86/include/asm/suspend_64.h    |    5 -----
 kernel/power/hibernate.c             |    4 ----
 9 files changed, 51 deletions(-)

Index: linux-2.6/arch/frv/include/asm/suspend.h
===================================================================
--- linux-2.6.orig/arch/frv/include/asm/suspend.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* suspend.h: suspension stuff
- *
- * Copyright (C) 2004 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#ifndef _ASM_SUSPEND_H
-#define _ASM_SUSPEND_H
-
-static inline int arch_prepare_suspend(void)
-{
-	return 0;
-}
-
-#endif /* _ASM_SUSPEND_H */
Index: linux-2.6/arch/s390/include/asm/suspend.h
===================================================================
--- linux-2.6.orig/arch/s390/include/asm/suspend.h
+++ /dev/null
@@ -1,10 +0,0 @@
-#ifndef __ASM_S390_SUSPEND_H
-#define __ASM_S390_SUSPEND_H
-
-static inline int arch_prepare_suspend(void)
-{
-	return 0;
-}
-
-#endif
-
Index: linux-2.6/arch/sh/include/asm/suspend.h
===================================================================
--- linux-2.6.orig/arch/sh/include/asm/suspend.h
+++ linux-2.6/arch/sh/include/asm/suspend.h
@@ -3,7 +3,6 @@
 
 #ifndef __ASSEMBLY__
 #include <linux/notifier.h>
-static inline int arch_prepare_suspend(void) { return 0; }
 
 #include <asm/ptrace.h>
 
Index: linux-2.6/arch/mips/include/asm/suspend.h
===================================================================
--- linux-2.6.orig/arch/mips/include/asm/suspend.h
+++ linux-2.6/arch/mips/include/asm/suspend.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_SUSPEND_H
 #define __ASM_SUSPEND_H
 
-static inline int arch_prepare_suspend(void) { return 0; }
-
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
Index: linux-2.6/arch/powerpc/include/asm/suspend.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/suspend.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_POWERPC_SUSPEND_H
-#define __ASM_POWERPC_SUSPEND_H
-
-static inline int arch_prepare_suspend(void) { return 0; }
-
-#endif /* __ASM_POWERPC_SUSPEND_H */
Index: linux-2.6/arch/unicore32/include/asm/suspend.h
===================================================================
--- linux-2.6.orig/arch/unicore32/include/asm/suspend.h
+++ linux-2.6/arch/unicore32/include/asm/suspend.h
@@ -14,7 +14,6 @@
 #define __UNICORE_SUSPEND_H__
 
 #ifndef __ASSEMBLY__
-static inline int arch_prepare_suspend(void) { return 0; }
 
 #include <asm/ptrace.h>
 
Index: linux-2.6/arch/x86/include/asm/suspend_32.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/suspend_32.h
+++ linux-2.6/arch/x86/include/asm/suspend_32.h
@@ -9,8 +9,6 @@
 #include <asm/desc.h>
 #include <asm/i387.h>
 
-static inline int arch_prepare_suspend(void) { return 0; }
-
 /* image of the saved processor state */
 struct saved_context {
 	u16 es, fs, gs, ss;
Index: linux-2.6/arch/x86/include/asm/suspend_64.h
===================================================================
--- linux-2.6.orig/arch/x86/include/asm/suspend_64.h
+++ linux-2.6/arch/x86/include/asm/suspend_64.h
@@ -9,11 +9,6 @@
 #include <asm/desc.h>
 #include <asm/i387.h>
 
-static inline int arch_prepare_suspend(void)
-{
-	return 0;
-}
-
 /*
  * Image of the saved processor state, used by the low level ACPI suspend to
  * RAM code and by the low level hibernation code.
Index: linux-2.6/kernel/power/hibernate.c
===================================================================
--- linux-2.6.orig/kernel/power/hibernate.c
+++ linux-2.6/kernel/power/hibernate.c
@@ -244,10 +244,6 @@ static int create_image(int platform_mod
 {
 	int error;
 
-	error = arch_prepare_suspend();
-	if (error)
-		return error;
-
 	error = dpm_suspend_noirq(PMSG_FREEZE);
 	if (error) {
 		printk(KERN_ERR "PM: Some devices failed to power down, "
