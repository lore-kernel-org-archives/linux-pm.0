From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 5/5] Hibernation: Introduce exportable
	suspend ioctls header
Date: Sun, 2 Sep 2007 23:28:20 +0200
Message-ID: <200709022328.20720.rjw@sisk.pl>
References: <200709022315.59652.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200709022315.59652.rjw@sisk.pl>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Move the definitions of hibernation ioctls to a separate header file in
include/linux, which can be exported to the user space.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/userland-swsusp.txt |   11 ++++------
 include/linux/suspend_ioctls.h          |   33 ++++++++++++++++++++++++++++++++
 kernel/power/power.h                    |   29 ----------------------------
 3 files changed, 39 insertions(+), 34 deletions(-)

Index: linux-2.6.23-rc4-mm1/include/linux/suspend_ioctls.h
===================================================================
--- /dev/null
+++ linux-2.6.23-rc4-mm1/include/linux/suspend_ioctls.h
@@ -0,0 +1,33 @@
+#ifndef _LINUX_SUSPEND_IOCTLS_H
+#define _LINUX_SUSPEND_IOCTLS_H
+
+/*
+ * This structure is used to pass the values needed for the identification
+ * of the resume swap area from a user space to the kernel via the
+ * SNAPSHOT_SET_SWAP_AREA ioctl
+ */
+struct resume_swap_area {
+	loff_t offset;
+	u_int32_t dev;
+} __attribute__((packed));
+
+#define SNAPSHOT_IOC_MAGIC	'3'
+#define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
+#define SNAPSHOT_UNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
+#define SNAPSHOT_ATOMIC_RESTORE		_IO(SNAPSHOT_IOC_MAGIC, 4)
+#define SNAPSHOT_FREE			_IO(SNAPSHOT_IOC_MAGIC, 5)
+#define SNAPSHOT_SET_IMAGE_SIZE		_IOW(SNAPSHOT_IOC_MAGIC, 6, \
+							unsigned long)
+#define SNAPSHOT_FREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
+#define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
+#define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, \
+							struct resume_swap_area)
+#define SNAPSHOT_GET_IMAGE_SIZE		_IOR(SNAPSHOT_IOC_MAGIC, 14, loff_t)
+#define SNAPSHOT_PLATFORM_SUPPORT	_IOR(SNAPSHOT_IOC_MAGIC, 15, int)
+#define SNAPSHOT_POWER_OFF		_IO(SNAPSHOT_IOC_MAGIC, 16)
+#define SNAPSHOT_CREATE_IMAGE		_IOW(SNAPSHOT_IOC_MAGIC, 17, int)
+#define SNAPSHOT_AVAIL_SWAP_SIZE	_IOR(SNAPSHOT_IOC_MAGIC, 18, loff_t)
+#define SNAPSHOT_ALLOC_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 19, loff_t)
+#define SNAPSHOT_IOC_MAXNR	19
+
+#endif /* _LINUX_SUSPEND_IOCTLS_H */
Index: linux-2.6.23-rc4-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.23-rc4-mm1.orig/kernel/power/power.h
+++ linux-2.6.23-rc4-mm1/kernel/power/power.h
@@ -1,4 +1,5 @@
 #include <linux/suspend.h>
+#include <linux/suspend_ioctls.h>
 #include <linux/utsname.h>
 
 struct swsusp_info {
@@ -136,34 +137,6 @@ extern int snapshot_write_next(struct sn
 extern void snapshot_write_finalize(struct snapshot_handle *handle);
 extern int snapshot_image_loaded(struct snapshot_handle *handle);
 
-/*
- * This structure is used to pass the values needed for the identification
- * of the resume swap area from a user space to the kernel via the
- * SNAPSHOT_SET_SWAP_AREA ioctl
- */
-struct resume_swap_area {
-	loff_t offset;
-	u_int32_t dev;
-} __attribute__((packed));
-
-#define SNAPSHOT_IOC_MAGIC	'3'
-#define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
-#define SNAPSHOT_UNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
-#define SNAPSHOT_ATOMIC_RESTORE		_IO(SNAPSHOT_IOC_MAGIC, 4)
-#define SNAPSHOT_FREE			_IO(SNAPSHOT_IOC_MAGIC, 5)
-#define SNAPSHOT_SET_IMAGE_SIZE		_IOW(SNAPSHOT_IOC_MAGIC, 6, unsigned long)
-#define SNAPSHOT_FREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
-#define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
-#define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, \
-							struct resume_swap_area)
-#define SNAPSHOT_GET_IMAGE_SIZE		_IOR(SNAPSHOT_IOC_MAGIC, 14, loff_t)
-#define SNAPSHOT_PLATFORM_SUPPORT	_IOR(SNAPSHOT_IOC_MAGIC, 15, int)
-#define SNAPSHOT_POWER_OFF		_IO(SNAPSHOT_IOC_MAGIC, 16)
-#define SNAPSHOT_CREATE_IMAGE		_IOW(SNAPSHOT_IOC_MAGIC, 17, int)
-#define SNAPSHOT_AVAIL_SWAP_SIZE	_IOR(SNAPSHOT_IOC_MAGIC, 18, loff_t)
-#define SNAPSHOT_ALLOC_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 19, loff_t)
-#define SNAPSHOT_IOC_MAXNR	19
-
 /* If unset, the snapshot device cannot be open. */
 extern atomic_t snapshot_device_available;
 
Index: linux-2.6.23-rc4-mm1/Documentation/power/userland-swsusp.txt
===================================================================
--- linux-2.6.23-rc4-mm1.orig/Documentation/power/userland-swsusp.txt
+++ linux-2.6.23-rc4-mm1/Documentation/power/userland-swsusp.txt
@@ -14,7 +14,7 @@ are going to develop your own suspend/re
 
 The interface consists of a character device providing the open(),
 release(), read(), and write() operations as well as several ioctl()
-commands defined in kernel/power/power.h.  The major and minor
+commands defined in include/linux/suspend_ioctls.h .  The major and minor
 numbers of the device are, respectively, 10 and 231, and they can
 be read from /sys/class/misc/snapshot/dev.
 
@@ -70,11 +70,10 @@ SNAPSHOT_FREE_SWAP_PAGES - free all swap
 SNAPSHOT_SET_SWAP_AREA - set the resume partition and the offset (in <PAGE_SIZE>
 	units) from the beginning of the partition at which the swap header is
 	located (the last ioctl() argument should point to a struct
-	resume_swap_area, as defined in kernel/power/power.h, containing the
-	resume device specification, as for the SNAPSHOT_SET_SWAP_FILE ioctl(),
-	and the offset); for swap partitions the offset is always 0, but it is
-	different to zero for swap files (please see
-	Documentation/swsusp-and-swap-files.txt for details).
+	resume_swap_area, as defined in include/linux/suspend_ioctls.h,
+	containing the resume device specification and the offset); for swap
+	partitions the offset is always 0, but it is different to zero for swap
+	files (please see Documentation/swsusp-and-swap-files.txt for details).
 
 SNAPSHOT_PLATFORM_SUPPORT - enable/disable the hibernation platform support,
 	depending on the argument value (enable, if the argument is nonzero)
