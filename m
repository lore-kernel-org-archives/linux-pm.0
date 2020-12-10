Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C381C433FE
	for <linux-pm@archiver.kernel.org>; Thu, 10 Dec 2020 10:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5314A23D69
	for <linux-pm@archiver.kernel.org>; Thu, 10 Dec 2020 10:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729967AbgLJKLU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:11:20 -0500
Received: from comms.puri.sm ([159.203.221.185]:40378 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgLJKLR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 10 Dec 2020 05:11:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6B604E1203;
        Thu, 10 Dec 2020 02:09:46 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zeW-Sjtm7vL9; Thu, 10 Dec 2020 02:09:41 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v3 2/6] arm64: dts: imx8mq: Add interconnect provider property
Date:   Thu, 10 Dec 2020 11:09:02 +0100
Message-Id: <20201210100906.18205-3-martin.kepplinger@puri.sm>
In-Reply-To: <20201210100906.18205-1-martin.kepplinger@puri.sm>
References: <20201210100906.18205-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add #interconnect-cells on main &noc so that it will probe the interconnect
provider.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 9c9d68a14e69..3617b7238952 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -1163,6 +1163,7 @@
 			reg = <0x32700000 0x100000>;
 			clocks = <&clk IMX8MQ_CLK_NOC>;
 			fsl,ddrc = <&ddrc>;
+			#interconnect-cells = <1>;
 			operating-points-v2 = <&noc_opp_table>;
 
 			noc_opp_table: opp-table {
-- 
2.20.1

