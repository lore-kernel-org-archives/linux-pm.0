Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380710;
	b=gQJhRv/fno/2k077WAQOuIpvvxAipr2ANuZQmNoztei2/0MqvlQvOR0PhfJc0KbZPORc
	 ZqCvpUNbRBrrMccQOisczggzUiXMaydvMqaA8+DcqJDQTr0OvwnsB4guuaqAQHmvBw0DP
	 BV2SjvDlSb2x0nNRK9/i7aq8VmIP6U0tuOYQhdnS3/rJPYW9uR/1MSR9UNjv0gtuYjU1m
	 /7v4Ctf9kMIhhyXHaMT/AIpsbyfLYlKKjlNenxvN2uf+aD9zR/dwmySI75fEtSSN8/vJ9
	 C5EGyRNoDgMikYS7rWab335riO/1/X2LwSgA02HkAo2Fxc/scYIl9g2CkDLoJxKIa7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380710;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=EZ2863pKGWwBwjrMKzumFwAyyrjNnDcDdwgqcYg/Bpc=;
	b=RJ+SgMP0F7ANRoYp1o/srOL0kKitm5Eh2utFc2vgh6/d36vTYumfvf3cAFYr4Fqp9zfx
	 03GXYXrobeUYpVGPSYvxp1q9/dyCIr/Kx6ssS/HXuRQu5AOhJ8vRxkUifjgFfyIzJT0Ns
	 jSEfhV5wVEUktYG3F8i/9cIcPMk79iPFXrD+IHF0gOIQDkAFywH4kko7r/IgzS4STCmFT
	 YeI9bGsZ2vnZPuJLxpE9d8Cxzj2BlPe1LAFNoLE9Hx7QoanLx2jWZqYDXMML+VopMjiuZ
	 lfnuGMQFtDkwapWnRNjzFQn3OJrvtrZkpwv5jryqP3TYNwUcq4kbMN9SnfRoLVUY7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=QGoA0ew5;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5AD606A68D
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 20:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F5AD606A68D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=QGoA0ew5
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so25979655e9.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 12:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795380705; x=1795985505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EZ2863pKGWwBwjrMKzumFwAyyrjNnDcDdwgqcYg/Bpc=;
        b=QGoA0ew5Wwo2vF99SeEnYxRiH3BDU2sCU9RfVjpUAhKSGwCEWkp5w5znIcRCM87Jka
         r4+rOhucsKeBvqBRxAJx6FYfY1FkSZUcTMTcZWsFPn5Opg2ANSOhlbUw71ZV/QC/HdY0
         jKIEZMVRJVhdeywUOqhE+ldeyOpwuEG2j7Y9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795380705; x=1795985505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EZ2863pKGWwBwjrMKzumFwAyyrjNnDcDdwgqcYg/Bpc=;
        b=nLvLBUknZ8sRs01J49b/w96u7kxRJnJt/JJpIQJZUQQLTdhQcMhw9RnJhUAM7y3ILp
         lnjb3o6uuGKbcNIT7F7fbVjhNM6+LsE25MgaQ51ph8VrST8NQXWsybu8GMYtuXeBNzTs
         kolwUK9kPzliWOXtn/0I67gD4XLzBIl5V5XIH9qShIIJh4TTQdfyd+/sXeapk9EipiKf
         iih96gyVjZTJ/lZgAcuOvYOpSLbp66w3MFD/jo30q2yBhqo1YUQhgSxKfb0oa6DGp197
         hNHNvMqCiUxLOwOVolAvxB1ylxkXEqIvw+iHNUt7OY8jBAgiMA3GdaWlOkuFbHyWLwOx
         X/+Q==
X-Forwarded-Encrypted: i=1; AL+hErHahw84Dc9LIgHCe0yRnWmRVv0T3hpQspd2rypT/x8BAmNwvamR9POdswTvt/cyrIRLjWTcW7PBmQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9+4My0m6K6tFwY69J9RcoW+FQp0YleJYkgq+oyZrpzu4FKrswl
	nqMzyezDkSrLKhbM52eDb14assNe0gEZjVU/ByE2daGCxUVFPtRro7xJ1ry/bG33LEo=
X-Gm-Gg: AZFdTZfJCfSqXhQLTMMD/36nvSsADz0RsMkTuznwbVcvBMiKTbFf+dVb/bsYdrvSBA3
	rg6BCBcf51/8zKvAiLd6FMP3DTM0NF/kZxfSYk1SzCgysvLFiDMhtC58XKROUme1Qp9V2yt2+Kz
	1GD+Uhx5RNpB/dKHnK9V33f3TNPPgS2Z6ZH0Otq3zNR1nFiUqPamq1ZxnW0d7Y3Rfs1i7iAR80d
	VjyoDRkg5EBUfVZxIHBovMNmhv6TSkIycGeKBRPV3RoZJQ/ir1ZXaMw1J+uXoRQUSassdNJ+Ahl
	EQAvHn50phu4S/l4e6R5wVcyuJ6iEWiO6TCxACTsbPF+z1ppao91vijdfzf090ypV6gttkPxbhG
	MK3JPywcB5zJL0ijy79RR2DkvPTUwubQodd1oodZtxQeTLBZ9p+ctK3kE2Ol4C231hK4vQfmS+F
	5oFAjdxMsdQFSwbKIRmJ9EdR7r88T9PEDe0IWLDD/18yklo24aJha8dzy/br25Jk3IS2HyhJzHV
	QC/RU29hT3psT9vL1e5xipIqMJUjKpYj/afpgDSJXIWMN8nrQsfFCDejIzLk+C8thEt3hH3Pi+a
	7Z+ZUM1icHbnPDI85scxlrjOr2lt+o/Shu5k8XsLzxIjFGVufL7TaXnV2cJS3w7LTVgbnmfQz2d
	uA9c/W6Y0c7iL3X46mFjgoBhLEAnf8wIROyoeCsg7DX9a7epvkQKBb/jK7/8qxyWncRKac0Y11A
	QuUfVrWNPg2q8VOdMLwOxMdCMLkQ==
X-Received: by 2002:a05:600c:800e:b0:4bb:7757:fe58 with SMTP id 5b1f17b1804b1-4bb8881b9d7mr201262775e9.19.1795380704844;
        Sun, 22 Nov 2026 12:51:44 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm397355305e9.13.2026.11.22.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:51:44 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
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
Subject: [PATCH v4 2/4] pmdomain: imx: gpcv2: Keep the domains left on by the bootloader
Date: Sun, 22 Nov 2026 21:51:11 +0100
Message-ID: <20261122205136.138173-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261122205136.138173-1-dario.binacchi@amarulasolutions.com>
References: <20261122205136.138173-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v3)

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

