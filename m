Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39483B8BD7
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377749; cv=none; b=jQzFmJQcOWwMPbaGrhrTtEMOhlZd+qS0vF88i7G76/WZ5hKSZD7B7aocm89KMYKqJ7Gb06vzD2cR/X0IWbYclhlNpHtdkgE/9e1c42mI1UriGxPWsi4RqVjYamkGUUT5DH7rlcyJQZ8GNGBcf79+g82aijZBPot6OMCLe1fvZu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377749; c=relaxed/simple;
	bh=ooP6TPJaU7E3qtlNtmtW111JJoBfcaG4ECdsHkhEnPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPbbraHoghSKSb0T5HTkindS20PsGfjxj5SkfbDNs3YJ9fJGEqQXFfvYqMnp148lWEh3BUnEnNqELNRu1JTaf07TXAbPEI1cAF2jdO+sx7bOW0uytvqxpGHcj9lXxp7wJvQbmcsjHMhp6H/gIU6oErXJO8295/TazuqrSxaqId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n/NvM10z; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/NvM10z"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1129321f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377735; x=1788982535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=n/NvM10zwi1pwbckGMiFNNtWFaWPvIPorKJuQKrHNhWnfQfz1ECxOwI4pzR3OEK8LT
         EZEmdJRltT7aWp+9gDl4mRl8RURw6pWOkSWTaZ/+4QfmKQYQdJjyCuj9qwie7jXKJsjB
         IQL9cNE9RR3jemk3NgTZBNxIu/+wb0t3I7ph5Df8Y/cojguvJx9SW8DHYhIlgA38ESK6
         MO3wxoqYNt8EbGuYEDQRxFt8543JTuvn0vibGJnnxuLHBjPx0qEMCY28S8wD7fFcheK8
         iEvD70TAkA0fr/KESMYnk4PBgr7vh+N2JgeW9PHXH+6nrXgFtLJbynGG/STRBTRdy9rV
         NeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377735; x=1788982535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=GNP2VYB8ma3z/Y7P+VNZAufT7HO8kwF0+hCiUSXg25KHA7yK8jDeyBz/iBz3rygd8U
         YRiqYrWE3M4QVyGUugXWPoqhPH5S+7Q6BRMrydKJ2nezblC6FRMtwV9J8WHHl3Td+Dz7
         VvnVftyYviUQi3dVxLmPgSgUUKsH0WUy0V3ptFui/WAnp7DQfB+qbkKmPHwc39pjhtfn
         Hg0/K8683KhTAcPbWAx1RJdOI0aGet0B6lFCunvX0zltz7uGjz+mtAMsdwnVmOVMk2kx
         SrGq/Ayag2NVBBlNCC34lT09BZafBh1NbjPIBvaEpqdtui9YPXv/ZzhJbrjuQKnezP7O
         mAGA==
X-Forwarded-Encrypted: i=1; AKwUvBzAIkdB50XuL0MWnNhVz5oZ4n9owiAqCo6G34kHz96lnW6C4BobGdVZgOT0OVen9sNDQzRLKPFNVw==@vger.kernel.org
X-Gm-Message-State: AFuF++ngWBLUiluf/fnbVTAmms/9CT7LibKLnA/CQmw8BKASXzQFe5+k
	0U0CYDK5mfTV/F5UNx6QDCficQG1GY8ymAC0mLSke1fYgolN2NUBIzUW
X-Gm-Gg: AYBFou1O9F5BkVVDG7N+NzJKaSE+Lwkq2Ma/gdPX7KIebHidFR7Kn7/46MmS09DeVe5
	BremLRGdvcN3OfH2ru2OvmmwvDL0qoSITlxYU/QpGRzs5QzaMrQIZF7Uq32RW565pQUB7znhbxF
	0wbWKKlp7q0exQbajXhxebmo7M6ebqyv2ghF2LLcy9T05EaWH/ApGUP7n5eiwMksV9mkuIiuS3H
	WeqGI/73s/XuRFJbMOcS+aE2QArpwbALtIpB8LYhbiBbrBEmyXU2dY8k/G7Okm5oXr7h1xN9DVA
	klnTSMNHvDjsix9w6XZ9wi8JBXI6TxijI7ZARcqcZkkTa3wGZCgaevZ/H+yMpewHbLecvJIIIeI
	R5MHYqN1qsGj4NC668YtfDbCCH/8PSAlBDXfnLTEybpLeDS9sGp8kFk8L9jC/jCXgW2rSJ44bhW
	Vb3cBYUMp5h7NNnNBf/u4jNR/gEiOWHmoKVhEPgwPsDv43vXsVXr8wFZd6
X-Received: by 2002:adf:e19e:0:b0:47f:f20d:8d4f with SMTP id ffacd0b85a97d-484913b9852mr14461136f8f.18.1788377734976;
        Wed, 02 Sep 2026 12:35:34 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm8889191f8f.34.2026.09.02.12.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:35:34 -0700 (PDT)
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
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v10 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Wed,  2 Sep 2026 21:25:42 +0200
Message-ID: <20260902193351.185771-7-l.scorcia@gmail.com>
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

From: Val Packett <val@packett.cool>

Add support for the MT6392 PMIC to the keys driver.

Signed-off-by: Val Packett <val@packett.cool>
Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/mtk-pmic-keys.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index c78d9f6d97c4..d758c7743f6a 100644
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
@@ -69,6 +70,20 @@ static const struct mtk_pmic_regs mt6397_regs = {
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
+	.key_release_irq = true,
+};
+
 static const struct mtk_pmic_regs mt6323_regs = {
 	.keys_regs[MTK_PMIC_PWRKEY_INDEX] =
 		MTK_PMIC_KEYS_REGS(MT6323_CHRSTATUS,
@@ -301,6 +316,9 @@ static const struct of_device_id of_mtk_pmic_keys_match_tbl[] = {
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

