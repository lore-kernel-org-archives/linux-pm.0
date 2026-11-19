Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093413;
	b=v+lijRlQ/A12JKwH3ip/Y9Y1E6w23ODCSHC8i/72svqVnjCdZARKjVNrXXvxbFU7uTDy
	 BsM6XNBKnsBNQmxyW/eaYBThA8YssknLsa4iO8o09IQdg+c+VF0FCV3icNi/EqLZvp9z9
	 DYPYZOWkQeIsPvMhFlYbz5CdKmIoviZS2Mvn6qYiombbNti/byDHu7S1ftxymb1FeB+0h
	 P2e67na5c/aaFNHTOJYSr/jHRvIMtKw40oID1MX2KZRC/CJ50b6EKEM5xChtGCDKO6mwn
	 zJx20296ONcHFthi50rAAuiwK1pLal24mCPTU9v61jIBzaIE6tfSm8XgswHHlZdvuFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=CH1mqdiplRi7By8jqv7ZewYLiYQBtFjjDxN+Pmiy7s4=;
	b=K2xju3fAPKuLtrOzxGdeh4gwO+KG/5lH7HfeMoQ9fmt8g9mBINs/CmcLvAG+E8/+yfr7
	 i8ECBizSxsVUe/E14oO//yQSs3DNIpUntd9v6UBY6YXXInE9mjE6ausbCYaIpIkoBh9Os
	 OvdNAzAmxdJAGK8Lnaoy/zgYEicXtVK5wSbkWa4OOYN9Zbalf0t+S+v8mv3k2/pt+mNgY
	 Regx7+dqNde0nGafnXoNov9SeHhYOAZZuSNxuxKQBsw7blljN0YhuUCwsS2kIuQItTEe8
	 zMIdObOis3tgqHJWdhStSjTZCUkclCJKHRhU0iukWZZxbTqwt2mYAydEwXnwccSDoDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=OfHgteXa;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE860A380C;
	Thu, 19 Nov 2026 13:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9AE860A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=OfHgteXa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093403;
	bh=+5SgEWnkoWOtJ2jdLxg0AQaYLfZljKvmJAUEogbH4b0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OfHgteXaGtmCA8UW8pYSFWbxJ6guQRUeEwgGHryt5sZ6imp794H3SVzDdPFeZkGBR
	 RQgs7mN/P+u62LJpPczBoNc1zn7O+aSoUD50YMq3o0ZDHQlWt2o/KsCK+egPzMgcvc
	 k6OEb1nTgGoQz8tM0HKTjcEDHiG1orbJBxXT6JuQCsyBbUlzXmc7u52EXo2G4OWAew
	 mnMYGcK4yCN0Vb7OHeyXWAl61y1zogJRZCZnbefwqHGgD9D03b8s6XWHtYr0a5jmuf
	 Y+yME2przF3R6IOGYhoKuHwgFKsjHTSm1DTppLTcEY9RPguzXp/lY9KmcBj/zXSM/6
	 pOt+4kU/MByPQ==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4682017E0E41;
	Thu, 19 Nov 2026 14:03:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 9DC80480047; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 19 Nov 2026 14:01:59 +0100
Subject: [PATCH v4 09/11] PM / devfreq: rockchip-dfi: move register offsets
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
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-9-517a68c008fe@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3935;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=+5SgEWnkoWOtJ2jdLxg0AQaYLfZljKvmJAUEogbH4b0=;
 b=kA0DAAoB2O7X88g7+poByyZiAGr+85qiYp8matfa8pEfF8LWVaNeOzhYBgPma9R7xf6VvTup0
 YkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PIO/qa8WYP/2DQ
 kpo/xSLbjP3DanDGBvzC8sqwK6WPr5UXcbDEIguMnt6SDB+zx9sXmzG91vvjiLBwF8KaG7ab1CY
 Bw+xRxUZMIzWXR7mdCO9wTRbfYi5LiPmrKR812fwmOSEsqP29OlqJDGc4JB26oNLjf+u4WXPCst
 BmpUZqy47dW7BzxOwD9QJb7Y8l86fOfgWTHD//wPohpkqbsNa/I9hqo12HHFwVJMUdJByhTWzE1
 ziuDn984gDuySGKIidhHRZbWqmHZwt2Nn6ivOiv65vKWY280Rd256vrhAENV9yU6klsUljZDoAk
 dpI9S4s/eL+nxbWhEn+8T8JBRFc4hvjXzVRjRzJrX+/x7pbaUmXXJISWWcB/+P1Ll6W5UWLn2jL
 m5M7qo0yW/BaY3IZ5LO4TWPlSU61mhhu3ZorGhEgwPAva+hLNBjfNQEtZ/2C5kUxJiyLJqWi9wU
 wrfYkd4M38wfTpU7Gl5TaKIkoWM+mlqy4rewLhUVhoJ6dkd1ZDxxANH1cnslJyKEip2dT2XD5be
 9VXtX250H5u2UAwyXPYnFm4qCJgo3XWjA/sayixDVDlat0ujsnL4CLsosQWSIWYIofnAJZNhl48
 rKLW93yLWIKiDT8rkRewzuqg03Dy7F313ABbjJh7NTr1LPzBFvabW2kiSiKR5pI8otr3sA45LO5
 4b4dt
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
index c51d7eeec394..a8329af90709 100644
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

