Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362926;
	b=b5uWnoDM1UPgXw4A4vh2cgGZSsueg6L4bblsZtugxO5myzp2uGYKm717hEl+udFkXm/e
	 2Y9mjc5ilXeVpMr5gPISkd6NJgC3NzkfIfH/XTOw12eA0IVn+1w9qo9m2dMx9XkTrQcsP
	 dPLtWyRcaBHA6EWCbwBYv9z8sdBOgrv4B3C9UD3hCaxxY0FAOrelXydc3Kd+fiz5zPIVk
	 h9C9ewSCcMOgdZxI8/3zX5XCoN1zUlixanZ6WbobXx1eep7D4O0e/CaVEZdAGDhOxmyuT
	 O6z0WwesDR8geExPYSCrZH07zdJ8uTBH7v/VfeVHsrz7O7y/QNvOlE12EFJRCaGrGpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0VEXadRTs4mVJ4mB3xY7u+vAwlCzDe/yNMl9zPs8LH0=;
	b=Pjo20tWmfyHez10oFFwyu5QsRUF3gneBhPo6WwfBIQSv8P+wpr1UHjI+B9j3FNmt1bpo
	 N0tr9q+FYCe6FivwAwfrS25MfCm8S6X51zu6kD8EtXSBcZFFlcnr/U/EBDwCxToNuw/wt
	 VIpDhEMl4Z7YxGSQec5Rmc9y3BgbTm6Ap0wVmVXXFs+2P3AfhXsl8u6NIWx6QuD2TgHxb
	 4YWBdPHEdZ9VZCtL2IM3ESn1bZXQfzZox793i1rpuhGDtXVY5S5RfMBPqY+qdnx2h2AgV
	 csy+HPQdu6PZGvqKap38BfcQEWBFGM5iL4LYlfK3aliw005Td6+Ic3lGyN9pzpaLk5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=FDxj4jNH;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0CB606A32A
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 15:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D0CB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=FDxj4jNH
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dee593f18so2354690f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 07:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795362924; x=1795967724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VEXadRTs4mVJ4mB3xY7u+vAwlCzDe/yNMl9zPs8LH0=;
        b=FDxj4jNHxhFm9e5JaCXRMp63KKlIf3Z+XlgEOqrrzSXAV+qy3L9uY/XU6VbUsRHw3d
         QscJCLajXF8y6OLTCJLJ1RZ94SgohvYaKjYyOM0thSC/ZhwTmXejDUAtsB9r/Zs1/04K
         V02Agskefa7rZF29aAd0Baptpotyc1w0s9I7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362924; x=1795967724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0VEXadRTs4mVJ4mB3xY7u+vAwlCzDe/yNMl9zPs8LH0=;
        b=13DE2tQ69J80/Hi1onmOePMhQTR3LnkKiAJQ+aMGuZMbQsc2VRbSpsBL6MLfSLDJsB
         U+s5TCq1eoEKrcwGuqPeQBLSLohdObqwu7T04NF/6gZl9rl6dQcenVRMs9VQSUZMkS0/
         cs7puuIF6df/9A5JGYY7byHtQjd/WuSWL9qaBXdrWC1JBZ6/CAA9SCTRtLtKideIVAjs
         uLJVB5eBa7zUuAtUZA4X8HbFwm/jjT7CkQnm/rwtdf3wjqC2KDQwPTyIo9/8XMdlZhGx
         O1/xJntLghQf7/SorucJzW4c1wq6wgDMeZDj2q24KwvIpTppWru4H5BdNCT8Yo9h7oyW
         rtbw==
X-Forwarded-Encrypted: i=1; AL+hErFZtUuzMItjueYRGAIRZPXMMyLZzowy+HQijmno9sK/ePdxiBN1UsKWzIlOpEE9SdkFai9P/lU0TQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+nUTkeUdNKK4H1CurXIphOTmGepQSdrB9B7yZEEzXLvwphMwTS
	VYQaKdGDtGFZ5YRj8UvL8MdFT7G3PNbwxmk2Q/hl7rnfO02cICSSeed5tjpBRsULDvY=
X-Gm-Gg: AZFdTZdGcsHwDcoaPetroXJDoHhqeEPcEn5pnSGifMFzlEUGnscms5DLyNK0TTRRtkD
	mdpQCz2JOSndf9Qczsu89m4AgFzb8wvvAFZt0TYsq+He3a0vZyXTblQTlVqCWl8gqH0Ugt8SNYb
	A7IzWKSSDAz87C8fMH7dGfWrqqG10aa7U5bLwBNa+vVLjwnTqkLjP4hN5PtdjiOG1sJt0qVXscV
	U1zUC/PiCZjbFiLyVfVwUXY9kIk5/hMwNHu90z6sPauojNo3ZuHq9U0Rm1Dw9xoe9NoXxQ0ZpIL
	llOiOya1/h0/XzuKHC4yPPAk59shjwV1QtmtQV9CEFo9it24+YsAq4Tzi1sG9ahMIs8S37tjaeE
	RAevGV2T8nhelRAXjvESNf2xVdy6ESampCdrJHPMoGiWvre+oCz4puRS4NVgihE1/BBvaThHbAu
	MquJNmBK3O5s2ss2+I8eF8Pu775r2tM+iRMp+VmmevrnNISMwldhIZx1kppMfibkylnoWx9snKb
	YmOzmVNa1oTT1RXkcG9kPlZPFY2H0LRCcQRNkk8W5Ej/GW69iU9xVrEWYn0hmGRUnO8yrGUTCL/
	UAWp8wtEDX28ZBQkw14kvtwYH++v/8dUAE0BioWwtViiAv91/gHNkLnvNA5iYm2D86F2rSP5mHr
	4mzerTmnuzabqs/DP0v63JdrwJA+Nf/RPDua08oOqvUhFaPYqHp3VMO2OQQJk7ODpVR+0s9FR6q
	GzgYvvmqg+tKJmBxwPLkonuTekZw==
X-Received: by 2002:a05:600c:4f07:b0:4bb:5dbf:af06 with SMTP id 5b1f17b1804b1-4bb88804d58mr224971215e9.9.1795362923616;
        Sun, 22 Nov 2026 07:55:23 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm20046526f8f.55.2026.11.22.07.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:55:23 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
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
Subject: [PATCH v3 2/4] pmdomain: imx: gpcv2: Keep the domains left on by the bootloader
Date: Sun, 22 Nov 2026 16:55:09 +0100
Message-ID: <20261122155514.10289-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122155514.10289-1-dario.binacchi@amarulasolutions.com>
References: <20261122155514.10289-1-dario.binacchi@amarulasolutions.com>
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

Changes in v3:
- Drop the runtime PM reference synchronously in the probe error path

Changes in v2:
- Release the resources of the domains left on when the driver is
  removed

 drivers/pmdomain/imx/gpcv2.c | 77 +++++++++++++++++++++++++++++++++++-
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 6a54ee734514..f8f2d38c1b2a 100644
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
+		pm_runtime_put_sync(domain->dev);
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

