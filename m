Received: from flow-a4-smtp.messagingengine.com (flow-a4-smtp.messagingengine.com [103.168.172.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489153D34AC;
	Mon, 31 Aug 2026 08:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164509; cv=none; b=ZKk4UOXF2UZnm5D6N1tpo3KPVAiiiFyadF7ZciK6UtYwTuvXOIt440dTQPwmc4m4KiLEPOUBqIobmUsxkkqXKhnJNz7gwSYyNRE4OfuAh92Z/DYc1/VlgHzzZQ96NkgMac90PtJVKLovM+ITtHzc9lnEVzuSplS0plXhCI4Je5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164509; c=relaxed/simple;
	bh=i98h2KyVaWOr/iBF7stkkIKZk/URJTaweBKbY2mKOOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXcfzFON9mrUC5KR3s3QYhZzEgKlpdeGpGByAzmwrq+eu0d9pGMdsV4a91d+7xm6AQ8TZyo6/5xIqTDBauEsBHbC5KUKkA5wCZO+Ii8WgkwhsgQFC/W9G5kZwACqypu/tsyiNjbcaKjX25qwFvf6N63K/8oYmJag7P0W/5uqtIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=qHVikLFW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BkzsxfYd; arc=none smtp.client-ip=103.168.172.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="qHVikLFW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BkzsxfYd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 711431380045;
	Mon, 31 Aug 2026 04:21:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 31 Aug 2026 04:21:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788164507; x=
	1788171707; bh=EuzlYllSmAZP6yajMRsW2NaQ/7lmKof72TRcxeRmWS4=; b=q
	HVikLFWi/fiHRnyEhpJfLitC7oOvrcleOhyCbn1OJcHyu9NPO3ooGG/WTcy1JsCb
	olbUAFmPsaguSETvAJLoLuImX5PChS586MYiAj3vczxsIaubCUSnkbcvcfwgj/Vj
	1nJh3+P95+frqy67AHi7pn3BWAjLb+btqRqRPCI0Zc0Bbx8NNlI1oiNyWGmOH3DF
	8xbd8yVoIyAYfJdXuML+o9y6c7jbZw2gm5aR2V9x4vKSAt/YBm3bFplLfQR1zYsz
	87iqrQ1gzpfYdkRqAcYvt6CqYTqwrf8UNVMr+qR4z0xaGSmxe3AO4Td7h4xahMFh
	z0BiOORGd9o3MHl0lQABQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1788164507; x=1788171707; bh=E
	uzlYllSmAZP6yajMRsW2NaQ/7lmKof72TRcxeRmWS4=; b=BkzsxfYdLk9VCMPCM
	pLjQh1ftD51Sx35+o+7C5/wN7L7V+SNz+1gGxjKPAfyCjV32bkK22zQjFg1H3HR0
	GsG7629+oe9evY4/0kjhq+GNPCfQmPx+sSWd+tG8Pu2Ay/Ztck0oPqt6MURPoxlk
	e7ASDHTbGPG1T1ijhvPuZeptg6gRhjeKnF4ILzZpV3JlfxM54rb2+JF90pn2pMsq
	4Q1tapk8H3DrnBNf4gVCgvLmv36/KZSu3a5DYqphPizlCzzzVAm/UFICndF5NxP4
	UwEFFwTginyjlfJgdjwEFyAYe0RKgstmuPWQQ7BmTr/2CrGGEdx6GFZwQDCFDlBL
	6CW2g==
X-ME-Sender: <xms:mzmVagl3C6yUhtHJ2cqx4C8TRxDPIZefTB_TulC6LJDPvazefIp7Yw>
    <xme:mzmVahUu8WH1N_UaUqkp64V9lEZ1g6RcKbuvSWIC0WCNy83PFR-wOaPpllak2cwxK
    QhKEdC8dN8ex2ciLOAc2-oX1Pym6PxBGrGVkHTdf-4TE5ZbTlLh6zo>
X-ME-Received: <xmr:mzmVajPcglgnqJ6sCORzg0425ndFqb7c-BZ4bHnMDFMO1d35TuXkmQYIF1-Uiv1xLKJdT77xxA>
X-ME-Proxy-Cause: dmFkZTEKWQSpa8iZqUtW1ZQqP4bDvh9SK/YZ53CarhgclGKwi9pBkSeAm2pl18Ydw9NqYm
    Zr/AB6JK94O+RJj3+nPdviPN4WL0ogDKkl2CMFV9N9D6NSBN5M/LV+S4GH+TRhS9zu3x5c
    x2UqefLwNZ1g6jIgnHYbLgvH6Qcfxwr5ayCKwx4jXlH2P7ErMCLVryfACFcfAxxNF+zWzB
    vhDdjBzJlYCkkDZuwtnUqHTI+YlUUPPhU6uGHE0mVT/tu7g0EvFCbzZenGG7GfkWbRsTX/
    Fnz7vKpfqzHdp9e6NpI62zQZ3fDQSeSft9eBVteswNRFnAgakK0VawtlqkiHWFDHZGPmZ/
    RLA6W00BnZUPO6lPqXvK27Vlt5IfgVBTlyK1yCf8jZiswalTyHVn+ITtwUR0RD0f54lamZ
    sjkAa9RCPa7WKjY+nVcSM0dJhkMmx/0jT4JVsE+B4qygxld8PnfwgnHoi5LjDQTMoTxFwl
    D/jKHGt/EwB9eQR7cHAj/ATpydqxeskcarggV1qP0x/4mH0YQLqo4WNHuOtO3YD4JwTenZ
    lLTnngdjyHpXAnoSF1m7QP0Y7apOK5p6dUybBq4UPJJ5FDpvcWYzqS8RZEovNgnyYrOteX
    BXn56WQw6ZmE7E2ZGL+ptlPXXBR9Ignbqe2LI+F/d5dnIFIhoZ18IlP6KBew
X-ME-Proxy: <xmx:mzmVasE9gx5dFWAir_CcJvdo9d6DIbnD4p4S4dwgNeqAmzAXL11vkA>
    <xmx:mzmVas0IQOuK4HC8bHKD6yV6Kc7SKdOeHNEd7ARvtFBG1rB3rJht5Q>
    <xmx:mzmVasMDzB6x7SmqBTm8jjcc-MoTlawozfnJAQM9RrDiBe3zn3WgSg>
    <xmx:mzmVasLVs0nep5Suh4KKSPlOW7JaAWfV8wm5_kMViNVEgTh5AhJr2Q>
    <xmx:mzmVatEeXvlKIvk1dt1CT-cSmF3xvmI42Sh4oE2RGcZLGcb2VqL784fe>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 31 Aug 2026 04:21:39 -0400 (EDT)
From: Jiaxing Hu <gahing@gahingwoo.com>
To: tomeu@tomeuvizoso.net,
	heiko@sntech.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de,
	ogabbay@kernel.org,
	zhangqing@rock-chips.com
Cc: royalnet026@gmail.com,
	u.kleine-koenig@baylibre.com,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	alchark@flipper.net,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>
Subject: [PATCH v11 10/14] pmdomain/rockchip: cycle optional power-domain resets on power-on
Date: Mon, 31 Aug 2026 20:19:52 +1200
Message-ID: <20260831081956.84871-11-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831081956.84871-1-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Rockchip domains come out of power-on with their bus interface in
an undefined state. On the RK3576 NPU this shows up as a hang on the
first register access after the domain is switched on, and pulsing the
domain's resets at this point clears it.

Take the domain node's resets if it has any, and pulse them between
releasing idle and restoring QoS. The resets are optional, so domains
that do not list any are unaffected.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 39988efd8..8f2fd8a83 100644
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
@@ -692,6 +694,13 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (pd->info->delay_us)
 			udelay(pd->info->delay_us);
 
+		/* Optional: some domains need their resets cycled after power-on. */
+		if (pd->resets) {
+			reset_control_assert(pd->resets);
+			usleep_range(10, 20);
+			reset_control_deassert(pd->resets);
+		}
+
 		rockchip_pmu_restore_qos(pd);
 	}
 
@@ -861,6 +870,14 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	if (error)
 		goto err_put_clocks;
 
+	pd->resets = of_reset_control_array_get_optional_exclusive(node);
+	if (IS_ERR(pd->resets)) {
+		error = dev_err_probe(pmu->dev, PTR_ERR(pd->resets),
+				      "%pOFn: failed to get resets\n", node);
+		pd->resets = NULL;
+		goto err_unprepare_clocks;
+	}
+
 	pd->num_qos = of_count_phandle_with_args(node, "pm_qos",
 						 NULL);
 
@@ -931,6 +948,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 	return error;
 }
 
@@ -949,6 +967,7 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 
 	/* protect the zeroing of pm->num_clks */
 	mutex_lock(&pd->pmu->mutex);
-- 
2.43.0

