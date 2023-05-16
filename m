Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABF8C7EE2D
	for <linux-pm@archiver.kernel.org>; Tue, 16 May 2023 06:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjEPGVo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 May 2023 02:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjEPGVg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2023 02:21:36 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436192D43;
        Mon, 15 May 2023 23:21:35 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QL5f86GbJzLq3D;
        Tue, 16 May 2023 14:18:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 14:21:32 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, <linux-mm@kvack.org>
CC:     David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 06/13] mm: page_alloc: remove alloc_contig_dump_pages() stub
Date:   Tue, 16 May 2023 14:38:14 +0800
Message-ID: <20230516063821.121844-7-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
References: <20230516063821.121844-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DEFINE_DYNAMIC_DEBUG_METADATA and DYNAMIC_DEBUG_BRANCH already has
stub definitions without dynamic debug feature, remove unnecessary
alloc_contig_dump_pages() stub.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/page_alloc.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1bd8b7832d40..aa3cdfd88393 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6250,8 +6250,6 @@ int percpu_pagelist_high_fraction_sysctl_handler(struct ctl_table *table,
 }
 
 #ifdef CONFIG_CONTIG_ALLOC
-#if defined(CONFIG_DYNAMIC_DEBUG) || \
-	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 /* Usage: See admin-guide/dynamic-debug-howto.rst */
 static void alloc_contig_dump_pages(struct list_head *page_list)
 {
@@ -6265,11 +6263,6 @@ static void alloc_contig_dump_pages(struct list_head *page_list)
 			dump_page(page, "migration failure");
 	}
 }
-#else
-static inline void alloc_contig_dump_pages(struct list_head *page_list)
-{
-}
-#endif
 
 /* [start, end) must belong to a single zone. */
 int __alloc_contig_migrate_range(struct compact_control *cc,
-- 
2.35.3

