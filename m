Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA913A782A
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 20:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781295979; cv=none; b=S0eMNH8I65mufzlqOR/CaAxnEsDbXVNNHegJbOepZteuggYuWQGS3BHgQDwFXJVoUjZ4FWRQI8ZF2SgMkYWebXRZ08+Pczh69JIquZNN45KDKKmjCwxxRDjbDduVUj7W08BNGv3ZMNzlf26tisVMAPjP/4ISEQlkDuogeh7NL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781295979; c=relaxed/simple;
	bh=3RdZslaSA8ENYukoWe2cG239lXtpnapiIyzZsztFDOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0yidun9L7pRe/VXzF0EJQVQB+iF+HhLv4gbudOkCxLVDsX4g7hmzZ4+gx2nx2GU8z/SZ2v4nFkVOLmpPKcxdJozmplOUzTM6cs2KtxpKjGR/sr2UHb1YkSpOrVEfcIlnbBzuu59ZYFFSxZK0bXRhPuIQEnyrbgZ7ThJSMmXByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FC6sXHkF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FC6sXHkF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490cf3000f0so14368095e9.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 13:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781295975; x=1781900775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQbFs2CKnSzJgOy+gjpokoR/HX0Y2GFtRKZFX0F9ALQ=;
        b=FC6sXHkFj0Zs8lq/HpdZuQoNiUSD/6URqmnIof8Po1yBYUEEuLuEoY4MGYOjGZ1QzP
         U2Sjg+U+JOm42+XcBqnCLZIwIFvHyxdyShYl0BzRoiOQJuyxJn4xS6rhz/0sBDohUN8y
         IK+VjUvr813B7bOssMOHlTj1B/oM1/FPc1wg9e8B1nRFoQ2k9M3YkMfhHqkyPnKYNkl5
         6xY9CEQw9FfyMI0zI/ZATj/xVi6ei+9+Bd39+xTJh1B7T31irtpe0BkqjvCUeBToUZR4
         aPKX9WRzwiAmZ48JdS7P0GqMzlSy0uIqI5W2MUeKa5iXxioNRaOx7tRnNaJxFLQQ9KLU
         p8Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781295975; x=1781900775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GQbFs2CKnSzJgOy+gjpokoR/HX0Y2GFtRKZFX0F9ALQ=;
        b=P7QpAFgIvXk9OvXat4pvltRAnPNtYDiZ8mhxe7bKaVwcpsNctngy9kKD0stNc2laV7
         fUHxaJbgZv0wr19EG9LoXYaoQ9WMpGv475nDaRznY89ekKqgY9TPedfL7bScB1KbJEK9
         1gTtXlBWGeLK8OXncFWe9uKJFiwR8uqPjZn7Y19la2khsPzE1cp7/3Gch8yhbLwDKEHa
         SKS5SNv/Xw0fLqiGelUTDUVEvC7XaebFwAUFLmuB46/oKKHAGD7NOmLz9HHx2JIqvSF2
         Ckk4HsLGp+MZpfD/SzuCnmdlEBznHf16w7jwhBzOX0lhBPu0Tb60g0iPKIgkNPucELMf
         6tuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8I8+Cvdcletiwd8LOyVUGZPBAVwysgfFmtLT0ZnCEl+kiZxHy0SexLu1aO9QNYnBIcf0kdjfFjaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySCPr9xF3wgRmqUWA9yy6Vg7iZEOZRY14Iz9iN/Y7jEbFMUsGi
	vjb8vHGr3QQiZtnzC5Sqi9dEYiEN2ls21uiRxPkW4QuT0c/j6pmuOKjj
X-Gm-Gg: Acq92OEs6z18q9KAUZd8QPlBsmgefV0+bvwEOfTn/bjvkDRXLEuFGkhIJFC/IHlEUyz
	pzepPJ/TDOslqc1zk/V0l1geEsmmp0q7hsyl5rNHita0hXaLvszFIcGiwMlnoz/Lsxpie0I1rTL
	QMTXOm8dA77u7s6Lv4fU9aN9QzLPwRqYCgSVo3LRvIyot29ZUxzNiDW1aux36M1Epb/MFEd4F4R
	MtS2MvexqSSp8oUXmHfTmIy4DVNVEs0KUBcTAYakRu/TGQKm/KQOx4aC0HgCBEHGqfjBhwRmm5Q
	CseWD7hSHGmM6VjBQEatxX1eaCDvrPbaf1wJIVDuSaN8NOlPQocJTwoBLi4Afug07ohdqfX+tsm
	UsmcoB5FF3yr69qMdMiXVLGIN2ixq2fvF4652kkoAd+5H0oPqC1xV4qX+dtbt8diu5EM2/jhFnr
	ZO8FExoe7TOVmOXb2Z
X-Received: by 2002:a7b:c7d2:0:b0:490:c2a2:e91c with SMTP id 5b1f17b1804b1-490ec521e1cmr40772195e9.34.1781295974844;
        Fri, 12 Jun 2026 13:26:14 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm9173261f8f.1.2026.06.12.13.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:26:14 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Fabien Parent <parent.f@gmail.com>,
	Val Packett <val@packett.cool>,
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
Subject: [PATCH v6 1/7] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Fri, 12 Jun 2026 22:04:06 +0200
Message-ID: <20260612200717.361018-2-l.scorcia@gmail.com>
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

From: Fabien Parent <parent.f@gmail.com>

Add the initial bindings for the MT6392 PMIC and its RTC device.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..e39e81aa9924 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -40,6 +40,10 @@ properties:
           - mediatek,mt6358
           - mediatek,mt6359
           - mediatek,mt6397
+      - items:
+          - enum:
+              - mediatek,mt6392
+          - const: mediatek,mt6323
       - items:
           - enum:
               - mediatek,mt6366
@@ -72,6 +76,10 @@ properties:
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
-- 
2.43.0

