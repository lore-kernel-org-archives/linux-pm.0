Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB6356778;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563301; cv=none; b=Mb0gpkm8scFif0Ki35w9opcUiC9dX2j3YWINPCiQWKQb/l6MTWKTdmh0MHgnvHmqrD6VUmTZ56hN+LH4FbXXDtDhmDW7iEI+ZBut9me8uc6aSJvxPmUTa+GqU5RqY2D0gBF5hQzQeBpDsUPu81VrngBM6v+2P7p28kkuIuozkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563301; c=relaxed/simple;
	bh=DE9DtCJhXP2BqElPVUX9ed0zgo/XCG9/i5jncW01HEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LtkHpEo3XWyZ0vnwuBugwu3V3CcN8ZfEeN6rFVIcEsMGxTkVMrHG1egxYilHZJNtiXdgolI5Uywx0CRir76Sz5CkI4nzeDa9ieHMJZeSsbvzIn/B3Isthy4OBbaUXjAXhfjfke+D/rxlfaAULP6Jn30NDBgvcKB4J9mzsQSKkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffbE+zGJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffbE+zGJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C2EDBC4AF1C;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778563300;
	bh=DE9DtCJhXP2BqElPVUX9ed0zgo/XCG9/i5jncW01HEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ffbE+zGJGCHr1lAYaJIR/6oJ9iU8LBZco0x0Tficx6r89p3Ly9zrEUzOegHrxguyd
	 qHOFT0POxaO7S03I4cgc5yZAMDRAxQMQUTC+PSZMlg7Sc9MqOP47JUX3lhYI8vlfz0
	 1Z1N0vv49imKJnADYpeKZgJ64GuxN+VSrNbwbHBlIPhOt5Gje3Y6ndZwiOjtzacyzB
	 u1OgH0DaQFIpcE3UDC2lkylIhQu73XPQ4DgTiGLjb+ZEPjN/X1oRY5FOEN3IA+X+uo
	 xGyojJehRUPIHVHvqr2OciQ/LU5bh5uM5XXFGg9qkbjq16PyZ+02f0ZpaoCFb7WBCU
	 WJLAoViSUYHIA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9373CD4F24;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 12 May 2026 08:18:30 +0300
Subject: [PATCH v2 16/16] MAINTAINERS: add MediaTek mt6323 PMIC thermal
 driver maintainer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-mt6323-v2-16-3efcba579e88@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778563297; l=692;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=8NVcmhjcZUhwoicnOrm6owXnni+d+cpxkUFwQ33c1Hk=;
 b=WuN6e8eFt0NDrjantucW+k4aytcYOhKb5NQLI+Q1K4YIL4RECU79bvOV8PH7sNGpbJyeE4bU4
 iSn4SKfdH5aBINvQ7Sxh1OHbZdW6DFMOJXAR0+SgjlrMcnNwh/x96mn
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add myself as MediaTek mt6323 thermal driver maintainer.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf2e066f377d..3001a713b083 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16355,6 +16355,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
 F:	drivers/leds/leds-mt6323.c
 
+MEDIATEK PMIC THERMAL DRIVER
+M:	Roman Vivchar <rva333@protonmail.com>
+S:	Odd Fixes
+F:	drivers/thermal/mediatek/mtk_pmic_thermal.c
+
 MEDIATEK RANDOM NUMBER GENERATOR SUPPORT
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained

-- 
2.54.0


