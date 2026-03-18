Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A323E4C63
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847691; cv=none; b=cYiCkrNQchX2LhtBr8HlLFVrhOQSny5p3jStCgLsp/W1k5JzANQCVyrhvAdEvTWhCSxLOW57dxwLRSNVGmcHqHxo77TmwIUj29FVwlCyAXZ88hCMhLc14llkncItJJi2yyeBGWpoqNSQqHRvrA88tTtmoPCA8ci7EoJxPK/7y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847691; c=relaxed/simple;
	bh=8T9/It5ApHDHnYD1q78TZh74X9foQBKZZLIC9h+az00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KTnErZJZJzZ9d4xiVgjpmRVHE8GVvHlbBRPzDips6/3lbWMWl1AIVJvMgwvixRi4Pz51gtQMAtKqFiBoYS9xwx+NdMdTLP/1fosiZflxft10XJsiengxWD07r2qrrfJrYmJ94HyhfD8JpIhDNKhtuXMiv+eQGgw0ZTAcARFmq0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaZmBis3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaZmBis3"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b97b1012d14so207401166b.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773847682; x=1774452482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FzTEmVg0E5h4X/7Ugq7xS1ujjrPpCimVnXzUPgyNm9M=;
        b=zaZmBis3OIvWv8Z/cmUga6MKezr9hCDKifTL7RAouUD9eApYwG2JrRpA2nr/P1RA64
         4poxjeQy0lZKo0Jo5NTNabTVG9RA6xvA9oc/qu2oAgrMah+ESz4rykw8Aa34nZWQaRR9
         3YS38tnv4Owg0Y6vT4bc/fEEJ5XabDqeO2YpV4s25y3Y6QaVZ8LOeOz9FJ4J3ZZ+AnEN
         XtGqt7moT3/WsVkD0KZR04g/ZtHIQEnlYxpoKzmvZKlWuDewJs7NYl93VxRJ+XENbShf
         ikhMM9pmrRzzKbS2EfSJvx5SprAedEqRxGIFAi5eizabPCDZRd6dVeJYQAsvqZTqIyVq
         GwCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847682; x=1774452482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FzTEmVg0E5h4X/7Ugq7xS1ujjrPpCimVnXzUPgyNm9M=;
        b=G4J/ru5CuJL/CLYxC1bfvpLwj6qtXVdL98/0d1m/AWW74EtypfjjqRq/xTvPDHwoHg
         Gc2idEvJHLIkBqwGlKEazPqJakBdoE9h7bRO71VOJLU1T6QapCCgJnHJyDABpnhc3rEc
         RvJsCDSAUfj/SA0h3s76bZd0n7/rpndMAAi7C3JFLWiZCjw7vTTWc8H9RkiVMDLD8OIB
         gqY7RT5018qaJscWzYMS56fGYwrDPaL77RDwc3eMAijFoQur/YA5uiS4yfPQmv4aDK+g
         wy4L3hM0XUE1OXWuk9bYTB5XOAtyXz0AH+2vASNinyLld3Er4cLQm1TLP6UEcv1AJp24
         l4jg==
X-Forwarded-Encrypted: i=1; AJvYcCUzzQL6tQ8BP5R3JHZcoi5eKi4+JwlnRMZVaJr+oH7qqEdM9V9jR457e/c1tgruA2GhJYO+yPdERA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzB2q7TAQQg4Q7v+QYAlMcDtdNNvvut9VyxLP8Ikq3W5K8dXvQt
	mjTdn0xc5zhWXDxMc/Rwkq0gQm8jy77ncFkUGVXXRr5NW3qJ9FVAlSo7qI0BiMpRPFA=
X-Gm-Gg: ATEYQzxNJP5KLJXRTN/EONsIZR+k88MnjkhI86SFTspU+96eUlMk+SctmihjdHPAvMG
	Xf0HF9V3OTukKD3I/audMJJ6/mQ/otjWvibiW0Kqa4Jj4WjlV/Su/KO86DnCJ4LycWM42ur8bTd
	BrqxIZk62Ej2PkdU23b+L935PzhdfuB3qpzok7i6PD8QKZqFUxkgvB8Kllx7haEE9O0mceK/k2/
	nSAZNTCyM6ZSZNXQeezIF8v+EDA/DxvH+4m4K9flZ2uTmOXkxxne5bNnA6dFt3wZFHVPMXjayVy
	NRrFCb4oeWVxeap4m6If1L47qhqMrcTqbGE7rcBgpVcmyPODqb8qBnECn6Cx6uwoS4pHpmJhL/W
	6UBJOG1MD2u7jtHs7f6IvA8vsX+iE8ruplfgcBQ9hJRxwE9G70dUo41Aouxf0Go3dGj7l4On5gW
	5hcMbroSjzuo7+gsE0gBp8ekKueCE42miduSmDlMSohY7aLpYBXDJ1XcZDodXGm1x7KkpZ+aI4e
	kl8cA51qyAKflU=
X-Received: by 2002:a17:907:e11c:b0:b97:73ae:e2e with SMTP id a640c23a62f3a-b980f9e248amr256966b.18.1773847682061;
        Wed, 18 Mar 2026 08:28:02 -0700 (PDT)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3e3sm226989566b.61.2026.03.18.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:28:01 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 18 Mar 2026 15:27:51 +0000
Subject: [PATCH v8 06/10] pmdomain: samsung: don't hard-code offset for
 registers to 0 and 4
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-gs101-pd-v8-6-241523460b10@linaro.org>
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
 Marek Szyprowski <m.szyprowski@samsung.com>
X-Mailer: b4 0.14.3

On platforms such as Google gs101, direct mmio register access to the
PMU registers doesn't necessarily work and access must happen via a
regmap created by the PMU driver instead.

When such a regmap is used it will cover the complete PMU memory region
rather than individual power domains. This means the register offsets
for the configuration and status registers will have to take the power
domain offsets into account, rather than unconditionally hard-coding 0
and 4 respectively.

Update the code to allow that.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 68b1e7ba8729..3aba00b9ddef 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -30,6 +30,8 @@ struct exynos_pm_domain {
 	struct regmap *regmap;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
+	u32 configuration_reg;
+	u32 status_reg;
 };
 
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
@@ -41,7 +43,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	pd = container_of(domain, struct exynos_pm_domain, pd);
 
 	pwr = power_on ? pd->local_pwr_cfg : 0;
-	err = regmap_write(pd->regmap, 0, pwr);
+	err = regmap_write(pd->regmap, pd->configuration_reg, pwr);
 	if (err) {
 		pr_err("Regmap write for power domain %s %sable failed: %d\n",
 		       domain->name, power_on ? "en" : "dis", err);
@@ -53,7 +55,7 @@ static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 	while (timeout-- > 0) {
 		unsigned int val;
 
-		err = regmap_read(pd->regmap, 0x4, &val);
+		err = regmap_read(pd->regmap, pd->status_reg, &val);
 		if (err || ((val & pd->local_pwr_cfg) != pwr)) {
 			cpu_relax();
 			usleep_range(80, 100);
@@ -164,6 +166,8 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
 	pd->local_pwr_cfg = pm_domain_cfg->local_pwr_cfg;
+	pd->configuration_reg += 0;
+	pd->status_reg += 4;
 
 	/*
 	 * Some Samsung platforms with bootloaders turning on the splash-screen
@@ -174,7 +178,7 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	    of_device_is_compatible(np, "samsung,exynos4210-pd"))
 		exynos_pd_power_off(&pd->pd);
 
-	ret = regmap_read(pd->regmap, 0x4, &val);
+	ret = regmap_read(pd->regmap, pd->status_reg, &val);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to read status\n");
 

-- 
2.53.0.851.ga537e3e6e9-goog

