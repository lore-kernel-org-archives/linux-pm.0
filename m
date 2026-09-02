Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F94AEBCD
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377729; cv=none; b=Q5We+L3IAQb1j8y9sHP0NfyIlde05ff3HjtN+MjgE4pGZBeM6NXeL/opU/R63Ldng5fVPMsa/ivH44Bk2L8qy9LN3rniaj7bsSs/LVhT5AIHyEUAi9aPKya5WYIzPx9DNtTzbqHBh3nFMEzs+sDjzLLKyPg7Hu831iUlEszb2qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377729; c=relaxed/simple;
	bh=4SZXkhOXler6fsLuahc3uouC7nEuZneq2BIMJPD3/nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jpNZVSpVIUJ7+dciYgorDQV1rpaydv8z9CLFsRxjNtQkTToFhXhMZL09UZTwd7taIl/+dGa1/b4Zu+oEfYrGLxR2oymqfCEINt8PecfKU6M1eJn5n97/mtA4ZYUhX91BuDgWv59elAEXLZrTWpuZGM7WByGYUnKdbL5x7ytPhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fo7PUGex; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fo7PUGex"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b8eeb3ff2so13270205e9.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 12:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377709; x=1788982509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khjjDBK0J2xOtnMH1muymGK2fwTqPXy0k/z60K/0+xY=;
        b=Fo7PUGexRddvM4VqS4ltLQ7SmxgjmqNdE1MfJSLYmZTiCU6bqtEloZy2E+dWMN4kHu
         o3eEXJ1EOaW6zje9bpIlzUjZ54mr+oeOvnL09qOXuHE2lX/c08iRljYs2gQ+4dHD6/No
         GaF75UcRQC4GwxWhLLtlcxZY0HQmU1v0jG9zPoDwHPYSt/pnRSowdMMO2u7CXyNLJpYg
         wTgu23QvV03mCe2eunBHSo62QzkTb7BT3YxKJCSSjPdKsZU6bOLSLkjofD5K0FPwcOMs
         VZcDIzfaYfoVjphs+4E9GiDR0XW8FUlUs1XDJZGKdLG0Z7lggkGcegw8+veTCVB3nFy5
         FZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377709; x=1788982509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=khjjDBK0J2xOtnMH1muymGK2fwTqPXy0k/z60K/0+xY=;
        b=IQENwNbHBW1i/SYrKN7OA3mrUDACyFLNJcx9vUr6GvmN7d0Cv+YgVocGkj1QeQsV/a
         eZAWuLFozT/DiDhZnU660FxHoB/+V+Kz2NDG3+kkVeMSBbhdrlq+8Lie2L1JgJYkkAm5
         iqvv3fuG07g/Z62GlL59JmaKDj1VLn12XFcqrif3c58NTGX0DARM/BSGjNoFrv14iweg
         RtjCoVP6Glnz7yG963lespZO1r2edm0Lc/rK2PIfH45ex/0G6V/Wz3bO6P8Uy5OXXtM7
         OyJXPAdMERHMovi+0bH1tzbZ4m3xgR8dIFOxnUoBYHPE1+UXM2gubhSWEDHImnyDr6bZ
         WT8w==
X-Forwarded-Encrypted: i=1; AKwUvBwt6ky7biOfaFAXvrIqkWGBspXs93533FRSNpFxI2EPDNduvsQ/0cqxGfEscWWadz+qrPBPFLmbng==@vger.kernel.org
X-Gm-Message-State: AFuF++ly/CY/OiLwLrap1GYEXf/gHANa/QKqFrfdUeEaA0aAMcnbUTuD
	+CfzpIKWCC4v50r/VwfMS3dEW9cZduVFkazatiM4GUZhQTb8a0r0aN93
X-Gm-Gg: AYBFou0rzcjPzBlzM11qUUyucV1YfCzldbXXmSs8kL++qRDfvt7ZYsUk7RPXgyHhnsj
	YCFAnFa6FOUMVn3/NFL2RXjhkel13llb6vTJ1P0T+K+DHw1AOYihej6Vzz5ImuFGkBzoMssSjLD
	teeguyjej+qGqhSVsX0dpWruT+kvDPe9M0Ik/tdKyE+6u+6jRNVc7T1EAcYjUFEsr7CG19ZWL71
	LmdSgO4/u7k/mh38LEMZwHxJ8a272wLH/HPN+Jn4teCZ5naD9xd4woGHwgIfLzxFJtny/wG1ZsD
	ANdQxgG7RfdDmgGp5Ovkko7V8HMTwLVKS5xbfmv9AMXndd55qq60BVHdT2Ux1q90XFhhdITVcKz
	MROVaPUT7MMEamgdPSuLNtkPN9bFBcQrAS47NAQsfe9UQFwgt4gY8mkGQFNBws6llgSbIh8VOFh
	p6uNMYfE7HujBsiCa7MBLCU+6d1nlmRLFlM899SLbU5NdS17hTwcWWiX07
X-Received: by 2002:a05:6000:2f8a:b0:484:3a16:cc58 with SMTP id ffacd0b85a97d-48488effce2mr10601794f8f.2.1788377708584;
        Wed, 02 Sep 2026 12:35:08 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cdc37sm8889191f8f.34.2026.09.02.12.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 12:35:08 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
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
	Val Packett <val@packett.cool>,
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
Subject: [PATCH v10 4/9] mfd: mt6397: Use MFD_CELL_* to describe sub-devices
Date: Wed,  2 Sep 2026 21:25:40 +0200
Message-ID: <20260902193351.185771-5-l.scorcia@gmail.com>
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

Use the MFD_CELL_* macros to describe sub-devices. No functional changes.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/mfd/mt6397-core.c | 207 ++++++++++++--------------------------
 1 file changed, 67 insertions(+), 140 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 9ec951996588..3e08179002fa 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -124,165 +124,92 @@ static const struct resource mt6323_pwrc_resources[] = {
 };
 
 static const struct mfd_cell mt6323_devs[] = {
-	{
-		.name = "mt6323-auxadc",
-		.of_compatible = "mediatek,mt6323-auxadc",
-	}, {
-		.name = "mt6323-efuse",
-		.of_compatible = "mediatek,mt6323-efuse",
-	}, {
-		.name = "mt6323-rtc",
-		.num_resources = ARRAY_SIZE(mt6323_rtc_resources),
-		.resources = mt6323_rtc_resources,
-		.of_compatible = "mediatek,mt6323-rtc",
-	}, {
-		.name = "mt6323-regulator",
-		.of_compatible = "mediatek,mt6323-regulator"
-	}, {
-		.name = "mt6323-led",
-		.of_compatible = "mediatek,mt6323-led"
-	}, {
-		.name = "mt6323-keys",
-		.num_resources = ARRAY_SIZE(mt6323_keys_resources),
-		.resources = mt6323_keys_resources,
-		.of_compatible = "mediatek,mt6323-keys"
-	}, {
-		.name = "mt6323-pwrc",
-		.num_resources = ARRAY_SIZE(mt6323_pwrc_resources),
-		.resources = mt6323_pwrc_resources,
-		.of_compatible = "mediatek,mt6323-pwrc"
-	},
+	MFD_CELL_OF("mt6323-auxadc", NULL, NULL, 0, 0,
+		    "mediatek,mt6323-auxadc"),
+	MFD_CELL_OF("mt6323-efuse", NULL, NULL, 0, 0,
+		    "mediatek,mt6323-efuse"),
+	MFD_CELL_OF("mt6323-rtc", mt6323_rtc_resources, NULL, 0, 0,
+		    "mediatek,mt6323-rtc"),
+	MFD_CELL_OF("mt6323-regulator", NULL, NULL, 0, 0,
+		    "mediatek,mt6323-regulator"),
+	MFD_CELL_OF("mt6323-led", NULL, NULL, 0, 0,
+		    "mediatek,mt6323-led"),
+	MFD_CELL_OF("mt6323-keys", mt6323_keys_resources, NULL, 0, 0,
+		    "mediatek,mt6323-keys"),
+	MFD_CELL_OF("mt6323-pwrc", mt6323_pwrc_resources, NULL, 0, 0,
+		    "mediatek,mt6323-pwrc"),
 };
 
 static const struct mfd_cell mt6328_devs[] = {
-	{
-		.name = "mt6328-regulator",
-		.of_compatible = "mediatek,mt6328-regulator"
-	}, {
-		.name = "mt6328-keys",
-		.num_resources = ARRAY_SIZE(mt6328_keys_resources),
-		.resources = mt6328_keys_resources,
-		.of_compatible = "mediatek,mt6328-keys"
-	},
+	MFD_CELL_OF("mt6328-regulator", NULL, NULL, 0, 0,
+		    "mediatek,mt6328-regulator"),
+	MFD_CELL_OF("mt6328-keys", mt6328_keys_resources, NULL, 0, 0,
+		    "mediatek,mt6328-keys"),
 };
 
 static const struct mfd_cell mt6357_devs[] = {
-	{
-		.name = "mt6359-auxadc",
-		.of_compatible = "mediatek,mt6357-auxadc"
-	}, {
-		.name = "mt6357-regulator",
-	}, {
-		.name = "mt6357-rtc",
-		.num_resources = ARRAY_SIZE(mt6357_rtc_resources),
-		.resources = mt6357_rtc_resources,
-		.of_compatible = "mediatek,mt6357-rtc",
-	}, {
-		.name = "mt6357-sound",
-		.of_compatible = "mediatek,mt6357-sound"
-	}, {
-		.name = "mt6357-keys",
-		.num_resources = ARRAY_SIZE(mt6357_keys_resources),
-		.resources = mt6357_keys_resources,
-		.of_compatible = "mediatek,mt6357-keys"
-	},
+	MFD_CELL_OF("mt6359-auxadc", NULL, NULL, 0, 0,
+		    "mediatek,mt6357-auxadc"),
+	MFD_CELL_NAME("mt6357-regulator"),
+	MFD_CELL_OF("mt6357-rtc", mt6357_rtc_resources, NULL, 0, 0,
+		    "mediatek,mt6357-rtc"),
+	MFD_CELL_OF("mt6357-sound", NULL, NULL, 0, 0,
+		    "mediatek,mt6357-sound"),
+	MFD_CELL_OF("mt6357-keys", mt6357_keys_resources, NULL, 0, 0,
+		    "mediatek,mt6357-keys"),
 };
 
 /* MT6331 is always used in combination with MT6332 */
 static const struct mfd_cell mt6331_mt6332_devs[] = {
-	{
-		.name = "mt6331-rtc",
-		.num_resources = ARRAY_SIZE(mt6331_rtc_resources),
-		.resources = mt6331_rtc_resources,
-		.of_compatible = "mediatek,mt6331-rtc",
-	}, {
-		.name = "mt6331-regulator",
-		.of_compatible = "mediatek,mt6331-regulator"
-	}, {
-		.name = "mt6332-regulator",
-		.of_compatible = "mediatek,mt6332-regulator"
-	}, {
-		.name = "mt6331-keys",
-		.num_resources = ARRAY_SIZE(mt6331_keys_resources),
-		.resources = mt6331_keys_resources,
-		.of_compatible = "mediatek,mt6331-keys"
-	},
+	MFD_CELL_OF("mt6331-rtc", mt6331_rtc_resources, NULL, 0, 0,
+		    "mediatek,mt6331-rtc"),
+	MFD_CELL_OF("mt6331-regulator", NULL, NULL, 0, 0,
+		    "mediatek,mt6331-regulator"),
+	MFD_CELL_OF("mt6332-regulator", NULL, NULL, 0, 0,
+		    "mediatek,mt6332-regulator"),
+	MFD_CELL_OF("mt6331-keys", mt6331_keys_resources, NULL, 0, 0,
+		    "mediatek,mt6331-keys"),
 };
 
 static const struct mfd_cell mt6358_devs[] = {
-	{
-		.name = "mt6359-auxadc",
-		.of_compatible = "mediatek,mt6358-auxadc"
-	}, {
-		.name = "mt6358-regulator",
-		.of_compatible = "mediatek,mt6358-regulator"
-	}, {
-		.name = "mt6358-rtc",
-		.num_resources = ARRAY_SIZE(mt6358_rtc_resources),
-		.resources = mt6358_rtc_resources,
-		.of_compatible = "mediatek,mt6358-rtc",
-	}, {
-		.name = "mt6358-sound",
-		.of_compatible = "mediatek,mt6358-sound"
-	}, {
-		.name = "mt6358-keys",
-		.num_resources = ARRAY_SIZE(mt6358_keys_resources),
-		.resources = mt6358_keys_resources,
-		.of_compatible = "mediatek,mt6358-keys"
-	},
+	MFD_CELL_OF("mt6359-auxadc", NULL, NULL, 0, 0,
+		    "mediatek,mt6358-auxadc"),
+	MFD_CELL_OF("mt6358-regulator", NULL, NULL, 0, 0,
+		    "mediatek,mt6358-regulator"),
+	MFD_CELL_OF("mt6358-rtc", mt6358_rtc_resources, NULL, 0, 0,
+		    "mediatek,mt6358-rtc"),
+	MFD_CELL_OF("mt6358-sound", NULL, NULL, 0, 0,
+		    "mediatek,mt6358-sound"),
+	MFD_CELL_OF("mt6358-keys", mt6358_keys_resources, NULL, 0, 0,
+		    "mediatek,mt6358-keys"),
 };
 
 static const struct mfd_cell mt6359_devs[] = {
-	{
-		.name = "mt6359-auxadc",
-		.of_compatible = "mediatek,mt6359-auxadc"
-	},
-	{ .name = "mt6359-regulator", },
-	{
-		.name = "mt6359-rtc",
-		.num_resources = ARRAY_SIZE(mt6358_rtc_resources),
-		.resources = mt6358_rtc_resources,
-		.of_compatible = "mediatek,mt6358-rtc",
-	},
-	{ .name = "mt6359-sound", },
-	{
-		.name = "mt6359-keys",
-		.num_resources = ARRAY_SIZE(mt6359_keys_resources),
-		.resources = mt6359_keys_resources,
-		.of_compatible = "mediatek,mt6359-keys"
-	},
-	{
-		.name = "mt6359-accdet",
-		.of_compatible = "mediatek,mt6359-accdet",
-		.num_resources = ARRAY_SIZE(mt6359_accdet_resources),
-		.resources = mt6359_accdet_resources,
-	},
+	MFD_CELL_OF("mt6359-auxadc", NULL, NULL, 0, 0,
+		    "mediatek,mt6359-auxadc"),
+	MFD_CELL_NAME("mt6359-regulator"),
+	MFD_CELL_OF("mt6359-rtc", mt6358_rtc_resources, NULL, 0, 0,
+		    "mediatek,mt6358-rtc"),
+	MFD_CELL_NAME("mt6359-sound"),
+	MFD_CELL_OF("mt6359-keys", mt6359_keys_resources, NULL, 0, 0,
+		    "mediatek,mt6359-keys"),
+	MFD_CELL_OF("mt6359-accdet", mt6359_accdet_resources, NULL, 0, 0,
+		    "mediatek,mt6359-accdet"),
 };
 
 static const struct mfd_cell mt6397_devs[] = {
-	{
-		.name = "mt6397-rtc",
-		.num_resources = ARRAY_SIZE(mt6397_rtc_resources),
-		.resources = mt6397_rtc_resources,
-		.of_compatible = "mediatek,mt6397-rtc",
-	}, {
-		.name = "mt6397-regulator",
-		.of_compatible = "mediatek,mt6397-regulator",
-	}, {
-		.name = "mt6397-codec",
-		.of_compatible = "mediatek,mt6397-codec",
-	}, {
-		.name = "mt6397-clk",
-		.of_compatible = "mediatek,mt6397-clk",
-	}, {
-		.name = "mt6397-pinctrl",
-		.of_compatible = "mediatek,mt6397-pinctrl",
-	}, {
-		.name = "mt6397-keys",
-		.num_resources = ARRAY_SIZE(mt6397_keys_resources),
-		.resources = mt6397_keys_resources,
-		.of_compatible = "mediatek,mt6397-keys"
-	}
+	MFD_CELL_OF("mt6397-rtc", mt6397_rtc_resources, NULL, 0, 0,
+		    "mediatek,mt6397-rtc"),
+	MFD_CELL_OF("mt6397-regulator", NULL, NULL, 0, 0,
+		    "mediatek,mt6397-regulator"),
+	MFD_CELL_OF("mt6397-codec", NULL, NULL, 0, 0,
+		    "mediatek,mt6397-codec"),
+	MFD_CELL_OF("mt6397-clk", NULL, NULL, 0, 0,
+		    "mediatek,mt6397-clk"),
+	MFD_CELL_OF("mt6397-pinctrl", NULL, NULL, 0, 0,
+		    "mediatek,mt6397-pinctrl"),
+	MFD_CELL_OF("mt6397-keys", mt6397_keys_resources, NULL, 0, 0,
+		    "mediatek,mt6397-keys"),
 };
 
 struct chip_data {
-- 
2.43.0

