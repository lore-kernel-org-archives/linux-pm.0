From: Nigel Cunningham <nigel@tuxonice.net>
Subject: [PATCH 01/22] Record & display i/o speed post resume.
Date: Sat, 25 Sep 2010 14:16:43 +1000
Message-ID: <1285388224-10012-2-git-send-email-nigel__40480.9568579823$1285388432$gmane$org@tuxonice.net>
References: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1285388224-10012-1-git-send-email-nigel@tuxonice.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org

Record the speed at which the image is written and read, and
display it to the user post-resume.

Signed-off-by: Nigel Cunningham <nigel@tuxonice.net>
---
 kernel/power/hibernate.c |   11 ++++++++++-
 kernel/power/power.h     |    4 +++-
 kernel/power/swap.c      |   14 +++++++++++---
 3 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 8dc31e0..8cd0bbc 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -211,7 +211,7 @@ static void platform_recover(int platform_mode)
  *	@msg -		introductory message to print
  */
 
-void swsusp_show_speed(struct timeval *start, struct timeval *stop,
+int swsusp_show_speed(struct timeval *start, struct timeval *stop,
 			unsigned nr_pages, char *msg)
 {
 	s64 elapsed_centisecs64;
@@ -230,6 +230,7 @@ void swsusp_show_speed(struct timeval *start, struct timeval *stop,
 			msg, k,
 			centisecs / 100, centisecs % 100,
 			kps / 1000, (kps % 1000) / 10);
+	return kps / 1000;
 }
 
 /**
@@ -645,6 +646,14 @@ int hibernate(void)
 			power_down();
 	} else {
 		pr_debug("PM: Image restored successfully.\n");
+		if (write_speed)
+			pr_debug("PM: Image written at %u MB/s.\n",
+					(u8) write_speed);
+		write_speed = 0;
+		if (read_speed)
+			pr_debug("PM: Image read at %u MB/s.\n",
+					(u8) read_speed);
+		read_speed = 0;
 	}
 
  Thaw:
diff --git a/kernel/power/power.h b/kernel/power/power.h
index 006270f..67b6896 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -49,6 +49,8 @@ static inline char *check_image_kernel(struct swsusp_info *info)
 extern int hibernation_snapshot(int platform_mode);
 extern int hibernation_restore(int platform_mode);
 extern int hibernation_platform_enter(void);
+
+extern char __nosavedata write_speed, read_speed;
 #endif
 
 extern int pfn_is_nosave(unsigned long);
@@ -153,7 +155,7 @@ extern int hib_wait_on_bio_chain(struct bio **bio_chain);
 
 struct timeval;
 /* kernel/power/swsusp.c */
-extern void swsusp_show_speed(struct timeval *, struct timeval *,
+extern int swsusp_show_speed(struct timeval *, struct timeval *,
 				unsigned int, char *);
 
 #ifdef CONFIG_SUSPEND
diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index e6a5bdf..728f85b 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -64,7 +64,8 @@ struct swap_map_handle {
 };
 
 struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - sizeof(sector_t) - sizeof(int)];
+	char reserved[PAGE_SIZE - 21 - sizeof(sector_t) - sizeof(int)];
+	char write_speed;
 	sector_t image;
 	unsigned int flags;	/* Flags to pass to the "boot" kernel */
 	char	orig_sig[10];
@@ -180,6 +181,7 @@ int swsusp_swap_in_use(void)
 
 static unsigned short root_swap = 0xffff;
 struct block_device *hib_resume_bdev;
+char __nosavedata write_speed, read_speed;
 
 /*
  * Saving part
@@ -194,6 +196,7 @@ static int mark_swapfiles(struct swap_map_handle *handle, unsigned int flags)
 	    !memcmp("SWAPSPACE2",swsusp_header->sig, 10)) {
 		memcpy(swsusp_header->orig_sig,swsusp_header->sig, 10);
 		memcpy(swsusp_header->sig,SWSUSP_SIG, 10);
+		swsusp_header->write_speed = write_speed;
 		swsusp_header->image = handle->first_sector;
 		swsusp_header->flags = flags;
 		error = hib_bio_write_page(swsusp_resume_block,
@@ -372,6 +375,7 @@ static int save_image(struct swap_map_handle *handle,
 	struct bio *bio;
 	struct timeval start;
 	struct timeval stop;
+	int mps;
 
 	printk(KERN_INFO "PM: Saving image data pages (%u pages) ...     ",
 		nr_to_write);
@@ -400,7 +404,8 @@ static int save_image(struct swap_map_handle *handle,
 		printk(KERN_CONT "\b\b\b\bdone\n");
 	else
 		printk(KERN_CONT "\n");
-	swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
+	mps = swsusp_show_speed(&start, &stop, nr_to_write, "Wrote");
+	write_speed = (mps < 256) ? (char) mps : 0;
 	return ret;
 }
 
@@ -550,6 +555,7 @@ static int load_image(struct swap_map_handle *handle,
 	struct bio *bio;
 	int err2;
 	unsigned nr_pages;
+	int mps;
 
 	printk(KERN_INFO "PM: Loading image data pages (%u pages) ...     ",
 		nr_to_read);
@@ -585,7 +591,8 @@ static int load_image(struct swap_map_handle *handle,
 			error = -ENODATA;
 	} else
 		printk("\n");
-	swsusp_show_speed(&start, &stop, nr_to_read, "Read");
+	mps = swsusp_show_speed(&start, &stop, nr_to_read, "Read");
+	read_speed = (mps < 256) ? mps : 0;
 	return error;
 }
 
@@ -641,6 +648,7 @@ int swsusp_check(void)
 			goto put;
 
 		if (!memcmp(SWSUSP_SIG, swsusp_header->sig, 10)) {
+			write_speed = swsusp_header->write_speed;
 			memcpy(swsusp_header->sig, swsusp_header->orig_sig, 10);
 			/* Reset swap signature now */
 			error = hib_bio_write_page(swsusp_resume_block,
-- 
1.7.0.4
