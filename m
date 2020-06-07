Return-Path: <SRS0=imOP=7U=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83F0C433DF
	for <linux-pm@archiver.kernel.org>; Sun,  7 Jun 2020 19:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 826642067B
	for <linux-pm@archiver.kernel.org>; Sun,  7 Jun 2020 19:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k56xqon4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgFGS5S (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFGS5Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:16 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D70C061A0E;
        Sun,  7 Jun 2020 11:57:16 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so17747665ljc.8;
        Sun, 07 Jun 2020 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFrdABztThT716Jqq69x971kwm0U7felWA1j1wl/1bI=;
        b=k56xqon4R+K/TQIXYrna6CxZqeeBZXJUJjLkrXhbn/1IudCgzPhWq8iqFLm120YG7B
         BO7HMLeaqtrE/+cZumDn2VQaNZIjdAB+3Z/pfTQPAPnBVYEQFrUcdYxcU/u70G+mppeY
         QhrlBffFq+Ycn7SayICgYe/uaYJzlBsl4yLEMtKXm3fQa/mdND0okHb5TtJGmQumjB1Q
         32bFFqgcX2c2e9GeM+yMQIoGn/SVVQhx3NYikBxPJmOs3sQF9GLOY6+kznr2c8AkKpub
         ho6lKbeXMUZUWjiMRf5TvGyZRWtQRpx1O0Qn9XH465HY4Ew6osUvvZT8gU19aZgzWbQG
         HnSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pFrdABztThT716Jqq69x971kwm0U7felWA1j1wl/1bI=;
        b=YHD1OkZNcomch+cAecYvONSI8Rh6iNUYH0C3fEYa0PmtnLMRHBMwyuVgYeNSYrbuDl
         zo7Sj0U78Qewmz4y5MNkAHlTr+mmgErQFjGzvNUjPAAiREnTb4iNc3PLWr4S2l6pj5GQ
         +RCvZ+vv3Qs8Oq3E0kMttUuFbqXymwREvMhGJ0mOBzoh2y5787CwVn7aGrGTx3JdfS36
         GECQ4TLF+k6S+bFZQHhlLy57+bOIYEoOUKxcq7L5s9tdxHTSva8ATlXODh9ZYXOBVAwb
         ZIApH5pskZD4DXxui8K5EnT0yRstEBC4qfqI80H7zifY+ixeQrns5MH79zVJTfcLXL0E
         1wtw==
X-Gm-Message-State: AOAM532H/LUAcf0NZqbA3H8aJC3U8e5Dn/ffVyU+KTJ/jhhU5SSVweVg
        dm18uYUnRXEIx9oi31RHUns=
X-Google-Smtp-Source: ABdhPJyGSJXaUvZ/7BCEtk384hJS0GQy9Oe46xyflS+AiCq0x4jwKwnU8TG6cLBVse3aTYldcwl/sg==
X-Received: by 2002:a2e:b0db:: with SMTP id g27mr9549002ljl.425.1591556234651;
        Sun, 07 Jun 2020 11:57:14 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:14 -0700 (PDT)
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
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 04/39] memory: tegra20-emc: Make driver modular
Date:   Sun,  7 Jun 2020 21:54:55 +0300
Message-Id: <20200607185530.18113-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds modularization support to the Tegra20 EMC driver. Driver
now can be compiled as a loadable kernel module.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/Kconfig       |  2 +-
 drivers/memory/tegra/tegra20-emc.c | 16 +++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/memory/tegra/Kconfig b/drivers/memory/tegra/Kconfig
index 9f0a96bf9ccc..7e0e1ef87763 100644
--- a/drivers/memory/tegra/Kconfig
+++ b/drivers/memory/tegra/Kconfig
@@ -8,7 +8,7 @@ config TEGRA_MC
 	  NVIDIA Tegra SoCs.
 
 config TEGRA20_EMC
-	bool "NVIDIA Tegra20 External Memory Controller driver"
+	tristate "NVIDIA Tegra20 External Memory Controller driver"
 	default y
 	depends on ARCH_TEGRA_2x_SOC
 	help
diff --git a/drivers/memory/tegra/tegra20-emc.c b/drivers/memory/tegra/tegra20-emc.c
index 027f46287dbf..035d9251e28a 100644
--- a/drivers/memory/tegra/tegra20-emc.c
+++ b/drivers/memory/tegra/tegra20-emc.c
@@ -724,6 +724,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, emc);
 	tegra_emc_debugfs_init(emc);
 
+	/*
+	 * Don't allow the kernel module to be unloaded. Unloading adds some
+	 * extra complexity which doesn't really worth the effort in a case of
+	 * this driver.
+	 */
+	try_module_get(THIS_MODULE);
+
 	return 0;
 
 unset_cb:
@@ -736,6 +743,7 @@ static const struct of_device_id tegra_emc_of_match[] = {
 	{ .compatible = "nvidia,tegra20-emc", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, tegra_emc_of_match);
 
 static struct platform_driver tegra_emc_driver = {
 	.probe = tegra_emc_probe,
@@ -745,9 +753,7 @@ static struct platform_driver tegra_emc_driver = {
 		.suppress_bind_attrs = true,
 	},
 };
+module_platform_driver(tegra_emc_driver);
 
-static int __init tegra_emc_init(void)
-{
-	return platform_driver_register(&tegra_emc_driver);
-}
-subsys_initcall(tegra_emc_init);
+MODULE_DESCRIPTION("NVIDIA Tegra20 EMC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.26.0

