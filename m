Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED103AA1B9;
	Tue, 24 Feb 2026 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771960568; cv=none; b=KFoF+aj9eBHu8tha+jr2f96k15SKdS+FMjyUSp3KNUr/Aax7qUugH0mJyd03gJEdWFnChA+TD53qROre4x040wCiCDuIEY53vSAHJtKrVcQY9pF9pqfwaz3GOFuIVUHiScIUpOksjxI/WVBmKel1adB8muc3uquKlc4zgpZveGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771960568; c=relaxed/simple;
	bh=HeqaD5C3VbcMLUgV66c0r5Xm/5P8DBm2op8E5VgnAKc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bxvG1gNiOJMllvQ+FUj1sNbj31bS3PIlYzLga7MfJYSZo6iEcfoiZ85AziA5rY8PHiIPq2/l5WrS/SK+SY9NufI/CXovwQd9OuMK9ZplJZhcB75g44vgm2Pxftdy6kA7x4uiIZXECihubTq2/BX2hW6EXAIyzcGkkJLNdbHvp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=cVp8Q3oy; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="cVp8Q3oy"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 4E90326FB7;
	Tue, 24 Feb 2026 20:16:06 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hJxx7fzy_zxt; Tue, 24 Feb 2026 20:16:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1771960565; bh=HeqaD5C3VbcMLUgV66c0r5Xm/5P8DBm2op8E5VgnAKc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cVp8Q3oydOATNesONIanc0h/IsT6SbZk0NcinukCbjnzAg3ygdIoP6kVocJJYY6I5
	 aLfj/rKotCeTlINaCDHYtesO16otnBEvOjyxksR1zglzHEYHj/HcKxStYatGUAlg9o
	 vIe/P9IwJYKvVRn1OodR5BCzuRdFFjMM9A5zTy0yJJmoQkNW9QzQuY676C+pkn/kRc
	 BDaXveGje9mLJY4QEyyTWRoumuZDQjdNd8YPZbyAVaBJcgXEHDijXXQZ+VRWcdW318
	 vQY0xFZ1erIeXH8zgc3jBcj9ufcSQQDYx51Fz68oFHPVTVtl1eiKJM5JTdHGsCU6Xj
	 nWbvcaVNtF8rw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Wed, 25 Feb 2026 00:45:09 +0530
Subject: [PATCH v3 07/13] mfd: sec: set DMA coherent mask
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-s2mu005-pmic-v3-7-b4afee947603@disroot.org>
References: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
In-Reply-To: <20260225-s2mu005-pmic-v3-0-b4afee947603@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org, 
 linux-doc@vger.kernel.org, Kaustabh Chakraborty <kauschluss@disroot.org>

Kernel logs are filled with "DMA mask not set" messages for every
sub-device. The device does not use DMA for communication, so these
messages are useless. Disable the coherent DMA mask for the PMIC device,
which is also propagated to sub-devices.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 drivers/mfd/sec-i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/sec-i2c.c b/drivers/mfd/sec-i2c.c
index d8609886fcc80..9fa1449a4f6eb 100644
--- a/drivers/mfd/sec-i2c.c
+++ b/drivers/mfd/sec-i2c.c
@@ -177,6 +177,9 @@ static int sec_pmic_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(regmap_pmic),
 				     "regmap init failed\n");
 
+	client->dev.coherent_dma_mask = 0;
+	client->dev.dma_mask = &client->dev.coherent_dma_mask;
+
 	return sec_pmic_probe(&client->dev, pdata->device_type, client->irq,
 			      regmap_pmic, client);
 }

-- 
2.52.0

