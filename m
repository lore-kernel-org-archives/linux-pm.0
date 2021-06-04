Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10351C47099
	for <linux-pm@archiver.kernel.org>; Fri,  4 Jun 2021 10:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F416461208
	for <linux-pm@archiver.kernel.org>; Fri,  4 Jun 2021 10:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbhFDKFe (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 4 Jun 2021 06:05:34 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55775 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230321AbhFDKFc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Jun 2021 06:05:32 -0400
X-UUID: b6dfb27ac575413a905bced22ab0c820-20210604
X-UUID: b6dfb27ac575413a905bced22ab0c820-20210604
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1002846354; Fri, 04 Jun 2021 18:02:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Jun 2021 18:02:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 4 Jun 2021 18:02:25 +0800
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>,
        Dawei Chien <dawei.chien@mediatek.com>
Subject: [PATCH V10 06/12] arm64: dts: mt8192: add dvfsrc related nodes
Date:   Fri, 4 Jun 2021 18:02:12 +0800
Message-ID: <20210604100218.13613-7-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210604100218.13613-1-dawei.chien@mediatek.com>
References: <20210604100218.13613-1-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Henry Chen <henryc.chen@mediatek.com>

Enable dvfsrc on mt8192 platform.

Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
index 9757138a8bbd..c70a3bf744fa 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
@@ -282,6 +282,12 @@
 			#interrupt-cells = <2>;
 		};
 
+		ddr_emi: dvfsrc@10012000 {
+			compatible = "mediatek,mt8192-dvfsrc",
+				     "mediatek,mt6873-dvfsrc";
+			reg = <0 0x10012000 0 0x1000>;
+		};
+
 		systimer: timer@10017000 {
 			compatible = "mediatek,mt8192-timer",
 				     "mediatek,mt6765-timer";
-- 
2.14.1

