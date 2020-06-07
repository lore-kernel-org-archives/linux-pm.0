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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306E9C433E0
	for <linux-pm@archiver.kernel.org>; Sun,  7 Jun 2020 19:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B31720760
	for <linux-pm@archiver.kernel.org>; Sun,  7 Jun 2020 19:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MqvDq9q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgFGTAE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Jun 2020 15:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbgFGS5a (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:57:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA74C08C5C3;
        Sun,  7 Jun 2020 11:57:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so17796909ljn.4;
        Sun, 07 Jun 2020 11:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AmHb/qTFiuR6DXvA/ffC/nHLs0yGE7r571S6zKct1lc=;
        b=MqvDq9q43i2GPx/wPz9ytYWKP88kiBVVzmPi0yFwA3iNTVJYOcWPcz/wxxrokVqKJs
         RY2CBx0Uao//TS1K+2h9Hc+mVgFzsOqbu/Ghe8Wpzd/eRdkCsSLBsj2LZPSrW6lMqLUo
         VmpVlTn5mXp4qTqfXzgx84FXF1U4PCk9QykLsBNdfTfwQyr8ngdKJ+vEl4rV8ZWB5MwE
         F7TqbOvhJWSg6W3qu+BZuiUWaHqkbGdTASKaQT9ITEb3xxfOq74uJ7WW9gSbB1Jjc8GK
         gfGjh9yRYpVg255ue2RW9chLZ4Z+DBiwIFORi9YjB1lPu9vbcQifGETMCB/Jx67aWBg3
         P73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AmHb/qTFiuR6DXvA/ffC/nHLs0yGE7r571S6zKct1lc=;
        b=KIsUtS7nhPZ6Xy9hC8Bl8vdFSIqWLK0JylMTv+3e21kkqTwWdH+Y9Hyq1gKx61yb+m
         AE80SaE8oGDGoF6680iMtrk7UoCGES61h8oR/zmLJI8/YonvSTGaeHYuEUkPz9Q0CCYQ
         uH1a5q73tmUkAKZxiBZ8qifnsPaQesr/YuLOcJp3e9AoUISye5gsqMqO/QORDso7fiwF
         D3he9Zh5TLfPRK9jxcQtKlgV+6Fa87KOh5QLd5+azWBTQQ7u6vUo7LEyTFC/3iQstCgH
         sAFgZJINTQkvtpn+hXSRLML1eU6TmKJofmYQ0kv1r2IpjNDnELSXQrSL+7B8ChsGHqev
         /H8g==
X-Gm-Message-State: AOAM533fOv85ep9sUmmeg9oy8zVDHxcGO/kamgBM8ROMnUmK08h7UJbB
        zsLPhvnhsb0PB/GqNfjAH+M=
X-Google-Smtp-Source: ABdhPJwcOUSznwhDpkI4gzAVGoraSqC7sU2i1NNjjHI6KUrQgIoEDkkkPx49bixW8DPBHVbikgyv1w==
X-Received: by 2002:a2e:9dd8:: with SMTP id x24mr10027334ljj.304.1591556248332;
        Sun, 07 Jun 2020 11:57:28 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:57:27 -0700 (PDT)
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
Subject: [PATCH v3 14/39] PM / devfreq: tegra20: Add error messages to tegra_devfreq_target()
Date:   Sun,  7 Jun 2020 21:55:05 +0300
Message-Id: <20200607185530.18113-15-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's useful to now when something goes wrong instead of failing silently,
so let's add error messages to tegra_devfreq_target() to prevent situation
where it fails silently.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/devfreq/tegra20-devfreq.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/devfreq/tegra20-devfreq.c b/drivers/devfreq/tegra20-devfreq.c
index bf504ca4dea2..249d0dc44f6c 100644
--- a/drivers/devfreq/tegra20-devfreq.c
+++ b/drivers/devfreq/tegra20-devfreq.c
@@ -44,19 +44,25 @@ static int tegra_devfreq_target(struct device *dev, unsigned long *freq,
 	int err;
 
 	opp = devfreq_recommended_opp(dev, freq, flags);
-	if (IS_ERR(opp))
+	if (IS_ERR(opp)) {
+		dev_err(dev, "failed to find opp for %lu Hz\n", *freq);
 		return PTR_ERR(opp);
+	}
 
 	rate = dev_pm_opp_get_freq(opp);
 	dev_pm_opp_put(opp);
 
 	err = clk_set_min_rate(tegra->emc_clock, rate);
-	if (err)
+	if (err) {
+		dev_err(dev, "failed to set min rate: %d\n", err);
 		return err;
+	}
 
 	err = clk_set_rate(tegra->emc_clock, 0);
-	if (err)
+	if (err) {
+		dev_err(dev, "failed to set rate: %d\n", err);
 		goto restore_min_rate;
+	}
 
 	return 0;
 
-- 
2.26.0

