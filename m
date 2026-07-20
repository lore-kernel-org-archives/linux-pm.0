Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBD9279358;
	Mon, 20 Jul 2026 02:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784513989; cv=none; b=KqCSAzYOjnNT9mHFd7+SSSqh6liamSxBuOgdm8VIX54jOsQ+rLrJ/T/2REMOEJulIYdqps2ffdXL5WbTvklxOpZobEUPPZxGAhx7bOnDvno1Ff701sGJFQo9gYAGCf27MbHIiOk/Gs6ANueAVJ9CMqNUR3zfjsKHAIpnDmfOFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784513989; c=relaxed/simple;
	bh=VRTtWR3D6S0wEB2rt3tQ/Ck5VjGJQGbVpwn8H1hxXWA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KzPPoAn7M7eHhA47blbKU00bXjwx6hya9mR8B97Ep5u1eziE/RQTYcFUihyGrPpZseU3tv/dzxlKNx7T+3jpvxtw2P1MXhvYFtZW08ITkTjClB4EwjzWWcI6UPWr7KZBDNqtaZd5Xa8zpDpc188936TdywYW+ndFCgKWiCtqRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXdvr+xc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXdvr+xc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B193C19425;
	Mon, 20 Jul 2026 02:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784513989;
	bh=VRTtWR3D6S0wEB2rt3tQ/Ck5VjGJQGbVpwn8H1hxXWA=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tXdvr+xcjXqEhVUWcTSMr6NXTXM4UvJMRxjp/dMT41onjaRoxErzbOIT003Ywe2lP
	 LBy4PYSV8h0x0j8xCdh+vKcZULnklyMoXIs7RXclZ/aOwFZhI75ddrZwsRCU4AbFRy
	 E2NVPbvsuumXynt6Xbp7WvA58YFENguZ0PqEyYWBhPW5mPaYxMaM/DuKpr/yv4SnAc
	 MjOSA7syNE2sf/Gp2f4yWWiphguaTKc/VuiBkwjIkEiNM8fjn/Ul25iZCqKPUkJt9z
	 CB4sdL7Q4s3lskk7ii4Rj2o1TaVS5vOrZv+L7jZgE7c2/CzzlNDA3cnblmfU/Hic3E
	 nFY5iqzkrjtpA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C8CC44521;
	Mon, 20 Jul 2026 02:19:48 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Subject: [PATCH v10 0/3] thermal: imx: Add calibration offset support
Date: Mon, 20 Jul 2026 10:19:39 +0800
Message-Id: <20260720-b4-symana21-11221-imx-thermal-support-upstream-6-18-v10-0-f8c3dcd9a57e@cn.bosch.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALuFXWoC/63SS27DIBAG4KtUrEsEmGdXvUfVBeChpqofAsdKF
 OXuxcnGqli53iANGvGNhv+GMqQIGb293FCCJeY4DqWg5PUF+c4OX4BjWy4QI0wSRQx2HOdrbwf
 LKKaUlTP2Fzx3kHr7g/N5msY04/OU5wS2xxJTjS3R3GjeglMSlZenBCFeHuzH57POZ/cNfl6pt
 aOLeR7T9THXQte+/02wUEwwIUHrwJlpiHv3w8mN2XcnP/ZoHWJhBzDsyQTFuBHAeIVpNgwl+5i
 mMK0zwTPDlReiwvADGF4YGiAY1VKvBKkwYss0+xhRGGk4Eb4h0sva38gDGFkYrW2jdLDgbW1p6
 gBGrREwTpasS+OAVhi9Zfg+Rq8RELzV0hCgEiqM2TJqH2MKo0TgNmijePgb6Pv9/gvOBVouRAQ
 AAA==
X-Change-ID: 20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-a084984deb76
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Haoning CHENG <Haoning.CHENG@cn.bosch.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784513984; l=6776;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=VRTtWR3D6S0wEB2rt3tQ/Ck5VjGJQGbVpwn8H1hxXWA=;
 b=4WSuXv6K+DKOkR4rqdXDKQsnhVIE0UCOQUYAwYZsdQ+xnBBbzP1PUA76f+ydL2TTL+LfXpj/8
 3GvqlSkhw0VDfHMuBqsy29eZrj7FxR/SnOU2yC/5L2Ge2yL+cyZhnLp
X-Developer-Key: i=Haoning.CHENG@cn.bosch.com; a=ed25519;
 pk=glQGwad/fosRS5gZUJYbLDPPLGe7rFTrTV2VxY/ySdc=
X-Endpoint-Received: by B4 Relay for Haoning.CHENG@cn.bosch.com/20260709
 with auth_id=860
X-Original-From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
Reply-To: Haoning.CHENG@cn.bosch.com

The TEMPMON sensor reading may deviate from the theoretical SoC
junction temperature even at the die level, before any board
influence. This series adds an optional DT property to specify a
calibration offset and implements the corresponding support in the
imx_thermal driver.

Patch 1 documents the new fsl,temp-calibration-offset-millicelsius
property in the i.MX thermal DT binding. The offset is determined
through thermal characterization by comparing the sensor output
against the calculated junction temperature, and is limited to
±20 °C.

Patch 2 fixes the i.MX7D alarm temperature conversion to use
ceiling division (DIV_ROUND_UP() for non-negative, plain /
for negative) and clamp() to stay within the 9-bit register range.

Patch 3 reads this property in the imx_thermal driver and applies
the offset symmetrically: it is added when reporting temperature to
the thermal framework and subtracted when programming hardware alarm
thresholds (to keep trip point semantics consistent). Out-of-range
values are rejected with -EINVAL at probe time. When the property
is absent, the default offset is 0.

Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
---
Changes in v10:
- Rephrase the series to describe the offset as sensor calibration
  toward the theoretical junction temperature, reverting the v9
  terminology that characterized it as a board-specific die-to-package-
  surface conversion. Hardware characterization confirmed the deviation
  exists at the die level, independent of board influence.
- dt-bindings: update the property description to state the offset
  corrects the TEMPMON sensor reading toward the theoretical junction
  temperature
- driver commit message: replace package-surface estimate wording with
  calibrated correction toward junction temperature
- Link to v9: https://patch.msgid.link/20260717-b4-symana21-11221-imx-thermal-support-upstream-6-18-v9-0-75f4af8974f4@cn.bosch.com

Changes in v9:
- Rephrase the series to clarify that the offset converts the internal
  TEMPMON reading to a package-surface temperature estimate, rather than
  calibrating the sensor for better die temperature accuracy (Frieder)
- dt-bindings: update the property description to explicitly state it is
  a board-specific conversion offset, not a sensor calibration
- driver commit message: distinguish die temperature from package-surface
  temperature in the symmetric offset mechanism explanation
- Pick up Reviewed-by tags from Frank Li (patches 2,3) and Lukasz Luba
  (patches 1,2,3)
- Link to v8: https://patch.msgid.link/20260714-b4-symana21-11221-imx-thermal-support-upstream-6-18-v8-0-d54d8690e16e@cn.bosch.com

Changes in v8:
- binding: s/behaviour/behavior/ (Lukasz)
- New prep patch: use ceiling division (DIV_ROUND_UP() for non-negative, plain /
  for negative) and clamp() for i.MX7D, extracted into a separate patch (Frank)
- driver commit message: add offset mechanism explanation with a +3000 m°C calculation example (Lukasz)
- probe: reject out-of-range offset with -EINVAL instead of silently clamping (Lukasz)
- prep patch: handle negative alarm_temp with plain division (C rounds toward zero)
- Link to v7: https://patch.msgid.link/20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v7-0-09b6b7669be1@cn.bosch.com

Changes in v7:
- Align the author name with the Signed-off-by trailer.
- Link to v6: https://patch.msgid.link/20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v6-0-88a378faeca5@cn.bosch.com

Changes in v6:
- Align the author name with the Signed-off-by trailer.
- Link to v5: https://patch.msgid.link/20260713-b4-symana21-11221-imx-thermal-support-upstream-6-18-v5-0-69405c306c6b@cn.bosch.com

Changes in v5:
- Move calibration offset application out of c2 initialization, instead
  apply it in imx_get_temp(), imx_set_alarm_temp() and imx_set_panic_temp()
  for consistent style across i.MX6 and i.MX7D
- Subtract calibration offset from alarm_temp before the if-else block in
  imx_set_alarm_temp(), simplifying both SoC branches (Frank's suggestion)
- Link to v4: https://patch.msgid.link/20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v4-0-1fef97d1c750@cn.bosch.com

Changes in v4:
- dt-bindings: drop maxItems to allow minimum/maximum constraints for
  temp-calibration-offset-millicelsius
- Link to v3: https://patch.msgid.link/20260710-b4-symana21-11221-imx-thermal-support-upstream-6-18-v3-0-db9fc2947c55@cn.bosch.com

Changes in v3:
- dt-bindings: add minimum/maximum (-28580/+28580) for
  temp-calibration-offset-millicelsius, as suggested by Conor Dooley
- Link to v2: https://patch.msgid.link/20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-0-00ff72495e24@cn.bosch.com

Changes in v2:
- dt-bindings: Removed explicit `$ref: /schemas/types.yaml#/definitions/int32`
  for fsl,temp-calibration-offset-millicelsius; the `-millicelsius` suffix
  already resolves to int32-array via property-units.yaml (Rob).
- dt-bindings: Fixed example indentation.
- driver: Replaced C integer division (/) with DIV_ROUND_CLOSEST() in
  imx_set_alarm_temp() to prevent off-by-one alarm threshold mismatch that
  could cause IRQ storms on i.MX7D.
- driver: Added clamp() bounds check for alarm_value [0, 0x1ff] to avoid
  corrupting adjacent register fields (PANIC_ALARM).
- Link to v1: https://patch.msgid.link/20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v1-0-00f88f42930b@cn.bosch.com

To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Zhang Rui <rui.zhang@intel.com>
To: Lukasz Luba <lukasz.luba@arm.com>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Shawn Guo <shawnguo@kernel.org>
To: Sascha Hauer <s.hauer@pengutronix.de>
To: Pengutronix Kernel Team <kernel@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org

---
Haoning CHENG (3):
      dt-bindings: thermal: imx: Document calibration offset property
      thermal/drivers/imx: Fix rounding and clamp for i.MX7D alarm
      thermal/drivers/imx: Add calibration offset support

 .../devicetree/bindings/thermal/imx-thermal.yaml   | 12 +++++++
 drivers/thermal/imx_thermal.c                      | 39 ++++++++++++++++++++--
 2 files changed, 48 insertions(+), 3 deletions(-)
---
base-commit: c50a940dcde35c647e097e89a9150003abd48329
change-id: 20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-a084984deb76

Best regards,
--  
Haoning Cheng <Haoning.CHENG@cn.bosch.com>


