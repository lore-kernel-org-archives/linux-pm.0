Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB7543A812;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788276467; cv=none; b=UcD8HHSnh5HtqJW8qb2DCT5fi77U3cQ62FpsFP/uxJhvHzecRZ+/zY/Ye09W/HZIilRoKRB8XdCaO335NMtYic4L5fxJdHAB1Der37iPY59WAZp6imr7ECkAyp0stNldR5U7+uK0RlLwP+Gu4LZUg2BHwhe4BlZ/iGscbIjEi10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788276467; c=relaxed/simple;
	bh=u7Jg9tQTHmoStH7V/USEIn5xFwqXnHXrTzN8IDNeez0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzIJPR/Z3yg/IKqUY9DPuXfsPc/dl3EzlZHrS1l2M1TLxQ8YSXRjJPkUjFZw2tN90O47MOSuIS7TfWPRQkVZ+DHddmjyo3DcNuzD4EqR6Xz+LkiC0J4a/+ebu4CsJx2NjRgA00DeNmjiUP1QuVHGpNdd3GUWvbyySh6YIkyt7ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6hPRY/K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6hPRY/K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0E58C2BCF4;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788276466;
	bh=u7Jg9tQTHmoStH7V/USEIn5xFwqXnHXrTzN8IDNeez0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s6hPRY/KfYh7TCuOkxKO35I7YPe6VWcSpchVqtVuowkZtpLGSiFwbxoR/p+mK5T3I
	 f5Y1PNXrk/l978nrS4yZww1D2Qtd9OuKyElKhNsvGusIJ1OSSuAwldwpAM8Bcnbmc3
	 HlDmb2mVAwJKFJMEA93JAaHq76W7Z84CYMwottegKSx6wTUfm5Gotofnr3iKU0wSAE
	 WAfgK2PYyA6Uc9So8WoWjlvQkFMVlCSigQ0Tmxjd7arsdcXepqhJu3RuxPiUsvguIq
	 t3fMf8t8Yc1US0eUTv4sK7KtsbC99ewF6D83blM1tmYWWzXf1EgrM64gE6csCKs3Nv
	 kTkXW+kQQe9og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3A2C624D5;
	Tue,  1 Sep 2026 15:27:46 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Tue, 01 Sep 2026 17:25:55 +0200
Subject: [PATCH v10 4/6] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-add-mcu-fan-khadas-vim4-v10-4-aecdb9955a30@aliel.fr>
References: <20260901-add-mcu-fan-khadas-vim4-v10-0-aecdb9955a30@aliel.fr>
In-Reply-To: <20260901-add-mcu-fan-khadas-vim4-v10-0-aecdb9955a30@aliel.fr>
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
 mfd@lists.linux.dev, Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5678;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=NgWEa6VMYz3MNICtIO8RbLKLnPH8ThvJnMMKdtpA/z8=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ9a0d2/7eD8lrLry9r7FysrQg0zfc1RFP0xpeHFvT/e6D
 yITOrev7yhlYRDjYpAVU2Tpn2t54t3lo2e+7lFPgZnDygQyhIGLUwAmcusAI8MC7QuTq/6rZz9Y
 lv74r1qH5emKgl/K4RkWF/865jq1qTozMlzh/9KceJM/UDBUgk//tWIaR9bC4EVCN0QXePw67HX
 6LTcA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Read the fan register and level table from platform_data (fan_reg,
levels[] and nlevels) instead of hardcoding a single register and
level count, as new MCUs need different values. MAX_LEVEL is kept
and bumped from 3 to 5 to make the speed change more gradual with
the newer MCUs.

The cooling device's state is stored as an index into levels[],
and khadas_mcu_fan_set_level() writes levels[state] to fan_reg,
rather than writing the raw state value as before.

Optionally acquire and enable a "fan" regulator supply
at probe time and on resume,
so boards that gate fan power through a regulator are handled.
The regulator is released via a devm_add_action_or_reset()
callback.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/thermal/khadas_mcu_fan.c | 94 ++++++++++++++++++++++++++++++----------
 1 file changed, 71 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
index 21b3d0a71bd0d..512a6f0ff7c26 100644
--- a/drivers/thermal/khadas_mcu_fan.c
+++ b/drivers/thermal/khadas_mcu_fan.c
@@ -13,34 +13,33 @@
 #include <linux/regmap.h>
 #include <linux/sysfs.h>
 #include <linux/thermal.h>
+#include <linux/regulator/consumer.h>
+#include <linux/minmax.h>
 
-#define MAX_LEVEL 3
+#define MAX_LEVEL 5
 
 struct khadas_mcu_fan_ctx {
 	struct khadas_mcu *mcu;
+	unsigned int fan_reg;
 	unsigned int level;
+	const unsigned int *levels;
+	unsigned int nlevels;
 	struct thermal_cooling_device *cdev;
+	struct regulator *power;
 };
 
 static int khadas_mcu_fan_set_level(struct khadas_mcu_fan_ctx *ctx,
 				    unsigned int level)
 {
-	int ret;
-
-	ret = regmap_write(ctx->mcu->regmap, KHADAS_MCU_CMD_FAN_STATUS_CTRL_REG,
-			   level);
-	if (ret)
-		return ret;
-
-	ctx->level = level;
-
-	return 0;
+	return regmap_write(ctx->mcu->regmap, ctx->fan_reg, level);
 }
 
 static int khadas_mcu_fan_get_max_state(struct thermal_cooling_device *cdev,
 					unsigned long *state)
 {
-	*state = MAX_LEVEL;
+	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
+
+	*state = min_t(unsigned int, MAX_LEVEL, ctx->nlevels - 1);
 
 	return 0;
 }
@@ -60,14 +59,21 @@ khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
 			     unsigned long state)
 {
 	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
+	int ret;
 
-	if (state > MAX_LEVEL)
+	if (state > MAX_LEVEL || state >= ctx->nlevels)
 		return -EINVAL;
 
 	if (state == ctx->level)
 		return 0;
 
-	return khadas_mcu_fan_set_level(ctx, state);
+	ret = khadas_mcu_fan_set_level(ctx, ctx->levels[state]);
+	if (ret)
+		return ret;
+
+	ctx->level = state;
+
+	return 0;
 }
 
 static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
@@ -76,22 +82,53 @@ static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
 	.set_cur_state = khadas_mcu_fan_set_cur_state,
 };
 
+static void khadas_mcu_fan_regulator_disable(void *data)
+{
+	struct regulator *power = data;
+
+	regulator_disable(power);
+}
+
 static int khadas_mcu_fan_probe(struct platform_device *pdev)
 {
+	const struct khadas_mcu_fan_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct khadas_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
 	struct thermal_cooling_device *cdev;
 	struct device *dev = &pdev->dev;
 	struct khadas_mcu_fan_ctx *ctx;
 	int ret;
 
+
+	if (!dev->of_node)
+		dev->of_node = dev->parent->of_node;
+
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+
 	ctx->mcu = mcu;
+	ctx->fan_reg = pdata->fan_reg;
+	ctx->levels = pdata->levels;
+	ctx->nlevels = pdata->nlevels;
+
+	ctx->power = devm_regulator_get(dev, "fan");
+	if (IS_ERR(ctx->power))
+		return PTR_ERR(ctx->power);
+
+	ret = regulator_enable(ctx->power);
+	if (ret) {
+		dev_err(dev, "Failed to enable fan power supply: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(dev, khadas_mcu_fan_regulator_disable, ctx->power);
+	if (ret)
+		return ret;
+
 	platform_set_drvdata(pdev, ctx);
 
-	cdev = devm_thermal_of_child_cooling_device_register(dev->parent,
-							     dev->parent->of_node,
+	cdev = devm_thermal_of_child_cooling_device_register(dev,
+							     dev->of_node,
 							     "khadas-mcu-fan", ctx,
 							     &khadas_mcu_fan_cooling_ops);
 	if (IS_ERR(cdev)) {
@@ -109,30 +146,41 @@ static void khadas_mcu_fan_shutdown(struct platform_device *pdev)
 {
 	struct khadas_mcu_fan_ctx *ctx = platform_get_drvdata(pdev);
 
-	khadas_mcu_fan_set_level(ctx, 0);
+	khadas_mcu_fan_set_level(ctx, ctx->levels[0]);
 }
 
 #ifdef CONFIG_PM_SLEEP
 static int khadas_mcu_fan_suspend(struct device *dev)
 {
 	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
-	unsigned int level_save = ctx->level;
 	int ret;
 
-	ret = khadas_mcu_fan_set_level(ctx, 0);
+	ret = khadas_mcu_fan_set_level(ctx, ctx->levels[0]);
 	if (ret)
 		return ret;
 
-	ctx->level = level_save;
-
-	return 0;
+	return regulator_disable(ctx->power);
 }
 
 static int khadas_mcu_fan_resume(struct device *dev)
 {
 	struct khadas_mcu_fan_ctx *ctx = dev_get_drvdata(dev);
+	int ret, ret2;
+
+	ret = regulator_enable(ctx->power);
+	if (ret)
+		return ret;
 
-	return khadas_mcu_fan_set_level(ctx, ctx->level);
+	ret = khadas_mcu_fan_set_level(ctx, ctx->levels[ctx->level]);
+	if (ret) {
+		ret2 = regulator_disable(ctx->power);
+		if (ret2)
+			dev_err(dev, "failed to disable regulator after error %d: %d\n", ret,
+				ret2);
+		return ret;
+	}
+
+	return 0;
 }
 #endif
 

-- 
2.49.0


