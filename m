Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12653C6379D
	for <linux-pm@archiver.kernel.org>; Fri, 27 Nov 2020 08:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A545A2224D
	for <linux-pm@archiver.kernel.org>; Fri, 27 Nov 2020 08:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXBHA5e3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgK0IfV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 27 Nov 2020 03:35:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728017AbgK0IfV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 Nov 2020 03:35:21 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1973DC0613D1;
        Fri, 27 Nov 2020 00:35:21 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id s63so3771019pgc.8;
        Fri, 27 Nov 2020 00:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a3VAIRA2LGMAvBhYowdILZiygTrfDzo45x8iVvF1lfs=;
        b=gXBHA5e3A0zZzIWR0PmTN1Gxg5qFUTth5rEDmYB7pMuV1UR8+ThiPssM3FM2qMH3bA
         Pxob1gwSP+3jrgAJwQ9htuMR5vBLuGQxdyNORnne2t12s4k8KmVPBuHK3bG4i4327f+Z
         tJH7G7PFEvw+YDQLQgWKey/S6OKGmmbADtSO6l0RhhTxnO+wdD3kDYqfpeZoU5XufdNr
         BSjR0VLwZyDTNgHnNjsa8c4TMSYhftPeYj4rNsMibuhfY5qoF2RqVpRECSgB/4YJfyBK
         FZFDsY38XqZQZWkGEzzgmkBuby6NOg+ovQ95xjYbP8+98VYoU4Uj/q4nTrPoUWyBXAEo
         akTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a3VAIRA2LGMAvBhYowdILZiygTrfDzo45x8iVvF1lfs=;
        b=SRQ0/dAojQTjP4qLw2HIkMSfFUmmW5agQWeSM2VJd0lTuFsejwP+UIPFsPT6BsuX6u
         qB+P4NR7zUtHAIGDrjVaWU/GEGjBdhI/VFBlRhO5yOHsqJSJDcl1IVAdSWZBiBtENDJu
         kz2bZKBPqwKmb+lvcmmzwzTPxSYQiGkVFgqkzIFo9TK+1EmngLAuz8SBS7rrb/R7o6Ip
         AUfix1AdiMasHMbSZGo3LTgGAevHrKZKXMr4IzGSJEje/urvT/g+Du3kmjrLSfKzc/dk
         c+6iMLGPPzqnCXV76Dkb/fNh/9LCSyVo7xk3eL83VdinSkUEej6fiGCOj3dS8rm4cJ4K
         cxwg==
X-Gm-Message-State: AOAM5326Zt6GgKUXK0ehVLx4Xvhxh/NZ4sFl0YvKG9b38K37tjDPWHAJ
        STZ691Xr3/MV9ODdFnjPN/Q=
X-Google-Smtp-Source: ABdhPJxnX6uQm+jK26r1gkYCvkl0oWT6BKFx6quoyaaF5wvnNBd8sHNdHkfmZxRgQ5CDd38Uor5CjA==
X-Received: by 2002:a05:6a00:c:b029:18b:eae3:bff0 with SMTP id h12-20020a056a00000cb029018beae3bff0mr6175775pfk.9.1606466120714;
        Fri, 27 Nov 2020 00:35:20 -0800 (PST)
Received: from bj04432pcu2.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i3sm1727283pgq.12.2020.11.27.00.35.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Nov 2020 00:35:20 -0800 (PST)
From:   gao.yunxiao6@gmail.com
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org,
        robh+dt@kernel.org, javi.merino@kernel.org
Cc:     linux-pm@vger.kernel.org, kernel-team@android.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        "jeson.gao" <jeson.gao@unisoc.com>
Subject: [RFC 1/2] dt-bindings: thermal: sprd: Add virtual thermal documentation
Date:   Fri, 27 Nov 2020 16:35:12 +0800
Message-Id: <1606466112-31584-1-git-send-email-gao.yunxiao6@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: "jeson.gao" <jeson.gao@unisoc.com>

virtual thermal node definition description in dts file

Signed-off-by: jeson.gao <jeson.gao@unisoc.com>
---
 .../thermal/sprd-virtual-thermal.yaml         | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.yaml b/Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.yaml
new file mode 100644
index 000000000000..3e3d2282e2a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/sprd-virtual-thermal.yaml
@@ -0,0 +1,38 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/sprd-virtual-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Spreadtrum virtual thermal driver bindings
+
+maintainers:
+  - Yunxiao Gao <gao.yunxiao6@gmail.com>
+
+properties:
+  compatible:
+    const: sprd,virtual-thermal
+
+  reg:
+    description: specify the virtual sensor id.
+    maxItems: 1
+
+  thmzone-names:
+    description: specify per-core thermal zone name.
+
+required:
+  - compatible
+  - reg
+  - thmzone-names
+
+additionalProperties: false
+
+examples:
+  - |
+    virtual_sensor: virtual-sensor@1 {
+      compatible = "sprd,virtual-thermal";
+      reg = <1>;
+      thmzone-names = "ank0-thmzone","ank1-thmzone","ank2-thmzone",
+                      "ank3-thmzone","ank4-thmzone","ank5-thmzone","prometheus6-tzone0",
+                      "prometheus6-tzone1","prometheus7-thmzone";
+    };
-- 
2.28.0

