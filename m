From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm] swsusp userland interface: additional
	ioctl
Date: Sun, 29 Jan 2006 22:56:22 +0100
Message-ID: <200601292256.23124.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============53440095636221607=="
Return-path: <linux-pm-bounces@lists.osdl.org>
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

--===============53440095636221607==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

The appended patch provides an additional ioctl() for the swsusp userland
interface that will allow the suspending and/or resuming utilities to change
the kernel log level at the time of suspend/resume (or even set it to 0 if
they are going to use some frame buffer graphics etc.).

Comments welcome.

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/console.c |    5 +++--
 kernel/power/power.h   |    6 +++++-
 kernel/power/user.c    |    5 +++++
 3 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-2.6.16-rc1-mm3/kernel/power/console.c
===================================================================
--- linux-2.6.16-rc1-mm3.orig/kernel/power/console.c	2006-01-15 12:42:27.000000000 +0100
+++ linux-2.6.16-rc1-mm3/kernel/power/console.c	2006-01-29 21:24:48.000000000 +0100
@@ -9,7 +9,8 @@
 #include <linux/console.h>
 #include "power.h"
 
-static int new_loglevel = 10;
+int suspend_loglevel = DEFAULT_SUSPEND_LOGLEVEL;
+
 static int orig_loglevel;
 #ifdef SUSPEND_CONSOLE
 static int orig_fgconsole, orig_kmsg;
@@ -18,7 +19,7 @@ static int orig_fgconsole, orig_kmsg;
 int pm_prepare_console(void)
 {
 	orig_loglevel = console_loglevel;
-	console_loglevel = new_loglevel;
+	console_loglevel = suspend_loglevel;
 
 #ifdef SUSPEND_CONSOLE
 	acquire_console_sem();
Index: linux-2.6.16-rc1-mm3/kernel/power/power.h
===================================================================
--- linux-2.6.16-rc1-mm3.orig/kernel/power/power.h	2006-01-25 21:21:13.000000000 +0100
+++ linux-2.6.16-rc1-mm3/kernel/power/power.h	2006-01-29 21:24:58.000000000 +0100
@@ -55,6 +55,9 @@ extern struct pbe *pagedir_nosave;
 extern unsigned long image_size;
 extern int in_suspend;
 extern dev_t swsusp_resume_device;
+extern int suspend_loglevel;
+
+#define DEFAULT_SUSPEND_LOGLEVEL	10
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
@@ -88,7 +91,8 @@ int snapshot_image_loaded(struct snapsho
 #define SNAPSHOT_GET_SWAP_PAGE		_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
 #define SNAPSHOT_FREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
 #define SNAPSHOT_SET_SWAP_FILE		_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
-#define SNAPSHOT_IOC_MAXNR	10
+#define SNAPSHOT_SET_LOGLEVEL		_IOW(SNAPSHOT_IOC_MAGIC, 11, int)
+#define SNAPSHOT_IOC_MAXNR	11
 
 /**
  *	The bitmap is used for tracing allocated swap pages
Index: linux-2.6.16-rc1-mm3/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc1-mm3.orig/kernel/power/user.c	2006-01-25 21:53:52.000000000 +0100
+++ linux-2.6.16-rc1-mm3/kernel/power/user.c	2006-01-29 21:24:48.000000000 +0100
@@ -78,6 +78,7 @@ static int snapshot_release(struct inode
 		enable_nonboot_cpus();
 		up(&pm_sem);
 	}
+	suspend_loglevel = DEFAULT_SUSPEND_LOGLEVEL;
 	atomic_inc(&device_available);
 	return 0;
 }
@@ -264,6 +265,10 @@ static int snapshot_ioctl(struct inode *
 		}
 		break;
 
+	case SNAPSHOT_SET_LOGLEVEL:
+		suspend_loglevel = arg <= 10 ? arg : DEFAULT_SUSPEND_LOGLEVEL;
+		break;
+
 	default:
 		error = -ENOTTY;
 

--===============53440095636221607==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============53440095636221607==--
