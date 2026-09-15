Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC3414A11;
	Tue, 15 Sep 2026 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789469143; cv=none; b=RTI59obT0oHm+8s9G+/vizYkT6ddgQfTPx8uGajtS5MRB66duUmH/075SFdBnRVrKpBbmiOYqRp9td8v2MVFN9O1+BnGH3Wg+Tt/9+ek5rdqhXd+pSNypg0y71ZPiz9MnVLwSDE7BNQEHb2tliwpZoYbY8xw+R6rktsJkjtTCME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789469143; c=relaxed/simple;
	bh=XkKS64ilmfTZbzrK5Po4eJtI/KFUDUj/aHDPQvHk5fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IKdCsrV7aovmUPddAN9mX+fmTF8JBYHLIvsKLRStT1VJXqYa0RC0G4qRz7SuP3v9QRm6/H0eIzDSeTM/mQrdbe6HQbENR0RsRjPRGk78GfBSBX5OXF9wTN2j0o5LCdgUjvV9Uca1lAkWqOzji+paepPW7euoCecGOS75N873oaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com; spf=pass smtp.mailfrom=gahingwoo.com; dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b=ocrzfgVq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2RaB+eE; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gahingwoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gahingwoo.com header.i=@gahingwoo.com header.b="ocrzfgVq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2RaB+eE"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id DD2ED130050E;
	Tue, 15 Sep 2026 06:45:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 15 Sep 2026 06:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gahingwoo.com;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1789469139; x=
	1789476339; bh=e9LoMMVEroZGsuUE/y7jMO1McFxznbr3sDdiQfN22eo=; b=o
	crzfgVqIX9nzqSsKB4VVaOb2yCi3rp6vwWP/QMVgFgQhjQrfSP0wq30iq2DZ2Sqk
	dFb4l5Uqy+EBg8ADSYtZCe8Uzg9/xFdRfwduF7uZNeQXatEOsWdxiy0vyLqCTwEe
	CBwV2F6xxKunC1SGVmEZKP21vu/3AGo3OEACuF+KhDJWa56jTyJyw2weFZAGD/Bg
	tY3SvaMRQjg0QNCvFHuRDQqPD0vkXcX74ATD7MWMNzK6N6L2B0/aXeLXcAG918Mg
	b/RwThctvpvq2a3SfkuMqAC6ZBqX7Lj3GaEKRIR+qQqlj4opYpdYKsi+00snA9rL
	fWapoJHgI5ehw5MxdWkNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789469139; x=1789476339; bh=e
	9LoMMVEroZGsuUE/y7jMO1McFxznbr3sDdiQfN22eo=; b=E2RaB+eE+296Vo8hZ
	c+PPBM71bH5Ju2czyFZHQZ4aPOSgwE1RPbwfgysKdSKmSWgoD6P5UmOFJJr/maJQ
	5d0WFgnyE90oUb9u801pkyrQ6oH0UIA6hNYEtReWvLeVleD6SROAlVqmodtjltbq
	oFbDsXFPQ0CJgZZEPw4HuXIaPGz6Y5+gd4MLIKRM6VCBVDqUEhG3PCJiRf9ZlBwK
	Lg6UHzcLPpE1Zje/1yGpMTt2VrAlZjF3tcfqzCXmgzt8SjFzUTAQ/09Oh39iFxAH
	8U1nW3wimXTEhw8tSfGK13sj3A6ihWmal+GfoKUKJfauVgKa05qXWPzQpvqWTXMs
	Lpaww==
X-ME-Sender: <xms:0yGpai-z_sr22rTDCWNPnh2ODxgmI9sg6cNnxw8SLj4pK9EcgaNC1w>
    <xme:0yGpai1lyqIHS5PrVAbxtJ0wwfJpNLDLF8VZbox_D6bMdW7HMzxZnTw-X5VBmG6K0
    xvhcMSngLzwJxQYtwlBgEiMHbK1A8MzUehql0aeWYEwdF6SIdLvj_g>
X-ME-Received: <xmr:0yGpal3gZW1Jcp1nsDI1EXcswJD6wEVNOZC1r8BW9fcKv_vPWm5Od3AIsud1q9NAXNQ71YR8ew>
X-ME-Proxy-Cause: dmFkZTEJ7lsNMc5MXcmK0yAby6zAyahnp/o+BLQRTsAUuD6zUFYE1mfayW4ARlNvxFxbHL
    RViSXklp2Mvqoh7nMl9WcpZxcA5zX09aM17WbnSDD1mVdJoa+dDoRGgFZ+ZZgzctt5mn//
    Fi1Mt6BzxdDiSZyXddMkKr5ZuKnhcJKMT/Ww41HfwQaAux+0BU99FP+g6srkBweq+0Pyu4
    FpApM0KD75gdC3rQ4X6qbPGbs1ABgnV9cF7lajdZo5Ix2shyw0qolijI7Y4mlyGIz0nhlc
    sJGrQ0glbm4LA0H4VdiK+uhUvmoFkp3adh0VEvVmG9UeMUF3kO5gMGvK351yi5uht+G8ld
    OEGeDapE9d4TJjJj8/jfXCLJSvp4JuqEodsMQbji7yujrCR0Ylfh6QlYm17IhhMp4x9e89
    GDmb9ncnSDvBZJUsyFOavh2XFTtkEAXGEUUjK2K1aVvkmT8CPEvCGeCZqTgiwoJVZq9xVR
    FIlolqXE6zSJhIEnGLpgLfAUMaFlZCx+yuDWQkCRN8BX0nbSq7QgQ9JRQP31SSR8OP5OZ9
    vKbD5QQh5WaHA7ot0CBeaHimgO26UwSqTk0fw2cEe8Ez/3+YnRE5TPtaubS3frMRDbnRCi
    2+OcKxI1Z8YeZmXpLhiDu8ANWPqr6v+2sLJbhHz1JfDtzlc6k8P+emlq3pBg
X-ME-Proxy: <xmx:0yGpautUpSv2ov0xAHW71EW04wgYmYwUZrFk0PsjNonsHCqJpxTu_A>
    <xmx:0yGpalb4bYzjtl9LXhxtARJuCUVfGRhlAMhz7Py6lcoHJfrPkHWsyA>
    <xmx:0yGpakL0vcohDWnbNEs0gpNSI5HQVcaRyCYftFwkkXM2Vd2So_Vu1Q>
    <xmx:0yGpamhynkjSFGXZ9r2pSgLrOHx9SzWNT4A5IpbssVzzjfctIELlrw>
    <xmx:0yGpaiAgpcbORUqkl1CtBIscTu_Hy1T9Xmy_Xj1ebQBBhj615PWet9Ri>
Feedback-ID: i7a5e4b5f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Sep 2026 06:45:31 -0400 (EDT)
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
Subject: [PATCH v13 10/14] pmdomain: rockchip: cycle optional power-domain resets on power-on
Date: Tue, 15 Sep 2026 22:43:24 +1200
Message-ID: <20260915104328.45901-11-gahing@gahingwoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915104328.45901-1-gahing@gahingwoo.com>
References: <20260915104328.45901-1-gahing@gahingwoo.com>
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

