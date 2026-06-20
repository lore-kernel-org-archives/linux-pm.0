Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12F2282F0A
	for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2026 20:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781985677; cv=none; b=KSGy74q4KUyOstto64oqgrgFCrGYjSDFEq+xLVraN6tblAZKOFdog3MZ269E1MrAPrEt6LwC1RAf9aPjS/ZasALsTwjEd02aAOtmlsPcVAIGkG9Zz6MXXYC5+AYaSv1ut5+2nbudL3eqWyIvAIUmTZjOCmOdVxvS6jO5ZPMyXaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781985677; c=relaxed/simple;
	bh=UGIM3aTui+shPbVvhLT3b5f6OpTvEv4JPJold/DY6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dkcXjQyWNfSO24qocrpjW9BmR+eEhazOoAF6jqzOoyaVbPC4aZiGMGXtwK0JSn8k9+TECnd70Eel5lCkXyz3rCfbhaD5jvSxkmjx6yfo5ZLIFZeoZxcD9arAFx23iNvSNG1JCfoaRVO+X+420+1oXQafqg3mXky7IfqN/g/gIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh0yTGa9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh0yTGa9"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b9318997so21514165e9.2
        for <linux-pm@vger.kernel.org>; Sat, 20 Jun 2026 13:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781985674; x=1782590474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=Vh0yTGa90+7WA9H2teAYH4fqZwLprY+cgU2m+PZechgUkuY2cBgOIUw7vJReHItBOT
         7I3Yz9jA7K/1SPahTTmhQgQHy5kGaa5EA3StSnDH6kLolptx01Yc1t6MxUFdXYydQRJL
         IqVfHfmodBOKMgDnBp6kM3PJX/28azp4Cc1ZG/2BBJyMpGMx80C/dnpsK1R2zXu2i1Xr
         GEL8/Swo/yxzfH5N5NYGlWWOzb/RTzzVkdcoOq78hHGETf0171h9ajeQ4S/AqKt01BpK
         pu4DkuzDNK7BRmZzKWMtFeumj4BkhjiGMmMThxFvC7MwxSN5bbgQVIgQZbzglkZxWXx0
         TBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781985674; x=1782590474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=j98hbzqZlfvjwUJMCQTYFGHHbtU4IpPEXUqCmIzQ/sPIAgfbGR6q+3gl79gN5DGC/R
         Z7B0fN63x1KMd1uIx/CO9BGz7EPjhUtwpImNfzogBa0W9eIZkggA8UFpOD+Ox3mxclR6
         x+IzASDH2DX6DNkkvW9RiE1b1MpHhY6uRZxxI9a9nf7p8Wbtodz+6Se36uBMgPGsVG9Q
         THoagwCtCSqVLIoW4+mmS30NXQf8oPM+1Q9+BaGGcUM0Av/VODAjBmv7MOYnbnKy7QuE
         McEHcp4d/a6i1+HXa84KwyiMwgeX/1baiNHs8o2e72818PvBbnpnDV5jyc3Nn8dNM4xl
         nRdg==
X-Forwarded-Encrypted: i=1; AFNElJ8Y/LQERUclt6DdA41Vigqgp/XHsPM8oqWiBgGjtjy6QrZqXsZ2Koq+UGdI4qrfXYFcxIrd2OsIEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrgJrMhf/1MOi/bo7SSRTGuFo+gI6MTtA4GFi53DltSInrZAWi
	2UAb5vSk1h+xEh05Sbhi1UhGKqEYbXk59KNNxlCyZ+R/8r6hOJzPYnUD
X-Gm-Gg: AfdE7clndGX/yp2B++QlJZzPeNORT0/FooKgVyLRVrlhMasly1nhBQSjYOKiMghwwmg
	k5g5r0dEZJI9LY2Uf1nArboVK5TYJRAOzZ1YeFFpuZi+8F+JJV0SBT4cD9+j0FquiWHhrKeqzMb
	lMmjUUNaOkc1dFqq29ls5Yp35f5d9oYH/EBXFn0/D8nEfVt7oEj2zITAZg5yaBNioR7OCoh98Fe
	9YVAzw2pjzwfrpgyQn1TfIn5S1h9DjJz9o9eMgW0KdzeV5OQukHSapsCaOD3zOEFuR3Gw34NYwE
	qcyiD6f7kXcP/Ed7Y8JgGqPA8AwXJFDgNlS8fcjAZSpG3g1Yt34hgXZDX6Usn5E8t91Po0qWiFJ
	VV/LaraUZdo/1lZ2MUZ7tuWLr4mWLL9M2CAlm81JKZHEb7UyZ6Eza8BU0eioYzoz7u4GWAdzxvF
	LakOX1ag==
X-Received: by 2002:a05:600c:4443:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-4923f582c6dmr168656025e9.27.1781985674088;
        Sat, 20 Jun 2026 13:01:14 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm10708354f8f.23.2026.06.20.13.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 13:01:12 -0700 (PDT)
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
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v8 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Sat, 20 Jun 2026 21:56:48 +0200
Message-ID: <20260620200032.334192-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260620200032.334192-1-l.scorcia@gmail.com>
References: <20260620200032.334192-1-l.scorcia@gmail.com>
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

