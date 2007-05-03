From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: Hibernation and suspend patchset
Date: Thu, 03 May 2007 21:08:55 +0200
Message-ID: <1178219335.4575.4.camel@johannes.berg>
References: <200705011558.11170.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705011558.11170.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Some bugs with freezer_exempt:

kernel/softirq.c: In function =E2=80=98ksoftirqd=E2=80=99:
kernel/softirq.c:515: warning: implicit declaration of function =E2=80=98=
freezer_exempt=E2=80=99
[...]

Maybe some header file they all use pulls in freezer.h on x86 but not on
powerpc? This fixes it.

--- linux-2.6-git.orig/drivers/block/loop.c	2007-05-03 15:30:23.274123904=
 +0200
+++ linux-2.6-git/drivers/block/loop.c	2007-05-03 15:30:43.015123904 +020=
0
@@ -74,6 +74,7 @@
 #include <linux/highmem.h>
 #include <linux/gfp.h>
 #include <linux/kthread.h>
+#include <linux/freezer.h>
=20
 #include <asm/uaccess.h>
=20
--- linux-2.6-git.orig/drivers/ieee1394/ieee1394_core.c	2007-05-03 15:30:=
23.423123904 +0200
+++ linux-2.6-git/drivers/ieee1394/ieee1394_core.c	2007-05-03 15:30:50.02=
3123904 +0200
@@ -34,6 +34,7 @@
 #include <linux/kthread.h>
 #include <linux/preempt.h>
 #include <linux/time.h>
+#include <linux/freezer.h>
=20
 #include <asm/system.h>
 #include <asm/byteorder.h>
--- linux-2.6-git.orig/drivers/scsi/scsi_error.c	2007-05-03 15:30:23.4981=
23904 +0200
+++ linux-2.6-git/drivers/scsi/scsi_error.c	2007-05-03 15:30:54.423123904=
 +0200
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/blkdev.h>
 #include <linux/delay.h>
+#include <linux/freezer.h>
=20
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
--- linux-2.6-git.orig/kernel/softirq.c	2007-05-03 15:30:23.187123904 +02=
00
+++ linux-2.6-git/kernel/softirq.c	2007-05-03 15:30:37.470123904 +0200
@@ -18,6 +18,7 @@
 #include <linux/rcupdate.h>
 #include <linux/smp.h>
 #include <linux/tick.h>
+#include <linux/freezer.h>
=20
 #include <asm/irq.h>
 /*
--- linux-2.6-git.orig/kernel/softlockup.c	2007-05-03 15:30:23.348123904 =
+0200
+++ linux-2.6-git/kernel/softlockup.c	2007-05-03 15:30:46.214123904 +0200
@@ -13,6 +13,7 @@
 #include <linux/kthread.h>
 #include <linux/notifier.h>
 #include <linux/module.h>
+#include <linux/freezer.h>
=20
 static DEFINE_SPINLOCK(print_lock);
=20
--- wireless-dev.orig/drivers/char/apm-emulation.c      2007-05-03 20:01:=
08.309154963 +0200
+++ wireless-dev/drivers/char/apm-emulation.c   2007-05-03 20:01:14.11915=
4963 +0200
@@ -27,6 +27,7 @@
 #include <linux/completion.h>
 #include <linux/kthread.h>
 #include <linux/delay.h>
+#include <linux/freezer.h>
=20
 #include <asm/system.h>
=20
