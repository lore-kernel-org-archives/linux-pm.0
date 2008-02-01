From: Len Brown <lenb@kernel.org>
Subject: [PATCH 01/37] Hibernation: Introduce
	SNAPSHOT_GET_IMAGE_SIZE ioctl
Date: Thu, 31 Jan 2008 23:36:32 -0500
Message-ID: <edae89f5d1eb1fbe1cab74333db5a8e29776900e.1201840183.git.len.brown__23770.843682769$1201841080$gmane$org@intel.com>
References: <1201840628-23136-1-git-send-email-lenb@kernel.org>
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1201840628-23136-1-git-send-email-lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Add a new ioctl, SNAPSHOT_GET_IMAGE_SIZE, returning the size of the (just
created) hibernation image, to the hibernation userland interface.

This ioctl is necessary so that the userland utilities using the interface need
not access the hibernation image header, owned by the kernel, in order to obtain
the size of the image.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/power/userland-swsusp.txt |   12 +++++-------
 kernel/power/power.h                    |    4 +++-
 kernel/power/snapshot.c                 |    7 ++++++-
 kernel/power/user.c                     |   18 ++++++++++++++----
 4 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/Documentation/power/userland-swsusp.txt b/Documentation/power/userland-swsusp.txt
index e00c6cf..32f1874 100644
--- a/Documentation/power/userland-swsusp.txt
+++ b/Documentation/power/userland-swsusp.txt
@@ -54,6 +54,8 @@ SNAPSHOT_SET_IMAGE_SIZE - set the preferred maximum size of the image
 	this number, but if it turns out to be impossible, the kernel will
 	create the smallest image possible)
 
+SNAPSHOT_GET_IMAGE_SIZE - return the actual size of the hibernation image
+
 SNAPSHOT_AVAIL_SWAP - return the amount of available swap in bytes (the last
 	argument should be a pointer to an unsigned int variable that will
 	contain the result if the call is successful).
@@ -136,13 +138,9 @@ required, as they can use, for example, a special (blank) suspend partition or
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
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 2093c3a..23c1703 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -128,6 +128,7 @@ struct snapshot_handle {
 #define data_of(handle)	((handle).buffer + (handle).buf_offset)
 
 extern unsigned int snapshot_additional_pages(struct zone *zone);
+extern unsigned long snapshot_get_image_size(void);
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
 extern void snapshot_write_finalize(struct snapshot_handle *handle);
@@ -158,7 +159,8 @@ struct resume_swap_area {
 #define SNAPSHOT_PMOPS			_IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
 #define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, \
 							struct resume_swap_area)
-#define SNAPSHOT_IOC_MAXNR	13
+#define SNAPSHOT_GET_IMAGE_SIZE		_IOR(SNAPSHOT_IOC_MAGIC, 14, loff_t)
+#define SNAPSHOT_IOC_MAXNR	14
 
 #define PMOPS_PREPARE	1
 #define PMOPS_ENTER	2
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 78039b4..c5ce0f3 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1264,12 +1264,17 @@ static char *check_image_kernel(struct swsusp_info *info)
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
diff --git a/kernel/power/user.c b/kernel/power/user.c
index 5bd321b..88aac26 100644
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -133,7 +133,7 @@ static int snapshot_ioctl(struct inode *inode, struct file *filp,
 {
 	int error = 0;
 	struct snapshot_data *data;
-	loff_t avail;
+	loff_t size;
 	sector_t offset;
 
 	if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC)
@@ -210,10 +210,20 @@ static int snapshot_ioctl(struct inode *inode, struct file *filp,
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
-- 
1.5.4.rc5.16.gc0279
