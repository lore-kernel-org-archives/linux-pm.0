From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] Hibernation: Fix lockdep report (v2)
Date: Wed, 14 Nov 2007 22:25:57 +0100
Message-ID: <200711142225.58033.rjw__18710.0332150751$1195074595$gmane$org@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[Andrew, please consider this as 2.6.24 material, thanks.]
---
From: Johannes Berg <johannes@sipsolutions.net>

Lockdep reports a circular locking dependency in the hibernate code
because
=A0- during system boot hibernate code (from an initcall) locks pm_mutex
=A0 =A0and then a sysfs buffer mutex via name_to_dev_t
=A0- during regular operation hibernate code locks pm_mutex under a
=A0 =A0sysfs buffer mutex because it's called from sysfs methods.

The deadlock can never happen because during initcall invocation nothing
can write to sysfs yet. This removes the lockdep report by marking the
initcall locking as being in a different class.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 kernel/power/disk.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: linux-2.6/kernel/power/disk.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.orig/kernel/power/disk.c
+++ linux-2.6/kernel/power/disk.c
@@ -456,7 +456,17 @@ static int software_resume(void)
 	int error;
 	unsigned int flags;
=20
-	mutex_lock(&pm_mutex);
+	/*
+	 * name_to_dev_t() below takes a sysfs buffer mutex when sysfs
+	 * is configured into the kernel. Since the regular hibernate
+	 * trigger path is via sysfs which takes a buffer mutex before
+	 * calling hibernate functions (which take pm_mutex) this can
+	 * cause lockdep to complain about a possible ABBA deadlock
+	 * which cannot happen since we're in the boot code here and
+	 * sysfs can't be invoked yet. Therefore, we use a subclass
+	 * here to avoid lockdep complaining.
+	 */
+	mutex_lock_nested(&pm_mutex, SINGLE_DEPTH_NESTING);
 	if (!swsusp_resume_device) {
 		if (!strlen(resume_file)) {
 			mutex_unlock(&pm_mutex);
