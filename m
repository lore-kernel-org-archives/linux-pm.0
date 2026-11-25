Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578279;
	b=mK/MJ+Ib2xvjBYSW/pvMHj0IGwAANRac6IEfmVVBPVmPuGustPxUMW7TJ/CF0JSweRao
	 zc2ij4/nErUnLfwkotS2Obmutb454zivz8AroUtQw4yJvYHNEDSmRxJGSl9XCkKWjkbIn
	 1/mEOpUvQKANw+hv3TBI2bw/5c0KrJjja6rNjGCw+Ve/N/E9u61Xfo+UQqGAlakz2FX3g
	 ZTnli5Ir2jF8HWLAKOH5UtgufTJClHd9s3uO6YScj4hCqd2+/eyUarrr/XZZL/Fz6gpyW
	 fmgkKYv14HSThD1oLmO/LfmMJeLGzAoVGWI5FZAHkKavlh1H3mHTjH/8Y44A47slNgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NkSN8UMfoTWKp8XmjqjM5ogwV9ygtNexpeqrEJLEfeA=;
	b=5OXfngHW015M9VwlnFMTaUooUKWdswEPPKi5RG6JTDqLdeJilqGuIJg9AzXX+ymRJn19
	 Zf3Vad2b6X+zDCmFvwdcBnsOBDU5LSIoh4s8y2NH6vzXa0YN9/Ti7pNrU2ZZDjfiqAEtP
	 Pzb723gl71wNETNq1Ft6Y03wkYRfVON0zqtQYar39ReIbwh6XjgIeK3jf/6UdJyv1lSEt
	 9whspqxLS1IROp0m8swz2c+3Di6Wil459l+SrsjkVHR1GJ41czqbvtmEzYc0kB4rF+vPm
	 smsiqHXFPlZN19V6QKOiPHat6a7grYMPqF5PkB9mIoN3Zr02c0RROb/u8Hv3b22A9iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6bOHwnm;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF0606A32E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:44:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68EF0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U6bOHwnm
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso50162575e9.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578277; x=1796183077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NkSN8UMfoTWKp8XmjqjM5ogwV9ygtNexpeqrEJLEfeA=;
        b=U6bOHwnmylm4OE+OQdzOR2JcP9rnvceibNuVdlJsekQnAPHAVsZYjW961luTOjXupN
         t3xUWIXNIaoNJPNo9+7RtxFz0lxiEVNvXwuwAzvaNKt+uExLr9UdfkxcAzl+SZLOSUWG
         KJP3XKfq1w/+aVC1tphSyxoHeoLmZwQS9x0oWPEKUboTecNTFa/HyGSJ9eYoPQSqP5Ph
         SlveDU/SaJDo0dym3fZwa+VzPSK/ZXVcbdLbKqTP/fIu7gALpIhll57g8sERanCoCQuK
         vpMmXz9AJjcrs/xYMpw4fl+uKg/QLTqw4eAMNowVAcZ4RTa8IbYG1Kf4GZleu81dYikJ
         wxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578277; x=1796183077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NkSN8UMfoTWKp8XmjqjM5ogwV9ygtNexpeqrEJLEfeA=;
        b=qlyLioXK0ZYd/mBojd6VVaVmfWs/aczwR6IcKGCI1MQHYc+8M9yWaAUaGgFcPPzu/i
         gtL2uX0aVewRA1xSkFIOdvsZDa+GPQZ552AAEaWLXiYSHDZEbrLfWHEkGLfVOLNF5qDG
         9nEf0+1jAQu4fcXSU+Bkn3gQu7Um0exQ7taecYRmgxoTyyjTJYnAZzK/a3XOnQDXJYce
         A1WOzabRYXW51yWyCcIl0TWuy9DSEy4RHs4+lWGZYK/V951YO20K7JCrIqP6Sm4WUxMt
         5fZQKkdQHGUqDytJ6B2o9p4hHcSuS2DBE06Fz42ZutTlbJL6A1pMYGk5RqC3J2wwFXgQ
         RlhA==
X-Forwarded-Encrypted: i=1; AL+hErHlX17Othz+0F+kyusThesfCFuk98BZQWpouIvJQnGGk47RkX7zozft1ryqg/AhTk4SohgAdO4q2A==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Qpe95OocjvjNzTq5Zr6o2APvoR0RbEhyTjsN5j2xDGxdhFKrQ
	TpTbb1+y+go4Z0HIpZvUML6mh3Rz32Qr2sdRzbhy+Y/4xGJGewESuzkO
X-Gm-Gg: AZFdTZePvM6mFiIuRLafkek5XU8dfvcq7nylQyNZ87ayFr0lu3T7J6UZCUFPWqmu++e
	/6gGA0oAg8g3VLLWqZ/G3Fy7Z7PE8usM6CFdCfXt2ojFpxubaoZ0G34DNwJVCdfDFNtR/rCcmN9
	6IriyUA75KucfEN+yfD+sf73ohEDmzYb6BQTkSmarOMckBURzGX6XrYuPWc9VJMkLW9tPG8S+Qt
	Hx9IhQQAHFilWS/rSY7K+SQaQYfnv3XFMsNf7vrXsAB31W88ewrb8S1FEB1kQ2eGoe83N33VowU
	qj/uRRUyk//9aS7c0U4PGXxFIj6x7rLBqTwHnNdUyPAbg3fmD0QDLmtZ8cwd6tOTiTChwGFXU/5
	ixFnASid4mgAypdMloWPMPr0LWdwVJbYROQx8u6wXk5Q9qqJLMHE1G3baYydpqu/SqqgeTieq7a
	OaQQPrhsEXmKITusJ2UNCDSRvg7GzLawuMCz4sWvfigY7q50oA5putsZT1ojXdmLi+g34gy1ow3
	ndYTb8PWtPpQ4O2CDEjHxOBDqxj/hngQGdIJufkLSH4j4isum9z7lMhY5N0A1CNbkGpdRG5SxQC
	do+r56oO8b0qGqJvj4ZtHB6YfJ4/8GI0yHU+wg==
X-Received: by 2002:a05:600c:a087:b0:4a2:5267:3cd4 with SMTP id 5b1f17b1804b1-4bb887c9fbamr346080945e9.3.1795578276823;
        Tue, 24 Nov 2026 19:44:36 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:36 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:08 +0000
Subject: [PATCH v3 12/14] soc: qcom: socinfo: Add SXR2250P SoC ID
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
Message-Id: <20261125-halliday-dts-v3-12-5c8311c0b70b@gmail.com>
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
 Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1207;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=sbEeAuvm0vdAU7a79gy3cwCbc+niIPSz0ebsMUqvyM8=;
 b=KR7TljwE3x2QteRIhm5O5gc+Ovt804bPNXZE2SHYg9Q0Owpdf51fj2CIb7ZGKKfP0khgNSrGC
 8wxHPG6P0W8DmuSngwRv4oXHEtyjNPML9jsnvTjumi9JPv03PdDisQP
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Add the SoC ID for the Qualcomm SXR2250P (Snapdragon XR2+ Gen 2).

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 drivers/soc/qcom/socinfo.c       | 1 +
 include/linux/soc/qcom/socinfo.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 18105ddcf04d..72d282f17b0e 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -529,6 +529,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SM7635) },
 	{ qcom_board_id(SM6650) },
 	{ qcom_board_id(SM6650P) },
+	{ qcom_board_id(SXR2250P) },
 	{ qcom_board_id(IPQ5321) },
 	{ qcom_board_id(IPQ5424) },
 	{ qcom_board_id(QCM6690) },
diff --git a/include/linux/soc/qcom/socinfo.h b/include/linux/soc/qcom/socinfo.h
index 317dcc26c504..3a3d7c7089d0 100644
--- a/include/linux/soc/qcom/socinfo.h
+++ b/include/linux/soc/qcom/socinfo.h
@@ -170,6 +170,7 @@ enum qcom_socinfo_feature_code {
 #define QCOM_ID_SM7635			636
 #define QCOM_ID_SM6650			640
 #define QCOM_ID_SM6650P			641
+#define QCOM_ID_SXR2250P		649
 #define QCOM_ID_IPQ5321			650
 #define QCOM_ID_IPQ5424			651
 #define QCOM_ID_QCM6690			657

-- 
2.55.0

