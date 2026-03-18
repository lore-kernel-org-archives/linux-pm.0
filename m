Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97423E5577
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847694; cv=none; b=kOVEZwVLXDvB5lZ0AzXfvMKdCfXh6zpEprKqYli9CqipYAnl3XGh6h5N/dv78nZWXxye1lNx6ip2cAFcFTnnv5JGWJFna+xyN2Y6uF34zCqDw+xiczTPUyubXftQmdfjWeImdZApxfuWkzdjgNK9+zmlXlLdrRrMlPX/ZG7Jvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847694; c=relaxed/simple;
	bh=dXXJ0JFFiPJa5gsAbYfOBbLVCxicEcA6VOArO5t8sE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzx08BI9POV7rIBdLrgPPJJkoLKlHLmlgAb5ZPtViu4F/Q5ME40Zyby4kCfBqNkYnLVN+5bTJKAcKBUsRtiiy82UMEFgOeVyS4e4uB8kzbyqL0nkIYZz3vkddZsI/yiz8qx5ycckeUuBHEOP/bIBDKVaLzJ3Y4MPJ4DGgVaiC8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WD6ya1xL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WD6ya1xL"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b97a9f4b4dcso481907466b.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773847684; x=1774452484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/+6mBPKyRHzZfHv/9qeLvEgXfBPcpvJNmyt49iF8ds=;
        b=WD6ya1xLD383pZlucf2L3neA7ONlx121PyGIFiqvDepTDXNXhmUb5/148GM+vkace5
         9CA0GldKmkbjRPpFhGxtIflp4fRcfR+5yzialryEnX1+Hfo/XIZU/idUOZlLnDxXd4xk
         gbhFak9+eaShDwOuC3XyvoiBHzhGonhBSQeJXvVt4H0joE0O9lZUWTer0xcA+iFtGPu6
         zLcicoSHIqgOODPefEcQEOb5xcQ/jB5qOYZGCurQxo3zYVAbMXufLbIpAvpkDBLocjA7
         7SzOxB4EK65Y4YqqjjjxpNqRKD8R7f7zFUbd9z3WlY0UTva0qhCNpcT3ncMxo2WkZoOi
         IfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847684; x=1774452484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=S/+6mBPKyRHzZfHv/9qeLvEgXfBPcpvJNmyt49iF8ds=;
        b=kMp11OCjlZUt421UdnkIhlXfYe1nORg9vemXOob32U9GbDuaDPoJVdseCxckB/yCMk
         s/Ggi0ZQKp3sW0J1h3uUZZquLUvlqshMKCF7E+3jDd5fgCxXNBNXwwx6E/7A+z7WALBg
         IJHdTsdZe4N8z1yTTB2aeUTfZJA8KHqZ6LdoBGUJdrRRqcUZfuqntj/axzxx6tKGIS8r
         7bD4pNJKxsSTIj6F+VEN2NigL/8oDUj5ADL8x3pKvmYPwOJIG7j9viBc7B71NmLCSaeB
         V4O7BM/5TzSZ7iO/IX6oXhYp4xiMxMmZmV9LTJiCnftpjCB75itABJ5z83jJl+QcMq3P
         a7Qw==
X-Forwarded-Encrypted: i=1; AJvYcCWjkqGgC0ljsNOOuk+c2qQCIvmcQ1vAum+XqqFPSvQPeUg/QW4jpoaaIx1z/8zw7vlZIishMXXZJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIltYbANbPoVOjdpex/PbLa3005UBtrx08XB9x/kmPiixeLMBd
	0/hjEo4Zsdefv6lWtc/TMtNHdCU4z71mTeh/i6nNnYu0nn4gtF1GEHauvGs9IOAvubs=
X-Gm-Gg: ATEYQzz9kuvZjZLjX8bnoySXbmm40ntyjNrmBZHX4IdNLhdFSoHN28sB7CZzLPEzdud
	vH4imQpkwTHNd4doBDLnx/Z4ZhdtbuHdBmiwMXlaI2fchG8FlgZ41smlcz4rYoSy08dVs4JOaP9
	Yb7/Z7KA7aGShrlbiVhsxGi0UN+hzhpaZDSJ3w4UNH/miRNI6WK08odmWYiw7kpv/PL3u0NWWZc
	sFLCs64O4YBlPJlp4nCywCuWOgmxQi7MYuemVyFpPivixljFHIzU8ozOdiRbZxiUKKoAYY68JFy
	eIyfFYFMISmkNvyDn6HqEIUB0gGxByC2aUyj6/+AIgwSQr4LYmhtJs5tb2kuoS96/p/LcXB6j/B
	vixktScspRuiRWxcLgfadwrLuVuMMmTnEJdTSXQbsJ7VuGpNRdXY1CGgzOOd023Me73TiyGsr0C
	u/TZfQV2cy7wyyitCd7R/luVv8I5mu3+Gw7sokYtopOS1q3qr69jditwnzw8srYod/QnTwNodLy
	9dIN4+DrupYjSc=
X-Received: by 2002:a17:906:2092:b0:b96:f0a0:c791 with SMTP id a640c23a62f3a-b97f479705cmr157898466b.9.1773847684124;
        Wed, 18 Mar 2026 08:28:04 -0700 (PDT)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3e3sm226989566b.61.2026.03.18.08.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:28:03 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 18 Mar 2026 15:27:53 +0000
Subject: [PATCH v8 08/10] pmdomain: samsung: use dev_err() instead of
 pr_err()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-gs101-pd-v8-8-241523460b10@linaro.org>
References: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
In-Reply-To: <20260318-gs101-pd-v8-0-241523460b10@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, Juan Yescas <jyescas@google.com>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3

dev_err() gives us more consistent error messages, which include the
device. Switch to using dev_err().

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index f8c0d11e9b33..6b0a0f395509 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -30,6 +30,7 @@ struct exynos_pm_domain_config {
  */
 struct exynos_pm_domain {
 	struct regmap *regmap;
+	struct device *dev;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
 	u32 configuration_reg;
@@ -47,8 +48,9 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	pwr = power_on ? pd->local_pwr_cfg : 0;
 	err = regmap_write(pd->regmap, pd->configuration_reg, pwr);
 	if (err) {
-		pr_err("Regmap write for power domain %s %sable failed: %d\n",
-		       domain->name, power_on ? "en" : "dis", err);
+		dev_err(pd->dev,
+			"Regmap write for power domain %s %sable failed: %d\n",
+			domain->name, power_on ? "en" : "dis", err);
 		return err;
 	}
 
@@ -71,8 +73,8 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 		/* Only return timeout if no other error also occurred. */
 		err = -ETIMEDOUT;
 	if (err)
-		pr_err("Power domain %s %sable failed: %d\n", domain->name,
-		       power_on ? "en" : "dis", err);
+		dev_err(pd->dev, "Power domain %s %sable failed: %d\n",
+			domain->name, power_on ? "en" : "dis", err);
 
 	return err;
 }
@@ -140,6 +142,8 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd)
 		return -ENOMEM;
 
+	pd->dev = dev;
+
 	pd->pd.name = exynos_get_domain_name(dev, np);
 	if (!pd->pd.name)
 		return -ENOMEM;

-- 
2.53.0.851.ga537e3e6e9-goog

