Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795687294;
	b=vyYylnOHvOM62SGgDTVYfyWSHW3Pc4hbZfkOenkiHMNvHe0UpSvcJp7TDrKlpWmQ3bG4
	 X64PgmyBummT+2Lcht0USXToacXHcrQcZU3GPXXWXo0KWVaVr3ULHQm359UOrfWVieA3h
	 VOPJL4aSEcJRUmIuiVlAfwVCRUjG/LzLmKRf7Iq6YqfurYAbp5H7vYwo936WzmhI6XAxD
	 6OItjyFtfoBhWisSX3EvYyIkkhW7u1vmPe+hppwApVUHH5EL0RMvklcOFijaYgMj6KjRQ
	 mM5je78DtxO8MAAf87VPMIM6Sx2V8mzNJHJduRTp0+2VniUBW8YcIyVvC7G1kJ8WU0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687294;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2ujEHY0Zi0y5OyztYT2I9S8JHnB/HKpYJXPk+96/YlQ=;
	b=ku0mcp9O4aDA0WOipAPGQrPbNPPo/+urR6VU5CnwsKbP4xkXOS0vJngjoQF3Yu1Bqt2X
	 z13VoVK1JGn5aK1rd55u2zL2zESrf3g02l2n8cBNcN7lTI4KOuXrPnJyqw20scndRY1ic
	 cTZ6ahbwDugVk1W6Ap+qYetaQiZa7qZdvxLedO6qmXfVrsIe5xPMlGsFvK8+0EvEFSInf
	 DBSqrsO3c1Huu+VqaiY2Z9Sfr1AvgwQ7Chyogg8oT58VPrrDpmXmHIrBi9zjMr2DvbeoL
	 Kx+DzACvOY8VhBPAp7fTxiOSI/Cu0Fw5y179JtRc+fKJ6aqgvLoBeUuVJcSQiygYQ4g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvLVGao1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0147606A6A3;
	Thu, 26 Nov 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HvLVGao1
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795687294;
	b=08eWDTeaGy9O9yX3lSmkdz4AMrqV68LTlluPNuwhd+g9o8mY9oSEtkTJVyHF3SOYDaJq
	 kw4X0g9hJJGTCcV+L5DfVyJX4I8gxNk1gaOaIldGa5mq+unPxIyiVmnqTeRNvnBgCAq5V
	 QIqc5A/Ve1YSWs7MpvSgbKaUcdtU84yhNFiNmRgb0XNnCFb6o4L+DQKcK/6ac8sgniveU
	 /C73L8aBeMecLWJdwbnA+IJgM9m8WpOO98VPO+Tow4m1h+3Z7WdXRHdamMPketDijsYL1
	 gcAuvvEnYpkf42xx58wTVjTLo9JPGTMD063Nw0itOjO33CQbCzH/e7L3A+m0EP9cCDw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795687294;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2ujEHY0Zi0y5OyztYT2I9S8JHnB/HKpYJXPk+96/YlQ=;
	b=s0XfIVpdJ+ZQNC00JhNVV5GN6NgLQMbv6EG+6tmYJc7q0WoSflo+uTCE4O6oh7v0P1xc
	 IeWixMDDktab53M+1g5FHg2khbxqZUzjiy9LrerZ4oCXMJbyyDjaSIKkUISPZguSkLaFT
	 z6Qek7pDnf4wC+J9ecSdc7Aij7PtERtnTjyN00yL6pEyjWlw2l7hXlFQVTt7UtZJ69Ms+
	 7eeajzZH+Dg8hTT+rpNzpeqG/83c7FD2Qbw7jaSZ4JX0jSzUTZfuLGBybXsV42KwFT05X
	 i5AHr7b8Mw32ctQCbrnwvvVOgH7i9ar8XGewx8vbNLjwGSDuWyWsyEyg6lRy+SPdAqw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 84B5E1F000E0;
	Thu, 26 Nov 2026 10:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795687294;
	bh=2ujEHY0Zi0y5OyztYT2I9S8JHnB/HKpYJXPk+96/YlQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HvLVGao1kuLiqQTBMvEvYO8v7JJZ4FCSdcNxgXRhVB+856TBzxK4vKn1rUI5yfoEa
	 UzquUmytJTuOe/uYh1UA/WZ//ZbLUSVLHCPTm8Pq3i1oi6C4nx3WxbECIaNHjt/q9h
	 lSeQXsatbtLaCAf385wocA5zLs53xcsgWw5No88myg2vtqqZbQZBcyHrusqHq9JnmR
	 BL766KnrVXU5Ac/Y11E55GQHR2uTJtXM37s85AVDjQXPHqCx6gCFlYAfIgYA4KdGoK
	 tYnKZBKtUB5g/ZArm34q3IJHwsjqDFpqBO3eAAnh+E44pbD9Rl2Wdim22zR2ZUn7iA
	 /Tt4aRMD1v8ag==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0D9A34D3EE;
	Thu, 26 Nov 2026 10:01:24 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 10:01:25 +0000
Subject: [PATCH 2/3] pmdomain: rockchip: use dev_err_probe() in the probe
 path
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-pmdomain-rockchip-cleanup-v1-2-a19f5ea7d555@gmail.com>
References: <20261126-pmdomain-rockchip-cleanup-v1-0-a19f5ea7d555@gmail.com>
In-Reply-To: <20261126-pmdomain-rockchip-cleanup-v1-0-a19f5ea7d555@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yao Zi <me@ziyao.cc>, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795687283; l=4842;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=EuQMv/4YZ9MKBCAwmy2pWeQx5JPLsPHE+V7fKlPqOcE=;
 b=PkWY7V9lN6YIaE5jS+PW/vU+Ml5zf9WOW6JDrNkQEWpdrHtdPrqAE7zHSQl56yI17wpz0+JnB
 F02kVG33IuUCwYpNho0/o2KlnExh/zWPiELveBTgGBoa4qa7KkpzuQ2
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Convert the dev_err() and return pairs in the probe path to
dev_err_probe(). The return values do not change.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 82 ++++++++++++++--------------------
 1 file changed, 33 insertions(+), 49 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index b52bdf0e8a19..9d5a79c6d4f9 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -842,28 +842,22 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	int error;
 
 	error = of_property_read_u32(node, "reg", &id);
-	if (error) {
-		dev_err(pmu->dev,
-			"%pOFn: failed to retrieve domain id (reg): %d\n",
-			node, error);
-		return -EINVAL;
-	}
+	if (error)
+		return dev_err_probe(pmu->dev, -EINVAL,
+				     "%pOFn: failed to retrieve domain id (reg)\n",
+				     node);
 
-	if (id >= pmu->info->num_domains) {
-		dev_err(pmu->dev, "%pOFn: invalid domain id %d\n",
-			node, id);
-		return -EINVAL;
-	}
+	if (id >= pmu->info->num_domains)
+		return dev_err_probe(pmu->dev, -EINVAL,
+				     "%pOFn: invalid domain id %d\n", node, id);
 	/* RK3588 has domains with two parents (RKVDEC0/RKVDEC1) */
 	if (pmu->genpd_data.domains[id])
 		return 0;
 
 	pd_info = &pmu->info->domain_info[id];
-	if (!pd_info->pwr_mask && !pd_info->req_mask) {
-		dev_err(pmu->dev, "%pOFn: undefined domain id %d\n",
-			node, id);
-		return -EINVAL;
-	}
+	if (!pd_info->pwr_mask && !pd_info->req_mask)
+		return dev_err_probe(pmu->dev, -EINVAL,
+				     "%pOFn: undefined domain id %d\n", node, id);
 
 	pd = devm_kzalloc_obj(pmu->dev, *pd);
 	if (!pd)
@@ -1072,12 +1066,10 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 		u32 idx;
 
 		error = of_property_read_u32(parent, "reg", &idx);
-		if (error) {
-			dev_err(pmu->dev,
-				"%pOFn: failed to retrieve domain id (reg): %d\n",
-				parent, error);
-			return error;
-		}
+		if (error)
+			return dev_err_probe(pmu->dev, error,
+					     "%pOFn: failed to retrieve domain id (reg)\n",
+					     parent);
 		parent_domain = pmu->genpd_data.domains[idx];
 
 		error = rockchip_pm_add_one_domain(pmu, np,
@@ -1091,23 +1083,20 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 		}
 
 		error = of_property_read_u32(np, "reg", &idx);
-		if (error) {
-			dev_err(pmu->dev,
-				"%pOFn: failed to retrieve domain id (reg): %d\n",
-				np, error);
-			return error;
-		}
+		if (error)
+			return dev_err_probe(pmu->dev, error,
+					     "%pOFn: failed to retrieve domain id (reg)\n",
+					     np);
 		child_domain = pmu->genpd_data.domains[idx];
 
 		error = pm_genpd_add_subdomain(parent_domain, child_domain);
-		if (error) {
-			dev_err(pmu->dev, "%s failed to add subdomain %s: %d\n",
-				parent_domain->name, child_domain->name, error);
-			return error;
-		} else {
-			dev_dbg(pmu->dev, "%s add subdomain: %s\n",
-				parent_domain->name, child_domain->name);
-		}
+		if (error)
+			return dev_err_probe(pmu->dev, error,
+					     "%s failed to add subdomain %s\n",
+					     parent_domain->name, child_domain->name);
+
+		dev_dbg(pmu->dev, "%s add subdomain: %s\n",
+			parent_domain->name, child_domain->name);
 
 		error = rockchip_pm_add_subdomain(pmu, np);
 		if (error)
@@ -1126,10 +1115,8 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	const struct rockchip_pmu_info *pmu_info;
 	int error;
 
-	if (!np) {
-		dev_err(dev, "device tree node not found\n");
-		return -ENODEV;
-	}
+	if (!np)
+		return dev_err_probe(dev, -ENODEV, "device tree node not found\n");
 
 	pmu_info = device_get_match_data(dev);
 
@@ -1146,16 +1133,13 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	pmu->genpd_data.num_domains = pmu_info->num_domains;
 
 	parent = dev->parent;
-	if (!parent) {
-		dev_err(dev, "no parent for syscon devices\n");
-		return -ENODEV;
-	}
+	if (!parent)
+		return dev_err_probe(dev, -ENODEV, "no parent for syscon devices\n");
 
 	pmu->regmap = syscon_node_to_regmap(parent->of_node);
-	if (IS_ERR(pmu->regmap)) {
-		dev_err(dev, "no regmap available\n");
-		return PTR_ERR(pmu->regmap);
-	}
+	if (IS_ERR(pmu->regmap))
+		return dev_err_probe(dev, PTR_ERR(pmu->regmap),
+				     "no regmap available\n");
 
 	/*
 	 * Configure power up and down transition delays for CORE
@@ -1204,7 +1188,7 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 
 	error = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
 	if (error) {
-		dev_err(dev, "failed to add provider: %d\n", error);
+		dev_err_probe(dev, error, "failed to add provider\n");
 		goto err_out;
 	}
 

-- 
2.55.0


