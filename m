Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795380711;
	b=RuM1eoWSPSmS/qPWKii7zVzRe1Sd6cF7SWImJzLcIMgmsELyZaKT/MqFdE0S7L0gDluW
	 qpQbuaHwbD+RfHpfuBIS5XXTCUoHXorCgaKs89fSlNu+wBYs67NrqjBNsMzSzOfVMY4LY
	 4ouNufeHf1A9yZ51LmYQOt1JNbBAzMBMxmg5EJ7zXha4qzVngZfaxuWAmY9ubEWWEikHQ
	 yPtNR8tLTCTplvbcADil77mi/gcWDrTv12toh2qSgm7FzHZFiyJrbVH51cx9vK00IesjZ
	 zmY0SGPFgSINT27dgrVnDcWm27I75beSokUM0UaFpJAx4mIJUusKurkSFcmH54ju4jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795380711;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=9qk8/ka9rPvexMaFJhcemSvfcHnBVEPtA/l1jjpp0TY=;
	b=4wG05EgSU3BOMOpTNGwcUTPrlLdgpjQPSFweFl2ZX3W5bYuZOznSxY7SEutrWHh32HxS
	 sVBClQiu+Kw6YFrMlBs+EYgNtYiUy2RRxej9wu/4epmcCm8cz+0Z93H9T/ExBT2Tu/Qb1
	 viEXrvvSWD5SnAcDLbBBvjFQRcc4klvxZ8X4QMsa/HP/TIHs81/NIbye86f16JceW14N+
	 tHVKjTNz7U/vWAlR+3c34kujlp8yVepuImrBBvCT6gq4mpJs9EzfexAMzq+BQgDl9h3Qm
	 k+qQxaYxAT+LUFo1+Pq6XwDIIjobax/xs5Je6ZHuXiHpO84Aqc1T7UJlwCv/wvkIURw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=GOfPNPFD;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC21606A6B7
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 20:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AC21606A6B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=GOfPNPFD
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a207b02a2cso18358805e9.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 12:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795380709; x=1795985509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9qk8/ka9rPvexMaFJhcemSvfcHnBVEPtA/l1jjpp0TY=;
        b=GOfPNPFDXV8AaxFLgADiuUHzw/L87ew/dvee2+1Kuoqqe34xknowgeDuzTrw+GQwz8
         0LjGWnfsfgao7yAkUvw6L/JaHGgRrRLjMbFX3CcF9sjIvI3Xqj0s1Gi1au6t8ijjDKoi
         eS64hRl2BTh3jxSPtC/oJnT/0zSsS0qD3zIMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795380709; x=1795985509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9qk8/ka9rPvexMaFJhcemSvfcHnBVEPtA/l1jjpp0TY=;
        b=uiT+R+6ZK0eJP30ZrjYvGs/N5Ip2b+fVizbVR4z9Ppe/z4IJgRO6V3EpfVHc2XcFdI
         MbE0XUJSKiL3Q4kaaAE8wnNhFHU+UipZwTBFBcw2S7oZkVFIf63q4LzS15TFMwLPm7IZ
         89rpmWZ7vB6ye0NuXhUoozbVNGbeXaWs1dM1copYCxAvsL96uY8IZSOoeJR4yTSnrNyP
         SsAfpTgwWsW5BuCDSZyb9LaphSyll6+C0NS9o6o/XeIlF1KJFRLmAUQGRVsHm6K7EzBh
         R/Wl5kTeQn1cU87T/XYqSaYabzxfBe+OnMn3ve59vjrzp2Bosj88te1HThB45bwUMXib
         +5ag==
X-Forwarded-Encrypted: i=1; AL+hErF+DGBxoQvDikwnCdXkcgs4vjIysP9qoc+iXUDvW7MDX8IT0y9IIg0zA/M/rSOIuOBrQJnKgvxv2w==@vger.kernel.org
X-Gm-Message-State: APuU4Z9OSJY4fpD3O5T+DF3Rh5wfIHPXt3U9gAmKwWSMTuSL3udvJoG/
	vZAe3+ZWSRy9CefEh/7b9vD2oSd1d8+pdOvgga0n0ax+6ZqAUVb6v2bdsnLuTbmIk2Q=
X-Gm-Gg: AZFdTZcQ/KAXYuXVvA7u0onS1Tm0qKLzV1g73pik0d81EQ4P2wj0dR1Hv98QLHP/Nr2
	7HaGcoNR9RGYcKYEB/H1inEEwYe0XEC298ACzNA4EWuq1UP5lwVQ9O9uyKdv6wvlTcivcWpoXv5
	Xww4hFeWlYaFpO6TZNV2l6Edp9SsJVIBmmRZQOvI015tu6x1DtPWvzx2zJJGVt2mgibsZnWnAeW
	3eNrGd81WHxRJn8NQhweTJW+e1+t8M+Vn+mVyqOd1jQW/KX2R8F02iAAPJPE/+iID0ji3b3aonT
	wM0zkOJnZpd5KyERLOgjEOFSPeUEL6/mXJ2gsDNiAfb6w5S+HeX9JUif/r0CPf36xGm4AxboRna
	5LLzzk2aqBdxAvaSj5aOhjPXP4/XcKgH1xj6MPq101drRpcwOTfljI5ekU8z8QfNW4Ys/r2F8G9
	5FLV4SalUKQ69vvUYiTAYnueU22gQdW3yqrbKKtXAzhw8PKBaMmzTKwQi+gnmWqX5d/a4mE2gRY
	AdnaFthyD34QwK71pjNUgKQwCSVCjaiEuzgcz9ezIRIdmv7ZBJNg3Poh2ShhXuQPtCyN4UYTJrc
	ut/MKIqG8PTYbQTmGob9CMoF7S4GVhoqGDdrIdp6P1kVEvuN7kDObyC71eFX4Jy66lIwjlER/mo
	rvzGXxeBJYT4cCmrFioAKDzGYuwsPnfMJBkCtAuDCfj1DFmdNac8kVmgv0d5T2WlQU8XP9R12Hp
	BNRp7zlklgR0XAZ1pBkC47uXMJBA==
X-Received: by 2002:a05:600c:45d4:b0:4a2:84c:52f3 with SMTP id 5b1f17b1804b1-4bb8880988cmr211812645e9.6.1795380708837;
        Sun, 22 Nov 2026 12:51:48 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm397355305e9.13.2026.11.22.12.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 12:51:48 -0800 (PST)
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
Subject: [PATCH v4 4/4] pmdomain: imx8m-blk-ctrl: Hold boot-on domain clocks until sync_state
Date: Sun, 22 Nov 2026 21:51:13 +0100
Message-ID: <20261122205136.138173-5-dario.binacchi@amarulasolutions.com>
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

The clocks of a domain left on by the bootloader have no user until
its consumers probe, so they are gated when the unused clocks are
disabled. On the i.MX8MN, with the LCDIF driver built as a module,
this stops the pixel clock of the U-Boot splash screen long before
the DRM driver probes.

Keep the clocks of these domains enabled until sync_state, i.e. until
all the consumers of the blk-ctrl have probed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

(no changes since v2)

Changes in v2:
- Rebase on the changes of the previous patch

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 04383d7e40cb..680a76b49ac4 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -84,6 +84,7 @@ struct imx8m_blk_ctrl_domain {
 	struct imx8m_blk_ctrl *bc;
 	int num_paths;
 	bool boot_on;	/* Left on by the bootloader */
+	bool boot_clks_held;	/* Until sync_state */
 };
 
 struct imx8m_blk_ctrl_data {
@@ -246,13 +247,31 @@ static int imx8m_blk_ctrl_get_boot_on(struct imx8m_blk_ctrl_domain *domain)
 	if (icc_bulk_set_bw(domain->num_paths, domain->paths))
 		dev_err(bc->dev, "failed to set icc bw\n");
 
+	/* Nobody else holds the clocks until the consumers probe */
+	if (clk_bulk_prepare_enable(domain->data->num_clks, domain->clks))
+		dev_warn(bc->dev, "failed to enable clocks of \"%s\"\n",
+			 domain->data->name);
+	else
+		domain->boot_clks_held = true;
+
 	domain->boot_on = true;
 
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
 
@@ -1059,11 +1078,24 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
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

