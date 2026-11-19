Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093413;
	b=Ii7FY0hYtV98yZP1pBe3aI0KDf/1fQsuyH8LAerXcCNlReuZdVS52jAid+TRUXAs4ZtP
	 hLhGNCSikT2aGzoXnFbON4M18vUhtYTlUgERMn2Z2AvQZzswzHE27P4et7eF6gvGXgJ72
	 o0PIdIXGFd2Ku5y+mY3Dktzt/ISvSSqaGhEQZVTU5VonLBEFKITdLaV4ODhKWKVkPSO2I
	 roSpDgBJy4ga5dWo3s9ZHsti3ISV1cXhoCgwssBhb2PF/LzQ22EqJrhEe4kOl9lteaEpa
	 928nhyDuWx84Y/+eo7XXyPDAPZyyp6of+iajl4x9mCQEqWy29T9RXIN8iycmuM7ua0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=YOJKLZNuDxiDombYJPat3LbhXw5M7Ig+dNscwWFt43Y=;
	b=alnpJdYSm6SU+iX+//AYz+trhuP47a/T8n1W435qI7bugGAEBNfV7daALuH5Xr+q+LcW
	 TKxdtpT5eROThcA1YTzfmRRo19sLzsxpmGw2AVJpQuq0HCTAbgtt7qqoG+XdAy5WVz0sH
	 HqF3YVbFivKPUBnoPqaIGf4WOhrqKJBGr8Q6xZgzbYCo5g0sqvbhye3QFH+vcxE0aF9hp
	 kz7p3DbeJPZ7fPoAUr+ei/dTnz93OccNOpX5v9jTUpUr26/9l81R4Qf5WZqBudD1Gu35o
	 z23U/y74lYVFMYaeqSNKMoh4JnrN9qIpYfGi3/9lAkb/f+UP76TOQFh8vJGdKlJD3mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WSTzP3Wu;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8F60A3806;
	Thu, 19 Nov 2026 13:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C8F60A3806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=WSTzP3Wu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093403;
	bh=nmQGX2bshDgcFD7WdCjhmzcgI65vzh41Ilv6V6Zqm24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WSTzP3WutGDd+M1CcwOeoKwTW8UZnkYZ6LaKu92Cy/CuBXJMJBAYt6C2S4d1gBEON
	 S/JBKcBKP0jiDCvYujD26hMq4ZOOsm8J+VsCDPnaaK+xcpZ3uw5BwCg2BAMZF1Y328
	 47NcsAiKpwHtoFu9MJTOSbHdAjX7EEpwwYZOSCBUydPNtZIFk9Q5zzZ1VzhCKJEBC2
	 Kp45oVhSd8MFpWtCT2YkXmNjw63iDdDNs79RaumDMpVo8xxrGBuOoYwqyBQBsjV1ct
	 4hTp3Kyf5+DMLmpxn0JIQ2QD1oMZxQEtWFakWqLHLnI4myFXkLq6olXrasR1oymIcg
	 9W1zJr0Cs2/PQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3C23617E0E34;
	Thu, 19 Nov 2026 14:03:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9A2AB48003D; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 19 Nov 2026 14:01:57 +0100
Subject: [PATCH v4 07/11] PM / devfreq: rockchip-dfi: use bulk clock APIs
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-7-517a68c008fe@collabora.com>
References: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
In-Reply-To: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-0-517a68c008fe@collabora.com>
To: Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@collabora.com, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4275;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=q4O8MSh4hnXjpwurlOXPD27hHNsi3+KnjWYGHwfNjAA=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr+85qBIO9f4QkNEKfH/DOiLYiZP25SEvj1P
 07DLwWnb9sLdYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PI
 O/qah18P+gJzeb9GT8TK8Cz9lPfra4cJYPVoRUQjI2dz44DzZNxLEotYEgd8WDBS4BU4FCKs/EC
 RlimCP6bKe1L1JmhegeYgzuHN1D4j5qiWB28r+xlcQIbBf3WKPPq6rRsw+dd0XmdUHVGE6HJasZ
 XbWUTtGdNwHWQsjZnl6iUe993KGT/r//AiDoRGSGHWBBHufdCMB0MWQgoUfOFL53jWuxy+hVTpa
 A7yIsEazWNNI3Grr9z3qMVxDhEZgL+JmjTZ+EpOrPV+5iNaVSufwRJvARyF3DCU/A4NNglSQKMi
 Xt6MegNSRhfrcumK3yx3tJjXqnIfcoXe9qcJvh7ma/neAsEyavnxrNciDtwvkVHeoEEZYE+Z/Di
 t4Ke9FUxoevM9DRtLIIagW0Am/7AH27avZHGT5fApfF4tgGt8oiE+geftvYGVcnH7Ymgr7A0Tf2
 Sf491MY2Asyk21S3dOTVQODxP8x+vcWnRfuPxp7I6JfxtwNL7BXmPDR5XiaUKXIHF04H9j39Xm8
 3lawvYtkIeVZVGnAZWJLoFAmhkmRCdQ6Q9dgPkJnJUT3ZU7ox0qI/vQRx/n6W7C6R7oloisYeuG
 0+C6uiAyw0f41XaSu1mWNGvz/uzaY5/o+XJlDh4bcg0CsrhQRYhiEiSmBqPa1BmJ1EJysUC5R1N
 +KOPUxT4ba0ZvkpSseewsLQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Currently, the only clock rockchip-dfi will ever use is on the rk3399,
namely pclk_ddr_mon. However, this is mainly because every other SoC's
mainline clock tree and bindings are probably lying and not telling us
about some clock gate branches that do exist in hardware, but nothing
happens ever gate.

Get preparations out of the way to fix this by moving to the bulk clock
APIs, which will make handling the one-clock-per-channel cases easier to
deal with.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 41 +++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 43da602ef101..2b9d9b26b11a 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -98,7 +98,7 @@ struct rockchip_dfi {
 	struct device *dev;
 	void __iomem *regs;
 	struct regmap *regmap_pmu;
-	struct clk *clk;
+	struct clk_bulk_data *clocks;
 	int usecount;
 	struct mutex mutex;
 	u32 ddr_type;
@@ -122,6 +122,8 @@ struct rockchip_dfi_variant {
 	int stride;
 	bool ctrl_single;
 	unsigned int max_channels;
+	const char * const *clk_names;
+	unsigned int num_clks;
 };
 
 static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
@@ -183,15 +185,16 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 	if (dfi->usecount > 1)
 		goto out;
 
-	ret = clk_prepare_enable(dfi->clk);
+	ret = clk_bulk_prepare_enable(dfi->variant->num_clks, dfi->clocks);
 	if (ret) {
-		dev_err(&dfi->edev->dev, "failed to enable dfi clk: %d\n", ret);
+		dev_err(&dfi->edev->dev, "failed to enable dfi clocks: %pe\n",
+			ERR_PTR(ret));
 		goto out;
 	}
 
 	ret = rockchip_dfi_ddrtype_to_ctrl(dfi, &ctrl);
 	if (ret) {
-		clk_disable_unprepare(dfi->clk);
+		clk_bulk_disable_unprepare(dfi->variant->num_clks, dfi->clocks);
 		goto out;
 	}
 
@@ -247,7 +250,7 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
 			break;
 	}
 
-	clk_disable_unprepare(dfi->clk);
+	clk_bulk_disable_unprepare(dfi->variant->num_clks, dfi->clocks);
 out:
 	mutex_unlock(&dfi->mutex);
 }
@@ -723,11 +726,6 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 	struct regmap *regmap_pmu = dfi->regmap_pmu;
 	u32 val;
 
-	dfi->clk = devm_clk_get(dfi->dev, "pclk_ddr_mon");
-	if (IS_ERR(dfi->clk))
-		return dev_err_probe(dfi->dev, PTR_ERR(dfi->clk),
-				     "Cannot get the clk pclk_ddr_mon\n");
-
 	/* get ddr type */
 	regmap_read(regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
 	dfi->ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
@@ -804,11 +802,17 @@ static int rk3588_dfi_init(struct rockchip_dfi *dfi)
 	return 0;
 };
 
+static const char * const rk3399_clk_names[] = {
+	"pclk_ddr_mon",
+};
+
 static const struct rockchip_dfi_variant rk3399_variant = {
 	.init = rk3399_dfi_init,
 	.stride = 0x14,
 	.ctrl_single = true,
 	.max_channels = 2,
+	.clk_names = rk3399_clk_names,
+	.num_clks = ARRAY_SIZE(rk3399_clk_names),
 };
 
 static const struct rockchip_dfi_variant rk3568_variant = {
@@ -839,6 +843,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	struct rockchip_dfi *dfi;
 	struct devfreq_event_desc *desc;
 	struct device_node *np = pdev->dev.of_node, *node;
+	unsigned int i;
 	int ret;
 
 	dfi = devm_kzalloc_obj(dev, *dfi);
@@ -870,6 +875,22 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	desc->driver_data = dfi;
 	desc->name = np->name;
 
+	if (dfi->variant->num_clks) {
+		/* NB: CCF is fine with us leaving this NULL if num_clks = 0 */
+		dfi->clocks = devm_kcalloc(dev, dfi->variant->num_clks,
+					   sizeof(*dfi->clocks), GFP_KERNEL);
+		if (!dfi->clocks)
+			return -ENOMEM;
+
+		for (i = 0; i < dfi->variant->num_clks; i++)
+			dfi->clocks[i].id = dfi->variant->clk_names[i];
+
+		ret = devm_clk_bulk_get(dev, dfi->variant->num_clks,
+					dfi->clocks);
+		if (ret)
+			return dev_err_probe(dev, ret, "failed to get clocks\n");
+	}
+
 	ret = dfi->variant->init(dfi);
 	if (ret)
 		return ret;

-- 
2.53.0

