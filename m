Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A213F3A4F46
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 20:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296056; cv=none; b=qn0oBEk/YfmtQ3XgQss0sCxcCN5JgIEg8K1dV+IUD6KCnyEyGSFxELkCfQ12DoPloW0R8McoygSY8vK/u/BmLc1o42C5uTCWbw61DYDgU1f9+gralNR5Jta8hQd8/BUXOUFpooJL0aC3o0k5nEYUigPjH1DsoXIwvv3/dlExbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296056; c=relaxed/simple;
	bh=CR0Lbo3n/3oeNiXmZXBO+NYu4WLlnQ0plwOZWYPDaYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxcaE78JQ2bHl/VnxC3vy9EPPFJDJSk+Y/miI8FYibAplVyqprcvBvyOanzmPGn7ZDL+WDyJkc13pWeIFmJaZJ4JM7qt7jSA8RznIsEFeChJvmBHWUtutlBihBu7Svbj2jZiiX/3cQLOHDpQRRAP6aIL1gYXuuIUdRWuAzL8iqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX3X4XwD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX3X4XwD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so14376725e9.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 13:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781296053; x=1781900853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2uiu84fLHByfY8NkkF/LaIKJoh0XbICVZ1vVfqMiiSs=;
        b=FX3X4XwDidk+/aBHU4zOsuu8EexfnnSbElbBLzbr5DlEHYw8iAEGatYAm1PK+VQov2
         GET0WP1+3RjZN2XqIWln8ct0z1Bh+1oiXP7isYi7mB7+YrNR/D7Z0fk2JJrZf6S6hdj1
         N29LOQmumTxN07mnPsukXeTdFt5XAZ5uUVM4MYWlx3Mh9jHhxvbyRMLURbjcrhhJrxf6
         mfuU4VQL1RA1rr+y7FhOzn/6bg7yMWnacPLhDS3+Yhj+IITX60JG/oXRykNbQ8bkp8FX
         vLFepW0ZrjEx6o/zMWcz0VGyTM7LD8Pg81Hi8Enbnf/majjfw18Yt7z+wlEdlnGoU1qD
         6eUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781296053; x=1781900853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2uiu84fLHByfY8NkkF/LaIKJoh0XbICVZ1vVfqMiiSs=;
        b=QAc325O5s3we3qEML228w+VV7o1trGlIig5K2lwqiDFDzN94gWllJHlyBUria5y7Kv
         A4RRlPJSV9+Xbu4fMJTQW/CD4Be7LbT9SCH2yGrDKHIlOqERtuQHF+k98KoQfcat37ke
         Rj1IC0ZHQobBlKjVw18WbZl8KIRduz72Lk9nb6SlTdq1GgfQXZCn/se/jvXbahpZNZDD
         An73nMxzqqUlBkj+HUTN2jE6LcTEUI8MzVdxDU2SFFK0QzNlHLBn3nXxDH/IeobcMITZ
         lRkNQZ68bZZeYAEMC9dRzxMYScOBjB/5YJTTMf7jPYBdwg8R8uQ6mxi2FzjwV5BGVbuQ
         oedg==
X-Forwarded-Encrypted: i=1; AFNElJ9Hjnhi+FyyBTWESW5+o2xp86Uoyj1df8ATUYu0o7xJFuGCTWM4tvlxwRyqyqF/FnK3aZduIXA6RA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+ECIWYwRtQYkL6Mlljy7Ezx6Gd2YaKhNvFnoQNpePoy7q0dqS
	E7PDuXwiuJthxppxh5K+14VwedKtd4/QvAfAcU7TuO3TdiZLduVHWL/H
X-Gm-Gg: Acq92OF5js6FnB6xRrDsqrhHhfXzkyR0sP1TJczJefuem2yRvnJv/B1vWAcGqYGDr6y
	VYz32HTP2oySG1tPtCbGFB9/xEqKRlxPcIXnW1QnQUskjnRszc+2ThyzJhfDKQKKvsz0XH3zHAb
	qRN6IUhNMRJGW6r1CQZP45jP0Ug5VCi7B+LtifZ82Gexhll0XGe7pMIMD2mSWHGXaW7nm9GA3EV
	h/+Q7WEZOT7sKdDpGQe7DmHXUXPPDjtAb5L4RmbaNiYup8DQ0bADbtnRo/7T+Qn9pEiFwmegVa6
	wOBOa7SkajGgOoTzEYFNvBj0bTafbPhKYVTMxZ9BNJk/sp3uPwyclI1vKUU/xjxV3tb1zJ4BRNL
	FGSVLQkSkhRK53nPmdPB3S36YXkU6sPsC1AqJHf7PvMqiPJFBWJyVPb8Rlud/w3K9/BAt/cK9Cx
	hILGrQlOBKqfTXTsvc
X-Received: by 2002:a05:6000:428a:b0:45e:edcc:f6dc with SMTP id ffacd0b85a97d-4606db9667amr6456265f8f.6.1781296052923;
        Fri, 12 Jun 2026 13:27:32 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm9173261f8f.1.2026.06.12.13.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:27:32 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v6 7/7] arm64: dts: mediatek: Add MediaTek MT6392 PMIC dtsi
Date: Fri, 12 Jun 2026 22:04:12 +0200
Message-ID: <20260612200717.361018-8-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612200717.361018-1-l.scorcia@gmail.com>
References: <20260612200717.361018-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Val Packett <val@packett.cool>

Add the dts to be included by all boards using the MT6392 PMIC,
providing support for keys, pinctrl and RTC.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6392.dtsi | 41 ++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6392.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6392.dtsi b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
new file mode 100644
index 000000000000..b8d943e47816
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6392.dtsi
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ * Copyright (c) 2024 Val Packett <val@packett.cool>
+ */
+
+#include <dt-bindings/input/input.h>
+
+&pwrap {
+	pmic: pmic {
+		compatible = "mediatek,mt6392", "mediatek,mt6323";
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		mt6392keys: keys {
+			compatible = "mediatek,mt6392-keys";
+
+			key-power {
+				linux,keycodes = <KEY_POWER>;
+				wakeup-source;
+			};
+
+			key-home {
+				linux,keycodes = <KEY_HOME>;
+				wakeup-source;
+			};
+		};
+
+		mt6392pio: pinctrl {
+			compatible = "mediatek,mt6392-pinctrl";
+
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		mt6392rtc: rtc {
+			compatible = "mediatek,mt6392-rtc",
+				"mediatek,mt6323-rtc";
+		};
+	};
+};
-- 
2.43.0

