Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184481;
	b=JEzLQpsO4DLc+PsIpMHDfDNN2iT2tCTdRB+Vvv447jYcP1JmvdXE09H02zyFRoX9yJbU
	 IoTNVHiLS/TQtkHw0WVD8cNvEGeM4DdDPr+41gllPzZFrkguuv72vhUreQsGUUovzXOQT
	 8JnTD6ewX+m5PArbBhkQ/fIrihIZuWJWOJrQZdkDLYg+q0Vbd3d7mfm6ja824c5ws6jnq
	 yR6eMAW6QYOqsggTJzhWmosBquiXGry5ZsePGi5KyoPDoVjeSRMn9Sa8cAOLjT12BEacP
	 k9ms3UanWkYY2C4ttc/Qo4/LoUemZkiUmTfv15idlT1wfWfMut89IaQ1anyriOAWweA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
	b=4efcCDtA+zkUbkXCUu2dTR/MVvM+y/cZ4WC1tfZGwVJERlQ2bDTlpEOM7HfYt7B2msRK
	 SCRLTUe48+vK9vshuH7vb8mMHAB/OXL/bUelml+L9Rr2tdxA8ENQZbrN3cUhYOMN69aq7
	 A3ZUJ/zhGUzXzqzYrPUxdxSqXZEqpf0HmnzeApjUOF7+loSQ04UboVJZr+YIf/OyzK8q8
	 YEVVH/4KaBvBUsasLFwXHoJCNS6mkBH0SxGIqShLqAb4cT8BAKm2UaIXDeWxks0I/Ptf+
	 ++V15fV5/QeXcUv4yaMQ3EE9GJHKdKLiccSAwUbcxBwJBS949+pO8pscjTxymy853kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVXS0Dfp;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DD4606D810
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:34:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2DD4606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVXS0Dfp
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48fd2e38825so235742f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184479; x=1794789279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
        b=IVXS0DfpUIsNMmmlCVLQc/sr3m1dEoc2PxYn9Q1ZBDZgge7WUtw+jdTyqhCup5beuX
         p5UkKtqsdQor407ZN5+sThyv2nEYmcDa0uUa+CnKgMYC7zlI6qui62evwV2DL9VYinBy
         BarYqmMFrc3QEZTIlC8ssJP3XT4AbNHEFJZW9AzKMaUXkbZAhWMFSvOd7SRW3KD8cBll
         drhaytrMXaHy1ToVY72wpbCvSuNZPazRJo4cICaGRiht28G8IVeEueDOvEoNfrZLf8pw
         YGCplgziHwLWFFjwnfizo2aTCI9Yr266yhB2sLiV1K7bPAt2DOuj7ztQV7B0vgLaulZy
         apqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184479; x=1794789279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
        b=0Uh6zp+xY/82uwyTLokvT+uwcXKIOuE4wAoWQX1UFMPqA5UA8t6l1UHGMa3QYrbciR
         guexOLYMboerCJxu6lla0oKjpPhD8QwwQ+VHqAWjcaLm0W1fWO7Lr2vVeSDD0xNYlpx8
         gM921w/3uOpiUjyr18pJjBY0I+1eQrubNOjK+WgTeb8/CilCFxxpaCsZDZvnNVrrTbl3
         l2w9MC8CrmK5F6511UFYEcB/nB6EnuTRSgR4bsYT4GlmAFHp+R6lKtfuM7UT+Q0U2Pww
         4DS6EX5c8AmsultyU5zuxyz7W2ffU0d9K+BVZ0nzi+s2MTFzBjjQJSbV23MsNOk/i7aI
         389g==
X-Forwarded-Encrypted: i=1; AL+hErH4Y7JUk689namtkrHox4lbzvwusLb/jLHSnCueLcWnwKF2fL3/MH0Cv31KSIxtv2KHJKDOffVJSQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9bZsxIBflP0htMh4oNDOkgefX9JMv6ge55JMq8Gyiul2GgJl+V
	D4oC9hhRStJdscNg9tpMQ45UVSH6i38GFNueqfDHtQIRdzUz7uxtMneD
X-Gm-Gg: AYBFou2xbGBJeEyEJuvHKJZzfSyqHOCKUd9vqRQUWBJc5HFBvAIfAC3ykM8pc9Fspb/
	Lj4El4meyeG1oxgLRgVEAPTLYikLb8Q+T3j9aM96lO2dPshA+Xidt7t/ilOomqUQU6bFswjnnU0
	6dFAcNeBMM4IrWo8X74/sN50gERoGG2Djv7jPITLqLXJ0+wuH+AAFYDQFU63qCy7IoODp8lRpYq
	QBVSAeu2oYuwPkTYnUxRLt55U/XvsCnDCAdWrjXyPUOKPEhritZjhy8iN2QwKHPpquc0QFvAaji
	VluptRFsIObO4xXcqOAh9UTCIdClK4CnhL1pFmQXAgcOCm3+lTpimbE95A6cnO6sNdLzcQ5S1jF
	xNwDdlu9GOBq6Dqh6yTWgsyZL3biFfp/pSDEPq8biHIyEGPg/B5K2TpTi3uP388M/hS0jsiLUK0
	wConguOSzMHCm5wGRsnP2iHQIefnzHRDfJD7nEnkwuvXaByZkQrXYXn4kvnpu2ZTaH4xufNbk7M
	2WUlpsqwrr6NP2fkxBJZVJGZ0clztO+CWbXdDgRy4A+Haux/ymIPnznCrAt1iVIjM9mR6vmN92H
	57X5PlZUu0fDCBSsJuAIUuQDp3LwtWTwjIEoanIv
X-Received: by 2002:a5d:6f0f:0:b0:48e:679a:4aeb with SMTP id ffacd0b85a97d-49586a3c015mr4911501f8f.3.1794184479389;
        Sun, 08 Nov 2026 16:34:39 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:35 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:25 +0000
Subject: [PATCH 13/17] dt-bindings: thermal: qcom-tsens: Document the
 Halliday Temperature Sensor
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
Message-Id: <20261109-halliday-dts-v1-13-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=829;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=QaX1Uqhi9JFBTyniSmrOqgkrx65fb+cn/pSnBpltl3Q=;
 b=Nal1T+ROAiQwIycyxEfKMIQ4y4aGW1L0uJ4HewmCRmGIZfSJuQVD6Fg2qPRcOrHnEpA/WiD2I
 u4aa5TB+J3JDBwhP4O82nlPD61zqIxNlRPMGwQQVcuKGnMJPv1tp6Q6
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Temperature Sensor (TSENS) on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index c78074fbcecf..3b440f395fe8 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -57,6 +57,7 @@ properties:
           - enum:
               - qcom,eliza-tsens
               - qcom,glymur-tsens
+              - qcom,halliday-tsens
               - qcom,hawi-tsens
               - qcom,kaanapali-tsens
               - qcom,maili-tsens

-- 
2.55.0

