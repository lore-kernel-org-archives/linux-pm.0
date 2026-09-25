Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED56477E51;
	Fri, 25 Sep 2026 08:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790326769; cv=none; b=o+tsnETEgRez5hewu8iiQ7DNinrEhsJX/mGN7MhQJAPWaeUYuOqwuD0cWJ6edv8rPV4S9N5bmjN2qhCeTtpWmDlsz8gmJue3kyoYaj1e5iZK+jVAv9isjQF4+GrrHU8mNLkvEqg/bdEsHp7CyLoUZnxaxKHFBL8SOHCi/lF0rkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790326769; c=relaxed/simple;
	bh=RSNwSSTx2eqkwh6SNPpmBWShiYztNRp2A78G/08sizU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CL6coc00J12nzr4GCZtsJeSxK9ALZgFh2XKIknoEg9A/2vSp5U71WIJ39rykrzuVtD9NV1wNh/XUeKpcKrpxSWOJHc6vcdBSIMwapIED2MkmC8IT7v3fwrK4w1wJ7fPdDZRp4ttsfHeUbMYqavRx660NT0hHSnNuVh72JYxE5F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RVoyDc3z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RVoyDc3z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B1BC1F000FF;
	Fri, 25 Sep 2026 08:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790326767;
	bh=/R8EDsFWm4mzuLIIsmkOdeGXz3KnTcXcIqVJWLIi1d4=;
	h=From:Subject:Date:To:Cc;
	b=RVoyDc3zNe9cJbetwR8Fil5lOc/YQ4ig/b6P+VHfriqUL0f5G+Gp+zdfq973K02M4
	 HLUGcQ00kU+UfUSQoa/g1LjnrWfvHw3yu/0MF2Irmrcz9jgyAsN0E/so9cOPLpJKQ5
	 nRm/UMyhGYXpYHxl7Xb3EI+o6RNZEzwmXfc+/GfVfIEEUEpN9Q4v/bRiZ5+8Y7ZjY/
	 sAVj9XliNBcxt3g2Xkf0GZRf0woXDOvxm1/137nvPktkZyKYI956qd0EiqUmzxeqiO
	 1Mya311ZPuwe1wqzzrXsTnoQsCrfUk6bQtxIl3rVWOR78Qso75gd/dSWr+Ukss9rtW
	 6dulKxgvPUT8Q==
From: Linus Walleij <linusw@kernel.org>
Subject: [PATCH v3 0/2] power: supply: Correct AB8505 charger device tree
Date: Fri, 25 Sep 2026 10:59:23 +0200
Message-Id: <20260925-ab8500-charger-dt-v3-0-f80b8d295e2d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NwQ6CMAyA4VchOzuzdbINT76H8TBGgUUDpCOLh
 vDuDk6aGI9/m35dWEQKGNm5WBhhCjGMQw51KJjv3dAhD01uBgK0qGTJXW1LIXheUofEm5lXlQd
 /0qCcFSzfTYRteO7m9Za7D3Ee6bW/SHKb/tOS5IJLUZtaWYPa6csdacDHcaSObVyCT8L+IiATZ
 SuNVwocOPNFrOv6Bk2l3vv2AAAA
X-Change-ID: 20260915-ab8500-charger-dt-99c2c4623a80
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3

AB8505 retains the USB charger from AB8500 but omits the separate main
charger block. Its charger node consequently has nine valid interrupts,
not the fourteen interrupts used by AB8500.

Adjust the binding to describe the variant-specific interrupt sets and
remove the five nonexistent main-charger interrupts from the AB8505
device tree. The binding update also limits the autopower_cfg description
to AB8500, since the corresponding AB8505 register bit is reserved.

The power maintainer can apply patch 1/2, I will funnel patch 2/2.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
Changes in v3:
- Move the conditional constraints below the top-level properties.
- Expecting Sebastian to apply patch 1/2.
- Link to v2: https://lore.kernel.org/r/20260918-ab8500-charger-dt-v2-0-5f17c332a2a7@kernel.org

Changes in v2:
- Add an AB8505-specific compatible with the AB8500 fallback.
- Tie interrupt counts and names to the charger compatible.
- Use the new compatible in the AB8505 DTSI.
- Link to v1: https://lore.kernel.org/r/20260915-ab8500-charger-dt-v1-0-10b7b387e6a6@kernel.org

---
Linus Walleij (2):
      dt-bindings: power: supply: ab8500: Add AB8505 charger
      ARM: dts: ux500: Use AB8505 charger compatible

 .../power/supply/stericsson,ab8500-charger.yaml    | 76 ++++++++++++++++------
 arch/arm/boot/dts/st/ste-ab8505.dtsi               | 17 ++---
 2 files changed, 60 insertions(+), 33 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260915-ab8500-charger-dt-99c2c4623a80

Best regards,
-- 
Linus Walleij <linusw@kernel.org>

