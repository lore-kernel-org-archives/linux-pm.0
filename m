From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH] swsusp: warn about USB devices in
	documentation
Date: Sun, 19 Feb 2006 23:06:23 +0100
Message-ID: <200602192306.25170.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============16213220188883426=="
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

--===============16213220188883426==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

The appended patch contains a warning about the possiblity to lose data
if any filesystems on USB devices are mounted before suspend.

The A:-Q: part is from my correspondence with Alan Stern (thanks Alan).

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/swsusp.txt |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+)

Index: linux-2.6.16-rc3-mm1/Documentation/power/swsusp.txt
===================================================================
--- linux-2.6.16-rc3-mm1.orig/Documentation/power/swsusp.txt
+++ linux-2.6.16-rc3-mm1/Documentation/power/swsusp.txt
@@ -17,6 +17,11 @@ Some warnings, first.
  * but it will probably only crash.
  *
  * (*) suspend/resume support is needed to make it safe.
+ *
+ * If you have any filesystems on USB devices mounted before suspend,
+ * they won't be mounted after resume and you may lose data, as though
+ * you have unplugged the USB devices with mounted filesystems on them
+ * (see the FAQ below for details).
 
 You need to append resume=/dev/your_swap_partition to kernel command
 line. Then you suspend by
@@ -347,3 +352,22 @@ terminal the kernel switches to during s
 kernel console loglevel to at least 5, for example by doing
 
 	echo 5 > /proc/sys/kernel/printk
+
+Q: Is this true that if I have a mounted filesystem on a USB device and
+I suspend to disk, I can lose data unless the filesystem has been mounted
+with "sync"?
+
+A: That's right.  It depends on your hardware, and it could be true even for
+suspend-to-RAM. In fact, even with "-o sync" you can lose data if your
+programs have information in buffers they haven't written out to disk.
+
+If you're lucky, your hardware will support low-power modes for USB
+controllers while the system is asleep.  Lots of hardware doesn't,
+however.  Shutting off the power to a USB controller is equivalent to 
+unplugging all the attached devices.
+
+Remember that it's always a bad idea to unplug a disk drive containing a
+mounted filesystem.  With USB that's true even when your system is asleep!
+The safest thing is to unmount all USB-based filesystems before suspending 
+and remount them after resuming.
+

--===============16213220188883426==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============16213220188883426==--
