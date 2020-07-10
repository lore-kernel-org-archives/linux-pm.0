Return-Path: <SRS0=akx2=AV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5565C433E7
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 19:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DED92078D
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 19:11:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGJTLn (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:11:43 -0400
Received: from foss.arm.com ([217.140.110.172]:35424 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgGJTLm (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 10 Jul 2020 15:11:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2207531B;
        Fri, 10 Jul 2020 12:11:42 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.37.12.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 840103FA00;
        Fri, 10 Jul 2020 12:11:38 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     lukasz.luba@arm.com, willy.mh.wolff.ml@gmail.com,
        k.konieczny@samsung.com, cw00.choi@samsung.com,
        b.zolnierkie@samsung.com, krzk@kernel.org, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        s.nawrocki@samsung.com, kgene@kernel.org
Subject: [PATCH v2 1/2] memory: samsung: exynos5422-dmc: Adjust polling interval and uptreshold
Date:   Fri, 10 Jul 2020 20:11:21 +0100
Message-Id: <20200710191122.11029-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710191122.11029-1-lukasz.luba@arm.com>
References: <20200710191122.11029-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to react faster and make better decisions under some workloads,
benchmarking the memory subsystem behavior, adjust the polling interval
and upthreshold value used by the simple_ondemand governor.

Reported-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/memory/samsung/exynos5422-dmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 93e9c2429c0d..e03ee35f0ab5 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1466,10 +1466,10 @@ static int exynos5_dmc_probe(struct platform_device *pdev)
 		 * Setup default thresholds for the devfreq governor.
 		 * The values are chosen based on experiments.
 		 */
-		dmc->gov_data.upthreshold = 30;
+		dmc->gov_data.upthreshold = 10;
 		dmc->gov_data.downdifferential = 5;
 
-		exynos5_dmc_df_profile.polling_ms = 500;
+		exynos5_dmc_df_profile.polling_ms = 100;
 	}
 
 
-- 
2.17.1

