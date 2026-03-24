Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DE63EDACF
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774352317; cv=none; b=FB0+4WsXXyNjcXoZaGTJJSmbXpZkIEB2ktBjYHmjQ0+xdr4GqT4MQAniVhpH2a820w6Dlqe7208XTeCvcXrEZ0THQQo+u7fd/1ygsPJyAKD/Fe87kV1imSpyd9a9M1ks4r1+VaDHvpoGOLUhTtDZrGw6tgIGsdWoQykBGnDLAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774352317; c=relaxed/simple;
	bh=Vj+thyx6im8c/60dw5piAk8vyroKtJcY1a74UdrGYxA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h5QF3W2+A/PJuxnbf6oLkYGFm+GjIjxjfJyaPCIbOUF4727K1OBIv8ANKGNNw4evqoALV7s8BkX2f1tEjdwdHJDiH1YupbNDLSJtEIMVDQXWomyVk1pwn17nDjzSPA1j2mhnNEMqCp7Z1YfzhzQc/01hnz2AVvm7M+aA5m4Ohfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=Udfi6hJa; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="Udfi6hJa"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-486507134e4so14301055e9.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1774352313; x=1774957113; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8wsphdPWc7OLP974m9ulR0tmXF0Yx3Br+A797hF6by8=;
        b=Udfi6hJaz9WmpD5YGp741cUe0QC7ni90n0Dx/zBfjYw0XvsImq6XcBoeQiN8st6xAe
         B3b3Z7L3cDx/f1wCV5EKw2lPwCLBNWrmcUVJyXWI2/0AWMvBmt6m7Bibe930SrTSGgAG
         fLLGKeaJqkH59Ys0MEhXK9lBit+FBUI7C3hb7TqcP3gJYsSWBPv49yDkLaUbmOZXhF98
         WJUqzivV4WwGbDg5OBLF7W1Jloh8jWLAomZtlsZwq7ppPnFa7zCfnZuCj8KdB3hYszgA
         tYDyy3NqPIZBO693LY2oGgyvzyM5jW/6FJGNoagUybVRtd1Nlp++GRGKMCIxq9qaZZlV
         3Ayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774352313; x=1774957113;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8wsphdPWc7OLP974m9ulR0tmXF0Yx3Br+A797hF6by8=;
        b=XtgQK9P48NAoj5aR7oarzQ7Hil9Of0WevtUu196TZ+SaJ1we2lI9EQ8APAmqIUnNHX
         rznIKe9bbJ/jc14eEsyx843zblytSyQ04aRtI2TJl3zE0RMd4kEORAE7rsxgQuu9wNgL
         /BtaxD9zkG4jXRCnZ+wTaj3y8z+I9WFFLp4T1GsOsu4DMStvCw5DQLNIM5P/FfIwB15r
         JF1mjm1uOVmyM+laMfmGazSfy0wJsSOgTSgO6DEqKBjQScUwhz7SkO0zP6KijpuuqXvX
         RZ0RHQ8w/+5x+yAcY21rnmsjOyF0FxYmNH2XOkSwulbYjo0ZReDs1pLIHX0lUhcbGh9x
         C72Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzoEIW0U4/qEmFlFRkem1pneV6pSi+0F2mmB1SS4I5r0MXHUPZmRehUkZ6fVk0B4APv7lLqkVD+A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyarHq/S/l7EUJprbfgfgfbjs44397tmomT4HdBrksLDE/6JRuJ
	9K/ZoN1eZRl3qu4McmoziEzTgK2mwlbq1MZfah1XwIm44zGVssg8FO4iPfxUICOowbA=
X-Gm-Gg: ATEYQzyoImzIbi4WwW0BANv/0hU5yarp01WL4SbWhkjqp4++xiwgw9HKjAM/PhXYp6a
	ViIJHNYhIQ/lRflgxGDU36IffxS3/Td3DpxgobrUCHta+e+yxF/sioU/grPqn5TofL73jPI4t9h
	QQkIe7jU+eINMxfsx0N5prpqShrq/bE+7zo9VN7bGVsyv4nfWq8NU4Z6Dzb7Nt+lVQTtBtn8oq5
	OMlfUVrfC5eYs6w1Ld6WTprOtpxWxpBNa75pkIfbmL6jjFL0MRQceDJDErd8h+6QB64HB2haI5b
	bsTBKD9k52PLDnc4g6cWww6Q/izIcO3tKrD2ffaLE/7Br/dGkPNkXKR01h1ghfIznqHZ2i7/r/V
	5m8+ynFFywrUQDgnxiOQeLIdPQJNOwiGhLM/oX14yzXx/7uHMt12j4v3o3V1zLv/OOcDmRG8faI
	XsfJuHcuonalOSueFYg+sHtUTvlPcMOonyAF+mvV96GcG6YpbHVua6dV3+2zlaEPn25KEqe0S8G
	/YTMQ==
X-Received: by 2002:a05:600c:8b18:b0:485:40fd:8390 with SMTP id 5b1f17b1804b1-486ff01b49emr197751245e9.26.1774352313338;
        Tue, 24 Mar 2026 04:38:33 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-109.alshamil.net.ae. [86.98.192.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4870f6c0fa6sm20846715e9.1.2026.03.24.04.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 04:38:33 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 24 Mar 2026 15:38:09 +0400
Subject: [PATCH v5 04/11] regulator: bq257xx: Make OTG enable GPIO really
 optional
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-bq25792-v5-4-0a2eb58cf11d@flipper.net>
References: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
In-Reply-To: <20260324-bq25792-v5-0-0a2eb58cf11d@flipper.net>
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
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQeKl/rOHvz9Kigk/G3JCUX75M7ku14YzGzSXV9dUdUd
 oBr5pbTHRNZGMS4GCzFFFnmfltiO9WIb9YuD4+vMHNYmUCGSIs0MAABCwNfbmJeqZGOkZ6ptqGe
 oaGOsY4RAxenAEx1ThnDfy+1nLMVMj2XuYsSzn6arXWtSNdjfcQj3eU7FrIv7058osLIcPrRynY
 50xVPDXdcjZjb584Q/2IJ/xOWruYNK0Uc8w4/YQUA
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

