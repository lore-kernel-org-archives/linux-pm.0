From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v2] power management: change /sys/power/disk
	display
Date: Thu, 12 Apr 2007 12:49:52 +0200
Message-ID: <1176374992.7052.49.camel@johannes.berg>
References: <1176338224.3579.2.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176338224.3579.2.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch changes /sys/power/disk to display all valid modes
as well as the currently selected one in a fashion known from
the LED subsystem.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
 Documentation/power/interface.txt |    8 ++++++--
 kernel/power/disk.c               |   29 ++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 3 deletions(-)

--- wireless-dev.orig/kernel/power/disk.c	2007-04-12 11:58:14.275366513 +02=
00
+++ wireless-dev/kernel/power/disk.c	2007-04-12 12:49:07.965366513 +0200
@@ -322,7 +322,34 @@ static const char * const pm_disk_modes[
 =

 static ssize_t disk_show(struct subsystem * subsys, char * buf)
 {
-	return sprintf(buf, "%s\n", pm_disk_modes[pm_disk_mode]);
+	int i;
+	char *start =3D buf;
+
+	for (i =3D PM_DISK_PLATFORM; i < PM_DISK_MAX; i++) {
+		if (!pm_disk_modes[i])
+			continue;
+		switch (i) {
+		case PM_DISK_SHUTDOWN:
+		case PM_DISK_REBOOT:
+		case PM_DISK_TEST:
+		case PM_DISK_TESTPROC:
+			break;
+		default:
+			if (pm_ops && pm_ops->enter &&
+			    (i =3D=3D pm_ops->pm_disk_mode))
+				break;
+			/* not a valid mode, continue with loop */
+			continue;
+		}
+		if (i =3D=3D pm_disk_mode)
+			buf +=3D sprintf(buf, "[%s]", pm_disk_modes[i]);
+		else
+			buf +=3D sprintf(buf, "%s", pm_disk_modes[i]);
+		if (i+1 !=3D PM_DISK_MAX)
+			buf +=3D sprintf(buf, " ");
+	}
+	buf +=3D sprintf(buf, "\n");
+	return buf-start;
 }
 =

 =

--- wireless-dev.orig/Documentation/power/interface.txt	2007-04-12 11:58:14=
.285366513 +0200
+++ wireless-dev/Documentation/power/interface.txt	2007-04-12 11:58:15.8953=
66513 +0200
@@ -34,8 +34,12 @@ for 5 seconds, resume devices, unfreeze =

 we are able to look in the log messages and work out, for example, which c=
ode
 is being slow and which device drivers are misbehaving.
 =

-Reading from this file will display what the mode is currently set
-to. Writing to this file will accept one of
+Reading from this file will display all supported modes and the currently
+selected one in brackets, for example
+
+	[shutdown] reboot test testproc
+
+Writing to this file will accept one of
 =

        'platform' (only if the platform supports it)
        'shutdown'
