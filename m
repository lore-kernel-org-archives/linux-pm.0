Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95508598BFF;
	Thu, 17 Sep 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653866; cv=none; b=aV1iir3bCPqBRHc3RWeXbfHnBKBkZBn1MZcro1kn3SXGG/dDMB+bTD0AfRcfLFPD97zYodyS6G2rBnDsdeFS63XaiRZ12Z9wS9e7zRxrQywhvZ0TfpqpffpDj0sAyFkp/QWqrR0i4sib8XmgKgt+9H1bKuI1+NEzMaOv4Ummv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653866; c=relaxed/simple;
	bh=uqMNGGCnilMrPONpheO7c6uhWrV0luIU3LS1piJiwUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lCXpeWV0E9s3QQQMhkZcgGKu4sgvM1q4ugHbqBaYke0753St1B2YiUM2Yx55pMDJRuA97J9Ug1oZ4ItgnztCZwpJd81YQ7OlFKjwUAibt0fuGPvY+mOODUtjoInyDdkJXErvVk/nsXcqzZG2CmmfLCbdZ9ECUvB4TLrHqzc4Z3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Q8Hov7j0; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Q8Hov7j0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789653858;
	bh=uqMNGGCnilMrPONpheO7c6uhWrV0luIU3LS1piJiwUQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Q8Hov7j0bmwbEV8YnTjWrbIpt/gcZtZMdn+u3RRLXekQgankrFeJ211naVE4uDTKg
	 yPLJiUufsGv+6WDiY33665GUtkZNOPmZEOIPegvGHjTJQAvxzyLVj2254egDkOb4XY
	 JWiEb4Oh5nKRzLk7rDNyHex7Rqznz0ziAlOO8k0VHwphF/lmwlEJ9pSRgvrL24b1Em
	 t98T3XMw5rdYDrAxk42ZBqDp2F/HdgkABwStdPRhl+b7BuehDuI5gByOEz9UEKKJL8
	 S3FmjCBnfekTvNI+Ag4av1ynfh6Q+O27ujlE8CMf3T40LMszVNSaqGxOzkjQMAhSfK
	 PKWkBPX+TUq3w==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7B27A17E0CFC;
	Thu, 17 Sep 2026 16:04:18 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EADB5480035; Thu, 17 Sep 2026 16:04:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 16:04:11 +0200
Subject: [PATCH 5/7] PM / devfreq: rockchip-dfi: move register offsets to
 variant struct
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-rockchip-dfi-rk3576-support-v1-5-a5752a29f7bd@collabora.com>
References: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
In-Reply-To: <20260917-b4-rockchip-dfi-rk3576-support-v1-0-a5752a29f7bd@collabora.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Kyungmin Park <kyungmin.park@samsung.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3887;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=uqMNGGCnilMrPONpheO7c6uhWrV0luIU3LS1piJiwUQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr82H+Ze7nkGXDHglk/7ea5CuuSw/DYTJQl
 +wxl/8tXk9Fs4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq/NhAAoJENju1/PI
 O/qaOzAP/jdLuPiuDud4XqaorY891Une9jj/j52FzbQK2LBgfx1HVjw9B3PY57k42Z19FRb0XFo
 aBGmPnPsTVpyfPAo3IjgX+rBcSEBe++gm3OCZp8Vu1k3ZOvZ1sBcrQXN+ORsGAsiE4iWrdU2q5G
 FeON4JyHMjQHbvqQr1UJpmFajlcHQCO/z5RPGqHC0tgu1NqIe7HrsQ2ddPYscbZoaf/4OyC6wwu
 Zok4gnULpG1c/10ZZk8stWbQ+JOqykt61IwhRBlfYBvFmjuL+rAVA5BzCMWt6WJyl+NGfsepk+e
 tPYYqHpRLT7gLQ5gAsb6xXFAgujM2M2kH1N+xLexKXmSMAo/mE403j+OB9zS66HLcfmjHfZ+vLo
 CBZ6LOixQXUigMPb5kjCb2E3DOQtCtX0D6fQ4+Bkl3+o1/dESFZCwiBKpz8PkYnm6e+bzau7bFn
 NmP9EZTVpfbCy22iKm2XrTM8YNNUhaufIudqdDZcTPd4h2x6G4Cd/0FiJLcZ4W4hC6+CITWRgmE
 U4oao2Kc6psfe3k28JKeP406UOv4vwi7vcYkah7eNERRaBgVZ8S89DAUfUvsBHQfwfmUTi95PQD
 cGtNkOFVfdpFqExMg1/G+Tti2vSIpP+Wk86AzqalDPF2NSdEj70h57P4ornx9WlvS/oIHDc6F9i
 7Ved/FfkVk42wpVtiZewy9g==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

DDRMON in version 0x40 (found in RK3576) has two control registers,
which moves the register addresses. Move the register offsets from the
defines to the varaint struct to ease supporting the newer version.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 380361a231a2..8490219f61be 100644
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
@@ -275,13 +277,13 @@ static void rockchip_dfi_read_counters(struct rockchip_dfi *dfi, struct dmc_coun
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
 
@@ -829,6 +831,10 @@ static const struct rockchip_dfi_variant rk3399_variant = {
 	.max_channels = 2,
 	.clk_names = rk3399_clk_names,
 	.num_clks = ARRAY_SIZE(rk3399_clk_names),
+	.reg_write_access = 0x20,
+	.reg_read_access = 0x24,
+	.reg_clock_cycles = 0x28,
+	.reg_access = 0x2c,
 };
 
 static const struct rockchip_dfi_variant rk3568_variant = {
@@ -836,6 +842,10 @@ static const struct rockchip_dfi_variant rk3568_variant = {
 	.stride = 0x0,
 	.ctrl_single = true,
 	.max_channels = 1,
+	.reg_write_access = 0x20,
+	.reg_read_access = 0x24,
+	.reg_clock_cycles = 0x28,
+	.reg_access = 0x2c,
 };
 
 static const struct rockchip_dfi_variant rk3588_variant = {
@@ -845,6 +855,10 @@ static const struct rockchip_dfi_variant rk3588_variant = {
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

