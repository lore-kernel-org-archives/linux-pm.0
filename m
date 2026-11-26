Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795654415;
	b=NMT1UzdXVzB2y84hVf3O5vTVCJcuIVVoVEXgE+Ei23CAmpYMZ7U0T0y/iCgshjZKXjA/
	 u0EftkwOrKQbQ2Q4ALa9/7TUvgUFAdy56SRnpuHQ6UShF+BOfx9RZrLKyZ19s/fvhhdkQ
	 MaSRat+147dFSH8TUnEvgAbJilZT1HUtsbADJcSVM82c3dgp35sCSYEVQ//fM2H0i9/mu
	 h0J7EeTnzMAsMeFWa8YjtbrhpUuSnA7UDZRFWcGoEHn+HkimhL4kOeq6cFNJaJZYg6Ad0
	 Nwu3J0NmjY0fs/s2jBZK6A9W9EkCFWecWY5AbiCCClo+g1qWxOgIfMhfh1OCaF++viw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795654415;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e3GFvodZKb6NEBDMDdPL8w7ibtYBo+PSh4w+1SwCVaQ=;
	b=ey1TrgZxr6KQtvD/d4PSe7suk+clUXoUR8f1PiSxCLtjns7apjEaxgxBPa5q+BjoQdtP
	 cnKQfbApIqa7Sk2uaBIh7dH/oPvA/u7mAYO2Uy10lOKOzXMC4oH0b9BZGSLVgbC+El73v
	 iHZorbq2hkYZCBL5o2aiCbE4BHhQwMsw5+x/ELGmikzjO8weriybQOrEVpjD7wEr/UnjT
	 2pCdfdzRom5JQkuCRTKkBdeWSxZtO4hwf1DofJUBnuuJK2SjxbhrFdKb0VXikPOCqJick
	 wAzB4gE9o4kzliOkdNUwzGk3D19QuPWW4P9RFZtLhw+pSNyx7/hpYRHREGCBONY6dyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjOZ6qCc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345F8606A327;
	Thu, 26 Nov 2026 00:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kjOZ6qCc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795654414;
	b=Vre5Ww9NCVttci1Tuc8POI0yXmp2DdKqXIbEsqWjf5cex/tCqCJwEV2vPwW8OL9Ngk9A
	 hadgcKWGCnm9iK2/seZfpeaVz7oA8puTxQRKit0HQTGP9e++Bjl2hmGRoYigi8wleMn1h
	 WXWqaV9dfmvJQSMUpylc1jLrmvX1XCWH/WO3E9nVs0cDQsN2Q2ZuK8r7jkYjF+aFeThg9
	 +WhgE/YBmARX7ZBSwcTRDuuvF/d3ZogdyCR+zUPR/N3Glq+rBXGTIugQ7jv0ngkrDPCLd
	 yFWbXV+ABCLrUPeBADPIr4c825D6M2iBqPe5LxFzKd0eGVCVAFFFyFzooWLUxMrc3Hw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795654414;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:MIME-Version:Content-Type:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=e3GFvodZKb6NEBDMDdPL8w7ibtYBo+PSh4w+1SwCVaQ=;
	b=TtriifcolMv3VUlWWR5dNVXEygZiEEQYz4hgRTN+wKHX0asY2MTMnBPJkSiSpJ+GMyx7
	 q2HpCh62t4DG7gCaAt2EjTBDnmOPjisfmzsVlt2FHDH5XmKrzPPgi0r5OU11Flo0mMdqc
	 L6FECeCO8Rc6xh+7Fr4qkpLV/AWjNKJT0EiLF8FiDg1RWaWZVrYf1uho/HA8wmy41gvkT
	 MRrz5z0hDKNG/0bmZmeh6uyXGKdwPj8BRxqFH/QL88lW9Jiq4C606B77P199WSvznaT+c
	 e6qk8Skwp4FqqLJhV7OjKcGPWUYHxMUJJKtDBSWCgeTNUaB7GQEpn/nIxpyULUkKvKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A16A21F000CA;
	Thu, 26 Nov 2026 00:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795654414;
	bh=e3GFvodZKb6NEBDMDdPL8w7ibtYBo+PSh4w+1SwCVaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
	b=kjOZ6qCc2fXWK0ACNZ9th5rhHTqmYpMU0Z8OWNixfPi/lrtFGosQDBX0jNNs0kw+H
	 c0F6mjLS3xa6zfcjLHkj+wNIdv8z70VedokJkel2k+y1uLWO81j0hjgXiejd5bAa3F
	 M/uNnfdNugmwHKJLkrX762ab6U6Hv1hDPKfR0MBtaMKYfdfpKeMsmBrpL5DGzb+zEE
	 i683avrpkgGLvYsjT68J3UsMt0CIFgKe9Tl/aAVpyR2/1eCmvBIE9fmOSn9TbyDHq2
	 syQ3erITGiFQUtEF73Xr0Y4JwXZ/sBW+xWnzJYESxp1eolJht+FhGBw5nLRqrFlU8z
	 3PE2e5x4ZIjeA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 292D84D138;
	Thu, 26 Nov 2026 00:53:23 +0000 (UTC)
From: Ilia Snezhkov via B4 Relay <devnull+iasnezhkov.gmail.com@kernel.org>
To: daniel.lezcano@linaro.org, rafael@kernel.org, rui.zhang@intel.com, 
 lukasz.luba@arm.com
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-pm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] thermal/drivers/mediatek/lvts_thermal: avoid 32-bit
 overflow in lvts_temp_to_raw_mt7988() and INT_MAX trips
Date: Thu, 26 Nov 2026 00:53:23 +0000
Message-Id: <20261126005321.71799-3-iasnezhkov@gmail.com>
In-Reply-To: <20261126005321.71799-1-iasnezhkov@gmail.com>
References: <20261126005321.71799-1-iasnezhkov@gmail.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795654401; l=3303;
 i=iasnezhkov@gmail.com; s=mindone2026; h=from:subject:message-id;
 bh=psSr6KJdwfmb1wfsBNafw8vECeQMBdTkcT5VL1q598A=;
 b=AYmY1cNYhCNMV/zdOV2u3nU5P6SKNRf55XL2K3+T/JDXQRWC0haRg/IFRwRaNwZVRRyD59tf/
 F0l9FwfIjHABLyOW8s1+3hnNHD8yHAPRJd+fXU4gXm55p8Spys1p6dT
X-Developer-Key: i=iasnezhkov@gmail.com; a=ed25519;
 pk=hQgXfiWi4ukk2jh4BHu1vRVhg9BUivo//AFp50AKMag=
X-Endpoint-Received: by B4 Relay for iasnezhkov@gmail.com/mindone2026 with
 auth_id=1643
X-Original-From: Ilia Snezhkov <iasnezhkov@gmail.com>
Reply-To: iasnezhkov@gmail.com
Content-Transfer-Encoding: 7bit

From: Ilia Snezhkov <iasnezhkov@gmail.com>

lvts_temp_to_raw_mt7988() subtracts two 32-bit ints before casting to
s64, shifts left by 14 bits, and immediately truncates the result to a
u32 before passing it to div_s64().

When golden_temp_offset - temperature >= 262144 (for example,
golden_temp = 60, temp_offset = 250460, temperature < 18316 mC, or even
LVTS_MINIMUM_THRESHOLD = 20000 mC when golden_temp >= 64), the shifted
value exceeds U32_MAX and silently wraps modulo 2^32, programming a
bogus low raw value (high temperature) into LVTS_OFFSETL/LVTS_OFFSETH.

In addition, lvts_set_trips() passes high == INT_MAX (used by the
thermal core when no upper trip exists) directly to lvts_temp_to_raw(),
which produces a negative quotient cast to u32 while leaving the sensor's
high-offset interrupt enabled.

Promote golden_temp_offset to s64 before subtracting, keep the shifted
numerator in s64, clamp negative results to 0, avoid converting
high == INT_MAX in lvts_set_trips(), and mask high_offset_inten when
high_thresh == INT_MAX.

Found and drafted with an AI coding assistant.

Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
Fixes: 2bba1acf7a4c ("thermal/drivers/mediatek/lvts_thermal: Manage threshold between sensors")
Signed-off-by: Ilia Snezhkov <iasnezhkov@gmail.com>
---
 drivers/thermal/mediatek/lvts_thermal.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
index e034c6c..9b8b653 100644
--- a/drivers/thermal/mediatek/lvts_thermal.c
+++ b/drivers/thermal/mediatek/lvts_thermal.c
@@ -322,11 +322,11 @@ static int lvts_raw_to_temp_mt7988(u32 raw_temp, int temp_factor)
 
 static u32 lvts_temp_to_raw_mt7988(int temperature, int temp_factor)
 {
-	u32 raw_temp = ((s64)(golden_temp_offset - temperature)) << 14;
+	s64 raw_temp = ((s64)golden_temp_offset - temperature) << 14;
 
 	raw_temp = div_s64(raw_temp, -temp_factor);
 
-	return raw_temp;
+	return raw_temp < 0 ? 0 : (u32)raw_temp;
 }
 
 static u32 lvts_temp_to_raw_mt8196(int temperature, int temp_factor)
@@ -409,12 +409,15 @@ static void lvts_update_irq_mask(struct lvts_ctrl *lvts_ctrl)
 			 * don't actually want to generate interrupts when
 			 * crossing it.
 			 */
-			if (lvts_ctrl->low_thresh == -INT_MAX) {
+			if (lvts_ctrl->low_thresh == -INT_MAX)
 				value &= ~low_offset_inten_masks[i];
+			else
+				value |= low_offset_inten_masks[i];
+
+			if (lvts_ctrl->high_thresh == INT_MAX)
+				value &= ~high_offset_inten_masks[i];
+			else
 				value |= high_offset_inten_masks[i];
-			} else {
-				value |= low_offset_inten_masks[i] | high_offset_inten_masks[i];
-			}
 		} else {
 			value &= ~(low_offset_inten_masks[i] | high_offset_inten_masks[i]);
 		}
@@ -447,7 +450,7 @@ static int lvts_set_trips(struct thermal_zone_device *tz, int low, int high)
 	void __iomem *base = lvts_sensor->base;
 	u32 raw_low = lvts_temp_to_raw(low != -INT_MAX ? low : LVTS_MINIMUM_THRESHOLD,
 				       lvts_data);
-	u32 raw_high = lvts_temp_to_raw(high, lvts_data);
+	u32 raw_high = high != INT_MAX ? lvts_temp_to_raw(high, lvts_data) : 0;
 	bool should_update_thresh;
 
 	lvts_sensor->low_thresh = low;
-- 
2.54.0 (Apple Git-157)



