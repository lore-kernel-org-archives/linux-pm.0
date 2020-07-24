Return-Path: <SRS0=KrQF=BD=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712F0C433EB
	for <linux-pm@archiver.kernel.org>; Fri, 24 Jul 2020 12:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A3F420737
	for <linux-pm@archiver.kernel.org>; Fri, 24 Jul 2020 12:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TbF45T7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgGXMWI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGXMWI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jul 2020 08:22:08 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC7C0619D3;
        Fri, 24 Jul 2020 05:22:08 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j20so5009642pfe.5;
        Fri, 24 Jul 2020 05:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R5vL6qXyjMQbfnno5/udo/Xo+t67QX6Wv8OgDyk3Wg0=;
        b=TbF45T7MzERf1vZY2O5mm4KJVgdG1/r2pUIRVJ5+SrGwDJzpeyfvE7YRN/yfamnLJl
         gvoy5nplxIQ+HO0jlDckDW1Xc2w7PQ/7Ne5Pc/OMDNVCF92UFy+1S+WiCbH67EBMiu5K
         5bfEgZb5MOCksnjb+fGQ8IQwi/Su/0pFSSX+nWBviITmkG2vZPyLc0JjzZX5WcY9TXqY
         rwf4rFEdG7ERmWvE8zhYdVMcuPOIn9bZnbBt3aUmQbV1dA2P6pGTr2gYfCPx90TeQPqa
         nYtNrfHyUmqD0vSDPimicQEdeOxR4JDnwZEsOr9djedWJbkXs/g/jRRWNpUXP1FSohwT
         Tbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R5vL6qXyjMQbfnno5/udo/Xo+t67QX6Wv8OgDyk3Wg0=;
        b=XoMQg9wvk6oP2Vf24A3IbFMJ7g6qVt6OaxP2NZ9+zIbIkCJStqDxUnO5b1j2idzCIr
         usaI6ySGlKjuP2D20QxKygyMDfl66oc16FkEV9le17wiaqyqhs4zQNOaPRjA1512mTmh
         doT2WFXI8tgu/3Zd6+kXh63AIe2LnI6wPknkOYVujiMid/hPJ3Wo/tW79tf+604lz5IA
         0zDp+3B20iOJZWzopwpZSUP8Gha+SyDIPQPz1O2js+pmtNxPkPQsa1egpCFDMu/llRFy
         rSJxp4oFHkBK8MrSDD/BHcTzf0Uvmy5ZRKWpN6DkzA5t0ZrvSO5iSkvMFQYDpBd8Qq+X
         Mp+Q==
X-Gm-Message-State: AOAM533myaWA5L+c2xJLchAGDxj9gI46JTGlZrHCcTNtTsjIfgS6bOp0
        EyWdNmxyb13uB0AWrWwqcbA=
X-Google-Smtp-Source: ABdhPJxIEq9QaSdd8FOYFFJQtpFKbythRPf8zzf8OPOXaOERzlmv4jo+N7OeViWRqIYoC84Ygb3/gg==
X-Received: by 2002:a65:43c1:: with SMTP id n1mr8102889pgp.67.1595593327778;
        Fri, 24 Jul 2020 05:22:07 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id r185sm5766819pfr.8.2020.07.24.05.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 05:22:06 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen Yongzhi <yongzhi.chen@unisoc.com>
Subject: [PATCH v2 2/2] power: supply: sc27xx: prevent adc * 1000 from overflow
Date:   Fri, 24 Jul 2020 20:21:48 +0800
Message-Id: <20200724122148.26541-3-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724122148.26541-1-zhang.lyra@gmail.com>
References: <20200724122148.26541-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@unisoc.com>

The input parameter is int type, cause adc * 1000 could overflow.
Change to use s64 to avoid this issue.

Signed-off-by: Chen Yongzhi <yongzhi.chen@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
 drivers/power/supply/sc27xx_fuel_gauge.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
index be42e814ea34..9c627618c224 100644
--- a/drivers/power/supply/sc27xx_fuel_gauge.c
+++ b/drivers/power/supply/sc27xx_fuel_gauge.c
@@ -5,6 +5,7 @@
 #include <linux/iio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
@@ -133,14 +134,14 @@ static const char * const sc27xx_charger_supply_name[] = {
 	"sc2723_charger",
 };
 
-static int sc27xx_fgu_adc_to_current(struct sc27xx_fgu_data *data, int adc)
+static int sc27xx_fgu_adc_to_current(struct sc27xx_fgu_data *data, s64 adc)
 {
-	return DIV_ROUND_CLOSEST(adc * 1000, data->cur_1000ma_adc);
+	return DIV_S64_ROUND_CLOSEST(adc * 1000, data->cur_1000ma_adc);
 }
 
-static int sc27xx_fgu_adc_to_voltage(struct sc27xx_fgu_data *data, int adc)
+static int sc27xx_fgu_adc_to_voltage(struct sc27xx_fgu_data *data, s64 adc)
 {
-	return DIV_ROUND_CLOSEST(adc * 1000, data->vol_1000mv_adc);
+	return DIV_S64_ROUND_CLOSEST(adc * 1000, data->vol_1000mv_adc);
 }
 
 static int sc27xx_fgu_voltage_to_adc(struct sc27xx_fgu_data *data, int vol)
-- 
2.20.1

