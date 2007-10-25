From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/5] Hibernation: Mark SNAPSHOT_SET_SWAP_FILE
	ioctl as deprecated (rev. 2)
Date: Fri, 26 Oct 2007 01:02:15 +0200
Message-ID: <200710260102.16469.rjw@sisk.pl>
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

Mark the SNAPSHOT_SET_SWAP_FILE ioctl belonging to the hibernation userland
interface as deprecated.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/power/userland-swsusp.txt |   14 ++------------
 kernel/power/power.h                    |    1 -
 kernel/power/user.c                     |    9 +++++----
 3 files changed, 7 insertions(+), 17 deletions(-)

Index: linux-2.6/kernel/power/power.h
===================================================================
--- linux-2.6.orig/kernel/power/power.h
+++ linux-2.6/kernel/power/power.h
@@ -156,7 +156,6 @@ struct resume_swap_area {
 #define SNAPSHOT_AVAIL_SWAP		_IOR(SNAPSHOT_IOC_MAGIC, 7, void *)
 #define SNAPSHOT_GET_SWAP_PAGE		_IOR(SNAPSHOT_IOC_MAGIC, 8, void *)
 #define SNAPSHOT_FREE_SWAP_PAGES	_IO(SNAPSHOT_IOC_MAGIC, 9)
-#define SNAPSHOT_SET_SWAP_FILE		_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
 #define SNAPSHOT_S2RAM			_IO(SNAPSHOT_IOC_MAGIC, 11)
 #define SNAPSHOT_SET_SWAP_AREA		_IOW(SNAPSHOT_IOC_MAGIC, 13, \
 							struct resume_swap_area)
Index: linux-2.6/kernel/power/user.c
===================================================================
--- linux-2.6.orig/kernel/power/user.c
+++ linux-2.6/kernel/power/user.c
@@ -29,10 +29,11 @@
 #include "power.h"
 
 /*
- * NOTE: The SNAPSHOT_PMOPS ioctl is obsolete and will be removed in the
- * future.  It is only preserved here for compatibility with existing userland
- * utilities.
+ * NOTE: The SNAPSHOT_SET_SWAP_FILE and SNAPSHOT_PMOPS ioctls are obsolete and
+ * will be removed in the future.  They are only preserved here for
+ * compatibility with existing userland utilities.
  */
+#define SNAPSHOT_SET_SWAP_FILE	_IOW(SNAPSHOT_IOC_MAGIC, 10, unsigned int)
 #define SNAPSHOT_PMOPS		_IOW(SNAPSHOT_IOC_MAGIC, 12, unsigned int)
 
 #define PMOPS_PREPARE	1
@@ -260,7 +261,7 @@ static int snapshot_ioctl(struct inode *
 		free_all_swap_pages(data->swap);
 		break;
 
-	case SNAPSHOT_SET_SWAP_FILE:
+	case SNAPSHOT_SET_SWAP_FILE: /* This ioctl is deprecated */
 		if (!swsusp_swap_in_use()) {
 			/*
 			 * User space encodes device types as two-byte values,
Index: linux-2.6/Documentation/power/userland-swsusp.txt
===================================================================
--- linux-2.6.orig/Documentation/power/userland-swsusp.txt
+++ linux-2.6/Documentation/power/userland-swsusp.txt
@@ -67,23 +67,13 @@ SNAPSHOT_GET_SWAP_PAGE - allocate a swap
 SNAPSHOT_FREE_SWAP_PAGES - free all swap pages allocated with
 	SNAPSHOT_GET_SWAP_PAGE
 
-SNAPSHOT_SET_SWAP_FILE - set the resume partition (the last ioctl() argument
-	should specify the device's major and minor numbers in the old
-	two-byte format, as returned by the stat() function in the .st_rdev
-	member of the stat structure)
-
 SNAPSHOT_SET_SWAP_AREA - set the resume partition and the offset (in <PAGE_SIZE>
 	units) from the beginning of the partition at which the swap header is
 	located (the last ioctl() argument should point to a struct
 	resume_swap_area, as defined in kernel/power/power.h, containing the
-	resume device specification, as for the SNAPSHOT_SET_SWAP_FILE ioctl(),
-	and the offset); for swap partitions the offset is always 0, but it is
-	different to zero for swap files (please see
+	resume device specification and the offset); for swap partitions the
+	offset is always 0, but it is different from zero for swap files (see
 	Documentation/swsusp-and-swap-files.txt for details).
-	The SNAPSHOT_SET_SWAP_AREA ioctl() is considered as a replacement for
-	SNAPSHOT_SET_SWAP_FILE which is regarded as obsolete.   It is
-	recommended to always use this call, because the code to set the resume
-	partition may be removed from future kernels
 
 SNAPSHOT_PLATFORM_SUPPORT - enable/disable the hibernation platform support,
 	depending on the argument value (enable, if the argument is nonzero)
