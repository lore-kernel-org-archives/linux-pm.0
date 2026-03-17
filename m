Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071436654E
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773773153; cv=none; b=EEWnLk/keCRfda9hyxdeiIew63a6oFmHhzpw6y24RepQlYIZ0l2S1J5glGgeTLRoq89Y/4V1tr7fuLxQfbpwuTp+tlqLHZUBtM9m6hyu2tpbeTRBQCEFv885/ZMYG4h8oXGTOokh1sVZebihfxRInIoHV6Zdn4HWDFMq+DmK/ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773773153; c=relaxed/simple;
	bh=q8iNQRclNimcvTVMz/xp0ANElWweIprPYt8rET1d6u4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERj7PWx45nwTpORUPCJtYYzeVDcdo+iGW9Tsm/U9r8WxdTR9uz0WyNrCCF0PQfTjNwxWNIW0399SIBAvgPRzQvmD2RO95tBwP9VsMqLcflWOoNfQzwvV+eq1bvOrDjo9HC6oGX59c6geI6fhwYMS+n7Psw86vODRCMqd4twirqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zq/XaBfW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zq/XaBfW"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso52239815e9.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 11:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773773149; x=1774377949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+y0veSsgUsUJmnxU5xqCTTpBOt5TLJfl8EzSd1maDY=;
        b=Zq/XaBfWQVvF5NbK0pKEYbQgj18PCCJvmQZjlZi4bsBXlf8GfR9mowFsgZWsMOgkp+
         Zav70swWAdTCzizZWJaS472IaKZ3nynQi/pCAO8sWT+qjE5gybdm2WF7KCIkdRRyWWX4
         dRIXOgN5EisbsCtUu9zRj5oU+MfkEDo5hqNbhDzENmLq67ow8DOyUVdL36qNUQJmOwFs
         rtqdEu8PWQUYpzVkrUjl4/0+qd2/Ijnjuz9Yio1F9d9oZosnGtMBTz7P21Y5isLVnq99
         9a3Un61QzYs6/3snZ0MVLTvRfB5NL7GOyG6h2QnQrLvLotYzBqHntbbpdf0bwqYMnQgW
         I1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773773149; x=1774377949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+y0veSsgUsUJmnxU5xqCTTpBOt5TLJfl8EzSd1maDY=;
        b=K/ipWzKInzao7wLGtyZfG40bAMR4H3k2hkrS10nvgBrsRIefEkcy39VGqUVcXRCDJn
         TlCDz2+KqK26ltYTQZcWrHjQ9wdyj56uabk/KyZD0N+z32Ph+cM91V0m86IiMSK+TCFx
         e6F7XndWO+x4gY6HKRsWDbI1uJJpX0Jj6N1SW3EPCwrug97GwMfL9Q3LMgXd7Wbsw16y
         q+Amci46MDYItpwAKLbvMC376acToQUn0iE/Q3kNbQdgjZcC/PpxkCDM6dye1zk75fbT
         4Lfu2AnO3i50jmNux0ZcITRi6+XrXBkdc/H97HeCN56UDPn/WBWmQr+o3Y9kb6Nuq8fE
         /8xA==
X-Forwarded-Encrypted: i=1; AJvYcCU+jdNIT7sBwp4NUYOIl6JVuS5jJrGcSDlCqmxb5+l1EtTbsJCvsl6HQbvvaA1J7l4/Umw1EAiojw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pditioZrJofSNor3G8tQQg4bd2apiuRGLbroQzkyB9eRO6Bt
	qDieo2g6V6RXONakKgUUYdweXoOHQkJmGECbn/2on1OdJLL7Ww9BUZrZ
X-Gm-Gg: ATEYQzwhNKvRHHVc9tQQ86Snmv7axFyFz3ggAPfmiHpXa1bcBBjaaTlUHc1P6rcp1X5
	S+OuV0buQc1fws+63kL63y9cfcsvIknxPMkaJWKY3lugJO/kC0fS2jdFh0YzSwEmCRT7Rfrgy/l
	L3Eo0KdUb1Ch6tqdzoJ3A3PJcHVkrDMjVrhsrTD9Gr3FDl8ifWQktbVjLqlvkRoi4syesIYi3qA
	R43Twwm8dvGP+XP3+9UkAop4/0SgAKxFheVv/QzVqo2NSqJhQe7xazvB9Dh4ShgtO85r5FUCZiL
	CFwhvitOEHRS4jhwIW4TRzkCQ5YaZfXR1VlhDjMIWqHtJsuj0qUKj60dsI1OEJGj5RyKj7zGhaX
	Kb7DEliJP7g43t/K1GbbsRPf/6hMBMopQNtRJLQMZkkuID7Ek/nS97qiv3V01mCYR8bLKWOIVm4
	fROe0sVaEIoRteyEsihMYJ6pJvpHX4NQ==
X-Received: by 2002:a05:600c:1f93:b0:485:3b5b:eb8 with SMTP id 5b1f17b1804b1-486f4463591mr10143505e9.26.1773773148893;
        Tue, 17 Mar 2026 11:45:48 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4ba760esm102725e9.24.2026.03.17.11.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 11:45:48 -0700 (PDT)
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
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Gary Bisson <bisson.gary@gmail.com>,
	Julien Massot <julien.massot@collabora.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v3 2/9] dt-bindings: input: mtk-pmic-keys: add MT6392 binding definition
Date: Tue, 17 Mar 2026 18:43:05 +0000
Message-ID: <20260317184507.523060-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317184507.523060-1-l.scorcia@gmail.com>
References: <20260317184507.523060-1-l.scorcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fabien Parent <parent.f@gmail.com>

Add the binding documentation of the mtk-pmic-keys for the MT6392 PMICs.

Signed-off-by: Fabien Parent <parent.f@gmail.com>
Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index b95435bd6a9b..2d3c4161a7f8 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -30,6 +30,7 @@ properties:
       - mediatek,mt6357-keys
       - mediatek,mt6358-keys
       - mediatek,mt6359-keys
+      - mediatek,mt6392-keys
       - mediatek,mt6397-keys
 
   power-off-time-sec: true
-- 
2.43.0

