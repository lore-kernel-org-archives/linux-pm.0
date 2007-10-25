From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/5] Hibernation: Introduce
	SNAPSHOT_GET_IMAGE_SIZE ioctl
Date: Fri, 26 Oct 2007 00:59:31 +0200
Message-ID: <200710260059.32326.rjw@sisk.pl>
References: <200710260055.02298.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710260055.02298.rjw@sisk.pl>
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
To: Len Brown <lenb@kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Add a new ioctl, SNAPSHOT_GET_IMAGE_SIZE, returning the size of the (just
created) hibernation image, to the hibernation userland interface.

This ioctl is necessary so that the userland utilities using the interface need
not access the hibernation image header, owned by the kernel, in order to obtain
the size of the image.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/power/userland-swsusp.txt |   12 +++++-------
 kernel/power/power.h                    |    4 +++-
 kernel/power/snapshot.c                 |    7 ++++++-
 kernel/power/user.c                     |   18 ++++++++++++++----
 4 files changed, 28 insertions(+), 13 deletions(-)

Index: linux-2.6/kernel/power/power.h
===================================================================
--- linux-2.6.orig/kernel/power/power.h
+++ linux-2.6/kernel/power/power.h
@@ -130,6 +130,7 @@ struct snapshot_handle {
 #define data_of(handle)	((handle).buffer + (handle).buf_offset)
 
 extern unsigned int snapshot_additional_pages(struct zone *zone);
+extern unsigned long snapshot_get_image_size(void);
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
 extern void snapshot_write_finalize(struct snapshot_handle *handle);
@@ -160,7 +161,8 @@ struct resume_swap_area {
 #define SNAPSHOT_PMOPS			_IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
 #define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, \
 							struct resume_swap_area)
-#define SNAPSHOT_IOC_MAXNR	13
+#define SNAPSHOT_GET_IMAGE_SIZE		_IOR(SNAPSHOT_IOC_MAGIC, 14, loff_t)
+#define SNAPSHOT_IOC_MAXNR	14
 
 #define PMOPS_PREPARE	1
 #define PMOPS_ENTER	2
Index: linux-2.6/kernel/power/user.c
===================================================================
--- linux-2.6.orig/kernel/power/user.c
+++ linux-2.6/kernel/power/user.c
@@ -133,7 +133,7 @@ static int snapshot_ioctl(struct inode *
 {
 	int error = 0;
 	struct snapshot_data *data;
-	loff_t avail;
+	loff_t size;
 	sector_t offset;
 
 	if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC)
@@ -210,10 +210,20 @@ static int snapshot_ioctl(struct inode *
 		image_size = arg;
 		break;
 
+	case SNAPSHOT_GET_IMAGE_SIZE:
+		if (!data->ready) {
+			error = -ENODATA;
+			break;
+		}
+		size = snapshot_get_image_size();
+		size <<= PAGE_SHIFT;
+		error = put_user(size, (loff_t __user *)arg);
+		break;
+
 	case SNAPSHOT_AVAIL_SWAP:
-		avail = count_swap_pages(data->swap, 1);
-		avail <<= PAGE_SHIFT;
-		error = put_user(avail, (loff_t __user *)arg);
+		size = count_swap_pages(data->swap, 1);
+		size <<= PAGE_SHIFT;
+		error = put_user(size, (loff_t __user *)arg);
 		break;
 
 	case SNAPSHOT_GET_SWAP_PAGE:
Index: linux-2.6/kernel/power/snapshot.c
===================================================================
--- linux-2.6.orig/kernel/power/snapshot.c
+++ linux-2.6/kernel/power/snapshot.c
@@ -1264,12 +1264,17 @@ static char *check_image_kernel(struct s
 }
 #endif /* CONFIG_ARCH_HIBERNATION_HEADER */
 
+unsigned long snapshot_get_image_size(void)
+{
+	return nr_copy_pages + nr_meta_pages + 1;
+}
+
 static int init_header(struct swsusp_info *info)
 {
 	memset(info, 0, sizeof(struct swsusp_info));
 	info->num_physpages = num_physpages;
 	info->image_pages = nr_copy_pages;
-	info->pages = nr_copy_pages + nr_meta_pages + 1;
+	info->pages = snapshot_get_image_size();
 	info->size = info->pages;
 	info->size <<= PAGE_SHIFT;
 	return init_header_complete(info);
Index: linux-2.6/Documentation/power/userland-swsusp.txt
===================================================================
--- linux-2.6.orig/Documentation/power/userland-swsusp.txt
+++ linux-2.6/Documentation/power/userland-swsusp.txt
@@ -54,6 +54,8 @@ SNAPSHOT_SET_IMAGE_SIZE - set the prefer
 	this number, but if it turns out to be impossible, the kernel will
 	create the smallest image possible)
 
+SNAPSHOT_GET_IMAGE_SIZE - return the actual size of the hibernation image
+
 SNAPSHOT_AVAIL_SWAP - return the amount of available swap in bytes (the last
 	argument should be a pointer to an unsigned int variable that will
 	contain the result if the call is successful).
@@ -136,13 +138,9 @@ required, as they can use, for example, 
 a file on a partition that is unmounted before SNAPSHOT_ATOMIC_SNAPSHOT and
 mounted afterwards.
 
-These utilities SHOULD NOT make any assumptions regarding the ordering of
-data within the snapshot image, except for the image header that MAY be
-assumed to start with an swsusp_info structure, as specified in
-kernel/power/power.h.  This structure MAY be used by the userland utilities
-to obtain some information about the snapshot image, such as the size
-of the snapshot image, including the metadata and the header itself,
-contained in the .size member of swsusp_info.
+These utilities MUST NOT make any assumptions regarding the ordering of
+data within the snapshot image.  The contents of the image are entirely owned
+by the kernel and its structure may be changed in future kernel releases.
 
 The snapshot image MUST be written to the kernel unaltered (ie. all of the image
 data, metadata and header MUST be written in _exactly_ the same amount, form
