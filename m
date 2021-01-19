Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08750C282E3
	for <linux-pm@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CABFF22CAD
	for <linux-pm@archiver.kernel.org>; Tue, 19 Jan 2021 18:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbhASR4n (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 19 Jan 2021 12:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389051AbhASR4b (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 19 Jan 2021 12:56:31 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB721C061387;
        Tue, 19 Jan 2021 09:50:24 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C5AD83F215;
        Tue, 19 Jan 2021 18:46:00 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     viresh.kumar@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v4 7/7] dt-bindings: cpufreq: qcom-hw: Add bindings for 8998
Date:   Tue, 19 Jan 2021 18:45:57 +0100
Message-Id: <20210119174557.227318-8-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
References: <20210119174557.227318-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The OSM programming addition has been done under the
qcom,cpufreq-hw-8998 compatible name: specify the requirement
of two additional register spaces for this functionality.
This implementation, with the same compatible, has been
tested on MSM8998 and SDM630.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 66 +++++++++++++++----
 1 file changed, 52 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index bc81b6203e27..17fd6a6cefb0 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -18,6 +18,10 @@ description: |
 properties:
   compatible:
     oneOf:
+      - description: Non-secure v1 of CPUFREQ HW
+        items:
+          - const: qcom,cpufreq-hw-8998
+
       - description: v1 of CPUFREQ HW
         items:
           - const: qcom,cpufreq-hw
@@ -28,21 +32,9 @@ properties:
               - qcom,sm8250-cpufreq-epss
           - const: qcom,cpufreq-epss
 
-  reg:
-    minItems: 2
-    maxItems: 3
-    items:
-      - description: Frequency domain 0 register region
-      - description: Frequency domain 1 register region
-      - description: Frequency domain 2 register region
+  reg: {}
 
-  reg-names:
-    minItems: 2
-    maxItems: 3
-    items:
-      - const: freq-domain0
-      - const: freq-domain1
-      - const: freq-domain2
+  reg-names: {}
 
   clocks:
     items:
@@ -57,6 +49,52 @@ properties:
   '#freq-domain-cells':
     const: 1
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: qcom,cpufreq-hw-8998
+then:
+  properties:
+    reg:
+      minItems: 2
+      maxItems: 6
+      items:
+        - description: Frequency domain 0 register region
+        - description: Operating State Manager domain 0 register region
+        - description: Frequency domain 1 register region
+        - description: Operating State Manager domain 1 register region
+        - description: PLL ACD domain 0 register region (if ACD programming required)
+        - description: PLL ACD domain 1 register region (if ACD programming required)
+
+    reg-names:
+      minItems: 2
+      maxItems: 6
+      items:
+        - const: "osm-domain0"
+        - const: "freq-domain0"
+        - const: "osm-domain1"
+        - const: "freq-domain1"
+        - const: "osm-acd0"
+        - const: "osm-acd1"
+
+else:
+  properties:
+    reg:
+      minItems: 2
+      maxItems: 3
+      items:
+        - description: Frequency domain 0 register region
+        - description: Frequency domain 1 register region
+        - description: Frequency domain 2 register region
+    reg-names:
+      minItems: 2
+      maxItems: 3
+      items:
+        - const: "freq-domain0"
+        - const: "freq-domain1"
+        - const: "freq-domain2"
+
 required:
   - compatible
   - reg
-- 
2.30.0

