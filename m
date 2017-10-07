From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] kernel/power/swap: Delete five error messages for a failed
 memory allocation
Date: Sat, 7 Oct 2017 15:07:37 +0200
Message-ID: <b8a259fa-92ee-e50f-9f64-834ee35ac434@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:63297 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751119AbdJGNHv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Oct 2017 09:07:51 -0400
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 7 Oct 2017 14:54:06 +0200

Omit extra messages for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 kernel/power/swap.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index d7cdc426ee38..ba82113c05de 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -699,7 +699,6 @@ static int save_image_lzo(struct swap_map_handle *handle,
 
 	data = vmalloc(sizeof(*data) * nr_threads);
 	if (!data) {
-		printk(KERN_ERR "PM: Failed to allocate LZO data\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -708,7 +707,6 @@ static int save_image_lzo(struct swap_map_handle *handle,
 
 	crc = kmalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
-		printk(KERN_ERR "PM: Failed to allocate crc\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -1190,14 +1188,12 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 	page = vmalloc(sizeof(*page) * LZO_MAX_RD_PAGES);
 	if (!page) {
-		printk(KERN_ERR "PM: Failed to allocate LZO page\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
 
 	data = vmalloc(sizeof(*data) * nr_threads);
 	if (!data) {
-		printk(KERN_ERR "PM: Failed to allocate LZO data\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
@@ -1206,7 +1202,6 @@ static int load_image_lzo(struct swap_map_handle *handle,
 
 	crc = kmalloc(sizeof(*crc), GFP_KERNEL);
 	if (!crc) {
-		printk(KERN_ERR "PM: Failed to allocate crc\n");
 		ret = -ENOMEM;
 		goto out_clean;
 	}
-- 
2.14.2
