Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E5E331A41;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045656; cv=none; b=Vrt1RT62uwl7R0NUntbX/tbdouF/udaUrxL6pY7VL1eneXK3eTl9i2hPWOflbDirJTXhBPdRwYtKixePXfPCMEE22nrYJQg4xd/OqiQef54RaORuEqW/KrY2icnzcI7nJBSUTUZnOIDGBRfe7oT2PwpwjJCdkLQXSPOmsNWQUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045656; c=relaxed/simple;
	bh=pPT6y+8yDPk/GQWT/vdcn7MpQPzpLNFYEE57p+hOukM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ae/yxszJSj+paL7lVmjRblYHbyUAbbsapre8GyeaVmCHcc0JILzuXh4ukwD9t6V/shpuRd7Yhkxzbw6lTfFwREfWkLunpPLvpW4zlH58ZiIlNSOTN/DK9TulAeNUO3iPbUOe+dzx9kTJz2y7uWu2Tn3lcEf221MrU00gKdp7dmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s1aHISig; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s1aHISig"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04C28C2BCB5;
	Fri, 24 Apr 2026 15:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777045656;
	bh=pPT6y+8yDPk/GQWT/vdcn7MpQPzpLNFYEE57p+hOukM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=s1aHISigFggsjfoyCnx37nWoDwIVBc1j7TebZVO6k8YgUJ3QlF6dO6gQAXnNBG0OW
	 owHjme2YWGUt7KvLbDtiaEhuDB+qntQReflVn1N1VLfPtpL4bQ8Tkfx5OAqer1rzHe
	 +ZL67/nHgUkd6/Al7JRpKN/1UKhGMLGZzz3LZoy3samPIzGOZc6hgqKWGNUvNQaaVe
	 Xkz2yfnWvGAzuMpAWPDeLoIlelWxiYjFOlRuJsDhl3ZCScFuLXpN6fuzmiIE7xOXvd
	 nsQg9xjn7C7dhISIngiopQRFILSmJOI+T5Jg4PLpe6aejbR+SwmK3hj6M32oC8xGmE
	 vuPu0YknMCYHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE69FED3D7;
	Fri, 24 Apr 2026 15:47:35 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Fri, 24 Apr 2026 17:45:11 +0200
Subject: [PATCH v5 3/8] firmware: meson: sm: Add thermal calibration SMC
 call
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-add-thermal-t7-vim4-v5-3-9040ca36afe2@aliel.fr>
References: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
In-Reply-To: <20260424-add-thermal-t7-vim4-v5-0-9040ca36afe2@aliel.fr>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=RboCfSHgRjly95YryQzSIFxNo4U3Gmip5nVqLI2kBVY=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ+brCb39+xXWvBRoN724JWn9M+Yq+1T7lPQCKa7zpWYac
 orZ7zd2lLIwiHExyIopsvTPtTzx7vLRM1/3qKfAzGFlAhnCwMUpABMxOMnI8HiaCpPSvq5FhXwO
 /kbKTcIHwtxPhxQkC1dmSO3gerJvKiPDEimXlqdSP2qnufzbvTYg4uvq6DkbebYv3MXGJbRs7o9
 OJgA=
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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


