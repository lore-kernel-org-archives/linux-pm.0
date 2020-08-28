Return-Path: <SRS0=beHt=CG=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA55EC433E2
	for <linux-pm@archiver.kernel.org>; Fri, 28 Aug 2020 15:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A24AA208D5
	for <linux-pm@archiver.kernel.org>; Fri, 28 Aug 2020 15:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598628667;
	bh=ZRmEHvNeCWySdppo9f+Xpr/wkwy/XVp3F0fZ+psgUTA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=xKkHShSbFsQcifrq0+Bmlw0DDjztivqOsIBsRI5UKZH7hlK2DWkxO4j6sDCsxlmCX
	 Dt3DIWNKcCIRKHAXbGfP/3bFLJBI0LGzH4LFMeNmBQ0PogpLX9GgnDQ9KBb3dPCyCu
	 OL7z65Le84vCredMBEPJemweU7InI66ybOrG7HA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgH1PbG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:41176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725969AbgH1PbF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Aug 2020 11:31:05 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01AC20825;
        Fri, 28 Aug 2020 15:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598628665;
        bh=ZRmEHvNeCWySdppo9f+Xpr/wkwy/XVp3F0fZ+psgUTA=;
        h=From:To:Cc:Subject:Date:From;
        b=v3LCcNlDRdLEhs0PxlDleb95PcfWSDsKdDgeXwh15QXXmxlrQ73XLS5fE/5rSR8Ld
         dCexiKcqZ7pcxg7ivfQQchWY6N5t0XdRxmdKtpb+8m7FKn2HH4LrGPuQ+HAe2N4zTW
         jBi8MpMAVLxrEcXK8GDLj3LKF5ZTCzzRn7nXNkls=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] devfreq: rk3399_dmc: Simplify with dev_err_probe()
Date:   Fri, 28 Aug 2020 17:31:00 +0200
Message-Id: <20200828153100.19006-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/devfreq/rk3399_dmc.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 027769e39f9b..35b3542f1f7b 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -324,22 +324,14 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	mutex_init(&data->lock);
 
 	data->vdd_center = devm_regulator_get(dev, "center");
-	if (IS_ERR(data->vdd_center)) {
-		if (PTR_ERR(data->vdd_center) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(dev, "Cannot get the regulator \"center\"\n");
-		return PTR_ERR(data->vdd_center);
-	}
+	if (IS_ERR(data->vdd_center))
+		return dev_err_probe(dev, PTR_ERR(data->vdd_center),
+				     "Cannot get the regulator \"center\"\n");
 
 	data->dmc_clk = devm_clk_get(dev, "dmc_clk");
-	if (IS_ERR(data->dmc_clk)) {
-		if (PTR_ERR(data->dmc_clk) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-
-		dev_err(dev, "Cannot get the clk dmc_clk\n");
-		return PTR_ERR(data->dmc_clk);
-	}
+	if (IS_ERR(data->dmc_clk))
+		return dev_err_probe(dev, PTR_ERR(data->dmc_clk),
+				     "Cannot get the clk dmc_clk\n");
 
 	data->edev = devfreq_event_get_edev_by_phandle(dev, 0);
 	if (IS_ERR(data->edev))
-- 
2.17.1

