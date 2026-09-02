Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C854CCDC8
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 19:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377694; cv=none; b=gkjkM1mby5jwDvP93zN6rP1Ge4ii+vvKqlTStborjEXPj25I5JmTscLWwpUJrQFqlscLVoU6bLS2z0/txGJuo4csCjYdRzD7fTG0ctX2mM8YimB7techXt8wb36n9udySL9q5B5d9IuQa3OVThlLocDjkREvst190MsAjKrv5y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377694; c=relaxed/simple;
	bh=UGIM3aTui+shPbVvhLT3b5f6OpTvEv4JPJold/DY6lA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tP1t5FdqBI4CvKCnTwRdffUPjbEBENOSHxLGBDQDIjItqFcv9/K/CXctXLXKcn6ZQpCZPszR85inU4CvxjIT2mZBTh4qf74NNwXOzdlByeTuV/A4IrDFmxjpVomdtTnOJF1XOID3cksgw6G2Hh77ZD9sW5kObQ7ZugCrjIs8gFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK9fhsdq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK9fhsdq"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48436251906so1563604f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377682; x=1788982482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=XK9fhsdqDFBXhDjSuvWJfNE5vT/jVeNPYAPP/NsbbmaD3WbbBJ8NmTOZ9mY8+VzunN
         KdMH+E+kYoUcuDdKeZfyf+1jRkx1ke28J3+mJxybitnpa9GE4lBGiOwLiQyZUrsi3NaQ
         d0itTIUnxjzeyI0qb1nEyA1sVdhEI0tKyoJylS0I1fofsuoD2XAW9fSCMkYPTeFTR51l
         J2JLqSmJjWuq2NXZP3vy/SS3Qsn/0TSbIo6dLmvzySLHrtcj8M3mS79hUxkWp5KYUrsH
         VwRRvKTb6J64DZPSekFwGbiuS66QqX8vv8Q5C+MqTKv8BFOQABLWhFgiZZv2eUPkPR5i
         ffDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377682; x=1788982482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bt6uMG9PgUYc/XVv1n4ledEppWz4qm8tk4GY6vs/fFQ=;
        b=n4IxiLvVbCAB2cLLTD+3jQ9NHjMpTWS+jCDfFR77IioGRsooLrDxEkZJGy/+D6G22O
         G8H+OnbYvk9+tmQMMVzuDTj9MRzEnqFvTvJfkgn0C45A2DKh6rJEzJJ3ggNJXKyLqGJA
         EkL8rHSX3ucqCfGgTFVFQr7S2WBQRJ+Jbb7yjfhXsZRI/tIF8t9eixv0DZcaYINshRVK
         ZPeDlcCFvr+KOefbxV91BAwbillDUeRv3j2WUuuxbhGsG8R7s9KAUtFiLTHaxUJfK39w
         zmI5CGYtecw/5KJKM180+jIEhIrQ2qLEYI7AM30O6sT0r7xPCHl9BF9/HMfbT0ndBeHd
         1qAQ==
X-Forwarded-Encrypted: i=1; AKwUvBy5phsfePR47RwNiPLZiKuqpQtc2JQrTk/sfESDFWwt/hlhyynUNtSYSBzbns4CfwrACpZMEa2H3g==@vger.kernel.org
X-Gm-Message-State: AFuF++m25KrNQzpfA1NqY4zIqDPWxRnZ/0CPa5vzKej+GoBG/50EzB9s
	z/rbAPH93IB+MwgYNq2JKAQUVzmZ/ORBk8qrUI+jrYOEvSz6YKrjMLvu
X-Gm-Gg: AYBFou0wen1fPechOidUEG32M9szgf6V/4O2u2zdBfq+Fxc09sti8u+U387Id+UWxPg
	EB5h38tNtkckwpmqWAzLSqkX+sx3orJq7MtwEAlskM438TFEhlE3K6KI2haEtPA6YTPFO1NmwBr
	EwAbDQyVZiCpAMTB3BPK5hBJHpVTv5kUKEiLwYfP1dJ0Byuyq/tLjIb5sSgc3AZd2KSwAnX5Km5
	WQ8lms1UvbAIgvErSmqBkCubJWHZC4kFS+XuFiFcsXQyS25+uk7mJEjHl9pDtM4OII5y9jkW3aO
	wg+0FaY9XjFY5vCwTQIm7XoLkVXX07jqcXDMXsxq2hhUhU0YON/OmqqglR2FBN73jgicvSxuWne
	3NCX8Pv39SS6VnZkHlEvwtzu0UICrrVaerDr6gNKoPqYrJOeSMEi91We1lQ3PYbilkpyiKiFl4B
	eyW1Y9O5EpvUey6b5yvhUmY+Ht8Iudrk/HsKwMHHVnJBqVCzMK+98xdSTK
X-Received: by 2002:a05:6000:480a:b0:47f:eac2:6f55 with SMTP id ffacd0b85a97d-48488f2229cmr14997817f8f.19.1788377682430;
        Wed, 02 Sep 2026 12:34:42 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm8889191f8f.34.2026.09.02.12.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:34:42 -0700 (PDT)
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
Subject: [PATCH v10 2/9] dt-bindings: input: mtk-pmic-keys: Add MT6392 PMIC keys
Date: Wed,  2 Sep 2026 21:25:38 +0200
Message-ID: <20260902193351.185771-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902193351.185771-1-l.scorcia@gmail.com>
References: <20260902193351.185771-1-l.scorcia@gmail.com>
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

