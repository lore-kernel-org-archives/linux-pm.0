Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380709;
	b=QYaBOz/43MidPuvmu73fOhxBBBySDwFRnn8zYTqUzpFEReDtNxMIXtmPW3WalD7AmtVe
	 vGpnZI0W/aTlM3fANxhs5EXJvaVhNgHBvnxv1v68hnC3s51eNmW7e79w3c75Y86SDjs7K
	 ZfaYfZSdutKl7OGdg429kDTIMcNY60pxErnuJluZcpfVuot3f9Nxe5VbTOyKZpLf89cXZ
	 X5Lh0c2rmoATdyv5tT1g2yni2zeoHwo+TOALxtD9HAcX83baWCE5H7F7GZR78aV4zJUK5
	 SWP+i9relTLTccEUtFLcb5f1A3KzSqyNM9ppEGVmby5ZlJiVTrV/JRpbpfDYFVaRRQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380709;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6PicXai3zi/Jeul0tDyGLavGDqHdliZb/sSdP134yZc=;
	b=CGDw0F+rWIOT5SMFZIt1oXxgUa8VB9YFuwHJtIKugfEAU5KuKsXx+EKE1f4YaRIfah0X
	 U493jqGS8+BLRGcpBCd8v1eFNAq8JTEvfyEhnBjVeR4/CkTfU277kYm7ij7NuZ4b+DcJx
	 yTDK6YtmihWoK7R/zfTMtfavZcAuzkKT1a1ZdhhgkjINQIPxAczHNMyvzzfc2tzjy26g7
	 8SkT66N7hWxTrmANDiVNTU5HIL89+ohuBSX1Na5+ZdUOeA53yBfQjzDt0MmW5dAAIu2bT
	 y7TIwHgZGNlP4rRP4V1xvSTFcOEgb1wlaHbqBGKboe/F/0k0mOQxpbVlhadfLoR1rEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=r6PFwLwa;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88026606A688
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 20:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88026606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=r6PFwLwa
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so19408835e9.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 12:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795380707; x=1795985507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6PicXai3zi/Jeul0tDyGLavGDqHdliZb/sSdP134yZc=;
        b=r6PFwLwa8CU2UZKnHe3ngruf4IFFaQjgQouALkhBN6ZOSQcIl/kpC0MyQp3CBE/xdE
         m9sXX/CqM5Gc4U62ebNnzU51fJuW+eLBPEO9RHGyV676LOLaJ5rfzTvL4wULG7IMcbFq
         nS9tMgs0J+B0rW9DyF6B1cEZ2RxB2Y+URBLDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795380707; x=1795985507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6PicXai3zi/Jeul0tDyGLavGDqHdliZb/sSdP134yZc=;
        b=bvVlQOouYVFqYJg4v2W/Nx1kJU+IMjp9G3ANdOtfsNlzdcP11dMHmWVAcQJXXHmP6m
         CMBvJMP2TUp27NmD1BqL5iYosSrwnBk0zM5Nfrc2AhR4erh4zWB0Y4es4fzVhtP652oD
         siT4NMIaxWvuDemICdx0v+pMAaiw9GZbB8dQa/i5NHwerBtxRafvXLbPMjpKElCfq1B4
         vsowN8xYEDKmwF7vYRexWE7rYSjjXZQ0olyQktTDxxAph+P37gEzQl2k7aDb+teY0KsT
         8y+myVgP8uBrypjkSDr6/Wq/H2qlMrlzEw8bKFtEgKXAB1+3mbf1/g7CVq5iDACDzs15
         B3hQ==
X-Forwarded-Encrypted: i=1; AL+hErG8nLYryM1acouEwdwbogUyq/l5Y0V7RnLTn9dtBjUZY2IcyV/fgkmJLLR+ITrGKAiTvPjZz84SlQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9b1pFw8MgZvFn7FWpo6meSgifSqqnLpk5pGMcWhBMAgjYKgh7n
	gZ0+CFG4AQaszXK8NwwljHsMNoLjAwxu8PXUd0NKNCAjVsGK6YzOOHSPsE0W+d7aw+Q=
X-Gm-Gg: AZFdTZcW5Pzu+VAIFbaMNYNBsPpj2/Ts9LEUbSC32ekUQ7O+CKLxKEuD9NTmlMc3vaf
	6MnFGNecv/QoXaR16ZteVUVGlcyjJVBV+47L7S+5dLzPZzRD9D3PaL4iZ1eVL/5Lc2KECCUFL/S
	6uVp/J8SJcSSI8smGuSUWxf3Pc1N4ybm84zswkY1s/xW6gny1THadUd828NoAi5ViEyTTvnTz4Y
	aN8YMoOGyVnccpKphxWqeGlSEC6koNqFnCgZNjiZJ02UeipcyQ19Z5WJdbdd0jY8f8JUJzLbHnb
	v2XznlXiGqP1eJutWHXdrr3Hj7c1GqmYn+i0sqjh6N0LVM2f3Al32NrCHU/zg9iXyl6uHgiq0Ph
	uFUiccCRaws9fGEwnSpcQO0b4+8mAPHI1v9JulXhG5LwoF8ZP7jWGZ3XVcA9WFDQ3jGPeziWN5/
	wL7Nmya5xjnj/6ZtvqDTOjIooySAzUFXckmKLhKOMFdAfJptOt0jXuJInVwjV8gHQr9UAbO9Aca
	9q9eoWb4IEE39S1cmRlTy2lTjBXuvEr2yebtG6KGOfwUUnqui7UBsVyN8AHnvaXGVICAOXzR6ts
	1UocNbDDcewge8L0xZrFqczEkxwA+NCmLonYhahuuo9c7oL1LH73dNfFOjTGFRN+4l2+rN16qQ6
	GfRShitJ+SFesehQC94W8f1zsEBpx/b8j2cWBPq+GLPOP9nQkvL1SzzwH3zWvycJfMpQS9BmHU4
	fh6OR3f15cYC9w/3QYN5JEBlBkFQ==
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id 5b1f17b1804b1-4bb8881c630mr212608835e9.27.1795380706996;
        Sun, 22 Nov 2026 12:51:46 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm397355305e9.13.2026.11.22.12.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:51:46 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	linux-amarula@amarulasolutions.com,
	michael@amarulasolutions.com,
	Peng Fan <peng.fan@nxp.com>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Ming Qian <ming.qian@oss.nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Xu Yang <xu.yang_2@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v4 3/4] pmdomain: imx8m-blk-ctrl: Keep the domains left on by the bootloader
Date: Sun, 22 Nov 2026 21:51:12 +0100
Message-ID: <20261122205136.138173-4-dario.binacchi@amarulasolutions.com>
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

Changes in v4:
- Register the power notifier before powering up the bus domain

Changes in v3:
- Keep the bus domain on while the state of the domains is read
- Remove the domains before releasing their boot-on references

Changes in v2:
- Take the references once the probe can no longer be deferred
- Clear the boot-on state when the domain is powered off
- Release the references when the driver is removed

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 128 +++++++++++++++++++++++---
 1 file changed, 117 insertions(+), 11 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 7d6735728d8c..04383d7e40cb 100644
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
@@ -250,6 +322,23 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 					     "failed to attach power domain \"bus\"\n");
 	}
 
+	bc->power_nb.notifier_call = bc_data->power_notifier_fn;
+	ret = dev_pm_genpd_add_notifier(bc->bus_power_dev, &bc->power_nb);
+	if (ret) {
+		dev_err_probe(dev, ret, "failed to add power notifier\n");
+		goto cleanup_bus;
+	}
+
+	if (bc_data->boot_state_readable) {
+		/* Keep the bus domain on while the state is read */
+		ret = pm_runtime_resume_and_get(bc->bus_power_dev);
+		if (ret < 0) {
+			dev_err_probe(dev, ret,
+				      "failed to power up bus domain\n");
+			goto cleanup_notifier;
+		}
+	}
+
 	for (i = 0; i < bc_data->num_domains; i++) {
 		const struct imx8m_blk_ctrl_domain_data *data = &bc_data->domains[i];
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
@@ -303,7 +392,8 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
 		domain->bc = bc;
 
-		ret = pm_genpd_init(&domain->genpd, NULL, true);
+		init_off = imx8m_blk_ctrl_is_off(bc, bc_data, data);
+		ret = pm_genpd_init(&domain->genpd, NULL, init_off);
 		if (ret) {
 			dev_err_probe(dev, ret,
 				      "failed to init power domain \"%s\"\n",
@@ -312,6 +402,9 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 			goto cleanup_pds;
 		}
 
+		if (!init_off)
+			boot_on |= BIT(i);
+
 		/*
 		 * We use runtime PM to trigger power on/off of the upstream GPC
 		 * domain, as a strict hierarchical parent/child power domain
@@ -328,37 +421,48 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
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
 		goto cleanup_pds;
 	}
 
-	bc->power_nb.notifier_call = bc_data->power_notifier_fn;
-	ret = dev_pm_genpd_add_notifier(bc->bus_power_dev, &bc->power_nb);
-	if (ret) {
-		dev_err_probe(dev, ret, "failed to add power notifier\n");
-		goto cleanup_provider;
-	}
-
 	dev_set_drvdata(dev, bc);
 
 	ret = devm_of_platform_populate(dev);
 	if (ret)
-		goto cleanup_notifier;
+		goto cleanup_provider;
+
+	if (bc_data->boot_state_readable)
+		pm_runtime_put(bc->bus_power_dev);
 
 	return 0;
 
-cleanup_notifier:
-	dev_pm_genpd_remove_notifier(bc->bus_power_dev);
 cleanup_provider:
 	of_genpd_del_provider(dev->of_node);
 cleanup_pds:
 	for (i--; i >= 0; i--) {
 		pm_genpd_remove(&bc->domains[i].genpd);
+		imx8m_blk_ctrl_put_boot_on(&bc->domains[i]);
 		dev_pm_domain_detach(bc->domains[i].power_dev, true);
 	}
 
+	if (bc_data->boot_state_readable)
+		pm_runtime_put_sync(bc->bus_power_dev);
+
+cleanup_notifier:
+	dev_pm_genpd_remove_notifier(bc->bus_power_dev);
+cleanup_bus:
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

