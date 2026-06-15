Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7B831E856
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507956; cv=none; b=Q7qyoYHWCjxFZwVS7CumqJsvNlIsP29nbMWEePnNqzs478XR0cFev7HgpO2vw7CY33VDGEWPrKPsM8nhr+qZ7TV4f2Xm9ZU7m0LLEs5Oys++xcyfFp1RzuSH8Ddb7dGHsakXUKg7giZr3eybFKPlBJCXh9g8KVmTU3uKPxNoSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507956; c=relaxed/simple;
	bh=UGIM3aTui+shPbVvhLT3b5f6OpTvEv4JPJold/DY6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaCP8QyJmLUra7mQhkBdTH5XzX7Ntd6z1DkNFrEl6tvicLI1xMTNIGhzA9+kICql2Cyue7kAzv1s3NlrLDEIji/pTcLfJqggviIlpC5at8FCiA25oLX7Aq29nbJ+ClXIwZEiBalWt9YAPAXH9Lypus2D4IZt5GhfGUdPGr0oytA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Inrh4Zf4; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Inrh4Zf4"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-491b390f9e9so23164205e9.0
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 00:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781507954; x=1782112754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=Inrh4Zf4y7O+QAIdZpvX0SiwfgcLdYfay8y6BlBidsFHvweIT3uzAk+iZ7rfrRnVOv
         xW+rRlt4ReycdKZMu8ZA7YdssVDNxALttd0OOrdDg/tvm+iS2aa0VKLQputsp6v/bjwh
         ymRKhPUeBBFd5FV566zYj0/or0s3mkzDBQpzB865uyg5oYB8k0IQa7aRDUpbBnU1ocaV
         NPYisbUfO+5RoLIyVJlFjdSw6fSuhBwvVfpHjS/hN0McnqX2+NqHqZswy6LYujuindkg
         f1cpD2odieixsU9XwkZgKwj8zza9dfr+XL1wk927FbSgwDBjMbw3YcJpRaIknBuVjnPk
         wvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507954; x=1782112754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=nl10G4sX4YJjThy59sKv8FKJzNDZNktBayMd9zePPgmbaTnNXUqMfchNmty69sDVkB
         kZNUV5TLm1GKruE3KG+7EU/9+lfW6j/iiJKPCYuYf4rEZPVM7aD95z9qgkJGoLPORPry
         3U4OW7po0ckwCo9zADo0YYRQYFNRUkTlXp7Vu3IXaPRwDJYafvzQ1PYCvlTqll+dltfF
         qsJp/6hOvQS1BMp98e3Wa+vP4z8xrsK0t9tDJYG7CLxUqJVq/tA2DIMuCIxkNow8HPZ3
         M7j70T5Gn/CLNFS9M5YQSTG/2BbIxJd3KNgSU0N1+CN7wuUHD+cIaus3zH66sXtYNZb7
         UIdQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Ut3m9D9aPfNePFb7RMDsvt0NU2f7R/qq2xIEp6eBUZfKx17z5BIrIMeRmZnR1Vqy96Nks3cujgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3iCaGdvPU8PH4jpt81pfQJoKuDZIyottBi/2qqG9UHBv892/R
	RIPJI3I2H9DOlzdJ8K3vVte3LAD7RsKv9EvMRNwrsCwAlcgC/1ZEZi4C
X-Gm-Gg: Acq92OHH7ZusGdzppFn62jnzUPu4YNBMucFdz2pKRLVVJ/HaNYzuuSo4FHuMtN6I/JX
	faN8TOAvFIgdVN+kPK2BatzplahLXVCgZ9k7ddr9haI06UgnJoN79bImBiJwbX2GphHmFkY+tec
	rQN/mipIJGBpw9namAnQZ722Vd8lzHcqXWEfNG1xvGI/E8mutpZbXajdTchuHJxXsDM5dCEYhFx
	qLyWKOi5SKh6Xhe7LVPP1fqem1kTsR+9w9tbK5TgdtdZOv1dOQZdbOySkzwaOCrnESygjKnQRdx
	tYZ2wmBV+OTqTEBd1Hz4mslW3arknuQUEU3nptbonXEUbLbyOREcwUfw4WdUZdaQbjfmcpc3wDZ
	HHEZ2MRcBzODjgVq/WPtXzL9MZC5JGEgd8n45jZWCeKqlPjft1XnVQ32k9FJCqrL2MO4MqrrcTS
	7f44J/2hsrVNWI71gL
X-Received: by 2002:a05:600d:8486:20b0:490:9782:3eb8 with SMTP id 5b1f17b1804b1-490ec4fc0c4mr117642565e9.25.1781507953725;
        Mon, 15 Jun 2026 00:19:13 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm200181015e9.10.2026.06.15.00.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:19:13 -0700 (PDT)
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
Subject: [PATCH v7 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Mon, 15 Jun 2026 09:16:08 +0200
Message-ID: <20260615071836.362883-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615071836.362883-1-l.scorcia@gmail.com>
References: <20260615071836.362883-1-l.scorcia@gmail.com>
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

