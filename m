Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578248;
	b=O6wbBxejNCkojHabe+LQ4+45Mje2ghMQLZfFWZiNAW4gCUHpFon/ClveRDvzjXWx0z0q
	 dAP1ILRhc32tYHvuAMaB8v+wfIdZnE6IQ3Mt9mN7GN0BtiOZNJ0OcNy6IHHrQxSwoI0Xe
	 6+AjQ11wc3TMOkDa1f0HrW3OXL5snuLgZMZckGZGGoLa8CnTQLccyFjS38J0S3WXA0eDY
	 k9Qg2W9MX4ZjonZlrTd/22WrnHnNdiL6iDSagcyYim+OQp0xe/mSSgQxO+qOLdlSZ2xh6
	 Xe8HrQu/uL8wd1CZ4wqYrzVDzM6SFL+16lvm6x7a/gYPFW/LWofxQUu04dr0ZdkoC8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=4KIqWeS+3qt6MqJuGRe1uG41SLx0XRfx3eXbs/xUTl8=;
	b=b/wb/NVoXMzbEh2+7u16dLhzARHgmqVOEbns9MIeJ+v3SjCKywA1Wrwhd0KoCx5pKdFz
	 NHahegXfI2O3vksJuFw+kZd5W+nGCCrCJhCn6mSDdN0zbPpx3GdOd6goncEOytNY0N51b
	 PoXvhJtBmf86U1jq6lbxqM53DcdDu8Re2nJsNoRcfzHIk7/KGSuj3/Fl9EH5JJbTHt13f
	 u/ZGRjk6iArP3QCVubyP+kr/Pps3h/eSJBVv8yoR4Tpl6Swb0TBrKIb4tSNjsP1ZFK/rA
	 LPFgRT37QBGn24shSXMbw+8qen3q6Ivk4FRBnVDYC2xox9U4rcjU60OwVbAvqYj7mXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYJnCPDC;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD95F606A33B
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD95F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yYJnCPDC
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so24202285e9.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:44:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578246; x=1796183046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4KIqWeS+3qt6MqJuGRe1uG41SLx0XRfx3eXbs/xUTl8=;
        b=yYJnCPDCwX2z7GW0KEzZrs4pq2lhpcKSCvfZ7Jxb5FFkSXbRD/DKL3imKFKjuozlx0
         PjoGDpUiZBJMXXrwVVv65xOZtRHEQr7Mp03mrKt/vzdLw8MJ+WFu49aJ+T/d37cNt9+0
         iyyRKW9IcXrsAWM7+n7HO24S6uBagb+7QbJE1odzSFgeGL6gzPo32tZiTXSkOPZdF8SQ
         lZXlXY9dCMKGWuXQqoNmMXGhc5CIK0sJZ4AfyM/TJgjzKVwfBbHcTRqrhathFIflxn4I
         m8Ek+pAdgoCuX2AZC4asCQrNaa4et/XMHCzHRzgNV/fFDwwF//9V/YDf75TCkIiiiCiD
         PQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578246; x=1796183046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KIqWeS+3qt6MqJuGRe1uG41SLx0XRfx3eXbs/xUTl8=;
        b=rjDi8C21i0uL+8UJP4hSfol7xxYnhSI46LQhJR67PmbHYfGy6D2VuA1I2zfiW/Ychu
         XhiFXIsTiq6gU4aM1VHyaqqZfZOIfMtgrj9ttluN54pzSIjVv349x/Up+M6bUjGUn/d7
         YzYhmrhSGv7xBYI0qcUsl1AtLH049g6OWBroGsM0iduPdg0iF1i7CAFmUgr6pG8iCInD
         yQTZTRBRDLGNdIFB533X89l3ePHQMAQm1UKmUwqNQPbBd7IfniGzLAW4lCQ/5eh1lEWZ
         JvgZGfFiNBBkE75AuaiP0i+e9JsLzu6GDreLcu//W8vzWdQd/kAgRejzzsApphrfZA0I
         VKiQ==
X-Forwarded-Encrypted: i=1; AL+hErHZIdsXS+l+RovKjszF2m8BF0zXa5ugp5xpvZBXM9pxSRtogSPyWJmEnBMVAzr8kv5eH6dcfl2Tqg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/1+Dg/xKL61I3Qolrn8MEijHW4Emo0J9uvnscaTOY4xzZwcKLL
	yy8LK3cIkcAYcux3BB7++QmF+0t+zyHWezKfJvULbqU1n1TsPGShhVGo
X-Gm-Gg: AZFdTZf7YFtyYMpuwDB8LErBifcBPAHsDDR0j7mNPUtJbTqudy9NddAdQIgsXDfwj6q
	gy2fxlbqMTYb2lbzalTrUawGekq9i8cN4Gc3iPXJqArVciSyPB3lEZk6xLnuKTcY+stCc3FO1gV
	Xr+piB/RevTJ/C8ADhrJLuW0Esiler2MajeeLZoEUjtoc9eEhC3yilVQRj70bw132nYv+2HG4qs
	TUKVg15m59A4NDGToYlHjWLnljojaAzZjElQqu9KPZeDkdv/qBDcxOCGL+CNGlaaUZ54zJZU8IX
	UPmrSDVZhg4lWtjlZ8d5DnnFlZei9Ovzk03NySH5dTi9fpUAIboZ3ze7qFUTX/8Q+qdj/EKjlkb
	GoAvAkuDDD9QvJlC3RvSs9TTBnxyJQdcPhfDsy21uI8uPKuLuatBJGnmLD4c0WG6kWjggj7l5ZU
	YhpaaMl8/qiITVb4daiGt9ppx8ko7GsyEUQ5wvQjVKCHGd4E1QSzXBo5UW/n9r9xxKQaLKTmXGD
	5oxbJtZcYPNsTIihvPfS7fnSI7v+tXNIGHQabboDr0Gkm8gK2RBGqvP2q2w2g1h7h/YFqRTmqq8
	GBUXoVM6bZ4UF4fGAWVV4KcY0LwSFDACbBq+Cg==
X-Received: by 2002:a05:600c:4e0b:b0:49f:e772:6ddf with SMTP id 5b1f17b1804b1-4bb8881ae90mr345180345e9.32.1795578246276;
        Tue, 24 Nov 2026 19:44:06 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:05 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:03 +0000
Subject: [PATCH v3 07/14] dt-bindings: ufs: qcom,sc7180-ufshc: Add Halliday
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
Message-Id: <20261125-halliday-dts-v3-7-5c8311c0b70b@gmail.com>
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
In-Reply-To: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 iommu@lists.linux.dev, linux-usb@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org, 
 linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1101;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=QhWGZ2nDLik/AVSmlPnUVJyIcZFTcrhPWPSMCAukIeM=;
 b=6AJhs5Z6f/n9pNkfdd62Z4MaOrVcciMknCqzjBkVEi354abH/HUGDZk9PowwAyDuxfg/8VsUi
 qlXYQzCUXxLD5rZQ1VTRb8Bh7LUtJE1bI5xcjBVOagvzX82tdchlf+N
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the UFS host controller on the Qualcomm Halliday SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

