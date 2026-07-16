Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A11B43E079
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222287; cv=none; b=UNoQglfoZFmQ4xTLRVgfbp/55xiWE5rmbL7XhMZqxqjnJMimR3MyrqvHoFSurwo2Y50yD24ELOk21dNz0RQubjSQRtfSvW0vIyne60px3nuod1BP9i08XXc0D/jjklZjvtlK6fAuVxm9P3twrWuWuFYikJk98E1RpLKfjS5aaM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222287; c=relaxed/simple;
	bh=Y8Yhg9LDZgOOn4IYBYFpDiXxdAtcDCdbUesWkE9/tns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukVbnjj0/V78xApwYjM2A13B1WQ36culnmIIRXMyW7NN4GUCtb4Ryxr6cFnYDi9PIxNKsvBKVIxcR/w/n8f0+VJtHGsaaaGHemt4XcS29BQdHtN+ZZGkm7SU+cd00f1wOGzFFtJkrgAzNoHHPebznrU95CSuR809lvGsrkIuDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCdB7emv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCdB7emv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ceab75934dso68539375ad.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 10:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784222277; x=1784827077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x+VQUfT4E2jpzaVYfn1xTQo+PWwjs/hsb3t7kl1meuo=;
        b=hCdB7emv+75h4IkFh1xMx+pBtbjzjmnsR+CZnIl33l6AMh1Kga4EuQntgWs6bTNZsk
         07eZprtW3kOQAg4y0WiCLa+/4HOuVC0mfvmTspbg/IT/0Ltu0xZwLnj3hNSinR/PJ63s
         KmtfLgmRAWsusaU2Li5fvO8/DokvmNh370EIiRDOa2gsMZpmQLnu15PFtAhHvZnnBzPZ
         brFwP3gg80TJhb/g9b2FoDIp/890dKtQmX/VOhFG2FvwJ7bihzVK47XobpkQr5YRErC2
         40BbJcHaYVZLGzeCCZweOGxG+aTBU3dD/fr0akQS3wwn2+Q885uHwlKIla1c6naSNFUN
         X93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784222277; x=1784827077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x+VQUfT4E2jpzaVYfn1xTQo+PWwjs/hsb3t7kl1meuo=;
        b=a1y1l3kLg4hNSr2AlXdnj3UQUveUyx9R9L2KfZsPo7x7BY8i/j1cM1KgxeNJRYqxN3
         7uysacZwnChwp7EdChNNmF24pNRUAh97JK+aEKyBos6Fu6RWganj9xta6+gYlyBV8c8J
         CWvHFEMgj3/D1zeXVpVwbSc1wHuGiQ5vfDVscEsAyPas7OFMyTEEK61sVELI47o0S77t
         gSIKtfwT8Wtry9qYBoJYH8QbQ6ZOYvu729H1IbnyKfHDZrisEjgpZCOW1odlgTuHXh17
         5jhk+eZxIFhEimTuGy2l1SmuSjmHtsqr6AZaj+aUyo9eAxSIxi90Nnw74q6YMiTEZANJ
         YNlg==
X-Gm-Message-State: AOJu0Yz3tf4q+Ue3Stvi9befr0QE+r1FvybehPHCfB5SDaKiUGlNVW+3
	buowk2em4DvofXCzXztiebKFzRibRHsSU7B80qhYSMHHW45pnba+Fi2f
X-Gm-Gg: AfdE7ckLLheuP0lOz8n7crIrI900AfvqXpYZB4fkigINGf3xvG12DBmQrK07zvuqXbh
	3paaMbt8dbD8TfdRx9zX34EsahwPhySzA1IdqOKNfqiBAv+1VpGCm1dO7d/VO+Uj7omeXyo21Mn
	QkknCSODSNMASJ84aK/8zsx8xlZRN464YnaNeuSlJwMoGpu0d+RLfM4OP2SNs6LJM9kPWOYrYS+
	hWTzELJnKrI+YqEIRys+Wabv65Aqj5IVFg9tU+XY8YdCyqWYwh/HFkWrzEMkC3VEuZdYiWPY3b6
	EajDqMwvEnmu7bR1PiRvl4egcpGEfhG257R3WP+FF2uiYvKveF/tnWfOkE1++KPg72fd1SbAwFU
	DlMiVwMbCS089KyPByfwtfqOslFgfSVS4P7yzji7gWDE7HU+w9gOkbTzTPrVCZRWdYhXubza4RK
	GPcMssdS1uZ1CRdtkmx3m7rmlmKsL0d/a30g==
X-Received: by 2002:a17:902:da81:b0:2ca:e19c:986 with SMTP id d9443c01a7336-2cf03c7c756mr75109205ad.1.1784222276928;
        Thu, 16 Jul 2026 10:17:56 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf1055de44sm22917255ad.51.2026.07.16.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 10:17:56 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Sen Chu <sen.chu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>
Cc: linux-pm@vger.kernel.org (open list:MEDIATEK BOARD LEVEL SHUTDOWN DRIVERS),
	mfd@lists.linux.dev (open list:MULTIFUNCTION DEVICES (MFD)),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCH 2/3] dt-bindings: mfd: mediatek: mt6397: add MT6320 compatible string
Date: Fri, 17 Jul 2026 02:17:32 +0900
Message-ID: <20260716171733.300885-3-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716171733.300885-1-akkun11.open@gmail.com>
References: <20260716171733.300885-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatible string for the MT6320 PMIC.

Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
index 3cbc0dc12c31..f2823338cccd 100644
--- a/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
+++ b/Documentation/devicetree/bindings/mfd/mediatek,mt6397.yaml
@@ -34,6 +34,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - mediatek,mt6320
           - mediatek,mt6323
           - mediatek,mt6331 # "mediatek,mt6331" for PMIC MT6331 and MT6332.
           - mediatek,mt6328
-- 
2.54.0

