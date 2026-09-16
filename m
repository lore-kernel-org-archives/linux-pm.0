Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6143A4BEE43
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541384; cv=none; b=hT6Q0kR8KwIWQIBb4s6E1NdOYqhOhR1Lkdp1/Cjpold2NSiPar5ORBR0oI9bLQFCwZGRd7JLCMoBKz9EnWKPgkzYnKPTmzlo1/Pyk6uHE6CJJRFIvn54ljj1qcM5bulpU++ZsFq68hQJp0uRvavXa+vi9+eXYSdLb2GcAh49Qig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541384; c=relaxed/simple;
	bh=KRQLoRgQ1AydKLPoU5/MRbhVS3iuiT+xwoyZ2nT7PF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7+D7sSADPuPesa6Yly6H3I+cXt87sQHX5SrQ4rHluvSwnLIr3ahj2TRsa0wUMMHu1YKPzmj3M5uOSakzHHcUeLvdDnopoc1rQ9YMn6s0QKAcOWgaiVQhL8iLFwwurfOjkeN1kPkymamMtybAHGWGSizSnKOezF7mzRKChNYyoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvWXcJfY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvWXcJfY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B6A1F000FF;
	Wed, 16 Sep 2026 06:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541383;
	bh=IjduQel4CkoJEZxuJkWyyEOnaa3uvOJvpfhafnxoM70=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=kvWXcJfYo4tkFw+zDVe4MzXorWcXI1k2omlmYl7zSGSAR90+BTcXpY1U0kiIppewe
	 8PElXv13MtpPDl5yqr1YeMLi3Le/g1SZ/A358rawpRIma7Jb7zbn8ioJvNLDBnqIoN
	 EsY33boLE7CCRTxvjZzp8HPFXpI2i5NIWUrmGANK2aYCnOgB5ObcPndqejzKqMjX0b
	 OSWsbrAGK26bIoYUNMAxnX7PkSDBTniGScBmTDgxLAjyYUx66Rs4IvqlZqgMhMQVN6
	 cPNZs7v0U+2R5za6xBULesacyL6XadIx1oDtVvGY0hiV4BZr+wHZbUtdK1L0C8vOJH
	 y6D8JNRY8uaaQ==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:37 +0200
Subject: [PATCH 15/15] power: supply: ab8500_fg: Avoid reserved AB8505
 CCConf bit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-15-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

AB8500 defines CCConf bit 1 as CCDeepSleepEna, but AB8505 reserves
bits 7:1 and only defines bit 0, CCPwrUpEna. The fuel-gauge driver
currently writes both bits whenever it starts the coulomb counter.

The Samsung-GT-S7710-Skomer and related Samsung product trees use the
same unconditional value in their fuel-gauge drivers, so they provide
no AB8505 workaround to carry over. Select the value from the detected
PMIC variant instead, retaining the deep-sleep enable bit on all
existing non-AB8505 paths and avoiding the reserved bit on AB8505.

Fixes: a982362c1723 ("mfd: Support for the AB8500 AB8505 variant")
Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500_fg.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index b3f29a43745d..069e7fee1d16 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -451,6 +451,16 @@ static void ab8500_fg_fill_cap_sample(struct ab8500_fg *di, int sample)
 	avg->avg = sample;
 }
 
+static u8 ab8500_fg_cc_config(struct ab8500_fg *di)
+{
+	u8 config = CC_PWR_UP_ENA;
+
+	if (!is_ab8505(di->parent))
+		config |= CC_DEEP_SLEEP_ENA;
+
+	return config;
+}
+
 /**
  * ab8500_fg_coulomb_counter() - enable coulomb counter
  * @di:		pointer to the ab8500_fg structure
@@ -481,7 +491,7 @@ static int ab8500_fg_coulomb_counter(struct ab8500_fg *di, bool enable)
 		/* Start the CC */
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8500_RTC_CC_CONF_REG,
-			(CC_DEEP_SLEEP_ENA | CC_PWR_UP_ENA));
+			ab8500_fg_cc_config(di));
 		if (ret)
 			goto cc_err;
 
@@ -555,7 +565,7 @@ int ab8500_fg_inst_curr_start(struct ab8500_fg *di)
 		/* Start the CC */
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8500_RTC_CC_CONF_REG,
-			(CC_DEEP_SLEEP_ENA | CC_PWR_UP_ENA));
+			ab8500_fg_cc_config(di));
 		if (ret)
 			goto fail;
 	} else {

-- 
2.55.0

