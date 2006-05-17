From: David Brownell <david-b@pacbell.net>
Subject: [patch 2.6.17-rc4-git] correct the USB info in
	Documentation/power/swsusp.txt
Date: Tue, 16 May 2006 17:33:14 -0700
Message-ID: <200605161733.15144.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_L9maEKX9eiSgnWT"
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
To: Greg KH <greg@kroah.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_L9maEKX9eiSgnWT
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

info == good, misinformation == bad

--Boundary-00=_L9maEKX9eiSgnWT
Content-Type: text/x-diff;
  charset="us-ascii";
  name="doc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="doc.patch"

The swsusp.txt documentation harshes confusingly on USB, and this patch
addresses the issue.  It's harsh because it blames USB for some issues
that are generic to all drivers -- especially those supporting removable
media -- and it's confusing since it says that USB has the issue with
"suspend" not just swsusp ... while in reality, USB doesn't have the
issue when real system suspend states are used.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/Documentation/power/swsusp.txt
===================================================================
--- g26.orig/Documentation/power/swsusp.txt	2006-05-16 15:39:47.000000000 -0700
+++ g26/Documentation/power/swsusp.txt	2006-05-16 15:56:40.000000000 -0700
@@ -18,10 +18,11 @@ Some warnings, first.
  *
  * (*) suspend/resume support is needed to make it safe.
  *
- * If you have any filesystems on USB devices mounted before suspend,
+ * If you have any filesystems on USB devices mounted before software suspend,
  * they won't be accessible after resume and you may lose data, as though
- * you have unplugged the USB devices with mounted filesystems on them
- * (see the FAQ below for details).
+ * you have unplugged the USB devices with mounted filesystems on them;
+ * see the FAQ below for details.  (This is not true for more traditional
+ * power states like "standby", which normally don't turn USB off.)
 
 You need to append resume=/dev/your_swap_partition to kernel command
 line. Then you suspend by
@@ -204,7 +205,7 @@ Q: There don't seem to be any generally 
 distinctions between SUSPEND and FREEZE.
 
 A: Doing SUSPEND when you are asked to do FREEZE is always correct,
-but it may be unneccessarily slow. If you want USB to stay simple,
+but it may be unneccessarily slow. If you want your driver to stay simple,
 slowness may not matter to you. It can always be fixed later.
 
 For devices like disk it does matter, you do not want to spindown for
@@ -357,17 +358,25 @@ Q: Is this true that if I have a mounted
 I suspend to disk, I can lose data unless the filesystem has been mounted
 with "sync"?
 
-A: That's right.  It depends on your hardware, and it could be true even for
-suspend-to-RAM.  In fact, even with "-o sync" you can lose data if your
-programs have information in buffers they haven't written out to disk.
-
-If you're lucky, your hardware will support low-power modes for USB
-controllers while the system is asleep.  Lots of hardware doesn't,
-however.  Shutting off the power to a USB controller is equivalent to
-unplugging all the attached devices.
+A: That's right ... if you disconnect that device, you may lose data.
+In fact, even with "-o sync" you can lose data if your programs have
+information in buffers they haven't written out to a disk you disconnect,
+or if you disconnect before the device finished saving data you wrote.
+
+Software suspend normally powers down USB controllers, which is equivalent
+to disconnecting all USB devices attached to your system.
+
+Your system might well support low-power modes for its USB controllers
+while the system is asleep, maintaining the connection, using true sleep
+modes like "suspend-to-RAM" or "standby".  (Don't write "disk" to the
+/sys/power/state file; write "standby" or "mem".)  We've not seen any
+hardware that can use these modes through software suspend, although in
+theory some systems might support "platform" or "firmware" modes that
+won't break the USB connections.
 
 Remember that it's always a bad idea to unplug a disk drive containing a
-mounted filesystem.  With USB that's true even when your system is asleep!
-The safest thing is to unmount all USB-based filesystems before suspending
-and remount them after resuming.
+mounted filesystem.  That's true even when your system is asleep!  The
+safest thing is to unmount all filesystems on removable media (such USB,
+Firewire, CompactFlash, MMC, external SATA, or even IDE hotplug bays)
+before suspending; then remount them after resuming.
 

--Boundary-00=_L9maEKX9eiSgnWT
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_L9maEKX9eiSgnWT--
