Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1932C43F08F
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228765; cv=none; b=nz+GZBAvDDb+LqF7Rw1gSq/nAj0TLSc/bgLtSjsqLisoLTl+kphMeLtFuoSAegxyKgQzJXCINxnbVnOlBNBWMWE3D+t6gRo4A4mxm3hyO4uI92WYs5xAX1DzTHYiFGjs5Udd0PBPCcgr49DM1n/XJ7lCwOpzZ5+WZyjyfBjNL1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228765; c=relaxed/simple;
	bh=UGIM3aTui+shPbVvhLT3b5f6OpTvEv4JPJold/DY6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT0Cxt8h669fCOVt9N2k4vPyXHYDGeECyY7xVlmS8SSRJVWd8Q+lhh2LbZZmXOuzMo3E3pN7R7zC65knA7kI65mfZnNwrQ0ChiKn3zTyXV2MpnK3Xxrt7YHA55Pvl5OdFZ9vWdmKVA8xse/QJx4CcJzzZVv5VDRnrZx1a/1WpIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=smH3jAQh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="smH3jAQh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49954b88fffso22524765e9.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 05:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228762; x=1787833562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=smH3jAQh3vCdNjEeaF8UD3BHn5lWWVbhOwqm3FC8giSqd9hZwfYsZeeL4tdwGGs1Cu
         S3i0NEZd+bqjXPIAOuWVTA332n7IMUoZqGQaEvDtGTybVuCL74ADlT53Eoi8vRiJ9ub/
         4t1HZdFxl1kQoukgKuVTlctHv6Zo2XlXuzP3xb9eBt83EEtYcgmUCU2aGt3BwjPWZxi8
         PtRyJES5t5KSkshDSzmF7g2sA2rZfhP55t0MVXNOMGxij+bs7nqragOUvxfrn8akP4in
         mpBwd1m0X1BbFpraBDCseUUMe7DQB9xOr4WBTrQAs1QdlLlUo5OFPQTo9Jpc3sTSLXMt
         wMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228762; x=1787833562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=f3h6zTASMKRgg3gKGmniR53xVkki4Rcm5c6xBVX7ZgrtHogeqmzHLxH6Lh4g3/X4OE
         n+8gJSKIJvydEgardNTEV4BUZ7z248ZfIKKFssPuxJrB3HZDWFSgIdAFSWoiaMqNTfaa
         cBWIriEPozm0lKt9nnYHKB2I2zR63aqEx2bkmEGFIpFAgczNmx8lIPcpsm7uv4zsVlQZ
         hPxCc5x6owtXAVl41vp0+R5o8Zujzf/JUgxh1F9GYVY0Gi7uy5zbrxC8UkY8IIa1RlFI
         GbbgSxCXT+Fd6/f+BlXHK7IY42cAic6N4fB12OW2uhYUvg0N06GBJQaKwCGyYm5f7I1g
         uoIA==
X-Forwarded-Encrypted: i=1; AHgh+RoQLT2RpUOfi/lwJR1GEkWAVfjz8HnhyeFjeMwJndL168adk1URu9ouwsFkAMPNs7Ek5ymKV2Tz4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ/McH2g2iLc2+OF/1LkXcxKz3lcoUZExT12rzgHrEc6PeJIpf
	jE0vjYfu7sqSbomou4SSTmlWHAuy1eeLMAp9E+fqsbkkIZ3lHK8TVDYC
X-Gm-Gg: AR+sD12Z84+QrzWs83s33Vw8OaNu7HZVfmogHc7xbGfooT6qOu6JphX1YRnDkBEM8x2
	HATKI6LpLMwbUm9SlA3izVV0t9lNgH0HTAlrbhwnF5QbNn3fWjmxKX3+PHX8A4okNtMdTBNng0p
	qeFd2L4K7GWHPfDhDh+TNSMtqV3qkrTvmUS0DnuiCsbZVszjYLHLU/kksfORI++SOQ4w2NemTi3
	OgK3bLgTZX9VmicI14emzg49S+6PhxZwxKfZcEDbcTAIXoY1i7H3h2GeC5kB2VPu2CVVy3lDqF/
	kQyRZz1Y4aknu0R/Q5Nx9JVtrB05viyR3sPvoXjmKvzSUWbUphYJodJctlM7kcKKTdSkGgkXpsk
	CAISFKyjqqzIs2EJc+/UP1xPuC0csUpmVLetHNhkjA4XeD5NpZ4oMAae6aFJtx4q3OlIsz3CUwm
	99pMwkQWL9dlkKCmwkb0/crekmh9XpJHAcGlYPBjq4btKpazFISn4sig==
X-Received: by 2002:a05:600c:8b65:b0:499:a5fc:2087 with SMTP id 5b1f17b1804b1-499aa1722f5mr231760135e9.6.1787228762272;
        Thu, 20 Aug 2026 05:26:02 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm170494645e9.8.2026.08.20.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:26:01 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
	Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
	Julien Massot <julien.massot@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v9 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Thu, 20 Aug 2026 14:20:00 +0200
Message-ID: <20260820122242.120039-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820122242.120039-1-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of mtk-pmic-keys for the MT6392 PMIC.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 140a862ecfbe..ff720588128b 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -31,6 +31,7 @@ properties:
           - mediatek,mt6357-keys
           - mediatek,mt6358-keys
           - mediatek,mt6359-keys
+          - mediatek,mt6392-keys
           - mediatek,mt6397-keys
       - items:
           - enum:
-- 
2.43.0

