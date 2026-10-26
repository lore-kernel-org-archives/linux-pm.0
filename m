Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014725;
	b=uQrbGDN1pYm5qLbPyPSHOmkFnNfXP01rD3Marcf/fT7DaG+DiCjehh/eGv5KKeu68mnS
	 pXHF9Wnpg3lcYR+49f3txvHJJK2RrzdJmCPANRmKqINaw0pk14ZX5NrP33d9dfJjT3A3I
	 yepnDaX8EumyW1kF4zMENUHBOdNwayggM4217XXI9675Pusp6TiUgr3UYxNbzzbvsHOaw
	 1HQUWMCe3zm7AzGxcEYhonZ6YPbGOgEs3ZV5/VsoXX1grJHyA23FioqJFe4y5AdIBzW89
	 RryialkMAW6mQDqdca6IrKt7er0WI/+cY1ogVAuGgVR/KQ5d/qlVs3yX2y8f4Rnl9wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=rmWzCzfSpt1rDCtVaLDN9FMHes3sH28/Mle8yGwChlY=;
	b=YZ4r7pbCZNTDcaBcu5RlzuGDbOEKCvtkU0N4poA3AhLDmTdoV3vIKwTwPlcwzREUdN6h
	 uBboeB1vrvCDjc33qS6AVknuI8es9r5pBovIcSJdHgSFuWiDXmhfMgqdgqy8pAbIzyFiv
	 QmPmHxcxT+a5sdL3YVt2IdEQ98W062A9zfD7/yWHGLorSlUwvMARkyqji1atlU7SQ4z0m
	 pH79Y4s4vkuOFgELeMn9RW+iuTDpIphXSOapvI2CRf+3hFFaW+rJ6vIdD349eDZJwP9cQ
	 k4V5okcHR6WxBOrTVVg9jThYodlk23G/vDiRGJ176orCaLaEwE1IVtI+IxlkUepwHkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=imd-tec.com;
	spf=pass smtp.mailfrom=imd-tec.com;
	dkim=pass header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256 header.s=google header.b="N+/aFAtt";
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C100606A323
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 11:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C100606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imd-tec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imd-tec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.a=rsa-sha256 header.s=google header.b=N+/aFAtt
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so18596695e9.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 04:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=imd-tec.com; s=google; t=1793014722; x=1793619522; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rmWzCzfSpt1rDCtVaLDN9FMHes3sH28/Mle8yGwChlY=;
        b=N+/aFAttA7wTxM0/7LDeAzXgMIzcPEMVDQ7jPp7ixWrZDgJlJYT1Qhb2CUQSDuEZv8
         Z7tjPRXeq9kmXmL2mQwtAqFotnrpYWH/hXktftDr7u1b+VAbjt+ZFw9PlOyi600cfkNB
         9twYYrZi99rcUTsg5p07Z5cpv2idOP5looPy9Zesok2XZ2JR6Ysr/C4faeaZFkmXZCxw
         tmkrFu05bYotW/Mk/xoOJ83I5QqSVBhovvemo4jRv8HJfY2bN0Rz0dEdKTyd6NgHTrdV
         fxYjrhPMJ7blXzncrjaf89sB989y1ya/HATIn8yaGCV5hZjENniIgAo9vbauslHNWPvA
         tyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793014722; x=1793619522;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rmWzCzfSpt1rDCtVaLDN9FMHes3sH28/Mle8yGwChlY=;
        b=ChPVZkdwXeWyoyB35pXqIoLnuJxmJXH5tNYd3bPXPx/9+1mtRTIdCkW+YxSy4lZ9+4
         8OYnuAbKoNGNVvR59NeZ5H5JkEeUS5xbcyDGc2KqPxb4Ahh3cW92IFBYS3OdNuUdwvsI
         9c6PWMom6QgUZPM2cu2VtwZW9kpoOCLq9vbix5SIBM6PL9Y2vID96X8cOR+Loikrxw/A
         QdHr3Tv+HvKAHKQuSSw84A1Z88DSCxDcnfpMszUcTME5HAQvqbqt30Hsu9V8G3ZcgMmL
         P0ZRSw9U7dHn5TcBWy7DdOn33MGfCW0fBb7WvZ9AFQAWEYZIs0hqYm5y9tt+DNwObEci
         P58A==
X-Forwarded-Encrypted: i=1; AKwUvBxxAySc1TWkT6bR6EKKtHX6473a5Gd7lmLoyl0fuEHp3vEPhXLCThCuyiFY+jJ9QhM//5aIeiHMsA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6SkYfU7/GzIJf/PwAdJjGr0x8ThIoXam1MKJUHqXG4wiq8D7w
	3gfrqfpcuJs/d0O6RZ3wvxVvSK09HxK2ALp0ty3OWp3g9aC2ufAArkgWeEADgZeVFmc=
X-Gm-Gg: AYBFou1ArnHq6YO8kMVityvdtqfMU6nURexq86naJHEBkSFoJG848jcxIQKqNfdPGBE
	wyarUoVSKuVSWaB+gFfQ71GGy5gLLUOiQcz/PKjIGLoqhkiqV4kgweLp7VFw1n2XgE3DvxM/C+r
	fEUpEd/2Hz8v1Qm4FJRf6bBb8+iuUi66TREImyMxGD1w3vOB8aoAYfK11mNE1wjN9uH1C6mZbtv
	jbfncB3WuqnO1GkVWWDuZ3b3uRMXK924gkY585In7zvvRC7liH2d6YPsd58P7xO4E/xqaQ7l/9W
	uHBdc48+oavQJsLs6EgaAQapz7I+ZNEmEaGd1/KQG6BMcmqyoBpgCS8+vxvYw+4oxbK+hy3T5tC
	VXuR08AT0V6wpVOVKSQVo3tyfrXF8vjBofGY+UvnifZ5WU472HHuttovc/RcbyIkQT2KbcJf3ta
	Fl4BV664ohrNRr1jMXOyXjX0jMQDWemDQ7+YI4whUMR72jtL8CTeNc46QgYeaodImUlJFN45ZMR
	beWI15v+Wh5hs5T05zbLvKKYJ+dQylt07j3YOJ2GDAaBn7kt/1X7GqbGh5PL3AEa3WT+OIKbj3h
	z4QmGNJwq6KEy+Kro/0r8uvTje3rnLmRSd0HGr9TGxRB+ENpVXgZGH1sLubm+9mqxJSsM/o8ujF
	gGRc=
X-Received: by 2002:a05:600c:3acb:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4a35aca4fe1mr116576345e9.16.1793014722474;
        Mon, 26 Oct 2026 04:38:42 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a04ad39sm503355405e9.1.2026.10.26.04.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:38:42 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Mon, 26 Oct 2026 11:38:38 +0000
Subject: [PATCH] power: sequencing: pcie-m2: Drive the Key E SDIO_RESET#
 signal
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-pwrseq-pcie-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com>
X-B4-Tracking: v=1; b=H4sIAL0732oC/yXMyw6CMBCF4Vchs3YS2iBBX8W4qO1Bh0SoM3hJC
 O9ulcVZfIvzL2RQgdGxWkjxEpNpLHC7iuItjFewpGLytW9dGee3Gh6co4Dvni3JxArDzLXbNwc
 fuqYNico/K3r5/Nun82Z7XgbE+Rekdf0Cc7Zl1X0AAAA=
X-Change-ID: 20261026-pwrseq-pcie-m2-sdio-reset-015492a846ad
To: Manivannan Sadhasivam <mani@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2

The pcie-m2-e-connector binding describes sdio-reset-gpios, but the
driver never requested it, so the line was left to pinctrl or to its
reset state.

Request it asserted, like W_DISABLE1# and W_DISABLE2#, deassert it once
the connector supplies are enabled and assert it again before they are
disabled. The card is then held in reset through power-up, and the
line is never driven high into an unpowered card.

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
The pcie-m2-e-connector binding describes sdio-reset-gpios, but the
driver never requested it. This holds the card in SDIO reset until the
connector supplies are enabled, and asserts it again before they are
disabled, matching how W_DISABLE1# and W_DISABLE2# are handled.
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index cafa642a4b6b..5f5a116063da 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -39,6 +39,7 @@ struct pwrseq_pcie_m2_ctx {
 	struct notifier_block nb;
 	struct gpio_desc *w_disable1_gpio;
 	struct gpio_desc *w_disable2_gpio;
+	struct gpio_desc *sdio_reset_gpio;
 	struct device *dev;
 	struct list_head pci_devices;
 	struct mutex list_lock;
@@ -47,13 +48,23 @@ struct pwrseq_pcie_m2_ctx {
 static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = regulator_bulk_enable(ctx->num_vregs, ctx->regs);
+	if (ret)
+		return ret;
 
-	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
+	return gpiod_set_value_cansleep(ctx->sdio_reset_gpio, 0);
 }
 
 static int pwrseq_pcie_m2_vregs_disable(struct pwrseq_device *pwrseq)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = pwrseq_device_get_drvdata(pwrseq);
+	int ret;
+
+	ret = gpiod_set_value_cansleep(ctx->sdio_reset_gpio, 1);
+	if (ret)
+		return ret;
 
 	return regulator_bulk_disable(ctx->num_vregs, ctx->regs);
 }
@@ -562,6 +573,13 @@ static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 		goto err_free_regulators;
 	}
 
+	ctx->sdio_reset_gpio = devm_gpiod_get_optional(dev, "sdio-reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->sdio_reset_gpio)) {
+		ret = dev_err_probe(dev, PTR_ERR(ctx->sdio_reset_gpio),
+				     "Failed to get the SDIO_RESET# GPIO\n");
+		goto err_free_regulators;
+	}
+
 	config.parent = dev;
 	config.owner = THIS_MODULE;
 	config.drvdata = ctx;

---
base-commit: 1a0586064ee1fbcefe49b6382ee17a236c590879
change-id: 20261026-pwrseq-pcie-m2-sdio-reset-015492a846ad

Best regards,
--  
William Bright <william.bright@imd-tec.com>

