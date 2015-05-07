From: Anisse Astier <anisse@astier.eu>
Subject: [PATCH v3 4/4] mm: Add debug code for SANITIZE_FREED_PAGES
Date: Thu,  7 May 2015 08:34:12 +0200
Message-ID: <1430980452-2767-5-git-send-email-anisse@astier.eu>
References: <1430980452-2767-1-git-send-email-anisse@astier.eu>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35578 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932166AbbEGGgi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2015 02:36:38 -0400
Received: by widdi4 with SMTP id di4so229113653wid.0
        for <linux-pm@vger.kernel.org>; Wed, 06 May 2015 23:36:37 -0700 (PDT)
In-Reply-To: <1430980452-2767-1-git-send-email-anisse@astier.eu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
Cc: Anisse Astier <anisse@astier.eu>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, David Rientjes <rientjes@google.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, PaX Team <pageexec@freemail.hu>, Brad Spengler <spender@grsecurity.net>, Kees Cook <keescook@chromium.org>, Andi Kleen <andi@firstfloor.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Add debug code for sanitize freed pages to print status and verify pages
at alloc to make sure they're clean. It can be useful if you have
crashes when using SANITIZE_FREED_PAGES.

Signed-off-by: Anisse Astier <anisse@astier.eu>
---
 kernel/power/snapshot.c |  8 ++++++--
 mm/Kconfig              | 10 ++++++++++
 mm/page_alloc.c         | 18 ++++++++++++++++++
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 673ade1..dfbfb5f 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1044,9 +1044,13 @@ void clear_free_pages(void)
 	memory_bm_position_reset(bm);
 	pfn = memory_bm_next_pfn(bm);
 	while (pfn != BM_END_OF_MAP) {
-		if (pfn_valid(pfn))
+		if (pfn_valid(pfn)) {
+#ifdef CONFIG_SANITIZE_FREED_PAGES_DEBUG
+			printk(KERN_INFO "Clearing page %p\n",
+					page_address(pfn_to_page(pfn)));
+#endif
 			clear_highpage(pfn_to_page(pfn));
-
+		}
 		pfn = memory_bm_next_pfn(bm);
 	}
 	memory_bm_position_reset(bm);
diff --git a/mm/Kconfig b/mm/Kconfig
index e9fb3bd..95364f2 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -647,3 +647,13 @@ config SANITIZE_FREED_PAGES
 	  Depending on your workload it will greatly reduce performance.
 
 	  If unsure, say N.
+
+config SANITIZE_FREED_PAGES_DEBUG
+	bool "Debug sanitize pages feature"
+	default n
+	depends on SANITIZE_FREED_PAGES && DEBUG_KERNEL
+	help
+	  This option adds some debugging code for the SANITIZE_FREED_PAGES
+	  option, as well as verification code to ensure pages are really
+	  zeroed. Don't enable unless you want to debug this feature.
+	  If unsure, say N.
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c29e3a0..f6105e5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -975,6 +975,24 @@ static int prep_new_page(struct page *page, unsigned int order, gfp_t gfp_flags,
 		for (i = 0; i < (1 << order); i++)
 			clear_highpage(page + i);
 #endif
+#ifdef CONFIG_SANITIZE_FREED_PAGES_DEBUG
+	for (i = 0; i < (1 << order); i++) {
+		struct page *p = page + i;
+		void *kaddr = kmap_atomic(p);
+		void *found = memchr_inv(kaddr, 0, PAGE_SIZE);
+		kunmap_atomic(kaddr);
+
+		if (found) {
+			pr_err("page %p is not zero on alloc! %s\n",
+					page_address(p), (gfp_flags &
+						__GFP_ZERO) ?
+					"fixing." : "");
+			if (gfp_flags & __GFP_ZERO) {
+				clear_highpage(p);
+			}
+		}
+	}
+#endif
 
 	if (order && (gfp_flags & __GFP_COMP))
 		prep_compound_page(page, order);
-- 
1.9.3

