From: Geliang Tang <geliangtang@gmail.com>
Subject: [PATCH] PM / Hibernate: use rb_entry instead of container_of
Date: Mon, 19 Dec 2016 23:03:11 +0800
Message-ID: <c479dd32fab44ad1cda6dc4f2e0d70e617608afe.1482159675.git.geliangtang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Cc: Geliang Tang <geliangtang@gmail.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

To make the code clearer, use rb_entry() instead of container_of() to
deal with rbtree.

Signed-off-by: Geliang Tang <geliangtang@gmail.com>
---
 kernel/power/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 32e0c23..f80fd33 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -201,7 +201,7 @@ void free_all_swap_pages(int swap)
 		struct swsusp_extent *ext;
 		unsigned long offset;
 
-		ext = container_of(node, struct swsusp_extent, node);
+		ext = rb_entry(node, struct swsusp_extent, node);
 		rb_erase(node, &swsusp_extents);
 		for (offset = ext->start; offset <= ext->end; offset++)
 			swap_free(swp_entry(swap, offset));
-- 
2.9.3
