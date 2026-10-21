Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792579936;
	b=WRKFy3Gndr938jfabx5fy97OOF6XMXeD5v3a6sf/PJLbxQtCzCb8PaKfXepCmwJl3F3P
	 RJlt1wrs8PY/9gkWvk+E8m5fPrL7ZHZsPe0LOqB0PSOxKScpHaLo5siG7NaJlvgAw6LAL
	 qkuTiJNXPBK+d9Fw0ZafaB2YQu8hmHgoj9w7zfm/SMeaQ0jkjzc6Y2Vppe1OinQDqtw4n
	 LxsRKVBX26N/ghOQuqGxWziLw6wvEAufLNshKzM0bmR4Fd17/0uIl4aeIpLOgn5cngdw8
	 5zyp3adinUE7CgabWoiwTKwecsuWljuJeauXgMKgatnkyJl3w56mM6C8r0j9UrME0Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792579936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
	b=KldydWjDF4kyXpFDVuC0iNhsifBQetyjwYbOlIH7ZkBo6Yx2KjDUIyk/uFPy5P9UYHYR
	 Usi/QvaoHbAGYId9fp9l1LdO3HSSTzz4uFWRbK1Qy2/9zsXWFXqGmYPXu+qC77+CcspBX
	 7j4r42JoAkfNLMicbdUUNO49+L3eEG8SVsppbikZuaRk+v3vdsoN/MPqF6Ng/GE9SwUy5
	 Hus5w3zFUOPpvikWpRT1NMsO/at+0of2aPmTKH9p4DQ7FRAwbTFs+owiHcceDHbUCX6g+
	 h2jRXE8LLC9WPSPBdwqSEMZSaDWB0axN4WSPAZgIL+iK3Knmq4ZuQ9SVNOum1R5zSiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=baH1H5HU;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E3E606A31D
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:52:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E3E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=baH1H5HU
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1f403aca0so3871255e9.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792579933; x=1793184733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=baH1H5HU89i+T118hkko/06VcnYYiJnn4oobqwgCsllxrJMDL6Wk55SvW0p8z2Ag9j
         uQyg5Z4TStPauoAXQupNfY9XZVOYpzLV8q0NQ4Z51+rsYF2nnKLlDslJp7hJwrUXewam
         v5xg2r3ohdM2d2ua+xFgr4tjsEwmr7L6kw0runobEQ4zJwJKwY3Y/7SolXnI0VbNHkyg
         oz0GlPBkxD0y+iTmKgpJOx/yrTWcD08yYWS7A4dg6HtdE96S00B/APkLTb7uGhrmw6aB
         pzFhNeEo/+gJXuj/vZnGZPLL7iv2I/yzPoFFHnLoGBIQNOQp8EXBVm24d54T0WIsOZtJ
         Sxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792579933; x=1793184733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=ZXGNhYJvI9vB2M/uDK6BN3gjHEc2X3a68WN/uhBtxL/EGg9bRBw151GWl+cbFjReGt
         uqqwZS/w/w51S3KNNaejXJ964Bk7jsjI8F0ilTtuRicJwnffEqgvmoq2YDMLiPvuNKtV
         5sRX0/9Qgjkq8Yq+4YexJSXOcszeMKKwwyYpHhuN53l1MCV+p3j2evHYXyQhkZ1Zdm0W
         qO7711ufotU4WNYBBJvZJYF+6nV/8ZPB/MZm4E8AyJcnzwxTDRwDpFvaQG260hMrkUwT
         RZQGTjP+jEYqJD89zTQ9g5akFZaRLFN8A5dM95Wkn/IYUX3K080P90PrXL3Yj1wbPcHB
         NkcQ==
X-Forwarded-Encrypted: i=1; AKwUvBzAjfck1wfCAXuwcXQo4zthzvnhOEd8WteeCbdKByhBLXWe3WMu+jVcb/DQt0UN9BqLb4pekOsNLQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJoI65EfA7cHTOy95FQEF/HmAoumTnZjVML9iLkRJfDwMYYJkP8
	/FhfACb/8Kne64db8SRDOl+bOKP3vEU1WE94EzIC6ztWTQ6QzRp49Jgw
X-Gm-Gg: AYBFou03Mdm8OMpoNPvxgahPQNT2ogGhuZXm9OTIUaHhn8blMwzctMOmWo9jMH+t5qs
	6ixTHS2AUDqnSprvCGlGu+8p85C5mI2geYWKIpYOS2cTt/XGOerRjskFOJGw4NXlBRmDI0uP7Wx
	JgPR13Ru451v1xmSVOMIFXh4HW8ImnDom3ayOh3EW/T0UNXDq983IeUHFMQsYksAHgjWTVXmwA/
	1+15I28Jd4l1EkQLvzxW3KcRvvvgFQAnVAfuDRl67Qfjk97XV0a4rMcVU6ruRXF1baScAsWZi3O
	pw1/FlGa5PycWe4oOuH92ATZf31hFghVse7OWz4KcwmrXr1LdPgaPyrTUrTgxFWcDaZVjTvGjgf
	grAvk3t+/rqZ3D7t9XswD3slhnubJiI4/zIrkluCNCwJO7MwC7ryD//hSSLSDE2PnS/Ei741pzc
	VOQHt1Mx/jRhhOHF1UggJBHNO/5B/4JQZ0LIEodbKlBT3XieX8G1/fn8MLAQDj9GYrtvZPMtFNu
	zqP+2SoNxz4JH+hfcPL6oRtOYLMGsedcj/0suGn3Ch1AWDDi83z
X-Received: by 2002:a05:600c:8b0a:b0:4a1:7ed5:99e8 with SMTP id 5b1f17b1804b1-4a1fdd23003mr30749575e9.22.1792579933214;
        Wed, 21 Oct 2026 03:52:13 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:52:12 -0700 (PDT)
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
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v11 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Wed, 21 Oct 2026 12:47:20 +0200
Message-ID: <20261021105109.199886-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021105109.199886-1-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
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

