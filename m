Return-Path: <SRS0=EC3c=AD=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E31C433DF
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jun 2020 03:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F0E23AF8
	for <linux-pm@archiver.kernel.org>; Mon, 22 Jun 2020 03:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731171AbgFVDAO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:00:14 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:51539 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731156AbgFVDAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jun 2020 23:00:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2084565|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0693178-0.00126328-0.929419;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07381;MF=frank@allwinnertech.com;NM=1;PH=DS;RN=27;RT=27;SR=0;TI=SMTPD_---.HqMydez_1592794774;
Received: from allwinnertech.com(mailfrom:frank@allwinnertech.com fp:SMTPD_---.HqMydez_1592794774)
          by smtp.aliyun-inc.com(10.147.40.44);
          Mon, 22 Jun 2020 11:00:07 +0800
From:   Frank Lee <frank@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        srinivas.kandagatla@linaro.org, linus.walleij@linaro.org,
        anarsoul@gmail.com, tiny.windzz@gmail.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, amit.kucheria@verdurent.com,
        p.zabel@pengutronix.de, clabbe@baylibre.com, icenowy@aosc.io,
        megous@megous.com, karlp@tweak.net.au, bage@linutronix.de
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pm@vger.kernel.org,
        huangshuosheng@allwinnertech.com, liyong@allwinnertech.com,
        Frank Lee <frank@allwinnertech.com>
Subject: [PATCH v2 06/11] nvmem: sunxi-sid: add support for A100's SID controller
Date:   Mon, 22 Jun 2020 10:59:02 +0800
Message-Id: <20200622025907.32574-7-frank@allwinnertech.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200622025907.32574-1-frank@allwinnertech.com>
References: <20200622025907.32574-1-frank@allwinnertech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for A100's SID controller.

Signed-off-by: Frank Lee <frank@allwinnertech.com>
---
 drivers/nvmem/sunxi_sid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index e26ef1b..8ac074b 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -189,6 +189,11 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	.need_register_readout = true,
 };
 
+static const struct sunxi_sid_cfg sun50i_a100_cfg = {
+	.value_offset = 0x200,
+	.size = 0x100,
+};
+
 static const struct sunxi_sid_cfg sun50i_h6_cfg = {
 	.value_offset = 0x200,
 	.size = 0x200,
@@ -200,6 +205,7 @@ static int sunxi_sid_probe(struct platform_device *pdev)
 	{ .compatible = "allwinner,sun8i-a83t-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
+	{ .compatible = "allwinner,sun50i-a100-sid", .data = &sun50i_a100_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
 	{/* sentinel */},
-- 
1.9.1

