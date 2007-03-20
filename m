From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] remove firmware disk mode
Date: Tue, 20 Mar 2007 12:02:53 +0100
Message-ID: <1174388573.3770.26.camel@johannes.berg>
References: <20070320015846.636692000@sipsolutions.net>
	<20070320084744.984025000@sipsolutions.net>
	<20070320093105.GD3922@elf.ucw.cz>
	<1174383407.3770.3.camel@johannes.berg>
	<20070320094352.GF3922@elf.ucw.cz>
	<1174385865.3770.20.camel@johannes.berg>
	<20070320102551.GB19283@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070320102551.GB19283@elf.ucw.cz>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This patch removes the firmware disk suspend mode which is the wrong
approach, it is supposed to be used for implementing firmware-based disk
suspend but cannot actually be used for that.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 include/linux/pm.h  |   13 ++++++-------
 kernel/power/disk.c |    3 +--
 2 files changed, 7 insertions(+), 9 deletions(-)

--- linux-2.6.orig/include/linux/pm.h	2007-03-20 11:55:22.663214909 +0100
+++ linux-2.6/include/linux/pm.h	2007-03-20 11:56:09.783214909 +0100
@@ -114,13 +114,12 @@ typedef int __bitwise suspend_disk_metho
 =

 /* invalid must be 0 so struct pm_ops initialisers can leave it out */
 #define PM_DISK_INVALID		((__force suspend_disk_method_t) 0)
-#define	PM_DISK_FIRMWARE	((__force suspend_disk_method_t) 1)
-#define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 2)
-#define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 3)
-#define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 4)
-#define	PM_DISK_TEST		((__force suspend_disk_method_t) 5)
-#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 6)
-#define	PM_DISK_MAX		((__force suspend_disk_method_t) 7)
+#define	PM_DISK_PLATFORM	((__force suspend_disk_method_t) 1)
+#define	PM_DISK_SHUTDOWN	((__force suspend_disk_method_t) 2)
+#define	PM_DISK_REBOOT		((__force suspend_disk_method_t) 3)
+#define	PM_DISK_TEST		((__force suspend_disk_method_t) 4)
+#define	PM_DISK_TESTPROC	((__force suspend_disk_method_t) 5)
+#define	PM_DISK_MAX		((__force suspend_disk_method_t) 6)
 =

 /**
  * struct pm_ops - Callbacks for managing platform dependent suspend state=
s.
--- linux-2.6.orig/kernel/power/disk.c	2007-03-20 11:55:23.353214909 +0100
+++ linux-2.6/kernel/power/disk.c	2007-03-20 11:56:09.783214909 +0100
@@ -304,7 +304,6 @@ late_initcall(software_resume);
 =

 =

 static const char * const pm_disk_modes[] =3D {
-	[PM_DISK_FIRMWARE]	=3D "firmware",
 	[PM_DISK_PLATFORM]	=3D "platform",
 	[PM_DISK_SHUTDOWN]	=3D "shutdown",
 	[PM_DISK_REBOOT]	=3D "reboot",
@@ -357,7 +356,7 @@ static ssize_t disk_store(struct subsyst
 	len =3D p ? p - buf : n;
 =

 	mutex_lock(&pm_mutex);
-	for (i =3D PM_DISK_FIRMWARE; i < PM_DISK_MAX; i++) {
+	for (i =3D PM_DISK_PLATFORM; i < PM_DISK_MAX; i++) {
 		if (!strncmp(buf, pm_disk_modes[i], len)) {
 			mode =3D i;
 			break;
