Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864414;
	b=RAJOIq00S2EleESN2wifEWczqh17Fl4FInktRoUYuLfTAwUNrvfATMFEc+nQatOERnNd
	 gmziONbeQyuIndWgjI6oI7ZvyJDfEg2sW1+c6lIm0dNqkJGGh4JA454ZRPi6JXOe7TmXd
	 OWzltpO5Jr/gvsi/XvFBGfMGvyO9gui/xq6Mn3ZQ3+s1SFcwPkLBnMNGedtbAhGVBgv1a
	 lzgwoH6lSH+emG77buCuFAAev8uO1JYD9+3fLpqWH4g2Xu+SvmaWmP9RaZptt9ItBS/E7
	 Pzohs0EsulNLGQxMo93awG4Xy6uH6rfZATPyrd/tyYWMoKSrhUSf8GzVM0Pz4UlClcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
	b=uSeA4XcxWVfyz7F5ewOrQCibPfGI2sCRo+znn+C0CdTxjLHbI7rzQQSbtYOcEZPN5vla
	 x6n9xi8Y2TFvbHxnliSnyy53euBTVD+NjmTLD7eeQ1sgD5dgBrWhXs82MWkuwZkjF5Rte
	 qRy3G6AkQI2BFMbFl4qC7NUF0XmYRm7CkzCKbw6Buoi3HyzGG2Mj3nILtGdDFZ89j3m1G
	 nHATD9OxFhyusw5KmA/9davAkXmbrLlHHiioc58nVsEiGQnknGuxkqUW3wCBktuIGbsJ9
	 2xUkKxlxy2XJNEOsmS8dO/EVMZPMnTE0VutbJGceb0P2w25IQDESqnXY5KQ12+VAtfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MAURpxwo;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4ECA606A331
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:26:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4ECA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MAURpxwo
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso41038215e9.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864412; x=1795469212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
        b=MAURpxwoicsksSVnc2WAsPB6JHUpT01pe/omkWv1cyD9LfvrkdfTpz9XI4PTsY+lD4
         SGrVtbMkILUcB8UlVxbff+5OGS2lWyRPg4+99wfZZJ3kK751LFxY/m8LTjr6oiMVus8k
         NLNpqxitTryKXQIbIcsKSMHDOxKylCzOFabOSB6t/1IlelEkuKnAU8DjjPvXU/qZDKLp
         LUS0foLTPneGc0r/9RGpT435PfWh/Tw1+g5u3NiaPw6KH3UroKGAVTBs+bDKLGIwpZ8n
         3wkffWoIIDLNuNqC9dnlPrAPuX1jUL9NxQr36U7VkPrRC2O736zzBd6z1/JXDHPc7i5T
         PENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864412; x=1795469212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
        b=ylQx4IBiep504DXNc1oba9B5yjMPW0BuM1wGrcQM5pzr6LcnhPX6JGZd54t8+n5IMi
         DCt0kMcNTvwHZmgVkJi2eSVtdT7Eonw9os7Z0Kbrox00Rw0Aj0dPWcrsh+vEW+RD1G/Z
         dAJ59+zSW1UznT9Zv46I4W2S9iIeeskSTBYPO7tCyayDuzahVnfCwnoJDxh6kwKL8+nJ
         YwxpBTH7oFO0AEisHOCVu4p960WZGN8bnxg/Qvr+9Xugrp/chfUGdXQGVnsLQvtUwAu3
         SDryCOYsdRrQg9Q/TBao0NwNwYmVxvigCMhdJyckmSA0D1W7kn0dRVFUD+XnFxoDjj0V
         T3SA==
X-Forwarded-Encrypted: i=1; AL+hErEi07J4dtLRj8JeDrUnp9FQWWy0zCWArbGZxOMlfI5r2fiPj6qE2unLnZvig9IPA08HiYCfvc3xQQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/cmPYZ23ACkwYILi0Ygh9eDv5FHXQ1aGfOslgNfFToyiQ/qCZ9
	e4lHkUhKDQaUmwczuokavVYdRIWxRKYssevVSwfchtpCTyQjppb4tsVE
X-Gm-Gg: AYBFou0qi6eU0nq97G1BGCoP19HdQjPZlJq6VmgXLbNfY14Y6KD2nmmN7Ol4fLZKNRz
	4TzD4yszxhlGSJI/45rtPjAgL2I+9dzhvN23/AV63AF8YTgwBe5LJkRGmogy3xYVgetLJfCY8XF
	scR+7Jh1yNZh6LltfMdQNMzwsnpgNIyhTpNYRpDBBeZaERudqzL67Rn2IyYFBsskKeb81UMAYee
	RFwYhHnHmyhTKxdt9UOFTvQqJvrZq8fVGdBWUa6hyNMR/vzTuaJw967YvzznNTwvZ3G/tdZecY/
	mwUBdrAvehiXn4AoQitbtlQjTVfumqUkX/kMHbQEfbmcw64+4BSmWfrhs+MiRn7rsLIa1A1NVCw
	21DOZIg1OR48uUVtO2iVOv54WXSVJzmgyf11ohlxlkXKOk6W90oGkXSB5l9rbhDfqIXyZdG7CZv
	xOpMXAxw6XP1BQ/Fks8sMI8u+hcrXuXQmL6DrmK2kllN6jnzD/3Gshr0ytLbYcktM46h/c5HWDy
	Mh0vC8MLADw4aN4EkoaQjBPvFRX5Ty4/KqKRDBNjv3/4sKt40JyQLc2occKT/LABZ1FAUKk/tHz
	RSMkSwTppPWO1B8d4Z7Qm3nQ0nsjX+2GMC27yCdy
X-Received: by 2002:a05:600c:3d92:b0:4ba:e7:ef3d with SMTP id 5b1f17b1804b1-4bb559f7044mr243891145e9.1.1794864412296;
        Mon, 16 Nov 2026 13:26:52 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:26:51 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:19 +0000
Subject: [PATCH v2 03/16] dt-bindings: mfd: qcom,tcsr: Add Halliday TCSR
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
Message-Id: <20261116-halliday-dts-v2-3-2c92438c6c46@gmail.com>
References: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
In-Reply-To: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=720;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=sz0jgm6yJ2qfmdfMMgsqR7Wg9ExS4UZymLewfvVCvH0=;
 b=FqcgSljUbrxAce/Wb8/tWQg7D8BxyY05VfRoM3lIlKWOtWcZxkvJ+EYJdvTvvxol8FPPRApKu
 mw5+dUw4O8RDXBA5aD2L3Fg9fYj7OF5FtJNOsGNYBuFx4Z8h2/2ns31
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the TCSR block on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index a021e4dea486..e8a681b5e6ad 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,halliday-tcsr
           - qcom,hawi-tcsr
           - qcom,maili-tcsr
           - qcom,msm8976-tcsr

-- 
2.55.0

