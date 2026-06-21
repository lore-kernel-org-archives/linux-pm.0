Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428127B32C
	for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029900; cv=none; b=bQC7ecsd4P0tk+T+Zdm266TQWnnFtBN2Rr1QUsoVGMLlwvZNC3BB2rRdJJQSdqr1hPtQzJ19jCYPyebT+7cemj5yfdCOhBo7vDp8PaeesYt9WE3s0wrIOiuNCYXw7imX08pxKe+Ma8JM5zK0Xhh8vEra+8Crv9bt/19qoD+qi8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029900; c=relaxed/simple;
	bh=2bZt2a2zRVSBV3MA0JWJ6SLazOmmGt1tpatOsImPFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZO+hRj5Ut0ZyGoXmXlJXx9a15XUoMjsPrHDOXact0dQSKwwnZD96IerT7jyC2/XkacaAyhxxrYdvDrKog3AOqrybihi2zqrTK2WxCo637xyt24blo5axe5T3HP3EGqruysm4kXt/jeIv27GlzchOB0Lj1Od1ZhFYnFmkaVovX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0eLtDjo; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0eLtDjo"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b3637b90so25452725e9.3
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 01:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782029897; x=1782634697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=H0eLtDjo1M6DTs34J++HTmOYKpyPhHLh1+QF4GHZfdTgFP0VdggJs0p5ngDTQyrb8z
         jj01noAzjOVngeJYgxlVHPkeC1MYsLIGkGZU0hj3qQM/TLjn49OTd7Ub2CJVsoomDnZH
         yr0V+HL+w71Xm3vujFUK0Gtx3ZvKv6HDO+iA5iojOjBciaPgZZQ2om1ctumPKUIX+aTw
         zf9f4zfqnVewMo4eub52t15EqhPBxSSU4YVwNQEVmDczMrGLcDZMsB/sIx0DsTUQc3Lc
         kuDxq7MsHaPqATHMd14VKeLrFr2rgw8PgRcBRmmL4yov4AgnKzsF0rsLfU8XB+6u7kS7
         otQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782029897; x=1782634697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=QZaduDq8lxJsHvciFLMSpfbDSF7czSu73PY78aCtIuLJSaBkBUQWaS8hfD7/+EfZ6z
         oR6VAX1StZ+G7NijW0DaRBSSiZPcQIeHZUGlFz9oBJ5FPhz1p25nRCU3TICm2NFhgZsQ
         DHKQ2XnnnvBQsxL3GIjc4MtKeiu1aZuqSwWmHf6lYVgVfBlws9nNuBp0axBSR+iS/ZSt
         oQVJjlqrAXkVyP9iGZOTRpwahHxCNZYpxTZmWSjBHSIH0j7P9X53yAQT3EqUG0sN9tFQ
         GuZtJ5s43c05v8zJFRutc2GE+2+NN82XWZkKD1WjiNdSPLFrZpSggQ1toUstIfFC5CAG
         FIjw==
X-Forwarded-Encrypted: i=1; AFNElJ9phM9aJhQbMgXvanE//YeM12AvPWSr42QWHxddiEk6keubvfr7v3raVQ1N4n3LDUT8lsQkSLkCTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3rHsw2WJJvF3YFccsCJPQIpI9pWm1Th79sgkfjCCHu9fhpTV
	VM/lGUysTEitAh8VGsbDig+2fqChNzNqH/LDNt8VHk73wYlmyWlOmVs9
X-Gm-Gg: AfdE7clIibgiR9QkqiCO7/Eoh4GsPiBATbRrs0Hjlnr+Hsl77GItxwCqwewKfwttIWw
	qY15xb2C9ttr2frY2NrujcHhQf6oVqDzi5hz5pAcKcEMRuzb987tcFs1knmp4j0dh2RD/MIL08S
	Y7Dlr4Fro7RrkFg5vaHx5rprNIzamJKTNEZB+/9cASCqOji2nUgGb+eOI1Xue9LbxLuQdxgj2Qr
	1YYHlV6Khiem1nvw2ZjuAw5jMBKM6rJz9i93OHeZ6GJb12o7RfdrgWHIE7SAFTjkKWbs8u2FCP5
	dcGrmEuZUf9/TG+edbvFi+5u4crmbv/z7FjZQ36XpRmUdKiiZv5EteL3S5o3iPGAAMTijXSbXcD
	Q3Gc9dyj3xu5YLw6kRyDKqMeH5p36yb/J149ceDxDr0UrIc5QSvUgN/t/wjvLS4nqEmKLcljBtE
	XkLV2lCg==
X-Received: by 2002:a05:600c:45d2:b0:492:1e36:85dd with SMTP id 5b1f17b1804b1-4923f596bbbmr163549115e9.37.1782029897128;
        Sun, 21 Jun 2026 01:18:17 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fe7b9e5sm194100445e9.10.2026.06.21.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 01:18:16 -0700 (PDT)
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
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Julien Massot <julien.massot@collabora.com>,
	Fabien Parent <parent.f@gmail.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Chen Zhong <chen.zhong@mediatek.com>,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org
Subject: [PATCH v9 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Sun, 21 Jun 2026 10:13:31 +0200
Message-ID: <20260621081634.467858-7-l.scorcia@gmail.com>
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

