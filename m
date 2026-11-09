Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184422;
	b=0IkGOKx2RJRWLJ/6IZY/A2wLBbqmzeLX8gAN6Z6PEAgyUrqpNUl8fK0KTxcjjL43jTSn
	 g9nUWxWACjxYQE5jcghUppJJY6JS1rL7RGnJ/XdtvdnZ0BK2lgZvluONN8MWFWMudCxF6
	 z9hRFmh913r4EJSLPOodsuN47vYzSd4+hTpj8rhRXxEWRRSZuvJEnQayP/aacAPodEMvZ
	 m0ZyXgfNM9Kdvq5eAmtBnB7awJeBxpHCiKsHtKvzCvHdzkJqynLB11dPIZ/l0jV0LZo7v
	 W3w45X+QT+nMdXbXOXQFmrcATX5b84luSFiajCIdzK8vU6jVZsuP9v4dxqh0Jcvg8Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=r6Z+1pNGTBfmPrEnFxF8VVutZ1rF2maRRdQm8+3OOLA=;
	b=t73m6rBhgCUPVEZTe8YDoU3ntuLUeOPGIIuxVHOAJ9LURzNh3awdV0SviGJniit30OOY
	 5fU90+u6SXDztw2qdq5ySn2aW6J6hU4yxSXkSlylE/zNTYA5QD7uAYUFQ+WWFEV4OFo+T
	 CmvS6ZDCYVeMrcA8qMpnSO3qAdHPloPc+lLiBMHIOmANWiRmZ9ZvmAV7oc5dCwbGLVOsE
	 rhGw0kd8OZclfkq4/wJDq7Lkyg0VFDiM79iL83CUS/F+G04m1duhggHxzOpNZLvZsEsDq
	 Tr0y/2jOXt89th4TQO29FY1+hEPd4T9Yaw44ro+UX8OqkF9ODdOybHgg9hhQojJsMQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="uD/fC9fw";
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6321606D810
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6321606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uD/fC9fw
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so3157675e9.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184420; x=1794789220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r6Z+1pNGTBfmPrEnFxF8VVutZ1rF2maRRdQm8+3OOLA=;
        b=uD/fC9fwd35e4pRCBo6Ir49OZrB2lX+E5PGdQnHcUkYxiqu2ZiGRETZ2zJmW8sZlTd
         A5/c2Xw6hipV3YiwOTPc6CN0uAO33PQjgwXUPiZreZzu4FdcrszHSfLcFtjRZOPT3itQ
         xle2xxFDmZmDqyMCWSs93UsfOpeLxSN6ue7xOrrEm/NzYT0xzZK/eCHB+h5f9jiXpkxi
         ypgX50w+AjK0hyhr8W1Y5z3Zeklf121xyaUU04Mnsch0HJVE6Dc9AjOAXq0dywq2opUJ
         SUXNk4QGfcfXnyUDSGqSEEHPKlnphwjmf7JR4/7BbHKuz3djlAWOEVbyJKz8FiaAylH2
         4tDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184420; x=1794789220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r6Z+1pNGTBfmPrEnFxF8VVutZ1rF2maRRdQm8+3OOLA=;
        b=L4sXEWEz5CefjmFDc1vyI3hYxkta3N4mEVqxN3nQln+H3jQ/+T3UjuY4IzlSOdAlvB
         19uXs4I7bvCUXicCzEP+jJ7rGRUs4GrEWSEa3pfrQdjdI1sp87/Rh5gCY6dv2b4ds3yT
         60ThpsUDmTofHfLghjxIcsc8UapBuFHyAEYhduxeWXKOYMEBXhxEEkSW9NBpO+haOEbA
         jWUzhaNxbzkZCAaP+l+xNfby04g/gk/GKTBTalMNg2jwIfTJzARGnvegasX+x9j6xRMt
         m/5G+PPD726A8rti/qQFYtporIsxX9vi2YV+cZtBYLwZpgA4CQpXO0IpeHk32aueoeDx
         jVnA==
X-Forwarded-Encrypted: i=1; AL+hErHGyyWOhJP/tP2aI/BfeneldtfD0sqouko2dsk6mxvvnYmQ5Z9lFMRQKGe6rfIRUJddnTe86CAYSA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8mA0thJazdbF2t/3Z+tFCs1rgUSLvE6HLmkOiyelg0hQ4xMkYi
	L3DFvjmdMyFOifMLDtpz5jLDFfHlLrBZnAadVOYrTgNyZIg6q7arWyAi
X-Gm-Gg: AYBFou3B3eZYxe8OL5vbn5yKb5i366LaNMAFz6PyQ5iF9xNDMdv2zAFyoQnBn0P73yl
	NNchpJXNXVwwfZPg28tSuuWFutmWxA/eWEM8pyO5ayXni06Pew/iMsagy1rmA5a8iRKAWxsOfwG
	AlHjK5aMLmgCkEVMx9kupidskoJj8YbK40+6+HUEsqusYYM4S7LNyot5XsA6smXVBuJ84k5NDZZ
	msz/LFBMfxln1rI5hyPkM/kP+smDTgxm5ZiYDyogX1PQ6AgVpWCxRjNyyahEjF4Ycj8wo96l2vA
	iXqv962jBRz2J0ibTFaLKG4tW58suUmeUdXVPhmugIxTherLXsr9VKLbMYTEDoxjNEaE0pNYVZh
	b+lXopiF5tdYkUgE0u9Kud7gPmxLA2mtLQ1AfC68ugW/ztjMwcB5lrvGwEW0LnZ8pvTPct6juJL
	uYB+MvTsytTz03riMa3K1ZzX/kTfxtcYcAk1b0csrBIgfkWBglX0ORFXsu7m4+3UBYiv9khiPaH
	bB6LEf8wZ/gh0IGVulj0P4KT2Yqnjj8BGZx2yxgpCaSlW0XduOMVawesKO6LKMRDGbU7qzpnz+Y
	TR+E6gYZtOAOH9FSuUcccUqWxrHP30hQoBSpKfoaJNSdmhHV1hoEmSwAIk2Ftg==
X-Received: by 2002:a05:600c:5253:b0:4a2:a3b:7aa8 with SMTP id 5b1f17b1804b1-4b94d762eb6mr47593435e9.3.1794184420329;
        Sun, 08 Nov 2026 16:33:40 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:38 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:15 +0000
Subject: [PATCH 03/17] dt-bindings: interrupt-controller: qcom,pdc:
 Document Halliday PDC
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
Message-Id: <20261109-halliday-dts-v1-3-289114ab8197@gmail.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
In-Reply-To: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
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
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=840;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=4hUtXzlXhIrBYYJFfDKQPQ3vEIzggE85cdjdS9WjQ78=;
 b=/Hr74fQlfTdpftwl6fj+vsUmb0ZD+laYeVxlhFK0akfSM/Zr+bIuUmQJNpniQW71Vw0S+OnBe
 X7HjWxQRJOhA4SO/MxeQgQ2JNwAjEDgqTYH/3IGyH4DzNXVVHXtyQib
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Power Domain Controller on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index 8401d3b48e0f..cf20041e86c8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -28,6 +28,7 @@ properties:
       - enum:
           - qcom,eliza-pdc
           - qcom,glymur-pdc
+          - qcom,halliday-pdc
           - qcom,hawi-pdc
           - qcom,kaanapali-pdc
           - qcom,kuno-pdc

-- 
2.55.0

