Return-Path: <SRS0=Boio=CM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B18EC433E9
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73A4B20737
	for <linux-pm@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oawjzr9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgICPLF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728936AbgICN5y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Sep 2020 09:57:54 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88F2C06123C
        for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2020 06:21:29 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a15so3713864ljk.2
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2020 06:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXk2DRDPFaxpsHdzRe63wBIuTTXve+FKPVYE5CUnDo4=;
        b=Oawjzr9vgHJvnLOxj5UJZV4sEvTPNZD09yISgS21ZAJA1uMxM0YVj7ZeiqGBT3Klwt
         nHiOV5EdlXBTfBvouAlPLYCRAS9D1CEcS7Aow4dIIFTWA1Q+lH9oQGPgK1HGRjxXZI1m
         tRqCeZ0bMDRJBnt9ZUd7O5eRzTBC4Gv3EXkxeEMyMCx+Ub9eVNwxu2C+hEXjDQokhl/f
         Q6C2aiwVzh8f58ewvJJVAxoYyduzCWjBkq18EiE8+t5u3K7ZhKitMoea5u+jCJdc1dKM
         pkVZPB+dnnZWrSEdYHm0XGU/81gTlOYpjgq6ZQPjQZcfLEImOFcyevKHN2qyUEdWUT1U
         cXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXk2DRDPFaxpsHdzRe63wBIuTTXve+FKPVYE5CUnDo4=;
        b=YxGbpH7SVJGZsP9uedR5a0H04zLyfcLRt8hDz0VWdrRgVNUH9jSbvHKIMWXd3kAiFi
         P9NjR5h58fiT3p8MHkBP5kAxwd2GfRxmD5AOYeF3/zW4aPVPa7ssgsxUEzC4hDad+h8S
         6BVKgJoMHc86hLwGcu2+35dHZz81UgyE8y5MfZXuRDk8tgH5c27jKCB5C2iRZUnodlrV
         8lFilugAHz+pId6w8Z4DiaSYFxNg9gaB5DeJrboiBop8jCPf6+nWpozm229qO1+0MkCu
         /YTte8KfwKZj9ymvbLCXWYOmIidX10m+lE2DljhuiXX4mr7nBVlQEGIiyyQBLlvAFb/2
         V5EA==
X-Gm-Message-State: AOAM531jomozQYDGCdCibmKVP+KwXyDmcVE3DkSrozmmiDDNzjqIZF74
        W+OsY5zy668EjUVdzbdcGxGnWQ==
X-Google-Smtp-Source: ABdhPJxpYZE3X4d30GKvZel54/zbb76gwu/P3GTWbd0QDstXkqBieq1IDsexJWonUMfJdWJelFPuzg==
X-Received: by 2002:a2e:7216:: with SMTP id n22mr1332916ljc.37.1599139288299;
        Thu, 03 Sep 2020 06:21:28 -0700 (PDT)
Received: from eriador.lan ([188.162.64.138])
        by smtp.gmail.com with ESMTPSA id e23sm584220lfj.80.2020.09.03.06.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 06:21:27 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 5/9] iio: adc: qcom-spmi-adc5: fix driver name
Date:   Thu,  3 Sep 2020 16:21:05 +0300
Message-Id: <20200903132109.1914011-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
References: <20200903132109.1914011-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Remove superfluous '.c' from qcom-spmi-adc5 device driver name.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 30b8867b31e4..c2da8f068b87 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -919,7 +919,7 @@ static int adc5_probe(struct platform_device *pdev)
 
 static struct platform_driver adc5_driver = {
 	.driver = {
-		.name = "qcom-spmi-adc5.c",
+		.name = "qcom-spmi-adc5",
 		.of_match_table = adc5_match_table,
 	},
 	.probe = adc5_probe,
-- 
2.28.0

