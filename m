Received: from flow-b8-smtp.messagingengine.com (flow-b8-smtp.messagingengine.com [202.12.124.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A218411689;
	Wed, 12 Aug 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786527747; cv=none; b=sjC7Vf/wP6o5k5fq72pKf9wRySWNMb2ibNhlsGX3kppJhOozreooFgeiz24joVVX3i4VYzG3OtL4MoJnAAUjaMZ51ICWjGsWi6KGmtWQz4NiEQ1x1TNzbFcX2MWuqdHQCalafPeRsr5A7ikzan5om72pk47CJwuz0esbXZ/QJys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786527747; c=relaxed/simple;
	bh=MOAl+6wW7KPWYXjQOBWfhd8nNouh77QqKrD9SZCDtqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W5FNDi+UBhbfLhR4FX6dzxheYYXCZM22FQFdkDRgQcI95g4Jq1lHS0T+fbCXK0Sq69IzHWQf4jGbKngOTI1RkgzCBzHEWE8S/vUGCFv2WYNrspJ0bpWSpul2Y7ZBE6F4XQcEFfD07eOuEAbe9MuZqNpA5mkbe8RL41PuYrydzvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=jKYU88/1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hd3njpte; arc=none smtp.client-ip=202.12.124.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="jKYU88/1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hd3njpte"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.stl.internal (Postfix) with ESMTP id 6FC1D13000EE;
	Wed, 12 Aug 2026 05:42:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Wed, 12 Aug 2026 05:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1786527744; x=
	1786531344; bh=t5ehuwu+R3IZPenGVdecVG/3J4bVeduLS34R82/gLXE=; b=j
	KYU88/1HQB38tEHGPcOZxSZI/xIdBKKz7rItHffOfva9EdpFTK4RSWN+1vwCvp5T
	NAkfq4z9H3NUgK6c+Qyv2bc4wgOJfynN7qjvq+ymekbzbqB3Sd6Z/p71pTsLDgUF
	eH7fseMYlgx3QcUcemyB2y3chb+YBJxbnDrtwN+PqhG7X7sNTXit1Qla4/fpHrZN
	VLrnHb/40wUzvfXWd2qAchF8vcAz65cCm/+KfuC2moieBcqRdr4qmBjcKF86oko7
	KjROGHFlxUn0zl7S0EUOoi120xb3XYLDwTxI8e+Mp0AGmlw25DQ85z/SSa6O/e9V
	BrkhuNOKslGZZrlz7eJmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1786527744; x=1786531344; bh=t
	5ehuwu+R3IZPenGVdecVG/3J4bVeduLS34R82/gLXE=; b=Hd3njptejXd1e1zIU
	mWb5J3QCaxUQwCyti8aXcW7qCJjZuj1tTfV6z7WApmoSap84s6z2zVcDcome1P0o
	wcKvmJA5yZP/JDwN8U67G3T/psIHsFn4eJJffW3Vp7lDOqvXY+6BGqu2YRuwqRi2
	+1ert89lDoIEB3y9dmfajxbhW0C5d0QpyTN+Zf2C42isYV4ZYCY5r1Xm9jUkq67u
	PskCw29fSn1DICEviDGC4tJSZ1Ox6B9C3ewpYrV/ytOUZs2UyDFiZAYRVJP14yvF
	HEVc/YUB29L8GEdkP31UUQ0YK3WgVP7sb629rFYtZQu3Y+OKQzJoHjCfx9Xvz6Vh
	Xln8w==
X-ME-Sender: <xms:AEB8agI945opoLnG6xWdQra2F8rSM5izgQits30xzeWqbAYc3C1faw>
    <xme:AEB8asT0Cm53-UPtGcG0l3ZUj8oSW6zl_f5X61_PrrMFSsMqrkcaYjs_JS0DMzoyX
    jgPEix_J4lGAvXFtUqVtPfIcrk5SOJLp_Q2tMtDLqLvaMqqAuUlCw>
X-ME-Received: <xmr:AEB8asibjHfJPyy5jUofzER5Z22DMrTQ6tQuPD4ZzfDkS0lgGdu_fuk0pcob4skUZry25_4IKA>
X-ME-Proxy-Cause: dmFkZTGwgEiQ82b/vslvxu748yQUK6wPursKF8fMIVbz67wiFGHgA47PKoO/uGXMsZMxLx
    gFPIgLOcY7P5CngkkiK3BYsM+NSvuArVGUEmY/S//Od5HX6j19/B4vsjpf5HveubJ3pf//
    pWCcY4ceqdx0GtHj0WCQ0o6J65xdr5brIk0MpFgwd1OnJb0OJtZbfDBehL90KckpJx/ici
    /427xioY7E6zKhb2nnVrNb5/eVe38u0ELJVPMEpl79CB4mXXIS+TOXwQ2vG5Pe68Rd3XXD
    xmR8fAtcy04eoj5dkZNb571/YdUoGmvjFo0tW/6wl1YthjyIcmyfW3v1C+VPOybfcM4wDu
    /FpDxAXbbfECzEXrxC0iSVGXGLdN2ejFzFEYHu13ZdLzrEMHd3VYdvZ/Y1IaOHzN8Xo8h+
    XqirhsQgGOv/203VZQXUdeJ0RJ3kHrEjaNOt7etJMSG5yf2X81nPo7aPw3PqfFG4W5AKK5
    BJD88GMjZF5mOGYU89FPCwExFIvdlLX1Y/M/CddXG8UoTWA8c6cLnP4wados4DZAu6Krp7
    U1fyQZQzlVsslfIUV007mMHP9XN1KQ8ZYnEdOvQe/IRwsgRa3Tys2yQdhpwBCjbZKoW3df
    0ysHur7hldRJnBMlMbToA+lGqA5aCrTM+3fYH6Lowpe3Q3gsdU81NIDUNWDQ
X-ME-Proxy: <xmx:AEB8amufkNpeAycmbYVtZq40J2Z5a0uY2P0jlSlfZLcvrxPZuFIJdw>
    <xmx:AEB8anizcLyQrtEtM6hXPR1xsz4aUBhJWabf7AbnYCYvte2sm72eVA>
    <xmx:AEB8atEvSVmozdJAboGa_EN2121mdSPEw3BFBmfZ2RSEQUBRAtz-vA>
    <xmx:AEB8agJ_NxwLx09rYqaFgZ2ILkDySuVw3QIY7geTeMkZHkNvAl10kA>
    <xmx:AEB8auS2LZhmcD4fRQ3k5PDx_AZY-rvSUG3VsBO9F028vKWRgK9xDS8D>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 05:42:16 -0400 (EDT)
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
	alchark@flipper.net,
	chaoyi.chen@rock-chips.com,
	diederik@cknow-tech.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [PATCH v7 06/10] pmdomain/rockchip: cycle optional power-domain resets on power-on
Date: Wed, 12 Aug 2026 21:41:01 +1200
Message-ID: <20260812094106.1391698-7-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812094106.1391698-1-gahing@gahingwoo.com>
References: <20260812094106.1391698-1-gahing@gahingwoo.com>
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
index e1857f878..4eebb5d99 100644
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
+		error = dev_err_probe(pmu->dev, PTR_ERR(pd->resets),
+				      "%pOFn: failed to get resets\n", node);
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

