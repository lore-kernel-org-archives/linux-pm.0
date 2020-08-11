Return-Path: <SRS0=erbm=BV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3601C433DF
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 10:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93E52076B
	for <linux-pm@archiver.kernel.org>; Tue, 11 Aug 2020 10:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHKKRe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:17:34 -0400
Received: from foss.arm.com ([217.140.110.172]:36370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728470AbgHKKRe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 11 Aug 2020 06:17:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F302131B;
        Tue, 11 Aug 2020 03:17:33 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id AA2543F22E;
        Tue, 11 Aug 2020 03:17:31 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     oss-self-reviewed-patches@listhost.cambridge.arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        krzk@kernel.org
Cc:     kgene@kernel.org, b.zolnierkie@samsung.com, lukasz.luba@arm.com
Subject: [PATCH] memory: samsung: exynos5422-dmc: Additional locking for 'curr_rate'
Date:   Tue, 11 Aug 2020 11:17:27 +0100
Message-Id: <20200811101727.3976-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The 'curr_rate' is protected by local 'dmc->lock' in various places, but
not in a function exynos5_dmc_get_status(). The lock protects frequency
(and voltage) change process and the corresponding value stored in
'curr_rate'. Add the locking mechanism to protect the 'curr_rate' reading
also in the exynos5_dmc_get_status().

Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index b9c7956e5031..952bc61e68f4 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -908,7 +908,10 @@ static int exynos5_dmc_get_status(struct device *dev,
 	int ret;
 
 	if (dmc->in_irq_mode) {
+		mutex_lock(&dmc->lock);
 		stat->current_frequency = dmc->curr_rate;
+		mutex_unlock(&dmc->lock);
+
 		stat->busy_time = dmc->load;
 		stat->total_time = dmc->total;
 	} else {
-- 
2.17.1

