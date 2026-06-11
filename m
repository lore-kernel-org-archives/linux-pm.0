Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9CB3CA4B9;
	Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173296; cv=none; b=C9pubApv7IXdYGN9IFOe1BudN+cEKbeAF3cA2DfuHOfKFisX2hjjZkdIsY+OK25AfBRo111iKPgEERbjYyFaVx+eo4togNC5rSzznJka3u3M0XQHGxvLJXFhyndxtkfcGB+DDRguNcwQo3skt/1GeyW92bdYwzey4oP6/zAokLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173296; c=relaxed/simple;
	bh=Tvmqx4pYtJuxtoQ3R62SMg0IdP8UogvEPTr0AvaCegU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iKZ50svvnjpx85UwI/hN9LzRL1vhxAEh2X1mGTBx6AqBjIyadInXFzyXmMf2Ox5/JOeJjzM2C1FfWk5PPGbuBywb/r4kc3B7+RaMPBtqWeRdhm2j6/0F+gTRWONyw1gYEEWMsBjkRlEbTmiFhQtEOExB0IAh9RaOWOF6ofXFkjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slKqyvkT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slKqyvkT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2DAD3C2BCB8;
	Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781173296;
	bh=Tvmqx4pYtJuxtoQ3R62SMg0IdP8UogvEPTr0AvaCegU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=slKqyvkTYrfzKN5d/aJE5DFcGmfalGKJ3HBfJrB6YNvv4vLONkqy1mIB8AYz1t5Gf
	 mG5DfJW0HccIEmOi9JbRKg89sszrHi8MB9I13CGeHUDNsKYcqvDpX9ETqMO5kJNsv/
	 uy0rl2Wp1qeZG0m/WmTFWFW63wxr+KiYVN1WBqGEetf91Qex+RZgUpu7KzBFpdTVzK
	 KknCOx0+b4/FIF/AbhuNVtKqo9Wcl7KtVk5lrUOr26urp6saPfI+msJua9rD81gF4y
	 nLW5WailNMuNy7T6GEEVrJTZO2g7g23BabiOeKLIErSUR3v5IEfZDWITpaWzLjcp2o
	 jeA1xIrnSWX7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1390FCD98C7;
	Thu, 11 Jun 2026 10:21:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH 0/4] nvmem: add support for the MediaTek mt6323 PMIC
Date: Thu, 11 Jun 2026 13:20:28 +0300
Message-Id: <20260611-mt6323-nvmem-v1-0-b5e1b9ce51f2@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqAIBBA0avErBPUSqirRAuzsSbQQiuC6O5ZL
 d/i/wsiBsIITXZBwIMiLT5B5BmYSfsRGQ3JILlUXAnB3KYKWTB/OHSMm6rU3EqrawspWQNaOr9
 d2/2Oez+j2d4H3PcDKOQeZnAAAAA=
X-Change-ID: 20260611-mt6323-nvmem-0c54a0f2fa9f
To: Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781173294; l=1828;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=Tvmqx4pYtJuxtoQ3R62SMg0IdP8UogvEPTr0AvaCegU=;
 b=r+iAeji7kO+0TGOzXiqhQcf+A5+3fkeYjjq9gerPbtOc6rQDDxklu44EumjyyX7+Qw++70LJk
 3kn+In2w6bUA0Kyok20FAN1TDGDf2JlVcLxmzPTL5uSJT28arb66KhH
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
Changes after split:
- EFUSE driver:
    - Remove 'linux/errno.h' header (Andy)
    - Remove explicit cast to u16 in the 'mt6323_efuse_read' (Andy)
    - Reword comment in the 'mt6323_efuse_read'
    - Capitalize MediaTek in the module description
- Link to a previous series: https://patch.msgid.link/20260512-mt6323-v2-0-3efcba579e88@protonmail.com

---
Roman Vivchar (4):
      dt-bindings: mfd: mediatek: mt6397: add mt6323 PMIC EFUSE
      nvmem: add mt6323 PMIC EFUSE driver
      mfd: mt6397-core: add mt6323 EFUSE support
      ARM: dts: mediatek: mt6323: add EFUSE support

 .../devicetree/bindings/mfd/mediatek,mt6397.yaml   | 21 ++++++
 MAINTAINERS                                        |  5 ++
 arch/arm/boot/dts/mediatek/mt6323.dtsi             |  4 +
 drivers/mfd/mt6397-core.c                          |  3 +
 drivers/nvmem/Kconfig                              | 11 +++
 drivers/nvmem/Makefile                             |  2 +
 drivers/nvmem/mt6323-efuse.c                       | 85 ++++++++++++++++++++++
 7 files changed, 131 insertions(+)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260611-mt6323-nvmem-0c54a0f2fa9f

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


