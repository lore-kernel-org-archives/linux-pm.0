Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795266383;
	b=Uqc0DvC2Vcl83liIAuP/P2xsJj92GNQPVShGSWlQUK3c04/FN43FMLSUSnjILRKWLuaZ
	 NNis7aTcBK8ayuJ2m65rLkYUuwph0dPYG776KqMx8QLSITGoF0LvWAhWc2k5+IDVJVfaI
	 ryrBmzzKw8/JrzejM3YO78TF4/JUqhziddZ8d2d7IMBcmK5zMVeQJt7zNHp5jr9KvFIyi
	 3v6KWgpqU/4pXpC/1NHn7P2QjOhv5vx5edLTkNKvjdvE6cYZK9KjeA9WICfQI/9IwDHH2
	 CGOKNxQf3ummhzA5Zx3WSb5A0EsZZGWwmpCnb49x9a0yLhi0VX8NspavDw1/t8O//HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bJhkKyRHV3mrHq/zTrWh/sC0/NiutVH/ddsVPD75YJQ=;
	b=sPyc9KXRmwOK/ciaudK8y06/5fXO9ZKouEi+D84blUvr3QqjOaQFIB5+4g/wD5fd2814
	 yIB1lN3QsWgQ8MvVm5W/ntfxUudppUfj/L1bbNz4+fDFlIeynKAtAKP+V0qDZ24nuzY/2
	 spsfUZQWqKYP8uh0qvhfXlSo21axVdmlDnI+IqTJH6U+lalM/zexw53YFqBAf+QBrq2FM
	 FRoScSerVNz3FDCDZgDhYswy7VdtHzTkiElBdOkA/eHbbNCXihGuMyGPv8LUOWdTE0kCd
	 B+vFSKSt3t7FpWbbZu5DXbq3oJEFf62F6+Ak1FA44J4nCiZE8xaJ4Jh+FPTU98eNQcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b="BM/hUPrM";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D34606A32C
	for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 13:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D34606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=BM/hUPrM
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4bb5b8ef642so15050215e9.1
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 05:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795266381; x=1795871181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bJhkKyRHV3mrHq/zTrWh/sC0/NiutVH/ddsVPD75YJQ=;
        b=BM/hUPrMUAxC0gKre+tdAIyYuB2rfm/AEyJ2PhsOx5ULoqOA543p3ng8Vq3cwRLxGa
         CtgUAQ8SdL2wm1r4WuBE1PwWz+flov5iQwLzE6yw382oQu/SIcP4w+qQkF0JpAQqlQVm
         fEm+MmADn3aqqIJF8usHobLmsGl09N8Q69x1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795266381; x=1795871181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bJhkKyRHV3mrHq/zTrWh/sC0/NiutVH/ddsVPD75YJQ=;
        b=pfv/9TOPTcTmw4M2keSmKMB4cnph6Kf/yVlsA7LGkhoBKGBfwmBTznsN/TVNJA5F8Q
         ymW8oFqnTD2pK34TRzk8skOr+yHGrvbAF02aWQRj0cUNDXsky17+Fla7dFjS+ayWJjbc
         1iyBq/H3oUE9hOfJRANkp367VP3kMYO+74gBESJ3F/bZIY4IKBtyitj5G1O2WHKSn6uD
         dw0NNgv6IcYGztxiEqMvUGouu0SaAtuskUC9K2Ca6jIIP3VRrRYSmrCR8KxjbQAYG/7c
         mDhK/anm3JooGVDaerlolrUy1XsPlVJrCx7mkWDDeXGnTB+e2feH4T9b2k9fR/BwNdQ5
         7y/Q==
X-Forwarded-Encrypted: i=1; AL+hErG3/4vAzPiRk1Ou+Jy6uGOHhbG6mH3sq06h6fgGPP6ud+ctf4FZKfOw0iyfX4yQymASnh8iqXrVbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8vXshv1XQsoxfqBgZ53K2J6q8jfsPCwA9bslVCxqWrulJGPmlT
	8xJwaC5bzL15NU5nsTH4FNfRDgTt9m9yRXviByl2qjKvLnGL3vsgZiKHqOYAV8kZ4xQ=
X-Gm-Gg: AZFdTZeSJiOAfoOL3rpsJyZtJ1SsPK7b7ptP3qb7PGnbr1XWrvjwF5AZlsMdrB1J4aN
	p0MO9LT/XAuuMaZSgHnLPZ+FLSmNHDBBUlCk9LCE2PmYe6cUsbpaCIK2m6thH6ntpdsxPZ4htsC
	tLwfRIjXt67n8d0pcDOj8AkKr0F8uqQwRuE7JRoUVJ0R21IPj17/fO3+156qcrtA+3gmVQGMTww
	mx+TNgkwPZagAYb7lCbboxNObJBncXmfjztkzGJ78Snyb0K4b9Xh7R/pZsUybbD48BF/QDoc058
	Q7PV98vH3Gr3A38JYrXTPcNYtm0ak0jFE5Sp3i1vUFKhRV0vPLyRZM2G5drjs9cb/QwpVDEaaQt
	cQ3xPVilba2VJJE5Cu0vgKRWxiernJ+aWVIAEohWBRErOG8N0AGRzCxqlYsTnl4ahd5wtTHsCpt
	QLvcYwO1OYoBH7bB34PUReeqFzNx18wyekELHuIrMCaruvcH0tmNVLIskSMeOEbcKteJQEZ28iG
	X+kqALlzEwM6ZuIG//+qFHxmTBdr45fk6qCIQ9nlAstslrGEWOIIpPdlvjt5Gapps97qamKEvCj
	UJ7LOWRTwtOIUUC/LO+jjIgyJH0nbZXvaZQfldvynYRrpdDnJqBmweo6E4BAI6vjXQGWHr44io/
	0yz271h9T7gkqcAg+X4RKhgXUwLv5AO/zLPzfoRkM9k7j58CxEtbbAX48aM1UnyDJy8OMST+BZO
	f0uvtQLclQ+oM1pL+iapuZU+f2hw==
X-Received: by 2002:a05:600c:64c6:b0:4bb:6a75:d04f with SMTP id 5b1f17b1804b1-4bb88807d96mr135151995e9.8.1795266381367;
        Sat, 21 Nov 2026 05:06:21 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm47196545e9.3.2026.11.21.05.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 05:06:20 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Lucas Stach <l.stach@pengutronix.de>,
	michael@amarulasolutions.com,
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
Subject: [PATCH 1/3] pmdomain: imx: gpcv2: Keep the domains left on by the bootloader
Date: Sat, 21 Nov 2026 14:06:08 +0100
Message-ID: <20261121130614.2482656-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261121130614.2482656-1-dario.binacchi@amarulasolutions.com>
References: <20261121130614.2482656-1-dario.binacchi@amarulasolutions.com>
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

 drivers/pmdomain/imx/gpcv2.c | 61 ++++++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/gpcv2.c b/drivers/pmdomain/imx/gpcv2.c
index 6a54ee734514..23159b0489d4 100644
--- a/drivers/pmdomain/imx/gpcv2.c
+++ b/drivers/pmdomain/imx/gpcv2.c
@@ -1315,9 +1315,27 @@ static const struct imx_pgc_domain_data imx8mn_pgc_domain_data = {
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
@@ -1348,12 +1366,42 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
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
+	}
+
 	if (IS_ENABLED(CONFIG_LOCKDEP) &&
 	    of_property_present(domain->dev->of_node, "power-domains"))
 		lockdep_set_subclass(&domain->genpd.mlock, 1);
@@ -1362,11 +1410,20 @@ static int imx_pgc_domain_probe(struct platform_device *pdev)
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
-- 
2.43.0

