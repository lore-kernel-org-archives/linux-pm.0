Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52C46D2A6;
	Mon, 21 Sep 2026 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985059; cv=none; b=aZxV+xq5hiRJ6jzLx70L1T/UJrNy/jWFAjppF4Rq0b+lTgg75WI5VuG84YEGzY1oxSFm0cAB3HgT1w07QrpvXdBQH/eEld8MWDfwIdNK9wqmp4rK3/tAC4sQyeKCiBJ/0dJOlWdeYNNbMqXsBLg3OafQCaUIThD+zsvh2CciRds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985059; c=relaxed/simple;
	bh=o8tkEtfdaCLslGnC7wOOlGKIAZ3lpJ9QEspVa1+MQcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FoEnUyWNaAPwNEygFH7Irw6m6S9PU/lGQ/gKOgSfnYDNucdFXNs0GgUIaIMtq+jVxKRahXZV3uTMuPszdJvNgvHWgtdjFRaMUOWbzGGF9P9NVzPirMwgGWjLM0uRAjEMN1A1EVn8WkZIPa27oBhe7DvbDDCz4nmsw7dn7vCcCVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=a2CuvkH4; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="a2CuvkH4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description; bh=sex8s1aAK4pDSoD9g8Psig1XFq5ZelUJOPbZALqcOA0=; b=a2Cu
	vkH4irWghq/a7o76/vQSJexagV5gHG6L6UrI6pJ1vcFkOXpYQ0/T2PhmSIBFuYpQq8l/jOGiUCyVr
	P28wkdCc+k5zuTZqOr7/vU4XnLZvoTItIyQtKixa8xrN5tErfcFNZiqDXSpshfrGCov3Ya0j7B7i/
	qttw65JcNIYEVtvFJNxW/ZUOX5G9u7owZdrQSJCAqZyKA8jStZSu8SwtOqNenhmtv2AivJj/0szV9
	azo5JvpSVH6aduuCF5Lya4q68F6v/bGWuRfZ/i5wJrnLWy6wTG6SPTj/9bOYwnTwRtL4rKLLl5ISt
	fdQOGt8xDFK40tRkgzi+5d5l1SmXxQ==;
Received: from ukleinek by master.debian.org with local (Exim 4.96)
	(envelope-from <ukleinek@master.debian.org>)
	id 1x8aXc-003NLx-34;
	Mon, 21 Sep 2026 09:42:28 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Sebastian Reichel <sre@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] power: supply: axp20x_usb: Improve probe error reporting
Date: Mon, 21 Sep 2026 11:41:49 +0200
Message-ID:  <b699f8251afed736af454a981630926e45eb7da7.1789983244.git.ukleinek@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2530; i=ukleinek@debian.org; h=from:subject:message-id; bh=o8tkEtfdaCLslGnC7wOOlGKIAZ3lpJ9QEspVa1+MQcE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqsPvlMhq722loO0BAZOdRKkNGKPvrINNsWRu9h jEj/giuHDGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCarD75QAKCRCPgPtYfRL+ ThiZCAC0DT90Y3g9lKVDJJq44XlyIGCgx6fen/3X749gu/KzRWYXu0U4UYkTM7r4PxTbw6xWFPb NKk3m/WO+jYdW5vEPhqJOvtwLVs1rQ8KigeCiWhbutbnhX0LCOEqAwvT08CyJhB+0c+wG96CZ+s aVwE3qw1FQULC3stpobkHoNWN5C3H8knjkPPKHbB17oaNG8DJNBMvBvJ0bXEAq5aeGJ/xD277cx trZdM1jFTVM3JBaB2hpyec6rBQ7Tl70OcFVXbJayISlA2ZeaiByPtUnjbpzhw6ZbgVmrV7HvBR0 ggw6tET1Xggjxzf6V7IVrsphSmdiaceDzuQcfMUcZRz88BBs
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Don't be silent about probe fail issues. Just having axp20x-usb-power-supply
in /sys/kernel/debug/devices_deferred without a reason is making it harder
than necessary to debug the actual issue. So be a bit more cooperative and
add an error message for the typical failure points.

Exit paths where the error is -ENOMEM and register write failures are
skipped, these should be quite obvious even without a dedicated error
message.

Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
 drivers/power/supply/axp20x_usb_power.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/axp20x_usb_power.c b/drivers/power/supply/axp20x_usb_power.c
index 7ee3ec49d695..7625366104bc 100644
--- a/drivers/power/supply/axp20x_usb_power.c
+++ b/drivers/power/supply/axp20x_usb_power.c
@@ -925,10 +925,8 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 	const struct axp_data *axp_data;
 	int i, irq, ret;
 
-	if (!axp20x) {
-		dev_err(dev, "Parent drvdata not set\n");
-		return -EINVAL;
-	}
+	if (!axp20x)
+		return dev_err_probe(dev, -EINVAL, "Parent drvdata not set\n");
 
 	axp_data = of_device_get_match_data(dev);
 
@@ -998,7 +996,9 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 			ret = axp_data->axp20x_cfg_adc_reg(power);
 
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret,
+					     "Failed to initialize for %s usage\n",
+					     IS_ENABLED(CONFIG_AXP20X_ADC) ? "iio" : "adc");
 	}
 
 	if (power->usb_bc_en_bit) {
@@ -1015,12 +1015,14 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 						   axp_data->power_desc,
 						   &psy_cfg);
 	if (IS_ERR(power->supply))
-		return PTR_ERR(power->supply);
+		return dev_err_probe(dev, PTR_ERR(power->supply),
+				     "Failed to register power supply\n");
 
 	/* Request irqs after registering, as irqs may trigger immediately */
 	for (i = 0; i < axp_data->num_irq_names; i++) {
 		irq = platform_get_irq_byname(pdev, axp_data->irq_names[i]);
 		if (irq < 0)
+			/* platform_get_irq_byname() already produced an error message */
 			return irq;
 
 		power->irqs[i] = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
@@ -1028,6 +1030,7 @@ static int axp20x_usb_power_probe(struct platform_device *pdev)
 						   axp20x_usb_power_irq, 0,
 						   DRVNAME, power);
 		if (ret < 0)
+			/* devm_request_any_context_irq() already produced an error message */
 			return ret;
 	}
 
-- 
2.47.3

