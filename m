Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794691849;
	b=WcbbsXoFXJvddbULVHsQGs1MJu7k32VxC5nhjqJ9IVGKMd2YWKxZqV7N6XWK+k+W7utC
	 JMcDLMGN+sgNMP3GAiRMyHhba5SSgxuRhzmuKL+++4Gp0eHdCNPsuWLWdeI4g3OV+1W+k
	 5b005QkTpNf7Ibi2N9tJjWb0n1WrUI5YwcaJmgxddbSdivm7XIGsEBlcZ9BovMu4AwsQn
	 aLBQojIIckmrSXqQO49Wi3GZbwCZdfuxbRvyc4w3lGrvw2Qnm5v0qQyIImlqjhO9trce9
	 HJ0QqFifMfI5rngjUwonMcrW4SF7uYQizdCQ3t9Vy92BZrNW97FoAosI9or1AV6SzRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794691849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vju4Tmf9HxWLCGDozxlRYY/dKPR1MEju5ORsVHds9AY=;
	b=iQu1fEhxI1j4MqlBBeXppM5KD8+H37tAN7K6FCeYDDVsvFW8vqfpFwzbl/i+/7y8KLHI
	 L50QPu+VmSjybKfeEfiEFBu/e/OwgXdqBJxhhar3I7x1KrqFPOzXVLJRUCDJC/seX3VlC
	 5Fr0lKYaPr/lXrXvsdanAxwZraxdypKjZTUZmkLpwW2nPS1Yix7e9bRR9PHOYvd2797cL
	 ymhKYal5UzGByUpIVc6Cvre0ohi8Y0p8iqGUy2SDYtT+7uz29wUALtJEn4wW7nYT6Q/5S
	 +j+xmVuSNFBk4+ThwEMgwx4p9z9T7wLRWpuWbdX5KC8aB+h65iQgMPsh8FFv1LzCnsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWlSLmZa;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBFB606A32D
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 21:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFBFB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lWlSLmZa
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb666304fdso3349105e9.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 13:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794691847; x=1795296647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vju4Tmf9HxWLCGDozxlRYY/dKPR1MEju5ORsVHds9AY=;
        b=lWlSLmZaPq3CwNa2GvJ5HLBZxwrHAyR4KYWcNLYDoejqq+bHE47WezKQusTce17cqB
         UTWjdD/IlmKTsXW86lcI5Re+obIoVIb9t86LrcMAeziz9eDWUmhlf0tEDJWLXl6iumFV
         A0KOTfltxQB7iH/1NZqAz8vQsctKFp7PZfZL10agBOyW0+/+Nlq4fquLxNOefQolK0q1
         7b1VyBrgPTzn3K2O93/7d5x0teNBV9W1gjmQsMpDfJX8yxuUQvPJ+6K/Js0FjGNLg/bj
         pddRJxGyyKNTa55ItmUV+vqh3pU2XKCHu2EjpM7+mnWtIVQHlY7yLwHWBA9Qc69Hd/il
         +DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794691847; x=1795296647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vju4Tmf9HxWLCGDozxlRYY/dKPR1MEju5ORsVHds9AY=;
        b=KjwbDtDzQCRqg9dsfp9/FbWoOQ3iIcIewbUK7nAWKBu/VFQnrropdytVhmSK7lasNc
         odx0+RS5gXAuE4O296v9jOzQRh3wvy08fRZOSJ14l/6/QFmTplrPT/tP+43mHxmYufjH
         fXf7t088DfOf8iXh46r/hVY7pnccQqC0Ufbk7vLQSILuGG+SVF8v5UGoTMHMyUTFzsF8
         KWp5AbVyyMo8fiXialLMs8sumHb8bL7IHYFPPLyC5Sl2LKGvMdHveICK4N2pZ02LlhcR
         mJMKKKHOM/UfQU2OTZimXRDuXUPlLlHQr2tmWjDOPVjD/D3HUL0wQ5e6NwTqdde9oRut
         vbSg==
X-Forwarded-Encrypted: i=1; AL+hErFIKBIvtV7TrPRN1aopHLN0Lcdp+G4sDu9TMbVFnHctkZmMP8Q1Ctey7o4YcdCeCIPCFgmHtltx0Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z8S6xtWo+IiJWk/ZxPUEwF4cNjN7lWC1CE+1j+a/Pr7Rv/p7PZn
	LIOUYObbwQsYcL2sWW4loD+i9jcuQKVMmU15+wdahVCBawuEOIp4rYEE
X-Gm-Gg: AYBFou1XtQDu7JVvxHZGZRg1n4YHUjnMjGL+WSK4UwOgPX2jytp5AWjAnFfVPdjfCQc
	ITKDlqV2QdXK16+RpZDW9xFHHE2zdrviZRDRColUSKaIyDrx0Wc+KdxB1cqSIix44+/w51ynzBk
	bMcct2aBSFYpPt6Sn0kkBOMpf3fMwt5RuCxrYvfCGWAr1Ve6GQiHqYgBRnvFCyfrDAGrgjyr8e2
	ibk+7ARYH0RPOm8mt4j3fIVL4G/4lzFR3NoZOcN5CF1uG9l2MTi892dHu6xOR+bmluqHYaPwBzi
	yWUOzA62vSaFeBvKpx+b/Hy+/TLQdIiIYB5e0/G75QEsmivIxsfQcNrk5+eWtegv/vTc6Obwikn
	9EbMG35Sot9E6ZvwOL3nlSE+eNYAe2HI5ZAjOAn3O2SKEUzOZVk8V1SK7LAnBNVjpQA8qvcvu31
	F7BpQSkKaP6+J0pFUwEZ0mmfgq8nZicI+S2Eh/bLnVEbFP0QjGzY9JTprhPaFBTlONd03qFrq7e
	BTAcIU98IBzkWHno/U/FBj4JMSMCYrdxPDquHnx3OlTQu3qf7nnb/EL4FwHQ640UOEBGIpJaWCE
	KRQsd4WWHDDQxsc5Pv5izXp3nLQ=
X-Received: by 2002:a05:600c:2784:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4bb4e2918b1mr187322445e9.2.1794691847097;
        Sat, 14 Nov 2026 13:30:47 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm12803478f8f.36.2026.11.14.13.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 13:30:46 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Lee Jones <lee@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	Stanley Jhu <stanleyjhu@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Georgi Djakov <djakov@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 16/17] arm64: dts: qcom: Add initial Halliday dtsi
Date: Sat, 14 Nov 2026 21:30:28 +0000
Message-ID: <20261114213028.1933448-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0cac5090-a135-4a6c-8221-846b34ed5513@oss.qualcomm.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com> <20261109-halliday-dts-v1-16-289114ab8197@gmail.com> <0cac5090-a135-4a6c-8221-846b34ed5513@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 13/11/2026 13:10, Konrad Dybcio wrote:
> Please add the other idle states (D4 and E3) from the downstream
> devicetree and match the order of properties (psci-suspend param)
> to glymur.dtsi

Thanks for the review. D4 and E3 are already there, as cluster_sleep_0
(0x41000044) and cluster_sleep_1 (0x4100c344) in domain-idle-states,
just above idle-states. In v2 I'll move that node below idle-states and
order the properties like glymur.dtsi.

> Please use '0x0' for zeroes in reg values

> Let's break up such long lists into one-a-line

I'll fix both in v2.

Best regards,
Stanislav
