Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B93DF000
	for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230192; cv=none; b=nVEK1NFfvSeJmbVAAkY4z1lFnJrOHKcCj9RkShBJswhu3Xi/mWwmflxffpvg7lEDRV57PzbqxFRevOe4Cfjk5627GRIamIBRNcQ5+2e0w9LOwWxViiNNQh0eZJa/p5xhBbiNLqcf2LEs5ANgNgNilhnOL0sa55X5S1mBlPbVfJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230192; c=relaxed/simple;
	bh=Vj+thyx6im8c/60dw5piAk8vyroKtJcY1a74UdrGYxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5e4OgEjxrnWtATvcv1Guta+kwOjP38ap0ENpwYu+OvHS1g288xsQOTpuA2S9rECgKiKPsbbVOYrxcKUiumEBywgzimrUaii1r0j/GTsgUpA6fXEIOOXCkYvqcSK+TiliHRjwIwBl4ah6qxz1W2hOQyc41HnYUPhWkvJEgfvcOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=iOt1r1zw; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="iOt1r1zw"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso115699065e9.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1773230190; x=1773834990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wsphdPWc7OLP974m9ulR0tmXF0Yx3Br+A797hF6by8=;
        b=iOt1r1zwaX9ESpgKEVpdL1reSJXdLv+YS7me+9QfcNn91Uk0VneW0uTU6sJzNNOk6R
         VtPtZGMsPIGMQVYD1NfFctLJgld1vNdZReEnxTxjwvGnYk760PVzVVReFdY+fQRys7mg
         V4psGXl+BK0xZ4ones8Cs/y5U2RZN15YmgZW1xxxU8SQA8zOP8vWV7u2CnJyiCwju9fp
         nfRJCykhzTZG33LdVogB+CH6HUg8yx/c5lUtdWJApIZAe06oYpEW+BmzxrIBOK5nFUhg
         vufbWbDLo9sa2+BItluuWnGTDgDnj9cGwyIbWoQY4P7sJ2i52mVD/GDlc3kbsip8WrHo
         4kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230190; x=1773834990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8wsphdPWc7OLP974m9ulR0tmXF0Yx3Br+A797hF6by8=;
        b=Mt9MiuCg+5SGfpsQQjLgJLYqP8lrMhGosJidtSj8Ozkc/3r5nADrnQV0CvcohlqIn2
         4kIkCB0JUySe/h5F1PIfq0EXQ/CwW7jdbYX8NqWtDSJRgnVkoUd7nTsGOY3PihlKTpet
         1XuSsZ2TSYwTHAUYRQgYtgcpaNyg1Hg3IrDqX0gY3P7mIA3QV2AHC8ZjCrQQSpKmTVIb
         YdO0THtQOO+lXn1qynbOs5knngRDTkC9u/NyyJpOnJ9NCCW9VyaqBauI+8+4nOfwNIlE
         1/zSxeW8miFMp/mpm+mwMq+CbJgm2BgLMgkCL1D0m4SFKICJWfzxBE/z59hXLc2dt0BJ
         sGTg==
X-Forwarded-Encrypted: i=1; AJvYcCXqmaywhpV/DTIVUFxqApTITCUvs9fE8NyRcwaTJ2h1dQRpuMVqrrSUO8RhLSDGQWtKhAlR6h5qpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YztLGbZF5VvJ55XEYe+e06Rd/7d2kgNpw4yBKrFgxCYD5QcIONN
	stvcurfYoNXeLO/bpgVYG5MhfJKL/N5ZHXWXLphg/dAeykBsAXbr5Z2KcjETOlrLvt8=
X-Gm-Gg: ATEYQzzcELCVus/sQAuAQR7dPPfB+/tpyiJIocFHJfmH45n2praobD2EAZoH3E6G6aV
	ilDuVbMWi6blpwAUldEC6T9DjXfK7B2Ln2DjF8n/3SZhHYlwu76L08NuRo5GsmFhwhGbXijIb0L
	5sECie8hlT3Djr5fOp3RFZcSGPn5j4sEMNXTV1NJKY6LRPHoU4IvDoxHdFS8oSVVXbM1zjclsRC
	wjZ1YhAisUqSDMfY+1Y6VpsTIFesCBHgOmUODYhRJfQTnIVHrGIsA1NRxIicl3a3rQXjcU68jmN
	Wulvs4DUFyLddzcg628yLw+4Ftmi4sPRI/qR/xeZWQIjKm+/vlNLtdRxLaSn9aDM9dVJmXgoiH5
	eAxbFQSD2syWbeGw4a0EeL5csO87ZPMjaozq+nvfBTYT851+DwEgQ13/cxMVYNnD12STDaHKqBL
	vAzUstQrC27Z5nD1SMLlVvHpBMiAQGR0XvUCUYPMHbYC+AWP1XvZ6TGX/V56ts+696to08D+9iN
	JgNGQ==
X-Received: by 2002:a05:600c:1d0e:b0:485:364e:9328 with SMTP id 5b1f17b1804b1-4854b10c82amr38597485e9.16.1773230189640;
        Wed, 11 Mar 2026 04:56:29 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854ad5416bsm39586485e9.1.2026.03.11.04.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 04:56:29 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 11 Mar 2026 15:56:17 +0400
Subject: [PATCH v4 04/11] regulator: bq257xx: Make OTG enable GPIO really
 optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-bq25792-v4-4-7213415d9eec@flipper.net>
References: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
In-Reply-To: <20260311-bq25792-v4-0-7213415d9eec@flipper.net>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-pm@vger.kernel.org, Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1183; i=alchark@flipper.net;
 h=from:subject:message-id; bh=Vj+thyx6im8c/60dw5piAk8vyroKtJcY1a74UdrGYxA=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRujEhWinB7G5m+51bI9o13WsxbYqadDyoSnf/YKrr3e
 lTr9FMKHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEz170BGhr8/rge99V63ZTJHQ+2aTZszBaSSGzlbJr5iPLnzwbbUQ/aMDJ25f24
 Kqs06ofp79t9vDrO7zxzdNzdIceq++HnPBRUm1/ACAA==
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5

The bindings describe the OTG enable GPIO as optional, but the driver
gets upset if it's not provided in the device tree.

Make the driver accept the absence of the GPIO, and just use register
writes to handle OTG mode in that case, skipping the error message for
-ENOENT.

Acked-by: Mark Brown <broonie@kernel.org>
Tested-by: Chris Morgan <macromorgan@hotmail.com>
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 drivers/regulator/bq257xx-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/bq257xx-regulator.c b/drivers/regulator/bq257xx-regulator.c
index 674dae6109e9..0bb58ab4b8d4 100644
--- a/drivers/regulator/bq257xx-regulator.c
+++ b/drivers/regulator/bq257xx-regulator.c
@@ -126,6 +126,12 @@ static void bq257xx_reg_dt_parse_gpio(struct platform_device *pdev)
 	of_node_put(subchild);
 
 	if (IS_ERR(pdata->otg_en_gpio)) {
+		if (PTR_ERR(pdata->otg_en_gpio) == -ENOENT) {
+			/* No GPIO, will only use register writes for OTG */
+			pdata->otg_en_gpio = NULL;
+			return;
+		}
+
 		dev_err(&pdev->dev, "Error getting enable gpio: %ld\n",
 			PTR_ERR(pdata->otg_en_gpio));
 		return;

-- 
2.52.0

