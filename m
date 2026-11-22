Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341579;
	b=3zvIEHMmxOlY5CYv9QTUztzg8ZA/9f/rdpu0UJKpY+HTZAJF9xZnR6mFBNx87mr4HZhL
	 L0E02KyR2x02rVGKe2XA/MlM/VrBihzCwyNcwIbRua0GRsovIIOlFH/99hWPQ4ITBKXvM
	 /knFwxZ/B19mveGqUzoQWETkSTHFoIM2rPs34W4GvE2cwssXebM2Cnu2SipzFpb8ADn9S
	 lB1t30gOBVj717QPOkkqlDzhS6m2yY8mBbxkTuU8MRvbWKy78K4XFwBQGged0FpsjtmKE
	 GvNnY8Ep3O3VatJ+s64nIM0tO5Op2Sp3Wd9HaPHPiuCzi8gN843Qy+qjU0uai5pujFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cF6KDJqu5o+VLH6VEzsmCco4XJ4A1kM2QuOlapez290=;
	b=3yoIFJuOHVOKloQh/Q450hmJNAsCsGM+lDDKw2Q2RphzpdQe/b5CWOWIJaF/Pi/FdLDn
	 dWJ2t8g0gFX7xbdwF5LSdGOlZRUGeCRZM8hmHs05osEgM+TWqjZbebGSKPempOrea033d
	 q9Vnv5yyfuWORzCgAzkLhYeqO6qhqTL3KIhYUiQRNJK2KaiqiS2k3gV8EDpqBwZMH65j7
	 ZyzB8l38j6A83voyj1uETr0LZhbaftcdl/Z/O2osTEqJ9fZS8YoGASAVboH33hOhYf0s7
	 VgLtFn3fk5uBflEPXXnD5Q6fVZIEDBO5ECIFq9JBfkoNVKY2IWGpij+wo4SSuoZpsVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=UoDqc+Mo;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98D606A320
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 09:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C98D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=UoDqc+Mo
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso29523025e9.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 01:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795341576; x=1795946376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cF6KDJqu5o+VLH6VEzsmCco4XJ4A1kM2QuOlapez290=;
        b=UoDqc+Mo0dPIAA3NFHfL11f9YXl/COpr9xXzmmoUqWzeKXpItQyH20ai1zyEsA1SF7
         5+vOXWFk3H0Z+kKa7ersCA5pHoT2AjoPjiZVpcnEhWfBp3ZLsklKtZ0yuqfeqWCWZ5gc
         W8SLmKgmPfdkV8ZoPptZOeGf1o09+K7dTIkGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795341576; x=1795946376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cF6KDJqu5o+VLH6VEzsmCco4XJ4A1kM2QuOlapez290=;
        b=DgDeYrLmSB7DVm8OL7nHNsuuxpCohSNWFcKitBhtXLuGOQVrerz5vkZ7XygkicJkoZ
         ja6BZWjR1JJhgDKErzoP+z6IDbEvgN6eFqD6IhDX+GCRnB7GhsKEXUNXHWNQG/cY8KpG
         Q50VQfI4bbWDRZwDqn0/89KFReGbkyWCRrpk/AgIdaE6oi1EOnBO9L+Xa+sccgf5OFH+
         zfvjFz/kmnvs6dbRi8DRFmquzY2uuIWO6TA4TEWHbaIPIn5S1jdPSVG4+NVInLUlDJPC
         ESgoV81e0LhmhHiDKn7ZXtgPdoGkd17/P9VPfZyTDrqje0BUvU6GCclLgGjbmK+xa1kr
         7cxg==
X-Forwarded-Encrypted: i=1; AL+hErEUX6tGxi8ikKjf/66z04PifdDaNCTi2EcjLTSZZDm/Vt+P63mibrFbywyeVpFj+vup4ajX8dZdrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z985wRfqUhVPxUS9o0W1nQ7gUwtQ3eLGvgC7D7yMHbXb4oRAggV
	HNcFR/6mVpo89Yl0CbrGlGDYxHFXnsXjJC5M/w/GpA7CHgpomn7pLdxmQq9YVVqJ3qk=
X-Gm-Gg: AZFdTZf7bQPtc9+YeyjRZPB7kAvEpcKjNNKGzOuHksa0YYqLuNBtGtwT8BRphOxr8U5
	SsQxEVMVg11HzoxK8mB7mY7JURlMRk0I7qK4/MOsv0Jx5BbrapE3vxnzKRCjMBkw2udqtWNY3rk
	vihxX63S49oTdSkxlMYEiU1j3HCfO7EGPPfSbVLpqq45RYr+0yxcCeb1SfpvZCxn8G2DVSY4CD7
	RoRCGVNpddVET1eSnoEP4rzW9qHlVzE/al4O3lODN1UynFOxa/XS8H95tc6QYWSZF92jGYUMkbq
	aVnsjGlk/vhcpnGMvcl0c7UFsEh/0SCaNt3lWWs/9oZ2ZT1DeZtTygBZq4SJEDJ9FwL+wkfLj8O
	sCV2vlbJK58OWCoiGDxJ6CiBfSrm0i6vTUokHowGXioRLc/YQWTbfoSFeuOrIhDuDfVz1OPTLqh
	yO58HfDJYDWJMBrfkkXHwu1JjFYXesjvM1RM1m5k7LGq9wLFuphYnurcw+Z6iCoF91SATqIXqQd
	mAwSkPUhyJaS9Ug9aDU3BRA82MMheWQfl0gchrL63reIU1d2b2rMTocN7COClTOHiIbbGQMPa71
	jRdYX+/BjggyomPNTEKfi7ZfQQII+EFdDkgXkCfrrW47YyYqiww6PoXt+IMo7URV/ZZ4soZ2nNP
	dVGpF4YJ76ksS+vHuvLvD+EsGQbRuu70X6DrCiUS1z0CwRP+vdXYJ9rpWCCj8mAW1JVrIxalR7o
	2pxZTQrhtEcqwZcjSU2SLorFMMWw==
X-Received: by 2002:a05:600c:e553:b0:4bb:9457:3c93 with SMTP id 5b1f17b1804b1-4bb94573c9amr35158925e9.2.1795341576638;
        Sun, 22 Nov 2026 01:59:36 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm342455265e9.13.2026.11.22.01.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:59:36 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Lucas Stach <l.stach@pengutronix.de>,
	Peng Fan <peng.fan@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 2/4] pmdomain: imx: gpcv2: Keep the domains left on by the bootloader
Date: Sun, 22 Nov 2026 10:59:17 +0100
Message-ID: <20261122095927.2631909-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122095927.2631909-1-dario.binacchi@amarulasolutions.com>
References: <20261122095927.2631909-1-dario.binacchi@amarulasolutions.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PGC domains are all registered as off, so a domain left on by the
bootloader, e.g. DISPMIX to show a splash screen, is powered up again
by its first consumer. On the i.MX8MN this turns the display off and
hangs the system.

The GPC does not report the power state of a domain, but the ADB400
bridge acknowledges the power-up handshake only while the domain is
powered. Use it to register as on the domains left on by the
bootloader.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Release the resources of the domains left on when the driver is
  removed

 drivers/pmdomain/imx/gpcv2.c | 77 +++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 6a54ee734514..71e551f0471d 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -292,6 +292,7 @@ struct imx_pgc_domain {
 
 	const int voltage;
 	const bool keep_clocks;
+	bool boot_on;	/* Left on by the bootloader */
 	struct device *dev;
 
 	unsigned int pgc_sw_pup_reg;
@@ -488,6 +489,8 @@ static int imx_pgc_power_down(struct generic_pm_domain *genpd)
 
 	pm_runtime_put_sync_suspend(domain->dev);
 
+	domain->boot_on = false;
+
 	return 0;
 
 out_clk_disable:
@@ -1315,9 +1318,27 @@ static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
 	.pgc_regs = &imx7_pgc_regs,
 };
 
+/*
+ * The GPC does not report the power state of a domain, but the ADB400
+ * acknowledges the power-up handshake only while the domain is powered.
+ */
+static bool imx_pgc_domain_is_on(struct imx_pgc_domain *domain)
+{
+	u32 val;
+
+	if (!domain->bits.hskack)
+		return false;
+
+	if (regmap_read(domain->regmap, domain->regs->hsk, &val))
+		return false;
+
+	return (val & domain->bits.hskack) == domain->bits.hskack;
+}
+
 static int imx_pgc_domain_probe(struct platform_device *pdev)
 {
 	struct imx_pgc_domain *domain = pdev->dev.platform_data;
+	bool init_off;
 	int ret;
 
 	domain->dev = &pdev->dev;
@@ -1348,12 +1369,44 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 		regmap_update_bits(domain->regmap, domain->regs->map,
 				   domain->bits.map, domain->bits.map);
 
-	ret = pm_genpd_init(&domain->genpd, NULL, true);
+	init_off = !imx_pgc_domain_is_on(domain);
+	ret = pm_genpd_init(&domain->genpd, NULL, init_off);
 	if (ret) {
 		dev_err_probe(domain->dev, ret, "Failed to init power domain\n");
 		goto out_domain_unmap;
 	}
 
+	/* Balance the first imx_pgc_power_down() */
+	if (!init_off) {
+		ret = pm_runtime_resume_and_get(domain->dev);
+		if (ret < 0) {
+			dev_err_probe(domain->dev, ret,
+				      "Failed to resume domain\n");
+			goto out_genpd_remove;
+		}
+
+		if (!IS_ERR(domain->regulator)) {
+			ret = regulator_enable(domain->regulator);
+			if (ret) {
+				dev_err_probe(domain->dev, ret,
+					      "Failed to enable domain's regulator\n");
+				goto out_put_pm;
+			}
+		}
+
+		if (domain->keep_clocks) {
+			ret = clk_bulk_prepare_enable(domain->num_clks,
+						      domain->clks);
+			if (ret) {
+				dev_err_probe(domain->dev, ret,
+					      "Failed to enable domain's clocks\n");
+				goto out_regulator_disable;
+			}
+		}
+
+		domain->boot_on = true;
+	}
+
 	if (IS_ENABLED(CONFIG_LOCKDEP) &&
 	    of_property_present(domain->dev->of_node, "power-domains"))
 		lockdep_set_subclass(&domain->genpd.mlock, 1);
@@ -1362,11 +1415,20 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
 					   &domain->genpd);
 	if (ret) {
 		dev_err_probe(domain->dev, ret, "Failed to add genpd provider\n");
-		goto out_genpd_remove;
+		goto out_clk_disable;
 	}
 
 	return 0;
 
+out_clk_disable:
+	if (!init_off && domain->keep_clocks)
+		clk_bulk_disable_unprepare(domain->num_clks, domain->clks);
+out_regulator_disable:
+	if (!init_off && !IS_ERR(domain->regulator))
+		regulator_disable(domain->regulator);
+out_put_pm:
+	if (!init_off)
+		pm_runtime_put(domain->dev);
 out_genpd_remove:
 	pm_genpd_remove(&domain->genpd);
 out_domain_unmap:
@@ -1385,6 +1447,17 @@ static void imx_pgc_domain_remove(struct platform_device *pdev)
 	of_genpd_del_provider(domain->dev->of_node);
 	pm_genpd_remove(&domain->genpd);
 
+	if (domain->boot_on) {
+		if (domain->keep_clocks)
+			clk_bulk_disable_unprepare(domain->num_clks,
+						   domain->clks);
+
+		if (!IS_ERR(domain->regulator))
+			regulator_disable(domain->regulator);
+
+		pm_runtime_put_sync(domain->dev);
+	}
+
 	if (domain->bits.map)
 		regmap_update_bits(domain->regmap, domain->regs->map,
 				   domain->bits.map, 0);
-- 
2.43.0

