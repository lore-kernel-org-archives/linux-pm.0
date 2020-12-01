Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DB8C83013
	for <linux-pm@archiver.kernel.org>; Tue,  1 Dec 2020 12:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE092085B
	for <linux-pm@archiver.kernel.org>; Tue,  1 Dec 2020 12:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgLAMk6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 1 Dec 2020 07:40:58 -0500
Received: from comms.puri.sm ([159.203.221.185]:35256 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgLAMk6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 1 Dec 2020 07:40:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id C3FF6E0422;
        Tue,  1 Dec 2020 04:40:17 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g9gNJm9Z32VS; Tue,  1 Dec 2020 04:40:16 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, georgi.djakov@linaro.org,
        cdleonard@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 3/7] arm64: dts: imx8mq: Add interconnect for lcdif
Date:   Tue,  1 Dec 2020 13:39:28 +0100
Message-Id: <20201201123932.12312-4-martin.kepplinger@puri.sm>
In-Reply-To: <20201201123932.12312-1-martin.kepplinger@puri.sm>
References: <20201201123932.12312-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add interconnect ports for lcdif to set bus capabilities.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 244e28e54b35..f21198b19ecc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -11,6 +11,7 @@
 #include "dt-bindings/input/input.h"
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interconnect/imx8mq.h>
 #include "imx8mq-pinfunc.h"
 
 / {
@@ -522,6 +523,8 @@
 						  <&clk IMX8MQ_VIDEO_PLL1>,
 						  <&clk IMX8MQ_VIDEO_PLL1_OUT>;
 				assigned-clock-rates = <0>, <0>, <0>, <594000000>;
+				interconnects = <&noc IMX8MQ_ICM_LCDIF &noc IMX8MQ_ICS_DRAM>;
+				interconnect-names = "dram";
 				status = "disabled";
 
 				port@0 {
-- 
2.20.1

