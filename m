Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A693F9F45;
	Fri, 11 Sep 2026 06:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789108434; cv=none; b=s4XJYTCt7UFgGDzi5ei6AfVJfWIM5i7HeDHWYQ4RnetYhJ+T+Doq6lG1DB0fXNyxISXSgzfK+QNzP1GJsZQKbxGafDOkV6IYBKw2AS0rvrkMkcOWGotqK62+MM/b0g5KeaHeEK+oFsNWwmTx4xd+mVGWc9raohb7yS+4i4H6U+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789108434; c=relaxed/simple;
	bh=III8deQ/x6mTKRMLEfxp/HqD28xxvlYsZv802tIFQL0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qwEZQx34OPImLTQH/9K7BgiApq7ORXoPpTOwLWdnImKqFBYUK2RzqD04ecQlp5UzU1SCaS/yY4gGKx08Bho9nryDAz3py+SYjDQW+Y9alrLIQROqFU1us749graKJ9q/wsZ5g6RjI9AdS8XkfW3NyWtaJ8zVwkHHB4XK+nVAQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoJUWwWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoJUWwWH"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 89370C2BCB8;
	Fri, 11 Sep 2026 06:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789108433;
	bh=III8deQ/x6mTKRMLEfxp/HqD28xxvlYsZv802tIFQL0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=EoJUWwWHKIZWYsp+7hfY9kX2kW5H3jSkga3GYy0L6BpfXrempyu+924rbRPuHms2i
	 Eam8no2s0QdOiAUr2WvYXjnWciAbFdYZZmlzSmKCLPLFdUDjWUj+9YNiRZgy2sj8F9
	 PQd+WOnej9D9ynpiD2qTmZrgkP/KC3rKwHAfte2ar3MJW22PhgKSo3YISJ2YEUWncU
	 +CBXwCtCvDVQFmM+dOO/4tVyJuBKOFuEYSLyCPQup12XEZU8TRbAtqfpYdHWsQucJC
	 PtVxVh7bEUl6yRnMT2knByDfAPiz8IrzjNh7/lDu2O5W61s++ibXIrE7+6XP16Cwl7
	 h3SFpFLcarmSg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ED8C88E42;
	Fri, 11 Sep 2026 06:33:53 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v4 0/3] nvmem: add support for the MediaTek mt6323 PMIC
Date: Fri, 11 Sep 2026 09:32:58 +0300
Message-Id: <20260911-mt6323-nvmem-v4-0-626dd17531dc@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTQ7CIBAF4Ks0rMXA0NLUlfcwLigOFiPFABKN6
 d2lutD4s3zJm+/NjUQMFiNZVTcSMNto/VhCvaiIHtS4R2p3JRNgIJnknLokBQg6ZoeOMt3Uihk
 wqjOknJwCGnt5cJvtM8dzf0CdZmNuDDYmH66Pvczn3h86c8po3yDvO40NN7A+BZ/86JQ9LrV3Z
 PYzvAvthwBFqI1gKKQqX9Y/BfESWi4+BFEEYI0WHchWwbcwTdMd5gQuckMBAAA=
X-Change-ID: 20260611-mt6323-nvmem-0c54a0f2fa9f
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789108431; l=2447;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=III8deQ/x6mTKRMLEfxp/HqD28xxvlYsZv802tIFQL0=;
 b=08QpbWtt2VFD+87AueJLzIdq6DQnxc3iPkj08mZppBO4XOonHfpRrRZxT5L3LFSBSKH6Q+GMZ
 16gF+U2AHR8D9+OeWNN9FJCrrtpCqZDMRi6TccNGNyvWeIrbwPQGHrb
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This series adds support for the EFUSE found on the MediaTek mt6323 PMIC.

The previous version of the series for all AUXADC, EFUSE and thermal
drivers was split after Krzysztof's comment [1].
    
Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
mt6323.

[1]: https://lore.kernel.org/linux-mediatek/20260504-mt6323-v1-0-799b58b355ff@protonmail.com/T/#med30fad67a090be35f549231336b2dec295233f6

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>

---
Changes in v4:
- Rebase onto nvmem/for-next (8f596c13b6b7 ("dt-bindings: nvmem: qfprom: Add compatible for Qualcomm Maili"))
- Drop device-id/of.h header (Andy)
- Mediatek -> MediaTek in Kconfig
- Link to v3: https://patch.msgid.link/20260713-mt6323-nvmem-v3-0-205c39267a24@protonmail.com

Changes in v3:
- Rebase onto next-20260708
- EFUSE driver: Replace 'mod_devicetable.h' with explicit 'device-id/of.h'
- Drop MFD patch since it's applied
- Link to v2: https://patch.msgid.link/20260617-mt6323-nvmem-v2-0-4f30e36aa0f4@protonmail.com

Changes in v2:
- EFUSE driver: Sort variables in the mt6323_efuse_read (Andy)
- Link to v1: https://patch.msgid.link/20260611-mt6323-nvmem-v1-0-b5e1b9ce51f2@protonmail.com

Changes after split:
- EFUSE driver:
    - Remove 'linux/errno.h' header (Andy)
    - Remove explicit cast to u16 in the 'mt6323_efuse_read' (Andy)
    - Reword comment in the 'mt6323_efuse_read'
    - Capitalize MediaTek in the module description
- Link to a previous series: https://patch.msgid.link/20260512-mt6323-v2-0-3efcba579e88@protonmail.com

---
Roman Vivchar (3):
      dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC EFUSE
      nvmem: add mt6323 PMIC EFUSE driver
      ARM: dts: mediatek: mt6323: add EFUSE support

 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   | 21 ++++++
 MAINTAINERS                                        |  5 ++
 arch/arm/boot/dts/mediatek/mt6323.dtsi             |  4 ++
 drivers/nvmem/Kconfig                              | 11 +++
 drivers/nvmem/Makefile                             |  2 +
 drivers/nvmem/mt6323-efuse.c                       | 84 ++++++++++++++++++++++
 6 files changed, 127 insertions(+)
---
base-commit: 8f596c13b6b7fa9fa35091273c37f9b6e3fc2d0f
change-id: 20260611-mt6323-nvmem-0c54a0f2fa9f

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


