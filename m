Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795687292;
	b=ytyPPiK5LjaYR6tZ9ZMoNAdCiYy5BUH8jlUp2VI65xcK650pfi27fLtHwmdnXffPzXow
	 deLHFfpoLZESsjeVonth7UwoVJiWhP7HZO1JEiaSUnLNF4m0juVZ7kR8sBXwKRAlWp3Rl
	 9oM7cL8+oS6uNHK1wc/Q0fdpWh6C/lMHZF14pEBECeLeELl7jKy0ZkxBvCRoiskgA1zRS
	 HnLu5z99JrH4iosAxw5CqSddAbZEtTjTF/h/B6vJlHl9/tq3i0ySxmccGc4u3tRGK2cns
	 eevG+m9i5IxbhJt4MsL96USXS7JVF2oDbemwla3ebm90EO4iKv2uwuref1WIdzeoW8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687292;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tiV6I1JiX5+frkJIFjtgyZXuAnFwqRw24mF7Pa1M3oU=;
	b=G0HYmOT9Q1t8XgRJ4lyPoz8kzRq5ftlO1KqBrt5ug+0cixRkOfh0gRwN1BeYD24EeTeu
	 vPa3Zog7F70v520pmeRSe863H7FA6S47fjZRBgD7kuo0AR4He5QHTriRV12FA3//Y7/1x
	 a1wPFT5V+MFt8QndRRaiC4lCs3ZeqeojohYppMMf8vd+dERWIslG7dr0XvWhaKGwL46FH
	 zIskGSybjGgkszJYHPxBgczgMGbYTA1U/3cwwHwEd/KTeAHjnKuo1bgp1MLXwY9y+Qf1m
	 uQU177m8jvKQrjSlPtAFVtNcLzpkg1IIuBu3y5kycTJ/+bGtHiGhYFN7dlsOAt9iyVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJ+4o03t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA739606A695;
	Thu, 26 Nov 2026 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJ+4o03t
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795687292;
	b=h2mCYSF1fTg7YUGSAn0f+v/RHxuThcYkwrXNCN6a7cEeIh2e449vLvt1Au8/M7ec1H32
	 9jz2BCJcUm8p5wpJvrKGBLM1AQvbLgri+cHu26WlPQ2IzTrmQvbdgxJf5REup9MvVHXPV
	 3mzDwPD8FSTectj+efD8S4Lv4p+hcS587P9MggIxLwf1t/ZkWQbuyEM7KoOOOKX4na1dz
	 m3zYx/WjRhHk7chOfFpihr5+sDl8SJnSQR7Ik7P9hT7DpesoL4qqrnKHJKp0y/YUPbes5
	 /rwxfh7w+BgM+J8UxdKBt43uHovD2rCEP0Jti0ReSQPTaoMSGA7Le5j1DRMIqAiY4LA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795687292;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tiV6I1JiX5+frkJIFjtgyZXuAnFwqRw24mF7Pa1M3oU=;
	b=DzWECX3/Epk4ueojTecp7dzinVvi8n9K4fz2nkcaFLMem6dEnQao6i/sC4JJgBN1m7fF
	 LOUyM7qZ/kWWTVYPJ7ZrlNFpVzqnE9KojeOxLJTAAjrnzlvUZ+wo2q9WM8trd/QxblbWi
	 aKEqw2i8bJ7gW9fgK4Svebp986fCDIE9yvwfrwuIv0fZRlSwegql0xsrJNj4xKw/dC7FR
	 aJuh5bn/MM16rhSZJW9VrIbdLRRCiLAc5pm5r+u2dWHKX0lRXKljgxAaN5NzKUMsjAurk
	 5K8U7wIlFCP4MRZ2R7XJ8Bxm9pGN/S/Q2g/XZtoo6mHfp6pPcoxzT7BtIke8hY5dQwg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A77F11F000F2;
	Thu, 26 Nov 2026 10:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795687292;
	bh=tiV6I1JiX5+frkJIFjtgyZXuAnFwqRw24mF7Pa1M3oU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=EJ+4o03tGDPDhINVMy50R9iYnWYDXTIPBpAFPSHVLHEeQHZGde5pLK2pRdWW3LIOO
	 mP7xHfAFWHEsZ8IJCm8O5z6VA4zB3KnlccVaRfH1NBOkXlX/AhnOzaxrt2gSkQP9Z0
	 NESkxgZhoNdWIqw79h3iCkM+K2ooZmxDRxWHb84RD0OrUnz5Cclcq8PXJ0QqHNd02R
	 44VXrbrT3r3a/md1ha03SZ/lg6yG5GiZ/PgQYcaPgH/PfSqLuXSj2CHFflpoDJ64RL
	 QXmICKDlz+lO0YM5IkB1WKIr78H/RHgR6RLnQrT9/D4uGO1gPUJDu+LAbr34cOqvJS
	 wwapvFdOPOI4w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2E3724D3F2;
	Thu, 26 Nov 2026 10:01:24 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 10:01:26 +0000
Subject: [PATCH 3/3] pmdomain: rockchip: report domain errors where they
 happen
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
Message-Id: <20261126-pmdomain-rockchip-cleanup-v1-3-a19f5ea7d555@gmail.com>
References: <20261126-pmdomain-rockchip-cleanup-v1-0-a19f5ea7d555@gmail.com>
In-Reply-To: <20261126-pmdomain-rockchip-cleanup-v1-0-a19f5ea7d555@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Yao Zi <me@ziyao.cc>, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795687283; l=3430;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=3AtAbt0gF5z4t2/yujfDXZ8Drlb6obYk/ZkMiiGPe04=;
 b=j+aLrJix27Oqfi1XC8nUFAK/8l0MqREaHGMArIJ+AoRbOnYDN/6wIpgqSGW7t7ylhckA+sm7l
 ipCOyxDq/MlB4wbav21x1xx2dYDoIlwQTlTtDuW8lyrdmaFRAmyIEdS
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

Print the clock prepare and pm_qos failures with dev_err_probe() and
drop the callers' "failed to handle node" messages. Each error is now
reported once, and -ENOMEM stays quiet.

Suggested-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 40 +++++++++++++++-------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 9d5a79c6d4f9..c3df32934120 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -881,17 +881,19 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	for (i = 0; i < pd->num_clks; i++) {
 		pd->clks[i].clk = of_clk_get(node, i);
 		if (IS_ERR(pd->clks[i].clk)) {
-			error = PTR_ERR(pd->clks[i].clk);
-			dev_err_probe(pmu->dev, error,
-				      "%pOFn: failed to get clk at index %d: %d\n",
-				      node, i, error);
+			error = dev_err_probe(pmu->dev, PTR_ERR(pd->clks[i].clk),
+					      "%pOFn: failed to get clk at index %d\n",
+					      node, i);
 			goto err_put_clocks;
 		}
 	}
 
 	error = clk_bulk_prepare(pd->num_clks, pd->clks);
-	if (error)
+	if (error) {
+		dev_err_probe(pmu->dev, error,
+			      "%pOFn: failed to prepare clocks\n", node);
 		goto err_put_clocks;
+	}
 
 	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
 						 NULL);
@@ -916,13 +918,18 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 		for (j = 0; j < pd->num_qos; j++) {
 			qos_node = of_parse_phandle(node, "pm_qos", j);
 			if (!qos_node) {
-				error = -ENODEV;
+				error = dev_err_probe(pmu->dev, -ENODEV,
+						      "%pOFn: failed to get pm_qos %d\n",
+						      node, j);
 				goto err_unprepare_clocks;
 			}
 			pd->qos_regmap[j] = syscon_node_to_regmap(qos_node);
 			of_node_put(qos_node);
 			if (IS_ERR(pd->qos_regmap[j])) {
-				error = PTR_ERR(pd->qos_regmap[j]);
+				error = dev_err_probe(pmu->dev,
+						      PTR_ERR(pd->qos_regmap[j]),
+						      "%pOFn: failed to get pm_qos %d regmap\n",
+						      node, j);
 				goto err_unprepare_clocks;
 			}
 		}
@@ -1074,13 +1081,8 @@ static int rockchip_pm_add_subdomain(struct rockchip_pmu *pmu,
 
 		error = rockchip_pm_add_one_domain(pmu, np,
 						   to_rockchip_pd(parent_domain));
-		if (error) {
-			if (error != -EPROBE_DEFER)
-				dev_err(pmu->dev,
-					"failed to handle node %pOFn: %d\n",
-					np, error);
+		if (error)
 			return error;
-		}
 
 		error = of_property_read_u32(np, "reg", &idx);
 		if (error)
@@ -1162,20 +1164,12 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 
 	for_each_available_child_of_node_scoped(np, node) {
 		error = rockchip_pm_add_one_domain(pmu, node, NULL);
-		if (error) {
-			if (error != -EPROBE_DEFER)
-				dev_err(dev, "failed to handle node %pOFn: %d\n",
-					node, error);
+		if (error)
 			goto err_out;
-		}
 
 		error = rockchip_pm_add_subdomain(pmu, node);
-		if (error < 0) {
-			if (error != -EPROBE_DEFER)
-				dev_err(dev, "failed to handle subdomain node %pOFn: %d\n",
-					node, error);
+		if (error < 0)
 			goto err_out;
-		}
 
 		/* A domain left on is not fatal; carry on with the others. */
 		rockchip_pm_power_off_subtree(pmu, node);

-- 
2.55.0


