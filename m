Return-Path: <SRS0=qxav=BY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A1DC433E1
	for <linux-pm@archiver.kernel.org>; Fri, 14 Aug 2020 00:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805CE2078B
	for <linux-pm@archiver.kernel.org>; Fri, 14 Aug 2020 00:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HOT+B89K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHNAHX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 13 Aug 2020 20:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgHNAHX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 20:07:23 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03D8C061757;
        Thu, 13 Aug 2020 17:07:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i80so3925181lfi.13;
        Thu, 13 Aug 2020 17:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nMtVCA/+W3wZ2Mh397uGPjY2K7aozwFY+OdCulsbZKY=;
        b=HOT+B89KfZEhp40OvFSrg3vNw3Hm3bICpJH0SAvreADpTu2pg4jXv2YvjJ1wLkp2P6
         yWA6+9wlj34AW5CjCekuXdCkl/15MGl4iEcaWB7n/XfOJ5VxcXAQmBj7dQltMIUh9it5
         TV2WV47UuD4xu89RIgrr4+Fbs0pcTFBgs0ryCOPAThtFW7yFYVYBs3ty9efal3a3A6tE
         O+JYPc3ma4MD5xou6ha7fVkjyqpU4l94e35VbUmS6IInluT0LgEQN7qYzq7vp8QC0CMI
         9wRzaLo8FP0NNC7Fe7fv1dRreUrHiapQta7l7GKAxGb0K9FOzK/5fJgGVm1qyrnVyFZs
         6WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nMtVCA/+W3wZ2Mh397uGPjY2K7aozwFY+OdCulsbZKY=;
        b=ZkhEWkaIaham3sUvG+Oz/uMDHNSokZUvJPepO0aiM3dyANwO3jLAQtYmyp5fLtvBGV
         U/Pwza5lPuZGZZp5k/jweeP1XY1sIIQfhav3uL9BCzk6/RgJNFfq/mpC8zYFQJpheqqB
         ggT2S5ngTUEvoeOKes13u6CIM4D4/4nHxxnJapkQwQfBODFoaYPFiHYYS2xeLzSpv0l+
         AeNaIERZEg9a1GlUbGDwe7P5bvwX0hFTURluntlMwAIIX40iCugkrM7KXT6vE6TtexjO
         uzHLQx+XCFE0xoKRXSD7HDkq0oYq0WiD6INRAXjwK62FbfZYaU2PYKhrNbqF0HZ3FFFm
         iOxA==
X-Gm-Message-State: AOAM5309VJ1G7fUSAnedKXCG9ih+h7WQuI/nu1oNf7n+f55nlmUfMmpk
        mZMHUKt90O0Hs08JxxrQ2Gc=
X-Google-Smtp-Source: ABdhPJxuSGGaGXcbC5IRQAu/n2OBRrEBSbs1XGbbyQXsUdDGOM8hvqUGx3Hz5n/nXH8LznMpybJddw==
X-Received: by 2002:a05:6512:330c:: with SMTP id k12mr3278745lfe.151.1597363641309;
        Thu, 13 Aug 2020 17:07:21 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id c17sm1504450lfr.23.2020.08.13.17.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 17:07:20 -0700 (PDT)
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
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v5 18/36] dt-bindings: memory: tegra20: mc: Document new interconnect property
Date:   Fri, 14 Aug 2020 03:06:03 +0300
Message-Id: <20200814000621.8415-19-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200814000621.8415-1-digetx@gmail.com>
References: <20200814000621.8415-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory controller is interconnected with memory clients and with the
external memory controller. Document new interconnect property which
turns memory controller into interconnect provider.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/memory-controllers/nvidia,tegra20-mc.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
index e55328237df4..739b7c6f2e26 100644
--- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
+++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra20-mc.txt
@@ -16,6 +16,8 @@ Required properties:
   IOMMU specifier needed to encode an address. GART supports only a single
   address space that is shared by all devices, therefore no additional
   information needed for the address encoding.
+- #interconnect-cells : Should be 1. This cell represents memory client.
+  The assignments may be found in header file <dt-bindings/memory/tegra20-mc.h>.
 
 Example:
 	mc: memory-controller@7000f000 {
@@ -27,6 +29,7 @@ Example:
 		interrupts = <GIC_SPI 77 0x04>;
 		#reset-cells = <1>;
 		#iommu-cells = <0>;
+		#interconnect-cells = <1>;
 	};
 
 	video-codec@6001a000 {
-- 
2.27.0

