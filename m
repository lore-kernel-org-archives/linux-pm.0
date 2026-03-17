Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5771519B4
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773173; cv=none; b=jCY1xYJkuQgLQ0EljGBoES6hGn0Mr9HAE0EVbKba35qv3gZyn+OIx4gWLiJeDSw/kKoKcackxR9+7+eMquN1M4ptfIZLKh7New/Oz+bxsSzWBqyU4iPQGR1ZLFVAj20+v8LubefFagiPdShINB1CTVfBitlPSf0HKZmuQF90DgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773173; c=relaxed/simple;
	bh=A3vo+lSyWqpioUBzuGEl518evPrqJQ5bf6SRn5b+iHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WlGX6sj/YB8GHoSAJSmf61I0Pi3+mxy3FMTyd7nFUnss/vaio3rMv7/5KcILSe6fblUy6mhbt9QRHQvR9Tj0oNodP1YK+q18bk2QXrq1nR6q69YnWoUphALYMH3GS8fxqPlu1ZkfObMLdZFuDKJlg5dpyQ+2to0q9f8hrvGy8U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs/i1f67; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs/i1f67"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48532925a4bso32521845e9.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773170; x=1774377970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5bd47LJ2tcZUp4fxKJyryk+1k19iRlk16WHTGOaLdME=;
        b=fs/i1f67uyb1Met3ZyHHUxUzh+D2xEDaaQM3ROg70PLRZ9I46dgFDxrQYsuQRGSkH6
         ntmiX+x84/WdgwtxN0tLuwI8R3khmDT7uPbjQHQNMgDIczlGacksBeiIDg9Lamfqlitm
         OEp3P0G+BbXOU1vf4EthU3MCYoQqVcfidJ9GsJR63jTqEoywp1s008z5KHZ4HdUdsp89
         RZeC5I8efwweFRB9s3i35xa3pRODjPUf7E7TKXnBCSy9QkNEkxsE6kLSD+FUzalMWSrj
         i3/ZMpIDOX0ncqoRPiG72+CX68vwUapC4LH74aLnFdFWPCW8mj/XRbiwo1gQx7ncXy1u
         e1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773170; x=1774377970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5bd47LJ2tcZUp4fxKJyryk+1k19iRlk16WHTGOaLdME=;
        b=KdlV/G4+ruiL07LZ+fRhBxMGdwLiIWq4X/nY/dXVLRUNcJfNcUVTw3nzGRK1ggy3/u
         Wfd/26junCGwzErAR6+LhX7ubENwHoxtFeWHqu8jMmnG5CUXtuQLLZ1nQVQjaVOkKJAl
         GStZMC3in8gOAsPFPX+1OzbUAxEPl/B/rb02ObAcKu9rgXVfrzp8SFTXv9inMYXpOqhY
         Bs3Hkt8w0+jtwbKRjioY7SHlvqsGqsC71KKdMtUnXh/MNVukP7WSLGBO/iJ79PUI72EU
         t+BRhQBjG8CLxn4r+SMzdjumkoo2rCt99XSsKMrHupA/+Sbvqg9+aFbgZIa7Plfoki3x
         /0oA==
X-Forwarded-Encrypted: i=1; AJvYcCU1kGs2oskmdMAP6f3AbOO7w5RZ427oGuo8JImdft6dyUqyy1qAuPtE2mVUzoZldnGW230VSPhz6w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ5gvUMGPEdLfVzXNWGaa5QYbwKXEOVub7OU4veCALUimN46rm
	QKxy14M2XNmKhvTZqUekWheLi646tcDaXOBTbFoqcUV+WUSBpadtUhJT
X-Gm-Gg: ATEYQzzmv+/e1s3Ro4elNMyfl5VmrzL5JyS8CkY1+8ixKO0qv2kijrRgzZXU4o/mBx8
	/7MXapI6k3/ai6P+WFPkFmcAFpUqBwQxu1q3KxzCsUUorua5kxCgwam3EbcFD8TSqa+grXx9Nnn
	tfOEhY+h7I9DYesY1jT9dZ7svHviyDWwsFD2Pze8KvMTC7R2nepp1RRh/3OI12srzcjrHmCRoin
	TmePw7w0oWs0pZjLBrzOLAsxWWQzwpfdlaO9/+oGS0lPcwwAebbixFjXO8X8FApbRS4zDRjKhEu
	ECmE0/76khu5Ia4cqECAuHhcyyK4Rt/ENMKjLVY0/RdXDRlEQOKzR1xEWuDa5e4mH7WwMe8rqy6
	LA/0KcpzwNh905nQOQ/51vM2f9QihS4zAACH/TUmarQXjUDZpUuliYfjOdVfcoA7jctJzMQ9p2A
	E380Va4Qqnt30sjeXYOMI=
X-Received: by 2002:a05:600c:348b:b0:485:4552:8fbb with SMTP id 5b1f17b1804b1-486f4457d26mr10995495e9.22.1773773170348;
        Tue, 17 Mar 2026 11:46:10 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4ba760esm102725e9.24.2026.03.17.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:46:09 -0700 (PDT)
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
	Julien Massot <julien.massot@collabora.com>,
	Val Packett <val@packett.cool>,
	Gary Bisson <bisson.gary@gmail.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 4/9] dt-bindings: pinctrl: mt65xx: Document MT6392 pinctrl
Date: Tue, 17 Mar 2026 18:43:07 +0000
Message-ID: <20260317184507.523060-5-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317184507.523060-1-l.scorcia@gmail.com>
References: <20260317184507.523060-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the pinctrl device of the MT6392 PMIC, a variant
of the already supported MT6397.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../pinctrl/mediatek,mt65xx-pinctrl.yaml      |  1 +
 include/dt-bindings/pinctrl/mt6392-pinfunc.h  | 39 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/mt6392-pinfunc.h

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
diff --git a/include/dt-bindings/pinctrl/mt6392-pinfunc.h b/include/dt-bindings/pinctrl/mt6392-pinfunc.h
new file mode 100644
index 000000000000..c65278c8103d
--- /dev/null
+++ b/include/dt-bindings/pinctrl/mt6392-pinfunc.h
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

