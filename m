Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838ECC4332E
	for <linux-pm@archiver.kernel.org>; Mon, 28 Dec 2020 16:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BE5B207C9
	for <linux-pm@archiver.kernel.org>; Mon, 28 Dec 2020 16:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393447AbgL1QG6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 28 Dec 2020 11:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393359AbgL1QG4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Dec 2020 11:06:56 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232AEC06179B;
        Mon, 28 Dec 2020 08:06:06 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id y19so24749110lfa.13;
        Mon, 28 Dec 2020 08:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPhbBtY24leD6EYjNk4lZTpgtDU5k3awjWfX3kBti/E=;
        b=hZlmdwIEtYVMxAah4R51EStHa7MVaz+0z4ZF5K2G6/5MgA6VvXfJKylmJcduM8SSTy
         6+oUt41T4RXwxJJrok0QcbTYhZC+knZkve31rOYCzEKW0Qc/mOv0sANohnWOMivjQvCu
         ia2PwSyu3jENcjZnEkmlArjPS1BdVd1mqWSscLTQrwFLEena10X4Rx3cooheayc+MHxT
         nvt/ViHIWzjtLAm56lpCcXXAElZUcmq1mbJJ2W4NIiYikV8uaFyZPsdzDEcMYEC0fANU
         HvAeChTuPzI+mx4NePulkVpFEX//SpoJYnmBYkZsZM+3fPQCBeuOd8SAze2AvT4qMEyX
         xLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPhbBtY24leD6EYjNk4lZTpgtDU5k3awjWfX3kBti/E=;
        b=B4jcbPA9PtSl6MyKzGxd/jpebQRjokgaHA/KCky3zVpoOonXbvO2Y7n8JkrgQ3OOVb
         TKTeP+C7HcpFWuUuq5xtOjmmpMzSnTEx1kGaTjEIHFNxpOZcez+Y2uy13UChPg35wiUt
         PrDqRN7nRmyvwluh0JfSpQL9io+YZ26RIpQOBXs879oTLlW/EQY1xAeJk6vhwwrPxGcM
         /Blbz37+BABgO6I4aEh9Sl9VkbbzJf39KDSGBHLZQvOjBqj9cZRSyxqQoqZxVE6PHNAI
         Guve6NNE/dnhf+IgT59QOFDUlGKDJTHVQ27j+jRgJZWzhL73XLmwiS0N413lmQTnyyx1
         NCnQ==
X-Gm-Message-State: AOAM5320YYgamwSTaPOthx4T/6Jb8I7v48vUgvIfOfr/s+OqHJahP7X3
        ZMdybKD2C1peXW2FmCUfacE=
X-Google-Smtp-Source: ABdhPJzc5hbC46eyt5/uSQFTJBsDdbXDw/FqdkedIy3IoUxH0F+OZmWY0ntAqDqvcQMbDXb4MC/u/Q==
X-Received: by 2002:a2e:920b:: with SMTP id k11mr21283230ljg.313.1609171564697;
        Mon, 28 Dec 2020 08:06:04 -0800 (PST)
Received: from localhost.localdomain (109-252-192-57.dynamic.spd-mgts.ru. [109.252.192.57])
        by smtp.gmail.com with ESMTPSA id v28sm5338837lfd.57.2020.12.28.08.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:06:04 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dan Murphy <dmurphy@ti.com>, Sebastian Reichel <sre@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 1/3] dt-bindings: mfd: Add ENE KB930 Embedded Controller binding
Date:   Mon, 28 Dec 2020 19:05:45 +0300
Message-Id: <20201228160547.30562-2-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228160547.30562-1-digetx@gmail.com>
References: <20201228160547.30562-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add binding document for the ENE KB930 Embedded Controller.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/mfd/ene-kb930.yaml    | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/ene-kb930.yaml

diff --git a/Documentation/devicetree/bindings/mfd/ene-kb930.yaml b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
new file mode 100644
index 000000000000..06ed9ec8f4bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/ene-kb930.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mfd/ene-kb930.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ENE KB930 Embedded Controller bindings
+
+description: |
+  This binding describes the ENE KB930 Embedded Controller attached to an
+  I2C bus.
+
+maintainers:
+  - Dmitry Osipenko <digetx@gmail.com>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - acer,a500-iconia-ec # Acer A500 Iconia tablet device
+      - const: ene,kb930
+  reg:
+    maxItems: 1
+
+  monitored-battery: true
+  power-supplies: true
+  system-power-controller: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    battery: battery-cell {
+      compatible = "simple-battery";
+      charge-full-design-microamp-hours = <3260000>;
+      energy-full-design-microwatt-hours = <24000000>;
+      operating-range-celsius = <0 40>;
+    };
+
+    mains: ac-adapter {
+      compatible = "gpio-charger";
+      charger-type = "mains";
+      gpios = <&gpio 125 0>;
+    };
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      embedded-controller@58 {
+        compatible = "acer,a500-iconia-ec", "ene,kb930";
+        reg = <0x58>;
+
+        system-power-controller;
+
+        monitored-battery = <&battery>;
+        power-supplies = <&mains>;
+      };
+    };
+
+...
-- 
2.29.2

