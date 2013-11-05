From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH] PM / hibernate: Avoid overflow in hibernate_preallocate_memory
Date: Tue, 05 Nov 2013 15:16:01 +0800
Message-ID: <52789B31.70005@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36740 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774Ab3KEHPQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 5 Nov 2013 02:15:16 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux-pm mailing list <linux-pm@vger.kernel.org>, Leon Drugi <eyak@wp.pl>

When system has a lot of highmem(e.g. 16GiB using a 32 bits kernel), the
code to calculate how much memory we need to preallocate in normal zone
may cause overflow. As Leon has analysed:
"
It looks that during computing 'alloc' variable there is overflow:
alloc = (3943404 - 1970542) - 1978280 = -5418 (signed)
And this function goes to err_out.
"
Fix this by avoiding that overflow.

Reference: https://bugzilla.kernel.org/show_bug.cgi?id=60817
Reported-and-tested-by: Leon Drugi <eyak@wp.pl>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 kernel/power/snapshot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 98c3b34a4cff..91aa616a1f4e 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1402,7 +1402,8 @@ int hibernate_preallocate_memory(void)
 	 * highmem and non-highmem zones separately.
 	 */
 	pages_highmem = preallocate_image_highmem(highmem / 2);
-	alloc = (count - max_size) - pages_highmem;
+	alloc = (count - max_size) > pages_highmem ?
+		(count - max_size - pages_highmem) : 0;
 	pages = preallocate_image_memory(alloc, avail_normal);
 	if (pages < alloc) {
 		/* We have exhausted non-highmem pages, try highmem. */
-- 
1.8.4.39.ga0d3f10

