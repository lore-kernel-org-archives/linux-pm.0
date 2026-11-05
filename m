Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907908;
	b=xABpOZJ8dmIbH1nV3m21wF5N7wURzFn4Yyb8hgT/GKO2Zm5e+KGLf3ZhXJBmCQHe8Ety
	 GgWJgPrV8NAOcyCU8yVv/JqjbwY35SVBFzYuhhn+Kou6dFV1D3yNgsLCuqBZ1hRxG1JoE
	 J/g5sp39rqKjF+OyyEWvzpLU9rUGZG73A0qrJ8IsXL8B+W5AEFeAx0Pd8BnSvoGo2ZjNM
	 cy0A3beXjGkgzt13e47FC/VmbRT/Zg4KoM8tGnL6FPrtOgAsmRLS80Lz0zAAfFcMXhY4f
	 +I7gRZwtUShf2niy/Z3nEmzLSzwREECj8J4+79Y6x29V12d6tpUNxBZ4lD2/xJi8MPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907908;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fdpjdk832N9BwoCOr6cdI+ScZVBChe7jU8b/pMSH0Po=;
	b=NX9y6JhZl+00LYxYiUtrUilK85E6mCvt6SY5XWUcuv/+cS3e9R8tu7+2HTKwakTqMFHb
	 YQNeZb7BdUMg6I1i7iSc811NmBtU9FJti9p6ILS37nWPhSTBD9fMJx1tjOPplOINjq/U4
	 eCXqt2E/ubMYiiBIobaGk0HfElO2EA7Be/OsaiObzU1mEp/KWkEJ+Qztd7MKa9fxjCrsw
	 P2DQsbBjNuqZGEjd8WYkoXlh5rkF0UAYBKi4JllkTXqVTsNwfIa0auv8ePesJT8Drr1HE
	 csMvEhtScRE3DTjPbdstAabEwNFbs05ZdNnRO6EJ8p/0SvyJZVkhferagyFm48v8uWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXvGOO6H;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA95606EEB0
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 19:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EA95606EEB0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fXvGOO6H
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so17610005e9.0
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2026 11:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793907906; x=1794512706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdpjdk832N9BwoCOr6cdI+ScZVBChe7jU8b/pMSH0Po=;
        b=fXvGOO6HFchZghMJ/v5+oavqAdwYE0FUczZPmVcjMiUsOmN8ET9E9lp0Bx2YdISBDs
         roUj3howt7B+J0uMVmcDh6WdKyZyp3SC7N31jGFtIHav/6hKW82Df2Kt02OjQ+slaZy2
         GsF6YUn4Nc+2weRAUGWJUtnPQRyrdkU9S7C2rLRJdWPNsTqni48qtxvlr7wYLCedQJk4
         F/MlCN9qRxnIQrLA3yXNoiZi1rzI8EdYyyZK1q5aoId91yTE6UJOx83RTNIJz04jkpuh
         6wq+U+O0kEL0B+qvjVs8yunDGqJ4RV+w38VGakbcBHiGjBXWu2u4+misUTWgqfRtJyn+
         8iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793907906; x=1794512706;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fdpjdk832N9BwoCOr6cdI+ScZVBChe7jU8b/pMSH0Po=;
        b=DUw1YncYuCMwRaVyGVdUGeqAG6wFf3mvhGSdBJJRePd6yE66Ms1z9SvHtAF+FS2/Bq
         WVEdqzb4spl0MVhjf6oBKigt/xxxIoYl811t0ed11KR0etG0lWo1HlWkTiy7TJ2iLvLT
         5Ck2b5t7UzV0v8guchp3KyUNBA55MXUOeRQvwadeU9WSXKY7i6ANjnc7sNRAzfZHyEN2
         gpbdtsWx2OzGo/h5qFcuy6JV0iwKMJhnSApPiZoXE3IwbCXeSeACPsMrng1glqciuBGJ
         L+zkLSQveNWLx02cHkXXfHpwmsB4Io+LZoifQAEXlXpWQvd+6dXTISUiYtFrd4oXgIMA
         kTDA==
X-Forwarded-Encrypted: i=1; AKwUvByAo5/m7j2f2Fsl/YOJZDJDWJak8i0U2xwtTGodyACbqwznZnGtb4mx6VKVHIOzjL+hgZHNpo/7QA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+zrGiZlc7PO5b/VbyhzOvpy9gI1+KvkqxGPAur1Ug25jduaCgW
	tQYZSQfG6xxFwM8pBkT3eYKKi6lcZRgvCNEIqkd3yXseN1MHlE0TaDeL
X-Gm-Gg: AYBFou3v2Wycr2OZa6Zu/lsccegR2cmcCIXbzO2XVdGuZwprc1yktG/dPPTq8WUTG6R
	NcwCaGzyRwjMnhAOQY5A4X+omlilwKNLQMP9r5S1aVjjTA6FhSNXdiFWciJme8+As6NHg8XdXpI
	s9HXBQrlMpIfI/6u7gCpfYRxKPPPbq9eYmjhLm8dzjd/I+XjbtC5R/f+OVQsgSFngFdC5zEoaKF
	UQg0RqCnl8IdrZIQerjnwgQJBA6B7SpLWHvuUxwd3PP4onSE1cmMuerHY99X1uukJv/OUMSRD19
	kK+wKtrUC6OU+8yPCZqHOSnXyPO1HQPzADZKZL/LTta1UAR+ogOmwgMD2MwBUPYJHjbH0pWXLoO
	/rd5/jA41ook5XvAp0VN8y0KRiSGfgOqpcxs09PZcm+uyrBr2/BxEOgcpUrrn/+3BUgIFvmYC7G
	E1s+MK+7PDa5nhf0y0+FaJc58DLgmC74PzK2ZKzrZ1tvgguLt30M9iNYZQGskiWPtqsM0FKu53r
	kRa/wuv1C2wZxzZp7BsodUUzCyZ3iruey1ytGGku0596jfS8n5A3uVeILAPz89dxqOuI9UD2lrZ
	ntBZ+5GyNg/oiMOTYMlJfZgD
X-Received: by 2002:a05:600c:34d5:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4b6db1c5e0emr3268735e9.2.1793907906381;
        Thu, 05 Nov 2026 11:45:06 -0800 (PST)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b6df5eaabbsm4204265e9.2.2026.11.05.11.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 11:45:05 -0800 (PST)
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
Subject: [PATCH v12 1/8] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Thu,  5 Nov 2026 20:41:32 +0100
Message-ID: <20261105194426.1113050-2-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105194426.1113050-1-l.scorcia@gmail.com>
References: <20261105194426.1113050-1-l.scorcia@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the MT6392 PMIC and its RTC and regulator devices. This device
is mostly based on MT6323 with some similarities to MT6397 and is usually
found on boards using the MT8516/MT8167 SoC.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 055625362951..8ecc44a88a14 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -39,6 +39,7 @@ properties:
           - mediatek,mt6328
           - mediatek,mt6358
           - mediatek,mt6359
+          - mediatek,mt6392
           - mediatek,mt6397
       - items:
           - enum:
@@ -75,6 +76,10 @@ properties:
               - mediatek,mt6331-rtc
               - mediatek,mt6358-rtc
               - mediatek,mt6397-rtc
+          - items:
+              - enum:
+                  - mediatek,mt6392-rtc
+              - const: mediatek,mt6323-rtc
           - items:
               - enum:
                   - mediatek,mt6359-rtc
@@ -111,6 +116,7 @@ properties:
               - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

