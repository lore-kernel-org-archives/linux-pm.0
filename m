Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE11943A819
	for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 12:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228790; cv=none; b=o3JLVWrgW3rOYiXvNdu91xGj6JuXroGmpg+QDK2Ls69dPg+jSDu9qp9jkEig3ccSiFql4mVAaKUgylWzjDPW2v4V6rzEYroCrXrBdRvmZmBf78qQbWMghS63krt5asXdKAKk9/kBmL7Zy4FT17bNfY9bvbOjKD0OcxRwNnLFrEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228790; c=relaxed/simple;
	bh=EIT7q6rGKbRYBsjvY4Hni82qKnXpt7oUOt261Pme79U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q/dz5yLQr/lrPmP31izBDqxJesOjkNQMU+AGIBr9malSeEly1/oZrW8KiNVS/poNQNX9MIk+GXn42rAwP0vNshC2rPsTWZhq7BokZh6SzFmPwUx6DvP2dF5CD7wEJJvM3cBFWmTHBC3bximgWUd2zJmO+2jCQT/AIBaCITMdmo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N75dO9qe; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N75dO9qe"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956869750eso14223225e9.2
        for <linux-pm@vger.kernel.org>; Thu, 20 Aug 2026 05:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787228786; x=1787833586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uKRxZy2kSNN7s+copbhEGB2/08qX7fHBu0PpcU+cI4Y=;
        b=N75dO9qeZ7wMWYbztUzl77T6ncgpfUEUTaKomqkNCZuDM7VNJ1fI3Vi67vNU/cYhMt
         5uSaVMOsqRy8JlzVbfRkgAyTWaV35RTBV313JoFoUiCsJ98d1sUGvlzY0sVag4evkGFi
         dJKEe3JlKM1c55m+9fkdGp75dDHg5N3zSK4CI8M9U6EY6DBa+p0outH9RIUwjAINdHZB
         qUkR9WQRsJ5rzXgmPgezrS49hxZL7LYoSIRcnPV+qbQn8j4lMXgVrgNpG4peBn3Q0hz5
         cB0xwXgVnpYdqj+/Zn3tzfvfWrbMWXLaIsD/auxmUQ3F8bqVVZd7Fs7BLOgUIg/JwnY8
         Cp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787228786; x=1787833586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uKRxZy2kSNN7s+copbhEGB2/08qX7fHBu0PpcU+cI4Y=;
        b=nYwjsDJUSYaRCEzXoQSevJ4jRobknlO2xVoeVcCqRkoCIzV5oosWasVFSMm5xfHtI8
         zQbT0kM0c29ET7zp8AUrbi3zyVfrS2r2facvV2v/f9QToZ7zLsfJYu2uXocTJIEAW0RY
         tZFq1zNH+UFYzALAEFFvfA1EwkE11K/ATuIq8KwXMVHFQu9uW5wt5mWLDoW9CZHmI+ku
         thhMZl55uwpC1b7cGwmqrLD7GyU5l11AnMswyfppdcufqKPet7z0MiiMTfqWTwuQrOIG
         sWw83yqo4mqAxXxSjNYDLrYMGt0CzgSFYtujdTunGTtD1+hpG3SIW7/CEzfN5UEALGIN
         3yFg==
X-Forwarded-Encrypted: i=1; AHgh+RooB6kMN2fhv3rTdkwjUEOiTUrsijvY5mAIuYZ2aH9uCuoJpcwp+/gDHOkETfRq6l4dJZERvDaf4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+I/2xEsdjvhaE20chby2kskGjhkMcQfNvmsEisH3VuRQYXxN1
	2uJaXSSCjLKq/WAWbeMNNYgFkIVogHNjKNZAJpGj+tlbW6tfyGo64hYF
X-Gm-Gg: AR+sD13GQAXlxyF/Ew4HDtxTRynE05R0POtyeIQFe8pMrPnAexMZ2B8JAID8du/IJDL
	G6A0CE8DPrSrlVAi5lgSdLkc3mbl8zRA/muqGYiU+q1d0Lze4nNDJqnuT1oMnQeTEu5uPXULFd4
	3wJ8OnX+qIRVWFf/KKoyJyD96YKsBfD71DWErTGze951Z2xDmIQpzsvDtXqSjvrrpTqh84cRO1/
	PK9N2IGwQp3/9VCkIpd8FC7fvRCdbWaGwPpRibNQCBDkKAcjJfOTsfY0KGhoyvGiZPiborjS62T
	2GJzaJqUOb+R8KDUkHzGu2KKvYig1v1WAk/kTD+CpJHhaI5COwylsCiajeqWwH8s5yJBQXuFi5x
	cX0DaeQjP1c6uNljUPAsJCiXje+20LzY/XK+izxmCbL+VJRKtrXQWvUGZPe9rmL+64WVccrE6GS
	RiYM03D/2a6kWd/Ck7A45sYLF2UNcw+0Ay7cfjOSpi/EjAT075OfaG2w==
X-Received: by 2002:a05:600c:4e8e:b0:493:aa0a:45ad with SMTP id 5b1f17b1804b1-499aa17dd15mr187045085e9.2.1787228786074;
        Thu, 20 Aug 2026 05:26:26 -0700 (PDT)
Received: from luca-vm.. ([81.56.18.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm170494645e9.8.2026.08.20.05.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 05:26:25 -0700 (PDT)
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
Subject: [PATCH v9 4/9] mfd: mt6397: Use MFD_CELL_* to describe sub-devices
Date: Thu, 20 Aug 2026 14:20:02 +0200
Message-ID: <20260820122242.120039-5-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820122242.120039-1-l.scorcia@gmail.com>
References: <20260820122242.120039-1-l.scorcia@gmail.com>
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
 drivers/mfd/mt6397-core.c | 197 ++++++++++++--------------------------
 1 file changed, 63 insertions(+), 134 deletions(-)

diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
index 1bdacda9a933..ccd97d66d7f1 100644
--- a/drivers/mfd/mt6397-core.c
+++ b/drivers/mfd/mt6397-core.c
@@ -124,159 +124,88 @@ static const struct resource mt6323_pwrc_resources[] = {
 };
 
 static const struct mfd_cell mt6323_devs[] = {
-	{
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

