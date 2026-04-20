Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F76382F0A
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 21:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776721074; cv=none; b=aU3DsSQ9UEf4RF++0tws18ET64/MvVcZdJKlLiU0bKLJkV2co4gfGugUnWtJKg9To65mpdOdpvP6aotcjZ5Qy9Mf831JmqJwYQBnFY3TeMTsYwc5J/+uiaCYnCqxNCkHNUMl5h3aU8w657HNeiTLXgfIzkVLY0TTOObcap0MCf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776721074; c=relaxed/simple;
	bh=ONzx1TVLssQ2quIYxWPdg1+c0cg1jkFrd/S0xZj62AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNtGGpIdxtQme6AW7I2hyNeLSL0lXY97XKZSJYQJ2VaSVP5qRIGCaTOlAv3RPzo+o4+8/BNPIchaqVP11zwp57iWbyWNJL+gjNDJs2rMePm6AX7ljKC3MPpAZPsfRzDPLTu/fcTjKes6d+Sri8tYEu5dCL/2laPReAp/opL2ohk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AgJXUVJ+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgJXUVJ+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852a9c6309so31273985e9.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 14:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776721070; x=1777325870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FkjylHhPY5Zp4sZf/mKL22KMI1gZWywJJ0iSsDcvxlg=;
        b=AgJXUVJ+fQmuigUW1WebP5+JaMMx3d4aUe08m8Doio5aOt6APm25qQce6HDe0zARmY
         LqVqjfYsainkg/8xwx65gRR8sT9iF2tMkIrjCp//0gFm6MAjkQS/k9KmYdSTBq23Pev6
         +m7+MOMHzXVOmwfUYWT1amQYoNJj/X/K2DNrbbnVnWikGEV/MNDiEjW7KXw/JFlqiDQ+
         5hbJ+SgcCr0jv+Znf3Pq0NlfkcxJi07VUkTq6BD6lC5i8vY0n5UfGjD3daLm8nK9rIAo
         ipfdJ/aqXuQX+YDdm1obiaNrBZY4uLJwj1yi7FyBstyGmkI3y48dCCZrG25uvReFt5n7
         UPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776721070; x=1777325870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FkjylHhPY5Zp4sZf/mKL22KMI1gZWywJJ0iSsDcvxlg=;
        b=gbTDGPCcwj4ZXcq4wmChfup2k/DwcWaXa+fjOEuaFUPt9CwbK70ZJG8lyDG3ZtGsJd
         0Ea0RUBSCSZvBl+qQv1VkqZclA3XH2ogZ11G9AJEMpDM9LLzkp5JBI+6SugiY594P/Pj
         7DJMsCv+AYRQryRSOj6qtzQtCnZOt2o+SdFPnl5iO0OBoIemAyIIbmnxmxSX68G/3Oyv
         Sikj7LNwwKtQaH41c4x1qxTII/HFhS+/g3xgHTNPtCYvIuRNB3jr9NoHXqSId0njXM8B
         AAYOObdE8jVuii68DUb/4YH3BRz6RmFyhrvBM1s/DdiQtUoTWMKIUfy0+LLmipvantMH
         RAjQ==
X-Forwarded-Encrypted: i=1; AFNElJ8XOAdDERF6u+ogz/hOwZn6iPamja22Jttj5TPFHC316vWz2VFzyiXt9fWNpcVjfXizC+uSHev+Yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQcpdKK1sFrlm/rb+wg3Hc3GOeT/EgawmxM3zOGkNljAOkI48
	jiDTFB5uIutZNHtNOWrl5vIJ4rmHaxTjRV7OMpeiAaZhzcCDNiF7SdJg
X-Gm-Gg: AeBDietRXMqvwPaqQFcjN/fZ9D6flESfUF1mAdNNPo9cPuthQHIV+O0puVveSQeB3sa
	nCyhED/2WHgOlrbblQio82/8gmF18pJmewL4DY/aF/6nbzIkkNq0xnVIMmS9yD6QTxtRbLgNiNg
	OcuMDAhX6+J58j5erI3KNEZppyQnODyK4voGrSADcXX8eyzyoJGIhtjd+QLawkLpr2+LRh46E4d
	Lbnc6F7b63zx+wn8CYJqooA1Nt5CSlBSLhDFYqhRF9rRkvGZBLQe3IotVX6Q3FLt9ES0h0E6dV/
	pB/ctQNYjak0fidDTDvetLO1bSiC0W8KNa5i2dRWY3iZ4VXulFProA7NTiAIaNjq/YBAuuxNanm
	Us5KtTUhLxQPjgVuA6ekZm73R4RI9fH2M+Y7NF7L8y9Fd5iibuFL51y4VUcdHn+TLutbgA4cTyy
	T2VFKUM4Tgew6/RU1Z01prpBw+RhizwA==
X-Received: by 2002:a05:600c:8115:b0:488:ac01:72b6 with SMTP id 5b1f17b1804b1-488fb77d7d3mr178338515e9.21.1776721070421;
        Mon, 20 Apr 2026 14:37:50 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc140c82sm289500355e9.12.2026.04.20.14.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 14:37:50 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
	Linus Walleij <linusw@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Val Packett <val@packett.cool>,
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
Subject: [PATCH v5 4/9] dt-bindings: pinctrl: mediatek,mt65xx: Add MT6392 pinctrl
Date: Mon, 20 Apr 2026 22:30:03 +0100
Message-ID: <20260420213529.1645560-5-l.scorcia@gmail.com>
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

Add a compatible for the pinctrl device of the MT6392 PMIC, a variant of
the already supported MT6397.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../pinctrl/mediatek,mt65xx-pinctrl.yaml      |  1 +
 .../pinctrl/mediatek,mt6392-pinfunc.h         | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
index aa71398cf522..1468c6f87cfa 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - mediatek,mt2701-pinctrl
       - mediatek,mt2712-pinctrl
+      - mediatek,mt6392-pinctrl
       - mediatek,mt6397-pinctrl
       - mediatek,mt7623-pinctrl
       - mediatek,mt8127-pinctrl
diff --git a/include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h b/include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h
new file mode 100644
index 000000000000..c65278c8103d
--- /dev/null
+++ b/include/dt-bindings/pinctrl/mediatek,mt6392-pinfunc.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef __DTS_MT6392_PINFUNC_H
+#define __DTS_MT6392_PINFUNC_H
+
+#include <dt-bindings/pinctrl/mt65xx.h>
+
+#define MT6392_PIN_0_INT__FUNC_GPIO0 (MTK_PIN_NO(0) | 0)
+#define MT6392_PIN_0_INT__FUNC_INT (MTK_PIN_NO(0) | 1)
+#define MT6392_PIN_0_INT__FUNC_TEST_CK2 (MTK_PIN_NO(0) | 5)
+#define MT6392_PIN_0_INT__FUNC_TEST_IN1 (MTK_PIN_NO(0) | 6)
+#define MT6392_PIN_0_INT__FUNC_TEST_OUT1 (MTK_PIN_NO(0) | 7)
+
+#define MT6392_PIN_1_SRCLKEN__FUNC_GPIO1 (MTK_PIN_NO(1) | 0)
+#define MT6392_PIN_1_SRCLKEN__FUNC_SRCLKEN (MTK_PIN_NO(1) | 1)
+#define MT6392_PIN_1_SRCLKEN__FUNC_TEST_CK0 (MTK_PIN_NO(1) | 5)
+#define MT6392_PIN_1_SRCLKEN__FUNC_TEST_IN2 (MTK_PIN_NO(1) | 6)
+#define MT6392_PIN_1_SRCLKEN__FUNC_TEST_OUT2 (MTK_PIN_NO(1) | 7)
+
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_GPIO2 (MTK_PIN_NO(2) | 0)
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_RTC_32K1V8 (MTK_PIN_NO(2) | 1)
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_TEST_CK1 (MTK_PIN_NO(2) | 5)
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_TEST_IN3 (MTK_PIN_NO(2) | 6)
+#define MT6392_PIN_2_RTC_32K1V8__FUNC_TEST_OUT3 (MTK_PIN_NO(2) | 7)
+
+#define MT6392_PIN_3_SPI_CLK__FUNC_GPIO3 (MTK_PIN_NO(3) | 0)
+#define MT6392_PIN_3_SPI_CLK__FUNC_SPI_CLK (MTK_PIN_NO(3) | 1)
+
+#define MT6392_PIN_4_SPI_CSN__FUNC_GPIO4 (MTK_PIN_NO(4) | 0)
+#define MT6392_PIN_4_SPI_CSN__FUNC_SPI_CSN (MTK_PIN_NO(4) | 1)
+
+#define MT6392_PIN_5_SPI_MOSI__FUNC_GPIO5 (MTK_PIN_NO(5) | 0)
+#define MT6392_PIN_5_SPI_MOSI__FUNC_SPI_MOSI (MTK_PIN_NO(5) | 1)
+
+#define MT6392_PIN_6_SPI_MISO__FUNC_GPIO6 (MTK_PIN_NO(6) | 0)
+#define MT6392_PIN_6_SPI_MISO__FUNC_SPI_MISO (MTK_PIN_NO(6) | 1)
+#define MT6392_PIN_6_SPI_MISO__FUNC_TEST_IN4 (MTK_PIN_NO(6) | 6)
+#define MT6392_PIN_6_SPI_MISO__FUNC_TEST_OUT4 (MTK_PIN_NO(6) | 7)
+
+#endif /* __DTS_MT6392_PINFUNC_H */
-- 
2.43.0

