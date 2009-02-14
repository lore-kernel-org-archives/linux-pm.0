From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/9] PM/hibernate: fix "swap breaks after
	hibernation failures"
Date: Sat, 14 Feb 2009 02:01:14 +0100
Message-ID: <200902140201.16221.rjw@sisk.pl>
References: <200902140157.40869.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902140157.40869.rjw@sisk.pl>
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
Cc: Arjan van de Ven <arjan@linux.intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, Andrey Borzenkov <arvidjaar@mail.ru>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Masami Hiramatsu <mhiramat@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

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
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

---
 mm/swapfile.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/mm/swapfile.c
===================================================================
--- linux-2.6.orig/mm/swapfile.c
+++ linux-2.6/mm/swapfile.c
@@ -635,7 +635,7 @@ int swap_type_of(dev_t device, sector_t 
 
 		if (!bdev) {
 			if (bdev_p)
-				*bdev_p = sis->bdev;
+				*bdev_p = bdget(sis->bdev->bd_dev);
 
 			spin_unlock(&swap_lock);
 			return i;
@@ -647,7 +647,7 @@ int swap_type_of(dev_t device, sector_t 
 					struct swap_extent, list);
 			if (se->start_block == offset) {
 				if (bdev_p)
-					*bdev_p = sis->bdev;
+					*bdev_p = bdget(sis->bdev->bd_dev);
 
 				spin_unlock(&swap_lock);
 				bdput(bdev);
