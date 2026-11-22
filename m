Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362928;
	b=RqWMPTOxQ+LCHxZAjwUflHSX8S/m7BGvb74WpfTYStGvbbRPTJG7AvSvfoUHvLqMkgbO
	 qm1Qge+LC5VV7/4DiNPBrIT17ueCE+OcNd7zNNNmRiYfn6n4qTrcJgdCunHFz+B/ZMVJ/
	 vPzugcD3xpmes7056266I2D78ZkIX7a5AsD852CLqFmum82rF8xPLBJwqAGD6efimTgbQ
	 S2HExsFYSdITAZbfNn0vKxY02KdFWk3UmLLrA7a3f0rpHnFF4cLogH1/Y0952tlWos4iX
	 /yZ0YBB+rhvYFC/3BXYV7dx6eKUluvL31Isaw97309ZPAPJonuyhQ5Sr+rBtK80kC/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362928;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=8K0cfCfqUv0w+a1bum5L9vcom6pDs+Jx7qFAqrqGDxc=;
	b=gC7CukkEipt0w9fVoiWUDJ9HpyyziJa+GWZNyvxbbRMtzcZ73TXdYCsDlUpRgOT8PzId
	 0GbaiFeaP6Q+sBfBY3m2fuJzgaCoMW8Xb7veBjhuVEN/mM7W6fN9PZQLu2LKNlSJY4ojk
	 JMOlToE9G77tPq08c4PNLNqgvhu0w/A8Bu6b51HlIh0JfxDsdZvw2I8zgb63CRZQs76mz
	 eU/U9PxF9m0ZS2HzV/N9xO0P+CzdftC1BhT5TcF7zNr9nFf88wQgFJfQAV1X9IBjSYk50
	 6vG70n8svmxt6Iw4ZuzX4bq9GbvjY0DRewbUEL4ipOEX9wcDNXER1Pvp/4mrQg2Y+nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b="ABrPh2A/";
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C433F606A32A
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 15:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C433F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=ABrPh2A/
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so2065737f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 07:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795362926; x=1795967726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8K0cfCfqUv0w+a1bum5L9vcom6pDs+Jx7qFAqrqGDxc=;
        b=ABrPh2A/Mase0l+gxlLeNc3SW8n7qaSwBu1hReqtNexM/O+TBLpLCjOBwFUDnEfV+l
         JyA2tk4F4wEDA6rsJT/dZjZffuXVXs1izQL+kzgZlUxG7C20LQBAMlAvm3PR5HHGBdVb
         43FoFfsOwACVE734APQuV3/OhgIjNOyUh3w3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362926; x=1795967726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8K0cfCfqUv0w+a1bum5L9vcom6pDs+Jx7qFAqrqGDxc=;
        b=dNGsgwTz/wW2EaV5cFlBmP47viCLxYcHsdsRR1u1VuDc7qC76hfdrnSqQwygE4K69G
         /rSIqQ/3j/6kGjBOI1LYf4SVmtAjpsvIC4f0R8cdJVJmIyLI+u2BnkoWMEHw8o2lVsXW
         oPrhrbIW1x3myT7KFXPR+zH/VBZCoz1NmDuBTxVUEorEYjJyp9wN3rx2eEzt87fHSnJS
         6i+BUxF2inZwH9g+UB5gSkKBOojOVBdlVtpaYlFCZoj0nuXN3xw1DljE0rDArPRwWGcf
         UqfCoHjv3+BO7GiQxvz3kEn/3KVKytqRwTE2MOzFquG6AcpN9zysi3ai4PW7vwlTnDoP
         oang==
X-Forwarded-Encrypted: i=1; AL+hErFZtF3oQiRH6KyuOU1v7G03plaTdRQ5osz5ckszMMUWHNTbs/K6j2chVTRHDgO5IOJPEa0xKZe54Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8CI+K5su5H+TZzqjnZTQJJBPjVFt0YnJh4J1pd0GHzJYlEdzrz
	fAjN74CF0C2AKPZ0R3TO8hI6Zc3OzWjjYTe5/qS/1OhsKuIShS+dNuzjuC/mE3AmKd8=
X-Gm-Gg: AZFdTZd4n6Zb9g20nU61pDK3tt8wVXPptARl5FJwe5dg9LwwJ0ZtqXxzzgnaiaCQUiz
	t+WFROYBly6GkxiTrsLh0EOsR6ODhoRSaGciv/f1gunZwCnzRr/ICCs0OFeRAGLYk83zZkvwnqQ
	eMXlyBdHqol82m5PGm+sPdkLmKhBpwDgFivGmjx5KCQ/2DN0MMXmIJ9yIRQKoZl2MOXe0RtNZpE
	H8sA4tIjIreJFShaxvpBy3tiydBSgkeCFbUtW/rKLcN4Cj8XjC6zUSRxPM1pbWVapcS2+ovwwCk
	FjlBjY3p+4tZIMkbuj2XBxooDmIxSscZb4AaSMvRji+oUR7M2Wmhj/IZXtfbroarn0VyQlPojrv
	Qc68OTqJtGRBL7QHk9t0h3NUgL48QmjS7MXR6aJ1MOlOqJTbYLSh6A/V4ava3AR4SMtSdSJztGb
	5z/tT8zyzK0fouMIoi6TUTv3RbYI2/78d7S5cQiWA/0/T+k5Uf+uluXkLO42HtUshBGw9OYsQkT
	K5x7xW0bpR9Y78AlmEolIZP47lMCuo4pHnv/FRaq7gmbKz43axHRx5GoMVRtUQgj4Dujy3IfgX5
	H4bTc+PqAy5JajDE6o89UNI1qWPd8BJIDKSqJb68Lbma3OlrVo+6XYCTeK1Gh9WTwqw6RJRVjMd
	26U+QIUVoobScWUKPfe3Zz8mwWBgHlytGVbck5MPTUwDzLxz3J3ihES5jkgRDRwHGMJ+W/1F52+
	Y/ANbY5E6UJ2LLaXG494di7lnsums=
X-Received: by 2002:a05:6000:2dc7:b0:4a5:bb9f:9c3c with SMTP id ffacd0b85a97d-4abb4c7ac0dmr21854740f8f.53.1795362926211;
        Sun, 22 Nov 2026 07:55:26 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm20046526f8f.55.2026.11.22.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:55:25 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 3/4] pmdomain: imx8m-blk-ctrl: Keep the domains left on by the bootloader
Date: Sun, 22 Nov 2026 16:55:10 +0100
Message-ID: <20261122155514.10289-4-dario.binacchi@amarulasolutions.com>
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

The blk-ctrl domains are all registered as off, so a domain left on by
the bootloader is powered up again by its first consumer. On the
i.MX8MN this resets the display pipeline set up by U-Boot to show a
splash screen.

Read the state of the domains from the blk-ctrl registers and register
as on the ones left on by the bootloader.

Enable this only for the i.MX8MN DISP blk-ctrl, as on other blk-ctrls
(e.g. the i.MX8MP VPUMIX) the registers do not reset to 0.

Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v3:
- Keep the bus domain on while the state of the domains is read
- Remove the domains before releasing their boot-on references

Changes in v2:
- Take the references once the probe can no longer be deferred
- Clear the boot-on state when the domain is powered off
- Release the references when the driver is removed

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 108 +++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 7d6735728d8c..99d75bfb69e9 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -83,10 +83,13 @@ struct imx8m_blk_ctrl_domain {
 	struct device *power_dev;
 	struct imx8m_blk_ctrl *bc;
 	int num_paths;
+	bool boot_on;	/* Left on by the bootloader */
 };
 
 struct imx8m_blk_ctrl_data {
 	int max_reg;
+	/* SFT_RSTN and CLK_EN reset to 0, so a domain left on can be detected */
+	bool boot_state_readable;
 	notifier_fn_t power_notifier_fn;
 	const struct imx8m_blk_ctrl_domain_data *domains;
 	int num_domains;
@@ -187,18 +190,87 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	/* allow bus domain to suspend */
 	pm_runtime_put(bc->bus_power_dev);
 
+	domain->boot_on = false;
+
 	return 0;
 }
 
 static struct lock_class_key blk_ctrl_genpd_lock_class;
 
+/*
+ * A domain left on by the bootloader has its resets deasserted and its
+ * clocks enabled. The registers can only be read if the bus domain is
+ * on, so a domain is considered off whenever the bus domain is off.
+ */
+static bool imx8m_blk_ctrl_is_off(struct imx8m_blk_ctrl *bc,
+				  const struct imx8m_blk_ctrl_data *bc_data,
+				  const struct imx8m_blk_ctrl_domain_data *data)
+{
+	u32 rst, clk, mipi = 0;
+
+	if (!bc_data->boot_state_readable)
+		return true;
+
+	if (regmap_read(bc->regmap, BLK_SFT_RSTN, &rst) ||
+	    regmap_read(bc->regmap, BLK_CLK_EN, &clk))
+		return true;
+
+	if (data->mipi_phy_rst_mask &&
+	    regmap_read(bc->regmap, BLK_MIPI_RESET_DIV, &mipi))
+		return true;
+
+	return (rst & data->rst_mask) != data->rst_mask ||
+	       (clk & data->clk_mask) != data->clk_mask ||
+	       (mipi & data->mipi_phy_rst_mask) != data->mipi_phy_rst_mask;
+}
+
+/* Take the references of imx8m_blk_ctrl_power_on() for a domain left on */
+static int imx8m_blk_ctrl_get_boot_on(struct imx8m_blk_ctrl_domain *domain)
+{
+	struct imx8m_blk_ctrl *bc = domain->bc;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(bc->bus_power_dev);
+	if (ret < 0) {
+		dev_err(bc->dev, "failed to power up bus domain\n");
+		return ret;
+	}
+
+	ret = pm_runtime_resume_and_get(domain->power_dev);
+	if (ret < 0) {
+		dev_err(bc->dev, "failed to power up peripheral domain\n");
+		pm_runtime_put(bc->bus_power_dev);
+		return ret;
+	}
+
+	if (icc_bulk_set_bw(domain->num_paths, domain->paths))
+		dev_err(bc->dev, "failed to set icc bw\n");
+
+	domain->boot_on = true;
+
+	return 0;
+}
+
+static void imx8m_blk_ctrl_put_boot_on(struct imx8m_blk_ctrl_domain *domain)
+{
+	if (!domain->boot_on)
+		return;
+
+	/* Sync, to power down the bus domain before its notifier is removed */
+	pm_runtime_put_sync(domain->power_dev);
+	pm_runtime_put_sync(domain->bc->bus_power_dev);
+	domain->boot_on = false;
+}
+
 static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 {
 	const struct imx8m_blk_ctrl_data *bc_data;
 	struct device *dev = &pdev->dev;
 	struct imx8m_blk_ctrl *bc;
 	void __iomem *base;
+	unsigned long boot_on = 0, bit;
 	int i, ret;
+	bool init_off;
 
 	struct regmap_config regmap_config = {
 		.reg_bits	= 32,
@@ -250,6 +322,17 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 					     "failed to attach power domain \"bus\"\n");
 	}
 
+	if (bc_data->boot_state_readable) {
+		/* Keep the bus domain on while the state is read */
+		ret = pm_runtime_resume_and_get(bc->bus_power_dev);
+		if (ret < 0) {
+			dev_err_probe(dev, ret,
+				      "failed to power up bus domain\n");
+			dev_pm_domain_detach(bc->bus_power_dev, true);
+			return ret;
+		}
+	}
+
 	for (i = 0; i < bc_data->num_domains; i++) {
 		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
@@ -303,7 +386,8 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
 		domain->bc = bc;
 
-		ret = pm_genpd_init(&domain->genpd, NULL, true);
+		init_off = imx8m_blk_ctrl_is_off(bc, bc_data, data);
+		ret = pm_genpd_init(&domain->genpd, NULL, init_off);
 		if (ret) {
 			dev_err_probe(dev, ret,
 				      "failed to init power domain \"%s\"\n",
@@ -312,6 +396,9 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 			goto cleanup_pds;
 		}
 
+		if (!init_off)
+			boot_on |= BIT(i);
+
 		/*
 		 * We use runtime PM to trigger power on/off of the upstream GPC
 		 * domain, as a strict hierarchical parent/child power domain
@@ -328,6 +415,16 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		bc->onecell_data.domains[i] = &domain->genpd;
 	}
 
+	/*
+	 * The probe can no longer be deferred. Releasing these references
+	 * would power down the domains left on by the bootloader.
+	 */
+	for_each_set_bit(bit, &boot_on, bc_data->num_domains) {
+		ret = imx8m_blk_ctrl_get_boot_on(&bc->domains[bit]);
+		if (ret)
+			goto cleanup_pds;
+	}
+
 	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to add power domain provider\n");
@@ -347,6 +444,9 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	if (ret)
 		goto cleanup_notifier;
 
+	if (bc_data->boot_state_readable)
+		pm_runtime_put(bc->bus_power_dev);
+
 	return 0;
 
 cleanup_notifier:
@@ -356,9 +456,13 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 cleanup_pds:
 	for (i--; i >= 0; i--) {
 		pm_genpd_remove(&bc->domains[i].genpd);
+		imx8m_blk_ctrl_put_boot_on(&bc->domains[i]);
 		dev_pm_domain_detach(bc->domains[i].power_dev, true);
 	}
 
+	if (bc_data->boot_state_readable)
+		pm_runtime_put_sync(bc->bus_power_dev);
+
 	dev_pm_domain_detach(bc->bus_power_dev, true);
 
 	return ret;
@@ -375,6 +479,7 @@ static void imx8m_blk_ctrl_remove(struct platform_device *pdev)
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
 
 		pm_genpd_remove(&domain->genpd);
+		imx8m_blk_ctrl_put_boot_on(domain);
 		dev_pm_domain_detach(domain->power_dev, true);
 	}
 
@@ -709,6 +814,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[]
 
 static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
 	.max_reg = 0x84,
+	.boot_state_readable = true,
 	.power_notifier_fn = imx8mn_disp_power_notifier,
 	.domains = imx8mn_disp_blk_ctl_domain_data,
 	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
-- 
2.43.0

