Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC36332EAC;
	Tue, 12 May 2026 05:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778563300; cv=none; b=XFb9q1vLRDOzNS9jpXgybEL9AWOmaqo5MBSqMbqdizgG2cAyifrSEOxCt1wmjp9LlfW22IfRQHWjmUhGPAORjBo5mAqrWReXwMAAY4DH+2psgAuteJdHAvlb9OzFvOwNOWJ0eJmJDSEwQYwrsXU+I7rB+JVqNsLdQrEUYEtb+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778563300; c=relaxed/simple;
	bh=cKlVGHgwvxxFs65BuqQmOweMlwKGCUXsVAlz1lHfpVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IKD/dMYmSLeh82Cl3+YM8OUWkmZLJCSuNdn892PXtIkWCBmd9P+3zvXaoD9vQkUaSlp6jbb3is85jTEdL0t+Oef86pWhScGFj9kWLw4pq8kiwC1ApG4yj3trqGRQ89BedtMaHQa23VhgY6SL/pffdvQpfOLPT6RgkF3md4gNZ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHxkA13J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHxkA13J"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BA444C2BCFB;
	Tue, 12 May 2026 05:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778563299;
	bh=cKlVGHgwvxxFs65BuqQmOweMlwKGCUXsVAlz1lHfpVg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VHxkA13JMtxu7FhZ32YOJtIJaNmm+67DbhqCqyjfmPpQe4V+OMVg4OoHhwUqTAvEA
	 rA8S/tR+Cdn8yWHyz7NamVenrR8V5+kyiC1cQtyJgwwRaGNCfcGDNyzTefp8uI2gsV
	 +FSYiZ8qs8wHyRUd7UcqJvgbk4uFIw0VCYFyaCKTWwomlI0aNT9xg2W4oTeOWMtAGp
	 ceS2RI3GtU+O8kIi95FQpC/d04qPHbw5dJXSZg7SnyZNDs/+88UIfoZdocxxwTsHjT
	 jQriurubgfjDKSuIGP/so9te85qaMbbN+Fglma786eYIXM1E7oMk7rrT1IIVeYXIKy
	 69bSuyNH9MmiA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CC5CD4F21;
	Tue, 12 May 2026 05:21:39 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 12 May 2026 08:18:16 +0300
Subject: [PATCH v2 02/16] dt-bindings: iio: adc: mt6359: add mt6323 PMIC
 AUXADC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-mt6323-v2-2-3efcba579e88@protonmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778563297; l=2076;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=c+cho/PX2cVaRg83PkB7K4s9HbnpwnddIKtcnK+QK9k=;
 b=W7KS0FHZxgzCrz3uoUR4XNBLsEDNUbCPF9yCBrCkA6/sQUCqk5mobEFYHMenvIGL1QQYOBSqf
 ftGX9yLmp7bD0duUSPjiUK2UC95xLJR11EZkRen5tQbZ1DTrigd7T99
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com

From: Roman Vivchar <rva333@protonmail.com>

The MediaTek mt6323 PMIC includes an AUXADC used for battery voltage,
temperature, and other internal measurements.

Add the devicetree binding documentation and the associated header file
defining the ADC channel constants.

Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 .../bindings/iio/adc/mediatek,mt6359-auxadc.yaml   |  1 +
 .../dt-bindings/iio/adc/mediatek,mt6323-auxadc.h   | 24 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
index 2e8857e104f5..1cafc314b8ab 100644
--- a/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/mediatek,mt6359-auxadc.yaml
@@ -19,6 +19,7 @@ description:
 properties:
   compatible:
     enum:
+      - mediatek,mt6323-auxadc
       - mediatek,mt6357-auxadc
       - mediatek,mt6358-auxadc
       - mediatek,mt6359-auxadc
diff --git a/include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h b/include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
new file mode 100644
index 000000000000..6ee9a9ecffc1
--- /dev/null
+++ b/include/dt-bindings/iio/adc/mediatek,mt6323-auxadc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_MEDIATEK_MT6323_AUXADC_H
+#define _DT_BINDINGS_MEDIATEK_MT6323_AUXADC_H
+
+#define MT6323_AUXADC_BATON2		0
+#define MT6323_AUXADC_CH6		1
+#define MT6323_AUXADC_BAT_TEMP		2
+#define MT6323_AUXADC_CHIP_TEMP		3
+#define MT6323_AUXADC_VCDT		4
+#define MT6323_AUXADC_BATON1		5
+#define MT6323_AUXADC_ISENSE		6
+#define MT6323_AUXADC_BATSNS		7
+#define MT6323_AUXADC_ACCDET		8
+#define MT6323_AUXADC_AUDIO0		9
+#define MT6323_AUXADC_AUDIO1		10
+#define MT6323_AUXADC_AUDIO2		11
+#define MT6323_AUXADC_AUDIO3		12
+#define MT6323_AUXADC_AUDIO4		13
+#define MT6323_AUXADC_AUDIO5		14
+#define MT6323_AUXADC_AUDIO6		15
+#define MT6323_AUXADC_AUDIO7		16
+
+#endif

-- 
2.54.0


