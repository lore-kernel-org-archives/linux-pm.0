Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40242E8FA;
	Fri, 16 Oct 2026 07:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792136603; cv=none; b=Nbyt88eCpQUnqAPcuyzedJEoe2CK6FthhtMkuwaVgohdJdY13Gw4DOiFJ+uGhl6xHtQ8GhSia21f3GCLgbvBno9QUQ82X3EV9N2vTzeMBsfCKuBgTjoqLdf9h5zZ3kT2gytLOIF0zBVDcsvyuQEZ7/U3jW06zCx6Yq3DraYVq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792136603; c=relaxed/simple;
	bh=q8QMU2g/5rxzERHN7LI3nwwsBxoze8z/SfHcGmxNnh0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=s2TmOoBEBLoZ6YGulIC/2kUBtIWSW+FESkZACQGAbYGqiyXvG3CPULsjwSu5trNvS0APTkofoQZN9BTmSZFAmoiT3E+qlkJjwR2FsJOhjEqxyMIFb74vBini7osvBb78hfVWZZAZPVclk0ElsH06j6eA7lD52WuUGTrnygHrlWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rEs2Uoe4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEs2Uoe4"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C8BBC2BCF4;
	Fri, 16 Oct 2026 07:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792136602;
	bh=q8QMU2g/5rxzERHN7LI3nwwsBxoze8z/SfHcGmxNnh0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=rEs2Uoe4LIYA1xAIfnDcNGymY71RX5okyxRWmQwx3g7KD65ve7kDOfhebnJcNl1FU
	 0juE32ehlgRFM1njeVtheUTVn7hKzfiqPxp/effvSQS23NbaelYfTuZpmztkNKxKU+
	 0iu5eBcMXZ4HATG9UJJM8zoJg2a6XJv2JjK5rKk44k60KaNKXJH//VlBSZnTm21O3n
	 T9gcUkJBAHfkrb4hLc0My7tFHcMw+CXO4+RDJZ2LylgwvJ3qorlIL76TJA/JYRox8z
	 pbvw2gsHVoZyiljief91wcv9PapO1CggzOi2EaqNXFofzMNnVPfmRoGop/N7vJGcMP
	 HZXTl316POr0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FA9CCA464;
	Fri, 16 Oct 2026 07:43:22 +0000 (UTC)
From: Haoning CHENG via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Subject: [PATCH RESEND v11 0/3] thermal: imx: Add calibration offset
 support
Date: Fri, 16 Oct 2026 15:43:17 +0800
Message-Id: <20261016-b4-symana21-11221-imx-thermal-support-upstream-6-18-v11-0-b80952ad27d6@cn.bosch.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792136598; l=7208;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=q8QMU2g/5rxzERHN7LI3nwwsBxoze8z/SfHcGmxNnh0=;
 b=f8P8IxutGqzvXkCQeSo8Aw7wZw9ob5Wj1VTpJ55ru1Q0rqQjav8jiufy/YhFfGs3JZmj8S1WX
 QvRJ/QoInmwDjEHlPR0wrce3G1GLWcSoN2AFy1axDLlqaiE4r+sozhA
X-Developer-Key: i=Haoning.CHENG@cn.bosch.com; a=ed25519;
 pk=glQGwad/fosRS5gZUJYbLDPPLGe7rFTrTV2VxY/ySdc=
X-Endpoint-Received: by B4 Relay for Haoning.CHENG@cn.bosch.com/20260709
 with auth_id=860
X-Original-From: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
Reply-To: Haoning.CHENG@cn.bosch.com

The TEMPMON sensor reading may deviate from the theoretical SoC
junction temperature. This series adds an optional DT property to
specify a calibration offset and implements the corresponding
support in the imx_thermal driver.

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
Changes in v11:
- Cover letter and patch 3: removed the claim that the TEMPMON sensor
  deviation exists "at the die level without board influence". The
  commit messages now describe what the offset does without speculating
  on the origin of the residual error.
- No code or binding changes.
- Link to v10: https://patch.msgid.link/20260720-b4-symana21-11221-imx-thermal-support-upstream-6-18-v10-0-f8c3dcd9a57e@cn.bosch.com

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
-- 
Haoning Cheng <Haoning.CHENG@cn.bosch.com>


