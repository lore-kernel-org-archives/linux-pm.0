Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB851598C01;
	Thu, 17 Sep 2026 14:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653866; cv=none; b=QcKtWNczfgoTGAFJ6H5I9DHvs7BsLvqFnvPEeA125AauNBLemGzSfJaLDPKLMNmdUFVVWHvpopR+6rvygCbUaMbnatVDUTAZRGOTILwZInMZteDwCxxttkNVk6mvOnZMXoY7O/ynBU3+RAcVrYPXpwJrcPRIh2ckTAYvE4RDqok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653866; c=relaxed/simple;
	bh=TNtuc9GGI5fjqkVDrU17OxAsxDoMnUnAakkErqmjmpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abTLQrhAaCugys0S4XQNPmqQ6jBsqRdS0E7vynorj+EELksdoUrBh5vjOtNZ8InViYgRYBCJi+C6cNSa+CcFtCg3jzMWwMRAF/LZm2/QvawbwuyBP9wIUe3d5+R+1nM/ZMl4nA/dQ6sP8Sd+dA22FT67pzmIn1iHC3MZuup8VgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jMT9IhNF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jMT9IhNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1789653858;
	bh=TNtuc9GGI5fjqkVDrU17OxAsxDoMnUnAakkErqmjmpM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jMT9IhNF7HGV7QqLeOyyL93BjgncoG8F+jFqYZJt2y0gROue0GjQ9BGA4YH8dbqRO
	 c157zJ8eXVCIEPJ6EjxpmxqgtYOvWQg5PRlmSovlzD+hrR/rXw3j7CrHyxQoSmWfgz
	 kxNBhCdgUsfdqnVeSsXnEODgTqTrG+rhSql5G2ypsZuK6v1eJE+3/Hkpla9gKjHcVZ
	 MTRdigstC78jIVbc7NM7LQ2lS5yhvyMj0yMaVobIYWWROerDr5yt0FpNMklwMPBm0j
	 5mGFDa6mb06mZOs1WPPPych7sWDOUjBg5v9wNj4priXir8niTWzoty5XiSP2Hv3UdB
	 YTWqpqd/DgtXw==
Received: from jupiter.universe (unknown [100.64.1.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 84EA717E0D49;
	Thu, 17 Sep 2026 16:04:18 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id EE3E748003A; Thu, 17 Sep 2026 16:04:17 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Thu, 17 Sep 2026 16:04:13 +0200
Subject: [PATCH 7/7] PM / devfreq: rockchip-dfi: add RK3576 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-b4-rockchip-dfi-rk3576-support-v1-7-a5752a29f7bd@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=TNtuc9GGI5fjqkVDrU17OxAsxDoMnUnAakkErqmjmpM=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGqr82EejlJ4FuU9C+ypGh5AhmIBgkLkIVLEA
 skFrKrWWYV3wokCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJqq/NhAAoJENju1/PI
 O/qa8+YP+QEDsuu3RP/2L/Qy2ETZ2iabxGV5UWbgrhU1pPnDMxMaAssY2VYSmij376j5jUg30yZ
 CsDgJztC5EgYglcDRzFTjrF7jY1BUqFwPInLGCn8rvy25PKxICcLtn5SaqNr3CgfmrwoKw0vgcZ
 LlwhUyyamFvSN/fbb5CJR2jBBemSEEDiDT1GS7xA7pW+4agVXoqpVd/Fq3NVJYVV5BCKSPsDaUL
 eJWoL/ynSBl62rS1ycp9uzCQONR3NubE285zGeLZ9vvtEIQTIlAKg6uiu6pu5P9fEEvnScZ5ihF
 OIVCaS5dT4Sz3BIjTnIQwligCNrcHt0VQ+nEBMDNUKx0pDl/BiNHME5g3RrDG55alodx1brJ/3N
 W9tceAUrE+Kt7debuHyb6+lSWWd8FGpePaa5vh0fYeAPCpPJgphs4Z4il5RZmcFnVZLXl9qDbxD
 xvexArxbuKPEQdJgXsXk2DHhnBFurWLaq6siNybPVNqY+GTfOOFt6OOsFx0K+AItSxGbJK+whay
 TGMNqwEGiWjXSVUnEhpEGSLN3e9A3+Q1c0YuRrwsktw4jOBk9FP1exsuvw4u63SVnNPeRCP2eNI
 Lf7x2N4OShGGhtLgDildct0SDJxrWALQEPIjTUc0SGJ/+vQzQFk50GZWmLbeqdeyYw5fHV4vrsN
 qnibFnxZbttyxFtVEw7kqJA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Add RK3576 support to the DFI driver exposing the same functionality
as found on previous chips. This uses the RK3588 init for getting the
DRAM type info from the GRF registers. In contrast to RK3588 it uses
a newer DDRMON controller IP, though (version 0x40).

Co-developed-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 8ba97af78e3d..a895e566b4b9 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -858,6 +858,10 @@ static const char * const rk3399_clk_names[] = {
 	"pclk_ddr_mon",
 };
 
+static const char * const rk3576_clk_names[] = {
+	"pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1",
+};
+
 static const char * const rk3588_clk_names[] = {
 	"pclk_ddr_mon_ch0", "pclk_ddr_mon_ch1", "pclk_ddr_mon_ch2",
 	"pclk_ddr_mon_ch3",
@@ -887,6 +891,18 @@ static const struct rockchip_dfi_variant rk3568_variant = {
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
@@ -903,6 +919,7 @@ static const struct rockchip_dfi_variant rk3588_variant = {
 static const struct of_device_id rockchip_dfi_id_match[] = {
 	{ .compatible = "rockchip,rk3399-dfi", .data = &rk3399_variant },
 	{ .compatible = "rockchip,rk3568-dfi", .data = &rk3568_variant },
+	{ .compatible = "rockchip,rk3576-dfi", .data = &rk3576_variant },
 	{ .compatible = "rockchip,rk3588-dfi", .data = &rk3588_variant },
 	{ },
 };

-- 
2.53.0

