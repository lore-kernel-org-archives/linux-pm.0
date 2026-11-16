Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864447;
	b=JQCcx20nNyjFGTxCVHSP4T6h9LO8vzKNGkiPCwK5JkmiKGgPPbPQ43CAuqG8PkfDFFDs
	 +dQ41eNqjU78ffD8MWfCHctjUNZTR6+/g+QeOm8E7U+thniktn3o5irpS/3d4GlvqeV6H
	 C1HzEMCTT5SnQbyocohmQveo5pRHwjC0uwoHWXh3TqX294TC7Q8rWhKm2W7OT+oV158Gu
	 icRzvgHL6CI7ZDiZdvaD3sUx5uilQXDMpU3wUMxJmNV9vPb3Pq0kN1oK4706PYmIhxsvW
	 haTmQNS6qmxQQPR9cynJIQr2gYvAdJQXs4dEdPxXRCnHTiuyC9vTZqqhTrZoW74SIAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864447;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
	b=Z24sajI5WacBhKHgEmSncm9uIetsY/9v7ZfhFHTNvfdg8GHDtMLeTw+2Fc9rkq51nmKt
	 V8MnKuz6FogqpiC0txNGjyEBs+sSIelhD4LVUMKlglO57NddkExb0Ge1kjdXGpWea7W11
	 mYxjXAfIQs2WfDalBNPihBoDx0QY/FO/7P1ZZ0+o1G7vUqha4qaQ38I+eMRgoDM9tkIqd
	 LJKbPHVgOur14l3tm/fbTOm9RVOHq7YRqdZPQ6wCa5ONloBQW/rO6Of4mH9JZZdWLCvOo
	 IZglUW8OuTpLft2bRGGv/KyGt6swGwrSVH6Zz6jNljP7hZJ/+kBSy4mTa1dkAD136NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iWmpHX9v;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6BB606A329
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E6BB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iWmpHX9v
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so43365055e9.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864445; x=1795469245; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
        b=iWmpHX9vy8zy4+SpuLwYiHLB3ln3/7sZipWq17iQxZemFskLqrf+5u0LQFERvFgOg0
         YGm75sawrb5dvvPHQL1E3tnBDx/3Lj9iGKAvXpNm6bZ7XZPo570BE2i9caMiY5IKS48b
         yiBmD1KuJl1DrDWRRsqVTXAG16CMeW5eB5GXQT6VgA4c1+z5l6oZ5HSKUqabtHjZShkT
         48NHibHjglieodvDk4cQu2TecbGkn+qDMwsDpIC4OxFmZTkuOj8+6GxuMUQCtCSsIVCD
         HuGkdrxWUd2eVnv/PV05xdTNl8Q6L1L49LNERTuDgEIO5Ltu94W6gpd+G19oZ0m2OntX
         /SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864445; x=1795469245;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
        b=pjxIELJZUr0sDa8PYoYQcooXQmuvubnrTnzoUNuxqqxprbG78en8oyJi7mSk5xJyws
         M0fcuIz3oFphvuK1xmm8O/tBcmMXSKhMfBncRIYAh5v4z1ri5tzhKdECCAIIxQdf0zq4
         bT65NWK8yNEkvHx/FFb0KBwL038CdxCTs0kXEzRfUrHvLve8s9ZBnA9twI44N6CeDuoO
         UIbpJov9OnLcv7L96h7pZVmhk3EucI48aDEAxUniF58SMUQNh24eAvX6Wni87TNT8bu3
         ASY8+iuSZcLVahAahmjs6BaUdi6dff9i2BrqYAQyPfEvk9pjyHVfzyM997QFIp8s7FIV
         c1dA==
X-Forwarded-Encrypted: i=1; AL+hErEo7rQi2oklRpIccaL75a4pgZp0X5IHDqs0r3ppSZhkbuRKjHta3BiEirmE0vygqe/+J7w+2isTrw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+yyqsm/8FHeYiOZLG3mhIezYh6ALufRTObDBdNQ6RbcpuVvGZB
	EHFXxVo2jA/NdGcuDQKTZ3gXOgKobeLxwQYjllem3fb4qbJVxrh0e8wn
X-Gm-Gg: AYBFou1G8jDoatqXq/8z6IRgU4dZqUnE2r20dliJ6jgtznkh9XKFSZAgsJgtOkhDriQ
	f1/+BOdy/4e2SfBFY73vkcQC/q+xBYs10QnKMZY4+6LrnisLl53dtv+txllme04jFin0PG+8IaT
	8+Y3FnxB+2EEHv+pf7o7A3wk4zpBd3j+zRJKG5/5PLnMBVbRNeNujxMKeL072XOnSyjE6AseuYJ
	yPN6oetNtsz5DQowQdJelr5VDaDi65A/71QAlt68HDsVr+fym1bccttfUYQJU9x+YI1lWAX1G8M
	pkbj8QYPrPe1iCTqtHKc/GYSnMm1I0fDFGHebH1b8tp3RdTYZPF/II5rw9sJ3Xn3rYjmDlua61O
	f5eeoT3YQQEaPNzG5Vcju6S3SIxXOxuAQPryWlNafA1F1i8ngk5R8H8WiVPODuLBVn0vSTyx2T0
	73v+uDPviEXtClsPupbII6kJ4AebGQgCbMXtdoD/f8sm4NCpEHO3ulU2FmCQTBdaCQT8QZEqEQP
	AwWthy0kLZyssQ+3PD5h5R5PhtSsNQio1XNFAiCBV/pZmfVSPSQiOs0+x+Lge3RNl+g71NPUjWo
	fRjoOyKogD8SARukh4nH1MQzXfDDpFG95pGZfrSv
X-Received: by 2002:a05:600c:6548:b0:4b0:c1ae:829 with SMTP id 5b1f17b1804b1-4bb55a8d621mr184234605e9.30.1794864444941;
        Mon, 16 Nov 2026 13:27:24 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:24 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:24 +0000
Subject: [PATCH v2 08/16] dt-bindings: ufs: qcom,sc7180-ufshc: Add Halliday
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
Message-Id: <20261116-halliday-dts-v2-8-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=1028;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=e5+pG0dDXEqC2bp77Ez+oDydvwUzWtL2BPwcLeGQJvE=;
 b=gD8xOm5xZ9FtfmXv7b9AItlwRATNEZobnHQBfav0fJLpw18USQbXaJrBNVYJ8htSmcNjmMoiY
 oIwuZK62UjeA39gKapnqrq7NNerfrM+Hz5ecpQBWUPf7UaNqv3Q7sGR
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

