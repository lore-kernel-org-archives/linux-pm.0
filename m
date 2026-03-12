Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E4A35A3BA;
	Thu, 12 Mar 2026 20:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347510; cv=none; b=Q7X5Vgg+LUI+7ZpT5QijZR+vETNpbXqdaD71zcWeAbO9WMZviEvx0ooMTN/FXscUgBsUqpTFEAEantxryPqKo2LyAyhu3ukNlzzy8DFQwg0x1W3WPZAb07/+M0DNSECbFiZVYWiLSbBYAFMgh7baWNTwxfBIolwEyzKz1dkqFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347510; c=relaxed/simple;
	bh=HOVxutGi4Nn6Bjd8udqFAwrlfi64Wn0LYOV5YekigEs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HAYOQjoA5IXiaPT7vSjPxKSqv3yQaE9wA9TuM7njoXK80Rfew0cVDL0+jFkLuMg7ZI1TJdDNYCUv7S8GAE4DRC4tvWP/jI29WqcvnUa2M6Jd2K6sT1oUD+JQu69XGkRSuFJgsmAP/9BzHzDHfbtFz1FlilrxF4qBUA1neENNpg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=h7QOH/3k; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="h7QOH/3k"
Received: from mxbulk.masterlogin.de (unknown [192.168.10.85])
	by mxout1.routing.net (Postfix) with ESMTP id B171140288;
	Thu, 12 Mar 2026 20:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=routing; t=1773347080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4QtKqKrKXA9mINSd6Rhs9VqIBwngxO4PNYOuvXQmlPU=;
	b=h7QOH/3kOksmM3xBpdfa3Z+KmgGvA09uoldDw407O3IuE3YKf2t61zwpP8tjwsUmijYXjX
	CAxLS80gpKblSFZS5eE6j6YY13MlithH2blXzjDqnZ4N9i+eWDJSTgleIM37edcbqLM33P
	RLqwccn/sRnGhHksz8bzf1emPSuIkX0=
Received: from frank-u24.. (fttx-pool-217.61.148.188.bambit.de [217.61.148.188])
	by mxbulk.masterlogin.de (Postfix) with ESMTPSA id 78AC71226B7;
	Thu, 12 Mar 2026 20:24:40 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	Laura Nao <laura.nao@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v2] thermal/drivers/mediatek/lvts: add missing fields for mt7987
Date: Thu, 12 Mar 2026 21:24:32 +0100
Message-ID: <20260312202433.39092-1-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Wunderlich <frank-w@public-files.de>

Commit a4c40559499f ("thermal/drivers/mediatek/lvts: Add platform ops to
support alternative conversion logic") added new ops field which causes
crash on mt7987.

[    1.518540] Internal error: Oops: 0000000096000005 [#1]  SMP
...
[    1.564481] pc : lvts_get_temp+0x84/0xc4
[    1.564492] lr : lvts_get_temp+0x60/0xc4
...
[    1.620900] Call trace:
[    1.631753]  lvts_get_temp+0x84/0xc4 (P)
[    1.645471]  __thermal_zone_get_temp+0x24/0x11c
[    1.656502]  __thermal_zone_device_update+0x9c/0x52c

Add the new ops member added in 7.0-rc1 for mt7987 too.

Commit 6931d597c5ef ("thermal/drivers/mediatek/lvts: Make number of
calibration offsets configurable") introduced field num_cal_offsets
in lvts_data. Add this for mt7987 too.

Fixes: 78c24e67d6f8 ("thermal/drivers/mediatek/lvts_thermal: Add mt7987 support")
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 drivers/thermal/mediatek/lvts_thermal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index a9617d5e0077..1224ce0c1507 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -2026,6 +2026,8 @@ static const struct lvts_data mt7987_lvts_ap_data = {
 	.temp_offset	= LVTS_COEFF_B_MT7987,
 	.gt_calib_bit_offset = 32,
 	.def_calibration = 19380,
+	.num_cal_offsets = LVTS_NUM_CAL_OFFSETS_MT7988,
+	.ops = &lvts_platform_ops_mt7988,
 };
 
 static const struct lvts_data mt7988_lvts_ap_data = {
-- 
2.43.0

