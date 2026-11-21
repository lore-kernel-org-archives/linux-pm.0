Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795266387;
	b=aKJvYZlIK9lnx/Jvnibx6sOWXSJ3X+vIiRpWfDAAuqvMEpQKMxcEnY3Jf+NcsweHE+r+
	 T6QRcx8PF1z6J2kxHkQq8k67N4hRd9tZF5syBCCqaoHSa3o6ODgdTsihSVDOmhCuWt7uM
	 kOM2A5FQUyZZG+TejaxZkPo7Al/fTuUqlrydhgmhkuHk1t9akUrpaYO8aZ9T0xFQUUl28
	 Z6bDtxRudZ+rNoqMnl5t3qropAaoEwa7zWfggc6evZNp4G7qm8AaWVQPecIFJuQ7Hpf2O
	 QwQtNUyPbZa5PyYCyGRAY0OU8j008CQ49PV1X2eq6NDlZLi8H5FJeUd2K33huHd6nBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266387;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U33Eqi0MwkCHOyFx02ypgQ50QlY/YFdApS7Aq1x3HP4=;
	b=FcGjydR5rcJ8556WN5HSZRfNyn6aaPNoGKGFhvD0NF3+F2OL6QuKOMTOFbeqqo2Qmm5Q
	 +wtmaR3Dp86qpHFI+oBjPCIxBspnAqOz6NT/71Z1HlmH3oYQD3hdgNsyh4OazTZywFoJs
	 fzi9s/tmh+CywwLtPHEFszhFBZVTX6C5IoC19xt4qEDtmudCKpjcte6raZAuw7FdVMjby
	 jUvO3VDsn8ow73L8oQIMAEWPszrde4ExImzkAylrsfKrhce9URWTUxfeoAKUef/q4/mLu
	 1c/bIjpcPWjGaKrnuURdIKkZCpOZTaCboG6HevjZEPwdPTmbo3epSrz5H/neChkdfPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=STdFBazw;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02C606A330
	for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 13:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C02C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=STdFBazw
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so1112635f8f.3
        for <linux-pm@vger.kernel.org>; Sat, 21 Nov 2026 05:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795266386; x=1795871186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U33Eqi0MwkCHOyFx02ypgQ50QlY/YFdApS7Aq1x3HP4=;
        b=STdFBazwuQvSl0Gs0J2L/D5sVoVSxkW3HzmxbHdIriLcAauTcU8ZyZ+hei8YOEh/zB
         C0rep5vFh6FRQ78WXcvN1cmwfAtReRsB6Nu7F0kWbRRoYdVcjwY80mrOD+KxziHy/4NC
         q0Uyfc6dPgZ3JkuPJ6Qh6WyDyQhPc3FvEjkGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795266386; x=1795871186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U33Eqi0MwkCHOyFx02ypgQ50QlY/YFdApS7Aq1x3HP4=;
        b=gnarmj9WjDcwq4K0OiFK5ZqD0+6tIdE9smv7r2H7VjqFFh6JuPrzkuvhPX09Mraue2
         +GSDQhTbNy1JxRcLkGIukyFglrG09IJ/o6eVUCZYteHOm/y3wD3aG/DEuFx0WqKPAkVG
         w4TnIH/71eDUnggOg6GG02Al4ocOsOLKOGBWllyhHr1+lWisc4GZJI/0IXB8U6gPuhBH
         HH7qMO2c8lld4VQyDzC4K/mmlOInp+jZrQFr3EwiLhg5fiuPv8bfmVASVOkwhruyuU/E
         Ip4xRJYXpJybflKCL55+Ka/4I+S9RFPdelQoKtXyxwys0AiFfKmoagGYXxARL3EH3pJp
         bjag==
X-Forwarded-Encrypted: i=1; AL+hErEhWfmBg10aZlHlIVMZ+er2SasUu946tZV5Q5utuNQFbwW1CsIU73/UyiB88zbngEFlQR9irpEHHA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Kvw+w0lBnoCH3TvqKcTgaa9Wfos5mlVPluuJDGgMhcesESR6y
	pTRrWbIyhC2Y6FqqA3Zs3THgSWM1NiqEeAO7GdcgSdoRt+HbJ6Lx969WBc3z/3SoW/I=
X-Gm-Gg: AZFdTZfUIdYv6LSy62vG9LlaAHMHZY9OkRbqd4jOdZ1wXt9WYFnB7YI/Qr92HWXgTDL
	iSwPs0kp0d8ROCWTDbeN9BvY5fMZ4UkB9ZjeFVs6IGt53jDaNIc022LHG7FMg5ZwnGEfJZ6uCDD
	5gVQLWR/4c2e9fJKKREQ8grX+Kh7sZw+JVr/flkBMjsOJNQflzHm/9ICGNuYafevSRjzD0UpM4c
	49P9+KXaSkt9UV4Mup7LPQTu8GrveSV4g5jxtdx2ufiHzpAErCchI7MBXT0YduUMI+whwZElVeA
	3ac0sJYsK9RnyVKOwcx+y+aWGMwK/EYof7TO5IBMPkH/dgdpubgGwfvhecSNu2lgyz31y2nVdVp
	RV6/VWX9cyo1b8nDic72/+z00Ef3BqeVblIfNWZ7MJEmuDgqr5MxerDcALgZRs9acrva2hJ/4OQ
	1qtUHia/RS4CFEDJHaFxq5JNnoJnb2QOjLNH98k+Qwl4QtQdZG+4XR3T4q1PktpZWZkNCXB/PJS
	Rw8FgCsJcRQcayCdDdx9/vFAI6XEPOYujKedYaXj1zLVXBTLy00i0ewK7vQpHfKXSsC2TZ5iiTP
	pOUvjiDWh4A910Qx9tNOTF92+5G/7hsySnuR4z5SbBBQr8eHffZkmgKRGH4PSkJQ32j2vtTm765
	tr6z3Zn31BZp+/o615a3HLc6ipEXLjagwQJQl5LW4KPIsNo3DpFxM0zTsAtfdhv64zlX2M5fGhO
	zn7QcvS+tkVjB6zZHsIB9zQAk0dzg=
X-Received: by 2002:a05:600c:848a:b0:4a1:fbd2:f689 with SMTP id 5b1f17b1804b1-4bb8880993amr134343985e9.7.1795266385739;
        Sat, 21 Nov 2026 05:06:25 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906d6a13sm47196545e9.3.2026.11.21.05.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 05:06:25 -0800 (PST)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Peng Fan <peng.fan@nxp.com>,
	linux-amarula@amarulasolutions.com,
	Lucas Stach <l.stach@pengutronix.de>,
	michael@amarulasolutions.com,
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
Subject: [PATCH 3/3] pmdomain: imx8m-blk-ctrl: Hold boot-on domain clocks until sync_state
Date: Sat, 21 Nov 2026 14:06:10 +0100
Message-ID: <20261121130614.2482656-4-dario.binacchi@amarulasolutions.com>
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

The clocks of a domain left on by the bootloader have no user until
its consumers probe, so they are gated when the unused clocks are
disabled. On the i.MX8MN, with the LCDIF driver built as a module,
this stops the pixel clock of the U-Boot splash screen long before
the DRM driver probes.

Keep the clocks of these domains enabled until sync_state, i.e. until
all the consumers of the blk-ctrl have probed.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/pmdomain/imx/imx8m-blk-ctrl.c | 32 +++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 35087da43dd7..95b010505ded 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -84,6 +84,7 @@ struct imx8m_blk_ctrl_domain {
 	struct imx8m_blk_ctrl *bc;
 	int num_paths;
 	bool boot_on;	/* Left on by the bootloader */
+	bool boot_clks_held;	/* Until sync_state */
 };
 
 struct imx8m_blk_ctrl_data {
@@ -245,16 +246,33 @@ static int imx8m_blk_ctrl_get_boot_on(struct imx8m_blk_ctrl_domain *domain)
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
 	if (!domain->boot_on)
 		return;
 
+	imx8m_blk_ctrl_put_boot_clks(domain);
 	pm_runtime_put(domain->power_dev);
 	pm_runtime_put(domain->bc->bus_power_dev);
 	domain->boot_on = false;
@@ -452,6 +470,7 @@ static void imx8m_blk_ctrl_remove(struct platform_device *pdev)
 	for (i = 0; i < bc->onecell_data.num_domains; i++) {
 		struct imx8m_blk_ctrl_domain *domain = &bc->domains[i];
 
+		imx8m_blk_ctrl_put_boot_clks(domain);
 		pm_genpd_remove(&domain->genpd);
 		dev_pm_domain_detach(domain->power_dev, true);
 	}
@@ -1032,11 +1051,24 @@ static const struct of_device_id imx8m_blk_ctrl_of_match[] = {
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

