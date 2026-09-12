Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBEC379ED2;
	Sat, 12 Sep 2026 06:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789195984; cv=none; b=i2mEBQpc1JWiKFzAH8EXrxJEslwJ5PFB/vNx9wvKFZq0GjH+rNrQBx/ACG69eXHcB8izRwXRsoDZZVf4UMzzgWYWjkkqrbd1O5W2Yoa9shenFmXwIUfblt9jP27twKlmfftK54nNo0L0glWPw+8VI2997TI8LcVrVwZEASGsEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789195984; c=relaxed/simple;
	bh=XkKS64ilmfTZbzrK5Po4eJtI/KFUDUj/aHDPQvHk5fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI5LmplX3HkNkGFwjPJaIrWGUnX/XHNH24uvrna87fiY96MC9VnLaaSbyyM/F4M0jzhgAFVw0H9CHJrZ3juMs81qL2+UALE93tRrnCWl0PqiKluBq3VuAzeOHvw3XAXBDJMhwzYXtMO+Cr7pkDTGIOMvQAVwnR/Xh0cNV6NIKlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=RqExlXUM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZGf/yffU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="RqExlXUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZGf/yffU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 0165F1D00072;
	Sat, 12 Sep 2026 02:53:01 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 12 Sep 2026 02:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789195981; x=
	1789282381; bh=e9LoMMVEroZGsuUE/y7jMO1McFxznbr3sDdiQfN22eo=; b=R
	qExlXUM0deJ7/whYA3v1mduBHnBnEKBhXEpoMY+nESYmYxRPLg3A622mwXnH+pbM
	eJMwN7zBUwSjlwW4olMB5hgIMlDIB1XdNiLvkZpmrhDmji+BTgGMQHCYmN6Elgjg
	O6/npKmBZP+VwuzHIBQPjSs6lLfwlordqOYr1Thu3+6mOkJ1lL0Sae4+JVa1kbbe
	tu7VBUfKmipw2aW8d8CsZ4+ku/ITAQLzlsKUAeWDLaftp5Q0tSIuvMHLqSTwVDhq
	be88nAyGoN06t0pUUiOOHrCEef1Ckd7umNa+rZNdDsSvlxUPZrE8PAQ9c4elow1I
	goE997VP64ZiOZM2UcGJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789195981; x=1789282381; bh=e
	9LoMMVEroZGsuUE/y7jMO1McFxznbr3sDdiQfN22eo=; b=ZGf/yffUt5d225bK6
	VNpRPHUFrBJqi9443RAVjPhBXrAAVZ13bSaAhMOz8NzLmy4R3iaQZ5R17faZDhL8
	AG9WMxa9D2GseGknfkiEagFH6miO+wyIe7GYzDxZPM8AKA3FugXgj98R3eMkM9Lr
	Uw9MXS2QRlk4CS+XBYB/PSSzGIEZ2PNdiZ6vev1DxBf1THRoF4BY+nIZATLWx+P9
	XiqVyczIVwpk4QHMD1RdZFQ5LsXK3TzqWM/9y0e2klWLkBO9x2ci/AQHHilB3nWD
	Xifn10Ng+o8TOMylEU4hBWCmOFnUz7QRRf2gDf9iyZNnCbRyFtADX5J78npe1xJj
	J34Zw==
X-ME-Sender: <xms:zfakakzu9fwPE5u1gNhpnfIPFvH0CZhIJXraeuQNp0ykCuCsUI6TVw>
    <xme:zfakaoae5qwJ9t8J-5EbAOflbCzQaWq-jIE0Bs2LAWb0Vr4JrnUV7gj-aS21wtzF_
    HdW6OryARCIjFLRo2CQ0JpQmnS0juR4pGd0K5umBwGqN2K1DDAJ-GA>
X-ME-Received: <xmr:zfakakJB_CJ7HovfBD0k6cgaqsmfbmvM0e7MImCAzC1B5yZXX8vcYS5CIiLX3v7h48A3Q1x_Wg>
X-ME-Proxy-Cause: dmFkZTFWRe4FupnosV8kB1g6tNV76p6jywVrK0lcdqghhiQv/JHzElhv6b9tuqq+aCOLTS
    EmoFZAtvHzX5d9oQIr0J9Ha3BwGzdA3zpPU3H3YNHnAt/uad4hE/RhjgAgWIAwYn/Jhsox
    kSjja0/P5LO3n/qCpTlMjacpEbiJsr25Qz08lRqXdqFPuHljo+J9/XW71P/mKHyE4e8EuB
    SPTMsPmhqyOmbMtQUpJiSbig7TMVVj0Zv/9fE9y6HOUn0XwsjMX9WNsc0M6IEwHRKcBkea
    uw6ElX4ffC60dLVplCV5rfWQZ5xjClO3fTMZyxWN6JpcDVAycskmADuyvJ1IzcEA0uX7BT
    n08quT6Ro0ZptaZQMwqf0fhtjT0O4xARVxZtP6z8fTCeRL3WWRh7g/lpa5tNJ4USa5/K0b
    jKbQXhkmfffFlFi8vbdY+fkqZulW7qvXuPiFqUjFwb7605LDsyWRwXaQFJvZYDcru4yWyJ
    t9Ks4W6o3606U8p5jE/SYBDjDe3IfybtKXUPVmQ5d/6QhhE88RRtN+LczQVQsb6qJyqC/j
    GB/QYFzNdCQCJiePnWx55REtfh/vjhoGk9K3Cs4qY/bZHFVMtMrPsQ4EhR5ZyxjzlSAy8F
    ja8aP7NGvp0bqjsKrOAfboMFkP4PpPtOPHyTCjPsG1P4R1wD+hSHzlpJEYbQ
X-ME-Proxy: <xmx:zfakamxU1oCD2qMVbeF5Ns1zUqYKibiwyNC7zl_llSru6RQ2ljbigw>
    <xmx:zfakakOoxECe9aRuA05NTljh2z43gGhBUt0QwKrNVwUkv6_gzu5lUg>
    <xmx:zfakaivKMSp-cHZ-DWcCYM0QxR-xTrFZ6tih-3ggktz2YVO_H7zz4Q>
    <xmx:zfakap3c6z_PhEXjXSXilAhZkawiZp2N7WQhPxYOVF_r_WnPOuCbSA>
    <xmx:zfakaoOhSE2Zb24dkR3n_BvF7q2YgeXZn1jtVYd29wymAOIiw6E8QU0f>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 02:52:53 -0400 (EDT)
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
	abel.vesa@oss.qualcomm.com,
	sebastian.reichel@collabora.com,
	sidong.yang@furiosa.ai,
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
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v12 10/14] pmdomain: rockchip: cycle optional power-domain resets on power-on
Date: Sat, 12 Sep 2026 18:50:49 +1200
Message-ID: <20260912065053.1519165-11-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260912065053.1519165-1-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Rockchip domains come out of power-on with their bus interface in an
undefined state. On the RK3576 NPU this shows up as a hang on the first
register access after the domain is switched on, and pulsing the domain's
resets at this point clears it.

Take the domain node's resets if it has any, and pulse them between
releasing idle and restoring QoS. The resets are optional, so domains that
do not list any are unaffected.

The cycle goes before the settle delay 9/14 adds, not after it. A domain
that asks for both is asking to settle before the QoS registers answer, and
a reset deasserted after the delay would leave nothing between the deassert
and rockchip_pmu_restore_qos(). On RK3576 PD_NPU0 and PD_NPU1 ask for both,
and the reset they cycle is SRST_A_RKNN0/1_BIU, the bus interface those QoS
writes go through.

It only runs when the domain actually changes state: rockchip_pd_power()
returns early when the hardware already reads the state being asked for. A
bootloader that leaves the NPU powered would therefore skip both this and
the delay, which is why 9/14 gives RK3576_PD_NPU need_regulator and forces
the domain off at probe.

No in-tree DTS puts resets in a power-domain node today, so every other
Rockchip SoC takes the optional get's NULL and is unchanged.

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 27 ++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 39988efd8..6cc8d6efd 100644
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
@@ -688,6 +690,21 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (ret < 0)
 			goto out;
 
+		/*
+		 * Optional: some domains need their resets cycled once power
+		 * is on. This goes BEFORE the settle delay, not after: a
+		 * domain that asks for both is asking to settle before the
+		 * QoS registers answer, and a reset deasserted after the
+		 * delay would leave nothing between it and the QoS writes.
+		 * On RK3576 the reset being cycled is the NPU core's bus
+		 * interface, which is what those writes go through.
+		 */
+		if (pd->resets) {
+			reset_control_assert(pd->resets);
+			usleep_range(10, 20);
+			reset_control_deassert(pd->resets);
+		}
+
 		/* Some domains need to settle before the QoS registers answer. */
 		if (pd->info->delay_us)
 			udelay(pd->info->delay_us);
@@ -861,6 +878,14 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
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
 
@@ -931,6 +956,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 	return error;
 }
 
@@ -949,6 +975,7 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 
 	/* protect the zeroing of pm->num_clks */
 	mutex_lock(&pd->pmu->mutex);
-- 
2.43.0

