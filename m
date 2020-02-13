Return-Path: <SRS0=85Kx=4B=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55896C3B188
	for <linux-pm@archiver.kernel.org>; Thu, 13 Feb 2020 10:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D034218AC
	for <linux-pm@archiver.kernel.org>; Thu, 13 Feb 2020 10:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="L+rh/B60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgBMKZT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 13 Feb 2020 05:25:19 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50180 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMKZT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Feb 2020 05:25:19 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01DAP8Wn086736;
        Thu, 13 Feb 2020 04:25:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581589508;
        bh=R6MRp++GWCpBdBjFCD+OFqWEafgbvoZG6dgOZ8foZv8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L+rh/B60/REwoPOcFwcQlNoTrDV0IahNa3q4BXFxusXziojrUi03A6kFOUp5tUYF+
         MjMUDan79gWmMyNncHogM0hgRjnzGL7LQDxr3EQlkd0VnQYa1W1MmS4bEDVYqUXH90
         goO5WNqGnx+HFMggvx7zARk+nUn+8NsRhmU+0Nk8=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01DAP89P110984;
        Thu, 13 Feb 2020 04:25:08 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 13
 Feb 2020 04:25:07 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 13 Feb 2020 04:25:07 -0600
Received: from a0393675ula.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01DAOqpa011317;
        Thu, 13 Feb 2020 04:25:04 -0600
From:   Keerthy <j-keerthy@ti.com>
To:     <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <j-keerthy@ti.com>, <amit.kucheria@verdurent.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
Subject: [PATCH 3/4] arm64: dts: ti: am654: Add thermal zones
Date:   Thu, 13 Feb 2020 15:54:39 +0530
Message-ID: <20200213102440.20539-4-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213102440.20539-1-j-keerthy@ti.com>
References: <20200213102440.20539-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The am654 SoC has three thermal zones namely MPU0, MPU1 and MCU
zones

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 .../boot/dts/ti/am654-industrial-thermal.dtsi | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi

diff --git a/arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi b/arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi
new file mode 100644
index 000000000000..cdc3d40c3f60
--- /dev/null
+++ b/arch/arm64/boot/dts/ti/am654-industrial-thermal.dtsi
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <dt-bindings/thermal/thermal.h>
+
+mpu0_thermal: mpu0_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 0>;
+
+	trips {
+		mpu0_crit: mpu0_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+mpu1_thermal: mpu1_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 1>;
+
+	trips {
+		mpu1_crit: mpu1_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
+
+mcu_thermal: mcu_thermal {
+	polling-delay-passive = <250>; /* milliseconds */
+	polling-delay = <500>; /* milliseconds */
+	thermal-sensors = <&wkup_vtm0 2>;
+
+	trips {
+		mcu_crit: mcu_crit {
+			temperature = <125000>; /* milliCelsius */
+			hysteresis = <2000>; /* milliCelsius */
+			type = "critical";
+		};
+	};
+};
-- 
2.17.1

