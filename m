Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929790;
	b=aX9wztkgJ4QcLXYaUYj0OGN4te0yovjBBIJzzdYAUreY9L/W0NsAi7PJyuZu6yIdEdAM
	 rKBg3fFX2sanIsjMC4P1q8bAjnJCzvf9zw2Hiv70BDzJhrbZm7jgzVAg0mWGFtik9r0nH
	 FlHeGXGaDC4l22UYFivCBa8Ts5CpQwawPU/W4Mo3KLMx/NZlijGuK+72mgGUaeLPHEE05
	 MWjtK+//5WxHEr3clv00RaeFUYJyrBREc1pNpZqH+o2/oQPi4q2IqaojiuHDXMBB63MkO
	 RnFUbQc1CABUw4tANWnc1BiiXsqcbHyZJj76Q2bxIPFwVXQRdYR+7BljPDunwbKBi6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929790;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=WFJgYNeA/aloy8pF2X21+EgWkKhCq+a9N4WCABzbaOQ=;
	b=RUVFp7cW+v/4/MO0J+mutFxgxl/cwrRRmyd4eLRvkUqaCXwwxhv48j82g8SW9RH6JiTB
	 V8EM+tOo1rpicig1BAn9+wE9LQjzbb93dqm2kt4PmxErPJKxN9c4gsqwhM50TkrTaG2ig
	 mKZo0UXT5RC5fgVSo/aPpEAzyQzw44UMrZIosHnKfcsdFQfSVTHdMTG0zDxmP6DYKV9UX
	 coJyto+jnYR4U+oOOWHtEUYpqpAwBbXDta3hUkux1FkvrESbvALHJFqoL7WB5vA+b52xt
	 292Cf6t8wtiEUlJbQ2y+XdV90i5tUot3u2pwPfjdOgh2CwaZZ3DB9Sspbc0PKCeAx0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="e6mdzX1/";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43559606A8B1;
	Tue, 17 Nov 2026 15:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43559606A8B1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=e6mdzX1/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794929785;
	bh=ATt9sQf4jrUWMWeCujd6AgupNJwciBcASnX+xPBVNtI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=e6mdzX1/v/Q1mjqNNfeoqEt4qHHiOMfF6dvDMtaLbG+enhDu26tmV0RDfYdM4qimF
	 eEtuFjrlIPAnFFIFDv6oK3fGc3d/ft/FHWJQTFMw8QoJaTxJuYf9zRM1zbipp38MNe
	 mS5F+fGqsqVA1erpOEaO6CcXwlfK7KFcEzJGFNCq66sfdZ6Ah3Foi6ugX8kAsMmwky
	 DNQjq9zarllb5pz9te1xS4OzmF2zuY+8/K7TZ6cXNPtKPAtshJkNL1KCL/lLGBsfqg
	 p5sZXOnLJmuStYhYOQ7ZkdV5ChcsXb1fbjikE4hhxHVcqa56dNNx2xUiYYdx1sulZn
	 uDUVF6frTDQZg==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 42F9517E35C9;
	Tue, 17 Nov 2026 16:36:25 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A5CA148003D; Tue, 17 Nov 2026 16:36:24 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 17 Nov 2026 16:35:43 +0100
Subject: [PATCH v3 7/9] PM / devfreq: rockchip-dfi: move register offsets
 to variant struct
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
Message-Id: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-7-32ff1546b0e4@collabora.com>
References: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
In-Reply-To: <20261117-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v3-0-32ff1546b0e4@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3935;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=ATt9sQf4jrUWMWeCujd6AgupNJwciBcASnX+xPBVNtI=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr8dHjVE3B7Vav1LrESj/TZCFyTgaIov7Af8
 IlKk7ohwzSQMokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/HR4AAoJENju1/PI
 O/qaxjsP/3uatGCNW/fdpZG5jUrO0X5u/lGCsTXKeI2c494/1e+lKtuyOyFeVJVQa7nkkB5LS4u
 kQOCu/S+Q7vjkiidg5js/UqQKXLZGy56iMVjiyP3y/YR4HjT7KVcF7+ZVwxmOkoid10+RzWmXSQ
 bdH/hT0PFXzF7GsjY4obcjEfgZ+P4V3X7d9pmYtWHtzNpJ2xq6vqhms4shDg0/GfXSDVLiEGOyQ
 CXh48e1k9uMohzMnjNZICeEyDRscI7S94lURugAkcRWalrAzmFkl8xg/S6SHNSE99Iy7iXasu7l
 dmPIZ5qERkhavZGDmN6EW+QEZrVs9sBWl8k/4bPnLrsSSwcEXk7ibzIT8LWr+wfWV4RZ1VvipXS
 E3f80bm8CTEb8ecXVU2nq4x/fB4AJf0hOpAo6katZl5BJ6PAqDYZJJfNHMlcC12aGNgIpUFm0Kj
 /3yyPPw69avR3haIZoyNV5Yq2JgD60k9IyQCZ/uMvL4WqzXCkXAVp8UHjxYOMOgIAFKus4WtCqj
 Gs2Br6i2zXibCElJR3OfG1cqh7nR3ZcRfQTdwtRfiS4Q2HD0UgbVLAytqsLR5aOSOoPG+q4D8g1
 Ft+RCCQa0GjLqbpDiMmCjV78fEDJ1uOK2fuwRiKOzKdkGtsuO3va6ZMsTiVLucWuqQvv9kcz2K2
 9TulwLvfWHAnA9GOBIp83ng==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

DDRMON in version 0x40 (found in RK3576) has two control registers,
which moves the register addresses. Move the register offsets from the
defines to the varaint struct to ease supporting the newer version.

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index a97c63cdab57..33a379618eb5 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -42,12 +42,6 @@
 #define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
 #define DDRMON_CTRL_LP5_BANK_MODE_MASK	GENMASK(8, 7)
 
-#define DDRMON_CH0_WR_NUM		0x20
-#define DDRMON_CH0_RD_NUM		0x24
-#define DDRMON_CH0_COUNT_NUM		0x28
-#define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
-#define DDRMON_CH1_COUNT_NUM		0x3c
-#define DDRMON_CH1_DFI_ACCESS_NUM	0x40
 
 #define PERF_EVENT_CYCLES		0x0
 #define PERF_EVENT_READ_BYTES		0x1
@@ -128,6 +122,10 @@ struct rockchip_dfi {
  * @clocks_optional: whether not finding the clocks is non-fatal. Set if the
  *                   DT binding for this variant didn't require clocks in the
  *                   past, so that the driver remains compatible with old DTs.
+ * @reg_write_access: register offset for writes access
+ * @reg_read_access: register offset for read access
+ * @reg_access: register offset for read/write access
+ * @reg_clock_cycles: register offset for clock cycles
  */
 struct rockchip_dfi_variant {
 	int (*init)(struct rockchip_dfi *dfi);
@@ -137,6 +135,10 @@ struct rockchip_dfi_variant {
 	const char * const *clk_names;
 	unsigned int num_clks;
 	bool clocks_optional;
+	u8 reg_write_access;
+	u8 reg_read_access;
+	u8 reg_access;
+	u8 reg_clock_cycles;
 };
 
 static int rockchip_dfi_ddrtype_to_ctrl(struct rockchip_dfi *dfi, u32 *ctrl)
@@ -277,13 +279,13 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
 		if (!(dfi->channel_mask & BIT(i)))
 			continue;
 		res->c[i].read_access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_RD_NUM + i * dfi->variant->stride);
+				dfi->variant->reg_read_access + i * dfi->variant->stride);
 		res->c[i].write_access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_WR_NUM + i * dfi->variant->stride);
+				dfi->variant->reg_write_access + i * dfi->variant->stride);
 		res->c[i].access = readl_relaxed(dfi_regs +
-				DDRMON_CH0_DFI_ACCESS_NUM + i * dfi->variant->stride);
+				dfi->variant->reg_access + i * dfi->variant->stride);
 		res->c[i].clock_cycles = readl_relaxed(dfi_regs +
-				DDRMON_CH0_COUNT_NUM + i * dfi->variant->stride);
+				dfi->variant->reg_clock_cycles + i * dfi->variant->stride);
 	}
 }
 
@@ -831,6 +833,10 @@ static const struct rockchip_dfi_variant rk3399_variant = {
 	.max_channels = 2,
 	.clk_names = rk3399_clk_names,
 	.num_clks = ARRAY_SIZE(rk3399_clk_names),
+	.reg_write_access = 0x20,
+	.reg_read_access = 0x24,
+	.reg_clock_cycles = 0x28,
+	.reg_access = 0x2c,
 };
 
 static const struct rockchip_dfi_variant rk3568_variant = {
@@ -838,6 +844,10 @@ static const struct rockchip_dfi_variant rk3568_variant = {
 	.stride = 0x0,
 	.ctrl_single = true,
 	.max_channels = 1,
+	.reg_write_access = 0x20,
+	.reg_read_access = 0x24,
+	.reg_clock_cycles = 0x28,
+	.reg_access = 0x2c,
 };
 
 static const struct rockchip_dfi_variant rk3588_variant = {
@@ -847,6 +857,10 @@ static const struct rockchip_dfi_variant rk3588_variant = {
 	.clk_names = rk3588_clk_names,
 	.num_clks = ARRAY_SIZE(rk3588_clk_names),
 	.clocks_optional = true,
+	.reg_write_access = 0x20,
+	.reg_read_access = 0x24,
+	.reg_clock_cycles = 0x28,
+	.reg_access = 0x2c,
 };
 
 static const struct of_device_id rockchip_dfi_id_match[] = {

-- 
2.53.0

