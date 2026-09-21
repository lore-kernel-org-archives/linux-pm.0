Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B3D44A416;
	Mon, 21 Sep 2026 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789977029; cv=none; b=tr/G5zcZ5X3L6h9eYw2Nn9oWIgVaF208iYVjUuuazKaM+LhtoyPvW7ZktbMU/qzUl40sY5Sl+4jtNE9EXaEG0m5RImmIIgTGY0Jp7E6Ipxr99MEF21gDJjN8wIctbGAKz84PepZpgbS2WtXdGVC0kQEX42iDmIhXevWUIbyJKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789977029; c=relaxed/simple;
	bh=MN6wjM73jwFJE0BBGgrZ2DP1kz/GNI2gsTbQ6k5QYKg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=L6s+NLyrXa3Oj2wnXr447AC1gwoSU1GHQIN0+rpzdJAB6mb/rfUnMAnWoFx8JKvnYegGKDFgB9RAXxj7QWQY0jGqgPY59dH68XJlxmjF6rR89gTWbPOfbbSXwsr4Y1xiDsLAQnxuOM8n4eQd5mmr9Nkhr2Bfwh2nJ8pGXGnMroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy0egReD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy0egReD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 787C5C2BCFA;
	Mon, 21 Sep 2026 07:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789977028;
	bh=MN6wjM73jwFJE0BBGgrZ2DP1kz/GNI2gsTbQ6k5QYKg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jy0egReD+8CgpgGNZcEoGc6MnHzSrqY8YQvM5daE5jPaDbqZmre0CW3f7cO4LhJvA
	 6T7lAAfhYUC7Hq1FthIqk4rzdNhD6NT+UN+ybSJ4rT/K11YxTl6IECBYpPsqVcCcgL
	 mBpMw80R97EGB8864NkCzza4eu35YRT7pYvEV+cz8FR+qN7UEVdlK6R45vbMpk93f0
	 to8f2tl1Gown9Ln3k7cq6EhyDDwAjqwmRN88M1eRJkCkQVrQZtPI4frtjXzyHJ7TYm
	 xRJ6VF0cWNBoL6Upj2PzVnVKwOsA+BBubhl/GLPvWNmomHSBSHDRV/mkrc1QaGlKSA
	 HXN15hfdQJbZQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E78C982ED;
	Mon, 21 Sep 2026 07:50:28 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v5 0/3] nvmem: add support for the MediaTek mt6323 PMIC
Date: Mon, 21 Sep 2026 10:50:01 +0300
Message-Id: <20260921-mt6323-nvmem-v5-0-2f5d308369f0@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPwW7DIAwG4FepOI8KbCDKTnuPaQdCzEpVQgUZa
 lXl3Ue6Q6u2O/7S78/2hRXKgQp731xYphpKSFML+m3D3M5O38TD2DIDAUYYKXmcDQLyqUaKXDi
 trPDgbe9ZGzlm8uF05T6//nL5Gfbk5tVYG7tQ5pTP131Vrr1/6Cq54IMmOfSOtPTwccxpTlO04
 bB1KbLVr3AvdA8CNEF5FITGtivVSwFvQifxQcAmgNAOezCdhdeCugn90xeqCQbMOMpOoxzdk7A
 syy9+Vg4WhQEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789977026; l=2403;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=MN6wjM73jwFJE0BBGgrZ2DP1kz/GNI2gsTbQ6k5QYKg=;
 b=WfuNkR0MZFTaJPn5Cgdqk4A6l9M4n4AssM/47amKmWilCckA8bhc+0ZqCnazyL3HtApVK61Vh
 bJCgtxCUZ28Abj0eGsH68mAgfNWjTroT7j4ofNoF8QSt1nNO8OXiuad
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

This series adds support for the EFUSE found on the MediaTek mt6323 PMIC.

Tested on the MediaTek mt6572 and mt8163 SoCs (Ben), both paired with a
mt6323.

Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2nd Generation)
Signed-off-by: Roman Vivchar <rva333@protonmail.com>

---
Changes in v5:
- Reorder Makefile entries
- Use mt6323_regulators driver pattern for regmap instead of dev->parent->parent
- Link to v4: https://patch.msgid.link/20260911-mt6323-nvmem-v4-0-626dd17531dc@protonmail.com

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
 drivers/nvmem/mt6323-efuse.c                       | 83 ++++++++++++++++++++++
 6 files changed, 126 insertions(+)
---
base-commit: 8f596c13b6b7fa9fa35091273c37f9b6e3fc2d0f
change-id: 20260611-mt6323-nvmem-0c54a0f2fa9f

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


