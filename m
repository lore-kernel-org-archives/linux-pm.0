From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 3/6] kexec: export PG_offline to VMCOREINFO
Date: Wed, 14 Nov 2018 22:17:01 +0100
Message-ID: <20181114211704.6381-4-david@redhat.com>
References: <20181114211704.6381-1-david@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114211704.6381-1-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, devel@linuxdriverproject.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org, David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Dave Young <dyoung@redhat.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Baoquan He <bhe@redhat.com>, Omar Sandoval <osandov@fb.com>, Arnd Bergmann <arnd@arndb.de>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: linux-pm@vger.kernel.org

Let's export PG_offline via PAGE_OFFLINE_MAPCOUNT_VALUE, so
makedumpfile can directly skip pages that are logically offline and the
content therefore stale.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Young <dyoung@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/crash_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 933cb3e45b98..093c9f917ed0 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -464,6 +464,8 @@ static int __init crash_save_vmcoreinfo_init(void)
 	VMCOREINFO_NUMBER(PAGE_BUDDY_MAPCOUNT_VALUE);
 #ifdef CONFIG_HUGETLB_PAGE
 	VMCOREINFO_NUMBER(HUGETLB_PAGE_DTOR);
+#define PAGE_OFFLINE_MAPCOUNT_VALUE	(~PG_offline)
+	VMCOREINFO_NUMBER(PAGE_OFFLINE_MAPCOUNT_VALUE);
 #endif
 
 	arch_crash_save_vmcoreinfo();
-- 
2.17.2
