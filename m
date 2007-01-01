From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.20 regression: suspend to disk no more works
Date: Tue, 2 Jan 2007 00:28:18 +0100
Message-ID: <200701020028.19866.rjw@sisk.pl>
References: <200701012244.42781.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754599AbXAAX1G@vger.kernel.org>
In-Reply-To: <200701012244.42781.arvidjaar@mail.ru>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-pm@osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 1 January 2007 20:44, Andrey Borzenkov wrote:
> In *the same* configuration STD now fails with "Cannot find swap device". The
> reason is changes in kernel/power/swap.c. In 2.6.19 it did not require valid
> swsusp_resume_device at all - it took first available swap device and saved
> image. Later during resume swsusp_resume_device was set either by command
> line or sysfs and everything worked nicely.
> 
> Now swsusp_swap_check() unfortunately checks for swsusp_resume_device at
> *suspend* time:
> 
>         res = swap_type_of(swsusp_resume_device, swsusp_resume_block);
>         if (res < 0)
>                 return res;
> 
>         root_swap = res;
>         resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_WRITE);
>         if (IS_ERR(resume_bdev))
>                 return PTR_ERR(resume_bdev);
> 
> but in case of modular driver for swap device this is likely to be undefined.
> This is as of 2.6.20-rc3.

Actually, if you look at the 2.6.19 code, the call to swap_type_of() is there
in swsusp_swap_check() too.

The problem is with open_by_devnum(), I think, which obviously cannot succeed
if swsusp_resume_device is not set.  I think we should return resume_bdev from
swsusp_swap_check() like in the appended patch (untested).  Pavel?

> I already have seen these reports.

Yes, me too.

> While 'echo a:b > /sys/power/resume' before 
> suspend is a workaround, this still breaks perfectly valid setup that worked
> before. Also 'echo a:b > /sys/power/resume' is actually wrong - we are not
> going to resume at this point; but there is no way to just tell kernel "use
> this device for next STD" ... also the error message is misleading, it should
> complaint "no resume device found". Swap is there all right.

Thanks for the report.

Greetings,
Rafael


---
 include/linux/swap.h |    2 +-
 kernel/power/swap.c  |    9 +++++----
 kernel/power/user.c  |    7 ++++---
 mm/swapfile.c        |    8 +++++++-
 4 files changed, 17 insertions(+), 9 deletions(-)

Index: linux-2.6.20-rc3/include/linux/swap.h
===================================================================
--- linux-2.6.20-rc3.orig/include/linux/swap.h
+++ linux-2.6.20-rc3/include/linux/swap.h
@@ -245,7 +245,7 @@ extern int swap_duplicate(swp_entry_t);
 extern int valid_swaphandles(swp_entry_t, unsigned long *);
 extern void swap_free(swp_entry_t);
 extern void free_swap_and_cache(swp_entry_t);
-extern int swap_type_of(dev_t, sector_t);
+extern int swap_type_of(dev_t, sector_t, struct block_device **);
 extern unsigned int count_swap_pages(int, int);
 extern sector_t map_swap_page(struct swap_info_struct *, pgoff_t);
 extern sector_t swapdev_block(int, pgoff_t);
Index: linux-2.6.20-rc3/kernel/power/swap.c
===================================================================
--- linux-2.6.20-rc3.orig/kernel/power/swap.c
+++ linux-2.6.20-rc3/kernel/power/swap.c
@@ -165,14 +165,15 @@ static int swsusp_swap_check(void) /* Th
 {
 	int res;
 
-	res = swap_type_of(swsusp_resume_device, swsusp_resume_block);
+	res = swap_type_of(swsusp_resume_device, swsusp_resume_block,
+			&resume_bdev);
 	if (res < 0)
 		return res;
 
 	root_swap = res;
-	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_WRITE);
-	if (IS_ERR(resume_bdev))
-		return PTR_ERR(resume_bdev);
+	res = blkdev_get(resume_bdev, FMODE_WRITE, O_RDWR);
+	if (res)
+		return res;
 
 	res = set_blocksize(resume_bdev, PAGE_SIZE);
 	if (res < 0)
Index: linux-2.6.20-rc3/mm/swapfile.c
===================================================================
--- linux-2.6.20-rc3.orig/mm/swapfile.c
+++ linux-2.6.20-rc3/mm/swapfile.c
@@ -434,7 +434,7 @@ void free_swap_and_cache(swp_entry_t ent
  *
  * This is needed for the suspend to disk (aka swsusp).
  */
-int swap_type_of(dev_t device, sector_t offset)
+int swap_type_of(dev_t device, sector_t offset, struct block_device **bdev_p)
 {
 	struct block_device *bdev = NULL;
 	int i;
@@ -450,6 +450,9 @@ int swap_type_of(dev_t device, sector_t 
 			continue;
 
 		if (!bdev) {
+			if (bdev_p)
+				*bdev_p = sis->bdev;
+
 			spin_unlock(&swap_lock);
 			return i;
 		}
@@ -459,6 +462,9 @@ int swap_type_of(dev_t device, sector_t 
 			se = list_entry(sis->extent_list.next,
 					struct swap_extent, list);
 			if (se->start_block == offset) {
+				if (bdev_p)
+					*bdev_p = sis->bdev;
+
 				spin_unlock(&swap_lock);
 				bdput(bdev);
 				return i;
Index: linux-2.6.20-rc3/kernel/power/user.c
===================================================================
--- linux-2.6.20-rc3.orig/kernel/power/user.c
+++ linux-2.6.20-rc3/kernel/power/user.c
@@ -58,7 +58,7 @@ static int snapshot_open(struct inode *i
 	memset(&data->handle, 0, sizeof(struct snapshot_handle));
 	if ((filp->f_flags & O_ACCMODE) == O_RDONLY) {
 		data->swap = swsusp_resume_device ?
-				swap_type_of(swsusp_resume_device, 0) : -1;
+			swap_type_of(swsusp_resume_device, 0, NULL) : -1;
 		data->mode = O_RDONLY;
 	} else {
 		data->swap = -1;
@@ -327,7 +327,8 @@ static int snapshot_ioctl(struct inode *
 			 * so we need to recode them
 			 */
 			if (old_decode_dev(arg)) {
-				data->swap = swap_type_of(old_decode_dev(arg), 0);
+				data->swap = swap_type_of(old_decode_dev(arg),
+							0, NULL);
 				if (data->swap < 0)
 					error = -ENODEV;
 			} else {
@@ -427,7 +428,7 @@ static int snapshot_ioctl(struct inode *
 			swdev = old_decode_dev(swap_area.dev);
 			if (swdev) {
 				offset = swap_area.offset;
-				data->swap = swap_type_of(swdev, offset);
+				data->swap = swap_type_of(swdev, offset, NULL);
 				if (data->swap < 0)
 					error = -ENODEV;
 			} else {
