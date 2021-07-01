Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E262DC11F73
	for <linux-pm@archiver.kernel.org>; Thu,  1 Jul 2021 10:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52A961490
	for <linux-pm@archiver.kernel.org>; Thu,  1 Jul 2021 10:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbhGALAP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 1 Jul 2021 07:00:15 -0400
Received: from relay06.th.seeweb.it ([5.144.164.167]:35843 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236194AbhGALAN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Jul 2021 07:00:13 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id C7CB13F640;
        Thu,  1 Jul 2021 12:57:39 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     viresh.kumar@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        amit.kucheria@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jami.kettunen@somainline.org,
        paul.bouchara@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, jeffrey.l.hugo@gmail.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v6 8/9] dt-bindings: cpufreq: qcom-hw: Add bindings for 8998
Date:   Thu,  1 Jul 2021 12:57:29 +0200
Message-Id: <20210701105730.322718-9-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
References: <20210701105730.322718-1-angelogioacchino.delregno@somainline.org>
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
 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 67 ++++++++++++++-----
 1 file changed, 52 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index bc81b6203e27..29b663321a0b 100644
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
@@ -57,10 +49,55 @@ properties:
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
-  - reg-names
   - clocks
   - clock-names
   - '#freq-domain-cells'
-- 
2.32.0

