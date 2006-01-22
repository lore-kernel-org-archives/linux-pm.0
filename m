From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH -mm] swsusp: specify available swap in bytes
Date: Sun, 22 Jan 2006 12:11:20 +0100
Message-ID: <200601221211.20937.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94201652585227214=="
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
To: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============94201652585227214==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

If the SNAPSHOT_AVAIL_SWAP ioctl returns the number of bytes, it will allow us
to use the number as an input for the SNAPSHOT_SET_IMAGE_SIZE ioctl directly.

OTOH, to make SNAPSHOT_AVAIL_SWAP return the number of bytes we need to
add the size of the image in bytes to the image header, but this really costs us
nothing, because the header is page-aligned anyway.

The appended patch contains all the necessary changes.

Opinions welcome. :-)

Greetings,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 Documentation/power/userland-swsusp.txt |   16 ++++++----------
 kernel/power/power.h                    |    1 +
 kernel/power/snapshot.c                 |    2 ++
 kernel/power/user.c                     |    8 ++++----
 4 files changed, 13 insertions(+), 14 deletions(-)

Index: linux-2.6.16-rc1-mm2/Documentation/power/userland-swsusp.txt
===================================================================
--- linux-2.6.16-rc1-mm2.orig/Documentation/power/userland-swsusp.txt	2006-01-21 23:26:37.000000000 +0100
+++ linux-2.6.16-rc1-mm2/Documentation/power/userland-swsusp.txt	2006-01-21 23:26:59.000000000 +0100
@@ -55,13 +55,9 @@ SNAPSHOT_SET_IMAGE_SIZE - set the prefer
 	this number, but if it turns out to be impossible, the kernel will
 	create the smallest image possible)
 
-SNAPSHOT_AVAIL_SWAP - check the amount of available swap (the last argument
-	should be a pointer to an unsigned int variable that will contain
-	the result if the call is successful).  The result is the number
-	of available swap pages, so it is architecture-dependent.  It is
-	only to be compared with the number of the snapshot image pages
-	read from the image header (see below).  It SHOULD NOT be used for
-	any other purpose.
+SNAPSHOT_AVAIL_SWAP - check the amount of available swap in bytes (the last
+	argument should be a pointer to an unsigned int variable that will
+	contain the result if the call is successful).
 
 SNAPSHOT_GET_SWAP_PAGE - allocate a swap page from the resume partition
 	(the last argument should be a pointer to a loff_t variable that
@@ -104,9 +100,9 @@ These utilities SHOULD NOT make any assu
 data within the snapshot image, except for the image header that MAY be
 assumed to start with an swsusp_info structure, as specified in
 kernel/power/power.h.  This structure MAY be used by the userland utilities
-to obtain some information about the snapshot image, such as the total
-number of the image pages, including the metadata and the header itself,
-contained in the .pages member of swsusp_info.
+to obtain some information about the snapshot image, such as the size
+of the snapshot image, including the metadata and the header itself,
+contained in the .size member of swsusp_info.
 
 The snapshot image MUST be written to the kernel unaltered (ie. all of the image
 data, metadata and header MUST be written in _exactly_ the same amount, form
Index: linux-2.6.16-rc1-mm2/kernel/power/power.h
===================================================================
--- linux-2.6.16-rc1-mm2.orig/kernel/power/power.h	2006-01-21 23:26:37.000000000 +0100
+++ linux-2.6.16-rc1-mm2/kernel/power/power.h	2006-01-21 23:26:59.000000000 +0100
@@ -16,6 +16,7 @@ struct swsusp_info {
 	int			cpus;
 	unsigned long		image_pages;
 	unsigned long		pages;
+	unsigned long		size;
 } __attribute__((aligned(PAGE_SIZE)));
 
 
Index: linux-2.6.16-rc1-mm2/kernel/power/snapshot.c
===================================================================
--- linux-2.6.16-rc1-mm2.orig/kernel/power/snapshot.c	2006-01-21 23:26:37.000000000 +0100
+++ linux-2.6.16-rc1-mm2/kernel/power/snapshot.c	2006-01-22 12:08:01.000000000 +0100
@@ -525,6 +525,8 @@ static void init_header(struct swsusp_in
 	info->cpus = num_online_cpus();
 	info->image_pages = nr_copy_pages;
 	info->pages = nr_copy_pages + nr_meta_pages + 1;
+	info->size = info->pages;
+	info->size <<= PAGE_SHIFT;
 }
 
 /**
Index: linux-2.6.16-rc1-mm2/kernel/power/user.c
===================================================================
--- linux-2.6.16-rc1-mm2.orig/kernel/power/user.c	2006-01-21 23:26:37.000000000 +0100
+++ linux-2.6.16-rc1-mm2/kernel/power/user.c	2006-01-21 23:42:32.000000000 +0100
@@ -123,8 +123,7 @@ static int snapshot_ioctl(struct inode *
 {
 	int error = 0;
 	struct snapshot_data *data;
-	loff_t offset;
-	unsigned int n;
+	loff_t offset, avail;
 
 	if (_IOC_TYPE(cmd) != SNAPSHOT_IOC_MAGIC)
 		return -ENOTTY;
@@ -214,8 +213,9 @@ static int snapshot_ioctl(struct inode *
 		break;
 
 	case SNAPSHOT_AVAIL_SWAP:
-		n = count_swap_pages(data->swap, 1);
-		error = put_user(n, (unsigned int __user *)arg);
+		avail = count_swap_pages(data->swap, 1);
+		avail <<= PAGE_SHIFT;
+		error = put_user(avail, (loff_t __user *)arg);
 		break;
 
 	case SNAPSHOT_GET_SWAP_PAGE:

--===============94201652585227214==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94201652585227214==--
