Return-Path: <SRS0=NrZp=EA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C1EC5DF9E
	for <linux-pm@archiver.kernel.org>; Sun, 25 Oct 2020 22:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D511C222D9
	for <linux-pm@archiver.kernel.org>; Sun, 25 Oct 2020 22:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3+RAmcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418789AbgJYWUo (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 25 Oct 2020 18:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1419373AbgJYWSr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 18:18:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB6C0613D0;
        Sun, 25 Oct 2020 15:18:46 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h20so7722053lji.9;
        Sun, 25 Oct 2020 15:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zP8wlyQsrquUXl8RVAlWCiQmUgoZ1Odmn7sqJkdmIO4=;
        b=M3+RAmcuQgmuqGWbrQzhYMev5R7cBfQeEh8ZhJaPmZnvlCc2L8LNcmcI96FHgaooG8
         cqQfqY+faXiwP641RsFaoLRXKklHvqLaBqVAudP3wHQ0tLR53cwxQR7yuDsYqyLS7Yfg
         4uLrBNL+8ckoP+VKXICnwNTzx62mHT5JOYzFUOuK6GZn6QUX/F4mJX+eVmzHVpQHrh3Q
         CQsos3a36qo7UnhL3VvPpErYDDfbYY/fqclctOYt2icC8fGc+3C7FNpN1b9PFYUjZrRc
         DXbg2WBTb4+ueJkTUqt1GsfuuZvpiqo9dxw3Oht4PVyxcvUspfD4/EHM/ZLPRTsLw4V+
         rC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zP8wlyQsrquUXl8RVAlWCiQmUgoZ1Odmn7sqJkdmIO4=;
        b=PT7Io1TtUq9qVwis2TdteQyQb8VCdZOUG21jAcqXzibjLBeEwPsPXtXEJAmjIbSoC9
         7TaLslA/fKdUEf79AigPwRlBdRXnGbHTESJUlQrdeBNc3kM7eEDenvr0MLhz/lqZdbYq
         rOoyaIFSpVdRDQNoDeGXSLiy/NFqMDF/JbC8NFjo7VBfWjltyUK9HpHfe/OTKQV8Z6Y7
         pgcfFfVvgzahW0yqnVfxPB3pi0PRjGIwsfUppoxYi/oIqGljQb1aoM/pNC3Gom8KLD+c
         gR98tW35enrgkf2eo/vYphc0vA6FuqRziQOl4EAIH7vlB3c/N2HbA0TcJgemi/PGbiSM
         xbjQ==
X-Gm-Message-State: AOAM532gLoSdPg8cz59gR1Yu1ubcFoXw1+jR5NpWxnUlTeK/7+vxj7ux
        WOPfXWCu1YnleT3cCn0SoKw=
X-Google-Smtp-Source: ABdhPJy6sbcs2N3lwS6ML6IijCJ0oltQjJb0Jguca6wgzN/W0MEsKCoGmeLzWKNxYggf+7kIleLYrQ==
X-Received: by 2002:a05:651c:1343:: with SMTP id j3mr4297239ljb.336.1603664325229;
        Sun, 25 Oct 2020 15:18:45 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.gmail.com with ESMTPSA id k13sm932423ljh.136.2020.10.25.15.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 15:18:44 -0700 (PDT)
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
Subject: [PATCH v6 50/52] PM / devfreq: tegra30: Silence deferred probe error
Date:   Mon, 26 Oct 2020 01:17:33 +0300
Message-Id: <20201025221735.3062-51-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201025221735.3062-1-digetx@gmail.com>
References: <20201025221735.3062-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Tegra EMC driver was turned into a regular kernel driver, meaning that it
could be compiled as a loadable kernel module now. Hence EMC clock isn't
guaranteed to be available and clk_get("emc") may return -EPROBE_DEFER.
Let's silence the deferred probe error.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra30-devfreq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index f5e74c2ede85..3f732ab53573 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -801,10 +801,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	}
 
 	tegra->emc_clock = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(tegra->emc_clock)) {
-		dev_err(&pdev->dev, "Failed to get emc clock\n");
-		return PTR_ERR(tegra->emc_clock);
-	}
+	if (IS_ERR(tegra->emc_clock))
+		return dev_err_probe(&pdev->dev, PTR_ERR(tegra->emc_clock),
+				     "Failed to get emc clock\n");
 
 	err = platform_get_irq(pdev, 0);
 	if (err < 0)
-- 
2.27.0

