Received: from srv01.abscue.de (abscue.de [89.58.28.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C233112A5;
	Thu, 28 May 2026 16:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.28.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985121; cv=none; b=PF7iwMlRd+sj6e8MnaDItjxlbimyrTfmj7MKf7x4c18NYRcOIn/8rIY5EWXj6+5JgBomE1qvNzlICWieZVPWW+bHGZ1dN+1w918jBR6413UnJQKA3OgtQqjsLiFaOgfEO4sPsXjrBCJdeLj6+tZf6cl2ClKY3Ncxg15FqgAwK2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985121; c=relaxed/simple;
	bh=cpm3Z2tfRLVxZihV48Imcp7RlgiZSK2jYGWPhKojK+Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lNE/thzC0r37XZy3CpxRpcNN58SOZEjATwn5Eg+8M5K4jWC4pu3i/xTacs8Uv/NPGlk4Hxtk6sl+1QW5SZFL1oV8FDVOgHxEgPN2+GVBdt/9QI9GASZl40cRBDvwWKqVlHSRdHXXUKsIZ01aUtUATWtxskgLQPwgZF+Q6S/Tjzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de; spf=pass smtp.mailfrom=abscue.de; dkim=pass (2048-bit key) header.d=abscue.de header.i=@abscue.de header.b=LFU5R4g7; arc=none smtp.client-ip=89.58.28.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=abscue.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=abscue.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=abscue.de header.i=@abscue.de header.b="LFU5R4g7"
Received: from fluffy-mammal.metal.fwg-cag.de (unknown [IPv6:2001:9e8:cde6:a200:bc59:4aed:9f3b:ec21])
	by srv01.abscue.de (Postfix) with ESMTPSA id 1EAA21C6B96;
	Thu, 28 May 2026 18:18:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abscue.de; s=dkim;
	t=1779985110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UODtJT4ZA+3fBK+TzSRQYV8/sUVhLQBAPI7oDO+6LHw=;
	b=LFU5R4g7cLUIKotSU6IByAmCLFoGkw6QEXZERdoHyKgpo+XF/zz2YXp3soQfzymOib/HmX
	UjO6+bY+Ci17T2mwhgalGwygZm5I3wGv0QDDbqgk8/T0iUtwellueJpufv4H8HjMurzn0C
	jGihs8eD6LYLWiUjaUnkz9rZ9RVVAJ8lQvN8yYz9ZBJlKiBXoKtHGqP519NMgJoqn7yBQh
	wbEFoHXX2Hm9jYjvr4FrHw15FcMp0DBA/bhlgzNXWb1xDi9nM/+kKsxcETKwsiRjF9aF+q
	A/utEJPQI8N4+cAIL1/vgTPU1PvueBTiZKammMiDstYDbPy3FWvRJIZLUMfGpA==
From: =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH PARTIAL-RESEND v3 0/3] mfd: sc27xx: Use MFD cells and
 devm_mfd_add_devices()
Date: Thu, 28 May 2026 18:18:22 +0200
Message-Id: <20260528-sc27xx-mfd-cells-v3-0-25cd685d2743@abscue.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAM5qGGoC/23NzQrCMBAE4FcpORtJNm1jPVnQgyAi6k08pMlGA
 /7RaKmUvruhCBbqcdjZbxrisXToyTRqSImV8+5+C0GMIqLP6nZC6kzIBBikDIBTr0HWNb1aQzV
 eLp4aVciMJVYohSS8PUq0ru7IA9nk2/0yX9HtYrdYz8kx3M/OP+/lu1useNf64jDEK04ZTbMEU
 osy1lLOVOH1C8cGO6yCHyAg+QNAAAzDokiZUrEaAKIPZH8AEYCMJxODGHMr4z7Qtu0HimuDSEI
 BAAA=
X-Change-ID: 20260221-sc27xx-mfd-cells-dab7905f3aae
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Chunyan Zhang <zhang.lyra@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3

This is a resend of the remaining patches in a partially applied series
switching the SC27xx series of PMICs to use MFD cells instead of purely
OF-based device probing. There are no dependencies between the patches
in this series, but they are part of a single logical change.

Link to original series (v3): https://lore.kernel.org/r/20260329-sc27xx-mfd-cells-v3-0-9158dee41f74@abscue.de

---
Otto Pflüger (3):
      regulator: dt-bindings: sc2731: Deprecate compatible property
      power: reset: sc27xx: Add platform_device_id table
      regulator: sc2731: Add platform_device_id table

 Documentation/devicetree/bindings/mfd/sprd,sc2731.yaml         |  2 --
 .../devicetree/bindings/regulator/sprd,sc2731-regulator.yaml   |  4 +---
 drivers/power/reset/sc27xx-poweroff.c                          |  8 ++++++++
 drivers/regulator/sc2731-regulator.c                           | 10 +++++++++-
 4 files changed, 18 insertions(+), 6 deletions(-)
---
base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
change-id: 20260221-sc27xx-mfd-cells-dab7905f3aae

Best regards,
-- 
Otto Pflüger <otto.pflueger@abscue.de>

