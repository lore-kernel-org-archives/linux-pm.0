Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DD5426690;
	Mon, 20 Jul 2026 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558572; cv=none; b=ugsuj8r2ObTWq8liijZYBpl7SK2wN2flOOSJ/gMMj9EMJMBOKasMDOX6ZJC8KzT+XJCyqpE3ZiCgpehNf+i2rbrc+o0wIOBd2yrIJDEG/OOqEMl7eLE6W3yEyt8p7tQiwwVULf6JoSLJIm1MdNgJzj15baiGsJ+GX5JHewbQnq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558572; c=relaxed/simple;
	bh=rGBw9sMpTr+wuKH0VkSwGrsToToyYGvf8ggG4l32bF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rN71veyd+0ZskMY1m0zbouPxUoyAdaC0bOSKMXbaXk2Gwl3m7tlbo+rRTgxCPyTAF7gX38SKLUOpcieAQgZSfV7joE598wGLLiV79PwpqZHEbtWpGCT7oeFRl7v392x4HFIkn3NahkxaQQjnO6/qR/gY8Ry6/E4ps9yrRz25Y7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O1AIoBlZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O1AIoBlZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784558568;
	bh=rGBw9sMpTr+wuKH0VkSwGrsToToyYGvf8ggG4l32bF8=;
	h=From:To:Cc:Subject:Date:From;
	b=O1AIoBlZ7+PqHadhmpd3v8rrXrW3BUvY76RgJxvEpgULv6oG7oNAeC7lEN9nuhw8M
	 Rpc38jleGfySsypICCj68/NXYZrVAOUr3FgvHq7zp+n9Q6+uwFHPQ9G8cYZ/gdlf5O
	 sy+k45gQ+s9jT+SqkxxgOtl6sUCVduNgu6W+75iA1eYRy8wKAVpI8pixX6EeUubWj1
	 EVuQV0w8LoitoOrN7aQ9H881I4jdof4hg5/atHr9iNWsb7Jt8dRd+7jmYT8hDJiR2n
	 Kbzsqql+CA2HaPpg+nHC8KkaN4phTBjkvz319iYbBFFch8jEdsf/ljSv+GC4AFEgpX
	 SnyREwZRMxB3g==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0843517E003B;
	Mon, 20 Jul 2026 16:42:47 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: rafael@kernel.org
Cc: daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	p.zabel@pengutronix.de,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	laura.nao@collabora.com,
	fshao@chromium.org,
	wenst@chromium.org,
	jiapeng.chong@linux.alibaba.com,
	frank-w@public-files.de,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] thermal/drivers/mediatek/lvts_thermal: Make reset optional for MT8196
Date: Mon, 20 Jul 2026 16:42:44 +0200
Message-ID: <20260720144244.88877-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Depending on the SoC+Firmware combination, the LVTS hardware may be
may be actively used by one or even multiple concurrent MCUs!
In this case, resetting it may produce either a severe slowdown of
the entire system, or even a thermal protection AP reset, as some
MCU(s) may be reading a very high or very low temperature while the
LVTS is being reset.

On those, don't fail if no reset is found as that may be omitted on
purpose, but still check if there's one, because some board(s) may
be running on a different bootchain with reduced firmwares or using
firmwares with reduced functionality.

Add a new "optional_reset" member to lvts_data and use it to check
whether the resets should be mandatory or not.

Also, while at it, since devm_reset_control_get_by_index() is now
deprecated, change the probe function to instead call function
devm_reset_control_get_exclusive_by_index(), which does the same.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 29 ++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index 92711896ce24..6670b5458f2c 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -160,6 +160,7 @@ struct lvts_data {
 	int gt_calib_bit_offset;
 	unsigned int def_calibration;
 	u16 msr_offset;
+	bool optional_reset;
 };
 
 struct lvts_sensor {
@@ -1473,9 +1474,29 @@ static int lvts_probe(struct platform_device *pdev)
 	if (IS_ERR(lvts_td->base))
 		return dev_err_probe(dev, PTR_ERR(lvts_td->base), "Failed to map io resource\n");
 
-	lvts_td->reset = devm_reset_control_get_by_index(dev, 0);
-	if (IS_ERR(lvts_td->reset))
-		return dev_err_probe(dev, PTR_ERR(lvts_td->reset), "Failed to get reset control\n");
+	/*
+	 * Depending on the SoC+Firmware combination, the LVTS hardware may be
+	 * may be actively used by one or even multiple concurrent MCUs!
+	 * In this case, resetting it may produce either a severe slowdown of
+	 * the entire system, or even a thermal protection AP reset, as some
+	 * MCU(s) may be reading a very high or very low temperature while the
+	 * LVTS is being reset.
+	 *
+	 * On those, don't fail if no reset is found as that may be omitted on
+	 * purpose, but still check if there's one, because some board(s) may
+	 * be running on a different bootchain with reduced firmwares or using
+	 * firmwares with reduced functionality.
+	 */
+	lvts_td->reset = devm_reset_control_get_exclusive_by_index(dev, 0);
+	if (IS_ERR(lvts_td->reset)) {
+		if (lvts_data->optional_reset) {
+			dev_dbg(dev, "No reset found. LVTS may be used by firmware.\n");
+			lvts_td->reset = NULL;
+		} else {
+			return dev_err_probe(dev, PTR_ERR(lvts_td->reset),
+					     "Failed to get reset control\n");
+		}
+	}
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
@@ -2163,6 +2184,7 @@ static const struct lvts_data mt8196_lvts_mcu_data = {
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT8196,
 	.msr_offset = LVTS_MSR_OFFSET_MT8196,
 	.ops = &lvts_platform_ops_mt8196,
+	.optional_reset = true,
 };
 
 static const struct lvts_data mt8196_lvts_ap_data = {
@@ -2175,6 +2197,7 @@ static const struct lvts_data mt8196_lvts_ap_data = {
 	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT8196,
 	.msr_offset = LVTS_MSR_OFFSET_MT8196,
 	.ops = &lvts_platform_ops_mt8196,
+	.optional_reset = true,
 };
 
 static const struct of_device_id lvts_of_match[] = {
-- 
2.55.0

