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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAE4C55179
	for <linux-pm@archiver.kernel.org>; Wed,  4 Nov 2020 16:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C23BA20825
	for <linux-pm@archiver.kernel.org>; Wed,  4 Nov 2020 16:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z3dfOO9E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgKDQyG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 4 Nov 2020 11:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731410AbgKDQtf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 4 Nov 2020 11:49:35 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69439C0613D3;
        Wed,  4 Nov 2020 08:49:35 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id l10so2703762lji.4;
        Wed, 04 Nov 2020 08:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IBTRolvU8VaL1YCS6g8sUoNhiFnnAzkyMcEZUpaHxEY=;
        b=Z3dfOO9Ea67OkV3Tijv2exUT2/K+vtzBmZ+Qq6hq+aUqPd2GsIld85fQT4TYOsJHdK
         2oHvop136sQLhZQmE3qBcPPDnS7rO2aUjQ9VEICgfr/nAoP5Xgno0Tf5ngbXHWiVC4IC
         PaLvpuCLguhxRDdZChNb/rfXoSPK3pvSgcIcF7rTzqp8WPv3nJtZ6Y7sXmV6y7iJpIRM
         YqEQ3gtyJJRkMJpy3rX+YTuSU5F+V2ci/heIYH0Kr99ihQPiicNqiAzHRccWwQGbD1eX
         fm+BH8Jr/YkmlVriAd9EUHq/aNgE9KUL4zXMOACUfJ5Lk7yWtXGQTCP/niLv1H6HZQn0
         W0cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IBTRolvU8VaL1YCS6g8sUoNhiFnnAzkyMcEZUpaHxEY=;
        b=oHzR8qjMpRBq9i0DsL+Sj0seNmbhoqA7uKTgB9Rh2Rau2fPOgoDEl3E7VIZXQJU7wZ
         6FDZi+fyTYvZN6l4NYwbPlryWHN5uNnPOdvAEdhJ4IK8OOJNYGsC354KLAu0b76DVDSQ
         208db6B3ua9trCyPbu8rri81hrzkDhNESXu+cud5R4BmytPSH9w2S7vBPQkD4UzXugOJ
         X2h2UpKxkzoU4RpYM5o15PKh9fb96g+bqyMXpL8MNSdPRFIKYpKw84yl5YTZ7NOGlkvA
         7yeSw4XS+p+2e0pMMR51PTrQdD2SS2qCz6vixYDodRjlve9YFj1HLIuSqdE2rJjakKSp
         sD6Q==
X-Gm-Message-State: AOAM531TSRGbVqRSWX1td6wkSFMy2JtjWpIlzITt9xDmqxtVf2YHzDWr
        6tbFIlhJKWT+YwLAW+MCyXI=
X-Google-Smtp-Source: ABdhPJzPhfeNNf/JRh3qD+lncCpacw7ow+jldI3XtQ0mIJlcrmMGEaMXoZJl/n41aHF5th0Rj3O0Mg==
X-Received: by 2002:a2e:854c:: with SMTP id u12mr7699503ljj.297.1604508573970;
        Wed, 04 Nov 2020 08:49:33 -0800 (PST)
Received: from localhost.localdomain (109-252-192-83.dynamic.spd-mgts.ru. [109.252.192.83])
        by smtp.gmail.com with ESMTPSA id m2sm454587lfo.25.2020.11.04.08.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:49:33 -0800 (PST)
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
Subject: [PATCH v7 03/47] soc/tegra: fuse: Add stub for tegra_sku_info
Date:   Wed,  4 Nov 2020 19:48:39 +0300
Message-Id: <20201104164923.21238-4-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201104164923.21238-1-digetx@gmail.com>
References: <20201104164923.21238-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drivers that use tegra_sku_info and have COMPILE_TEST are failing to be
build due to the missing stub for tegra_sku_info, thus add the missing
stub.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 include/soc/tegra/fuse.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/soc/tegra/fuse.h b/include/soc/tegra/fuse.h
index c702bd2911bc..78cbc787a4dc 100644
--- a/include/soc/tegra/fuse.h
+++ b/include/soc/tegra/fuse.h
@@ -56,7 +56,11 @@ u32 tegra_read_straps(void);
 u32 tegra_read_ram_code(void);
 int tegra_fuse_readl(unsigned long offset, u32 *value);
 
+#ifdef CONFIG_ARCH_TEGRA
 extern struct tegra_sku_info tegra_sku_info;
+#else
+static struct tegra_sku_info tegra_sku_info __maybe_unused;
+#endif
 
 struct device *tegra_soc_device_register(void);
 
-- 
2.27.0

