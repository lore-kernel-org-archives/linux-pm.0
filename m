Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5A2C47080
	for <linux-pm@archiver.kernel.org>; Tue,  1 Jun 2021 02:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53050600D1
	for <linux-pm@archiver.kernel.org>; Tue,  1 Jun 2021 02:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhFAC0C (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 31 May 2021 22:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbhFAC0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 22:26:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D286BC061756;
        Mon, 31 May 2021 19:24:18 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id w33so19321110lfu.7;
        Mon, 31 May 2021 19:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S8vIWLZExfHwrllytUl82llWvNAE8jr59cb6GfsI/sc=;
        b=QSQnS6orgEeE0FakSD3AuyPbB6t71SGC8B6DmuVyXAaqHvFPnfA61rHTHdeGOACVV+
         Gj8iQsUoobaERXTkS0Oqk3Ajl5KW+DeeoVNS5jc/7nMM3UyftsNiejYDuyGbjDXMhJub
         Hh0OM85BCiswJUgO089I5HEu8hip48ZEbGp8LRQjJQ/uQSkV1tFz98SqvSEuNsGje5S1
         +5SxCRz2LwgqlI9NKprA488yl5HkwwHPNLxJPG45QXFcdZm6ZAVPeVItDVEUb6GpPx2N
         cAkNmW1QpVXEvFmSJsYU/yzuFV6S0mrWytzWs1gXg/ObtJB+QvQbdzgNye2vUD/tEDwN
         rByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8vIWLZExfHwrllytUl82llWvNAE8jr59cb6GfsI/sc=;
        b=VdH/s/6++xLffc3YYKDXawEPt0a3B4mGOA+rX7JpygXkYjIy3BvUliHBzGD6yEo+GP
         3b9XrBwBZTBZKkAIeJiwXe8/iwtObyDInNxrzNEjvpv1qXJmIam/fg7D6qsWndkamt8I
         mhJdA5gXWtG59f9Ymqhb6ft98lgVjHOn4Cehldv0GnTK9/KT9h5GEn0T5wtlnkmrvHgu
         E8M9I4IwzaMlWEEjWLqzjpE1+x5jWpszEGHJH17W7hWrfuJdB9HTJN5i4x40SiZrqkx+
         o3JsSM4fJ5XbW1YrYHgnvJ1MuAzaE0zEJBpQ57q2bsLXE8b1/rigb2NmbzA5djLm9btp
         K1qA==
X-Gm-Message-State: AOAM531GGTz7sOkB8JiB93eQ4uMDxjJ5av1/XqIOmF298ASKKLtc6QJC
        U33Zwy+8p3CEAqgI/L1f9vw=
X-Google-Smtp-Source: ABdhPJxRLTcWUI3a6c18u1QZHb9K/WBQdeqCJeZdWlIhkYUEqu7MTo2564bXnCUcAAl/UL58GLyAxA==
X-Received: by 2002:a19:8545:: with SMTP id h66mr5007771lfd.64.1622514257124;
        Mon, 31 May 2021 19:24:17 -0700 (PDT)
Received: from localhost.localdomain (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.gmail.com with ESMTPSA id g34sm1524207lfv.59.2021.05.31.19.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:24:16 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] dt-bindings: devfreq: tegra30-actmon: Add cooling-cells
Date:   Tue,  1 Jun 2021 05:23:19 +0300
Message-Id: <20210601022319.17938-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210601022319.17938-1-digetx@gmail.com>
References: <20210601022319.17938-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The ACTMON watches activity of memory clients. Decisions about a minimum
required frequency are made based on the info from ACTMON. We can use
ACTMON as a thermal cooling device by limiting the required frequency.
Document new cooling-cells property of NVIDIA Tegra ACTMON hardware unit.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml   | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
index ba938eed28ee..e3379d106728 100644
--- a/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
+++ b/Documentation/devicetree/bindings/devfreq/nvidia,tegra30-actmon.yaml
@@ -63,6 +63,9 @@ properties:
       Should contain freqs and voltages and opp-supported-hw property, which
       is a bitfield indicating SoC speedo ID mask.
 
+  "#cooling-cells":
+    const: 2
+
 required:
   - compatible
   - reg
@@ -74,6 +77,7 @@ required:
   - interconnects
   - interconnect-names
   - operating-points-v2
+  - "#cooling-cells"
 
 additionalProperties: false
 
@@ -118,4 +122,5 @@ examples:
         operating-points-v2 = <&dvfs_opp_table>;
         interconnects = <&mc TEGRA30_MC_MPCORER &emc>;
         interconnect-names = "cpu-read";
+        #cooling-cells = <2>;
     };
-- 
2.30.2

