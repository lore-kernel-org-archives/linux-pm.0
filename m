Return-Path: <SRS0=WgFL=EK=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B307C388F9
	for <linux-pm@archiver.kernel.org>; Wed,  4 Nov 2020 16:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FE7A21734
	for <linux-pm@archiver.kernel.org>; Wed,  4 Nov 2020 16:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t+6XmamO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbgKDQtp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731450AbgKDQtn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:43 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 931CBC061A4A;
        Wed,  4 Nov 2020 08:49:42 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id h6so28020936lfj.3;
        Wed, 04 Nov 2020 08:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=13zJHfR9di8Ydxi+LOybO5H+JCALzXt2g6wK8WiSzjg=;
        b=t+6XmamOufud85gfyMGuCbFRnXH/pka7+DXkYhQq3VCFFSEvuLsvT/RYOOG2zit/v+
         DH/OLrTipaYalni61+oeoO3/7u84O5R5Phy9YzK2RevmSVcp2gnlyfZfAhm7h4/ZH8cd
         7DpxAk2by+O/uw6YAq8CfQYoCdQ7umQiL8Zzf+xuUMXXYMUpTKZDso8ez+UT2MVdbbr7
         7piRmA6pTCTWJxwwNiFAWxGPBZWfbwBU6mCWoo+b06xnj05+hqgiklRggG3uEah/2aqz
         Rj0ADEcNQAJ2XRayKBWGOhvMriNvkkapI1ud+5e1wQ/jr0Lcs3IUVjwrTb6+uaBT2JZX
         Ee7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=13zJHfR9di8Ydxi+LOybO5H+JCALzXt2g6wK8WiSzjg=;
        b=N6B3U7WJVyNngfChmQzjO3jM8Wtz+28ZWf/7bvlqj8FS37ygsbNETbfMKFJRJrbkKw
         2IXtRAFjeL91IcUG2DolbNkj/hDcNNbhJwbeWQUCKJC2H2250fB4PUtn7e6u7IyPT3yA
         D69S4rJtO9rbySB0k/qM6htqZ9cpHd7pO79HTmnOf1oeIZl/TSsK/OhBTlDMTucWXWkM
         ygS0dJoX69SIr+2DoqEV6ZsCCm8cHuD4YoQnncwqnNInkXpOHbGpun/ckc8qoXTeUvfX
         fcv5aRIjo675AyAza8fvNRV5F1LBF1GYikIy1a2Y6E6MYsfdRQ725bB+oghDiKHCg5QQ
         bvow==
X-Gm-Message-State: AOAM531GPv9T0QSkJK1WMleNtK28lNjoYBKEFa5sKxIy3vGELrl+doEg
        T5CFq1hA73r/SGgLK0LvcAQ=
X-Google-Smtp-Source: ABdhPJx3MXf1ifZHHtSGhKEXSuUOoWS5aH6HQ2rKgpVEkQPSr1h0IPaDi1gyerE0+/GxhDL58Mu8tQ==
X-Received: by 2002:ac2:592f:: with SMTP id v15mr6582641lfi.512.1604508581136;
        Wed, 04 Nov 2020 08:49:41 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:40 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v7 09/47] dt-bindings: memory: tegra30: mc: Document new interconnect property
Date:   Wed,  4 Nov 2020 19:48:45 +0300
Message-Id: <20201104164923.21238-10-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
External Memory Controller. Document new interconnect property which
turns memory controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra30-mc.yaml       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
index 84fd57bcf0dc..5436e6d420bc 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra30-mc.yaml
@@ -57,6 +57,9 @@ properties:
   "#iommu-cells":
     const: 1
 
+  "#interconnect-cells":
+    const: 1
+
 patternProperties:
   "^emc-timings-[0-9]+$":
     type: object
@@ -120,6 +123,7 @@ required:
   - clock-names
   - "#reset-cells"
   - "#iommu-cells"
+  - "#interconnect-cells"
 
 additionalProperties: false
 
@@ -135,6 +139,7 @@ examples:
 
         #iommu-cells = <1>;
         #reset-cells = <1>;
+        #interconnect-cells = <1>;
 
         emc-timings-1 {
             nvidia,ram-code = <1>;
-- 
2.27.0

