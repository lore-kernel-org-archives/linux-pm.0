From: Kyungsik Lee <kyungsik.lee@lge.com>
Subject: [PATCH] PM / Hibernate: Remove unused parameter of enough_swap
Date: Tue, 16 Jan 2018 10:19:43 +0900
Message-ID: <1516065583-29239-1-git-send-email-kyungsik.lee@lge.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:37543 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750773AbeAPBV4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jan 2018 20:21:56 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chan.jeong@lge.com, raphael.andy.lee@gmail.com, Kyungsik Lee <kyungsik.lee@lge.com>

Parameter flags is no longer used, remove it.

Signed-off-by: Kyungsik Lee <kyungsik.lee@lge.com>
---
 kernel/power/swap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 293ead5..a46be12 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -879,7 +879,7 @@ static int save_image_lzo(struct swap_map_handle *handle,
  *	space avaiable from the resume partition.
  */
 
-static int enough_swap(unsigned int nr_pages, unsigned int flags)
+static int enough_swap(unsigned int nr_pages)
 {
 	unsigned int free_swap = count_swap_pages(root_swap, 1);
 	unsigned int required;
@@ -915,7 +915,7 @@ int swsusp_write(unsigned int flags)
 		return error;
 	}
 	if (flags & SF_NOCOMPRESS_MODE) {
-		if (!enough_swap(pages, flags)) {
+		if (!enough_swap(pages)) {
 			pr_err("Not enough free swap\n");
 			error = -ENOSPC;
 			goto out_finish;
-- 
1.9.1
