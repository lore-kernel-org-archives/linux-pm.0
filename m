Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFC33932ED
	for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 13:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258641; cv=none; b=tfENMjrIWzCgsYd6VGGJRhlDaMC83Jtz62MVllHMhkGzomsm++S9mUCYNWgbrHKWZt/quAbkTTwDwQZIT4TCBQhN9oZ31wr7T8t9lONCC3K4mttwlkRM2kFGKYdFxERO074W7g4CJdhGBCIbIGNuiLm8iFfFyjtFLrx6EK5Og7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258641; c=relaxed/simple;
	bh=7PW1lPMswvgJuRQIYg5xAY53B74djXr4QMhYyX34Qa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bW/K0w54mTGXpY3WDy0MG3l4+q0sL+y6nu9wSLV2IYr5psTpMFZ5+h6GMOui1C/9BCCmUPPhKQXThaVlbuARrKavHrLaZEsN97/ig5/2jxEmwW/j7jtzf9KcpTCEUVMyupBvxJ62lT/mvK0n7D2vj++PDf9Ln9TydMyqivq1vIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQs4tvzB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQs4tvzB"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2adff872068so34301765ad.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Apr 2026 06:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776258640; x=1776863440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cgiajh9ZFC2IgUfICjc3cGv7OXm2lzFWtpGDZIIxGOc=;
        b=RQs4tvzBBq9XDDwJJ6HmZjcff5wU9K49rFBaRN234NK5KtU4Ap5gWw5iiTZGgqT9T2
         3HtW5ZgQoHnVDrYtWYdr0fkSHp5d8tF+Leu7BaUw5ORHMTMCladbp7JYTmrLRSlPDrUm
         niIye753DXwM4Xqz57b1yNx7HVn8k2G+Kj8sOIWgFToKYuRg9rGFjHDXV9+6hFZBUa8q
         ubuo+XwEFR48mMM++hyF68BIDi0AHpxAwXdhZSWQq7C6PA+qz86KtGejZhqLs8VtvzsP
         aKiJxFvjbC6kZ7rRjMUhPbL8Bzjqw/DZqlPEiPGE4OO5T//x8TEB7/inOJo88mVQqf4a
         MR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776258640; x=1776863440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Cgiajh9ZFC2IgUfICjc3cGv7OXm2lzFWtpGDZIIxGOc=;
        b=ri4OvLGi1A5swK81C1sJ/kMkQbZpP01a1JjAqvW95H3Q9+Ug1a1mhPiZM/RdY4Rus+
         5k/j71LL4/zgb3+DwyLWw+B0vFKc1xygKoA24wE71YUTSlQfOPJP7UCEYWQFwlDxavv7
         DSXbXHSJfMx0Vrsu6Fb5hnaBUOG1CulSLaK7Mqy3/0SbcGg5WsCkeICmCTnL3kUPnXDX
         HSSOfj8yj/1EoDTtpVeq3WO09v4UYu+bD8aARoLT6RjsHHjfG+ybbA9LloQOKyxzjaE6
         gAVFtELiYo6Nt/7ntWVwM+ayZ4dd6+rbOZOoC6VK7YnQ1XdGx9FlOHaj8wudmdlYSpWM
         dy1Q==
X-Gm-Message-State: AOJu0YxjPaKwAn9GeEfvm8KML9v2SW52DcCBep5jPAKjEf5vc6cv2Uw4
	9QqlrrDB8b5KUFYHPoeLcIlb+lBNxsqqtVA0uq0ibEmfiFgbVkRzo3KZ
X-Gm-Gg: AeBDiesS+AEKHIUZ6g9xJLxiKQ6xB+ixoaeu+uqT9wQUGB9mjzNbQ9WA7tQShhhtaN6
	Z1XpVKJJ4MHlu6lU8aLNGdE8N4aKv6UUOPaE2cm9n0kimyesXSA7vDmOiNOOR2T04soOc9dP/x8
	uEY2xqxHCj0s2YSxQ0rsqR0R9d0EkH31gkzKL81kH5BxMKHNTaLhsTwgS08X0mup4aSyZX46HZh
	MXUGxU2AYNufTPB1TGDij2zi3xHHEeNFdcaQLNqTKrnTYSt6e8jMuVCRVN9uryLkyrBXEIZKcdE
	/MlHiTqMls3CrvSvHQgauP1tE5yesmXkqWXA1/lNfJEUYRQtJeLgFT45aDwum5r2GdLwc5KRbVo
	OXnhENDl8BTF7+JJcG8PAnlDQmUMo/2FHmY8utQ2h0D4G0slO2V3gVHxGWAANV4oiJ9+iSWCB4h
	aKIvAhZwFxctVT0+XMpUvddsOhzbU6KfeP2CTFkTI1F7/n7Agx/B4rQitNAq+XEE7eod0FGtmjT
	zkId73Bj0qGHt2IZQ8a14VxdcM5ZKA=
X-Received: by 2002:a17:903:1ab0:b0:2b2:67ca:5fff with SMTP id d9443c01a7336-2b2d5a5d952mr210669185ad.28.1776258639793;
        Wed, 15 Apr 2026 06:10:39 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478292053sm28062555ad.56.2026.04.15.06.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 06:10:39 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 15 Apr 2026 21:10:28 +0800
Subject: [PATCH v2 2/2] thermal/drivers/imxl:Fix runtime PM handling on
 early returns
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-imx-v2-2-aeacff9e72b2@gmail.com>
References: <20260415-imx-v2-0-aeacff9e72b2@gmail.com>
In-Reply-To: <20260415-imx-v2-0-aeacff9e72b2@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-pm@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776258629; l=1767;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=7PW1lPMswvgJuRQIYg5xAY53B74djXr4QMhYyX34Qa8=;
 b=zc9s8r8gJYEF99ja/bK8BCYwUX6qO8U83NdS+xZl54YsmqyvJBsRpZbIBaWc4Errs/PcTw9c/
 ylmRwbKMQeDBA6dJu4y5ZbMbRXZFFsIsADvFvXB22DRbNSttxxOPGeW
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Use PM_RUNTIME_ACQUIRE() in imx_get_temp() and imx_set_trip_temp() so
runtime PM references are released correctly even when the functions
return early on errors.

Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/thermal/imx_thermal.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 3729c3eac748..057dbab70266 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -274,8 +274,9 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 	u32 val;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(data->dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE(data->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	regmap_read(map, soc_data->temp_data, &val);
@@ -316,8 +317,6 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 		enable_irq(data->irq);
 	}
 
-	pm_runtime_put(data->dev);
-
 	return 0;
 }
 
@@ -351,8 +350,9 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz,
 	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(data->dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE(data->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	/* do not allow passive to be set higher than critical */
@@ -362,8 +362,6 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz,
 	imx_set_alarm_temp(data, temp);
 	trips[IMX_TRIP_PASSIVE].temperature = temp;
 
-	pm_runtime_put(data->dev);
-
 	return 0;
 }
 

-- 
2.43.0

