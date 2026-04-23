Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40783372EC0;
	Thu, 23 Apr 2026 16:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776960491; cv=none; b=RtmWIy8K/z1zwwnS1gWHjnge9ke/DPvsKVeG7bLToBT8rh6SQ19EMeO3sdtOBZH5l+CkS3bnXXVHK/V95vYRdtjYafqmqy/290sx+Hw6tHa0eVOCWsZP+sKvEHcESDpUD5VWDS6ztyUp2tfBaneEYYduFHrj5sFJ7wQiCQ7v4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776960491; c=relaxed/simple;
	bh=BEGT7QGuXKZN1/TyxTNzOGeUptM2L1qa4oyYW8iXDC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CnF/0VZNtNT3d5galykRS2I41ZmAuA5b4dcIvWwFkNqy61eUCOOKXyrfBZxAoH48w95+phuVvCPchNsrr235W8yy4L9UEHHQTa/ZXIqfRC+xFJxvXnp13A6RYAeY9xtBqRnD1RRZJOKA7o5vp3vH1doLE/y3WvHsf+gKGGwJH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjbhVxhm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjbhVxhm"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 023FAC2BCB9;
	Thu, 23 Apr 2026 16:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776960491;
	bh=BEGT7QGuXKZN1/TyxTNzOGeUptM2L1qa4oyYW8iXDC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rjbhVxhmHgVZZjoPWaU7066lR5LruzPiO+4IPp/2qwmj+prtPplgKKJj8YiCmSX2a
	 3OL1fYxmDrvDKxIyZn44A7GqsViQnnLWRFzeHBazFEFnqwWNkOQTdElPSdJWo1zH10
	 mRcJC4n1fQfo7+LuqV1gE5RiJQtqNWqQSL/KuAaBo8WPbBr2W8327lvWcBPGWNyUul
	 p1YXulFSoJ2WtzJBuOdcJHaw1INr3nNlA1KvbBz+mWViCPNhMj1Nt4O/IXOmZpu2wO
	 3lffSGrIIUeLRl2MNfJxA2y/Wy5PkF1a3dAGQSlppD///f+ysgtXGRaLwUfEW8IV3A
	 2BKz4i6tu/BFQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1E7FC0379;
	Thu, 23 Apr 2026 16:08:10 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Thu, 23 Apr 2026 18:07:18 +0200
Subject: [PATCH v4 3/8] firmware: meson: sm: Add thermal calibration SMC
 call
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260423-add-thermal-t7-vim4-v4-3-d4c1528d5044@aliel.fr>
References: <20260423-add-thermal-t7-vim4-v4-0-d4c1528d5044@aliel.fr>
In-Reply-To: <20260423-add-thermal-t7-vim4-v4-0-d4c1528d5044@aliel.fr>
To: Guillaume La Roque <glaroque@baylibre.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2173;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=QVwXg2rjCHDLPb10isf9/q6yv3hIqKAxTDlkEXCyDmk=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+Yr50ez3ocqrml4N/nmpWX9Kounm235ZJE1W8R/g/yVz
 9+qbrM96yhlYRDjYpAVU2Tpn2t54t3lo2e+7lFPgZnDygQyhIGLUwAmwveT4Q/fab/4TS2sBd8s
 NJ/oL+ifJtSyX/VCksC0MoFnaSFn5r1iZDht8M7A+sa09S/LE3WnX2Ndpp8o1merKZ+XeMSy5YJ
 aITcA
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

Add SM_THERMAL_CALIB_READ at SMC ID 0x82000047 in the command
table and implement meson_sm_get_thermal_calib(), which forwards the
tsensor_id argument to the secure monitor and returns the calibration data.

Also realign the CMD() column to improve readability.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 drivers/firmware/meson/meson_sm.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 3ab67aaa9e5da..4e57986724212 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -41,12 +41,13 @@ static const struct meson_sm_chip gxbb_chip = {
 	.cmd_shmem_in_base	= 0x82000020,
 	.cmd_shmem_out_base	= 0x82000021,
 	.cmd = {
-		CMD(SM_EFUSE_READ,	0x82000030),
-		CMD(SM_EFUSE_WRITE,	0x82000031),
+		CMD(SM_EFUSE_READ,		0x82000030),
+		CMD(SM_EFUSE_WRITE,		0x82000031),
 		CMD(SM_EFUSE_USER_MAX,	0x82000033),
-		CMD(SM_GET_CHIP_ID,	0x82000044),
-		CMD(SM_A1_PWRC_SET,	0x82000093),
-		CMD(SM_A1_PWRC_GET,	0x82000095),
+		CMD(SM_GET_CHIP_ID,		0x82000044),
+		CMD(SM_THERMAL_CALIB_READ,	0x82000047),
+		CMD(SM_A1_PWRC_SET,		0x82000093),
+		CMD(SM_A1_PWRC_GET,		0x82000095),
 		{ /* sentinel */ },
 	},
 };
@@ -245,6 +246,24 @@ struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
 }
 EXPORT_SYMBOL_GPL(meson_sm_get);
 
+/**
+ *
+ * meson_sm_get_thermal_calib - Read thermal sensor calibration data.
+ * @fw:		Pointer to secure-monitor firmware.
+ * @trim_info:	Pointer to store the returned calibration data.
+ * @tsensor_id:	Sensor index to identify which sensor's calibration data
+ *		to retrieve
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
+			       u32 tsensor_id)
+{
+	return meson_sm_call(fw, SM_THERMAL_CALIB_READ, trim_info, tsensor_id,
+			     0, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(meson_sm_get_thermal_calib);
+
 #define SM_CHIP_ID_LENGTH	119
 #define SM_CHIP_ID_OFFSET	4
 #define SM_CHIP_ID_SIZE		12

-- 
2.49.0


