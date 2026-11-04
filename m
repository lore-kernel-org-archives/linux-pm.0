Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793810846;
	b=V5R5XARqe6niDGbu/ox7YiubmxfKW8kHM0jGmnPO1lBbaUJ5VP6vM0B9VhXsFSbQ9aHK
	 MkSxW0HC93ORreTDd/wbXxZVbfU19vwcTnfuDjN5Cl9U7MsZad1rbxigpqitkuIAMG03/
	 WOHFLK0WH8lolAcJWZTX4NkeSHTpavXGzSe+vcSfaxRUx8GFoiwVFMkVIhwtqYVgsh5Ir
	 esGI8nTl0S/CEt35jSLTSfINcDW2f6mfrFbvU/em84m/IIuthS35zQNDxcbQorkA57XU0
	 eOpgltdeYUipTqlTrdLFn1qO8N2BvrSh7NSzbrXH3z6lVC7pZsmL9r21mcrJHYpLrqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793810846;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=zMbG6vrMcWe5nACzqEmNc6Lg/tRkWbgNePdHtBr1o4c=;
	b=43QGvUQ/aNqW2jTsXpYfBPPZNVQR5pDg9ruqNHhJ69oGgUz3iHOW4a7McdwKhj/BfNhw
	 MIU6HzRmJwJTRQzMTr++gr8qoMyP6ExkJ1Q56xxXH1dmpuVs50zaRIJvpFcDAKTVehwGp
	 8dwGM+eIr/rw8arFkjiIlR1B+vGagHvb+C2EOuU1TTinHjQYxvAESrsu8MqjZvQ4jEc71
	 E5ICm/Aemo3pSHToqL50AvTMy07UkDUhS8hpUXKo30L8KeKGfEbsVCvkT+JA1ut9cFvww
	 sDNtMGYsN1GLYy+gteCSyWR2P4p3G74iaQYwwENd3w4dHXOl4KaCQZnc8/Es7n0fhhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bq1wPuid;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58924606EE85
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 16:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58924606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bq1wPuid
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so973084c88.1
        for <linux-pm@vger.kernel.org>; Wed, 04 Nov 2026 08:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793810845; x=1794415645; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zMbG6vrMcWe5nACzqEmNc6Lg/tRkWbgNePdHtBr1o4c=;
        b=bq1wPuidKb+BpFTqMAhm7/EWX8A0CldFXYzvw7TglvuSehTtA+Wv6rhY2jEAUupSPz
         8Y+6bq9xZ4N22LC/k/nHIU2VRG4ER3x4QhYoQCxWfRAiy/vR3PtZmIv2kgsjUAd8cusj
         swjHaOz2WNvfkpFbGw4/4xxxjoXXGnGZKtQp2GV2xxKRCEg8C550O7PCCGoUHdi+MqYB
         c0M9ArvTTm8LLIkCdho+PEOq6aqF2A6sUoxxZAZUY1J3Vy0xYJ3rBZ93IVmMGnceJbb7
         U7A+9TZZIJmWG75sp5+9VXfLb/Ll2bWz5tr7EoZ4xU7nWPjOf3caHWdaZTOVz/74+p5I
         GrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793810845; x=1794415645;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zMbG6vrMcWe5nACzqEmNc6Lg/tRkWbgNePdHtBr1o4c=;
        b=QrDGVDJyquCk+DUj8q4X690zC0I++HdHctbjd4dqS3uNekd4PxqhX5gvecTZQWQoO9
         lfAcGoj0QYwSJPcQAejr4BJ7Am0kJPd/0lCHei48prq46snjTRKRKOMGmuXL+eywXCoK
         ua5sBV9NuYbyF3w0OubPRItQJ04dBNfN/+Wmvo7BD0oyLkLY2w7n7S1CYhsZ02OXXzUC
         k1hTfVjmkILzrjD6Flsnuv0uWMfyr+7JpHUQexG8B5urIu+LVfR1H9P3IbEnjE0bDRHI
         gro4xndWsgh3V/sxyLI2SzeFgguoh7sHKWJX5KpF9RvbTUer/Vqj4vDUnVxSYOkgmxkn
         cgHA==
X-Forwarded-Encrypted: i=1; AKwUvBxXZbpMlGxa73EJvPSQsURVig+/cnp4Kx9uGExofIMf92CjATpHNbd3zL8OU7YK6l03wmhT3rImjg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9YalBRiUWAKvQWBxg2NQu6EHujb9HKQirvWC8tRum0m3m+wq5c
	/JkjQ0Uhhy8rqTFqvyNkTv8JhvxSsXD+3ml2PBp7RCEm0k1Hns0RpQwW
X-Gm-Gg: AYBFou3lEX09dP1JASzc1suKpx4eUOsvIm1O1YwrAUlvOwKKE3XruvwRbLMONHdiMuL
	QsByR0Q43xey0txLl4T6sIu9YJH08gqmMwcKeNRBh5zxVfvPchzaF+JsOa4DDFGN8XkL1n9XgCJ
	0MDZnIA1Cyt6Mrk/3p00mHhM/ry2gxHUt9jc0j8dHTqdcn5PIqCxymwhaarp7zZI91OmwgBy/R9
	R79/Rd4aHA8NKYn9sfnIpAsM5loY63n/algAyaHquURMGPQngao11LL9aTbElVvPYx0d2kd5uh1
	mL51Rf2RfBKLWA7k494E2U8Vno3yoocYC/tqCEL+hubolHzCuHiC3dSfUpGzVAUBAP4bOTaW17L
	YIsJ+CWRA0VfZhGYzOiJ8NTnViQaomjpMF8NBTBfpx8qBkpDlxFLoscjQSh0ZDaDk2QhFijjPcT
	fbtlR8Ks91+bGKmBvsCuHB1O+Xii0DL2ygg8xyRWqyd5NfVjdchYw2r3S50QFTovVL+JqTSZmDA
	Vh8izcXUJlq/o3DjG6GZgl6XmIQYjDNBFE2OqOogtHIwT1oD8EtfseBTnd4K8RVdgA3Dic7mk49
	9WIoZSSpZl0HVtBtT/WOcUImFhiQYGKuy3NuDPw6flwNOYMtQA+iZGHIqAl4HhYVgBa9sr5EZ4J
	q1CFK2BU=
X-Received: by 2002:a05:7023:90b:b0:14c:8461:b3ef with SMTP id a92af1059eb24-1ac5e6f5132mr31506193c88.24.1793810845290;
        Wed, 04 Nov 2026 08:47:25 -0800 (PST)
Received: from Sobhana.localdomain ([157.51.207.207])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c57430sm10839666c88.18.2026.11.04.08.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:47:24 -0800 (PST)
From: Sreeshankar K <sreeshankar0910@gmail.com>
Date: Wed, 04 Nov 2026 16:46:36 +0000
Subject: [PATCH v13 4/8] dt-bindings: thermal: lmh: Document SM7250 LMh
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
Message-Id: <20261104-master-v13-4-355b65c6f764@gmail.com>
References: <20261104-master-v13-0-355b65c6f764@gmail.com>
In-Reply-To: <20261104-master-v13-0-355b65c6f764@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Taniya Das <taniya.das@oss.qualcomm.com>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Konrad Dybcio <konradybcio@kernel.org>, 
 Robert Marko <robimarko@gmail.com>, Guru Das Srinagesh <linux@gurudas.dev>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Sreeshankar K <sreeshankar0910@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793810796; l=744;
 i=sreeshankar0910@gmail.com; s=20261029; h=from:subject:message-id;
 bh=J3JLI+Blhkxqdoc8xLtRIhgDC8KARWHgIPjkApYQ3sY=;
 b=kBVXuJVpl65Jqkx4GULbJr59C4L4KJhdnwRlb2jZNK7mV/HoJ5fAdvNJsr2e5rCRPli2NX6K3
 QcEZXucPf4MDzauU/SeHXl/IE+5KsUbsPsBPFVOGpVI3IJdTX0hYBET
X-Developer-Key: i=sreeshankar0910@gmail.com; a=ed25519;
 pk=CGSHduvtn2hwLCNRXRc9s/fh6X8PH/zNdp08zC8hOuQ=

Document the LMh compatible for Qualcomm SM7250 SoC.

Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index ce72347e2..e1d5cb871 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -21,6 +21,7 @@ properties:
       - enum:
           - qcom,sc8180x-lmh
           - qcom,sdm845-lmh
+          - qcom,sm7250-lmh
           - qcom,sm8150-lmh
       - items:
           - const: qcom,sdm670-lmh

-- 
2.43.0

