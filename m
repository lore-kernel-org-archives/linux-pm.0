Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03FBC433EF
	for <linux-pm@archiver.kernel.org>; Thu, 12 May 2022 07:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350884AbiELHTr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 12 May 2022 03:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350877AbiELHTr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 May 2022 03:19:47 -0400
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8AA9EC5E52;
        Thu, 12 May 2022 00:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NROcH
        46QTP7r22AZhwCyQpzWGpCpKihEyG7MRmlO5rI=; b=owRHhQwYs+ntE37SNQhOY
        +PcIEtmES+TZEn10QnTeKALl3p8DvYgdxv46uT2PXHfRt9URENyapa8wKyPADzz/
        c5AoKHeHkZdTN1pthyp4HLYW99T/nLCwHaMdqi/++lBtO5vj13yAGj2/Z1DodT+7
        l2rcHz8nW/7sfZCoK+tBYY=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
        by smtp13 (Coremail) with SMTP id EcCowACHoI3ptHxiu+ySCA--.8205S2;
        Thu, 12 May 2022 15:19:06 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v3 1/2] ARM: dts: sun8i-r40: add opp table for cpu
Date:   Thu, 12 May 2022 15:18:57 +0800
Message-Id: <20220512071858.10805-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowACHoI3ptHxiu+ySCA--.8205S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw47XryfXF4UZw4fGw1ftFb_yoW8tFW5pr
        4UKayYkF4fWr129wnIqr18tFyrCa9Y9F45Jr9rC3y8t34FqryDtr9rtry3K3yDXr47X3yS
        qr4aqryUKw1DA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zR0JmUUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiGhP+7VaEBigVVQABsn
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

OPP table value is get from allwinner lichee linux-3.10 kernel driver

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
Changes in v3:
- remove "allwinner-r40" compatible from allowlist.
- split dts in two part.

 arch/arm/boot/dts/sun8i-r40.dtsi | 47 ++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 291f4784e86c..90de119095fa 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -54,6 +54,41 @@ / {
 	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1000000 1000000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1100000 1100000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1160000 1160000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1240000 1240000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1300000 1300000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -84,24 +119,36 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu1: cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu2: cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu3: cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
 
-- 
2.25.1

