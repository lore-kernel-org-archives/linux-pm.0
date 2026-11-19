Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093413;
	b=mZEPNvwsOIGHIXyQQB4ZucpFFmJpSQpHO7yDQ4pW+j2tpVbbZs3OiqQEvV8zrgxiRX6U
	 yiZeMAYkxF8adG3AC63UzFJKsIAaDBvWwYJKohMil2tjUXkCnngTkCu1aQxdzk5zJi9yB
	 qYy6GpxjZhAxxMFPgXsZfhfweHgwrr7WWt1uzNyna7ZV2oyK+XQWYcM6tIgBj2BSh5Iol
	 JRPO9myUXvklh2E61cgPE3nhUDvRPQxat1MM6Kw9n8j20RqWU4y+unUN9iAFydk+LRiaq
	 oj+AJ102HD6S33wTEMxLTX4jAqy6yrngGNg3DqzJDbEUxSf4Wg39/t1RgXK2RU3x57g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093413;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=DYH1/AQ3Lu1M5WSXLXEh2RLsLWPm+QDXkHsPbloJE1w=;
	b=WyqFVbCfJ8MlyImLG/ZleUbFew1MJHRY9ulOZa1+HVhRq5j4wAI81MVK0wIzwCyPDL6Q
	 wKH73ZesVeP+INoofgkkEis11CZoRN8dRbEph3+DmNbfBsatMrY7Ut9j0/Hr795Zr0avw
	 iV4wRFgEyNrzYE1RMFBy9Wm5ZOn9vJhqeR91eQQtCGZNaf+w+V2NBNVJxdX2QKJ84CV3X
	 bRSuB2iPERAwwbsAmfXetIZFNarsaPXFx2S0IjhGjrsJyXVV4dOEl5hkwXu5ZCOj3pqD+
	 0zlvriDvUgQ8KEUZV+UPYGeGkiiUh5Zh54HGC7O2QR+sukCDBwIeAQDHtrxrn747QSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b="ld40b3/L";
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E3A60A3811;
	Thu, 19 Nov 2026 13:03:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6E3A60A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=ld40b3/L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795093403;
	bh=189/Wb7wAR5Wao+TccPh0/fJo+O+FiP0nVvOXZeN/CU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ld40b3/LCPLvkhbWxL2oK1n4/DS2GerNic0XNXSGhVMa7Mb8dUvVwAgzZtNaJ1n8b
	 0cJq3aAOTKjNTICnq4hNYw1zBfFJM/Na3+1+7dkg1pAkCw9AyFKj16VcIreY+UnWdr
	 eqrfgeclmCuz2NFtjcTiVRys71BqZtDbPK899vfoaCI8UzzJXE5ZgRwmVosZgFUAd4
	 yAf8rLrb0lw6T6niV2xnIU6J6Xh1KYzWv2MOdABttqzNSyTpzdLn9USjF/o0yvVlZ3
	 Sg3PreaiP/Tu39ZUVdc4OaqgqRhqvtBcfls9IxV/qKlXBrALBp3Rds0RkDFG9iHyNT
	 hPpndfRcXrjwA==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 51AA917E0E6C;
	Thu, 19 Nov 2026 14:03:23 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id A129E48004C; Thu, 19 Nov 2026 14:03:22 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 19 Nov 2026 14:02:01 +0100
Subject: [PATCH v4 11/11] PM / devfreq: rockchip-dfi: add RK3576 support
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
Message-Id: <20261119-rockchip-dfi-rk3588-cleanups-and-rk3576-support-v4-11-517a68c008fe@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2187;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=189/Wb7wAR5Wao+TccPh0/fJo+O+FiP0nVvOXZeN/CU=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGr+85oe7j+c/5fx60jVJUxmbXk43f7T2DBR7
 8dLvea+4G9t+YkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJq/vOaAAoJENju1/PI
 O/qaeG0P/A47wQnk1LcG5oDfUxLMhv1xQ0XI+IdDgNzegYajRUrNpNpaXfr/H5/AreM6cXULysC
 XLuMsIctCpkkQdI1qmJeVRSkgW+CGS5h53MLC7up/J+/3ZtZWByuWjS/E6blwDZXVCOsLQaG5bo
 019b05dqVgk9dGG1aTCT/By7ntcjA6htqvluJJJbZGEPoSKojA8tbqVSMhMO8mDDgDNTbpx3xB1
 f4izBelW9LWjA9+k6lDSxz11+hfrBhGXBRM7NWvNC2M0dYeyU54MmLiCtrbbDmry3hfy+08gFcI
 f2JDbcYor5T8aMdDyngNnSjxK/vpu5cyDk6uqA1wn3pGB4LNfWl+y4OdRczoilCHSa9O21esFyj
 37RLPfI/vy+aRyqXEN7tAKKzGSD0Yl2wOVcAWzX8vyteExUSZUk/w6uwDClEfYBqvzlmxBylLim
 A7owwJfPypxUF0tDnf/ILtdDJfgMejoabWA2GHXZqob4/OsSGNtuVBzOD7DHhU+Ge40KW8oQyO7
 8xdmP771xX6Q8n8BHy6sP3a7XCQGi8wncZ2buLBiwmyiAngczdKAeneR6ObS14x2Y+SUxDlYIjz
 X6JzZrXuuYypbCW3YKPzJ1sHOQMY00sQxSPLUnUIHI6aoCSjRYSlnjJnVFYmxHzzBBXLe2z4twb
 YXdgKhojllAoRrh/e4uI5kQ==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add RK3576 support to the DFI driver exposing the same functionality
as found on previous chips. This uses the RK3588 init for getting the
DRAM type info from the GRF registers. In contrast to RK3588 it uses
a newer DDRMON controller IP, though (version 0x40).

Co-developed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index db2c77fc5907..cde10d1e708c 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -859,6 +859,10 @@ static const char * const rk3399_clk_names[] = {
 	"pclk_ddr_mon",
 };
 
+static const char * const rk3576_clk_names[] = {
+	"pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1",
+};
+
 static const char * const rk3588_clk_names[] = {
 	"pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1", "pclk_ddr_mon_ch2",
 	"pclk_ddr_mon_ch3",
@@ -888,6 +892,18 @@ static const struct rockchip_dfi_variant rk3568_variant = {
 	.reg_access = 0x2c,
 };
 
+static const struct rockchip_dfi_variant rk3576_variant = {
+	.init = rk3588_dfi_init,
+	.stride = 0x10000,
+	.max_channels = 2,
+	.clk_names = rk3576_clk_names,
+	.num_clks = ARRAY_SIZE(rk3576_clk_names),
+	.reg_write_access = 0x28,
+	.reg_read_access = 0x2c,
+	.reg_access = 0x34,
+	.reg_clock_cycles = 0x30,
+};
+
 static const struct rockchip_dfi_variant rk3588_variant = {
 	.init = rk3588_dfi_init,
 	.stride = 0x4000,
@@ -904,6 +920,7 @@ static const struct rockchip_dfi_variant rk3588_variant = {
 static const struct of_device_id rockchip_dfi_id_match[] = {
 	{ .compatible = "rockchip,rk3399-dfi", .data = &rk3399_variant },
 	{ .compatible = "rockchip,rk3568-dfi", .data = &rk3568_variant },
+	{ .compatible = "rockchip,rk3576-dfi", .data = &rk3576_variant },
 	{ .compatible = "rockchip,rk3588-dfi", .data = &rk3588_variant },
 	{ },
 };

-- 
2.53.0

