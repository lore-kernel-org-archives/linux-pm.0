Return-Path: <SRS0=VqYW=C3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9927C43464
	for <linux-pm@archiver.kernel.org>; Fri, 18 Sep 2020 02:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A5BF214D8
	for <linux-pm@archiver.kernel.org>; Fri, 18 Sep 2020 02:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600397086;
	bh=Ne3dh4tylcpIqw3gc57sWDEHi9qpHguAfHHfpVuiAqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NcHDq2dfBR6AXDN18xdey1MCZcO4tkVZBLpBhjJ4TDYTNFEqeLD7iriey8f5rGs5q
	 RoGKuEGsBY7So+CDiscwiz0JGFcumveU/m0dzdeY9oUZt03doBK1gqg6QK8qAbRNJT
	 LjQD+z70+9EJP71gsPFGfwyEkjPuCIOS3OZHXGWw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgIRCK0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 17 Sep 2020 22:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgIRCKZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 17 Sep 2020 22:10:25 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E57EB238E6;
        Fri, 18 Sep 2020 02:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600395024;
        bh=Ne3dh4tylcpIqw3gc57sWDEHi9qpHguAfHHfpVuiAqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCihhU9k8CGy/UgI9kMu+73WG1nN4My+d1x6i00QtNh+0IqhjAbDk5WrAHQnzI/5O
         0WspJOkn46alP/vlLMD6EKUQUw02rtRHYMe2qHG3ZU1iFFKGJekayoSCf2RDcOSMow
         1QrR/C4MAG5hjh09cnefMaQGb4ZePAc8+U7syYk8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 118/206] thermal: rcar_thermal: Handle probe error gracefully
Date:   Thu, 17 Sep 2020 22:06:34 -0400
Message-Id: <20200918020802.2065198-118-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020802.2065198-1-sashal@kernel.org>
References: <20200918020802.2065198-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit 39056e8a989ef52486e063e34b4822b341e47b0e ]

If the common register memory resource is not available the driver needs
to fail gracefully to disable PM. Instead of returning the error
directly store it in ret and use the already existing error path.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20200310114709.1483860-1-niklas.soderlund+renesas@ragnatech.se
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/rcar_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 4dc30e7890f6c..140386d7c75a3 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -505,8 +505,10 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			res = platform_get_resource(pdev, IORESOURCE_MEM,
 						    mres++);
 			common->base = devm_ioremap_resource(dev, res);
-			if (IS_ERR(common->base))
-				return PTR_ERR(common->base);
+			if (IS_ERR(common->base)) {
+				ret = PTR_ERR(common->base);
+				goto error_unregister;
+			}
 
 			idle = 0; /* polling delay is not needed */
 		}
-- 
2.25.1

