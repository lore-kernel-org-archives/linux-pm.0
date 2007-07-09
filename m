From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm 6/6] Freezer: Document relationship with
	memory shrinking
Date: Mon, 9 Jul 2007 22:41:28 +0200
Message-ID: <200707092241.29029.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707092229.08898.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

One important reason to freeze tasks, which is that we don't want them to
allocate memory after freeing it for the hibernation image, has not been
documented.  Fix it.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/freezing-of-tasks.txt |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

Index: linux-2.6.22-rc7/Documentation/power/freezing-of-tasks.txt
===================================================================
--- linux-2.6.22-rc7.orig/Documentation/power/freezing-of-tasks.txt
+++ linux-2.6.22-rc7/Documentation/power/freezing-of-tasks.txt
@@ -88,7 +88,16 @@ hibernation image has been created and b
 The majority of these are user space processes, but if any of the kernel threads
 may cause something like this to happen, they have to be freezable.
 
-2. The second reason is to prevent user space processes and some kernel threads
+2. Next, to create the hibernation image we need to free a sufficient amount of
+memory (approximately 50% of available RAM) and we need to do that before
+devices are deactivated, because we generally need them for swapping out.  Then,
+after the memory for the image has been freed, we don't want tasks to allocate
+additional memory and we prevent them from doing that by freezing them earlier.
+[Of course, this also means that device drivers should not allocate substantial
+amounts of memory from their .suspend() callbacks before hibernation, but this
+is e separate issue.]
+
+3. The third reason is to prevent user space processes and some kernel threads
 from interfering with the suspending and resuming of devices.  A user space
 process running on a second CPU while we are suspending devices may, for
 example, be troublesome and without the freezing of tasks we would need some
@@ -118,7 +127,7 @@ frozen before the driver's .suspend() ca
 thawed after the driver's .resume() callback has run, so it won't be accessing
 the device while it's suspended.
 
-3. Another reason for freezing tasks is to prevent user space processes from
+4. Another reason for freezing tasks is to prevent user space processes from
 realizing that hibernation (or suspend) operation takes place.  Ideally, user
 space processes should not notice that such a system-wide operation has occurred
 and should continue running without any problems after the restore (or resume
