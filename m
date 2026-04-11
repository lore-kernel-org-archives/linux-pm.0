Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8DC285041
	for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2026 19:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775934221; cv=none; b=eWfCpjgP/iS+PTlqdGjfpsXBghFZwHVHYn5/jrjV7UBpXVF0/mdnAVgFTbo6ENVJ2m5JG/7av3kf6zm4SJzY4FvAed3IXcdF0IhlJe6uh9XarZ2w+jXgGjs+pgr4iHAMiZbnFC6yFJMYPLNteOqdgEV2IsZeJzXsUXr3Rn2bdc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775934221; c=relaxed/simple;
	bh=6RaDDsGnWQW8DuDWURtJZzjEsjLR60hKYlROb26NIUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P1yp4jfHd6hSt4ruvVyqkCVM9oBXN6bFqvDViCZYDY8OFFo8xzgJ7h04AI8kpqFss9r8drUTJKoGxuzyO+IUviRcla7uN10CXPrwuQR43HBH7zBRPrNCjcehPg543uA9Pl9pjvDKyZA+WbaNHok1e37mwjFZW8bi9TmnWz5Ovww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otuCmUPx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otuCmUPx"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82c70e4654eso1389952b3a.2
        for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2026 12:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775934219; x=1776539019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tGIk18dSjHKSjMBfr2zRSzrPhhMb1Wy+tDs49j3GVxc=;
        b=otuCmUPxyhei2q1Yr4vb9OXtOea6zrN2HW/sGsGMQorr4yiYlJf7k3re3MTOSJuHbe
         hz59epv3G8+Xqr41AQhhlfsSa5YxesBlspp3J7sZ5oqlvsRLIWqd7AlcDIjhCoHSo0RY
         rAQWLw9/iF2NO4gMe/4xXleX+yNhkoOv03n4Fz/2xC+yABamIhNRydhcx26SpxfCzzSc
         9TvDVvBIgOrmDLrlcGhj3xyU0ou2lZGjqe/IEuPdKytY64DjLwDI6DnKuTop6gm2ZsNN
         oBJsOWnjXhosv/kmwQqzKG7zWtuuQZuf7w1Ax7divQcAvvFDCjfmobjvwgVpsMtd2pCt
         v+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775934219; x=1776539019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tGIk18dSjHKSjMBfr2zRSzrPhhMb1Wy+tDs49j3GVxc=;
        b=lWYNKWe7JajWYpFU7KrFORn5MLWpkiKV2dF4yD2EN0GbWEyc5tLamcLO4Qx3bYyipg
         Bqx8RF6RJnfr3fwbLJlx2OPEYHZbsvMuOYgi3gpWWFLJk3aC+gYifAjcMZnxcG08cm95
         KeZIdog45gjVr7cbnYWMc/zvjgmMVQcVTjqbbYF0wPnF5DER+O7Lq4u9QuQ3pM3VVsS2
         8stRjXXnUZs+ETuBxKItYVNm/EkTMJVQ6cnBvb10XnCuB5xXPc5wr78/WsvsHp2cGHzk
         ID2bl21NzvSXg+tajLG5xJ97Rj3vUZ0AJ/HEX8jTZn1lnANRUeada7RSy3dBOEziyi6p
         BkxQ==
X-Gm-Message-State: AOJu0Ywj7njfANNDeIbFJI1WrOKW17Cqd104u9PPugb5X4Ys5hPPt4Da
	Ym5qChGEfgidcAH6EH+NyB5pIM31486i3ir37thTg+hGx9FB9zueKH7w
X-Gm-Gg: AeBDievcJW0Hq2jx2Ewpc9EL1FLwVA2IOoAIejUCnsQuOjaz/Hv9dj04FULiEKbRROl
	c5NdAjnQkAtrVoa+8D/zHPpbUGNNjTQ39g21Y4g6CbLUYXIHL7uAInRdsujGH1HIEp0BMiFVs66
	VYIXXOOnFa3ImXyuALmYHDjcA4geraZW6cZ2Nx94osJuosmH68xjkprZOdUCznMfILh3qr2/4kE
	imLedIkFEKEZHFZV+/3EC2GYhB+3VHJtmK8farlsG/xWuvy9WJmyJk01o429ykPeqCXhTFzWxDF
	kpRzDJIGYZ8fN4O379JQMlZaavTwCqPGJbGZXuuGJx6o8p0wSmHGkYGY/zrGezBZQlcJ7Fj2bFk
	mflRY+URydjvJDib086R4ccYLxCQeballL3KEa8iOtWJn783CKbjqAoX8e2X/1/8u55c5s4qDJR
	LJ4uQqzMHlnHZAJriMe7lzCjzXWzpjW4Jk6BOOY+s5wqvEj+3wDGsPa7FW5qvAQmiZtEDFV1bT/
	vO0rk6dhZi8oPj8T55O
X-Received: by 2002:a05:6a00:4507:b0:82f:120:fd6f with SMTP id d2e1a72fcca58-82f0c0faafemr7383565b3a.0.1775934218598;
        Sat, 11 Apr 2026 12:03:38 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c338dafsm7058962b3a.17.2026.04.11.12.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 12:03:38 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 12 Apr 2026 03:03:04 +0800
Subject: [PATCH 2/2] thermal/drivers/imxl:Fix runtime PM handling on early
 returns
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-imx-v1-2-cc3b45d63811@gmail.com>
References: <20260412-imx-v1-0-cc3b45d63811@gmail.com>
In-Reply-To: <20260412-imx-v1-0-cc3b45d63811@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775934187; l=1725;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=6RaDDsGnWQW8DuDWURtJZzjEsjLR60hKYlROb26NIUM=;
 b=4BLCl7id57T/9qyuxB+Ons1cJ9eYH6GtrniSvJYEyQhYBOSdzQdtJxj+AGj/GX768L8KTU3Jk
 6v7hShaEIfWAOZx3KDCW/X/UvqA2JHhNFWhD2XBRFeFw7gejFAC9ZC/
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

Use PM_RUNTIME_ACQUIRE() in imx_get_temp() and imx_set_trip_temp() so
runtime PM references are released correctly even when the functions
return early on errors.

Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/thermal/imx_thermal.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 68f9ce41a670..9d9ae7871068 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -260,8 +260,9 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 	u32 val;
 	int ret;
 
-	ret = pm_runtime_resume_and_get(data->dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE(data->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	regmap_read(map, soc_data->temp_data, &val);
@@ -302,8 +303,6 @@ static int imx_get_temp(struct thermal_zone_device *tz, int *temp)
 		enable_irq(data->irq);
 	}
 
-	pm_runtime_put(data->dev);
-
 	return 0;
 }
 
@@ -337,8 +336,9 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz,
 	struct imx_thermal_data *data = thermal_zone_device_priv(tz);
 	int ret;
 
-	ret = pm_runtime_resume_and_get(data->dev);
-	if (ret < 0)
+	PM_RUNTIME_ACQUIRE(data->dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
 		return ret;
 
 	/* do not allow passive to be set higher than critical */
@@ -348,8 +348,6 @@ static int imx_set_trip_temp(struct thermal_zone_device *tz,
 	imx_set_alarm_temp(data, temp);
 	trips[IMX_TRIP_PASSIVE].temperature = temp;
 
-	pm_runtime_put(data->dev);
-
 	return 0;
 }
 

-- 
2.43.0

