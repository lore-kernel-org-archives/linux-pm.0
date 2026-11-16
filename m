Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864401;
	b=OdM4j+sdCPU9hSAWOINfVCPNZ+/L6kNVCIIE1ICgQl5U9Ff4DD4+AmjZmTOPDHyVUuSa
	 ru2hf+kWAuaw4b32tbS0JjLRjomAFzR5neGsE9XNk0kmoOtkhXrpWK2zqTiXM9QEYwaXN
	 vp20n3j6IBGxhcBhAdct6E3ocFqIu5GJDufZS9fzD8YgpR/cyXqXRIsrNcxEhh5dZBYq8
	 MsGb/0qJFVW7sQI24RZXUQXShy/GIi9FHIQRhJdTcrV9OKSiBtPTZN25KKQiz/+8BMcCZ
	 v6gZHIZiawGf8Prk43ZKodXjGQzDEwsI4qhxNViM4c6kbfOFq/khWhpcgGLlHkCRiTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864401;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
	b=udyxVwBOWM0Y9m5la2zc46QdU/aoWzyVLCe4yhwUmXPbiF23ThfQuwKldS7UgFqswfZB
	 eC8eplu5Yvn2lDHAoq1SY3KZ+8bcWWH2TPHxuINCjg+ZJe/qevA5QUsHJbTl3P2irgn12
	 q2BdDdp5rkTvcFGs1Xtn0kFZBQx0d9Kq0VI0JnS6s7BOezFqiANiImfqyoJXxEtQ66rCf
	 ib+ivlptzR+o0sv0N/WfnihOxdHXzxGARnB7IuDVLdupg6yEnJbGk+S1haYX9QmywLuf3
	 srrVaJVsUUDAqw5H0xb98P4ljm5lpH06khr2TCNLD+9BBIVe7dFL0pXLxkFy6ZBVmzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y3jIIAKb;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA031606A33A
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA031606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y3jIIAKb
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso27226405e9.3
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864399; x=1795469199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
        b=y3jIIAKbbbSqQMJBSkJHyd7OrigIp9VoXLj5TrsVjC1P5SJK1+6GfH/CwfjSUDChdp
         aSUwKzVMSzcpqSu+dYj881QSy5uTr/mR1OuilOAa2PvT9ykPWZFupXWFXDJUWg+Evv7+
         YMfIN375w4C+9j10ZwuEeWRYPJesN+qvcukrs197w5O55lUuxshj1qTYZTKsY4pTkB8q
         AmWVhst/9ZLMgOWXi9rzj5DYH6Nkhc6djSlUphB9PtYcVDNyHJItRCJ/2xhCROn2FZJc
         u07Cqgc9tSSpuyxqc+gXNYk6FMS5PVUI7wsv9LBks2s6FQbonvj25Ul9GhnE9u2M+hED
         rhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864399; x=1795469199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=drwleRdoQE3pkKiq8NvL3TA0ZreOLUUT7TR68lPFDhc=;
        b=v1iIsG7GJh2WRsoxc350rePtpX0Q5yjy8fiNQgtHf4F7fFjciqJW2XkKDHlQWB18a2
         q9RQNIeSqP1bIgpTJ0pDV3yG5nmEXOuy9e1X57esLFCj9vXeAgpr6OwpvbUV0EojBzfv
         HXQAa/4cPrZ3UYrJ0bpOp8BvUQ8VgHNktXJi/XG6sZ+7PUzP5NaqYZ0Mz3f0Id0dZuK3
         7AUV4GxplcQG+L3VUY6yI/FAgyqG02+fdLZcNq8jIfU9GfgGTFXg8NUh2aW+rp8IQw+O
         UKSK2iBWFLVM9SAkphaLsbCbstcYfRMHZLT/ycIRGuhVEv9i3oYOCZ/pcSfmvTxlrbGI
         TaNQ==
X-Forwarded-Encrypted: i=1; AL+hErFryHmPAUTaPxz/sEpo/XDiA1Tk0ubYW9xFPDIixNa3qk5dFwxIFm5xCQOlbte3OdzBeJm1oPC8bA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+XDRlKCjc1lwDYyq/CD4GcRUYEY9AnW/saF+1sNYwNZawu3pE3
	Vr0L1aXbjQXNrBMvj8ExJhoMKviVij3xn2VO0fbQbMz2F1i+yMoV2RwV
X-Gm-Gg: AYBFou3FpLeZtsWpLNNCK0ZfFh0aw+ioCrch0xa2tZz5tGZMOnrFUb/s/fmGyiZjU9/
	lHJWojLVBzYG6BND2H7wG/9Zq20Ltw+kddfym+trI4GhesTsXpc+dkt5F0DyxgAQqbRDz97LVkt
	DqhQ3g9xKhqWrfUbWfD7xsx8L5legDAS3rd+e7yGY8mSmmPEcnFxlAGd8GKwtAQATTVn6cv2oao
	LJC79ZA8g2JrFWCFSaUJX4gqptltAHFxZKpPMSavB2hg7mJwQM1y1l4F5Iaa/KsJdtHnIimyCzP
	Z/vD1vUg7H7TbdbB5KHMC+5GX3l7rmNR9tafpH/O/XQA/EV30HVkYhYK+sLiFDVMpvd+i/hRZBv
	AvLehAh7YTwdjxygaLJt+6m5xdnkwN7w/N/IAPv2pavdpgGZR5clPBdTOruG9/loYMWXaSe6RT1
	diCCZlGWAmJ9h9uvY5nrX0U6i4nDVFcQY0QlZ+PCrzhgqkOcp1xlAAVyvah6jK8HFQtxsuKroA/
	IaFNc4HicAwO+tx077qKFWuFr7n0Gp31BDgBKkB5dSb49fJ3/HL8OuH28lPBvU2rgq/5LhU54lK
	0mlI4tp4vHUXSP5MWIgrRRLYswqKO6loKxTVbnoj
X-Received: by 2002:a05:600c:3509:b0:4b4:262b:88a2 with SMTP id 5b1f17b1804b1-4bb559f3633mr229913355e9.1.1794864399079;
        Mon, 16 Nov 2026 13:26:39 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:26:38 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:17 +0000
Subject: [PATCH v2 01/16] dt-bindings: interrupt-controller: qcom,pdc:
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
Message-Id: <20261116-halliday-dts-v2-1-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=910;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=TIEe9N/cyAzKgpuoZBtDZhrBfZnBIMsVZBId/jMf7sU=;
 b=dpF7p0w+OJpIxiGvX34+YlsXwN/di/jZgfYFaXfY2LGvx7anrS9naa9DX6XaW0R3KAm0CLz0p
 0yoxibSkrgQC5/lkQjgDmvTXyvnDrKaMbIZimtpZ/81OcVIj7o3EQjp
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Power Domain Controller on the Qualcomm Halliday SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

