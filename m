Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF25C4AD7D5
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 19:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377716; cv=none; b=PJNJPqw5YKU1STsO7HZFnp2d7qlvV0U9+lnZXSvLrJKoGZg7guI/QURvAQIDGi5HAJL3NUqy1fP4rrubccGqvflf/HIbr2hbNbwfSXq+dDnDcmd28d6PU8Znn+EVP+M0+oc0QDp4qsL8tudH/3S/wyAu61ELlkGyg2w5mjU/nsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377716; c=relaxed/simple;
	bh=/+AZg6hP2XDv78PWt241IT+LpSwJDBWfvUMImlV1iL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbHE+aTyOIUWokscApcRf5J17n2ZcxrCYydx6iTg6OPL3uwR/2j6/65CB602rh9kFXA/FLBOMjTFcMnaf4zl94LFMBZfXUO80wTBvTVJtP0aTZcgvuOM/vmVbip+sAZ/summ3xEBYHGGf3t/6kEM3V4ooevrn4nN04C+weGhEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbUwDoHv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbUwDoHv"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48441a2ba14so1386223f8f.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 12:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377696; x=1788982496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=F23t8iLTcn/LXqN2lEEgBTUnPAkeyO0taUnuYVGHe48=;
        b=VbUwDoHv5akBMya+Og4X9Ghd8LyIzXLPT+bxt2ZntNFgFDXeIEAej7OQbHiUvNDZkn
         UF784JZ4UoS7LopBCGfszmqu31bCMuDKCfF4INbw2wjLwqmTU5E7abuidOeD7Z/cPqIF
         u7Q1rOujtm5pvd+EJlC1nbDDFK+Pwm0+NnQ8zMUp9p9Hr6HzSG061ZrXWWBySdk4/pu1
         WjGegwdMoDFdXVhwHx45Fruo60IlQxlHhIxmU9j9WRrEiC3TCUTQZ0mTYRuXueONlXLz
         4lJZ/1bw7xnEFH6BH2q51Vfsai0jWizvTbDDAJesyVpzP9HfB/iSTPLNU5Lq7a1hBddc
         tqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377696; x=1788982496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=F23t8iLTcn/LXqN2lEEgBTUnPAkeyO0taUnuYVGHe48=;
        b=aiJFyTbO6DBYtk3brhpQLzs7QygQT3tTTONnMIbhFA+Jbuny+lelKGArwRNm1oAUFC
         mDdjLIuYtuK5Y/dwWHdOTSge9rJ9wrTI+d2CgaW2+l5phRuMRTCoeibEjtUdBDzAIb6z
         gO5AUJrugfXQOauNslT58g2T8KfDsLyihBZVV+TwoFbWqNkyVN3oIfkGwC6/XZTrO9IR
         RO0Mj8J8IbAvbmwwTWaMr6akOVkZTrIiJtojF+c/6+k7A0oyAJqpNhZ9HHzxQbBDfifG
         AyhKopUZnoOxmqrE/5KCtmqr0e+I3YpHC7kwjSV8KklmWZKRMCNNuoZZJNOvwOMKksYc
         d5dQ==
X-Forwarded-Encrypted: i=1; AKwUvByBE0PWCgtd4Pwo4WwP3GUaoYtT0kvECKgNJkxIFQZr41vNi7USufARxOMiUunUh8d22ViYBCAL0g==@vger.kernel.org
X-Gm-Message-State: AFuF++kcyuc5TypuoDCSwQcpUM+ZSUiw7bhXkCH7tjCoBg4JtKzs6hYC
	uk2a3MCigcqZnG7bHZtNq5OvNhSCJ76rcgJ6oONh9Ho3pbiqAok8/9b+
X-Gm-Gg: AYBFou3HiCNiB0Ij49NTJZR2twoOhrtNx3p3S4xJF/r/nNBTGUFANLyqfKfndL+Oxgo
	OiU0JtCKjkDdR6fURUzdgQQexXlb6fo1lVZ31kEH5/VsG8zHfzYrm7Ycp9xRWaTBrJuWlCS6EBm
	tu8vcl/3W/8l0WyQG1vhDwIyWZv4sNQHhk55K50zKx4OLCTT0DSsxiwOHfLCbmRCYCtJufS3j9E
	h8FcyWumihZ4jRvbVQqiUB8x9lM07Tyl4ERz+uSn8JFK27x1Ri+XCZPznlQTHc4dYJ3NceoaqUR
	PHw0THCdLCtgoc5OvEHHRNGyete+kmwUa9kA8x2wFQdcRpxVuOnSBswQJXCZmEy5OUJIqy3j9bS
	wAyrnLnObNEc0nAroYeE9IudGrhlPxhu91a3sAEEhQmgFMDBY2mpqd+GbAGmH6u7hTtz7L7mRZP
	O7YVeS/V3YtpYFaXKsWFeO+SM82Xade0lc/9lvvqGkvjNzxnQfus7uCyXi
X-Received: by 2002:a05:6000:188f:b0:484:3d1b:7871 with SMTP id ffacd0b85a97d-48488f1b05emr14960874f8f.19.1788377695627;
        Wed, 02 Sep 2026 12:34:55 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm8889191f8f.34.2026.09.02.12.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:55 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Val Packett <val@packett.cool>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v10 3/9] regulator: dt-bindings: Add MediaTek MT6392 PMIC
Date: Wed,  2 Sep 2026 21:25:39 +0200
Message-ID: <20260902193351.185771-4-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902193351.185771-1-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../regulator/mediatek,mt6392-regulator.yaml  | 112 ++++++++++++++++++
 .../regulator/mediatek,mt6392-regulator.h     |  23 ++++
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
 create mode 100644 include/dt-bindings/regulator/mediatek,mt6392-regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
new file mode 100644
index 000000000000..d74721d8f2ff
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/mediatek,mt6392-regulator.yaml
@@ -0,0 +1,112 @@
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
+  compatible:
+    items:
+      - const: mediatek,mt6392-regulator
+
+  vproc-supply:
+    description: Supply for buck regulator vproc
+  vcore-supply:
+    description: Supply for buck regulator vcore
+  vsys-supply:
+    description: Supply for buck regulator vsys
+  avddldo-supply:
+    description:
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
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes:
+        description:
+          BUCK regulators can set regulator-allowed-modes to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 1]
+        minItems: 1
+        maxItems: 2
+      regulator-initial-mode:
+        description:
+          BUCK regulators can set regulator-initial-mode to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        enum: [0, 1]
+
+  "^v(adc18|camio|cn18|io18|xo22|m25|aud28|io28|usb)$":
+    description: LDOs with fixed output and mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes:
+        description:
+          LDO regulators can set regulator-allowed-modes to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 2]
+        minItems: 1
+        maxItems: 2
+      regulator-initial-mode:
+        description:
+          LDO regulators can set regulator-initial-mode to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        enum: [0, 2]
+
+  "^v(cama|dig18|rtc)$":
+    description: LDOs with fixed output without mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes: false
+      regulator-initial-mode: false
+
+  "^v(aud22|camaf|camd|cn35|efuse|emc3v3|gp1|gp2|m|mc|mch)$":
+    description: LDOs with adjustable output and mode setting
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+    properties:
+      regulator-allowed-modes:
+        description:
+          LDO regulators can set regulator-allowed-modes to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        items:
+          enum: [0, 2]
+        minItems: 1
+        maxItems: 2
+      regulator-initial-mode:
+        description:
+          LDO regulators can set regulator-initial-mode to values specified in
+          dt-bindings/regulator/mediatek,mt6392-regulator.h
+        enum: [0, 2]
+
+required:
+  - compatible
+
+additionalProperties: false
diff --git a/include/dt-bindings/regulator/mediatek,mt6392-regulator.h b/include/dt-bindings/regulator/mediatek,mt6392-regulator.h
new file mode 100644
index 000000000000..2e1f41e0ebfe
--- /dev/null
+++ b/include/dt-bindings/regulator/mediatek,mt6392-regulator.h
@@ -0,0 +1,23 @@
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
+#define MT6392_REGULATOR_MODE_NORMAL	0
+#define MT6392_BUCK_MODE_FORCE_PWM	1
+
+/*
+ * LDO mode constants which may be used in devicetree properties (eg.
+ * regulator-initial-mode, regulator-allowed-modes).
+ * See the manufacturer's datasheet for more information on these modes.
+ */
+
+#define MT6392_LDO_MODE_LP		2
+
+#endif
-- 
2.43.0

