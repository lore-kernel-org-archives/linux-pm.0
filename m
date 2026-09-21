Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279AB46DFF4;
	Mon, 21 Sep 2026 10:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985063; cv=none; b=ISHBT8LOKs8wXTNMnaJv0CcGXjqEi3eagzWmUm5irej3bw3SA4WUdNkoDg+GPRIDZ5YUcotL9mGw/evavKy4Rk6eUEGzlVgGaIdwtahtYaSn7+67UH7bPZ8mqe3pAkO4QzrnL2oO87eEJjycEEPfD/TH/fosq6ze9UNoo4zwlys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985063; c=relaxed/simple;
	bh=gg25qhHUozmURV2g5k4pHl4UyRqIAIqQl3hDObxAYPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrSKpZrk1EuLvtrUax1ChtCRMOJNDEF3Qc1CO5DGJUN8F4f5UHqy1U4FLd4SZFetuMkW3SjUdmylU2GsiN/MRw08Pw978Q7iq3/CsLo93htvJgVB2IkM32R22+NY3Z/Ryiq0fZuCIVj982QwZo1krRqQAZ2ffFk1MVC4YjlMVI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=ymT57+DF; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="ymT57+DF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description; bh=z5n4EYuINE3lAyBylaDRVh3cEp86bCNaJ116BMmwFWk=; b=ymT5
	7+DF+D5hn3VwY25LXKxx/HdFC+X1Z8cetN8yQ12h4vvEYeWTA70EZLzN3ubLqsFsSdpTHuOKRxMJM
	cmfHt3ecgH6bzLoxiPOhkqHAmJIX/cURpjFPzNljsM42Okx5i3IYA4wwyHX78Kb4yJFLmXoF24LQF
	NlzT/z6TP8y0NXYlHf4qRAWWDOu1IPoFiIxav1s/W41rgY3Dczn5MUomt12t6TwGYKTg0U3E0NJvC
	nWmptgXPr465KbX2xGtOiut/sGCUXk3R3uWYlrZ6DtchfTZtFR+oK2A4IxxWxrlmdC9KWSXosQE4M
	Yel7xNso/45QOESv5OrfiAdg6OUgGw==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1x8aXc-003NLm-0y;
	Mon, 21 Sep 2026 09:42:28 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Sebastian Reichel <sre@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] power: supply: axp20x_usb: Introduce a helper variable for &pdev->dev
Date: Mon, 21 Sep 2026 11:41:48 +0200
Message-ID:  <f0e6c7ff8dce9f1a0903d83ff3ef782a18cd63d2.1789983244.git.ukleinek@debian.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1789983244.git.ukleinek@debian.org>
References: <cover.1789983244.git.ukleinek@debian.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4334; i=ukleinek@debian.org; h=from:subject:message-id; bh=gg25qhHUozmURV2g5k4pHl4UyRqIAIqQl3hDObxAYPM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqsPvjiafXGoLxesODdahFOU+e6atbmpRTM0yF2 iLKziXDGwGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarD74wAKCRCPgPtYfRL+ Ti9vB/4+GuWh2fvmIIBHPWUBvzXw7O4aTj6h58z50JeVFMaFEDz3imlgHvO6bl/bVfwVHHQoaTo mxUKQHNMFJu/5sXgbu5Gs58Ghn6abt8k/mZ4aiB/JFtQtzV95vjSTdMDzC6uR2g+/9NolRXhIUC JU7TLcYiEaZjyEaDJ91DdQwcy8y1VBCvClbLVZkZFpqjcpU++97BWrzb7Nqee+6kOsS3he9+0wc 9Rl4CtsQZcuRXcpn01Tayo3LbxDrNKh0+9cuIf1vpO9zYR45nI6q3anD7Mxzjmle+5u1oZ7EBAi 6DJ7VY8ym/hoLmScaCQofjfS8H81YSElooN93Wj/Ldf9CP1J
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

With the next commit adding several new usages of &pdev->dev, a helper
variable is well justified. To not clutter that commit, split out the
introduction of the helper out in this separate change to simplify
review.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/power/supply/axp20x_usb_power.c | 34 ++++++++++++-------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 463f9fe35cec..7ee3ec49d695 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -918,70 +918,70 @@ static void axp20x_usb_power_parse_dt(struct device *dev,
 
 static int axp20x_usb_power_probe(struct platform_device *pdev)
 {
-	struct axp20x_dev *axp20x = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct axp20x_dev *axp20x = dev_get_drvdata(dev->parent);
 	struct power_supply_config psy_cfg = {};
 	struct axp20x_usb_power *power;
 	const struct axp_data *axp_data;
 	int i, irq, ret;
 
 	if (!axp20x) {
-		dev_err(&pdev->dev, "Parent drvdata not set\n");
+		dev_err(dev, "Parent drvdata not set\n");
 		return -EINVAL;
 	}
 
-	axp_data = of_device_get_match_data(&pdev->dev);
+	axp_data = of_device_get_match_data(dev);
 
-	power = devm_kzalloc(&pdev->dev,
-			     struct_size(power, irqs, axp_data->num_irq_names),
+	power = devm_kzalloc(dev, struct_size(power, irqs, axp_data->num_irq_names),
 			     GFP_KERNEL);
 	if (!power)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, power);
 
-	power->dev = &pdev->dev;
+	power->dev = dev;
 	power->axp_data = axp_data;
 	power->regmap = axp20x->regmap;
 	power->num_irqs = axp_data->num_irq_names;
 
-	power->curr_lim_fld = devm_regmap_field_alloc(&pdev->dev, power->regmap,
+	power->curr_lim_fld = devm_regmap_field_alloc(dev, power->regmap,
 						      axp_data->curr_lim_fld);
 	if (IS_ERR(power->curr_lim_fld))
 		return PTR_ERR(power->curr_lim_fld);
 
-	axp20x_usb_power_parse_dt(&pdev->dev, power);
+	axp20x_usb_power_parse_dt(dev, power);
 
-	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+	ret = axp20x_regmap_field_alloc_optional(dev, power->regmap,
 						 axp_data->vbus_valid_bit,
 						 &power->vbus_valid_bit);
 	if (ret)
 		return ret;
 
-	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+	ret = axp20x_regmap_field_alloc_optional(dev, power->regmap,
 						 axp_data->vbus_mon_bit,
 						 &power->vbus_mon_bit);
 	if (ret)
 		return ret;
 
-	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+	ret = axp20x_regmap_field_alloc_optional(dev, power->regmap,
 						 axp_data->usb_bc_en_bit,
 						 &power->usb_bc_en_bit);
 	if (ret)
 		return ret;
 
-	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+	ret = axp20x_regmap_field_alloc_optional(dev, power->regmap,
 						 axp_data->usb_bc_det_fld,
 						 &power->usb_bc_det_fld);
 	if (ret)
 		return ret;
 
-	ret = axp20x_regmap_field_alloc_optional(&pdev->dev, power->regmap,
+	ret = axp20x_regmap_field_alloc_optional(dev, power->regmap,
 						 axp_data->vbus_disable_bit,
 						 &power->vbus_disable_bit);
 	if (ret)
 		return ret;
 
-	ret = devm_delayed_work_autocancel(&pdev->dev, &power->vbus_detect,
+	ret = devm_delayed_work_autocancel(dev, &power->vbus_detect,
 					   axp_data->axp20x_read_vbus);
 	if (ret)
 		return ret;
@@ -1008,10 +1008,10 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			return ret;
 	}
 
-	psy_cfg.fwnode = dev_fwnode(&pdev->dev);
+	psy_cfg.fwnode = dev_fwnode(dev);
 	psy_cfg.drv_data = power;
 
-	power->supply = devm_power_supply_register(&pdev->dev,
+	power->supply = devm_power_supply_register(dev,
 						   axp_data->power_desc,
 						   &psy_cfg);
 	if (IS_ERR(power->supply))
@@ -1024,7 +1024,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			return irq;
 
 		power->irqs[i] = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
-		ret = devm_request_any_context_irq(&pdev->dev, power->irqs[i],
+		ret = devm_request_any_context_irq(dev, power->irqs[i],
 						   axp20x_usb_power_irq, 0,
 						   DRVNAME, power);
 		if (ret < 0)
-- 
2.47.3

