Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769A1385D8E;
	Sat, 30 May 2026 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780124807; cv=none; b=Rt3lSmeyB7GpD8RZ2X9MoMMQHlHgdQOf2tRR9YMkRyqwYAj0xVbZwkjBs09wTNGEke7MP/AHEWq6EOg+qsPpMSfC9T1asy8hsYfdW/OPs33Y9zw3yv70SnSxe4txjrbhF0VZrNIlWqhKNTkiZmEsVdBqvqbgxai4l12M3xofAJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780124807; c=relaxed/simple;
	bh=5HNG54dPBxmmIkxBE1FpYE/o9KMljPg2ln/nqNqBMiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uAh0FGAeuMUiX0okaONp/zc9ShBR3UgRqiJ4cCJlaqNfLVeR4BJ/LjqleAEDQifL26pCzuT+7qjVY5V5vwqC0SjpV4t7EqGo5lnXN1RdFqozrthEqN3Gb93tM2EMctvF3fIjL6vPsw7G8fvVk46ASmv9a6zr/VCq0S4av6CP30c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1HVgV2Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1HVgV2Q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7E01C19425;
	Sat, 30 May 2026 07:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780124807;
	bh=5HNG54dPBxmmIkxBE1FpYE/o9KMljPg2ln/nqNqBMiY=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=q1HVgV2Q066uy00q74VJPuVTVte5iYvwQUJdmTB2N7as/zY/0SCJDcc6leN0bE6TQ
	 0rd1mrf8vYxfpJBcTLaaEPzYNN9QF19W1H8Jz8SBAcc6inKs0mIFwIhrOI2+3Wkhkl
	 bAzvoZYPU64++0lvVWgBskr1Gemmjwh1WraBfZ2AoJRTzhCfTjSljrRivJAIm2advv
	 DdKlbAZocRXU2RVKvNKNCROT4prY9ApKrShEZrkxLJDD2v21Ko4xETApm756aUqk2T
	 l0UvA6ne2kbt+EeFSb+Mo4MfwO/LdmfLQ8Fz7OifzDq8VwGbg94afU2ExxRuC5gqzt
	 7Hh7DNKNe9gdg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E4ECD4F54;
	Sat, 30 May 2026 07:06:46 +0000 (UTC)
From: Ronald Claveau via B4 Relay <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Sat, 30 May 2026 09:05:57 +0200
Subject: [PATCH] firmware: meson: sm: add stub functions when
 CONFIG_MESON_SM is disabled
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260530-fix-missing-meson_sm-symbol-v1-1-3fb672b989d4@aliel.fr>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3M0QpAMBSA4VfRuXZqVrZ4FUnYwSnbtFMieXfL5
 Vd//wNCiUmgLR5IdLJwDBlVWcC8jWElZJcNWmmjat3gwhd6FuGwoieJYRCPcvsp7mitNU65xlm
 jIB+ORDn/713/vh+4IbHLbQAAAA==
X-Change-ID: 20260529-fix-missing-meson_sm-symbol-7776d0d9d760
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Cc: Guillaume La Roque <glaroque@baylibre.com>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, Ronald Claveau <linux-kernel-dev@aliel.fr>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2190;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=9bC21YQnPxgGtSXVEFJabEi6tIt8Ai/WeaIfr6J2d/Q=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQ5ZUT5nA3z2OrJe9ZwYLTfr6ViGqZJ7CyVPVm2zvevK4T
 4ic5n2go5SFQYyLQVZMkaV/ruWJd5ePnvm6Rz0FZg4rE8gQBi5OAZhIgxgjw/fgkB1dR1beYNyR
 UPFhTUdUUsRmsdIPSyZ8Z1biO7vDrYiRYdaCuRtzbG7OK9J4Ivw0wyDg+KwERsmG8ANcFrd6M4S
 VGQA=
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Reply-To: linux-kernel-dev@aliel.fr

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

After merging the thermal tree, linux-next build (arm_multi_v7
defconfig) failed like this:

arm-linux-gnueabihf-ld: drivers/thermal/amlogic_thermal.o: in function `amlogic_thermal_probe_sm':
/tmp/next/build/drivers/thermal/amlogic_thermal.c:196:(.text+0x2f4): undefined reference to `meson_sm_get'
arm-linux-gnueabihf-ld: /tmp/next/build/drivers/thermal/amlogic_thermal.c:205:(.text+0x320): undefined reference to `meson_sm_get_thermal_calib'

Add inline stub implementations of meson_sm_get() and
meson_sm_get_thermal_calib() behind an #else guard so that drivers
including this header can be compiled without CONFIG_MESON_SM .

Fixes: b21d88de6918 ("thermal/drivers/amlogic: Add support for secure monitor calibration readout")
Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 include/linux/firmware/meson/meson_sm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index 3ebc2bd9a9760..813166ccedd1d 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -27,8 +27,25 @@ int meson_sm_call_write(struct meson_sm_firmware *fw, void *buffer,
 int meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
 		       unsigned int bsize, unsigned int cmd_index, u32 arg0,
 		       u32 arg1, u32 arg2, u32 arg3, u32 arg4);
+
+#ifdef CONFIG_MESON_SM
+
 struct meson_sm_firmware *meson_sm_get(struct device_node *firmware_node);
 int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
 			       u32 tsensor_id);
 
+#else
+
+static inline struct meson_sm_firmware *meson_sm_get(struct device_node *firmware_node)
+{
+	return NULL;
+}
+static inline int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw,
+					     u32 *trim_info, u32 tsensor_id)
+{
+	return -EINVAL;
+}
+
+#endif
+
 #endif /* _MESON_SM_FW_H_ */

---
base-commit: 3929405c64376a8a54c794e8a4485023b108a97e
change-id: 20260529-fix-missing-meson_sm-symbol-7776d0d9d760

Best regards,
-- 
Ronald Claveau <linux-kernel-dev@aliel.fr>


