Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBD7244665;
	Sat, 18 Jul 2026 03:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344355; cv=none; b=UnOFuap41Of8tJMavDA2HnI75KJkgJgq9hCO+z1hJp39wmkiap7u3yYbfKfDi2j++Ku44XrP+KgGyVHGaHeOppU/iIVmo1wOMptNQDtXk4OnNVRUio/SBZClhGDeHELy/yZZoWl9uCFM8ewpu3OTQ76jJU60Ww31nvrAyoL0ca4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344355; c=relaxed/simple;
	bh=QgRKt4IS7CNU0vvklMdhC/IP3jqWkDhJiThkz4Jx2+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzUt8ABI2bxrJwhllFecvy/wh2tmr7U18lXyjJh7Urxdk8ytpeXpBt7QBzkU09gtd3S7tqpeMaGXmsx28M+3aVTpmudqX+5GuV2MlTmGz5z3zDUxINSZYvxFF2qlq1vHa/+cw6o5Rcks9P5ya2DcTJysiCMFt+PXcAXrRH0/BcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=f13js8cM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VETlfcUv; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="f13js8cM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VETlfcUv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 7E5011380327;
	Fri, 17 Jul 2026 23:12:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 17 Jul 2026 23:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784344353; x=
	1784347953; bh=ReDEZNNVB6LR8TBo9n+GfIJ6P/foCnyQWElDcThh+I8=; b=f
	13js8cMotlSvz6w3J13kdWOflPNn7kaiGIZsJaYhhH8b2FtCbEmNvvxygoDdrvET
	e7N6qZ23ubjHJCv2bqSyIYBhnA5v+mmk9yOLofAvxVQcZoDJ/FbFz6qvL5JVXL9e
	E27MXQ4fe1UmFbZ/soOlokURSLp7oRPDzdG5fShpOJCN6w9yediqtZXr5YO/oeZM
	Je9dTJ3pXexj5iTt6lS9hi94ASmE6tjluDu/3CTx0eszBR/EolYQSj5AWMRf5fW6
	+aGlN4BTORQ8y+TaUXUWHns/7fluKuGCmYp5Op5KEkNrLSDIgxJPVTZ8RPb712p9
	72d+JQIOvP5H1NY5NB4GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784344353; x=1784347953; bh=R
	eDEZNNVB6LR8TBo9n+GfIJ6P/foCnyQWElDcThh+I8=; b=VETlfcUvMO2S0Z9Lj
	vfIZcjBnGpONs76AZEqg0fpDbGt8K8kWWr0T8Zd6C8cWe/0iJ8SJJveVj8HvvXpQ
	6OOySbAQgSFvYnTlpzrnvx1mgIeIdRZ2SFIh0jApJfZCHJ/qA0Zvq5cLCX3hmz3f
	j/fScdiANyseDva2SxJ/wIWHovDlkPsPcWB47WvsJqotdyt4qi7WVDDTe9diGMt7
	neS9s3xk2bjf2g7tv45u5cn4SWC+qWzkzYdRYupd/2Rak7aFrb1dESiAB7rccA8l
	n8L0RHg+Z0EGS+IiDeW3O7/hFM4xRkHK1nhbixv7YVNDSP2Q/4e/5h83uP+TIhoi
	4XKlA==
X-ME-Sender: <xms:Ie9aatx-c8-TQvSTi5nxs6tLczDgbWL8CPzKm5FzaY7eAYoo_q_oGQ>
    <xme:Ie9aatpfBZ1KQamgquxoBEpOZZC8bT7rsrKkGyMW1y5hvsddCfsdu3DcrI8zL0wUb
    lPMDOXlNTNkmnNmbpI7CUytiXTArAL-TnZdqeWMNk0plNnA6NfZ4Ww4>
X-ME-Received: <xmr:Ie9aaoe5GZct_2JFDzcZnNEXJSkjeCIkOsJrQsuckw5DY83jFygAaIJ7-p-R82zB2Q8Mk7C0AME5yOO-6BY>
X-ME-Proxy-Cause: dmFkZTGiua8u0bNA9XH/1gRMOwAvIEaw+Xtz0KCuQKXabiOHwfxpZ5MZYByRWbR7Kp9nF6
    qSe4oUPMRhjVDuO3uTQXqNB9rW/YS03mixI6iwJykTNKzlTWPLWtINW2pRnzFmGD/jHaBH
    GW+Ck3GrggAvw64iMT6xDcUsunGB8iGvjpZn8uEGxdGVdwsgwFdZGN7ymS1icJndc4lt6e
    zFZUrbtWEQG8UIpC7Nj6JLcyz0vHsWVRB3V4EGPAQFYmiIaqKn/E4qxv/cGIWyj+pw9l6Q
    Qrz/KpDo+6BmEyRu9vKadFcnov/EnFsq7LCdBsST1Re0wCrcf9imh4FlvqjBTb6afFWNbI
    CWDWTqgOw5anCxAJQ2RRzTsQ8FyQFlAOMjKAk1O4IqUMRqnLXv2OD6G3Fv6e85qDfB0ZbF
    sIdOWBajTsziR7rZvXmNaBtj4QEY42I8c9LuNjFX6ElGDT938ucWOXXxQmwYhHRbt4LK14
    VxDq2e/FsrRxp1EZJsSbePv8BVlyJl33MEzRk7kCtypm8qti2NVi1VYHnGtBUKHkBg7kyM
    9NiNRh5aQhUBpJ7rUKBpzR605Sj3g/nvWHh2gyFoxQFVsT+T3bQZbWRZ3EmHsbdJCE292S
    hWNu/R6Pr1K5Qq+e5y9bmqhMfMdnWlcWIa0///qO2yJrTEqXdZxjkqWSv+FQ
X-ME-Proxy: <xmx:Ie9aarj56CpV29TFAI_Qy85Z0IX_qjCVtXNevIzyb7BGnJjmX7AMsQ>
    <xmx:Ie9aauKnXPbREXX_-2M_USNARksu0M2TFPoz7s4fjm5MVFWp1PpufQ>
    <xmx:Ie9aagovXI_vn7jQuiHJmEP1HKUnktL5ZkYrXQ7N7fgBlQhTaKuFxg>
    <xmx:Ie9aarqg4Cup2kkoMNCCxycW4P0xKwqfZk_eH07KbLea-rr11LtElw>
    <xmx:Ie9aatHVSKIPwhrLAua9ytNS53utZn_B1mSLRuA0BEy4X9nmc3eAfsdJ>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 23:12:25 -0400 (EDT)
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
	ogabbay@kernel.org
Cc: chaoyi.chen@rock-chips.com,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jiaxing Hu <gahing@gahingwoo.com>
Subject: [RFC PATCH v2 3/8] pmdomain/rockchip: cycle optional power-domain resets on power-on
Date: Sat, 18 Jul 2026 15:11:41 +1200
Message-ID: <20260718031146.3368811-4-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718031146.3368811-1-gahing@gahingwoo.com>
References: <20260718031146.3368811-1-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some power domains contain hardware bus interfaces that require an
explicit assert/deassert edge on their reset line after the domain is
powered on.  The CRU preserves reset state across power cycles (stays
deasserted), so the hardware never sees the edge it needs unless the
driver pulses it explicitly.

Add an optional resets property to rockchip_pm_domain.  When present,
the resets are asserted and deasserted (with a 10 us hold) inside
rockchip_pd_power() after the idle bits are cleared and the delay_us
settling time has elapsed, but before any device in the domain resumes.
The resets are released in rockchip_pm_remove_one_domain().

Signed-off-by: Jiaxing Hu <gahing@gahingwoo.com>
---
 drivers/pmdomain/rockchip/pm-domains.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index 1787f62ba..8ce0cc3de 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -18,6 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/syscon.h>
@@ -102,6 +103,7 @@ struct rockchip_pm_domain {
 	struct clk_bulk_data *clks;
 	struct device_node *node;
 	struct regulator *supply;
+	struct reset_control *resets;
 };
 
 struct rockchip_pmu {
@@ -671,6 +673,12 @@ static int rockchip_pd_power(struct rockchip_pm_domain *pd, bool power_on)
 		if (pd->info->delay_us)
 			udelay(pd->info->delay_us);
 
+		if (pd->resets) {
+			reset_control_assert(pd->resets);
+			udelay(10);
+			reset_control_deassert(pd->resets);
+		}
+
 		rockchip_pmu_restore_qos(pd);
 	}
 
@@ -840,6 +848,14 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
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
 
@@ -910,6 +926,7 @@ static int rockchip_pm_add_one_domain(struct rockchip_pmu *pmu,
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 err_put_clocks:
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 	return error;
 }
 
@@ -928,6 +945,7 @@ static void rockchip_pm_remove_one_domain(struct rockchip_pm_domain *pd)
 
 	clk_bulk_unprepare(pd->num_clks, pd->clks);
 	clk_bulk_put(pd->num_clks, pd->clks);
+	reset_control_put(pd->resets);
 
 	/* protect the zeroing of pm->num_clks */
 	mutex_lock(&pd->pmu->mutex);
-- 
2.43.0

