From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH] Hibernate: fix "swap breaks after hibernation
	failures"
Date: Sat, 24 Jan 2009 10:39:58 +0000
Message-ID: <497AEFFE.7020106@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12239

The image writing code dropped a reference to the current swap device.
This doesn't show up if the hibernation succeeds - because it doesn't
affect the image which gets resumed.  But it means multiple _failed_
hibernations end up freeing the swap device while it is still use!

swsusp_write() finds the block device for the swap file using swap_type_of().
It then uses blkdev_get() / blkdev_put() to open and close the block device.

Unfortunately, blkdev_get() assumes ownership of the inode of the block_device
passed to it.  So blkdev_put() calls iput() on the inode.  This is by design
and other callers expect this behaviour.  The fix is for swap_type_of() to take
a reference on the inode using bdget().

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

diff --git a/mm/swapfile.c b/mm/swapfile.c
index f48b831..7740478 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -635,7 +635,7 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
 
 		if (!bdev) {
 			if (bdev_p)
-				*bdev_p = sis->bdev;
+				*bdev_p = bdget(sis->bdev->bd_dev);
 
 			spin_unlock(&swap_lock);
 			return i;
@@ -647,7 +647,7 @@ int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
 					struct swap_extent, list);
 			if (se->start_block == offset) {
 				if (bdev_p)
-					*bdev_p = sis->bdev;
+					*bdev_p = bdget(sis->bdev->bd_dev);
 
 				spin_unlock(&swap_lock);
 				bdput(bdev);
