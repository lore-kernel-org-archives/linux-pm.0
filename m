Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184454;
	b=XYbIWnpwsBWOxZyA7a8p23hVGDp5nhuTnYTvfHhrVLKEy+ef8+VW2c0VBxuiypbmg4Ez
	 jEWsLRp4879VxtoJybjGFIbQjbeRtxv7eO80WHwwY+M7gXbjqiUYuxzsNG9qGSlPsAo6p
	 4wbIREXaIGl6TLPwhomVU3aJt0I/I9hLdNGUBX+D79+cIXVi4FyJ52OH7oqfeAPTLXMH0
	 bSdCJunhK2a6YTVA6+a2GA/tjEt49u/LdYCuTnQgANI0qVjAHNONSH3rk9vx4FgFrjkTK
	 Yes3ABvgSrO45fxSObw2iUNOv2AedDr4TtXpB5xjVoYx/An5AT9jMQ7mWbEcJDaVZAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
	b=tvn2l7OIzqBIDEEcFlqWZBdUpcVR6zNhNnc/QgMh1nq6RKMKri3rKkb4g1U758TqD4XL
	 s14hoiTccCudFo45y6BoCINikLyTln4jISOQ+0i1haGKGySkstq3IthHPi8VhvUH4L670
	 4nHgAihFammVENbSdmkfZCCpsWQ9N390rLoHu7Az/3vseedMdgVTWxS8soVWHuIU/D8c8
	 RiFjnB4dNTGH5FnAYeE7J+f7DlqaVsWo1chCP/E0an65lL+f7XC2odM3sBhZz8T8ROJ7Q
	 WDqrdiAauPOHEdd3HQ85KDhqF5Y74oNVe+kSqybEPzhrJWTuna9b+/8sKuikgKZfB/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=umF6j5At;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E126082BDA
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50E126082BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=umF6j5At
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491971ac844so310107f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184453; x=1794789253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
        b=umF6j5AttmWrzMlF/KQZyI0KXH1YwvPaczptCwrQT345yLijjcx6iSsqOlX5KCD1Mk
         81IVQcYSQByved1oLZtfvz31EEtFJl8JdhoQ65nRSPU0kQDnBOItbKbX1fUEejMPZy6p
         METpa5VGRkb7v9AxKCwn06Ti2a+76f2PAO1fYp6OK7f3YoHRXXgMtR6eIOyl0wZr1XR+
         Q+Q0b8evofiGdpmVDTQLjHcuU3ANrLntmTVs+p4/Be+4Iw0IjImFcnD8OEhWh+sz8qV3
         VCshHfU3qUyeCBVw7vIdWPRJVTwUI9OA/sBzhqc3Q3wO+TOkhOJYlKm5WwJwlbBly7NM
         zXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184453; x=1794789253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
        b=E/6FuANtGMu8H4x8a1kkO9eNOMnssUgCxMFYyOvTnIiUtnSMtmMbQm0dSFukOlY3Rf
         /cPd+Puj/kOJNnb5UvppxSYpvJY5mQrp1dSYGVLgkKd9iuBJlsOsF1s97zifK3lzO1t8
         DsS8z3pE+PluswmeNlD7lLiTMJx/NKK0CpWiPD2Y8ppHUhTb6FpguCt/CSVGQ1Zyw/TL
         eQsIim3JQajeCamQ+squkKmv52RLPR4DgRK6Eu99PAsketmma/+auXyXJwxFX1NFqJxM
         sOETe+lLilCG0h52zbLQEizeAUq0Zs5Ze0FWfk0ZcMQkktXxMbjGxzt4tIhf+gFJavDu
         +g1g==
X-Forwarded-Encrypted: i=1; AL+hErE2wakq4h1n+fsUhmQn/8PkdhKnzgEQPNXAeUeX5yG5t0+uwLx0qBIMLrjpsU4aYUE28aB8Gbpd0A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/R5sK+8+/P4Ks+obe9Bg4IRMBT91f6CJkwiyXi3ztktJFbwoHo
	SNoLlPn5SYkZtygbwvnVrfXgNIgFai+ju5U1zk9Rm49+WA8BCUCxzkoO
X-Gm-Gg: AYBFou0n3dJeVnfS5T0nBsSqLqOs9S7D0x+PCZSi7/rmIR4FcOmI1C8ANudmBk2pOMF
	fVkIlUHv7/mBymdfMkCVhKZ981tNoQUty+6m/4QrmsHiPK6p7xhnxxkjUrQGiwCkP9IcAZWKrJD
	7LasBA193EhVrNmMqZAQnk5OGGLlw3IqdJ2dkLXHrdTv2pw1gFUU4jipCcIOrdyVt7dRlaNQioG
	ctLjnT8Q+J6pE0fff5aZC7pURCfmmmjL5hPSkh6PsjxRMlW2ovdvGvIPKMGhiIFaHqC7+q15w+G
	WhdE1+W9AsTGKHKhf824NZ+BVl6ScN3eO2EwWiO5w2PQvaRiTghKSamBcjw4jddyeYeV7hyXlhd
	u1LNFLWMEWkO9FXgWgDSvywagnxNa5+JiKKg7Fq3ywhF7Aq3iEldR0EHImI4K6z1y0N+r9pXM2V
	Os3e7qQEAInE2damo9CCS4PtoVkqHwQBqI8FGXGh5A4RnVTeK5D1B0RqNlB1QXNCCwr7MQBrb7S
	CnGGyYQ+TgQFsuUqc+Rhc3p0GvcwfboJzWENGe0+TVPxy0AzkRDmKQ2pB+1tmxtDDgLpgnlHNX/
	QxKbH19fJ02Gy2jxM+h6vu5rIeHi9x6ASfVZh8P1
X-Received: by 2002:a05:6000:40db:b0:48e:3d2:44b1 with SMTP id ffacd0b85a97d-49585ca3e5dmr5109174f8f.52.1794184452788;
        Sun, 08 Nov 2026 16:34:12 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:11 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:21 +0000
Subject: [PATCH 09/17] dt-bindings: ufs: qcom,sc7180-ufshc: Add Halliday
 UFS
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
Message-Id: <20261109-halliday-dts-v1-9-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1028;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=e5+pG0dDXEqC2bp77Ez+oDydvwUzWtL2BPwcLeGQJvE=;
 b=iWkySt37dA02PFmmfguFJEKrCwxdhGzWk24XOJRJESzAH3T4aPp1n4WJJawTbnHxhzVp2Ej2x
 6zP4CwoB/ABAxTrRpUZjqAEi2nTiW6DG09fAo8ednu84TwNnmQyJB1n
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the UFS host controller on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml b/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml
index 3c407426d697..5d1784baddd7 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml
@@ -15,6 +15,7 @@ select:
     compatible:
       contains:
         enum:
+          - qcom,halliday-ufshc
           - qcom,milos-ufshc
           - qcom,msm8998-ufshc
           - qcom,qcs8300-ufshc
@@ -40,6 +41,7 @@ properties:
           - const: qcom,ufshc
       - items:
           - enum:
+              - qcom,halliday-ufshc
               - qcom,milos-ufshc
               - qcom,msm8998-ufshc
               - qcom,qcs8300-ufshc

-- 
2.55.0

