Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E38630C144;
	Fri, 15 May 2026 21:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778881195; cv=none; b=uAsgsD5d+8MV0406Pe2Eq0OFGbMC8xEFY+BVZpXa2YJZWBnHJIsdyz0kTxNe6Lee68lTUW61MT5fn/U08I69sEytpMDgx07P/g+A1yVumU2tLiwL3S2rCXdG6tBYg5MW1/5ajQBuTWKpqBfQOAgmazd6m8uBia7f+aTvBeKY/Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778881195; c=relaxed/simple;
	bh=AKOYSTnAopVjhKq/egRCzv2oT+9f47rFpyYUVmm1u10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=teYrtJSdqFT75R31IjOffjl1qFG5i/TVD22G/BtV49CFDGKAM52SP44iUZ5gjliqzCsKtm9hhoIxYik6WZ2+fK2k4QG4N7tMSSjewZeeRFHJ8V+tYJc2N5M7QRWsMrn2b9eYkF+ZiG3vdU/+WKJmMZ4HOeC0ENJ7s7dd3JrqyKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=lQKS+yRc; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="lQKS+yRc"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 1AF97267F0;
	Fri, 15 May 2026 23:39:53 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AoQktcRayw3h; Fri, 15 May 2026 23:39:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778881192; bh=AKOYSTnAopVjhKq/egRCzv2oT+9f47rFpyYUVmm1u10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lQKS+yRcrfVvQ/NJKXRhOGCSPUKY0KZUSK8MZ0morKMX3wd1Lo27pThkoiQLSz7AX
	 dyP7wuOWB5uxrNz44MFx2IhMAc4vUiUGCGQnjTl5dHrv+7YlJTXxrt6ZYzrXh1z4gP
	 NkwpowrUV5hVsRGSv2KPZRqdlrAQgrqH0Jo9ONnUwiF2FF+8zh7wBaOV3gjcBoIIDD
	 e46ID22Cmd8IDWmvgpAThRVuy88si6wDRuvtMZXJ6To27983HyWxpfhiCneHY2mclG
	 yEh+LRkju+FpijYXRnBSJ+XooWjIjPE3lxdKn16k+yMdmQ5e6Q1ej1JN9C2F10XPrb
	 9V7b2iNyJq4Aw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sat, 16 May 2026 03:08:37 +0530
Subject: [PATCH v7 05/10] mfd: sec: set DMA coherent mask
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-s2mu005-pmic-v7-5-73f9702fb461@disroot.org>
References: <20260516-s2mu005-pmic-v7-0-73f9702fb461@disroot.org>
In-Reply-To: <20260516-s2mu005-pmic-v7-0-73f9702fb461@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>, 
 =?utf-8?q?=C5=81ukasz_Lebiedzi=C5=84ski?= <kernel@lvkasz.us>, 
 Yassine Oudjana <y.oudjana@protonmail.com>
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
 drivers/mfd/sec-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/sec-common.c b/drivers/mfd/sec-common.c
index 22f6c74eb6c0e..fe92bc4a3dd26 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -221,6 +221,9 @@ int sec_pmic_probe(struct device *dev, int device_type, unsigned int irq,
 	if (IS_ERR(irq_data))
 		return PTR_ERR(irq_data);
 
+	dev->coherent_dma_mask = 0;
+	dev->dma_mask = &dev->coherent_dma_mask;
+
 	pm_runtime_set_active(sec_pmic->dev);
 
 	switch (sec_pmic->device_type) {

-- 
2.53.0

