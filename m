Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9363BED24;
	Mon, 20 Jul 2026 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580410; cv=none; b=qYuT8B8QGFmlLpE0n3OYeN+z+isNpY2KqaSIpie4P8GUV9sZxUiq2cdscNvose4Gsr0N1u0Awctuqk8tuZ2RMNotidfIYS2SWAe6m6qRkRXhpAPaJRRFkq3dUaDs9L/VgPZ5fs0jy8ChMWASHbA0Ftt7Xq5s3dY6l1AQabM612U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580410; c=relaxed/simple;
	bh=v+gyiP3F5En4Mzp5K0FZ5ZTCbmOS6wGQ+d/V1cnkflY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eP/Kn3WD8vicWReTmKl+6l9oJvPO0YFo88eQ0UMZ6jzffq2Z4+EoOYxQSevo4VivJ3V5JjVesuVxcUnqVoXORd4A0vGviOLLaZ/zTkDHVt1AUXUjemsfJsLYX1lpvsCStsv7FxDRVJu59Nsc1R3urbe4qCiB7sTBgbjteVXMr9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bz33iz0P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bz33iz0P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD272C2BCF6;
	Mon, 20 Jul 2026 20:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784580409;
	bh=v+gyiP3F5En4Mzp5K0FZ5ZTCbmOS6wGQ+d/V1cnkflY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=bz33iz0PZwUg92faQOMbeOWANCIQw34JkZCLs1cgYUo+G2ef6iiII/9xLJf4990uN
	 mlqxSQ863zIUNG2pd6YeBcStKOsniHwRazJfa3dWKQZvRcv2zYybpELSedAkMokQMK
	 kRKG5bKsvr3Hy8kfmdXtrjNqKfJXXmxaM3kYKJUV7iaA+fg8pUiPdiwiUo2sfnvSY4
	 rTu2ni70vREw8WuOOF+/7yDbhAVxcS/6isrss2h7/cTazyztj1Rk2pFbfEZchsyI4v
	 WatfM5Jj++Sagv9f0NIu63j3nBlNqgOYJl0ucFCe5L5k/yS69KMfnxWWy2LFHoBnOx
	 DXe9MRlEinIsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5620C44520;
	Mon, 20 Jul 2026 20:46:49 +0000 (UTC)
From: Nikolai Burov via B4 Relay <devnull+nikolai.burov.jolla.com@kernel.org>
Subject: [PATCH v3 0/3] pmdomain: mediatek: Add MT6858 support
Date: Mon, 20 Jul 2026 23:46:45 +0300
Message-Id: <20260720-mt6858-pmdomain-v3-0-8966d8de93c8@jolla.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWJXmoC/2WN0QqDIABFfyV8nkMtTfe0/xh7SLNlzAxtshH9+
 7QxCHo8cM+5CwjaGx3ApViA19EE48YE5akAqm/Gh4amTQwIIgzVmEA7M045nGzrbGNGKLGsKFO
 CsZqCZE1ed+a9FW/3H4eXHLSacyYvehNm5z/bZcR5969Xh3rEEMGqQ0JKyQnR6Dq457M5K2dBr
 key9+nRJ8lnRJSa151Cotz767p+AVdnEVgAAQAA
X-Change-ID: 20260712-mt6858-pmdomain-b1b456c96675
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Nikolai Burov <nikolai.burov@jolla.com>, 
 Nikolai Burov <nikolai.burov+review@abscue.de>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784580408; l=2706;
 i=nikolai.burov@jolla.com; s=20260707; h=from:subject:message-id;
 bh=v+gyiP3F5En4Mzp5K0FZ5ZTCbmOS6wGQ+d/V1cnkflY=;
 b=us8g3ckdvk3t87RuXqPirheNWUBIN2a3SyiS4ZM13IU1iIzPELzMCVooL0FeU/86E2JqlpDvj
 3bcHU8tKQD6BYYg61dC1QFG66x/70B3cMmmoYQbdaosUKVBbfJxCmA+
X-Developer-Key: i=nikolai.burov@jolla.com; a=ed25519;
 pk=yzpa+PD+ovHUFMIOBA9o2QqGwI110jM6hdGHLc7jtoQ=
X-Endpoint-Received: by B4 Relay for nikolai.burov@jolla.com/20260707 with
 auth_id=859
X-Original-From: Nikolai Burov <nikolai.burov@jolla.com>
Reply-To: nikolai.burov@jolla.com

Add power domain driver support for the MediaTek Dimensity 7100 (MT6858)
SoC. On this SoC, there are some new subsystem-specific bus protection
blocks, which are listed here in ascending address order:

- IMG_SUB0 at 0x1502f000
- CAM_SUB1 at 0x1a00c000
- CAM_SUB0 at 0x1a00d000
- IPE_SUB0 at 0x1b00e000

The VLPCFG bus configuration registers at 0x1c00c000 are also new.

Additionally, implement the SMC-based power sequence required for
enabling the modem power domain on this SoC.

Signed-off-by: Nikolai Burov <nikolai.burov@jolla.com>
---
Changes in v3:
- Fix error path to also skip sram_pdn for MODEM_SECURE_PWRSEQ
  (discovered in Sashiko report)
- Link to v2: https://patch.msgid.link/20260715-mt6858-pmdomain-v2-0-6293e87fc093@jolla.com

Changes in v2:
- Rebase
- MTK_SCPD_MODEM_SECURE -> MTK_SCPD_MODEM_SECURE_PWRSEQ
- Convert SMC command enum to defines
- Based on the new SIMPLE_PWRSEQ changes, skip the sram_pdn stage for
  MODEM_SECURE_PWRSEQ too since it wasn't intended to have an effect
- Clarify that the SMC call also handles bus protection
- Simply if/else code based on the assumption *_PWRSEQ are mutually
  exclusive
- Add comment explaining that PWR_STA_2ND is skipped for modem
  (mentioned in Sashiko report)
- Link to v1: https://patch.msgid.link/20260714-mt6858-pmdomain-v1-0-4f09bbb822e0@jolla.com

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-pm@vger.kernel.org

---
Nikolai Burov (3):
      dt-bindings: power: Add MediaTek MT6858 power domain controller
      pmdomain: mediatek: Add support for secure modem power domain control
      pmdomain: mediatek: Add support for MT6858 SoC

 .../bindings/power/mediatek,power-controller.yaml  |  21 +-
 drivers/pmdomain/mediatek/mt6858-pm-domains.h      | 466 +++++++++++++++++++++
 drivers/pmdomain/mediatek/mtk-pm-domains.c         |  55 ++-
 drivers/pmdomain/mediatek/mtk-pm-domains.h         |   6 +
 include/dt-bindings/power/mediatek,mt6858-power.h  |  23 +
 include/linux/soc/mediatek/mtk_sip_svc.h           |   3 +
 6 files changed, 568 insertions(+), 6 deletions(-)
---
base-commit: 3fe08b9796f36ef437ab9328e7dd1e5ff2d66603
change-id: 20260712-mt6858-pmdomain-b1b456c96675

Best regards,
--  
Nikolai Burov <nikolai.burov@jolla.com>


