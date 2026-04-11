Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB48285041
	for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2026 19:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775934210; cv=none; b=t5D1fvn9k88wjhzmpOGQVfm4IY1Hifj/HrHTyJ4tsphi4fzLwhpVhDk2CLtAvMczoi/iZYAk2uGlWhWp5PVRGBmXsYC1mmfta4W7jvmPm6V/oCMrce8gPX3FRBwfmyrwDvQokn8ioEm0z97QfBqR0zyNEHdw4UX6DZGFZZd3Dbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775934210; c=relaxed/simple;
	bh=HdJtNYVZoBcseIrEtuqZHe4dtTSU6Ka5kLHKaWeLYmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=anpIZULj9lHADBScxeWJQckNwNJUANlFMID5jvyFJzoxoiiakweUDdv8n013Kxjjyp5TtLTe83lM05VAevGo9FigIwO1EBsFt+7Qz/GmRogNIdC8aCcEYa648Ge9SBSHCX9Dz9q+Lp5kMU5o0zm3YV9Wy0WdNThr4BdYBW/HfGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSsQHBWT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSsQHBWT"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8296dabef74so3321038b3a.1
        for <linux-pm@vger.kernel.org>; Sat, 11 Apr 2026 12:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775934208; x=1776539008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZCcfd2j80fnOyI9eoqdL6EvakDEWReMcJQ9OZ/rF64=;
        b=hSsQHBWT+QTiJ6HnPR+eM+YFMo9svBQcINrhj2wzomNbXgE4EzBepYzconZ9D8zslf
         0oJZ6i0wlcN/n6nEmZ9zoQjQ7SSeZX48ERurTHyjN9jqWWn0FRxYNKz1VybWy+Hh+j0i
         twxZAj/r6I1dw40D73zWcQIrF89gRTcsNG3rZVw5jvomR1xut2Uosvx51YCoCc6XXie9
         Se6XsFgQLwLAQvyNQDDcROVmnoMTI6yD8BCbjR5qgdi+8LqRuE9kD8CF3jLEFJp/vYJB
         etiUkQQuTsrViXXSHLfQDw63eR9mCJZAhORJ/Eurr4WqZGBdbSyYFX8SNCMEhSROCo6g
         bXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775934208; x=1776539008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SZCcfd2j80fnOyI9eoqdL6EvakDEWReMcJQ9OZ/rF64=;
        b=R2jdGSJBcjIANo+/Y2bGnjeSC2twAiX9L/ZjR+ejhSN//iUl4QjfqFenjp5aC3gV8I
         uIBLfplAc87r6BnrSYB425cKOPVG4bffx7zBkTRT91CoiDybBK09w7YJluuOMJsE2Nyw
         no2Ap7PWJrKRBm40lgd960lEnyKNdhjbxjQtTUrhc78xrsUemaPhzpnQfrQBcwj7IB1S
         WlkplGI9i7XGnQJGwX5KPJPmZr9s2YiaN+zXsWZ2po6hCF6TXB5k6URo20XIe+AgmDMq
         ndcsrCxapL2aDgd1A5Vb3ma0LZW5uZ3wJIW5kJc6dgXv72BTBxEs8PSYZlYgMO+w3z9H
         im2g==
X-Gm-Message-State: AOJu0YyG/SkDYFVFnMkjlfUiag0yZix2f3JXoHlLZepAXuYskxnvJGhs
	MkomRtCxtfyIBzVCiTfCCiAtm9kMgXBnVH5kl+DEcsT7KUJ441EvvdMo
X-Gm-Gg: AeBDieuohUpgvrJeVGwmuxImx5KcdHYTw1t6xGrmaRUaXd2n78NbyMeT7KxMRuuCM5T
	MbteUqmpEyD0ZkcSfhf6xaojwn5VWxZGcbU6x9oxv4beIznL3WqitAWAmb4hRF+tPkqfcw1piBX
	8PZmF9asD/u9DBmEmIK2j1YdK7vEGFx2uGSiamTmVNK0iGfKzphrWCw4rPQWa66uSTjpVHa1a1H
	978bLJ9qRe4A/OTIX1uSf3WgJELopHJeFPjcMOf1NxbZY5FSt2c62UtkI8/eFaNVBpXrto+udhk
	gaIJrLF9aTbp8VA5i7wxpUoPdyWT/XKlPiQlBqfaMqTttje17MCKw9eGZX2RmldfPu1yOh+B5vn
	Vd88tJ0NX+GF3QyqUlG10DD8ZFVCIFodY5YmqfhIawG8nVPG3pmB6FCco31dB2LsmgruUOJUG12
	p4UCDSQCV9tEFu3O3FL53jXf2rF37uxufzR2xV4VwRo+467Kpdizt8tpiN68jjOjFYSciLcC02X
	srC1k9ILKI/DbfobVRo
X-Received: by 2002:a05:6a00:aa85:b0:824:93e4:2ddf with SMTP id d2e1a72fcca58-82f0c2108e5mr7582747b3a.13.1775934208443;
        Sat, 11 Apr 2026 12:03:28 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.167.147.125])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c338dafsm7058962b3a.17.2026.04.11.12.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 12:03:28 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sun, 12 Apr 2026 03:03:03 +0800
Subject: [PATCH 1/2] thermal/drivers/imx: Fix thermal zone leak on probe
 error path
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260412-imx-v1-1-cc3b45d63811@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775934187; l=1641;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=HdJtNYVZoBcseIrEtuqZHe4dtTSU6Ka5kLHKaWeLYmo=;
 b=neNOP4zpKWvHPkLkH0wdVnaTfqhzSv/BpzFq9DKrR/JAJc10E6mAsmmekeCLKiDqbQNajMH0i
 B6BD4UMtexGDr1MJj8lbme6hvP/nA6/CmECAFZ/qJQoFx/UM6NYNdPC
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

If pm_runtime_resume_and_get() fails after the thermal zone has been
registered, the probe error path cleans up runtime PM but skips
thermal_zone_device_unregister(), leaking the thermal zone device.

Move thermal_zone_device_unregister() into disable_runtime_pm so all
failures after thermal zone registration unwind the probe path
correctly.

Fixes: 4cf2ddf16e17 ("thermal/drivers/imx: Implement runtime PM support")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/thermal/imx_thermal.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 38c993d1bcb3..68f9ce41a670 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -727,25 +727,24 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	data->irq_enabled = true;
 	ret = thermal_zone_device_enable(data->tz);
 	if (ret)
-		goto thermal_zone_unregister;
+		goto disable_runtime_pm;
 
 	ret = devm_request_threaded_irq(dev, data->irq,
 			imx_thermal_alarm_irq, imx_thermal_alarm_irq_thread,
 			0, "imx_thermal", data);
 	if (ret < 0) {
 		dev_err(dev, "failed to request alarm irq: %d\n", ret);
-		goto thermal_zone_unregister;
+		goto disable_runtime_pm;
 	}
 
 	pm_runtime_put(data->dev);
 
 	return 0;
 
-thermal_zone_unregister:
-	thermal_zone_device_unregister(data->tz);
 disable_runtime_pm:
 	pm_runtime_put_noidle(data->dev);
 	pm_runtime_disable(data->dev);
+	thermal_zone_device_unregister(data->tz);
 clk_disable:
 	clk_disable_unprepare(data->thermal_clk);
 legacy_cleanup:

-- 
2.43.0

