Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D56386550
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 21:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721045; cv=none; b=WJbqpufAqcVxrj0odS458LzenAwdyqWwOJ41mzhlY+y1jKKVW819Kl2e/N45uMOJLX5tBkdXIkgf40V/g7yYgRVjb7RQAKkt0mfosn6lwsJ17igq9iz4OUkye5X2VCNbjEPJpohiCax6+AC1DRVSxV00Pxnw2paTOsoU3qL57hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721045; c=relaxed/simple;
	bh=ul1QjKwQ15j90vxyJdXpWoxbkcZndJ0tR3VW3k92AL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meWBXGeDplmfdzASo/tPtb3ca7Xrg3FWOwCR24P5PXnC97+9tjMpBQPqhZsokcGKutg5vT1QLw2zL6mXE+MaBHdrVT3J1mb6hd5GtMY4BNTiiL2tkQ3Sr/imETfLGWnz9Z7qCo53zAyXtNHb8ZCYoDOmjXEA6C3BqSmZDcpQ6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuC2fVbc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuC2fVbc"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b8bc6bc9so24571205e9.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 14:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776721043; x=1777325843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ozJhRqHV7vShx8fI9wXW10pkaLTm6Vl4wo1OcZafVU=;
        b=XuC2fVbcV1FDzmcn+r8WeXbXJV71p0ZjjCvbowVEnVCeuJrDQKWXt3qSeOv2m9F69E
         iO35zjFaaAbtbrJGZEwqmpscbXSIoX4ZpEs5JH1x0Hz5Kzmu1b4qLTYVLjHCq2T+98d2
         gBBav7SoADYcHtLrHcxwhfHlUR1XwdKajsSpsYzPLVPbsC03+a+QVrbuJ+zN8xS0aFhY
         2gE0BwPXqgyrAnrkkvdalImqYi/uMFgxlqZaNJBOTKr+EFDL5PKmW/Wi48hp4Im+gGPo
         4/9sD7q9r6xPL8uZPfRx+5U47S3OR5UHw/4/sONsMnBC//yKUNH/Jx90uR+pJ6ydPn44
         H/hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721043; x=1777325843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ozJhRqHV7vShx8fI9wXW10pkaLTm6Vl4wo1OcZafVU=;
        b=KshOIY5YgzTFrsPHJFYHzREMz6ZzytPg1ZonwOm5qSvlQib6fTYcbK2rReIg6hAH1T
         xq+lVoIuE2mwCtMrwVFPotEnpJf8Vx4trLsU6nzE2G6dT2hqUkygW53MFYyGOgojduhy
         Qr/31PD0s12MfYXGbej3ZGebDSCFpjQalgYIBfH7UK2nc/lwDj6fXkETukhIu7iZ4RV8
         WrAg/yUPNItE5qx/9vsmOnX9CsusWROdS12jhaHW6zNfwpe055a90azFxVFl++xVBfvm
         d6Q9JxcCAqT2me7W27yquJ6GfZVDwyr/iTNhWzjHTtw+dsy6hNKAGoq56PHrxiZ0jTRz
         WeeA==
X-Forwarded-Encrypted: i=1; AFNElJ8RZvcCj0ChgpLDVEtiIjgMBcQk/d2doy46RbRJzi0Sct55zNrM08KFUnQnXFySOXdlVlc0b2DbyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YysgvVoTYv5D5onbNp5JqIFQH8OY+KXZdm1Mz8mIibkkFZqj+ky
	Q16iMQlRP7U8dQPKnbVeFIw5JU4sOjEWNHx6uORWyfZI9EbWpNVEkpWR
X-Gm-Gg: AeBDiesvI4X4RZxyE6JVSoj29pTfeMeOCFtzduBfnnmNaKDaadYe9B0RCZRILFbtrvG
	VoKHThUe5jPHk0mXEwKKFMXybYgZMvHN1q1vbDcqexpoRZXyDZuUUbpMzjlpkSpSTLUFS4hKCLH
	jr6P5k7bqaMA8W6wWXF9k9buHFHkjMUB3G7XPgmGIr+IN2TdoeyT95t71pk2QpEwqt+E+/6nqOZ
	ryWThiLqXxP8D3VXrLMwGRbssqOAVAylq7erQWnUxrMvyRJUAtOkVs82wdb+p0FCqNfEnj2EnmM
	v52zAw0krtNbMit7z9LH2bYuHZtQlpRtpq7eQ2g8HxXZ39+gthQRFJQ0SRZzxcVYhYxeCtu3Jdg
	mpdjXDVwVAgkjPsdgJZyhXPAPs6s6/dutoEUoLxYhCzFYd3QJnGdA6Usb1m0tJMEtqwMDF/qOQR
	QmP+tdIOjnk1ZThTb8KrJWiAtPAsQ6Wg==
X-Received: by 2002:a05:600c:6296:b0:488:c40b:c8a4 with SMTP id 5b1f17b1804b1-488fb73d764mr213394625e9.1.1776721042584;
        Mon, 20 Apr 2026 14:37:22 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm289500355e9.12.2026.04.20.14.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:37:22 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v5 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Date: Mon, 20 Apr 2026 22:30:02 +0100
Message-ID: <20260420213529.1645560-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420213529.1645560-1-l.scorcia@gmail.com>
References: <20260420213529.1645560-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add bindings for the regulators found in the MediaTek MT6392 PMIC,
usually found in board designs using the MediaTek MT8516/MT8167 SoCs.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../regulator/mediatek,mt6392-regulator.yaml  | 76 +++++++++++++++++++
 .../regulator/mediatek,mt6392-regulator.h     | 24 ++++++
 2 files changed, 100 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
new file mode 100644
index 000000000000..f62bd94bd42c
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/mediatek,mt6392-regulator.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT6392 regulator
+
+maintainers:
+  - Luca Leonardo Scorcia <l.scorcia@gmail.com>
+
+description:
+  MT6392 is a power management system chip containing three buck converters and
+  23 LDOs. All voltage regulators provided by the PMIC are described as
+  sub-nodes of this node.
+
+properties:
+  vproc-supply:
+    description: Supply for buck regulator vproc
+  vcore-supply:
+    description: Supply for buck regulator vcore
+  vsys-supply:
+    description: Supply for buck regulator vsys
+  avddldo-supply:
+    description: |
+      Supply for AVDD LDOs (vm, vio18, vcn18, vcamd, vcamio). According to the data sheet
+      this is an internal supply derived from vsys.
+  ldo1-supply:
+    description: Supply for LDOs group 1 (vaud28, vxo22, vaud22, vadc18, vcama, vrtc)
+  ldo2-supply:
+    description: Supply for LDOs group 2 (vcn35, vio28, vmc, vmch, vefuse, vdig18)
+  ldo3-supply:
+    description: Supply for LDOs group 3 (vusb, vemc3v3, vcamaf, vgp1, vgp2, vm25)
+
+patternProperties:
+  "^v(core|proc|sys)$":
+    description: Buck regulators
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        description: |
+          BUCK regulators can set regulator-initial-mode and regulator-allowed-modes to
+          values specified in dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 1]
+    unevaluatedProperties: false
+
+  "^v(adc18|camio|cn18|io18|xo22|m25|aud28|io28|rtc|usb)$":
+    description: LDOs with fixed output and mode setting
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes:
+        description: |
+          LDO regulators can set regulator-initial-mode and regulator-allowed-modes to
+          values specified in dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 1]
+    unevaluatedProperties: false
+
+  "^v(cama|dig18)$":
+    description: LDOs with fixed output without mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+  "^v(aud22|camaf|camd|cn35|efuse|emc3v3|gp1|gp2|m|mc|mch)$":
+    description: LDOs with adjustable output
+    type: object
+    $ref: regulator.yaml#
+    properties:
+      regulator-allowed-modes: false
+    unevaluatedProperties: false
+
+additionalProperties: false
diff --git a/include/dt-bindings/regulator/mediatek,mt6392-regulator.h b/include/dt-bindings/regulator/mediatek,mt6392-regulator.h
new file mode 100644
index 000000000000..8bd1a13faad8
--- /dev/null
+++ b/include/dt-bindings/regulator/mediatek,mt6392-regulator.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_REGULATOR_MEDIATEK_MT6392_H_
+#define _DT_BINDINGS_REGULATOR_MEDIATEK_MT6392_H_
+
+/*
+ * Buck mode constants which may be used in devicetree properties (eg.
+ * regulator-initial-mode, regulator-allowed-modes).
+ * See the manufacturer's datasheet for more information on these modes.
+ */
+
+#define MT6392_BUCK_MODE_AUTO		0
+#define MT6392_BUCK_MODE_FORCE_PWM	1
+
+/*
+ * LDO mode constants which may be used in devicetree properties (eg.
+ * regulator-initial-mode, regulator-allowed-modes).
+ * See the manufacturer's datasheet for more information on these modes.
+ */
+
+#define MT6392_LDO_MODE_NORMAL		0
+#define MT6392_LDO_MODE_LP		1
+
+#endif
-- 
2.43.0

