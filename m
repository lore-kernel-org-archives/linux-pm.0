Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADB268690
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 16:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783269802; cv=none; b=rUxt9ETTJ1sscg9hPJtJf2RXDe0t0di4Gd2hzOf4MN0y+9of365N3bocJyAHTfpfqUGAdiIFVV8WgmKEXMgGDxX8AkCOIzoI78gEqUAwGbCUg1Ab49YCmEMZkSpbPvfngdirnsb02QYOVywPHcg/eYK8+ZFZWNQ1lBNoEuOxKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783269802; c=relaxed/simple;
	bh=cyUkMLJJp3urCo9V1X8obrIRw6qDYFxdPLNNgwlOFR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ltJPUVaS2bLhR1KXdtQ8UdQJoM/KkjBTaik+Z6N2vAwFQIdlY2BpV0DiP/yilCCaKD/GYh8s4dtK50T2rjKde4wEeamRh+2+Cw8I7M4E2aTii021UUeyg5/uBzsRB90rwA+gw90WAL99/hOnLgSAfCTTcx5HOvJnKM6lSSSXQ58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=PdRaf902; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="PdRaf902"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=GAELMdD28uRnWd
	mZM6U9lfBnfk6B8A+WDHptdWUHPCM=; b=PdRaf902Qlmj0nfltRVYKhEPRG7ixa
	dzPjp1QeBSg0xA9eDxJeXTcuhE4Vj+cC5BAwPr493DDoPdt67APbf41qt4cebozj
	74+wnJIqTIDcUvw/a0+YEKk0/ns24ENUq+5kuS0JMrnCB68zk0k2kKl1I+ELGAuz
	7pnvNq1uUGxmTWfaO58/fxDb8XBPAmP/Z0NpMpE4ESgv9NBPtdalLrFYeNTbqA+z
	5iI3T76rl5gRNCRS6iZAKVddDrJoQF02L42MUN0KRkOAsGcqQkZaNl5XHp531QeX
	Rcq9E7kB4FI0b+QdaI2nQQx8xv81ZyCHn2t8A1Ut5RP//XdEvu/VsHmg==
Received: (qmail 2289317 invoked from network); 5 Jul 2026 18:43:18 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 5 Jul 2026 18:43:18 +0200
X-UD-Smtp-Session: l3s3148p1@QWjd2t9VkCltKjFj
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH] thermal: remove unneeded 'fast_io' parameter in regmap_config
Date: Sun,  5 Jul 2026 18:43:12 +0200
Message-ID: <20260705164311.2273-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/thermal/armada_thermal.c | 1 -
 drivers/thermal/sun8i_thermal.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2fbdb534f61..252d5afecea1 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -722,7 +722,6 @@ static const struct regmap_config armada_thermal_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 };
 
 static int armada_thermal_probe_legacy(struct platform_device *pdev,
diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 22674790629a..284684137c43 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -149,7 +149,6 @@ static const struct regmap_config config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 	.max_register = 0xfc,
 };
 
-- 
2.51.0

