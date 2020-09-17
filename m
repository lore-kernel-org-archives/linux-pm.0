Return-Path: <SRS0=qROV=C2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85000C43461
	for <linux-pm@archiver.kernel.org>; Thu, 17 Sep 2020 03:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E1A6208E4
	for <linux-pm@archiver.kernel.org>; Thu, 17 Sep 2020 03:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NyQoaVEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgIQD2t (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 16 Sep 2020 23:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgIQD2S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 23:28:18 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C45C061221
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so800643qtw.5
        for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2020 20:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91xhdh0yMbg0WvS++faa8p3tfvFulTbKZKHM2XlY74k=;
        b=NyQoaVEhlCnIGRqdp321BmI4p2RYV5GPrX3iVW7IPq2tfUJ57cCEZoreEVlu1lbBWZ
         su5ozIUlgC8gHb1OaMDzEmpfZfLbFTBsoBBLxSNI2Lxcu6VABPH3NcjEYfo1nDSaG5+T
         oQCuRKV7f8ON4HPr3U6JmB1C09O990Js8g/DDiXG1W0NUbgyhXcWYKETNJcA2zSqDqT2
         XkFyfa2T8xEvcAa1fMWzS4jPSjM7XhXkCqIubKkeJ7/1idKK8LLzoxuW7253bFWkJBA/
         xy5ZyEK+L0Tx9r3N2KwW5hlwSiLLSyNC1jEWIuTeHNKy4xO4PNjiVvJwHMV63sKQFG2I
         9X/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91xhdh0yMbg0WvS++faa8p3tfvFulTbKZKHM2XlY74k=;
        b=bLIMVS/JdlqLHVyw33Dso4ZyZfxLfwD2YHCPaPpFO0ybRTOg98qXvRLQwm5AeAZqXF
         0RAQcEZR1eXTxzcZhDnElBKkra6gbVdRPA4ZpIg9NyBDBLZuyKzrY/goc0hSx/qeea5q
         X75/oaMdLB7cTJUulJ3V5Ii9pgYpFYRO9gVG+mVWQbeiB1flClJgdECwIThFSmMICTt8
         wMpkkvaCOSmtw7htuDD8QQeCGk+lA6BNhD2ZFdPKlIQHe4+vtnu9oCBp/fb4evAwBHN1
         VuYexTHYTYm5m+ObjWMR/phmnR0sLrplLopGsyIbD8pYxMqOAvstY4LhawZcxyga+NRt
         gFBQ==
X-Gm-Message-State: AOAM5321K8eecSyM/BzzbF52SOHGhUcUXb8IfMtuLFrJeSETrXPR6LgB
        G3CQoEonCeR44+Y1wwDYzLDYow==
X-Google-Smtp-Source: ABdhPJzGVKbFfyn5rK7FIWROKX5Y6Ozb4GkKmDTocfvmrnEQHqR5zV7FnxxIy6zJL/wOmfKrZcsJSg==
X-Received: by 2002:ac8:75ca:: with SMTP id z10mr13718611qtq.345.1600312951689;
        Wed, 16 Sep 2020 20:22:31 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id g45sm21370801qtb.60.2020.09.16.20.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 20:22:31 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rui.zhang@intel.com, daniel.lezcano@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lukasz.luba@arm.com, amitk@kernel.org
Subject: [PATCH RFC 4/8] thermal:core:Add genetlink notifications for monitoring falling temperature
Date:   Wed, 16 Sep 2020 23:22:22 -0400
Message-Id: <20200917032226.820371-5-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200917032226.820371-1-thara.gopinath@linaro.org>
References: <20200917032226.820371-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add notification calls for trip points that are being monitored for
falling temperatures.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/thermal/thermal_core.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 72bf159bcecc..bfd436379408 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -417,6 +417,7 @@ static void handle_critical_trips(struct thermal_zone_device *tz,
 static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 {
 	enum thermal_trip_type type;
+	enum thermal_trip_monitor_type mon_type;
 	int trip_temp, hyst = 0;
 
 	/* Ignore disabled trip points */
@@ -428,13 +429,25 @@ static void handle_thermal_trip(struct thermal_zone_device *tz, int trip)
 	if (tz->ops->get_trip_hyst)
 		tz->ops->get_trip_hyst(tz, trip, &hyst);
 
+	if (tz->ops->get_trip_mon_type)
+		tz->ops->get_trip_mon_type(tz, trip, &mon_type);
+
 	if (tz->last_temperature != THERMAL_TEMP_INVALID) {
-		if (tz->last_temperature < trip_temp &&
-		    tz->temperature >= trip_temp)
-			thermal_notify_tz_trip_up(tz->id, trip);
-		if (tz->last_temperature >= trip_temp &&
-		    tz->temperature < (trip_temp - hyst))
-			thermal_notify_tz_trip_down(tz->id, trip);
+		if (mon_type == THERMAL_TRIP_MONITOR_FALLING) {
+			if (tz->last_temperature > trip_temp &&
+			    tz->temperature <= trip_temp)
+				thermal_notify_tz_trip_down(tz->id, trip);
+			if (tz->last_temperature <= trip_temp &&
+			    tz->temperature > (trip_temp + hyst))
+				thermal_notify_tz_trip_up(tz->id, trip);
+		} else {
+			if (tz->last_temperature < trip_temp &&
+			    tz->temperature >= trip_temp)
+				thermal_notify_tz_trip_up(tz->id, trip);
+			if (tz->last_temperature >= trip_temp &&
+			    tz->temperature < (trip_temp - hyst))
+				thermal_notify_tz_trip_down(tz->id, trip);
+		}
 	}
 
 	if (type == THERMAL_TRIP_CRITICAL || type == THERMAL_TRIP_HOT)
-- 
2.25.1

