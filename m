Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864441;
	b=FjYxphrxhiqlT6B6N+E91gWR5jmj8ZxUOQ8QVvt51pwowsqT+LDVxoyakNj2CwKaKr5u
	 d1cjAQXJziSwtPUI9nHNlN4gJplTpQ+5MBZ7Zd28b43DnAUW2/NRqnX3cmrjEDvEZg8p5
	 3Bja6Swq9p3nEVQyOdlabvnnV57UR0ONCOY/ePHY+1Kr+i2M3xt4x22rGhY91dNjmEqkH
	 guGNRG/mqIBLtUH149hANjch2fULh5AF7/E1m0Srb0FlsVGLKgWY6zCY19FP8FoooV6UO
	 6/OH3lns7+YtkAlUiuKct1UCdVl3t6F3AyKHFy6ple9kN46HEEHGlPmWo7yTJS+1ObA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864441;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=w98VdCA9EtnwfzZZ4SHf5Gk3YVXSBdJ/uT/O1NuBZJI=;
	b=ib8Kn0R0t1bsl+thmT5PplwYnY7W+l+WdGuYUnDzRtq5SsWN8r6Cx9scSaQFFL3L3hPx
	 hDCFMl+l6DLWL2magxtOo+ednzfmQas2Y9KV6+ZHozb0H3FkQpu51ipaQm0RSUQKGpqn8
	 kmKlqFrrp7JmIbkMDYpK+9pN5iEdlyr1aaSXe6t1raprnPl1PypXgca7YZXuzQ69P9+3b
	 1j0HpQvZ4f1MFCIbT34TgaH++//W1topIvFc6gYfOdgRtZv9deup6QUMFKfF9sXQek0Nd
	 WovrC5j1h9x8EAqIJXyRsfYd+1iZ9nhUhY+cq0V/aYXLXzRE5pPSY9GnNBy6fbBBXlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AG9pfL7W;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F06606A333
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:27:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3F06606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AG9pfL7W
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso27635695e9.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864439; x=1795469239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w98VdCA9EtnwfzZZ4SHf5Gk3YVXSBdJ/uT/O1NuBZJI=;
        b=AG9pfL7Wd/r6/98cIDo+nVLfIVZ9Px+zjsXE5kwL5C5mXq0vvRxtAzXqCOjP57c76/
         QDAdB73QojRTusWajXwvXLflOajjTrRtPUzzN2iBmylVD9h5CuWtCva4RFTGQ3WAXdqj
         QUPHfhV8R3R6+D57fWZz5PoRdD7Zh4aEwbeRy6IRy5hp3spzPFQuezFUatlivFZZIhX7
         UvyPXGEihmkcLMT0slqp/7SwQoAyDHmifQcdngvOwon8ytHUPr4DHYsG+dXREzWIOZZf
         o6twMtZmZHhO517aRhzfH+NpS/QusUvv1lm6Ilz7LGycETpzHg6Fbdmdyo/hrzPzp1uj
         QbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864439; x=1795469239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w98VdCA9EtnwfzZZ4SHf5Gk3YVXSBdJ/uT/O1NuBZJI=;
        b=RFYyuJpDe3gZCoLqaB0KXfJcaks6EP1Hm4HU5d6eCjwk0m123RhrguYR3zTMUPWTla
         2ImvvUBkbZlooJatWj2wpwip4AxghPHapUVX0vJL+1rUOZWEvi22dhxOIKH8PLJP/OK5
         5kep/rtQLmswH45J/vng1zEGaZKxvUccMfWQ/n9HiKHiXQFV2Fp2CY1I1zySDj3PSljW
         rLi28gaQtky1+w0Y3DFmWpAGxBWS5GQR2mvRVoICRNctirCumvnnBUZrMXY/zGlf0i8g
         Fw0gukyi1aZgwdPm8F4pcLHVnDemUZL4hO1SIG81fSKr9j0wWaJ8/kUoQifDxqTXxtCM
         cK0A==
X-Forwarded-Encrypted: i=1; AL+hErGanC/PLNyOQ+No6xhkRPRL4sUa3q4kdH2b7xgFNAXynSj4heO+UcwmxnT7I6mKfEGwODkFUpwzwQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z87mWNY8t0irUJge7UJT8c6wWLK/AMA5Jez4lSoWJ0mnoxzQDwr
	Xp5i7DWODKUScAP8It2vfyN7hDPs/aoKe3aqmBUmgU39+HLhwzP5kgcg
X-Gm-Gg: AYBFou3EnJ2wsbmDdNChVtZyjo56HdsO+7b/maAZrCNem7u2asGzH7mUvnd6QFhGKoP
	+hP4i0/44IdMZRTWxd5rcw1/HXtbpd1VdyIcv9LL1W96i6+lLf2XJ3D5pbv23Lnvk6YRNBm4+cm
	kPvcZFQFl2imU+HRVYa5NUEGs0kB8147TfC3oI7b5SKeMxezK/aZbwD5hjdSlTwedMaWfzpyqow
	WO3KG21lJ/IdyEKjz+0+YWW9q2X/IaRIyqh+BklgaWN1jTVnCgisnSR53A0ugSVPMpUfgZlVC1w
	NWA5FGH+6ijOfFOV5+ccFgbXck/4M1hVGf2a/iAd57kvECWUWY84FVb75kOCIT/tOyNL/2Qh1C+
	0Iaq9b8X0f8wF2Z8ycIG/ekf6DJQPZfVuLi3QASGgMarrAzEMVImyglwXIunBgdqtdJuHJAi4RK
	iB0KUbzhfbp2yS1A1+CKo7T0OkFotpcLsMydAmmlfKrabTxqqhYKFP9ccHzdp2p2ViqbXuKDYBu
	461a7Qenm3fmrc+Qg5g9fm41o7rkwu9jV7njrajJSNYc8oaShcIhBbSU5ASbOEBuol7cadkndKy
	XxXVgfblAerdRFJ1KvVFpor1fGg1eE97rrLNmRmQ
X-Received: by 2002:a05:600c:3487:b0:4a2:526b:d410 with SMTP id 5b1f17b1804b1-4bb55a4f1b4mr255653315e9.13.1794864439353;
        Mon, 16 Nov 2026 13:27:19 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:18 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:23 +0000
Subject: [PATCH v2 07/16] dt-bindings: phy: qcom,sc8280xp-qmp-ufs-phy: Add
 Halliday
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
Message-Id: <20261116-halliday-dts-v2-7-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=993;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=Os3dtyGi4Umq8bQ7AEz34h0NK9e+Ws6GY42XJz6qujA=;
 b=JAnPagjMpge0X10XiR/LbxFcl9vIwvXlY8rdMR3b7TnG2zjS5Ef/3pOUFBSYZcopY2HJ+t+/s
 qtEtnXV/IW3BvhWLgk5yEo8YJikc5cpwNQrDqesXNsRHoPh2k6l5Th3
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the QMP UFS PHY on the Qualcomm Halliday SoC, which is
compatible with the SM8450 one.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 10435a0b5230..a42bba9b550d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -28,6 +28,10 @@ properties:
           - enum:
               - qcom,qcs615-qmp-ufs-phy
           - const: qcom,sm6115-qmp-ufs-phy
+      - items:
+          - enum:
+              - qcom,halliday-qmp-ufs-phy
+          - const: qcom,sm8450-qmp-ufs-phy
       - items:
           - enum:
               - qcom,x1e80100-qmp-ufs-phy

-- 
2.55.0

