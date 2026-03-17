Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F93E3DA7;
	Tue, 17 Mar 2026 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757898; cv=none; b=LjPIaNZ05Tj+DKpf5O3lO/zJuEBO1lz+ywk9ElZqv1iVSFtYPMTpKMjAW2ZkJ44MDsAuFUu8IYGaVIK4EPPPsYPP9NxN4wtSnGW6v7y0tn9w0SLMuO3sovcnYcO93ZrANDFCD/ZX+vXYYrw9MYcFvBm/ddJXX4uEv1zxMtLn4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757898; c=relaxed/simple;
	bh=rM6Cq3+ZUiC+AZdFn8pQ1HrieI0QVdQPA7j0GTmtziQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oLA23bXZnnCO6CV6w6YztgeWwvy+eIgeW26laYb+PIehbuK2Lhe+Ew+eVuP/5tH92zJWSeq360IObNyaIdzPRJC5vhJ3Wkf4Ccogakb3NO2GGAdg4upwwkTvKfqvYK35yQmuaCD3QpVENOhUpUuGBLinKBUoc6l7ZXQwypwzsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=f7s6+i5q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="f7s6+i5q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773757895;
	bh=rM6Cq3+ZUiC+AZdFn8pQ1HrieI0QVdQPA7j0GTmtziQ=;
	h=From:Date:Subject:To:Cc:From;
	b=f7s6+i5qeAAhNNBIIP95or8sqqZR8VV6EGDPuK8gMGdnGKIYgdrqCGWQYS9HIzSaN
	 2wZBja0TR0tFI7I0+c8Cs2VS5tokSz/B/ra35kideju+jeOk02YJDVLZmOYn4rWfxV
	 jjSxMPbKSziXYWH6huiEGpbfo6DIVvjfCY/JUbiRSGTlY7Kc+p2/I3jDtH89p4Js9T
	 w6rU1fz7iUXCY+ZNNwPLEyY0frIzXfaMkj3SVOv/9fy79bjshbBXszs771K1Xs/Ebt
	 XnoE8osfJw38Qr4L0gugLufChcL5L0w0B/UXDTQ+7/iqlJ4Xj3CxlV409IZqwNW6Ok
	 +8O06/Znl5KJQ==
Received: from jupiter.universe (dyndsl-091-248-085-025.ewe-ip-backbone.de [91.248.85.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AE84517E0E3F;
	Tue, 17 Mar 2026 15:31:35 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 4D43348002A; Tue, 17 Mar 2026 15:31:35 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Tue, 17 Mar 2026 15:31:30 +0100
Subject: [PATCH] thermal/drivers/rockchip: Shut up eFuse prober defer
 warning
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-rockchip-thermal-trim-warning-v1-1-01bc4bda75e9@collabora.com>
X-B4-Tracking: v=1; b=H4sIAMFluWkC/x3MwQpAQBAA0F/RnE2tJcqvyGFaw05YmhVK/t3m+
 C7vgcgqHKHNHlA+JcoWEoo8A+cpTIwyJIM1tjZl0aBubnZedjw860oLHiorXqRBwoRuMKaxRHa
 sakjHrjzK/f9d/74fe+Y/z28AAAA=
X-Change-ID: 20260317-rockchip-thermal-trim-warning-cd0072aa2f46
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Heiko Stuebner <heiko@sntech.de>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1275;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=rM6Cq3+ZUiC+AZdFn8pQ1HrieI0QVdQPA7j0GTmtziQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGm5ZcfOlHQ7B7RY9QNFeSFEmZIw2HGpVt8dv
 mD4+j/mpmTEmYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpuWXHAAoJENju1/PI
 O/qaA5UP/1gX3O/UsiG5YGu6U32IAcf1ROmf2gS3hTr4Qy5C2UMVBC7FyJuV3Yhwotm+tZ1FedJ
 pTWqekZXX90khjfN1dAct8DmQmL4NEc8O60f7g9q79Hu1D2nTOBOJBvmmWE6esZJAE+tx1q65Uw
 MA47NDvMaki1BpkU/rA8rzAsYiEdZpmOYQMCYZN5wkb6Ida/Khc8gZxDum1qVSIAlmcGyphmfN5
 Kj/oV7weqc3RTJKvb45VwRYrll4RKQ7gEUN8Sjq1XAUtdKql3bbSIJywX4atWfRPpCW5y81V0/S
 GI+iDnZf5u22N44RLZskYy+DA/UxR7RwKEGO9/rQ2zwI+TTRGsEi9q1/0mIsbUdoIlK1W9VQSDm
 6GWiMBIvMSyFHDcGJC+upkL8eBX7AKlBCGWF3FqJdjnPzpcgx8uxa5VQkryAJPx8wua5YwsHv1w
 dvGb0iz8dPzZph2NnL7MmQOZcxfXqdve/9oJce3FLPgXLBhvD/CbvsfEIaKLiObDl174lSqybff
 Vn6YT3C5iS2Y7ecuwLHcW1TE1qAUchL/tGxR8wLaSqSchzSZyOXb2RLBQxM2MppiwzpJspxw7tM
 sWCClZLrjhReq0cf3qCvxrgbQON1ubEtTtCwX+7Uvjd3bA4BuUFiZ6TbF0WXI+eaDvn5TLOqvJ0
 ML+Y/XnxAN06UQL8iX2QtsA==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Shut up the following message printed at error level on ArmSom Sige5:

rockchip-thermal 2ae70000.tsadc: failed reading trim of sensor 0: -EPROBE_DEFER

Fixes: ae332ec0009d ("thermal/drivers/rockchip: Support reading trim values from OTP")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c49ddf70f86e..2a40339de0d0 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1638,8 +1638,7 @@ rockchip_thermal_register_sensor(struct platform_device *pdev,
 	if (tsadc->get_trim_code && sensor->of_node) {
 		error = rockchip_get_efuse_value(sensor->of_node, "trim", &trim);
 		if (error < 0 && error != -ENOENT) {
-			dev_err(dev, "failed reading trim of sensor %d: %pe\n",
-				id, ERR_PTR(error));
+			dev_err_probe(dev, error, "failed reading trim of sensor %d\n", id);
 			return error;
 		}
 		if (trim) {

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260317-rockchip-thermal-trim-warning-cd0072aa2f46

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

