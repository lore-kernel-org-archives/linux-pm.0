Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717BD3E44EB;
	Thu,  9 Jul 2026 08:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584628; cv=none; b=b+kpuh+LotusegP1h2ZSMoAuiZ//+dr/Qe6VWDU994RtD/qAZBXTW9gz8fv1nw1Z1vt9rzTz6IYZ4bkIrhJsXY6QA7Tv/oCmwL4Y3iwhfSxdpAwc8y48aCyXyLb0HRMQoIp0uKTXoIxmiR9rW0Ye0TG1+uXnrX0mUFEGauYx4RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584628; c=relaxed/simple;
	bh=Ed32Ov8Wnno8739CLzEbPeqoJp38IFrosMVh+VgXch8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZmTFMIsW8F/tdpZc98XNHpnsYct8wEddnTYkqhlLm2IG9PuFVcZa0xItH0d/5DvnL8TO9YvHqdrEADkrW+pSj1UgjixaCl/ro2nPxXLl8Pz8vHRpjamlXNhglJwIiy8M678QoohWLGMwky3Jl6jC+pfdlem0v4ZAkxEZBXn/sTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isKz1Yr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isKz1Yr1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2334FC2BCB7;
	Thu,  9 Jul 2026 08:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783584628;
	bh=Ed32Ov8Wnno8739CLzEbPeqoJp38IFrosMVh+VgXch8=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=isKz1Yr1asl+P5K7S/EKfjxIAY5ZCTMlhDEWlWr2DB0dwspgHgIS0NVKPFw2E4E7R
	 hj+x1z3a36AOsfFjgQidxck7kzfscVfAyYg2QGNtomeTA8nZy5TfTBdN6vgMUzzKE0
	 KE5yqt1M3tq0dNjLNzbEK371NE2uXGSxeil1CD7Yzg3t4WQsPOUON6CRm4PuipaqtH
	 4u3YROKwik93m3UmuFjElf/k4CGNEvQZUdNc278CENQiI4BkgO2n5GN7IOEg+lg42d
	 q7Nw+K3yHH3PMRr7dXbrEqsuigMJPT7Bz/PNGFDT6NzPHx6ntGMSD5eXxeTak+Fsnv
	 r2kYp9zb7KQ/w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC9AC43458;
	Thu,  9 Jul 2026 08:10:28 +0000 (UTC)
From: HaoNing Cheng via B4 Relay <devnull+Haoning.CHENG.cn.bosch.com@kernel.org>
Subject: [PATCH v2 0/2] thermal: imx: Add calibration offset support
Date: Thu, 09 Jul 2026 16:10:20 +0800
Message-Id: <20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-v2-0-00ff72495e24@cn.bosch.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGxXT2oC/6WOQQqDMBREr1Ky7pckFY1d9R7FRRK/NaUxkh9FE
 e9etUfoZuDBMPNWRhgdErtfVhZxcuRCv4O8XpjtdP9CcM3OTHJZ8JJXYHKgxeteSwFCyD2dnyF
 1GL3+AI3DEGKCcaAUUXsoQCjQXOWVyhs0ZcH25SFi6+bz9Vn/mEbzRpuOq6PROUohLqfWJI7ef
 waTAA6ct0q1uaxu3Dxsn5lAtsts8Kzetu0Ldgrj2wsBAAA=
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
 linux-kernel@vger.kernel.org, Haoning CHENG <Haoning.CHENG@cn.bosch.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783584623; l=2596;
 i=Haoning.CHENG@cn.bosch.com; s=20260709; h=from:subject:message-id;
 bh=Ed32Ov8Wnno8739CLzEbPeqoJp38IFrosMVh+VgXch8=;
 b=Qyrh0pqJkAqTC9HXSwX1SHEZKZTEkWAVYLM+8N93HWAlXkURPGf0G31phtpodLYbKIiy6kuna
 NKeMx9peD9ABEqQcUTVZhaAG9aeqsZxqjJ/ZbzRYsS8SE5Nep6ZFdPq
X-Developer-Key: i=Haoning.CHENG@cn.bosch.com; a=ed25519;
 pk=glQGwad/fosRS5gZUJYbLDPPLGe7rFTrTV2VxY/ySdc=
X-Endpoint-Received: by B4 Relay for Haoning.CHENG@cn.bosch.com/20260709
 with auth_id=860
X-Original-From: HaoNing Cheng <Haoning.CHENG@cn.bosch.com>
Reply-To: Haoning.CHENG@cn.bosch.com

Some i.MX boards need a small per-design correction to align the
reported CPU temperature with board-level measurements. This series
adds an optional DT property to specify such a calibration offset
and implements the corresponding support in the imx_thermal driver.

Patch 1 documents the new fsl,temp-calibration-offset-millicelsius
property in the i.MX thermal DT binding.

Patch 2 reads this property in the imx_thermal driver and applies
the offset to the i.MX6/6SX/7D calibration formulas. When the
property is absent, the default offset remains 0, preserving the
current behaviour.

Signed-off-by: Haoning CHENG <Haoning.CHENG@cn.bosch.com>
---
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
HaoNing Cheng (2):
      dt-bindings: thermal: imx: Document calibration offset property
      thermal/drivers/imx: Add calibration offset support

 .../devicetree/bindings/thermal/imx-thermal.yaml       |  8 ++++++++
 drivers/thermal/imx_thermal.c                          | 18 +++++++++++++-----
 2 files changed, 21 insertions(+), 5 deletions(-)
---
base-commit: c50a940dcde35c647e097e89a9150003abd48329
change-id: 20260709-b4-symana21-11221-imx-thermal-support-upstream-6-18-a084984deb76

Best regards,
--  
Haoning CHENG <Haoning.CHENG@cn.bosch.com>


