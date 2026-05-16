Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D373ED5AD;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778951902; cv=none; b=E6EVOoik9FtzGXqnnAtRNxyUkfezSD+XnlTPNCc27Fq1UBlzVIZHeKQpvubY5+L4ncQv15hgTOq4BNz4CJ4jXY542Vu2ZqscRRKIEanFSF0EHzIQULFRsygiAozkpt/fe/+aXaoGcRmdpiCf4dxyx+7YlzKaGd+v5uY98nDO9XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778951902; c=relaxed/simple;
	bh=dOoxnDlBmKRUEuWn0/9PCIB2WwlAKvILRj6iXjFR3rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZaxP69o+lobTjYBIDHNuhnnT5n44SNtOQRHPDNjGQBlHq4QSwnqefp6pVAgN3noxdJvUWzgeQhd1ggeoFpoUlQfQnu9Z5AV+ABntw2MyyZ1dMgDnbtUn7Bf9lOLwV+BR3D/IZBn6rzIa5XNEtCodbFEL0OFcQQGJr97zJPG72mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKhF5tI6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKhF5tI6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C2EFC2BCFC;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778951902;
	bh=dOoxnDlBmKRUEuWn0/9PCIB2WwlAKvILRj6iXjFR3rg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qKhF5tI6v75rZMOl30wwloDyDiBIRjDovAF6gJ2V1gpZooP8T0ZtEWjsbuiRDD+q5
	 7jjuzUfOCmufNYanr/tnV9V1w8LeHwokPQ1nyz8h24loGm/3LDac3bE9rE5Dyin6tH
	 8tRVaL0tAttcfLOsFbA0a6fmZYz98+Ewo/rC+oxDpTKzikeGutiRSQM9/HcTykl81P
	 QhCMUNyjWwMCEtH5fu7PqVz8AUQvyzHo9+9gFnG/7df6XkqSoXpU37NEFP293M9gIK
	 DMe6fRIlrNwqwH8nAK0UFtLMH/50taG8DaSu5Gl4TpmwUMvQbV1dY5Q8qsA+84G25w
	 SV/ACxFodm/+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8B2CD4F3C;
	Sat, 16 May 2026 17:18:22 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 16 May 2026 19:17:05 +0200
Subject: [PATCH v6 5/8] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-add-mcu-fan-khadas-vim4-v6-5-cccc9b61f465@aliel.fr>
References: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
In-Reply-To: <20260516-add-mcu-fan-khadas-vim4-v6-0-cccc9b61f465@aliel.fr>
To: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Beniamino Galvani <b.galvani@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3542;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=GAu0pdDCPzhOo5CdDYjBvtBNlGqzAQdEX8wTJo3sqIc=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQxbHsuufVtfMUz+YbeqUO/ukVkggh63ozG2rjhyYuJD7b
 eJ0Me47HaUsDGJcDLJiiiz9cy1PvLt89MzXPeopMHNYmUCGMHBxCsBEMusYGf4ezVxiwM25cAH7
 qc/if+2XdT5vllZ97vDW8Ji/yu00UXlGhvvWN+J1Kz9N3Oh71vNt7sTZuQcebt38wCzzl5vK870
 l71kA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Replace the hardcoded MAX_LEVEL constant and fan register
with values read from platform_data (fan_reg, max_level),
as new MCUs need different values.

Optionally acquire and enable a "fan" regulator supply
at probe time and on resume,
so boards that gate fan power through a regulator are handled.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/thermal/khadas_mcu_fan.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
index d35e5313bea41..5603fa099a858 100644
--- a/drivers/thermal/khadas_mcu_fan.c
+++ b/drivers/thermal/khadas_mcu_fan.c
@@ -13,13 +13,15 @@
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 #include <linux/thermal.h>
-
-#define MAX_LEVEL 3
+#include <linux/regulator/consumer.h>
 
 struct khadas_mcu_fan_ctx {
 	struct khadas_mcu *mcu;
+	unsigned int fan_reg;
 	unsigned int level;
+	unsigned int max_level;
 	struct thermal_cooling_device *cdev;
+	struct regulator *power;
 };
 
 static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
@@ -27,8 +29,7 @@ static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
 {
 	int ret;
 
-	ret = regmap_write(ctx->mcu->regmap, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
-			   level);
+	ret = regmap_write(ctx->mcu->regmap, ctx->fan_reg, level);
 	if (ret)
 		return ret;
 
@@ -40,7 +41,9 @@ static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
 static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
 					unsigned long *state)
 {
-	*state = MAX_LEVEL;
+	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
+
+	*state = ctx->max_level;
 
 	return 0;
 }
@@ -61,7 +64,7 @@ khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
 {
 	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
 
-	if (state > MAX_LEVEL)
+	if (state > ctx->max_level)
 		return -EINVAL;
 
 	if (state == ctx->level)
@@ -78,6 +81,7 @@ static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
 
 static int khadas_mcu_fan_probe(struct platform_device *pdev)
 {
+	const struct khadas_mcu_fan_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct khadas_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
 	struct thermal_cooling_device *cdev;
 	struct device *dev = &pdev->dev;
@@ -87,7 +91,21 @@ static int khadas_mcu_fan_probe(struct platform_device *pdev)
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+
 	ctx->mcu = mcu;
+	ctx->fan_reg   = pdata->fan_reg;
+	ctx->max_level = pdata->max_level;
+
+	ctx->power = devm_regulator_get(dev->parent, "fan");
+	if (IS_ERR(ctx->power))
+		return PTR_ERR(ctx->power);
+
+	ret = regulator_enable(ctx->power);
+	if (ret) {
+		dev_err(dev, "Failed to enable fan power supply: %d\n", ret);
+		return ret;
+	}
+
 	platform_set_drvdata(pdev, ctx);
 
 	cdev = devm_thermal_of_cooling_device_register(dev->parent,
@@ -124,12 +142,17 @@ static int khadas_mcu_fan_suspend(struct device *dev)
 
 	ctx->level = level_save;
 
-	return 0;
+	return regulator_disable(ctx->power);
 }
 
 static int khadas_mcu_fan_resume(struct device *dev)
 {
 	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regulator_enable(ctx->power);
+	if (ret)
+		return ret;
 
 	return khadas_mcu_fan_set_level(ctx, ctx->level);
 }

-- 
2.49.0


