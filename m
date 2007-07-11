From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 1/7] Freezer: Document relationship with
	memory shrinking
Date: Thu, 12 Jul 2007 00:08:50 +0200
Message-ID: <200707120008.51074.rjw@sisk.pl>
References: <200707120006.50095.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707120006.50095.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Oleg Nesterov <oleg@tv-sign.ru>, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

One important reason to freeze tasks, which is that we don't want them to
allocate memory after freeing it for the hibernation image, has not been
documented. =A0Fix it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/power/freezing-of-tasks.txt |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Index: linux-2.6.22-rc6-mm1/Documentation/power/freezing-of-tasks.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc6-mm1.orig/Documentation/power/freezing-of-tasks.txt	2=
007-07-11 20:48:04.000000000 +0200
+++ linux-2.6.22-rc6-mm1/Documentation/power/freezing-of-tasks.txt	2007-0=
7-11 20:50:24.000000000 +0200
@@ -81,7 +81,16 @@ hibernation image has been created and b
 The majority of these are user space processes, but if any of the kernel=
 threads
 may cause something like this to happen, they have to be freezable.
=20
-2. The second reason is to prevent user space processes and some kernel =
threads
+2. Next, to create the hibernation image we need to free a sufficient am=
ount of
+memory (approximately 50% of available RAM) and we need to do that befor=
e
+devices are deactivated, because we generally need them for swapping out=
.  Then,
+after the memory for the image has been freed, we don't want tasks to al=
locate
+additional memory and we prevent them from doing that by freezing them e=
arlier.
+[Of course, this also means that device drivers should not allocate subs=
tantial
+amounts of memory from their .suspend() callbacks before hibernation, bu=
t this
+is e separate issue.]
+
+3. The third reason is to prevent user space processes and some kernel t=
hreads
 from interfering with the suspending and resuming of devices.  A user sp=
ace
 process running on a second CPU while we are suspending devices may, for
 example, be troublesome and without the freezing of tasks we would need =
some
@@ -111,7 +120,7 @@ frozen before the driver's .suspend() ca
 thawed after the driver's .resume() callback has run, so it won't be acc=
essing
 the device while it's suspended.
=20
-3. Another reason for freezing tasks is to prevent user space processes =
from
+4. Another reason for freezing tasks is to prevent user space processes =
from
 realizing that hibernation (or suspend) operation takes place.  Ideally,=
 user
 space processes should not notice that such a system-wide operation has =
occurred
 and should continue running without any problems after the restore (or r=
esume
