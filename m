Return-Path: <SRS0=udDz=6V=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283C6C4724C
	for <linux-pm@archiver.kernel.org>; Thu,  7 May 2020 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1373D2075E
	for <linux-pm@archiver.kernel.org>; Thu,  7 May 2020 11:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgEGLy0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 7 May 2020 07:54:26 -0400
Received: from mail-m17613.qiye.163.com ([59.111.176.13]:44732 "EHLO
        mail-m17613.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbgEGLy0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 07:54:26 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 May 2020 07:54:26 EDT
Received: from ubuntu.localdomain (unknown [157.0.31.122])
        by mail-m17613.qiye.163.com (Hmail) with ESMTPA id 2BEEA482B3F;
        Thu,  7 May 2020 19:45:22 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] memory/samsung: Maybe wrong triming parameter
Date:   Thu,  7 May 2020 04:45:14 -0700
Message-Id: <20200507114514.11589-1-bernard@vivo.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VOS0JCQkJMTklLT09NQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgg6Gjo5NTg0GT8wSyNCHzMv
        IkwwCRJVSlVKTkNDQ05KQkhISkxJVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSUlZV1kIAVlBSUtMTDcG
X-HM-Tid: 0a71eef455f993bakuws2beea482b3f
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In function create_timings_aligned, all the max is to use
dmc->min_tck->xxx, aligned with val dmc->timings->xxx.
But the dmc->timings->tFAW use dmc->min_tck->tXP?
Maybe this point is wrong parameter useing.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 81a1b1d01683..22a43d662833 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1091,7 +1091,7 @@ static int create_timings_aligned(struct exynos5_dmc *dmc, u32 *reg_timing_row,
 	/* power related timings */
 	val = dmc->timings->tFAW / clk_period_ps;
 	val += dmc->timings->tFAW % clk_period_ps ? 1 : 0;
-	val = max(val, dmc->min_tck->tXP);
+	val = max(val, dmc->min_tck->tFAW);
 	reg = &timing_power[0];
 	*reg_timing_power |= TIMING_VAL2REG(reg, val);
 
-- 
2.26.2

