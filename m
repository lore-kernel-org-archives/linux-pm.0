From: Joe Perches <joe@perches.com>
Subject: [PATCH 4/6] power: swap: Standardize "Image <loading/saving>" messages
Date: Thu,  4 Jun 2015 11:36:47 -0700
Message-ID: <21562844eb3bcbce4b7619098a69d0c342b879a3.1433442778.git.joe@perches.com>
References: <cover.1433442778.git.joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1433442778.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Standardize "Image <...>" messages

Always emit the "Image <loading/saving>" messages on 2 separate lines so
that these messages can't be interleaved.

Signed-off-by: Joe Perches <joe@perches.com>
---
 kernel/power/swap.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 2f30ca9..7aa2635 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -552,7 +552,7 @@ static int save_image(struct swap_map_handle *handle,
 	if (!ret)
 		ret = err2;
 	if (!ret)
-		printk(KERN_INFO "PM: Image saving done.\n");
+		printk(KERN_INFO "PM: Image saving: done\n");
 	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
 	return ret;
 }
@@ -843,7 +843,7 @@ out_finish:
 	if (!ret)
 		ret = err2;
 	if (!ret)
-		printk(KERN_INFO "PM: Image saving done.\n");
+		printk(KERN_INFO "PM: Image saving: done\n");
 	swsusp_show_speed(start, stop, nr_to_write, "Wrote");
 out_clean:
 	if (crc) {
@@ -1081,7 +1081,7 @@ static int load_image(struct swap_map_handle *handle,
 	if (!ret)
 		ret = err2;
 	if (!ret) {
-		printk(KERN_INFO "PM: Image loading done.\n");
+		printk(KERN_INFO "PM: Image loading: done\n");
 		snapshot_write_finalize(snapshot);
 		if (!snapshot_image_loaded(snapshot))
 			ret = -ENODATA;
-- 
2.1.2
