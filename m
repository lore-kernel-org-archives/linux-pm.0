Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795341583;
	b=YpY/SPxYICePkyogNdyr3SpdGSR7w+gIfNjfFNhb9hMUCNV7PP9+ykWoSJdRIo3d90OW
	 LbIleUuCnmIO/IpFAYvQMAqvFDE19buJDCcvBmQANWOowzw2ZZMOYQe+L4mwR97ZeaEfN
	 W8XLQoSXTuoPJKv9TZPEeKBBteyUtkYWjcCB3HbInGjftXMB7IKYJJcLVWatAbXy24xYw
	 LsZ/YL7EGOm/SUs/6CUr9YQLH9GGhXcQuRAUEqaaIz7AF3s01WRvl+qqgYgid2BWqVe1p
	 /FLdPA5NcuWSVKAIjRObsR22TCGnT2jCtkL9FVaUcvlYk+hTLByDtOrajDgqBbo4r6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795341583;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=P4BwB3GPSpT/AdzHng5SCwGK7VpozgBU8e5MfbG9wwI=;
	b=Z4AvP6ehvsyhB4gCcG0xdU3BSqjs/LzRIq9A7KX+uwS9zswN7RfhakKOWPpPXRnmKDtg
	 QgoZCa5ibAD79hALuzlVObohqqv8kX4e+1lju1SUIntDGs7YCunl6YQwIvZTqvqzaNtma
	 ppaD8vvVu4XsS77TG3TIWUjbCYrJQIg7Gl/x3T7mZItYyOJo+lWybfnqVqM3w+ixYgx2B
	 P4BysLo7hUGqAIWjGMBdTH1TsnSL4h4NAlcKte9/MFCL8PM2yAx3zzoL2EyXMCsobSTNM
	 vcAouScyOn1t41LQubAcO0b23IBZM8FnHAB3pjSBRX+RWJpmvmJlRfMmST3W67LOw+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Vh8CgIyU;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73672606A32A
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 09:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73672606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=Vh8CgIyU
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a210470b49so20626495e9.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 01:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795341581; x=1795946381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P4BwB3GPSpT/AdzHng5SCwGK7VpozgBU8e5MfbG9wwI=;
        b=Vh8CgIyURlbbUEbAbn82qNMFcK6hgbnpctaFZeFis//oJpRKL7+PKBBrORn/nl/fny
         EKMxdqOov/I+zDNJYTpi8d/K3BJGF5wJ7NeGZkBpiI7WnNa2j4vpeurxlC/Mm9J92ojA
         htU1Oid+lpGbTMXVj8cnAnz3OzwZzf7oR9/AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795341581; x=1795946381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P4BwB3GPSpT/AdzHng5SCwGK7VpozgBU8e5MfbG9wwI=;
        b=Xu13JwQzz+pYIWzNzWIhP6p+2DjQkT2YaonUl56zV0g7c8eh5dVYiK8Z2fJDgh31z4
         wUIsc/iI6f56XFb6Q5X/NjFPLr8/DLniaT31aEj0uBzwQQDCo3sa0NbAeddfVrOCPHCa
         gcZRHeG4nZkViDwbeVE+o6M6LDAFKRr+ijcYvgYMg9kj86thrJ5bN0kwu46vsOjqLRbq
         nz8xYKq5ZbjXLwbqFYjyw6qzIAiOYDmk43W0tdTJB+6lz5X7gxcicqZQdC4K5Zh/T1HK
         0WkgyN1CnvNFqjbRwctITZjOqPWykzwkUjpEqvhCmebOhx2SMykYy/ahb1bHN4JXwLEI
         4E7w==
X-Forwarded-Encrypted: i=1; AL+hErGAFeK2b1TEglpkyFvQUtgTpLr/88IKVP807R9Ey+PBvH9bc2ynDFrvC9sF4B49HooE1aGBjzBZ2g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/PO5irSrMeWIxBZ6HpHuFMyhuC366HIztckUjJJgzTTG7JQ/fI
	tWxBYy6EnPS9TyNUMehoZ78ba50MtBo5ijFRmRuuy30zyAE7f5tubscm6KcF1kbuzZ0=
X-Gm-Gg: AZFdTZf+0sZuelYBkzfERsTeiy4z2eDF7mKm89f/TGyiAL8RMn6pc4rF6jTVm3TYXPt
	4GKSrtTswhbj6YOTp8TWVWKstoum6EGewEqzGgVz7FGKG9F3vgdPufH16KdJj+WdD23D0EhoKQU
	oFR4cvVRMjqTZEOa9ygyy4cKWCEheZizTtDPE+1D7qRq+LI+GMEb3j3bN3pXzoRLOj7HCiH5s9m
	TIwuIZZ1jkKRel8X9v1Q44p9FFO1+1Zj14UAJOKjxiN3wCTqzi1kmTc9UrQPCzgYuYHaVWJayW0
	AgGlGt9UG0c/XmNbcIyCrkaAYewkgGL88VVYX+hKNj6662o1uL70ewKEjtfHHLiAyHh4CuB+w+4
	EXpYs8Rb3pnRg9Wo4Ar7+wqvfoPQWl06uofK0h/3posH3nyoAgIKZPirlfUWyRGYBYd8MGAnB4n
	hbedBovC+AuJ/0M1N98YyL+n74KMuVMM77p4yakTPyaW/NoriBvBFiENIm0kP4TAFtpOi0uEmO8
	pT6nlZ0jrigZH0hqlUAISg8lwRACcjB5HUjWBBWXy32iEww2cWaDdD31aMaNu11CE9KEHeQ+pRr
	tOXysWA6WFglus3NPmrz+UpF3gnQcFIQmEZrmd31BD0jEiY1hEp0x0jhaWMmEEExNBF3NTQoMU5
	Wo3Y2MUPKvSrZVO9OPMr29uiZB4ikNX8/tM1Gfn8+dTFSUAAFrO5MmwKSAPopoHZCg0oF/Wnmpo
	mYKrh8Oh5ORiuvs6z1t752+zLb7REhvC+ZaxhqwuY/PaNQIXk=
X-Received: by 2002:a05:600c:5249:b0:4bb:665c:a078 with SMTP id 5b1f17b1804b1-4bb8893a89bmr173732335e9.28.1795341580916;
        Sun, 22 Nov 2026 01:59:40 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm342455265e9.13.2026.11.22.01.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 01:59:40 -0800 (PST)
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v2 4/4] pmdomain: imx8m-blk-ctrl: Hold boot-on domain clocks until sync_state
Date: Sun, 22 Nov 2026 10:59:19 +0100
Message-ID: <20261122095927.2631909-5-dario.binacchi@amarulasolutions.com>
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

The clocks of a domain left on by the bootloader have no user until
its consumers probe, so they are gated when the unused clocks are
disabled. On the i.MX8MN, with the LCDIF driver built as a module,
this stops the pixel clock of the U-Boot splash screen long before
the DRM driver probes.

Keep the clocks of these domains enabled until sync_state, i.e. until
all the consumers of the blk-ctrl have probed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Rebase on the changes of the previous patch

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 5ab201eefeb3..bc69e7336526 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -84,6 +84,7 @@ struct imx8m_blk_ctrl_domain {
 	struct imx8m_blk_ctrl *bc;
 	int num_paths;
 	bool boot_on;	/* Left on by the bootloader */
+	bool boot_clks_held;	/* Until sync_state */
 };
 
 struct imx8m_blk_ctrl_data {
@@ -250,11 +251,29 @@ static int imx8m_blk_ctrl_get_boot_on(struct imx8m_blk_ctrl_domain *domain)
 	if (icc_bulk_set_bw(domain->num_paths, domain->paths))
 		dev_err(bc->dev, "failed to set icc bw\n");
 
+	/* Nobody else holds the clocks until the consumers probe */
+	if (clk_bulk_prepare_enable(domain->data->num_clks, domain->clks))
+		dev_warn(bc->dev, "failed to enable clocks of \"%s\"\n",
+			 domain->data->name);
+	else
+		domain->boot_clks_held = true;
+
 	return 0;
 }
 
+static void imx8m_blk_ctrl_put_boot_clks(struct imx8m_blk_ctrl_domain *domain)
+{
+	if (!domain->boot_clks_held)
+		return;
+
+	clk_bulk_disable_unprepare(domain->data->num_clks, domain->clks);
+	domain->boot_clks_held = false;
+}
+
 static void imx8m_blk_ctrl_put_boot_on(struct imx8m_blk_ctrl_domain *domain)
 {
+	imx8m_blk_ctrl_put_boot_clks(domain);
+
 	if (!domain->boot_on)
 		return;
 
@@ -1045,11 +1064,24 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, imx8m_blk_ctrl_of_match);
 
+static void imx8m_blk_ctrl_sync_state(struct device *dev)
+{
+	struct imx8m_blk_ctrl *bc = dev_get_drvdata(dev);
+	int i;
+
+	/* This replaces the genpd provider sync_state */
+	of_genpd_sync_state(dev->of_node);
+
+	for (i = 0; i < bc->onecell_data.num_domains; i++)
+		imx8m_blk_ctrl_put_boot_clks(&bc->domains[i]);
+}
+
 static struct platform_driver imx8m_blk_ctrl_driver = {
 	.probe = imx8m_blk_ctrl_probe,
 	.remove = imx8m_blk_ctrl_remove,
 	.driver = {
 		.name = "imx8m-blk-ctrl",
+		.sync_state = imx8m_blk_ctrl_sync_state,
 		.pm = &imx8m_blk_ctrl_pm_ops,
 		.of_match_table = imx8m_blk_ctrl_of_match,
 		.suppress_bind_attrs = true,
-- 
2.43.0

