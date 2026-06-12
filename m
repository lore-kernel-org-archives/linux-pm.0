Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A145C3A0B3B
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 20:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781296030; cv=none; b=SS/ZdzwgB/DjNHwVuQW/rC80ZuqatW9Rfvr91xbhXseSEQxCb0csBK7vGf46OGaVWc6icP0NlgTZd8HyDAHSQuxQnM5+Nz54hGPSe//sd57qinp+nbZfLqBoj7Z3zlR/JAU2MZTfrQJob8ShGN18a6ru5bPk4XaPWaMkzS5ASeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781296030; c=relaxed/simple;
	bh=2bZt2a2zRVSBV3MA0JWJ6SLazOmmGt1tpatOsImPFW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JePCr2tfPH0t8d0wXi3n/BAzDyI2SGS3ltxItde/C5/qJXAwYHjrLNRP60DB5jEyMGLqeMbHOXfdv3uJpKHCUs6vM+zVgFpiguIgzx/UFC1yh3MFnfLOLZeKJTy11/YlCwiTIfyK75DPNqZDNHl+2BbF0Z9y7T+r4ceEKYRGRV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=npXKP+yk; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npXKP+yk"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45eee266c6cso1216961f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 13:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781296027; x=1781900827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=npXKP+ykQJbcKG8KBz95UF8rst7yKpaxGMIE0IdGcwEjxm0r84cCaXSgK3aSSao1w7
         uDneSaJk4HNu6NbP3izRvI3YuaV3K/Z8DuCntkBDOWcykNI+INjCaFdaAiSjXaMMDI5o
         9IRFSaBolxAMGYOYAKOiEJxHA3pQ2v+lQjfu3AuOkSf0gmTLAgzHuFSEmIh+5y0vb7cH
         3bGTkhl2TF6HUO6HlrlluigMusnM+XYC5HcV/X2bAnUobRHx8soAt0plUU2oQ2/eTM+b
         2T/tgnVw7QwWALxPIbratGmUwfgucu7+tGlTtjK7JzMZdOOrkhLf/Z4SsNQ3W3ZqniA4
         /Zxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781296027; x=1781900827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RzvCFyjr8bx4d2LvTNFN/pQ0QZHT1mGXGPc+CarTw40=;
        b=PHZOZKg5VAa3vDbPYDvYS4EMMieIsND6zniY5BCa8OrIwfzB/gJvOnjjtPaZ2/yEBD
         q9Uw30IUsf0xQ9MsZEJZgm79JlCILTMa7DhcR9+XOQZRc19geXE+n2D5w7T+FA7m2EQu
         573Hh1enCjVYuMCzYSk3jlIZYqjdvgK6jTgJT1RSDtU13JrX1GDU8yfcznEja9wFYYbr
         VpW7EQBZIYq/0AoQPGhHhyEEpOTZLp5dXVq6o2uW9UFaG/sSoXqFJoE2uzBoVv7XFIc9
         4+x69ofX+H0S4QDT9KKDPza46AP4cV3jrz0YYalynxByivRBMU3Zx5S2xQ533odFot32
         hNPg==
X-Forwarded-Encrypted: i=1; AFNElJ/9Eol8EYHFcKgYbj/bn9U+V2tUHnfyvDp7cnqK2pFKD2KndmBHtrITJd83P5kFXStEI5Ip1EqOzA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8f4v9WcuCcvMUzQx6e/2nbNYv7+cxaWAqZHq9meo/+gBIJ0n3
	kKeUj0lISBY9iNMDJ9573Yslc+RL2jBSTbtPH3D03ZH3BGBKuF4cQ0Gs
X-Gm-Gg: Acq92OECEv5NhKch5GcoK+iX7Kr/CptZ0hH1L/XlSmtrk/8/28IU9ietkwrG6vnd26R
	UYjzeoGjsMcUuN0OcnWJ+55YNM/bSoPwuVeQHZO3iihett5+eFedjNnkJ4e7B0mk8jGvak+rPTq
	zUN8q03ZbkKKP6gxzcs0q0ClpWfebs0TaDTDYVbm+JAYZRnb0N32jLuSdMi++pqCqOFi7kd4wlM
	2Gce/Npd6edqlZu10P8FIfXqTyD2pG4C5KPY6ab2LaKL7MdmnSrXK0g6SUltJxk7GuwPDfWX33e
	tP8agiywPl5TD9V7TgJsUGrSQknSW8MMgJ18iqsJBsZTm748VrDg/E6igZHqK2Mx7SytZgxH8en
	qkweRdWJg5TES3QmPqALmlEHVnMW401e+/bX9fI7LROrRM7zUgRvdqAi+en07Cp4xTYLIo5mF1t
	Vj+Kz4uH6In6Zc/g8W
X-Received: by 2002:a05:6000:402a:b0:460:f4e:a481 with SMTP id ffacd0b85a97d-4607ebee2ccmr873998f8f.34.1781296026959;
        Fri, 12 Jun 2026 13:27:06 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26434dsm9173261f8f.1.2026.06.12.13.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 13:27:06 -0700 (PDT)
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
Subject: [PATCH v6 5/7] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Fri, 12 Jun 2026 22:04:10 +0200
Message-ID: <20260612200717.361018-6-l.scorcia@gmail.com>
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

