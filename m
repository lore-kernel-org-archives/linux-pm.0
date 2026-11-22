Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362931;
	b=cWbpfk/yXtH8CA1acoPEWPF8Oh+9V18Aw+kZWzqKurfK2WQTlhX8AqjiiOxfjkL2U/tL
	 gAEO7rcBiov8w+OGKoQvSISh2LMILYiUXaWj62JoS2QsEp9dLX0bLNWSccrloSi8t5zMI
	 USKg6R5ODUb0qb5Q9IbVE1petn8enFUVrETUOiDYr7qx3EAysJ+EiqPpK02Na40kG6qrN
	 /kWPU8rvqFKZ703FnW+4hadaqR9IO6KIGOKV7RI+9zZDkH7s/JZH8O2lnih9tq/6tfl46
	 vZcvQooKC+x7Ux8er/wWU+clFbdoTxb2Gw+GEwFtwADmEfE39V5VUbw2WBaZpn1o+sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362931;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YXPf/W4XcAqD9x9Cn0OV3MiVFNQRYObRCyBfE5aJVqU=;
	b=V8VHFmKLaNL9YnUeSmZ+jB+wJIO+j5f0LftHSv9xOwe08x7mmOQMg+I1Nul15WC1HOEu
	 frXWM3nGeOqFrofYrx95G0d9JHnY7lZt7K3skhEkF8tSl9//73Pdn9j2JYAIZpG+Liova
	 zO7SCOkZrd+wWq/3oDfnR4gZ7cLLz0jwDQOMh00K23AqLQDj642DG8GAHAwRk+U02/+xV
	 8vuFMYkSGzgFUdiR3ChknBx1gn0Ark7DI6rdxvZYjmDzj2B0bvn9ohAMMbxkThB7Xwiap
	 dtWGVslxKgayZNiVKp0iJWXC4ml4LjvYzQioRGgB2FnDzc6PkfXbc2VR57GGZ11IItQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amarulasolutions.com;
	spf=pass smtp.mailfrom=amarulasolutions.com;
	dkim=pass header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=MdnJhKfU;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2FE606A332
	for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 15:55:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A2FE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.a=rsa-sha256 header.s=google header.b=MdnJhKfU
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-490d59c3edaso1639099f8f.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 07:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1795362929; x=1795967729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YXPf/W4XcAqD9x9Cn0OV3MiVFNQRYObRCyBfE5aJVqU=;
        b=MdnJhKfUKd7yLmu/RApNQIpBuc0MaP8qvoPewk3MBfWXx9jWlPNtsX09LISghmll0S
         eCTtkCNo9hQ0IihMqd6vLi8xlYRB2jJMrkQ7Mzzv6+ptTsacWzwv0xCtE8jTEk00EU1Z
         XGi09iUabr5TFojSO2janM1cM5p7qpNGLLIMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362929; x=1795967729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YXPf/W4XcAqD9x9Cn0OV3MiVFNQRYObRCyBfE5aJVqU=;
        b=tThHwlobIl+/DF0RN6E0WapUuu541nWsf/SHsBSrHMsCuQ2fNQlGPVL6KP56ntNab4
         dWlt+ceKeQkQ0kG9/wjP0qXHJTHXmj9xYUkyNxStXDLZ+lNSEIdj1SiMwqRYoH5CuazJ
         RT8DcYEUGKo7z5l1u2gCDE6JIzAf6gjzL9JrqfZEt6r8lTbh6dgiXCHTNmmXHYOM/a1e
         va9a70Hexv2SzjCVbe0n7H3Ej+vydg3dpJtutdOmZ38XVyugxrNIq2Vlt6AZBsy2ut1J
         GVvP6ze19mQdaQJAnLCPae/dv/7sMh0zJrbcEbP3FQ5YTJpSNbZ4SwfnZOFfJCxGKG0K
         Tx4g==
X-Forwarded-Encrypted: i=1; AL+hErGCa3PRzKo04caJoTBpVDO9I07KGcKiFOOQ9JqoQgusZD4t1ZZH1dPaSISQvV17KMjAh01lwt4ckw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9PFTjJ/jSKFJw1yVy/ZLlVRQX7oTA82U8Swb8HTH4yz4TSvRO1
	WsMfv/5RCboI+TAEmHelNfMnSdPwAo6QaGZcjgZ57k5f91KVV3H7GfIvx5JSgfAb2Sc=
X-Gm-Gg: AZFdTZcd/nwu+iu8t1cuZqB09DxsASRbUXCYzj4WScfttdP3OX6i/xYuQFRnNXqHYMS
	r6enb9NUcfFEQLJ/erdlAHyH1Iary083uvv2/Dv1anDqjZZITgdtbECmutckAMXlP9TTAmUMTLY
	lJBgIL9VtSYUk8zYt19565axz588XNqhZKgjsdIEsQcsMF8BefVKx3u+TVu22/8j14mp/MnGFpt
	Aircd3zxsGgZMoyxPLxCYFHq/Bfds++FyicasN5b9YsEx8v8dFLv7gqP/fQ3n+IvI5GEBX6h9N1
	1GR2olWBMV44+Z9j6goJNStkXZj1buAnit1RX9KoH0q32+Am7NWZpKOCsp64xYJ8nmZH8KLx0Pj
	oqhjH9NLmN9YhxVnPQQKzy10RKYN4I1kGW9tv/tBos7XoWKv+nMHVKjfp4jaskN/EqsunUX6Ael
	xTcnS0az4iOV+/EKRg2mRZtNGd86TNbL9DldQ+DOMe5xtHFpM46Nx6WgQUXrmPN3GElh1yn2jbR
	Ur2nE9Y8t8tKFTCXpJ1tdHBvzUF2KjeoLwhv7ZukxNMHOxQTYBTHvsxG5I6qAgYVEBQYPvWLiKQ
	xxobfmlCTbANFkfIwTOLXjef0ZFyy3ln+JYYMFf8Tq6spYeTy+uaOtWv7Nf96rbnOg87KvWcxi3
	ItigM95dvzMeOJfcHgohaYfMeW/RGmYQ2iKXYkmAXVdFPb14IXAlVkI6IXi3MKORJEHMK7aeOHS
	toDa6ad0WzLmfN3Psu92Natq1MMw==
X-Received: by 2002:a05:6000:4012:b0:4a8:f1a5:efb3 with SMTP id ffacd0b85a97d-4aa550796b2mr23844832f8f.11.1795362929563;
        Sun, 22 Nov 2026 07:55:29 -0800 (PST)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it (host-79-14-29-58.business.telecomitalia.it. [79.14.29.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c340df4sm20046526f8f.55.2026.11.22.07.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:55:28 -0800 (PST)
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
	Xu Yang <xu.yang_2@nxp.com>,
	bui duc phuc <phucduc.bui@gmail.com>,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 4/4] pmdomain: imx8m-blk-ctrl: Hold boot-on domain clocks until sync_state
Date: Sun, 22 Nov 2026 16:55:11 +0100
Message-ID: <20261122155514.10289-5-dario.binacchi@amarulasolutions.com>
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
index 99d75bfb69e9..e360cb038969 100644
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

