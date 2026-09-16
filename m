Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D8129DB64
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541383; cv=none; b=lt4Lnbc5lWXHRAaDRM7LSpPIPiZy3vnx0Opi1vYdUOUF3fCGgu5jzPyLBQx5YhLampP3N+LvhKUJr6mAB3zOYF6It+Lzd59zBjXJCVTZL6MBSATCtnVO5aIaBJvfMhj+NO0x9IetCVxErO5CvfP0EIKe8cD5szb/LGJKTMXo33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541383; c=relaxed/simple;
	bh=lsk1QWuTUS9Nd2/d7mkXlHhU5yiCS1Maqopfu/YC5aA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rPGT6aK8G2ywseHGfV2c2akiRX6nNVi4YOeeRTd+/e0EqXAr0EG9RtfyuEYTfbqyPcGGduwp3jkhSUSrACcT/7bCyAKOMJflmZVt/zH9ddduf6/0TooxC4gb/cnpilkq8jDvSeZqlnMlJ3xkh4MKer2ol5vNljVmAoG9QAAJJuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgUEF2Rg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgUEF2Rg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9121F00893;
	Wed, 16 Sep 2026 06:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541382;
	bh=vRQB42zqCIm/o3FC0oEqxEawLh0xAICMd8Zh82pN2jY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YgUEF2RgMR/vXRnPUzpJ7wMV3dL42xd3P8kyUEqtExGraw0tftVLVtpalUw6Rs75m
	 ABUsK470uF8Jb9aviCZ7MwYoeFavQlXMmooc6ce/MyB3B5jzuZGXdmymUHIrDsZMVT
	 XxkjlstduPNxmL+a3WVUrHHqfgHwamE3WcEwAsHMPQC0VeT4340Rxa4oj2thC1KNSu
	 OFmK62h2z2MlOlwuO36Jcfe4TPyxg6VdklDmmZamoa130It3+ecCDIeXHbEN1QqmyT
	 8D1lbrDsQN3zJ47SRb+aA9i27lC6DlSdGmvJ/+PONBlrzAz2nBxK0BzV5fGZoe9gxP
	 eHZ42btsIxmMA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:36 +0200
Subject: [PATCH 14/15] power: supply: ab8500_fg: Finalize current
 measurements
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-14-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

ab8500_fg_inst_curr_start() returns with cc_lock held and the CCEOC
IRQ enabled. The bounded sampling loop in the load-compensated voltage
path returns without calling ab8500_fg_inst_curr_finalize() when it
expires, leaving both resources active. The next fuel-gauge work item
then blocks on cc_lock and all cached power-supply values stop updating.

The Samsung-GT-I8530-Gavini, Samsung-GT-S7710-Skomer,
Samsung-SGH-I407-Kyle and Samsung-SGH-T599-Codina-TMO product trees use
a bounded sampling loop in drivers/battery/abb_fuelgauge.c but still
call the finalizer. Follow that pattern so the normal completion timeout
also performs the required cleanup.

Check the start result as well and return an uncompensated voltage if
the instantaneous current transaction cannot be started or completed.

Fixes: edc400e1632f ("power: supply: ab8500_fg: Break loop for measurement")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_fg.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 70e29c9e8108..b3f29a43745d 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -934,9 +934,15 @@ static int ab8500_load_comp_fg_bat_voltage(struct ab8500_fg *di, bool always)
 	int i = 0;
 	int vbat_uv = 0;
 	int rcomp;
+	int ret;
 
 	/* Average the instant current to get a stable current measurement */
-	ab8500_fg_inst_curr_start(di);
+	ret = ab8500_fg_inst_curr_start(di);
+	if (ret) {
+		dev_err(di->dev, "failed to start instantaneous current measurement\n");
+		di->vbat_uv = ab8500_fg_bat_voltage(di);
+		return di->vbat_uv;
+	}
 
 	do {
 		vbat_uv += ab8500_fg_bat_voltage(di);
@@ -945,15 +951,14 @@ static int ab8500_load_comp_fg_bat_voltage(struct ab8500_fg *di, bool always)
 	} while (!ab8500_fg_inst_curr_done(di) &&
 		 i <= WAIT_FOR_INST_CURRENT_MAX);
 
-	if (i > WAIT_FOR_INST_CURRENT_MAX) {
+	ret = ab8500_fg_inst_curr_finalize(di, &di->inst_curr_ua);
+	if (ret) {
 		dev_err(di->dev,
 			"TIMEOUT: return uncompensated measurement of VBAT\n");
 		di->vbat_uv = vbat_uv / i;
 		return di->vbat_uv;
 	}
 
-	ab8500_fg_inst_curr_finalize(di, &di->inst_curr_ua);
-
 	/*
 	 * If there is too high current dissipation, the compensation cannot be
 	 * trusted so return an error unless we must return something here, as

-- 
2.55.0

