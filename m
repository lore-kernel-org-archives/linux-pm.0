Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CD4C7EE2D
	for <linux-pm@archiver.kernel.org>; Mon,  8 May 2023 06:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjEHGzH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 May 2023 02:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHGy4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 02:54:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1592CAD03;
        Sun,  7 May 2023 23:54:55 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QFBpG2Gm2zpW9f;
        Mon,  8 May 2023 14:53:42 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 14:54:52 +0800
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
        <linux-fsdevel@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 11/12] mm: vmscan: use gfp_has_io_fs()
Date:   Mon, 8 May 2023 15:11:59 +0800
Message-ID: <20230508071200.123962-12-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
References: <20230508071200.123962-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use gfp_has_io_fs() instead of open-code.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 6d0cd2840cf0..15efbfbb1963 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2458,7 +2458,7 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
 	 * won't get blocked by normal direct-reclaimers, forming a circular
 	 * deadlock.
 	 */
-	if ((sc->gfp_mask & (__GFP_IO | __GFP_FS)) == (__GFP_IO | __GFP_FS))
+	if (gfp_has_io_fs(sc->gfp_mask))
 		inactive >>= 3;
 
 	too_many = isolated > inactive;
-- 
2.35.3

