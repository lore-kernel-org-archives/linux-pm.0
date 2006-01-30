From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm] swsusp userland interface:
	additional ioctl
Date: Mon, 30 Jan 2006 22:15:09 +0100
Message-ID: <200601302215.10384.rjw@sisk.pl>
References: <200601292256.23124.rjw@sisk.pl> <200601292346.58928.rjw@sisk.pl>
	<20060129230647.GE2318@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060129230647.GE2318@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday 30 January 2006 00:06, Pavel Machek wrote:
> > > > The appended patch provides an additional ioctl() for the swsusp userland
> > > > interface that will allow the suspending and/or resuming utilities to change
> > > > the kernel log level at the time of suspend/resume (or even set it to 0 if
> > > > they are going to use some frame buffer graphics etc.).
> > > 
> > > klogd can already change loglevel... It should be possible to use that
> > > to silence suspend, no?
> > 
> > Well, no.  Currently the kernel changes the log level to 10 unconditionally
> > in pm_prepare_console() (that's the reason for the patch, BTW).
> 
> Can we just kill that log-level setting? It may have been useful in
> the past, but I do not think it has right to live any more.

Sure, we can:

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/console.c |   12 +-----------
 kernel/power/power.h   |    5 +++++
 2 files changed, 6 insertions(+), 11 deletions(-)

Index: linux-2.6.16-rc1-mm4/kernel/power/console.c
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/power/console.c	2006-01-30 21:17:53.000000000 +0100
+++ linux-2.6.16-rc1-mm4/kernel/power/console.c	2006-01-30 21:32:24.000000000 +0100
@@ -9,18 +9,11 @@
 #include <linux/console.h>
 #include "power.h"
 
-static int new_loglevel = 10;
-static int orig_loglevel;
 #ifdef SUSPEND_CONSOLE
 static int orig_fgconsole, orig_kmsg;
-#endif
 
 int pm_prepare_console(void)
 {
-	orig_loglevel = console_loglevel;
-	console_loglevel = new_loglevel;
-
-#ifdef SUSPEND_CONSOLE
 	acquire_console_sem();
 
 	orig_fgconsole = fg_console;
@@ -41,18 +34,15 @@ int pm_prepare_console(void)
 	}
 	orig_kmsg = kmsg_redirect;
 	kmsg_redirect = SUSPEND_CONSOLE;
-#endif
 	return 0;
 }
 
 void pm_restore_console(void)
 {
-	console_loglevel = orig_loglevel;
-#ifdef SUSPEND_CONSOLE
 	acquire_console_sem();
 	set_console(orig_fgconsole);
 	release_console_sem();
 	kmsg_redirect = orig_kmsg;
-#endif
 	return;
 }
+#endif
Index: linux-2.6.16-rc1-mm4/kernel/power/power.h
===================================================================
--- linux-2.6.16-rc1-mm4.orig/kernel/power/power.h	2006-01-30 21:19:43.000000000 +0100
+++ linux-2.6.16-rc1-mm4/kernel/power/power.h	2006-01-30 21:33:19.000000000 +0100
@@ -43,8 +43,13 @@ static struct subsys_attribute _name##_a
 
 extern struct subsystem power_subsys;
 
+#ifdef SUSPEND_CONSOLE
 extern int pm_prepare_console(void);
 extern void pm_restore_console(void);
+#else
+static int pm_prepare_console(void) { return 0; }
+static void pm_restore_console(void) {}
+#endif
 
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
