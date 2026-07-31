Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143233939D;
	Fri, 31 Jul 2026 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785472543; cv=none; b=P6E5+m1sekeVAc1UD1OxrptTo6WKszJvLkDxN7NqWgTEWpjn6FNiL8f4PzYXDv5PMrGCNF5EPOunRSuFKGxmaxC2n31wOlZBCEKTqmKDVoclABU4CTzvMw1p1M/pqkExpqiGvdIKd6chaYJ8WU0MIMtI/Lh8hWdAdOIm6e/Xn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785472543; c=relaxed/simple;
	bh=NYWeX1zT+UWLIEpQ6DXkvnWhzoaOxj6r57zcKYjDIXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZCbvMF9IdlxtHH/HNzydU9ZCpgYo5d4YBfsk/RmVQ+IV5H4AlYdVeI4NWZ5zTUgxj2wl3DfXFWLSswtHJM+MtRbgyvy9b3KNKVdovOoGM3V08qS1INtYTkDzja9V/vUULEfaMkGNqbEVI6IdIaLwKyaiDHNyfmkyJir/iiftbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=LQpdNp8Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CuMO39co; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="LQpdNp8Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CuMO39co"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id BCDAD1380308;
	Fri, 31 Jul 2026 00:35:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 31 Jul 2026 00:35:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1785472540; x=
	1785476140; bh=vfiH5V16AyO9stikNxuMC7UErEwVoICawUpn+9ckh+U=; b=L
	QpdNp8QE2ar35yEgP6yb6E4HWWAMOyaURlf2TfWLSE+weEgswKn9rengcJz3HcmH
	AA9MkKb1HYL1SMPduP/hSmmL0Y5348mqSVNDFNf7aS17bFh9AhwweCuLOGHkwi0U
	eEwCKDjBSieWoRjol0pyUGUL5H/ACCjnJ5MwcD3DQWxoU6S1GFRD+f76drHTVtWB
	JokOds7Gvb+r8z5fcXl1rNuLyN52PVErhFIjs0L4H1UnQPPYcqhoWvnfvmbJk6BR
	By6pkj/4KMM2rwBDBEDcqBhcEDWpezdyH89hp7OeCcyh4H6NIywf05Zo8cH0US6u
	hOfxSwFaRx3CkuJfEjyvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1785472540; x=1785476140; bh=v
	fiH5V16AyO9stikNxuMC7UErEwVoICawUpn+9ckh+U=; b=CuMO39coTUAyumyaj
	SlaAcZC/Mymx3wM6Wfe/0iTWY3fR7Tmv+4BmtQpR1DgDGy7QiZ6cEF6thFK12gHe
	yHN8ZsyZOF/ICa9hxhfHvoH0odRAU4gEj66uH6h7VFIMeW4dYtApH+3GzdaPtyOE
	81HxkK1xjnGSA3WBcfI5mt+ayIDzNAiN5e9JGr3UdhYzqUr3HTgMcefPOOzprzvA
	1r5KVuhTPl92foC1TzJhwGAVYlq6YTg0Dn6pbL2ZQ3vW3Py/dGlTQ9T6CdMxFjOJ
	bae+bbkAcK6SO/4fjftJecHcANBfY8qgTMA4i1cgF3fnzkYNeCtOpt65sdPFRh+c
	/35Bg==
X-ME-Sender: <xms:HCZsavYpF50s7aW2WzXTn6tCQxlOLxTngLMcRBMtisaFSdww9axpzQ>
    <xme:HCZsamWYTrnEW85HJ7oPtVEqAq7JSgapqYXoXRipzJeIACmsvKev7844Or6k09MCR
    CepZuCdVDvNSTGiHV5edVCOBRRRV6TyzEGyucbzKCRxhHOeJYuQwPAR>
X-ME-Received: <xmr:HCZsapKqI6xQkkC3eH9Q6SZ4pWnfGjwszRGBoUx_Cb0D6mmLPFafXoBSXgLO2BjdKhN1VGsxFw>
X-ME-Proxy-Cause: dmFkZTGYT4kL28qB16BISDukPuRI13bgUTT3tZ+FwfFOi9iyRIQ4cdWQvs+qtyjYhb8aZv
    7ZNLDkjsiNZpV57v6b2mii/c57NwdcNZfLGFST9tf2uM8u59dW+Prl9GdDUx4nV+E4lAra
    SQEwebYcIunW3qRo5j2tIFm46bFqTUlJGjqQ9G9vA9CMpIOxOxZMoG/yT+2+8464KOGHAY
    8imDrR7vRedTQm5ukLhDfImc5hqq/PMdpFBDkbYJy2uWgqM9NADLHcVQwbEaQMfbuf/RMq
    10+PB7Nd2itAuYvcdzVTZtUYUQ86psUPJqGvTKqOSymMowMLYjogTDdmqQ1+5Yqwyb6wmf
    JSvlG9/5D0DLlR/pyNn3qNI9clPJUCIQPSfVrLbDEDy12Hwb2Ew02t95WcEyH8rdV+gPQ/
    KAStDW8gD0OCH+yNXkUruoT7cYZT7HBChdQ60aZSQpmrpUufga0MoYA8JEajqHUNZGhL/d
    K3RwtxLR+63GPIWLaxadlrNg3eGp8xSfFKV6DeQxnRVL71n3/5GVEHlnDG5N/diQKeLoZi
    UaAZteLXnMfFHiGWmemLlJWxwSNq6z4J9uoergRTA6AxAoz4g+HzQzztTkiozDSsWMmdNT
    t02O46JPd2qSwhloLX6Ah5iWO20ConyGtqVtw62rNAkZ5vTmNBC4k+PGQrMA
X-ME-Proxy: <xmx:HCZsasEp6kWK6TmvtsX9zbEJIu42K6KlTqlvGePKqV3bQIl5baXW3Q>
    <xmx:HCZsamx_ErQoIxl7oeb1ez1G7-G2qA0-kB-1M5TmKbLLBrh6pgRuHQ>
    <xmx:HCZsahiBoY6XBHjlqH8B2rr-z9pjVe76F2Hi8ffe7H6opbxO4dQysQ>
    <xmx:HCZsarJ7PsE_0b0VrJS07IKbC1_pSuvQIzhsNQe8tetXaKdUGY9Bhg>
    <xmx:HCZsaqOVEPn5LqSubvlNbc1J0rYPLtvy99QRhQK_YEJC5f4VIdtB39NC>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Jul 2026 00:35:34 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com,
	alchark@flipper.net,
	royalnet026@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v3 3/6] pmdomain/rockchip: cycle optional power-domain resets on power-on
Date: Fri, 31 Jul 2026 16:35:04 +1200
Message-ID: <20260731043507.1832277-4-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731043507.1832277-1-gahing@gahingwoo.com>
References: <20260731043507.1832277-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Rockchip domains come out of power-on with their bus interface in
an undefined state. On the RK3576 NPU this shows up as a hang on the
first access after a cold power-on; the vendor kernel cycles the
domain's resets at this point and that clears it.

Take the domain node's resets if it has any, and pulse them between
releasing idle and restoring QoS. The resets are optional, so domains
that do not declare any behave exactly as before.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index e1857f878..82051f600 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -19,6 +19,7 @@
 #include <linux/of_clk.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
+#include <linux/reset.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
@@ -103,6 +104,7 @@ struct rockchip_pm_domain {
 	struct clk_bulk_data *clks;
 	struct device_node *node;
 	struct regulator *supply;
+	struct reset_control *resets;
 };
 
 struct rockchip_pmu {
@@ -688,6 +690,13 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (pd->info->delay_us)
 			udelay(pd->info->delay_us);
 
+		/* Optional: some domains need their resets cycled after power-on. */
+		if (pd->resets) {
+			reset_control_assert(pd->resets);
+			udelay(10);
+			reset_control_deassert(pd->resets);
+		}
+
 		rockchip_pmu_restore_qos(pd);
 	}
 
@@ -857,6 +866,14 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	if (error)
 		goto err_put_clocks;
 
+	pd->resets = of_reset_control_array_get_optional_exclusive(node);
+	if (IS_ERR(pd->resets)) {
+		error = PTR_ERR(pd->resets);
+		dev_err(pmu->dev, "%pOFn: failed to get resets: %d\n", node, error);
+		pd->resets = NULL;
+		goto err_unprepare_clocks;
+	}
+
 	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
 						 NULL);
 
@@ -927,6 +944,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 	return error;
 }
 
@@ -945,6 +963,7 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 
 	/* protect the zeroing of pm->num_clks */
 	mutex_lock(&pd->pmu->mutex);
-- 
2.43.0

