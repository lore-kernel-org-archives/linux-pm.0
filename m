Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8E63BCD15
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781508010; cv=none; b=R60T4m3OTbm3DWjOZ301vbEAovp+EV63E7Rup84jVvcIi11ygujvTXUW6bK17TYyQWazkP042PpPYM26QbVTckio9zjM9mFQOs271g2BbPsw5ftEJjb8sIYRwdNhxKQp0SUTzqLM6U7Rvz97WMl1h0rWq8LvV3LrhOgtP1MmjG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781508010; c=relaxed/simple;
	bh=2bZt2a2zRVSBV3MA0JWJ6SLazOmmGt1tpatOsImPFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3hrzirTXjmY8UI+EN6Sp0+THvJnK8TgUh0eg9v40GV0EB6D0KGbwUWBBZNNuPbLJ/qhurv5cL9mEpR8aVWeTuXqf9xqyNj7Gf2pSdFiwJVuMa8xFO7gCl4U3m7xMwjVkBs2gYLQm4WWDitQ+kOk0iAsN9cbHYVppxwgUSHKXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+CeLBep; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+CeLBep"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac10e337so20074825e9.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 00:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781508008; x=1782112808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=g+CeLBepzKb75Gvc/6kDeXUm7wIWCHcpUFR7NHWkOZZhvDpVYTC/ZWAVy73BQmOrop
         RmDQSXMI7rqSeLMQ20l/kBFrcpEEcKYy6OEAeCraMoMK3iRYeLBZ0vzPrrqHO0Lsl8me
         iO6kQjrfNtzAjjHHkgG7M59fBF1uMMp4AWbvis0dgatazdSmgp6GWl8ftWIdzQlDxVxA
         4lsV+sLvosy/7ClhEPcKq+AaM4ZoyxOTu6rRjg2ug1cT0ly/oi5iWitQR7ghbcz3Cw5I
         m+cmiAFoOtLSU1ya9QQpyvFoW1D6DXZ0Ik4jnn8zDF2hWl5TnHDVHfd3askIGn2fyzYL
         ozcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781508008; x=1782112808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=OMcX6Y/wCKBgX0ds+Snd5hxEMJjNJIWODUVEzRx4ouKH9tLUde45knGINBTC/Gnguo
         FLf/svBuoeUtZdhOgTtUO4n8qef3j3uCWWCLNDtyIk7oVBQ45i04O/Il3vbsC1YEEoTK
         L647bchzozDCVHrTbbZ1eBOmYUyBodJdO2fHeUbWT5wT6AmSUt1ttBOHZaPr7O2070QN
         tFh9YO5ZfVYsLkQOb1NZd7ojwfLUDBagrYNMlmyF5ioVkOgrxYmRij3L3Uxsu737PJWS
         f/dsm9MX8znr9RvZVuHXspkvTtH2tywELwikAQtAI/x1oDddNU3rPqfqaXksfP7rePRs
         W2Gg==
X-Forwarded-Encrypted: i=1; AFNElJ/bIYT1CtGfscbfFoAslyup2nQcptfKQTYGc3KKGrQtK/RLtz9CsiJBsWp46LxeK4L5Ovz7+M2fwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRvY5IikWOqd3oN0GFFnHf8jQTBJKr/L+QoNUZtA02YZxqJNF
	C39bQTi+F5UrrAqsSfp+23vePImtcQXtgpmZMGRNiq0rPU4DU3xlsr+Z
X-Gm-Gg: Acq92OE1gOkR2ARa5TDg+E5vf3PymbcgXNkSuoZfuHF/zP1TyrpfnAjLVGnOZlUFZ4V
	a70T2oMfoL8D70nRuMF8y2yj0ZbW/fJVb0YbP2BH1KM+BOhkCZyc5PZZ5WWT8WweO1Dq8BQy40/
	B5srA+vtPRt7a8NipdbL6pIEf8A/Aw850BFToYyIEXsG0qh7iNjf5kBbCvyts3Jo8oy9XAdTaRU
	EtCFO9tC2SnuRsEGjmwzTMenBBpDU6jYq3exsZePXNFIApQBgbCLHSpspYgcDpZwQcX8UIj8p0K
	ZxSXqiTH+0zU3ZXB1nz8jHXlpCgnKbzvSXC+iTXHKyWMjhX4Uik6pa9sxub10n3C7F/sQxSGRhc
	UrbAfb6kjQQRYJ8wgktEZS1j225dP2Y8sdpVsY25N/DzU1UNqvjNUqo0U6vX56Tcvfa8vSPs/q7
	+Bj2aTmHv1bDksgQPZ
X-Received: by 2002:a7b:c7c1:0:b0:490:ba0a:1178 with SMTP id 5b1f17b1804b1-492200e7bf4mr83916975e9.28.1781508007746;
        Mon, 15 Jun 2026 00:20:07 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm200181015e9.10.2026.06.15.00.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 00:20:06 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Val Packett <val@packett.cool>,
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
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v7 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Mon, 15 Jun 2026 09:16:12 +0200
Message-ID: <20260615071836.362883-7-l.scorcia@gmail.com>
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

From: Val Packett <val@packett.cool>

Add support for the MT6392 PMIC to the keys driver.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..8b4a89fce4fb 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -13,6 +13,7 @@
 #include <linux/mfd/mt6357/registers.h>
 #include <linux/mfd/mt6358/registers.h>
 #include <linux/mfd/mt6359/registers.h>
+#include <linux/mfd/mt6392/registers.h>
 #include <linux/mfd/mt6397/core.h>
 #include <linux/mfd/mt6397/registers.h>
 #include <linux/module.h>
@@ -69,6 +70,19 @@ static const struct mtk_pmic_regs mt6397_regs = {
 	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
 };
 
+static const struct mtk_pmic_regs mt6392_regs = {
+	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS, 0x2,
+				   MT6392_INT_MISC_CON, 0x10,
+				   MTK_PMIC_PWRKEY_RST),
+	.keys_regs[MTK_PMIC_HOMEKEY_INDEX] =
+		MTK_PMIC_KEYS_REGS(MT6392_CHRSTATUS, 0x4,
+				   MT6392_INT_MISC_CON, 0x8,
+				   MTK_PMIC_HOMEKEY_RST),
+	.pmic_rst_reg = MT6392_TOP_RST_MISC,
+	.rst_lprst_mask = MTK_PMIC_RST_DU_MASK,
+};
+
 static const struct mtk_pmic_regs mt6323_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
@@ -301,6 +315,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
 	{
 		.compatible = "mediatek,mt6397-keys",
 		.data = &mt6397_regs,
+	}, {
+		.compatible = "mediatek,mt6392-keys",
+		.data = &mt6392_regs,
 	}, {
 		.compatible = "mediatek,mt6323-keys",
 		.data = &mt6323_regs,
-- 
2.43.0

