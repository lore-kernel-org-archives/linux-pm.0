Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864421;
	b=JKVRrTeG8gx5C9llo4M6mfs0JRl8Ab0aq58duT+y9/uDi0GcMxQKQ+pTtTsX44Kf9PZM
	 0KnpuB8C2MPrYHFvO4aXRCQ5ilwGGGaq27ecK374p6+e4ICIHCGLcB9ilyrif6YB6Tjom
	 iCeRlRuNutNdwIiX9TzyC3Z4pdCrNAVVEI4Z8j1vd8w0YGYROo0iA6soWjAUif7tSDd1o
	 RJH+frFeDIn4UzwoiHo8mYvyvrK/aHJM91L68b5QXKmQrF5JTDZM/qzECRJ6jNMgWDEZR
	 zlqKtMomo2HthPhXaexMC6LE8I5TaphOvh5/lfDfNDJ8WtAgdlzPY8oa4I9q0Jnqyng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
	b=xkOe51Q8KLkRViTRw8GrYs0isx4zE7XJQikOK5UTqknckD61fWNBiJlkGuN3fwZgKTm+
	 dk2OkqBmPZ306I5PacLxOhwJ8xKjiMihZF+JZHfALuvo8ZMjvuGcAhVnpvw4J1djoaJUY
	 DUA72adEwLlWcO040qSHMPvb32BgMvRH4og5DaQDKQalN1vGy6duR/TGdWOO6nXbFoKlt
	 U3EP1Qha2FgYrm2RK17XnABztx7TpW1pdYSFzzBlgnyXxJ4RmQnRFWrTOHUFvo9sFi95K
	 sicf0w9M9t+5GERAUnAV20h3ykxus6SX85HRiPTO8GrT7/ZWbGLnNoWGUdsBaDQJ7kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLkgL2gk;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4E606A31C
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB4E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lLkgL2gk
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso45094725e9.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864419; x=1795469219; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
        b=lLkgL2gk0QHyzdlrISl0quTs24SlvKBMOFoH1j1nhSiSS7JrK+rmqPoGnROwp4PajW
         VeDHrF2l/KpppBUbfWOTOW5Jyih8ZdeaJORgZp7fZ1X4LC0f3uKoaabUuJ9TyYvtFXQZ
         DeC8HfyWDeKEMkb86Mvb4GrBoZFekGhg+QFoxcILtp4GPkjIrUJTxwXwmYy7wQi5P2qm
         QXYM7HxQNkhbi4kAyQPpLc1ypzpHNgh6uTB3bmXhVTpqihvt2TqYQ6MlbLWHh4OGTL0I
         SUPSh3Lvd0vX4kNZX6t31437DW1cmDuLnDDpn7okWV7cTDtFCrWfSYavOzRWSnj8Y7zD
         H3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864419; x=1795469219;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnAQsJm0J9tjLLptwYNMgJxavVvbhamVp2XrX/3IRso=;
        b=IpcB1xLHj94TFDhqIsB1WnxwVhayznXALCmc3nYpdIkKRgB/n2KbPHn7KiC8hnDaDY
         Y9mb8JiHcQ4aeuUlq+FdUgYPl6POt7vejnv/3j29TO6HJiC8hs7Gx7OQwmE772BW1iBy
         F+37RufsTQTjfTdVuAX+hdmz0pKb5N2aNN5AbH3e6dmGPitU8nASfcbkeVhQ2srw57WG
         RvhdvLHLjFmZtIFtADtJwJy6iseMR1mOOCNpQgGbeesTcVgy01ZBUslRDQNEn5L+bmjK
         +vYMcaFeqbpuyZUDD/BDbmURQmdJLdUs9XyqMkbwgMZD2FplcEz+QqhZuymRjpxVEJ9g
         nhOg==
X-Forwarded-Encrypted: i=1; AL+hErFN88tGPVHJUSi24tZv077cKtTwNBzP81JntEv7zLnviA3kJcjQO5zgnSDwaBr4Ypm/2nRS356Gfg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/eyKUv9mMWb/p/K72a0U24B5m1C1V/9uAe8Pxd4SuaQSjbfr/Z
	1V1xefhNJ3H7bCnRrdrDdNM5ZGplfMiRROzXFFc1/ZmvdPoE9KBg9kda
X-Gm-Gg: AYBFou0BVZdf4z/crNRo7VKfC4GpkJsjJGSuDbIfE4nIt3LfMXM98RBhzfGuuOqf+9U
	V3nNR5Vh9sn2nkfnrkz+Db7uZu5ObWaEYKBuxUog6bzzNuqElebeS6oia3ddbjDnQV8kCQAr8ui
	RVRN+m6u6T+E94DRmS96bOhnPbRmZgu/NGolKtSQG18qowZLG3Jj9SOD3Pm6oeVVXzA0vHqjTiZ
	2tLbSpYs66wYSABhIQhuR9kVH0m+2WtA8JKZWRpNeaowMFhYLaBkspiNAx85WCFAoNgjeSKmxY5
	sf6I0ZWH06IrJQJmcUHKJcm8O/dyPZ8fOIhQIcdsvb7advVKvxFACNX+shro0EB1hY/BESVRIC2
	m4KxDcdjxPdqkm5zr9xN3bPd6vv2W1PLprR46aPu7MoBELvYL3bFTNc+ycPjMHvRGXLxDUNhuPO
	Ub+ywJv2GWgHit2KfwUc9PppMxS8q1/2PgFGDOvggxpuOmwp3mdmRe4AqER+fYf1I63tpoDqpoT
	ii7OwSJZNVLomtqZwRxM/h2XHV3P+nWCIMSqKMMO3slXeaUoDeScHQB6YAnVYBVbTIExmSgzM52
	3OTsXcly/R+YAWK8LmALXPrrOaCN3Y14uNkTIfkR
X-Received: by 2002:a05:600c:482:b0:4a5:75d2:c104 with SMTP id 5b1f17b1804b1-4bb55a59c9dmr184592375e9.22.1794864419406;
        Mon, 16 Nov 2026 13:26:59 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:26:57 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:20 +0000
Subject: [PATCH v2 04/16] dt-bindings: arm-smmu: Add Halliday SMMU
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
Message-Id: <20261116-halliday-dts-v2-4-2c92438c6c46@gmail.com>
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
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=1185;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=48k8tRM2Ds8B2KdX/k6MNHyKgJdAqOSEc8lLmnEqak0=;
 b=jdhSJvOgnkWCr3N/XewHYvU/DMh7fs9E9l4PMB3CyD3bi1r+fHKz+jcOeuCkYmmgxW1wl/a9T
 LhE9PjP/kP5CRKJpxWsTiZqjVGzsx7uCz1lP4rAnXmBZayBQqDt+vzF
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the SMMU-500 on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 6748351c7812..925afa8cca8d 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -37,6 +37,7 @@ properties:
           - enum:
               - qcom,eliza-smmu-500
               - qcom,glymur-smmu-500
+              - qcom,halliday-smmu-500
               - qcom,hawi-smmu-500
               - qcom,ipq9650-smmu-500
               - qcom,kaanapali-smmu-500
@@ -629,6 +630,7 @@ allOf:
             - enum:
                 - qcom,eliza-smmu-500
                 - qcom,glymur-smmu-500
+                - qcom,halliday-smmu-500
                 - qcom,hawi-smmu-500
                 - qcom,ipq9650-smmu-500
                 - qcom,kaanapali-smmu-500

-- 
2.55.0

