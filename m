Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939333E9F96;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777919099; cv=none; b=Fs1osqDclblC2/MtfFE2GWMzHHJdeEeQJDznxS292lmdHp5IgrNKBiyyHYhMYVDgWa8XSxOBxcdAAVTELpY7gJiCFK44dbEtB9qmMkMqbmiYrbHmaR6cKsFy8s4DA1drKfDD4ap2aePW21px2fXyNUasP6465Dbtwt4DdAI4iY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777919099; c=relaxed/simple;
	bh=GU4QVvFihDtlJ6mm+kq5xGELKC7sNPpkFTI44o4I8MI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tg5vgugjjMu66J4gpRY3hKGDiqUDG8HamRwC0Bg7hdDbJ9tl3RoF1RzO6Q4Cgn/rGOLrzpcYruznC+ePgtJQxBQ4mnvaOyQIT3Df/ilkgz3UUTwdc/b7Hx2Q6nBVL0kO0Oe4NVAO5FuDdPF+YHvGhKd/lFFjxvT4fOe0oS1JqTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9Ag+iZ6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9Ag+iZ6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 68059C2BCF7;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777919099;
	bh=GU4QVvFihDtlJ6mm+kq5xGELKC7sNPpkFTI44o4I8MI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X9Ag+iZ6EZ0Y9BhoLfKnpEnIALv2h9odzKx1MQa6gN3R4nPeT+Mg14hbROmo6pYpX
	 1D/rwHCrc6C3HDrW5T2Uy3rBEJV20kI/nGEzGDOEes1136K3j2CmnIoxmb8teJYgCU
	 g5e09B5HRQTa/k4t/rT5faGXoxmrjN68/cuzWxk0V8e0YvWVPkfjJbXP9yuRfgVu7w
	 2opD4o562Jl+PugOLcz1xFjac8bFQZVNiayyEPWj+1GzL4M6MGDw3BD8fOmKDFVdvm
	 x2bAriTyQYWJvKlNmU4bSg120cwOwYHVqVkuFR/Wtg+L61wSjRgZwugJGYgZbntZ5o
	 82ZsExigdrvIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B48DCD343B;
	Mon,  4 May 2026 18:24:59 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Mon, 04 May 2026 21:25:05 +0300
Subject: [PATCH 13/13] MAINTAINERS: add mt6323 drivers maintainer
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-mt6323-v1-13-799b58b355ff@protonmail.com>
References: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
In-Reply-To: <20260504-mt6323-v1-0-799b58b355ff@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, 
 Ben Grisdale <bengris32@protonmail.ch>, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777919095; l=1438;
 i=rva333@protonmail.com; s=20260325; h=from:subject:message-id;
 bh=IVcMJZ09jRgz+N+6u0mZ3SGFnZp8AgopNcJEHOCTJNc=;
 b=sGOiE3hgm56BrjQDzKGAj+m/O2IVz15/wAVId3APq3ZRUTQQDfaPwGa8RgJBYGeN7nDaBwYvr
 f0PDwqQvQRvBN/Or0xUv3NBMufyq8nsAz59qQxiQOJSsQ4iB3uMLrae
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=euuVBZGtA2Cqb8Dju84qpQPhvwxyUirJlXpqEPQWKBM=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260325 with
 auth_id=695
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

Add myself as MediaTek mt6323 AUXADC, EFUSE and thermal driver maintainer.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 MAINTAINERS | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..53493a24d00a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16337,6 +16337,18 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/mtd/mediatek,mtk-nfc.yaml
 F:	drivers/mtd/nand/raw/mtk_*
 
+MEDIATEK PMIC AUXADC DRIVER
+M:	Roman Vivchar <rva333@protonmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/adc/mediatek,mt6323-auxadc.yaml
+F:	drivers/iio/adc/mt6323-auxadc.c
+
+MEDIATEK PMIC EFUSE DRIVER
+M:	Roman Vivchar <rva333@protonmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/mediatek,mt6323-efuse.yaml
+F:	drivers/nvmem/mt6323-efuse.c
+
 MEDIATEK PMIC LED DRIVER
 M:	Sen Chu <sen.chu@mediatek.com>
 M:	Sean Wang <sean.wang@mediatek.com>
@@ -16345,6 +16357,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
 F:	drivers/leds/leds-mt6323.c
 
+MEDIATEK PMIC THERMAL DRIVER
+M:	Roman Vivchar <rva333@protonmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/thermal/mediatek,mt6323-thermal.yaml
+F:	drivers/thermal/mediatek/pmic_thermal.c
+
 MEDIATEK RANDOM NUMBER GENERATOR SUPPORT
 M:	Sean Wang <sean.wang@mediatek.com>
 S:	Maintained

-- 
2.53.0


