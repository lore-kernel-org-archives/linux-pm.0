Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D693E3158;
	Mon, 13 Jul 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783937515; cv=none; b=fRe1M22BjQvHv0eifmBsq/Rnb6JjNg1Ei8bVhBR4jY3boiQ9UtBCEZhbiOAT5d3KGTNt2PE9HyIzn9YKNHrezq+6dWWLfTr08kubOMQLrqvZ5K+yjTEN8T+ptj1mMmACVrmfiWzSK7G1Ydxd8kPp4rpb1hkRRGs2UhkOAaDrA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783937515; c=relaxed/simple;
	bh=IH90joJ4tnRLkJPNr03igPwq+iiAzvjOkx7FuVR2LQo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ozL82HjoA/M8tpQW3pg5Sin8SH1yw4O+TJ2TK5G8rsy8VfZ+lzj9p3VufrJ4OmFct3zTOqyygazj/Y7PcgFLZVWR18tp4rHOfWIBPjvtbBMfzGxfgQaWTSceZ1YyBf9m6udMB65ZK/eogs8YkFJo5f4jQzTQnFGQOxwZDClAgR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPs2CPfw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPs2CPfw"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84281C2BCB8;
	Mon, 13 Jul 2026 10:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783937514;
	bh=IH90joJ4tnRLkJPNr03igPwq+iiAzvjOkx7FuVR2LQo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jPs2CPfwNKnT/QK3kmF3AknCV+qOfFfTKyeZQiIdECp0FVnfQsWLllpPfQox/FqEY
	 i+E1OpjXy0wvVs8XTa5Rzs+9uhFpFBfhfh10r96sjjiJGnDI3nwZXE+klNcfyNW1dS
	 o4NYb1ARoaJF6oFix7S3zAPZEDXG+WXjtpGgn6Qp8FKIuRsrina4EsATbwhy5WuunS
	 umD/EJgCpdPo7kv5DfKEnFdpBemG9G4aD6TlHZWsgV00jUIS5JPsf0KxnUB0WMX4UI
	 NaQ03RiIU+au+EassF5XJ9DYfXZ3SZ6ZiTUYV/B0AyjoHblIamDSeWT46HkR7wK0EL
	 0dTtq0qdz60eA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F353C44506;
	Mon, 13 Jul 2026 10:11:54 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Subject: [PATCH v3 0/3] nvmem: add support for the MediaTek mt6323 PMIC
Date: Mon, 13 Jul 2026 13:11:34 +0300
Message-Id: <20260713-mt6323-nvmem-v3-0-205c39267a24@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XOTQ7CIBAF4Ks0rMXw02LqynsYFxQHixFoAImm6
 d2FujEaly95872ZUYRgIKJ9M6MA2UTjXQl80yA1SncBbM4lI0aYIIJSbJPgjGOXLVhMVNdKopm
 WvUblZAqgzWPljqd3jvfhCipVozZGE5MPz3Uv09r7Q2eKCR46oEOvoKOaHabgk3dWmttWeYuqn
 9mnsPsSWBFazQlwIcuX7Y+wLMsLAjaZiQEBAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783937511; l=2150;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=IH90joJ4tnRLkJPNr03igPwq+iiAzvjOkx7FuVR2LQo=;
 b=e72h5C0iNaVmwv4Y/8ukUwlKHV0J3jGG7YwkrI9fJAY3hbFhInt4LTTzIWRwBD+eA4nrrKCyJ
 v4b+mBvQsnSDumEwaC9CVp4OBK+J2/pJ3PklK3CCHhJJnfOQ8aMtO3S
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
 arch/arm/boot/dts/mediatek/mt6323.dtsi             |  4 +
 drivers/nvmem/Kconfig                              | 11 +++
 drivers/nvmem/Makefile                             |  2 +
 drivers/nvmem/mt6323-efuse.c                       | 85 ++++++++++++++++++++++
 6 files changed, 128 insertions(+)
---
base-commit: b9810cd75b9fb56a3425d391cba3f608502bd474
change-id: 20260611-mt6323-nvmem-0c54a0f2fa9f

Best regards,
--  
Roman Vivchar <rva333@protonmail.com>


