From: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: [RFC/PATCH 1/2] swsusp: preserve boot-time printk output
	after resume
Date: Fri, 27 Apr 2007 15:25:06 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0704271522070.11149@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: linux-pm@lists.osdl.org
Cc: nigel@nigel.suspend2.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

Hi,

Nigel, can I please get a sign-off for these if you're okay with them. 
Rafael, Pavel, please ACK or NAK. Thanks.

			Pekka

From: Nigel Cunningham <nigel@nigel.suspend2.net>

Adds a new config option CONFIG_PRINTK_NOSAVE which makes the kernel
preserve printk() output from boot after resume.  This is useful for
debugging hibernation.

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 include/linux/suspend.h |    6 ++++++
 kernel/power/Kconfig    |   11 +++++++++++
 kernel/printk.c         |    7 ++++---
 3 files changed, 21 insertions(+), 3 deletions(-)

Index: 2.6/include/linux/suspend.h
===================================================================
--- 2.6.orig/include/linux/suspend.h	2007-04-27 14:42:13.000000000 +0300
+++ 2.6/include/linux/suspend.h	2007-04-27 14:43:13.000000000 +0300
@@ -55,4 +55,10 @@ unsigned long get_safe_page(gfp_t gfp_ma
  */
 #define PAGES_FOR_IO	1024
 
+#ifdef CONFIG_PRINTK_NOSAVE
+#define POSS_NOSAVE __nosavedata
+#else
+#define POSS_NOSAVE
+#endif
+
 #endif /* _LINUX_SWSUSP_H */
Index: 2.6/kernel/power/Kconfig
===================================================================
--- 2.6.orig/kernel/power/Kconfig	2007-04-27 14:42:13.000000000 +0300
+++ 2.6/kernel/power/Kconfig	2007-04-27 14:43:13.000000000 +0300
@@ -48,6 +48,17 @@ config DISABLE_CONSOLE_SUSPEND
 	suspend/resume routines, but may itself lead to problems, for example
 	if netconsole is used.
 
+config PRINTK_NOSAVE
+	bool "Preserve printk data from boot kernel when resuming."
+	default n
+	---help---
+	This option gives printk data and the associated variables the
+	attribute __nosave, which means that they will not be saves as
+	part of the image. The net effect is that after resuming, your
+	dmesg will show the messages from prior to the atomic restore,
+	instead of the messages from the resumed kernel. This may be
+	useful for debugging hibernation.
+
 config PM_TRACE
 	bool "Suspend/resume event tracing"
 	depends on PM && PM_DEBUG && X86_32 && EXPERIMENTAL
Index: 2.6/kernel/printk.c
===================================================================
--- 2.6.orig/kernel/printk.c	2007-04-27 14:42:13.000000000 +0300
+++ 2.6/kernel/printk.c	2007-04-27 14:43:13.000000000 +0300
@@ -32,6 +32,7 @@  *	01Mar01 Andrew Morton <andrewm@uow.ed
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/jiffies.h>
+#include <linux/suspend.h>
 
 #include <asm/uaccess.h>
 
@@ -92,9 +93,9 @@ static DEFINE_SPINLOCK(logbuf_lock);
  * The indices into log_buf are not constrained to log_buf_len - they
  * must be masked before subscripting
  */
-static unsigned long log_start;	/* Index into log_buf: next char to be read by syslog() */
-static unsigned long con_start;	/* Index into log_buf: next char to be sent to consoles */
-static unsigned long log_end;	/* Index into log_buf: most-recently-written-char + 1 */
+static unsigned long POSS_NOSAVE log_start;	/* Index into log_buf: next char to be read by syslog() */
+static unsigned long POSS_NOSAVE con_start;	/* Index into log_buf: next char to be sent to consoles */
+static unsigned long POSS_NOSAVE log_end;	/* Index into log_buf: most-recently-written-char + 1 */
 
 /*
  *	Array of consoles built from command line options (console=)
