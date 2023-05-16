Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8269C7EE24
	for <linux-pm@archiver.kernel.org>; Tue, 16 May 2023 06:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjEPGVn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 May 2023 02:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjEPGVg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 16 May 2023 02:21:36 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAA32D42;
        Mon, 15 May 2023 23:21:34 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QL5gx2DsrzLmDK;
        Tue, 16 May 2023 14:20:13 +0800 (CST)
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
Subject: [PATCH v2 05/13] mm: page_alloc: squash page_is_consistent()
Date:   Tue, 16 May 2023 14:38:13 +0800
Message-ID: <20230516063821.121844-6-wangkefeng.wang@huawei.com>
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

Squash the page_is_consistent() into bad_range() as there is
only one caller.

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/page_alloc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 84ba6cca3b3a..1bd8b7832d40 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -517,13 +517,6 @@ static int page_outside_zone_boundaries(struct zone *zone, struct page *page)
 	return ret;
 }
 
-static int page_is_consistent(struct zone *zone, struct page *page)
-{
-	if (zone != page_zone(page))
-		return 0;
-
-	return 1;
-}
 /*
  * Temporary debugging check for pages not lying within a given zone.
  */
@@ -531,7 +524,7 @@ static int __maybe_unused bad_range(struct zone *zone, struct page *page)
 {
 	if (page_outside_zone_boundaries(zone, page))
 		return 1;
-	if (!page_is_consistent(zone, page))
+	if (zone != page_zone(page))
 		return 1;
 
 	return 0;
-- 
2.35.3

