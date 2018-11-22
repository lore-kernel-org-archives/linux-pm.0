From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 7/8] PM / Hibernate: use pfn_to_online_page()
Date: Thu, 22 Nov 2018 11:06:26 +0100
Message-ID: <20181122100627.5189-8-david@redhat.com>
References: <20181122100627.5189-1-david@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122100627.5189-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, kexec-ml <kexec@lists.infradead.org>, pv-drivers@vmware.com, David Hildenbrand <david@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: linux-pm@vger.kernel.org

Let's use pfn_to_online_page() instead of pfn_to_page() when checking
for saveable pages to not save/restore offline memory sections.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Suggested-by: Michal Hocko <mhocko@kernel.org>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/power/snapshot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 640b2034edd6..87e6dd57819f 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1215,8 +1215,8 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
 	if (!pfn_valid(pfn))
 		return NULL;
 
-	page = pfn_to_page(pfn);
-	if (page_zone(page) != zone)
+	page = pfn_to_online_page(pfn);
+	if (!page || page_zone(page) != zone)
 		return NULL;
 
 	BUG_ON(!PageHighMem(page));
@@ -1277,8 +1277,8 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 	if (!pfn_valid(pfn))
 		return NULL;
 
-	page = pfn_to_page(pfn);
-	if (page_zone(page) != zone)
+	page = pfn_to_online_page(pfn);
+	if (!page || page_zone(page) != zone)
 		return NULL;
 
 	BUG_ON(PageHighMem(page));
-- 
2.17.2
