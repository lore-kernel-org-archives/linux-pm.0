From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH] power management: change /sys/power/disk display
Date: Thu, 22 Mar 2007 15:34:11 +0100
Message-ID: <1174574051.3588.5.camel@johannes.berg>
References: <1174468981.3769.8.camel@johannes.berg>
	<20070321122954.GO4520@elf.ucw.cz>
	<1174480375.4230.12.camel@johannes.berg>
	<20070321131128.GB4523@elf.ucw.cz>
	<1174482773.4230.19.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174482773.4230.19.camel@johannes.berg>
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
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

This patch changes /sys/power/disk to display all valid modes
as well as the currently selected one in a fashion known from
the LED subsystem.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

---
This patch is the simplified version that just changes the attribute
instead of introducing a new on. It also contains the relevant updates
to the documentation.

Good to push for .22?

 Documentation/power/interface.txt |    8 ++++++--
 kernel/power/disk.c               |   34 +++++++++++++++++++++++++++++++---
 2 files changed, 37 insertions(+), 5 deletions(-)

--- linux-2.6.orig/kernel/power/disk.c	2007-03-22 13:56:20.184654656 +0100
+++ linux-2.6/kernel/power/disk.c	2007-03-22 14:00:18.754654656 +0100
@@ -333,7 +333,34 @@ static const char * const pm_disk_modes[
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

@@ -374,8 +401,9 @@ static ssize_t disk_store(struct subsyst
 		error =3D -EINVAL;
 	}
 =

-	pr_debug("PM: suspend-to-disk mode set to '%s'\n",
-		 pm_disk_modes[mode]);
+	if (!error)
+		pr_debug("PM: suspend-to-disk mode set to '%s'\n",
+			 pm_disk_modes[mode]);
 	mutex_unlock(&pm_mutex);
 	return error ? error : n;
 }
--- linux-2.6.orig/Documentation/power/interface.txt	2007-03-22 14:01:09.68=
4654656 +0100
+++ linux-2.6/Documentation/power/interface.txt	2007-03-22 14:02:22.9846546=
56 +0100
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
