From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 08/19] PM: Remove unused asm/suspend.h
Date: Thu, 11 Jun 2009 23:04:18 +0000 (UTC)
Message-ID: <S4AoGnG.A.SG.beYMKB@chimera>
References: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Date: Thu Jun 11 23:25:58 CEST 2009
In-Reply-To: <0615007ad8090a890586d530b5d3bb98da566014.1244752872.git.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux PM List <linux-pm@lists.linux-foundation.org>
Cc: Sergio Luis <sergio@larces.uece.br>, Lauro Salmito <laurosalmito@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Magnus Damm <damm@igel.co.jp>, Ingo Molnar <mingo@elte.hu>, Wu Fengguang <fengguang.wu@intel.com>, Jaswinder Singh Rajput <jaswinder@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch removes unused asm/suspend.h files for
the following architectures:

 alpha, arm, ia64, m68k, mips, s390, um

Signed-off-by: Magnus Damm <damm@igel.co.jp>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/alpha/include/asm/suspend.h |    6 ------
 arch/arm/include/asm/suspend.h   |    4 ----
 arch/ia64/include/asm/suspend.h  |    1 -
 arch/m68k/include/asm/suspend.h  |    6 ------
 arch/mips/include/asm/suspend.h  |    6 ------
 arch/s390/include/asm/suspend.h  |    5 -----
 arch/um/include/asm/suspend.h    |    4 ----
 7 files changed, 0 insertions(+), 32 deletions(-)
 delete mode 100644 arch/alpha/include/asm/suspend.h
 delete mode 100644 arch/arm/include/asm/suspend.h
 delete mode 100644 arch/ia64/include/asm/suspend.h
 delete mode 100644 arch/m68k/include/asm/suspend.h
 delete mode 100644 arch/mips/include/asm/suspend.h
 delete mode 100644 arch/s390/include/asm/suspend.h
 delete mode 100644 arch/um/include/asm/suspend.h

diff --git a/arch/alpha/include/asm/suspend.h b/arch/alpha/include/asm/suspend.h
deleted file mode 100644
index c7042d5..0000000
--- a/arch/alpha/include/asm/suspend.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ALPHA_SUSPEND_H
-#define __ALPHA_SUSPEND_H
-
-/* Dummy include. */
-
-#endif  /* __ALPHA_SUSPEND_H */
diff --git a/arch/arm/include/asm/suspend.h b/arch/arm/include/asm/suspend.h
deleted file mode 100644
index cf0d0bd..0000000
--- a/arch/arm/include/asm/suspend.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef _ASMARM_SUSPEND_H
-#define _ASMARM_SUSPEND_H
-
-#endif
diff --git a/arch/ia64/include/asm/suspend.h b/arch/ia64/include/asm/suspend.h
deleted file mode 100644
index b05bbb6..0000000
--- a/arch/ia64/include/asm/suspend.h
+++ /dev/null
@@ -1 +0,0 @@
-/* dummy (must be non-empty to prevent prejudicial removal...) */
diff --git a/arch/m68k/include/asm/suspend.h b/arch/m68k/include/asm/suspend.h
deleted file mode 100644
index 57b3ddb..0000000
--- a/arch/m68k/include/asm/suspend.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef _M68K_SUSPEND_H
-#define _M68K_SUSPEND_H
-
-/* Dummy include. */
-
-#endif  /* _M68K_SUSPEND_H */
diff --git a/arch/mips/include/asm/suspend.h b/arch/mips/include/asm/suspend.h
deleted file mode 100644
index 2562f8f..0000000
--- a/arch/mips/include/asm/suspend.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_SUSPEND_H
-#define __ASM_SUSPEND_H
-
-/* Somewhen...  Maybe :-)  */
-
-#endif /* __ASM_SUSPEND_H */
diff --git a/arch/s390/include/asm/suspend.h b/arch/s390/include/asm/suspend.h
deleted file mode 100644
index 1f34580..0000000
--- a/arch/s390/include/asm/suspend.h
+++ /dev/null
@@ -1,5 +0,0 @@
-#ifndef __ASM_S390_SUSPEND_H
-#define __ASM_S390_SUSPEND_H
-
-#endif
-
diff --git a/arch/um/include/asm/suspend.h b/arch/um/include/asm/suspend.h
deleted file mode 100644
index f4e8e00..0000000
--- a/arch/um/include/asm/suspend.h
+++ /dev/null
@@ -1,4 +0,0 @@
-#ifndef __UM_SUSPEND_H
-#define __UM_SUSPEND_H
-
-#endif
-- 
1.5.2.4
