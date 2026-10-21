Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580018;
	b=Ks7zzn7lkTYvelBfXP+4hovmaBZciE5SRpP4uqpfia9EVuh2CTUKBzUyBdFFdny0AdtZ
	 4qbzX7sZ0aMkSa4qS9cvhoRAfMYMuopN49HdTf48E3mvrKWcY3vZ4IVcSl887ygiFpagP
	 mHvouxIEmgz2V6PILhqpTXcwiqXjVIWvX4XY3DolTcVx1O9HyqoQnjY0qlAhalqPSsEt4
	 JVcGAsRuibcp79jHjQ9TKQZ7BJaq2ZjsYgWHbuAWpUaHFKIKMOmkk00zJdL28QMm4+HqR
	 cuhJiIW/pAsCjSxr3lkxC8+Phpt7zPsnBYrBPEBPDYowoJ1wGF2/Kq0j7cBKAmJNuxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
	b=U+/nI9bcA53RK3hCh9rJavTt3I490bEoSYA00ojm24KBFyjpjyatv1Pq/1LJHl9/T1qH
	 JorABPlapU2dcFZ2h9ilsGXC4j7gyt+pqHzGBQFep/qmRs51A6nC80hJIg3KQyBN2USoD
	 xexMf6ZKuFF9TbuE/HCBwKrlZP+gKg4oGD4r9uJsjL96psOzjiPxljMRkRMKYoQfPAgST
	 TvvHlk0TR0AAZy1plg0J+dASmYlOk1VJZEfpkyKPckxQO+UElOL9/ej0H1qOJGJCpW7CC
	 i0rowbqnGU+PJ4bNxBTX91yfLXC7towfe255DFhEpaD1YimBqjALdtmO6G5AIWRkCEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqhnUmc+;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC754606A321
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 10:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC754606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VqhnUmc+
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so6500525e9.0
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792580015; x=1793184815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=VqhnUmc+IfS4dyLcwdf6o8jCet/Wr0E/jiJ3m3A47upXon3dtsVNqNWa67BzvlHBUg
         ctS27FXdI9Vsl+CAa7WYOzKIREPPU7di8eIWog/Ufj+GIrL+tg8tanndzUB7bHx+uhxt
         0JA3zlkJQxmu4y90tnFA8IGi9wup7y4n+aGLTxzHQmWNyaih7TvvP4H2cO37qcgB79oT
         KrAikpDILAnJbn6WW6nHFIcyUnyam7eA9xBRQ/ojAqAhpibdE3sCxV2qS6sd0FnAbvxq
         i4u4Fl/3EPgYMy1vfV2739UAO2TsCYI6ggwO9g5cPSpWXjmNe0zrB+BGOXoMiwif03e2
         +ECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580015; x=1793184815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DcCZ++LfjibxMYCGx+YpvA8XnStwxpnU2ZVwc+ej5jY=;
        b=Zco5uDXhHSd/Rd5a1yqL0C8oHcrnX6z1v65n4BfqMxreabfIe3q7hQAgr5X/GpVi4a
         10BkOD2b5DN868zHdAub7EQSdKS+FsZsyLTJwPiyjKGgVc5hFwy/z4ZMiD8JHGIR8hLv
         QGLrx1WbdfIBljs2ljpVgRGnY7kejCu8eBcJ/WwcZs50WUUy6Lz1UBY1A81cl7+mDxl2
         46L0gqZOYrRBuXWnwtpHBgmFqIySgwsFEfi+Ab8cjOO9olkZ1kZ1d+PdLnanM7BokDdX
         U14UjPQtjHIhGw/DXsod/l1C3pXFDbFZJVdF82W48n/EwC3TgH0nYlPGhHlhs9hLE42C
         gB5g==
X-Forwarded-Encrypted: i=1; AKwUvBySWtV4wgSOygYFEj9CZuWDl7pOCehjiY5zTZUGtbTA6XVSiYCQ23McXCG2gwbDGNK0PnCSPQlyKg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLz27grpurPV/NuXJC3jnNXGqLJhwZmD7pQYTaKOmlwz2QB+TBa
	eRdd+fVdcLvlpD3rPVWIFWz8RNadP36ra/lX4X02EJbtr0FmFRfVNT40
X-Gm-Gg: AYBFou1MB8486brf0cJ6uqdBIdI14Rv7Mjx9FxnRpCE0grHl8TcaSfuN7zyL6YYw1Aq
	fdnX+qTmEVQ6yPs7YkZ+SJX/wb9UI0FBKHRWd/we14XDZQx40Er97VXzsZ0Z7Uous8GPShLvYus
	QRvyobb9TFAcnb1iZ5Rys4K/FWOtw8fUBZ94V9yLfuN/nd7xZgftnXNmG0sKp1AyyFSCBr90IAH
	cLiVmUB08UM/C9vUSbBhJAIxUsxVNex248mnSW74EY5QuQeh2FM19+T5NN4wZIj6TvlH8/qfTod
	LDj7Nqc+4OZbFqqaboX5W6yoUEcMsMgPq9PfIvFQv1v0tTGbS0NMYOGcwCGRMppWFBVOpfiDQni
	1i1KF7q5SdTnjU6QgK+iGWfCDwXhrmf5GPHGVbLEi3wslBS+HX4dIoQqStV3IGiKxVlA6thKRok
	GGay0HFFog9h4v1tY/ksl7LPu/UE/MpujDDn4AFH9YaARtEPMUbdIma8GQUlRSPROsIyZrQaYZc
	73jn0s/sCLbJRjnMlKJzltSKKHKtlDFmk5WsUTuJ9AqJd8yxOzJ
X-Received: by 2002:a05:600c:3f0d:b0:4a0:34a:588c with SMTP id 5b1f17b1804b1-4a1fdd29c19mr35588045e9.14.1792580015036;
        Wed, 21 Oct 2026 03:53:35 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d6e2dbsm153388305e9.13.2026.10.21.03.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:53:34 -0700 (PDT)
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
Subject: [PATCH v11 6/9] input: keyboard: mtk-pmic-keys: Add MT6392 support
Date: Wed, 21 Oct 2026 12:47:24 +0200
Message-ID: <20261021105109.199886-7-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021105109.199886-1-l.scorcia@gmail.com>
References: <20261021105109.199886-1-l.scorcia@gmail.com>
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

