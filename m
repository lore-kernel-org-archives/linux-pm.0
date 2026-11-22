Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341580;
	b=cLFPU9surrcKxSN7iCRJW0Rq6O6DR3NCVZCvQ9ix1fqlO593Y3W+RClEc4HQKVNXQq33
	 jz9FR+pa18RCr6IdeyVxOoEfBQBVpAkIGXCdmnKbCW+P1y5xdg2sxnx1DJ47G/veoL/mJ
	 IDBLsegQ2lkJ3ojDMfzu7nAnsb6RYpn8H8BbqqbW9UgiHwl0csEIM5OXNERZhByElview
	 5AdntoRV8BZ88G9HjTgi0BwS4RlGS/Ic9+oGjwKXfiXpVzRONoKujlbjg7lrakhx8d/ZX
	 wWS5L/pWN/GzvSp3pP6HBXrHeWQ8KcoEBzf8pdZadZ/Xg27NEtghh5YftoFSgg6JJCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UecCKV7n25Ql/GlYyEWBnjpzmQQb5gUz48JCN9VfJSg=;
	b=c6PZ7+wMQplh9JaQANOngIRJjRushj56shuPLL2R7SviL7vdtikT+gvln8ipy5lmVs2c
	 SW8g/c6XSIwvGMmaYSnr48AjkvFGIwMJN+xXx3nvrIFhpCrQF1u/ClM9X2MBkVJpNok5b
	 BNRQ/RdOxan8lsliEma5zjlegwypRgYVTesbuUsZRFtV2nQw6NqHSdZcefPyU8GrS0cRl
	 w87FEQh6kpXfHeK2o1R4c1kG51zUXVZRgRO7qGQ/YJw8ygmXJ6AUX/LhzJ+ACN2xHl0n+
	 BruloSYWEFKSkNZcdU9Y7SdIMj1RmPoyuScm5BOIGL/Sam2vMNVpzTlbt3/ERRU+sdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=q94P9A9+;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C57606A334
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 09:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58C57606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=q94P9A9+
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a2153c8525so17010925e9.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 01:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795341579; x=1795946379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UecCKV7n25Ql/GlYyEWBnjpzmQQb5gUz48JCN9VfJSg=;
        b=q94P9A9+LQ6oJH4KfBOhgOcMpf9eKkl97tiTq6nU0o8ly2rTck0RoErxa0q+eHXJFv
         fW2Ev0aXNCWMGe6pCjowXX8lwe61HnnljoCQPD5fdtxpFtPsLLhiqhWPDuA5CS/0eyCb
         spZayMBy4+MFGVkJfW+O+MAgZl3KiWxdyoOQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795341579; x=1795946379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UecCKV7n25Ql/GlYyEWBnjpzmQQb5gUz48JCN9VfJSg=;
        b=EjTPMcdO247x90MsjwCniv54eN+bMV30tl/fE8xMu0lag/3mCI02i/gykl5s1mRN6I
         /WOKgm0ewuMFLaKwx4VRVMyOxNpxWzdaWj/oParraSQYsA+qVGxmf3DCz56363Jb06DY
         4r03/k2o1nW1PyYnLWJ55XD8iCfiG+Twjyy9UwuU5ZZII7eSMlUMv+o4EhM90Vrjc2yZ
         phiFJ8yluUQIU6U2O4FLH2G8aKEo86SdRJkBor09mY6dTn6bLXkFdgN88QiC17LUfwdM
         PysZQczmJ4rThohHPbbfM4x0lPRxukwI2LJrtNX6r5tqe9CmFx/IWYpasvahMzgX9PP2
         gC/g==
X-Forwarded-Encrypted: i=1; AL+hErFNztdMze6TTtrfRUdlJU/XA+d2ZdaQhrQmRfWvjH8rJP/pkkWOsO8yX4atjCBsrBN9aKgta8/ilw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8zL3BP74Lwzb1aKpL4UHlVwMZvloqE1iU9Chpg0rIP5JtpU+u+
	5e91SxigLFO7ItzU1xBQurDQdMMXlbHQwcfzD1tIJbdug19Jz6T2u1j1i1gTVdhWZbs=
X-Gm-Gg: AZFdTZdIg6Pz/Koem0F2AbqP0eJh/jmSXA7+ojWBec5eUef5RI/XySOraMHLtNkbDYf
	Oddf83cBAUaW/wOEdouHuKmYBxkjHJKCmCllm9yWM0VKpsp8rQgCA1v3EfKF014z5Y6Ievwhs/v
	cUDuBDiLnKhUhkGRxEXBkd1fR2aASugsh4l908MTkIZ464xdp/4qbIX8W7huSVDgXMxYMKcN0QC
	vfAc3xcnMaDoMefqicGu2dY+2qCqsc08XNLuSnVbq5DDm5cIrweidnocJrEd4078PF7vTgkDgra
	Oh7OI4zMlvX8sw3ofpyIxjnj1tZQq9guMFyMruc6063MZnFDCBZiCqZLd3fpKybyY/zSYZ+plxF
	rGHgTwfmF4gfDYm8mcTfNNkSMLN44cPk0jy7IJZj+wgLorORAhqQ4hyQfGaNdKfu8LwoxapR2Hb
	Mwf8F3DdpJAYx9YIyAxpbrGqN0U/XI73izTW3WE2QQ5eBliWifZe60kh1ZIa/96CHygsTONp88k
	8uJF7Ehx/57qee8CJ7eObCc40FIOrRUmEpLVKh/C8kWYa+zCugFA/pDGN0487QuCGXM58ZkaORD
	kqoc1LLEAenyqhZM8RScsfA1K+4lCzzpW4JolXQaEetTo9FRRRzYaY08ZCha/9ZYQ61YXkQjFUi
	cZByyQBFs+xlugC/l8QFV9LkXr6JgLLKQH7/aAQXOMAF5QFS3q/Jok7el0yNa/zB3zUjEkeekdv
	KC/iHougXP0loIJBdTZogV8hl2HnOebaBCivAXwRlPnjsJj0w=
X-Received: by 2002:a05:600c:4515:b0:4bb:6f67:ca0b with SMTP id 5b1f17b1804b1-4bb888267f4mr179692205e9.29.1795341578657;
        Sun, 22 Nov 2026 01:59:38 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm342455265e9.13.2026.11.22.01.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:59:38 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: michael@amarulasolutions.com,
	linux-amarula@amarulasolutions.com,
	Lucas Stach <l.stach@pengutronix.de>,
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
Subject: [PATCH v2 3/4] pmdomain: imx8m-blk-ctrl: Keep the domains left on by the bootloader
Date: Sun, 22 Nov 2026 10:59:18 +0100
Message-ID: <20261122095927.2631909-4-dario.binacchi@amarulasolutions.com>
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

Changes in v2:
- Take the references once the probe can no longer be deferred
- Clear the boot-on state when the domain is powered off
- Release the references when the driver is removed

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 96 ++++++++++++++++++++++++++-
 1 file changed, 94 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 7d6735728d8c..5ab201eefeb3 100644
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
@@ -187,11 +190,80 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
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
+	if (!bc_data->boot_state_readable ||
+	    !dev_pm_genpd_is_on(bc->bus_power_dev))
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
+	if (!domain->boot_on)
+		return 0;
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
@@ -199,6 +271,7 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	struct imx8m_blk_ctrl *bc;
 	void __iomem *base;
 	int i, ret;
+	bool init_off;
 
 	struct regmap_config regmap_config = {
 		.reg_bits	= 32,
@@ -303,7 +376,8 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		domain->genpd.power_off = imx8m_blk_ctrl_power_off;
 		domain->bc = bc;
 
-		ret = pm_genpd_init(&domain->genpd, NULL, true);
+		init_off = imx8m_blk_ctrl_is_off(bc, bc_data, data);
+		ret = pm_genpd_init(&domain->genpd, NULL, init_off);
 		if (ret) {
 			dev_err_probe(dev, ret,
 				      "failed to init power domain \"%s\"\n",
@@ -312,6 +386,8 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 			goto cleanup_pds;
 		}
 
+		domain->boot_on = !init_off;
+
 		/*
 		 * We use runtime PM to trigger power on/off of the upstream GPC
 		 * domain, as a strict hierarchical parent/child power domain
@@ -328,10 +404,20 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 		bc->onecell_data.domains[i] = &domain->genpd;
 	}
 
+	/*
+	 * The probe can no longer be deferred. Releasing these references
+	 * would power down the domains left on by the bootloader.
+	 */
+	for (i = 0; i < bc_data->num_domains; i++) {
+		ret = imx8m_blk_ctrl_get_boot_on(&bc->domains[i]);
+		if (ret)
+			goto cleanup_boot_on;
+	}
+
 	ret = of_genpd_add_provider_onecell(dev->of_node, &bc->onecell_data);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to add power domain provider\n");
-		goto cleanup_pds;
+		goto cleanup_boot_on;
 	}
 
 	bc->power_nb.notifier_call = bc_data->power_notifier_fn;
@@ -353,6 +439,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 	dev_pm_genpd_remove_notifier(bc->bus_power_dev);
 cleanup_provider:
 	of_genpd_del_provider(dev->of_node);
+cleanup_boot_on:
+	while (i--)
+		imx8m_blk_ctrl_put_boot_on(&bc->domains[i]);
+	i = bc_data->num_domains;
 cleanup_pds:
 	for (i--; i >= 0; i--) {
 		pm_genpd_remove(&bc->domains[i].genpd);
@@ -374,6 +464,7 @@ static void imx8m_blk_ctrl_remove(struct platform_device *pdev)
 	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
 
+		imx8m_blk_ctrl_put_boot_on(domain);
 		pm_genpd_remove(&domain->genpd);
 		dev_pm_domain_detach(domain->power_dev, true);
 	}
@@ -709,6 +800,7 @@ static const struct imx8m_blk_ctrl_domain_data imx8mn_disp_blk_ctl_domain_data[]
 
 static const struct imx8m_blk_ctrl_data imx8mn_disp_blk_ctl_dev_data = {
 	.max_reg = 0x84,
+	.boot_state_readable = true,
 	.power_notifier_fn = imx8mn_disp_power_notifier,
 	.domains = imx8mn_disp_blk_ctl_domain_data,
 	.num_domains = ARRAY_SIZE(imx8mn_disp_blk_ctl_domain_data),
-- 
2.43.0

