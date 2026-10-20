Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517871;
	b=kdvw++iykTTRuguaZNNKngyvpyPSETZ+s1FkMkxpV2wh1qhEbX9XGm1kcE+NkkP1/mQx
	 9Lz7midil1/bOo8ympMQM7wxpKOKmuXkfw9xO6E1ArzrrFq0qJTZiQyZ9pz/skU2nhy+v
	 ENIlkQ8mrcfEdNfO0gH9Sf1DT5x48GQ35k3yTdPjRRsmN2amROxFRSNVwaFReJAAX2SR8
	 A2yhdlXAks7e10i5zh0l+LYAoHZWD8KBSTq3iQEmPCTEYlZZXuWI+882kIqpJeIzGNGXo
	 QOwrN0iLGCHDKSjHlwTYBNha/60D1V0DSzPxQgJZgpsjA1OeAqVeFX/RvblSPLkZLAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517871;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
	b=RqTWm56fFtDLoBZEd4yC1Hio3atw0cZFCmbfwFRc+/sJGKb/VsT9e4Ut1b0QDdKfF10D
	 yTsAAnYbFN+s4PU1tOrk7Pv8FPMLvZtSFJtj+L0Y2fdJw1NrIwi4lJFLgAJCbDGlSKixR
	 K53B7aXn8WVXLFQubn06bgOTLX8roQb/yPT1nyOa7zsYwQqfmAPw8eoTK1Hj+AhRcJf2H
	 DNN7g3H0vZlfaTRtSBT0pfrVq28nrXEOmt8LHJWr3pnOvh/oB0KtoyVsK/33o5garcpxJ
	 BuCcjUgcTDFDJg8jZC8+bY2Vtq+vRxezbgg3zMaH+rzEfDDdczmm9l3FrhSP5ouFlhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L48N4DES;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319DE60A260D
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 17:37:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 319DE60A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=L48N4DES
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1e34ecb02so18807175e9.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792517870; x=1793122670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=L48N4DESJPMuvTIdKy+bXJAL0dZnouK6wG/XF2R1DWSaZzsOTOsvBy/sGuBN3pyhEQ
         QAxIwReDLqmluK3WkWr/pb/iKA/CgH9xAf7bJUntUWGgIwRFGBOxJgAffbyEapj5s5Ax
         Q0WNz5FmO3zq1gD0DL+xeT8pKuIgd4ffIHSk06vnA1B9R6Nf3BwiTdapE5X7ZjQTSIbW
         IF57BlZ10S87JVLWyj5n2lu6oSZlmDckSMXEd3+A3l8+OyjNrLGxUK55CwPTE+OqhEik
         cKpe3KC2ALiE2wEBsknqgggnq0gITQtCLCSXTFp9yoYlHP7WAlPYS1LC9DOmKC+1cAHm
         BjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792517870; x=1793122670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=uT5E2Z9d5VMDIdV6q/jbgx0F2W4mfUIBwih0aehM8XN/OXde852IfcuPTzr96zzpUr
         H23RKpOamghBxQZN/L5o9DGRQA6WiBCrg6lLIkzehC6GOyD1xEJNGM7gWW/NNVTHlqd0
         z/LIEcioLzR0Ymv/mzXgz2T9FIqP5SfQtQ0248kzfYXZsJ5fxY8fC2PqTX6pAmYvnx12
         k+E1EQpTICBuW/uN76OEu2sJLzZAsVxEjjgKvN2iIbpXJg0IZmqQD+ChC5D9XDzL2AXd
         4hZ76Pmkcau9PEL0CMgasmKpnHNxXp9ewYtOE3MjzlyobotJaUsnrVpr8P6btjvyIEjE
         Kvkw==
X-Forwarded-Encrypted: i=1; AKwUvBzDl4jFvBa1rS4gzHr+hkFHoQMUdOb+GC3s94EH/v08blTX7+e1fIQ3jSvHz/XBqQSt18f2oNsgNQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJsPxmRtSYNeibxU1xiCSDiOlBFfgWmmB7ivi1EfLRol3xJIFuz
	srZSYvm5yueZ36f4N+ShwPu/pFYdqcpVgegEYOK+5cb9hAhOP0+bCbNC
X-Gm-Gg: AYBFou3zdbYRjm60yzvCaeiYf6tKdHfs7QboMet7UFjvdnpO7C1cK6FzTeIHlRQ5Ov+
	30U1iXl48RGdfy41prCCD3yuAfLzC/0ZvmEM3AdCJEki1b8P4aRS9gAU2l43Haf1Zdajli4riby
	uxE4JphEJQbxGoRB0qUceSLLyFdotDsSNX3v+7/W4rZ5WXDJhphxZKRanGgmV5gdjHdE9K77C4C
	oKCqboHFnT4q4gUx4LlLoSLzYUHG8nfDou9hsr2oirMR7n5CiNsOdgsCPyK+mj345sNwzQFEXID
	VZs1oU2Fd+e4hyJ7+NduWBNFRO9ivvMFZVrpt6KZaHhH8SHNR6eNSsHdKmtQCSc01Dr5WTJVAg6
	NiioLjCLmdacCmrVdOq7Mitt1d8wgoRMH0t8BBhomL6v8CvxZ/LcwBIJ38sW9LT7opdrEwBSA3K
	R7m5LXOEKxtpEFVveItkct1j/TDXst324Snchdr2R/sxqqni8ywi4VOvdl9dZ4X9NBHJrQ/B0Of
	LxR
X-Received: by 2002:a05:600c:8706:b0:4a1:946c:953f with SMTP id 5b1f17b1804b1-4a1d7601873mr254696305e9.20.1792517869433;
        Tue, 20 Oct 2026 10:37:49 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f8016c93sm52505235e9.5.2026.10.20.10.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 10:37:48 -0700 (PDT)
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
Subject: [PATCH RESEND v10 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Tue, 20 Oct 2026 19:33:27 +0200
Message-ID: <20261020173556.632798-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020173556.632798-1-l.scorcia@gmail.com>
References: <20261020173556.632798-1-l.scorcia@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
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

