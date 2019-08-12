Return-Path: <SRS0=ntgF=WI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375D1C31E40
	for <linux-pm@archiver.kernel.org>; Mon, 12 Aug 2019 18:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AEE2070C
	for <linux-pm@archiver.kernel.org>; Mon, 12 Aug 2019 18:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfHLSuC (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 12 Aug 2019 14:50:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:51608 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfHLSuC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Aug 2019 14:50:02 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8B9832006A4;
        Mon, 12 Aug 2019 20:49:59 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D4CC2006A1;
        Mon, 12 Aug 2019 20:49:59 +0200 (CEST)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B3A5205ED;
        Mon, 12 Aug 2019 20:49:58 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@partner.samsung.com>,
        Saravana Kannan <saravanak@google.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Bailon <abailon@baylibre.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/7] dt-bindings: devfreq: Add bindings for imx ddr controller
Date:   Mon, 12 Aug 2019 21:49:48 +0300
Message-Id: <4cbddd75652c63aab19866c93faa0b784b56d53f.1565633880.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1565633880.git.leonard.crestez@nxp.com>
References: <cover.1565633880.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1565633880.git.leonard.crestez@nxp.com>
References: <cover.1565633880.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add devicetree bindings for the i.MX DDR Controller on imx8m series
chips. It supports dynamic frequency switching between multiple data
rates and this is exposed to Linux via the devfreq subsystem.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 .../devicetree/bindings/devfreq/imx-ddrc.yaml | 53 +++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml

diff --git a/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml b/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
new file mode 100644
index 000000000000..fa20280a682f
--- /dev/null
+++ b/Documentation/devicetree/bindings/devfreq/imx-ddrc.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/devfreq/imx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX DDR Controller
+
+maintainers:
+  - Leonard Crestez <leonard.crestez@nxp.com>
+
+properties:
+  compatible:
+    contains:
+      enum:
+       - fsl,imx8m-ddrc
+
+  reg:
+    maxItems: 1
+    description: DDR Controller registers
+
+  clocks:
+    minItems: 5
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: dram_core
+      - const: dram_pll
+      - const: dram_alt_root
+      - const: dram_alt
+      - const: dram_apb
+
+required:
+  - reg
+  - compatible
+  - clocks
+  - clock-names
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mm-clock.h>
+    ddrc: dram-controller@3d400000 {
+        compatible = "fsl,imx8mm-ddrc", "fsl,imx8m-ddrc";
+        reg = <0x3d400000 0x400000>;
+        clock-names = "dram_core", "dram_pll", "dram_alt_root", "dram_alt", "dram_apb";
+        clocks = <&clk IMX8MM_CLK_DRAM_CORE>,
+                 <&clk IMX8MM_DRAM_PLL>,
+                 <&clk IMX8MM_CLK_DRAM_ALT_ROOT>,
+                 <&clk IMX8MM_CLK_DRAM_ALT>,
+                 <&clk IMX8MM_CLK_DRAM_APB>;
+        operating-points-v2 = <&ddrc_opp_table>;
+    };
-- 
2.17.1

