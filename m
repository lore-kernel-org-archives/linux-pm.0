Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D745FC77B7F
	for <linux-pm@archiver.kernel.org>; Mon,  8 May 2023 09:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjEHJpD (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 8 May 2023 05:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjEHJpB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 May 2023 05:45:01 -0400
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291791BD9;
        Mon,  8 May 2023 02:44:58 -0700 (PDT)
X-QQ-mid: bizesmtpipv601t1683539081tf77
Received: from localhost ( [255.223.254.8])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 08 May 2023 17:44:39 +0800 (CST)
X-QQ-SSF: 0140000000000090C000000A0000000
X-QQ-FEAT: Wp4pj0u9TIdcZv2TJB/NfqHBlbnhxuRKFJgnw9gxgj10J/dRDegEeeTSP8Ihc
        Y/jaVm56S8UJwaq6yJQQFXVGRhMpADxPiPLvwh3TL/exQF6FyCVWIyxL5rcGKGPmUeiY635
        zCicvnWNKKn4U3/k0NKsWdXAQdvKYKChtdznbWVvvaZD2x199jWDwmItb6qbD6F3mwZ/F/1
        pmuxNQCaCexciUN7Fcpq/CU73cRvjrmvKx8RAD9ZoS7HfQpVNWbXa+8bSgmMEVXgwDPEkxO
        Ti1WnRUpCt8Ugjea4s1YarzHXG+RQsnR++2YCguBobtiuRo6fkhWmEG9EvEuqr5vc0gDslL
        twt2qNfDHLdBJMf3KjKHlaZ9sP8PNt8CgXOHD34
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12323299872173341947
Date:   Mon, 8 May 2023 17:44:38 +0800
From:   Wang Honghui <honghui.wang@ucas.com.cn>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] power: Fix a typo of comment
Message-ID: <9C62688C6A61734D+ZFjEhkpuP52chLti@TP-P15V>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:ucas.com.cn:qybglogicsvrgz:qybglogicsvrgz5a-2
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Subject: [PATCH] power: Fix a typo of comment

As title

Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
---
 kernel/power/snapshot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index cd8b7b35f1e8..b27affb7503f 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -398,7 +398,7 @@ struct mem_zone_bm_rtree {
 	unsigned int blocks;		/* Number of Bitmap Blocks     */
 };
 
-/* strcut bm_position is used for browsing memory bitmaps */
+/* struct bm_position is used for browsing memory bitmaps */
 
 struct bm_position {
 	struct mem_zone_bm_rtree *zone;
-- 
2.34.1

