From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 6/6] PM / Hibernate: exclude all PageOffline() pages
Date: Wed, 14 Nov 2018 22:17:04 +0100
Message-ID: <20181114211704.6381-7-david@redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114211704.6381-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, David Hildenbrand <david@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: linux-pm@vger.kernel.org

The content of pages that are marked PG_offline is not of interest
(e.g. inflated by a balloon driver), let's skip these pages.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/power/snapshot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index b0308a2c6000..01db1d13481a 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1222,7 +1222,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
 	BUG_ON(!PageHighMem(page));
 
 	if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page) ||
-	    PageReserved(page))
+	    PageReserved(page) || PageOffline(page))
 		return NULL;
 
 	if (page_is_guard(page))
@@ -1286,6 +1286,9 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
 		return NULL;
 
+	if (PageOffline(page))
+		return NULL;
+
 	if (PageReserved(page)
 	    && (!kernel_page_present(page) || pfn_is_nosave(pfn)))
 		return NULL;
-- 
2.17.2
