Return-Path: <SRS0=E9iA=3A=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80207C3F68F
	for <linux-pm@archiver.kernel.org>; Sat, 11 Jan 2020 16:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6076F2082E
	for <linux-pm@archiver.kernel.org>; Sat, 11 Jan 2020 16:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgAKQQQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 11 Jan 2020 11:16:16 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:46109 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730319AbgAKQQQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 11 Jan 2020 11:16:16 -0500
Received: from localhost.localdomain ([37.4.249.154]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMWcT-1j9DUG0YRr-00JcDG; Sat, 11 Jan 2020 17:15:51 +0100
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V4 1/4] dt-bindings: Add Broadcom AVS RO thermal
Date:   Sat, 11 Jan 2020 17:15:39 +0100
Message-Id: <1578759342-4550-2-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
References: <1578759342-4550-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:c1+Mg9NKoWCLsN8E1wZaMxrh5a2EHZsNfpj80gj1+uD4c7oIiwg
 B3VvaHwXDziW/0JZNSoLmcZX8rLv0yBvdngyCtKwW1gYSC5Tb2b7wF6GswrAYW9I+WHKu/o
 LTaFSb+hdE937/T5VA55+bpUm7bMwoXxhCnwMuCcO7Kvivv9lh/LFNaaELpESpgXuR7c5Od
 yOjaNwupb1GP1TMr/Lp0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bDV4gChWJ6A=:zVDMyHIm0wg/sFXJsxBFfg
 vngWYXC+y1Ggagzjk+77JYoa5b8mlaU7s3yQysh/DUcYDchjc2QE+oKBV2X/cMebilELriIOu
 GhmEp0SQpix3GArGJMKuMqF1IxCI15L9gjDGX/RNoJVqFqxqgGOs647EWR1TAcGe12Xl/UFzF
 yQQ3cDZ/IbLfKTKf3FUm27gVfsJFK+as6TGliiefFdHgdRg2HE4hklN4EPR3EFivwP8bpboNc
 3ZvgkRDm7duKqdiWFQSZ1zB6e0WeTBhbrJ9UZaT6D7af6Bu/U6072B+qAUgA+2w0h1zJUppqH
 Hr8vvVFWdZo3nyqjZ+qiB6EJ8QkkeU9rCxBlxU7ZjF9IInhJBOamwjbNAudlesivbMfVy0jzz
 a+JlGtygizahGncvqBM+hLVuYgPeMvUBieneXCq24uAVJEFch9oUeUn3bEulqZ0Sj/2gRFe63
 wqRPYahB1wAEch+A/wKcVMj7y37TTMtvm0A84VT9UnkEE56//NhE5gL7BUmA7m2MfABMb4aVg
 vKkjETfAuqYxj0A2yh6+v5cOyztnjBG/zt8+/eryT11h91mPcDtd5ltWmSuhVeqomXNIjaDIJ
 JxoEgCFbd/fAHqE/tczrz0Of38IQjktzXm96FpwwLa8u8hKjLBcf6oYjOJv5sNgbDoZBHu7YR
 1Gvjse1+vdz6hef6XU/FO/D3xqp+taSVj9IUZIOsV1lGBaeVUcI1zVA1quOEhVza36sLDPamj
 xGoaGYGp0FYhbEdG3ZlTLzHLtZM8N0nE5YZ0cunW8Yv5NPSCTwZ0oBp6hnT6Y1eeBAyM+K+7W
 apIiRHo9Vaa68SxMS4JXRGizA4wnUmXXPxX0Jbo4/0YDzMSDHc+JBLFeDxKTbgmlLlAY5+4en
 QmlpyU4MCCmOIQr/pmA6q3/sIYrU2c0p6DC4rPrwA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since the BCM2711 doesn't have a AVS TMON block, the thermal information
must be retrieved from the AVS ring oscillator block. This block is part
of the AVS monitor which contains a bunch of raw sensors.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../bindings/thermal/brcm,avs-ro-thermal.yaml      | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
new file mode 100644
index 0000000..98e7b57
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/brcm,avs-ro-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom AVS ring oscillator thermal
+
+maintainers:
+  - Stefan Wahren <wahrenst@gmx.net>
+
+description: |+
+  The thermal node should be the child of a syscon node with the
+  required property:
+
+  - compatible: Should be one of the following:
+                "brcm,bcm2711-avs-monitor", "syscon", "simple-mfd"
+
+  Refer to the the bindings described in
+  Documentation/devicetree/bindings/mfd/syscon.txt
+
+properties:
+  compatible:
+    const: brcm,bcm2711-thermal
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+        avs-monitor@7d5d2000 {
+                compatible = "brcm,bcm2711-avs-monitor",
+                             "syscon", "simple-mfd";
+                reg = <0x7d5d2000 0xf00>;
+
+                thermal: thermal {
+                        compatible = "brcm,bcm2711-thermal";
+                        #thermal-sensor-cells = <0>;
+                };
+        };
+...
-- 
2.7.4

