From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH -mm 3/5] Hibernation: Correct definitions of some
	ioctls
Date: Sun, 2 Sep 2007 23:21:03 +0200
Message-ID: <200709022321.04183.rjw@sisk.pl>
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

Three ioctl numbers belonging to the hibernation userland interface,
SNAPSHOT_ATOMIC_SNAPSHOT, SNAPSHOT_AVAIL_SWAP, SNAPSHOT_GET_SWAP_PAGE,
are defined in a wrong way (eg. not portable).  Provide new ioctl numbers for
these ioctls and mark the existing ones as deprecated.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 Documentation/power/userland-swsusp.txt |   24 ++++++++++++------------
 kernel/power/power.h                    |    8 ++++----
 kernel/power/user.c                     |   16 ++++++++++++++--
 3 files changed, 30 insertions(+), 18 deletions(-)

Index: linux-2.6.23-rc4-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.23-rc4-mm1.orig/kernel/power/power.h
+++ linux-2.6.23-rc4-mm1/kernel/power/power.h
@@ -149,12 +149,9 @@ struct resume_swap_area {
 #define SNAPSHOT_IOC_MAGIC	'3'
 #define SNAPSHOT_FREEZE			_IO(SNAPSHOT_IOC_MAGIC, 1)
 #define SNAPSHOT_UNFREEZE		_IO(SNAPSHOT_IOC_MAGIC, 2)
-#define SNAPSHOT_ATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
 #define SNAPSHOT_ATOMIC_RESTORE		_IO(SNAPSHOT_IOC_MAGIC, 4)
 #define SNAPSHOT_FREE			_IO(SNAPSHOT_IOC_MAGIC, 5)
 #define SNAPSHOT_SET_IMAGE_SIZE		_IOW(SNAPSHOT_IOC_MAGIC, 6, unsigned long)
-#define SNAPSHOT_AVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
-#define SNAPSHOT_GET_SWAP_PAGE		_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
 #define SNAPSHOT_FREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
 #define SNAPSHOT_SET_SWAP_FILE		_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
 #define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
@@ -163,7 +160,10 @@ struct resume_swap_area {
 #define SNAPSHOT_GET_IMAGE_SIZE		_IOR(SNAPSHOT_IOC_MAGIC, 14, loff_t)
 #define SNAPSHOT_PLATFORM_SUPPORT	_IOR(SNAPSHOT_IOC_MAGIC, 15, int)
 #define SNAPSHOT_POWER_OFF		_IO(SNAPSHOT_IOC_MAGIC, 16)
-#define SNAPSHOT_IOC_MAXNR	16
+#define SNAPSHOT_CREATE_IMAGE		_IOW(SNAPSHOT_IOC_MAGIC, 17, int)
+#define SNAPSHOT_AVAIL_SWAP_SIZE	_IOR(SNAPSHOT_IOC_MAGIC, 18, loff_t)
+#define SNAPSHOT_ALLOC_SWAP_PAGE	_IOR(SNAPSHOT_IOC_MAGIC, 19, loff_t)
+#define SNAPSHOT_IOC_MAXNR	19
 
 /* If unset, the snapshot device cannot be open. */
 extern atomic_t snapshot_device_available;
Index: linux-2.6.23-rc4-mm1/kernel/power/user.c
===================================================================
--- linux-2.6.23-rc4-mm1.orig/kernel/power/user.c
+++ linux-2.6.23-rc4-mm1/kernel/power/user.c
@@ -39,6 +39,15 @@
 #define PMOPS_ENTER	2
 #define PMOPS_FINISH	3
 
+/*
+ * NOTE: The following ioctl definitions are wrong and have been replaced with
+ * correct ones.  They are only preserved here for compatibility with existing
+ * userland utilities and will be removed in the future.
+ */
+#define SNAPSHOT_ATOMIC_SNAPSHOT	_IOW(SNAPSHOT_IOC_MAGIC, 3, void *)
+#define SNAPSHOT_AVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
+#define SNAPSHOT_GET_SWAP_PAGE		_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
+
 
 #define SNAPSHOT_MINOR	231
 
@@ -190,6 +199,7 @@ static int snapshot_ioctl(struct inode *
 		data->frozen = 0;
 		break;
 
+	case SNAPSHOT_CREATE_IMAGE:
 	case SNAPSHOT_ATOMIC_SNAPSHOT:
 		if (data->mode != O_RDONLY || !data->frozen  || data->ready) {
 			error = -EPERM;
@@ -197,7 +207,7 @@ static int snapshot_ioctl(struct inode *
 		}
 		error = hibernation_snapshot(data->platform_support);
 		if (!error)
-			error = put_user(in_suspend, (unsigned int __user *)arg);
+			error = put_user(in_suspend, (int __user *)arg);
 		if (!error)
 			data->ready = 1;
 		break;
@@ -232,12 +242,14 @@ static int snapshot_ioctl(struct inode *
 		error = put_user(size, (loff_t __user *)arg);
 		break;
 
+	case SNAPSHOT_AVAIL_SWAP_SIZE:
 	case SNAPSHOT_AVAIL_SWAP:
 		size = count_swap_pages(data->swap, 1);
 		size <<= PAGE_SHIFT;
 		error = put_user(size, (loff_t __user *)arg);
 		break;
 
+	case SNAPSHOT_ALLOC_SWAP_PAGE:
 	case SNAPSHOT_GET_SWAP_PAGE:
 		if (data->swap < 0 || data->swap >= MAX_SWAPFILES) {
 			error = -ENODEV;
@@ -246,7 +258,7 @@ static int snapshot_ioctl(struct inode *
 		offset = alloc_swapdev_block(data->swap);
 		if (offset) {
 			offset <<= PAGE_SHIFT;
-			error = put_user(offset, (sector_t __user *)arg);
+			error = put_user(offset, (loff_t __user *)arg);
 		} else {
 			error = -ENOSPC;
 		}
Index: linux-2.6.23-rc4-mm1/Documentation/power/userland-swsusp.txt
===================================================================
--- linux-2.6.23-rc4-mm1.orig/Documentation/power/userland-swsusp.txt
+++ linux-2.6.23-rc4-mm1/Documentation/power/userland-swsusp.txt
@@ -27,17 +27,17 @@ once at a time.
 The ioctl() commands recognized by the device are:
 
 SNAPSHOT_FREEZE - freeze user space processes (the current process is
-	not frozen); this is required for SNAPSHOT_ATOMIC_SNAPSHOT
+	not frozen); this is required for SNAPSHOT_CREATE_IMAGE
 	and SNAPSHOT_ATOMIC_RESTORE to succeed
 
 SNAPSHOT_UNFREEZE - thaw user space processes frozen by SNAPSHOT_FREEZE
 
-SNAPSHOT_ATOMIC_SNAPSHOT - create a snapshot of the system memory; the
+SNAPSHOT_CREATE_IMAGE - create a snapshot of the system memory; the
 	last argument of ioctl() should be a pointer to an int variable,
 	the value of which will indicate whether the call returned after
 	creating the snapshot (1) or after restoring the system memory state
 	from it (0) (after resume the system finds itself finishing the
-	SNAPSHOT_ATOMIC_SNAPSHOT ioctl() again); after the snapshot
+	SNAPSHOT_CREATE_IMAGE ioctl() again); after the snapshot
 	has been created the read() operation can be used to transfer
 	it out of the kernel
 
@@ -56,16 +56,16 @@ SNAPSHOT_SET_IMAGE_SIZE - set the prefer
 
 SNAPSHOT_GET_IMAGE_SIZE - return the actual size of the hibernation image
 
-SNAPSHOT_AVAIL_SWAP - return the amount of available swap in bytes (the last
-	argument should be a pointer to an unsigned int variable that will
+SNAPSHOT_AVAIL_SWAP_SIZE - return the amount of available swap in bytes (the
+	last argument should be a pointer to an unsigned int variable that will
 	contain the result if the call is successful).
 
-SNAPSHOT_GET_SWAP_PAGE - allocate a swap page from the resume partition
+SNAPSHOT_ALLOC_SWAP_PAGE - allocate a swap page from the resume partition
 	(the last argument should be a pointer to a loff_t variable that
 	will contain the swap page offset if the call is successful)
 
-SNAPSHOT_FREE_SWAP_PAGES - free all swap pages allocated with
-	SNAPSHOT_GET_SWAP_PAGE
+SNAPSHOT_FREE_SWAP_PAGES - free all swap pages allocated by
+	SNAPSHOT_ALLOC_SWAP_PAGE
 
 SNAPSHOT_SET_SWAP_FILE - set the resume partition (the last ioctl() argument
 	should specify the device's major and minor numbers in the old
@@ -112,7 +112,7 @@ The device's write() operation is used f
 into the kernel.  It has the same limitations as the read() operation.
 
 The release() operation frees all memory allocated for the snapshot image
-and all swap pages allocated with SNAPSHOT_GET_SWAP_PAGE (if any).
+and all swap pages allocated with SNAPSHOT_ALLOC_SWAP_PAGE (if any).
 Thus it is not necessary to use either SNAPSHOT_FREE or
 SNAPSHOT_FREE_SWAP_PAGES before closing the device (in fact it will also
 unfreeze user space processes frozen by SNAPSHOT_UNFREEZE if they are
@@ -123,7 +123,7 @@ snapshot image from/to the kernel will u
 partition, or a swap file as storage space (if a swap file is used, the resume
 partition is the partition that holds this file).  However, this is not really
 required, as they can use, for example, a special (blank) suspend partition or
-a file on a partition that is unmounted before SNAPSHOT_ATOMIC_SNAPSHOT and
+a file on a partition that is unmounted before SNAPSHOT_CREATE_IMAGE and
 mounted afterwards.
 
 These utilities MUST NOT make any assumptions regarding the ordering of
@@ -145,7 +145,7 @@ means, such as checksums, to ensure the 
 The suspending and resuming utilities MUST lock themselves in memory,
 preferrably using mlockall(), before calling SNAPSHOT_FREEZE.
 
-The suspending utility MUST check the value stored by SNAPSHOT_ATOMIC_SNAPSHOT
+The suspending utility MUST check the value stored by SNAPSHOT_CREATE_IMAGE
 in the memory location pointed to by the last argument of ioctl() and proceed
 in accordance with it:
 1. 	If the value is 1 (ie. the system memory snapshot has just been
@@ -159,7 +159,7 @@ in accordance with it:
 		image has been saved.
 	(b)	The suspending utility SHOULD NOT attempt to perform any
 		file system operations (including reads) on the file systems
-		that were mounted before SNAPSHOT_ATOMIC_SNAPSHOT has been
+		that were mounted before SNAPSHOT_CREATE_IMAGE has been
 		called.  However, it MAY mount a file system that was not
 		mounted at that time and perform some operations on it (eg.
 		use it for saving the image).
