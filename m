Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D1B4071DC;
	Mon, 17 Aug 2026 11:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786966660; cv=none; b=gTYej6zpyjb8h2uEAmNWZgrh0uUNSgH322zsjY3Fb5gUXXrnTaLSfxHKOG9Jr+2tAqnt+DPohOXk2HqWqorMNOeLC1WFO9UF6M5YmHEEDpcIgM1HIuu40DLQ3Q3q2HqT4uVrZOpYC7hrK7aTEKGvmBMufoLTyOUcKC2BvLcg6sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786966660; c=relaxed/simple;
	bh=BINA7y08BvXk+5tFUCvn8rDGzX4PaIC66daBZMXhtDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDZ/i0R22u0ckpIA8NiGVH8tn6mPO3cvYnf2S61EEhAOmP3m0Obu8yHYSjsXukmwJNhCZHZBFrWvtdQKWHyAePuRgDhDrdKaH4fpVMsgY/YekNoU2ey7Ezl7U90w1D+VWzaFg7Hrz+Q1mgH71gaR1waLHeYwaXfbQRduLS13BUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=O09+0ERu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LwWg3G+V; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="O09+0ERu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LwWg3G+V"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id B68311380159;
	Mon, 17 Aug 2026 07:37:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 17 Aug 2026 07:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1786966658; x=
	1786970258; bh=fS23uuCXhX5KBwhj1s1IBkURLfoPr5JSNb7BdIodlrI=; b=O
	09+0ERu41vWgOEp53K/yLnvKcPUy64StIQdZqCeltZyDXjtR9YX8VNqTgXAM71wY
	pf3P9JlJS+3TZF22XlNIh6R4ItosaI5PyOzP1ZXUEe+U/elai34Fvs4siXV4vUYa
	T4OeMH+d8hHhCwkob17ztrBseKAVAo4sevV9M4sErwwpiAR3ibaIeBXK6h3T/X1y
	1WNQSox/5/Kee7sNe3LktyToFyRtTVb7U2LrZR/WOBCzcGmkHErYNj6TP4803dyE
	OHoWbU/Db3+iX0FYhjOarulDk37JqsVTfv79x9jvcCuXsmWN/b/wHz6B61hMZlxi
	N/jOnpRlcDhf0A49vX4Wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786966658; x=1786970258; bh=f
	S23uuCXhX5KBwhj1s1IBkURLfoPr5JSNb7BdIodlrI=; b=LwWg3G+VDKF83mi2a
	lLb37sFV1Vc1/fDwslIAM+BabC71dQYJaXEH/QFnPyd2JK8d2gEaVeXw7LuEziBp
	haIcI65+9TB95pyIsICNRbmo3qQzI0ih0/TkfduidMHB+GfZ4IFAEMQDmLRb4bM5
	PaRGh/5V+oygDtKuleZm3FtLYB0BGOXNDs+Bes45aDfZRgi0UPj+b5rHUtjIJ/e4
	ji1uM6V3PSft0sRypcPhalpQS5PU4Wd+hHNItfFJ+JsaX3D6abw6I/qiPyzKjSrY
	EQLq+5nllRBZTd9sJfbJyKeQvhVXUZp9JHOtREhb2nASj1Wfwz67dyc5utn9+ry+
	+xIpw==
X-ME-Sender: <xms:gvKCak7zjElg0J8z3Y5V2hO2mu6UX6uAocTu-8ox64z5N0GsNwkrHQ>
    <xme:gvKCaiDbJTxET1oh9G_ukNcYM5oEQiL_qMRbtAGHkgydytycze2mmvJtSC9DZYqfu
    EjVYbzY--yoafTD_CHSHAEA9IpqpdO7xnLT3THHscMqc-IjTHhxsUH2>
X-ME-Received: <xmr:gvKCavRYx4irBuQOwz_aniqt8jDSPJ7IOrowt7p4EPxL7qU2TjDJ4lTy7k9qFqHgEA8_cbU5cQ>
X-ME-Proxy-Cause: dmFkZTGn55Su7Hrpv3xQW8kiCeQLMMXe+EtNw8Ny5aOMmrmA/S52UxT8toGIRHunZ5TeC3
    8CUVPo0T3TI3v5+JSydbOrVRGOweYdzSDjgeJ2HQU+QnteRCG4RIWbk2YstaxI8PwPUpsI
    B5rlrRzzeplZJm8yeVSbv/dntMzH8U1W06Jzf6jYXremoRNGcl11nn7wHzWdkBjGJoGDz5
    K29ctzqiIeZqkCbp46aL398FJPW7bEBGCmrhb0F1vK6pVmU9zPAKi/cGOkmtwexgjxIL+q
    96O5UmLol4m5QizJ2A09pNn8WXCDa3t2pEd6bRFohA1nn7RuA+wCG078NSdyrM65XTwvLa
    CMzOwyBkB/LuercLJvzIOhg0nj8hMFfG8HhZQALsdnVvfuWWlAKB7MZndGV5R6yeneRbcJ
    P/MuWbXQIJ9riHF2KDoXUI/HMDzVTodWFaMPcvzNZ5mT9RbHtuAUBLf1tcH/r/oAr/p0tb
    iMZN4uQo3YX97bt6Ylvh96WUdKqsq6VAIi0pEDcyO6iM6HQ6vrJa64jCCh7Tlcvt/NUxwU
    FuzdXJLRZxyCaR/LfbaWiago4eLdR6vIELClPeDk0J/vUE2EM1NhmM37RVyEpN6SR7LaQb
    WGH4QX71JepC9ph2tayiciNtYvkxg701i92DIBaqd6/wSvRBZz8/YdxxF1KQ
X-ME-Proxy: <xmx:gvKCaiezGINOqlg4R_Tt8Wo_e2lTsn7CAIj73SdBGLerruFvkLZSWg>
    <xmx:gvKCaoQCbPk8sXg4Umj7vtiL99QFRjuA1EdUmWaJfVySoGhpBG6NRA>
    <xmx:gvKCau2fXmCzl9ODh5xwDj5N3u7I5PMwBYhdDlx4Lgw6_6szftd6bQ>
    <xmx:gvKCau5i4QTWqwIzbD--YRayCSMhs58e-2Gwnubt6K5kR1QygZZYLg>
    <xmx:gvKCaibA2ncga6FTIM1gyZk3FvibJreMVfiu995kjziHu_XA4uBiB3Fj>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:37:31 -0400 (EDT)
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
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v8 08/12] pmdomain/rockchip: cycle optional power-domain resets on power-on
Date: Mon, 17 Aug 2026 23:35:59 +1200
Message-ID: <20260817113603.1436067-9-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817113603.1436067-1-gahing@gahingwoo.com>
References: <20260817113603.1436067-1-gahing@gahingwoo.com>
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

