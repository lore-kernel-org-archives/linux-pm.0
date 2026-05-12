Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E438E35676B;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563301; cv=none; b=o2kpLEGfMk/eN/gwYQCflyh4ZUk0Q0h1IV8v0aDvHGBDC0+uiWINmvdLiifqH2WolmRF/g9fK+HjmQWPmdc13j/wScAnFDreebvJcNzf/ZvCh0VNA/cz48c7KQGP0565nn32KQ6NB/TVal+urB15IxZpopPbh7EqfUnx1FCAr00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563301; c=relaxed/simple;
	bh=/p49E0kAapVpqQ1BgFexwVmJgZuamoRVrgCb0GktNF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FllpGgySp2pjLiuzF7QN/s9fYkrZlwhxyNFNnfHh06bg/BeN9NkkI4YPWJAvqqlHSXvWOpvMzsO7yDfQBm9QYWP8FdjvgpTfP3Gst2kS8ShajYoO8mg1zRCFoUiZJNgUfPse0/mIgpzoMrOFE2kS0wZTifuyOui4LCqw7XfPXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYbypev2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYbypev2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0CACC2BCFF;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778563300;
	bh=/p49E0kAapVpqQ1BgFexwVmJgZuamoRVrgCb0GktNF0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BYbypev2x5JtDrd4+d6s8Ho7D0IWs5Usrx4GoMBnCzSay+xzBy93KS4+abYQIq5Sh
	 WQ+9iZdy6yGA3PyzBHLMai6yZ6wn5NzxhQVEop79lWL3bdwtv5KXogNHuolj5sMnzK
	 tLVefGnlshaJNqpRrUd1Mt2CT2Ea3WxoCOv23uuRNzMbsg/Ir5sW3D4IvCqL3ay/Co
	 wo8aTpQrfPx5SJ0HnNxN0KpcjSQOhv8vZQJ8gOuNkPFNi0eLlvb5t0ERokCXmfd1U+
	 fjGTSUBCIroPp3bV3v9ExL1YvZmI2fCZvkSkkDRjumn4wOWpkMJpM8DmHRYP8WrsqQ
	 ijnB8d2Z0+NVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7993CD4851;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 12 May 2026 08:18:29 +0300
Subject: [PATCH v2 15/16] MAINTAINERS: add MediaTek mt6323 PMIC EFUSE
 driver maintainer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-mt6323-v2-15-3efcba579e88@protonmail.com>
References: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
In-Reply-To: <20260512-mt6323-v2-0-3efcba579e88@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sen Chu <sen.chu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Lee Jones <lee@kernel.org>, 
 Roman Vivchar <rva333@protonmail.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778563297; l=660;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=if+Z5Y6WKURioqoOXDX0bP25C/WqfsUOAvh8ArrZ0l0=;
 b=+PAUp2rRKc2hyayPgfig+OPswFCKcw28umi1pE1EWA6SDbjVe3GbH5skbIdrNjk7zsueqwEVp
 d5k57KXidBsBi/AozWoFEn2srmGWDGSdvcBo7MvcyL/d7SE5A2BBF8s
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add myself as MediaTek mt6323 EFUSE driver maintainer.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 52249c301633..bf2e066f377d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16342,6 +16342,11 @@ M:	Roman Vivchar <rva333@protonmail.com>
 S:	Odd Fixes
 F:	drivers/iio/adc/mt6323-auxadc.c
 
+MEDIATEK PMIC EFUSE DRIVER
+M:	Roman Vivchar <rva333@protonmail.com>
+S:	Odd Fixes
+F:	drivers/nvmem/mt6323-efuse.c
+
 MEDIATEK PMIC LED DRIVER
 M:	Sen Chu <sen.chu@mediatek.com>
 M:	Sean Wang <sean.wang@mediatek.com>

-- 
2.54.0


