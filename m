Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390F37D12E;
	Sat,  8 Aug 2026 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786220704; cv=none; b=t3imrG9oKwsP8AXG7rTokMWohUgW4ZrIqYzNO48N0smkr7Tg6EMdYMX29T6FCSOIbkp0UREzYyTjKq3j66UjyiUWX+tSUYCW8rWoDMfU565mFyJuFn56OXZ5Dp/e3iwJ89Tyr2WXaTbQRQNmc44OdItZl2v539/6xiA1JiFUb54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786220704; c=relaxed/simple;
	bh=akIElZ664VnThhT/O583ioHadFcoj3UoY4fB8Adz9ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ru4TqvYABdtMiqjPnFd6gpAqQZpjU8Czb9dIlk7sX6FpyRjXJ2jbnd2xbbmAFdnvdN/6se5llj0UYQJNmryQkj53sPLrj+9+4TLrUfpAtYtXouoMkieO1d+etVkJYD4GDsj0HLoM1t0Jpa981Hi+0PbTIzzMkieFAkqmDkoZyNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Zk3RD5K5; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Zk3RD5K5"
Received: from device-101.home ([10.64.95.115])
	by smtp.orange.fr with ESMTP
	id sna6wGeV0xVuJsna6wvBy1; Sat, 08 Aug 2026 22:23:46 +0200
Received: from device-101.home ([IPv6:2a01:cb10:785:b00:6128:9b8c:c203:905])
	by smtp.orange.fr with ESMTPSA
	id snZww80X0VmS1snZwwkz1T; Sat, 08 Aug 2026 22:23:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1786220619;
	bh=Ll+F6nXFSqpVhu4IsFAP7UVPO/qt/IPQf17t5zCa43c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Zk3RD5K55BZ+T/D1ZOwUQvj5+2diY/4gCOhQ+FoOAgQ8Y3bVrLwYB9qldsbSVqSHe
	 prxaEo1Y0kJYxP6yq/lS7tfMbS6r6UcxM2oufRHpBHpZqQSSaOd97onbJyBX2UzJcI
	 YreeOTlxvlC6hCbT/u5Npm+ifZGQpdf4/WbDN5lSxf40sb2a49ze9bleflMDhSlw9S
	 ORqumwfWEE9XyVoSracsePste0lrlBlj9rifV0uZNMqn1A2WvtTy78/CZC8UTSFlN3
	 lPQg5x/r0MOY0e5ftefHf1BQUHDTXLK4+YC4BDpIDDCIxFq3LTd0tsuCFSZpUu/II2
	 poi7Xo7OI2BhA==
X-ME-Helo: device-101.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 08 Aug 2026 22:23:39 +0200
X-ME-IP: 2a01:cb10:785:b00:6128:9b8c:c203:905
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-pm@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] thermal/drivers/imx9: Constify struct thermal_zone_device_ops
Date: Sat,  8 Aug 2026 22:23:33 +0200
Message-ID: <5cce9ea713edcf2aa3c0efd5d31e9d9fd9f40a88.1786220585.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct thermal_zone_device_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
   8567	   2144	      0	  10711	   29d7	drivers/thermal/imx91_thermal.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
   8695	   2016	      0	  10711	   29d7	drivers/thermal/imx91_thermal.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.
---
 drivers/thermal/imx91_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
index 25915bb702be..892a25440e06 100644
--- a/drivers/thermal/imx91_thermal.c
+++ b/drivers/thermal/imx91_thermal.c
@@ -225,7 +225,7 @@ static int imx91_tmu_change_mode(struct thermal_zone_device *tz, enum thermal_de
 	return 0;
 }
 
-static struct thermal_zone_device_ops tmu_tz_ops = {
+static const struct thermal_zone_device_ops tmu_tz_ops = {
 	.get_temp = imx91_tmu_get_temp,
 	.change_mode = imx91_tmu_change_mode,
 	.set_trips = imx91_tmu_set_trips,
-- 
2.55.0

