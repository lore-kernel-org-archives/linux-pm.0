Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FEF3E3D9E
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 15:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773847693; cv=none; b=Boihp7EStVCY+B3kTsW5vWKycqlkVCQ4ME2ZaVxq8XcJzudwilF2CQi3pI4nFinow6vh/zn931UEDaiKX23rNk8vgSu1fuyaU/JZ4chI+zxy0VV+B1qFsJOdrNMX10RIbE5DfYcZDqKFR0q3OgDkuZKBVsIB9yBapRB1tO3cOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773847693; c=relaxed/simple;
	bh=ZB2mXwiY6WLnAaRrQ82k9nOv6nRpmPd0asigL/Lb6kA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ch5Lwxx74uXZOewDdennPCMHv3KLhjWOsXyVN1+L10HXTTfJG5OqPmRI0igzsSiyPGWB0sPxqXUuSHm6iV7Irj+YDZv4Q0BVKuRGQXdQObKYVT3gULPmDfzy6zeh+4AzNGjGyi3BJynECtwXDNKmWVqyTYQBwMFJr3FoBLW4A5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HOVVT1JL; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HOVVT1JL"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8f97c626aaso147894366b.2
        for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773847682; x=1774452482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OmOSgH2/TrtS7qixNkttWcSY4QBZ3ekluiBJZ/v3k4=;
        b=HOVVT1JLm36OgYO0ojfgFmUgMxFbQ51cl2OBzcxZyDJ91TZwU52DtAHM/E+gYggaHV
         0EAjK6hKGtylSeLqVfoe9BiAO1j41UvIxuHP943D1SGe5eFQ1zCKCO19T5DdjtLDXaZa
         AroDXEh+xXguHlLAmFI7aQXQ4vpjEkPOwkH2wcyxpw7E0DMQ+fbIHm/0JvKT2Rzd5w4f
         PRGqKwCR/HQpwO3GIW8ZLKa9IDu0OZ4NOJ4UeIRlMHVIdYOJcLNubRk24kzjcI+8TyML
         Lv8or/HI93ruuNZ7RlIGenZhuqRUTJ3vRrM5s5FU5AU6S9ABaou2UWuqWoa2dK8NeXvO
         gwlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773847682; x=1774452482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6OmOSgH2/TrtS7qixNkttWcSY4QBZ3ekluiBJZ/v3k4=;
        b=Ceel5Z4EvdPHk+4ZhZeFe5DS7a0hSEZotqc0Vk9qWyPfULeUkwYHOP4kpc4lV+kJaG
         4EHcl7B7AbUmhjXF5Ub1QDCj+iaRsdWMQW7pReVUoddlivosWcoCwnizqXZeOBT/vRyf
         f4JhR+mfLIy9Dm0l/kHzqWDh2adOPDakmGw6VXfX3iGBxm23q7Xa/8TCrCV3eMNbcWow
         veOHutnh77Vx4Bgfgr2/3ZHDSG/aJdVj74Es4WEi3VGK+fLu2cfOZbHrArXOJaPGuKSC
         PNqNjF3mSTIE+BMn5EE6DddzEkfCeZ/yIJtoR9hU5RSqKzwqyP05Qg0PFhcuSK83cklS
         T/2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX6UvYjkHVU/ihjD2GmP5tl05yGtFSRInQGc9bNmyV0sb/LaJ6TcgJPLJBGwwOLioWP+A8lq15Ulg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrpqU21UzaGZvyB6YlpFv63EjwLP9Yh31iqvDqLAbLkIrJhHeR
	6pOMWuoROKe26pY+pLUWGSGjYMyWet2PC8enT+ziZ6+yQ65T+jqOWKwChfLIrUeALTQ=
X-Gm-Gg: ATEYQzyZCMlC3J08aY1OmWWASPkV68o0m1fVnsZwt16bEQoDMQLQoZRQG4zexazfHCa
	5jY/4Hs2AB5MCqNnwCCZPpBga+SjKCfsaCRzQlEmOC9e21B9dbIZ9xoAFXfNq7WF+J+D7wAazza
	CRheGpVsf/0ZP/Rq/Vt/4puudwHq8cwSK+BwNsM5DRrVQigAU3TBmO2AtFP3qHvgfgy1PO/nRyU
	WxWigJRxRllJj2En+U3RtPVWrIKbYJ4Z7CIi48TcYkrrAq65gdhXSEA3Mz4bNzDeglR2Ope2uyz
	W694XF9eZQYNGaKrLD4eLs2wgWSWNXEZPe7YNz1j3QGw2xICzx8mxpl7GCHZVueW7/j74wNrj1I
	5PW480nQBQYTuPDC99dz4Mq37AfnAxtkgrG9rfkqnBFbwpZNrIwDvnuqOGG0NU51m1z3maxMdEs
	nyYDb4PwJNdjXmu3Aefy7j00p7bSpJAR1KfjmgJWdtWkmVE2o1FQxWuLecCz3NMv+KBntzf98Ha
	vovX00/I61BoZQ=
X-Received: by 2002:a17:906:4fc6:b0:b97:c45a:840f with SMTP id a640c23a62f3a-b97f4a73bfdmr272840266b.32.1773847681503;
        Wed, 18 Mar 2026 08:28:01 -0700 (PDT)
Received: from puffmais2.c.googlers.com (221.210.91.34.bc.googleusercontent.com. [34.91.210.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f173a3e3sm226989566b.61.2026.03.18.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:28:01 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 18 Mar 2026 15:27:50 +0000
Subject: [PATCH v8 05/10] pmdomain: samsung: convert to using regmap
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260318-gs101-pd-v8-5-241523460b10@linaro.org>
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

In preparation for supporting such SoCs convert the existing mmio
accesses to using a regmap wrapper.

With this change in place, a follow-up patch can update the driver to
optionally acquire the PMU-created regmap without having to change the
rest of the code.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
There is one checkpatch warning, relating to the non-const
regmap_config. It can not easily be made const at this stage, but a
follow-up patch allows us to make it const and the warning will go away
anyway.

v8:
- add missing \n in some of the new log messages

v4:
- rework the loop in exynos_pd_power() slightly, to not return 0 early
  to allow more code to be run after pd on/off register write without
  changing the loop again, required for gs101.
- add error message in case first regmap write in exynos_pd_power() fails
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 83 +++++++++++++++++++++-------
 1 file changed, 62 insertions(+), 21 deletions(-)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index 5c3aa8983087..68b1e7ba8729 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -9,15 +9,14 @@
 // conjunction with runtime-pm. Support for both device-tree and non-device-tree
 // based power domain support is included.
 
-#include <linux/io.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/pm_domain.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/pm_runtime.h>
+#include <linux/regmap.h>
 
 struct exynos_pm_domain_config {
 	/* Value for LOCAL_PWR_CFG and STATUS fields for each domain */
@@ -28,7 +27,7 @@ struct exynos_pm_domain_config {
  * Exynos specific wrapper around the generic power domain
  */
 struct exynos_pm_domain {
-	void __iomem *base;
+	struct regmap *regmap;
 	struct generic_pm_domain pd;
 	u32 local_pwr_cfg;
 };
@@ -36,31 +35,42 @@ struct exynos_pm_domain {
 static int exynos_pd_power(struct generic_pm_domain *domain, bool power_on)
 {
 	struct exynos_pm_domain *pd;
-	void __iomem *base;
 	u32 timeout, pwr;
-	char *op;
+	int err;
 
 	pd = container_of(domain, struct exynos_pm_domain, pd);
-	base = pd->base;
 
 	pwr = power_on ? pd->local_pwr_cfg : 0;
-	writel_relaxed(pwr, base);
+	err = regmap_write(pd->regmap, 0, pwr);
+	if (err) {
+		pr_err("Regmap write for power domain %s %sable failed: %d\n",
+		       domain->name, power_on ? "en" : "dis", err);
+		return err;
+	}
 
 	/* Wait max 1ms */
 	timeout = 10;
-
-	while ((readl_relaxed(base + 0x4) & pd->local_pwr_cfg) != pwr) {
-		if (!timeout) {
-			op = (power_on) ? "enable" : "disable";
-			pr_err("Power domain %s %s failed\n", domain->name, op);
-			return -ETIMEDOUT;
+	while (timeout-- > 0) {
+		unsigned int val;
+
+		err = regmap_read(pd->regmap, 0x4, &val);
+		if (err || ((val & pd->local_pwr_cfg) != pwr)) {
+			cpu_relax();
+			usleep_range(80, 100);
+			continue;
 		}
-		timeout--;
-		cpu_relax();
-		usleep_range(80, 100);
+
+		break;
 	}
 
-	return 0;
+	if (!timeout && !err)
+		/* Only return timeout if no other error also occurred. */
+		err = -ETIMEDOUT;
+	if (err)
+		pr_err("Power domain %s %sable failed: %d\n", domain->name,
+		       power_on ? "en" : "dis", err);
+
+	return err;
 }
 
 static int exynos_pd_power_on(struct generic_pm_domain *domain)
@@ -109,8 +119,18 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	struct of_phandle_args child, parent;
 	struct exynos_pm_domain *pd;
+	struct resource *res;
+	void __iomem *base;
+	unsigned int val;
 	int on, ret;
 
+	struct regmap_config reg_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.use_relaxed_mmio = true,
+	};
+
 	pm_domain_cfg = of_device_get_match_data(dev);
 	pd = devm_kzalloc(dev, sizeof(*pd), GFP_KERNEL);
 	if (!pd)
@@ -120,9 +140,26 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	if (!pd->pd.name)
 		return -ENOMEM;
 
-	pd->base = of_iomap(np, 0);
-	if (!pd->base)
-		return -ENODEV;
+	/*
+	 * The resource typically points into the address space of the PMU.
+	 * Therefore, avoid using devm_platform_get_and_ioremap_resource() and
+	 * instead use platform_get_resource() and devm_ioremap() to avoid
+	 * conflicts due to address space overlap.
+	 */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return dev_err_probe(dev, -ENXIO, "missing IO resources\n");
+
+	base = devm_ioremap(dev, res->start, resource_size(res));
+	if (!base)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to ioremap PMU regs\n");
+
+	reg_config.max_register = resource_size(res) - reg_config.reg_stride;
+	pd->regmap = devm_regmap_init_mmio(dev, base, &reg_config);
+	if (IS_ERR(pd->regmap))
+		return dev_err_probe(dev, PTR_ERR(base),
+				     "failed to init regmap\n");
 
 	pd->pd.power_off = exynos_pd_power_off;
 	pd->pd.power_on = exynos_pd_power_on;
@@ -137,7 +174,11 @@ static int exynos_pd_probe(struct platform_device *pdev)
 	    of_device_is_compatible(np, "samsung,exynos4210-pd"))
 		exynos_pd_power_off(&pd->pd);
 
-	on = readl_relaxed(pd->base + 0x4) & pd->local_pwr_cfg;
+	ret = regmap_read(pd->regmap, 0x4, &val);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read status\n");
+
+	on = val & pd->local_pwr_cfg;
 
 	pm_genpd_init(&pd->pd, NULL, !on);
 	ret = of_genpd_add_provider_simple(np, &pd->pd);

-- 
2.53.0.851.ga537e3e6e9-goog

