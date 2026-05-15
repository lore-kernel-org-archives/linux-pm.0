Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A1C44BC93;
	Fri, 15 May 2026 10:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778841637; cv=none; b=rpkLyhhfVDcXX4Sl7p0IOptosXaGfLazNerAjb9XPR5i+ns7dHkNpMF+FATpBAEEoji4uXepEFMqjSPvfwgfYHLYMdcV5hEd2+x5cV2b+8Nve8Y6VoAzFdqXTEuMmtWKrwvJbMtkVIv4IVibzrVGPQfMN1jHzoimtRrjBZc5R80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778841637; c=relaxed/simple;
	bh=IGWSMsR9l3YcM+vGFQnwqbuQBc1K81j9HFRpS0NQ6D4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7wrnt5gCvpAwKXVRqZUH7L9OrrZoMXGy9eG0Ywa48Gh1B38O3fhsRGhvtti8vY6q/EjPZ1LygYJX+uVnnxEa3RvC9g59VPUj5Ki8bcjFxvQVFl/Z/av8Eu12ULyI9P7GyoXSv2OpzJRvXbbo04lS5oxzhHhi8ff0e3xuZwGRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=BWHupkgP; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="BWHupkgP"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 88C3327238;
	Fri, 15 May 2026 12:40:35 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hSdipLkKMsFG; Fri, 15 May 2026 12:40:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1778841635; bh=IGWSMsR9l3YcM+vGFQnwqbuQBc1K81j9HFRpS0NQ6D4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BWHupkgP0Dblz7f+KmqYP47UPC4D5MxnnhrATaa3NQ/ot/Bvc2Ah1dpHj+wPTTQ8Z
	 hC7JTPOGXcN1Xz1vCoesqy6yA+5doUh4ttVlbmnT/iSqa0iY/PJFzPYfR/p+3Z9ju5
	 Yi9c6nP4HlNUPzTq7Nse4XUA44IQVggQq/9Wp7j9L2etsZbNESAVHo9+keZ4bX9aSf
	 cuPNBRilBJU6EGLbD+MxKHWfKAXOrBYyF+DqRlovTxFkPAAGDau22vPsWksTklI0qE
	 KMyQrIn0oIu13xryeBZYQAKsoDXWEF8OWqTki/IF2Wjy28+he1v1ZmMbiSRh8mNAS/
	 Pnhhmml1YvlGw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 15 May 2026 16:09:01 +0530
Subject: [PATCH v6 05/11] mfd: sec: set DMA coherent mask
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-s2mu005-pmic-v6-5-1979106992d4@disroot.org>
References: <20260515-s2mu005-pmic-v6-0-1979106992d4@disroot.org>
In-Reply-To: <20260515-s2mu005-pmic-v6-0-1979106992d4@disroot.org>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Nam Tran <trannamatk@gmail.com>, 
 =?utf-8?q?=C5=81ukasz_Lebiedzi=C5=84ski?= <kernel@lvkasz.us>
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
index ad1c7de83a620..afc9e691bb67c 100644
--- a/drivers/mfd/sec-common.c
+++ b/drivers/mfd/sec-common.c
@@ -215,6 +215,9 @@ int sec_pmic_probe(struct device *dev, int device_type, unsigned int irq,
 	if (IS_ERR(irq_data))
 		return PTR_ERR(irq_data);
 
+	dev->coherent_dma_mask = 0;
+	dev->dma_mask = &dev->coherent_dma_mask;
+
 	pm_runtime_set_active(sec_pmic->dev);
 
 	switch (sec_pmic->device_type) {

-- 
2.53.0

