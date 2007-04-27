From: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time printk
 output after resume
Date: Fri, 27 Apr 2007 15:52:12 +0300 (EEST)
Message-ID: <Pine.LNX.4.64.0704271551250.12688@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0704271522070.11149@sbz-30.cs.Helsinki.FI>
	<20070427123615.GF22250@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070427123615.GF22250@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Apr 2007, Pavel Machek wrote:
> 1. This should not be a config option

Ok.

On Fri, 27 Apr 2007, Pavel Machek wrote:
> 2. This does not work. pointers are nosave, but logbuf is not. Eh?

My bad, sorry. Thanks for the comments, Pavel!

			Pekka

[PATCH] kernel: preserve boot-time printk output after resume
From: Nigel Cunningham <nigel@nigel.suspend2.net>

This makes the kernel preserve boot-time printk() output after resume.

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---
 kernel/printk.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

Index: 2.6/kernel/printk.c
===================================================================
--- 2.6.orig/kernel/printk.c	2007-04-27 15:39:26.000000000 +0300
+++ 2.6/kernel/printk.c	2007-04-27 15:49:25.000000000 +0300
@@ -92,9 +92,9 @@ static DEFINE_SPINLOCK(logbuf_lock);
  * The indices into log_buf are not constrained to log_buf_len - they
  * must be masked before subscripting
  */
-static unsigned long log_start;	/* Index into log_buf: next char to be read by syslog() */
-static unsigned long con_start;	/* Index into log_buf: next char to be sent to consoles */
-static unsigned long log_end;	/* Index into log_buf: most-recently-written-char + 1 */
+static unsigned long __nosavedata log_start;	/* Index into log_buf: next char to be read by syslog() */
+static unsigned long __nosavedata con_start;	/* Index into log_buf: next char to be sent to consoles */
+static unsigned long __nosavedata log_end;	/* Index into log_buf: most-recently-written-char + 1 */
 
 /*
  *	Array of consoles built from command line options (console=)
@@ -117,10 +117,10 @@ static int console_may_schedule;
 
 #ifdef CONFIG_PRINTK
 
-static char __log_buf[__LOG_BUF_LEN];
-static char *log_buf = __log_buf;
-static int log_buf_len = __LOG_BUF_LEN;
-static unsigned long logged_chars; /* Number of chars produced since last read+clear operation */
+static char __nosavedata __log_buf[__LOG_BUF_LEN];
+static char __nosavedata *log_buf = __log_buf;
+static int __nosavedata log_buf_len = __LOG_BUF_LEN;
+static unsigned long __nosavedata logged_chars; /* Number of chars produced since last read+clear operation */
 
 static int __init log_buf_len_setup(char *str)
 {
