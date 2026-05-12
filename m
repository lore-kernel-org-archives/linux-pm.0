Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D666A3033DE;
	Tue, 12 May 2026 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563299; cv=none; b=N9BWGj8m+6kARs22nj35vO+4xZiCQGkXOxl4DOsCpoAE1uO0U+poyqaaOYRfZxu2hEfa465IgVK9S0hNh2nNa6u6sYx/2cAauCZeBKDY4+m2mGDKsv8Noiw/wmMy2/e62n5SW8wIqPhS+Kj14OHj8uF8tfHmOpSc9z9TdQdZYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563299; c=relaxed/simple;
	bh=8rD3NqMbvfYvXT1U3COEaIqJZUm6U2f/YI8JsziTLi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7gLKtY6OI/MoX21hZ7SkjKrNtgFJIjNT0wmbilPe9LYVtVjWPogXTjU0LQXpDVKRfu3GMA3nLiDWvL4nVn8WHoT0uVjcrx8PFqgDNGckZVILOtvTPRuzEogNdRa66hxlWbNJBahpx6LNEru9pRbv1mLSbY6erQQal9FvXau09M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEDzgb47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEDzgb47"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABA67C2BCC7;
	Tue, 12 May 2026 05:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778563299;
	bh=8rD3NqMbvfYvXT1U3COEaIqJZUm6U2f/YI8JsziTLi4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mEDzgb47pH0Xm+QRZMUBy6VibEvTQOvbQ7VnJODdkwVS0RFi3IV97KSX1Sb4kIPY5
	 SQa4/weqW05P+9L0F1qrcfZj7ABqovNB1065PqMtKF9E/nUY9dmjrkZAN+ZI59p4s2
	 22daHJGbpf9ajy3JNNnRzLOQzWRrYW1JZcJ1sL3ENHpI7vgeomzmdVzBSX/wtY+RZr
	 79E3ezw7IWFjPsHgKrl+6oZtF3AM3vbOz7r6ejAhcOQ6J9pAggzi1kVh2muDFZjkI+
	 99kaD4xi+V7mZzGAWp+TGg9ED2sv/aSoib9SThraDe3LLWC+DwhtXF9CKc8oA4E7Fy
	 XifHwYRGA3GTg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A66CD37BE;
	Tue, 12 May 2026 05:21:39 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 12 May 2026 08:18:15 +0300
Subject: [PATCH v2 01/16] dt-bindings: iio: adc: mt6359: generalize
 description for mt63xx series
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-mt6323-v2-1-3efcba579e88@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778563297; l=1032;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=AYn0XjU2ae/zdyiw0ViO8BkZaJAkv3YZ+5qK7y/nM24=;
 b=cI500HfBOYi++fLA+j7kNShbO0dyyIKQxeQSrjaUgFR9GTRMwmDJB7zwlbjlnlYUZoyOvdEa6
 AVYu5CxEPWeAaImMRcxt2YYlc0zSb+PzjPNQpDJ65J7x39j+q8wrbHw
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Update binding title to the MT63xx, since the list of compatibles already
includes mt6363 and mt6373 which don't belong to the mt6350 family.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
index 5d4ab701f51a..2e8857e104f5 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/mediatek,mt6359-auxadc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: MediaTek MT6350 series PMIC AUXADC
+title: MediaTek MT63xx series PMIC AUXADC
 
 maintainers:
   - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

-- 
2.54.0


