Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB803E5A17;
	Wed,  5 Aug 2026 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785917295; cv=none; b=mUiuM6Z3Qjpxu88k32mIeD4JnTo4vzoc5vqEoYjjB13dXUmR4V2742gj4mnqP8nNq42oDwjHWB+dlcQ5MT6ywYlr2PElb3VQ/2XUurMiZxlrXIFLrzbbRO/1jbBcdp0HWVKIZm70b8IBGAZXuk7aYQPTS795q3+M7Saq9XabJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785917295; c=relaxed/simple;
	bh=zJ9vphVMBzNYXgwvdVFpKScyRKZfxDrmu7izpa2hJSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJM8OzBH6gYW4/TQoyf9ekfNTIed5dQMW+ENg2B4IXq0KE/gB8a1x5taEb+KRXgGZcUvEt00lkR9Gm7akxVOa0/hg+LdVbusodYlGTdAattpvklYE54S8oUMeAhvzuCM8eF0NPb0OhbLBTQALucouIVwuYMXRJ6mT4FFN+kmfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CD1zOKQM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CD1zOKQM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C7932C2BD05;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785917294;
	bh=zJ9vphVMBzNYXgwvdVFpKScyRKZfxDrmu7izpa2hJSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CD1zOKQMPL1QmK+fuYBzkrgLTKYBVHc3HEFFpXxLfu3AG5NzDTSXYtylumGpAUXZM
	 JUNYM5v1SMc/kTKirEim+Vj1R7ap1QnFgFPOziF38chB0Ng5h8BPIAGnpzn8RMdCd5
	 Im1HgESZcPv49oh4WvuPNN6QZ6hpbahea/c9lT2NrAtA+b9eMMCZfX4HSztGEO8N+Q
	 dpOpYUhGy68ByhzJT1uuCFApqzgt7Ldkvj/SzEhHVVC7vSamg+Y6AQq8up69MvqzEc
	 vM49sUqjIb+ia6YNAJqm4agJ2pyRFqdZWFQTJQScHJBGlMyOsQGVxyTIAXfNITLbK3
	 qQBfUCAZbXSqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFD8C55ABA;
	Wed,  5 Aug 2026 08:08:14 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Wed, 05 Aug 2026 10:06:05 +0200
Subject: [PATCH v9 4/6] thermal: khadas-mcu-fan: Add fan config from
 platform data Add regulator support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260805-add-mcu-fan-khadas-vim4-v9-4-75df78710b9e@aliel.fr>
References: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
In-Reply-To: <20260805-add-mcu-fan-khadas-vim4-v9-0-75df78710b9e@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4111;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=xyEzSXqpYiePonMeddDiYlTDMPNaRxm1EjYvtENMuSw=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ1bR+8xr30oFzOr3sTUeWOeS2mpQtqHjsvBEg5QtWVeut
 Nqoduh2lLIwiHExyIopsvTPtTzx7vLRM1/3qKfAzGFlAhnCwMUpABO5zM/wPy+6OXfNyVM123ef
 yGtTfLNnfkuDaInz5c9yVUpFj26obGJk2KKw6Uq0grq3e3i0otoCA89pv5NfeaYZ2a8sPsHBpPy
 QFQA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Replace the hardcoded MAX_LEVEL constant and fan register
with values read from platform_data (fan_reg, levels[] and nlevels),
as new MCUs need different values.

The cooling device's state is stored as an index into levels[],
and khadas_mcu_fan_set_level() writes levels[state] to fan_reg,
rather than writing the raw state value as before.

Optionally acquire and enable a "fan" regulator supply
at probe time and on resume,
so boards that gate fan power through a regulator are handled.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/thermal/khadas_mcu_fan.c | 58 ++++++++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/thermal/khadas_mcu_fan.c b/drivers/thermal/khadas_mcu_fan.c
index 21b3d0a71bd0d..c7f74394b823f 100644
--- a/drivers/thermal/khadas_mcu_fan.c
+++ b/drivers/thermal/khadas_mcu_fan.c
@@ -13,34 +13,30 @@
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
+	*state = ctx->nlevels - 1;
 
 	return 0;
 }
@@ -60,14 +56,21 @@ khadas_mcu_fan_set_cur_state(struct thermal_cooling_device *cdev,
 			     unsigned long state)
 {
 	struct khadas_mcu_fan_ctx *ctx = cdev->devdata;
+	int ret;
 
-	if (state > MAX_LEVEL)
+	if (state >= ctx->nlevels)
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
@@ -78,6 +81,7 @@ static const struct thermal_cooling_device_ops khadas_mcu_fan_cooling_ops = {
 
 static int khadas_mcu_fan_probe(struct platform_device *pdev)
 {
+	const struct khadas_mcu_fan_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct khadas_mcu *mcu = dev_get_drvdata(pdev->dev.parent);
 	struct thermal_cooling_device *cdev;
 	struct device *dev = &pdev->dev;
@@ -87,7 +91,22 @@ static int khadas_mcu_fan_probe(struct platform_device *pdev)
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
 	if (!ctx)
 		return -ENOMEM;
+
 	ctx->mcu = mcu;
+	ctx->fan_reg = pdata->fan_reg;
+	ctx->levels = pdata->levels;
+	ctx->nlevels = pdata->nlevels;
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
 
 	cdev = devm_thermal_of_child_cooling_device_register(dev->parent,
@@ -125,14 +144,19 @@ static int khadas_mcu_fan_suspend(struct device *dev)
 
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
 
-	return khadas_mcu_fan_set_level(ctx, ctx->level);
+	return khadas_mcu_fan_set_level(ctx, ctx->levels[ctx->level]);
 }
 #endif
 

-- 
2.49.0


