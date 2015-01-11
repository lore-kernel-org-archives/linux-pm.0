From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] kernel: power: snapshot: Remove unused function
Date: Sun, 11 Jan 2015 23:27:38 +0100
Message-ID: <1421015258-24472-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:60302 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbbAKWYd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jan 2015 17:24:33 -0500
Received: by mail-wg0-f41.google.com with SMTP id l18so16447293wgh.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2015 14:24:32 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the function get_safe_write_buffer() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 kernel/power/snapshot.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 791a618..dac8919 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -2309,8 +2309,6 @@ static inline void free_highmem_data(void)
 		free_image_page(buffer, PG_UNSAFE_CLEAR);
 }
 #else
-static inline int get_safe_write_buffer(void) { return 0; }
-
 static unsigned int
 count_highmem_image_pages(struct memory_bitmap *bm) { return 0; }
 
-- 
1.7.10.4

