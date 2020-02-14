Return-Path: <SRS0=AHLa=4C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E73BC3B196
	for <linux-pm@archiver.kernel.org>; Fri, 14 Feb 2020 06:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECDB2465D
	for <linux-pm@archiver.kernel.org>; Fri, 14 Feb 2020 06:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iP3UEGuk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgBNGfJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:35:09 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:36096 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728879AbgBNGfJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 01:35:09 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01E6YmnR071829;
        Fri, 14 Feb 2020 00:34:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581662088;
        bh=cpLUTNVR49uGyfeecKABhA92PHiDQxqNdtEiU6LDsD4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=iP3UEGukIe1d3hFbeJZC2ZpNJ7lpwCIJWRaIQALCbnRJajFQXAhMy0JBFc4zJhepT
         d8TSBgq49juePY2fRCpsuZVlCK7D5fydmHAEwDzrzxYJ7AdNDHlo3acCLs49wPFPUx
         HfmY8YgFCse2NqDWavIz2zWw2PMrcOHGzScItvvU=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01E6YmGk002502
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Feb 2020 00:34:48 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 14
 Feb 2020 00:34:47 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 14 Feb 2020 00:34:47 -0600
Received: from a0393675ula.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01E6YdP3028331;
        Fri, 14 Feb 2020 00:34:44 -0600
From:   Keerthy <j-keerthy@ti.com>
To:     <rui.zhang@intel.com>, <robh+dt@kernel.org>,
        <daniel.lezcano@linaro.org>
CC:     <j-keerthy@ti.com>, <amit.kucheria@verdurent.com>,
        <t-kristo@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <mark.rutland@arm.com>
Subject: [PATCH v2 1/4] dt-bindings: thermal: k3: Add VTM bindings documentation
Date:   Fri, 14 Feb 2020 12:04:40 +0530
Message-ID: <20200214063443.23589-2-j-keerthy@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200214063443.23589-1-j-keerthy@ti.com>
References: <20200214063443.23589-1-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add VTM bindings documentation. In the Voltage Thermal
Management Module(VTM), K3 AM654 supplies a voltage
reference and a temperature sensor feature that are gathered in the band
gap voltage and temperature sensor (VBGAPTS) module. The band
gap provides current and voltage reference for its internal
circuits and other analog IP blocks. The analog-to-digital
converter (ADC) produces an output value that is proportional
to the silicon temperature.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

  * Fixed make dt_binding_check errors.

 .../bindings/thermal/ti,am654-thermal.yaml    | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
new file mode 100644
index 000000000000..1c26ad8cd505
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/ti,am654-thermal.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/ti,am654-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments AM654 VTM (DTS) binding
+
+maintainers:
+  - Keerthy <j-keerthy@ti.com>
+
+properties:
+  compatible:
+    const: ti,am654-vtm
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+    description: phandle to the associated power domain
+
+  "#thermal-sensor-cells":
+    const: 1
+
+required:
+  - "#thermal-sensor-cells"
+  - compatible
+  - reg
+  - power-domains
+
+additionalProperties: false
+
+examples:
+  - |
+
+    vtm: wkup_vtm0@42050000 {
+        compatible = "ti,am654-vtm";
+        reg = <0x0 0x42050000 0x0 0x25c>;
+        power-domains = <&k3_pds 80 TI_SCI_PD_EXCLUSIVE>;
+        #thermal-sensor-cells = <1>;
+    };
+
+    mpu0_thermal: mpu0_thermal {
+        polling-delay-passive = <250>; /* milliseconds */
+        polling-delay = <500>; /* milliseconds */
+        thermal-sensors = <&wkup_vtm0 0>;
+
+        trips {
+                mpu0_crit: mpu0_crit {
+                        temperature = <125000>; /* milliCelsius */
+                        hysteresis = <2000>; /* milliCelsius */
+                        type = "critical";
+                };
+        };
+    };
+...
-- 
2.17.1

