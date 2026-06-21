Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D0A40D564
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 08:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029843; cv=none; b=VnueLDw1oZDxIBv9fbAzL85H1uRceoqKQjdx3Z0DXkdvRqCO4pwtv6zYkzP1duJks7fVOp9bVCGf/RqzNL/2kP/3u8VUJVDLl2LGeKowW9MqN283gR6TyAPT4/EgE508rc+j/QEyYXh/vg4eGx8i3kIfXB4aD9fe+32aHRzif3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029843; c=relaxed/simple;
	bh=UGIM3aTui+shPbVvhLT3b5f6OpTvEv4JPJold/DY6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRowrrs2UcOEGbK3AtkatDOvk/vXbAsbu64EVW/xnj6+NxFVQ+oB0bnyY4w8Dns1VXfns6/GXoi7iywnttT/bZygMlfAbv5WQyAUdBJVIFyWcgSZiRj/c+xxvjIQA+14yYW3pgATUXag9iIJIm4O6zTJDCKXlsEyhmUZqiah8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dbyXZtWB; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbyXZtWB"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49241a577d8so13712125e9.3
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782029841; x=1782634641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=dbyXZtWBNRHT+OgstRcFJ3dvfYdKvLxQlxqWJgch6ivGYs/N37G7ZFMoBt7Glg+tQY
         GD/3vVUvShCeY3TsYHxpyZhrJ/j64DsZLJ22uS8IPJA0cSZ4KrST4PMMzFi4pdQpCgn7
         Jo/bFBR7ATKZQwnl3dhiaNLK1lnLXU4+Lmd8BkL065B+CMMgRU1Uv97mFX2+vC6utVVA
         PShYw3/Uf1xWEhHneUGV2+g+ZbFHm/knuLSoKhZnebmQZFMY+Of1XFy2rGx5SAhtKwIx
         bqr8Bso7QPYoUTrtVddxlSTmDocICzbBWxJpQ0xCICkPhrx0KRH3Ee0hFBFprmaG5/RR
         /uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782029841; x=1782634641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=PU5WaH+UFFUjA4Bpf7MHngnu/WnMw9XNe2BAYfMenARxYdlwMXAuoz9R9MRgTdAd8i
         VEWw212TgvpSQBbf1soH4iGaN9aUhf1edA5tR3vGSg6Pa0p7Qx1gGmC6KSqhio82Pz+i
         PNs+cbrfeRnJEQg+26wyPmpgQ4QGPym4zUCu5m/2sl2DvS8fGQxwGqxqijym92nJ1vpP
         uSNYnTdDXh9qaMTVpIeVDokJpUKFvXiBU1SDxSI5nTZJubMERF3UtQSNFl5vLxEgTcI+
         jVVm76/c5wHW5CjeMtAaPUz+Ps6EA0JIjNKW0YHGkt8Zu9TYNY/C9Z8fohgffMpL/oeJ
         3a0g==
X-Forwarded-Encrypted: i=1; AFNElJ/D8IrbNxSNG2PtORtZvnzFqIkVUZtO2/XMgDtBLGuf8C4jhZZYXEk7knpptxPdOumPFDn/GQuoNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+n4luDMuuCUEJS8L34Zp+drA2lHClRx9xyqzB5f9Uu/QgWe+f
	rbp8bVrGm+hNqA7UW3Oi4FVRwEWNQKCQV6NQOrkRIunBtSc69g9AptPe
X-Gm-Gg: AfdE7ckwSHfalXYXyA3epZF/7KlNdtLOj+LGN7EQf2eB5hyLc8fARM9MXM8T6HZY15H
	E3Jooss29whby+Xxqz/Ii6MduHwT/4mAoaaeiKlEFKlTJPCD0uZ8RtCb4C1PVjDdlXkP0jYXvEV
	G7DAbZ1xCc4DOeW6mj2biDL5jf28xSDDHAnMAazuiZdTZM7vEfoHBRoBKiTmY5rETeGot73JMdp
	ASea0z4u/zHb3m5u1j+gcIlztQHpD2kxaHK92fBObAwfO3ALaeH+D8NNaB7/od+MdUMXIOezERH
	1bvA/lSwdIWfsJi1yM6LHvsdqtYZjmZ9QnCQvrUOBG4Ee/fwpgu1LgNFcIfPrH//ESGZEm4xOBW
	sj0Pfru/H93InesevkmkCMbGdyssmZNKBp+8QBnVKFPBDy4AFnndGtQSrsdNijKQ622Gy/NoF8u
	0KZy81Zg==
X-Received: by 2002:a05:600c:5289:b0:490:3d62:f5e1 with SMTP id 5b1f17b1804b1-49240e81ac2mr164933815e9.22.1782029840525;
        Sun, 21 Jun 2026 01:17:20 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b9e5sm194100445e9.10.2026.06.21.01.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 01:17:19 -0700 (PDT)
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
Subject: [PATCH v9 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Sun, 21 Jun 2026 10:13:27 +0200
Message-ID: <20260621081634.467858-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260621081634.467858-1-l.scorcia@gmail.com>
References: <20260621081634.467858-1-l.scorcia@gmail.com>
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

