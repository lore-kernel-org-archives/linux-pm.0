Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AE531E856
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 07:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781507943; cv=none; b=akpV5zfj5eI7fA1Rd5IgmZ3WF/HOc1jS/Ze+v0ec4kmbgjUQ1zpxmccFFd/NeMg1M8N0afC8qyxkWfFP0D1hFpfuWelJuT15rXDvoDRAriDnj22wN/wvOnCgxMujjvfieGiLB0mFGvbNtq4v8KPMv4yZ6QNKqLDo2uwXT90AtYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781507943; c=relaxed/simple;
	bh=39n206CmQ8BRbq71T9wut28oq9EZ1MOP8rFLirp5ceg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxSnqjksT0XwqLOyt+hbiygP/Bc+3bvoJwan38sBEfsjKE4enFzsp0RkPjQM5gkKNg+CMRTqqigQgS8hzTn6DCz4PxEFHLHg/Fn7+Rj4raiswmEN74Sk7er28UCUEzDOp4U5JU9uaffjvCoAEfQ8q4k/FKTmMdX9OkSR7dPCPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pznMkxxP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pznMkxxP"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b3637b90so21903415e9.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 00:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781507940; x=1782112740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/l1g6CPnWeS0nbdTC0p6FeyNadxSnUc62NucgUQYfYI=;
        b=pznMkxxPsRm0Y0UeSTdzN+hU88kV+QNuSZ7Gt0SiRctaFEOtwQLd1snaMVfprEyasG
         KFwb7DA/ka/apKZB9+u+7a0pCujujWabndQI/IJlZ32zz0fgkugt1nZCtk3OwcY0sFXp
         gdXXZ6+ixiTGrHf+JHa+1pGdgyiqQEpVgoxzNy/6kU19CLSw3ipmNs+pCRrJpCodzQ7l
         t34l3A6a/CkJbdmuPr2NjeFGm3EYnzm6C3NE8mYjPdPNjWdY4Z9f/C02HXCGITDjfZpN
         okcK4hgachbsaqXxSChgcbcpztA4vuhBZQ8TVc1fYH89hsedBR8jxRH4sWGgvdWrv3al
         Bk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781507940; x=1782112740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/l1g6CPnWeS0nbdTC0p6FeyNadxSnUc62NucgUQYfYI=;
        b=qY29qenvMAV5ucuT4DCz/HUkHEEssoVgBRSs/0S0W4KngoNSRWK0+8ex2iigSaH0LN
         gyYcPgmc+z7tA77MCl+4HkAuDUUECHOH1w6MOilj6IOTLMmW2PyxIH4829+0i/lvD4U0
         nKZ5SmZfRfXGO0SjLTRINYDkGNJvI+2byX4/us6gHrJa+Yjr5G5vNcf9Ao0yxh4mhUBV
         cNoIAwrkM52iDo0cUzG/F5gcOg3ICekif2sB73t90ksLFgbG7Ciid0OnBis+6xc745vr
         KRyV7QN1Te5yCl8wcYTpqg0le1793ZkYnu0flQ70XMVEKBctmSx5r9ZnqclxeSXijE/m
         EXCw==
X-Forwarded-Encrypted: i=1; AFNElJ+8uMgwYhXqy2HENy7on7UoSHmaRk1UQG8ZcjYde6sL2QDSi/HD0mc5Wxz/Bw5YlHJLJaDg+e0++Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YynYDe18iiwImCi5E8jbX2V/oWroBRBQKAayEX4M/mgNOBCSnjy
	TQ+ighAqswhpS6DXvk6EXXjEFOA+3Onn4AUuIQQvw5kwnpjO5uUSWdme
X-Gm-Gg: Acq92OFIIOKms+UgvSzbp+TvhQuorcJK+y6O/5pBsW+E50OkggVSQRmYTlRZMzvQAKg
	XbrkWcq2ar7GNhp2RmI3z/sv0eP/Tb0KeckvCI8a6+aigqiPhSogL+kRLCogciczAxYaV4O1/AZ
	/zSEydoZt0yXTZ0e0zYaBx5VurOwZQ/mtou11Svb+3xVu2GZZxyRb0uHe7jCxom6Wk2iKghu+pg
	1Lu+OnefsSsd7PgfdXqDFA4oJ55K7Uv9rANOp9prn2V1/MZmuwrmB5O4Akfcwy6pTljrvmZqwc8
	h0OhqnTmAC1O/+C41/k7nQmvBI+PT/mhsi0c9OLX/Gt9eX+AB0EsSloW+5CWhMT519cIhIBYhXc
	4QB6IJAmhVLJoafGIh6jCeaRb/8MrBD8hB4nw4pxzit4siuQF0lRfmyiaoJcKTFPfQZmc7YNlrs
	uPrM/T8/2h2IJl6EG5
X-Received: by 2002:a05:600c:5286:b0:492:1e36:85dd with SMTP id 5b1f17b1804b1-4922017bc4bmr108656645e9.37.1781507940110;
        Mon, 15 Jun 2026 00:19:00 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm200181015e9.10.2026.06.15.00.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:18:59 -0700 (PDT)
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Julien Massot <julien.massot@collabora.com>,
	Val Packett <val@packett.cool>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v7 1/9] dt-bindings: mfd: mt6397: Add MT6392 PMIC
Date: Mon, 15 Jun 2026 09:16:07 +0200
Message-ID: <20260615071836.362883-2-l.scorcia@gmail.com>
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

Describe the MT6392 PMIC and its RTC and regulator devices. This device
is mostly based on MT6323 with some similarities to MT6397 and is usually
found on boards using the MT8516/MT8167 SoC.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 .../devicetree/bindings/mfd/mediatek,mt6397.yaml         | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..8b14956af4fc 100644
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
@@ -99,6 +107,7 @@ properties:
               - mediatek,mt6331-regulator
               - mediatek,mt6358-regulator
               - mediatek,mt6359-regulator
+              - mediatek,mt6392-regulator
               - mediatek,mt6397-regulator
           - items:
               - enum:
-- 
2.43.0

