Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578260;
	b=wQ3wnlwpua/jx7QcdpeiwzWoV7aUaMj7rp6ygLalxHAkl8XDdVaEQ58mzYjTOOWwJZY3
	 lpIVLDVqnmDNT6OJ6XyJOUDXthies8olKtXotBa0Q/5X7U+b4HbdyX/Wp2qC2LfE1YQdE
	 7hzzzHPHthYDCJl8jblr4HxAVvd43V5JqxkVKMC6BO5ZAvMrnPE9cIOAFvP2wKQDHMxL5
	 SM1TXiPzwoTM5hlk9Ly1RF4PHz2oPl4M0gGuYUYanqeOYFsYV8jH9rHwEOTmqlvRIP/lo
	 Gfh3JZcvabLHBP8mszss9ybZpqlf9H2JOjwhno836fBwdbrg3pG2WEyR8x4jj9GHyvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578260;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=W2b0VXMdCxwEqSCTP3OlO/X4AxL36r2Zoj510JVt9mk=;
	b=xtb2g+hKTplYLUwj/YKds09YcQTr8o8dplc0BnjNae9v3HBmP7pAv2vujaaz8A6KhuXf
	 dMujgfDysft6zBJPC+QsoKEHknCznPzVpEfIJZ1LzrSW7AFV18kO7Vof5b+9VgnVncjS8
	 zSysExvsCkoROd6gD+wuHpZbITuHB2t+vNwPjBB9+4aHIRyZ+z1MBrdRXzj/w54Xgx9yH
	 e8Tg96pdtiDvteYuYoZS/m80Nf7V9CfxjDaerAf8ciMn/5TvblQHSqkWkpcTRgprnSEJ/
	 hEcklauVSskzV+jQxRnvfPCoCm4SxwmkPcI9ryI7xu654uNftyDMTuafqJwVNy6fYgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=laYSzHNN;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E91F606A339
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E91F606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=laYSzHNN
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so35709575e9.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:44:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578259; x=1796183059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W2b0VXMdCxwEqSCTP3OlO/X4AxL36r2Zoj510JVt9mk=;
        b=laYSzHNNApvR6hkCfW91e7FyeGAkAKidR4abU+y7ghA8I/ig+rBp4IhezAN7BpYWH3
         f5Y7CPtN4xV7uJPIaE56Gva0Rp5GUYs5GwSqRjsJcJVv2f1+wmo29KWJzeu7eCxi6m3c
         9Au+o4hVYVaxhe0/Cel8skNSDR0POHCdew23VxzftD2vmyoJQvIikRA1VdEp4QXuCv/m
         hlsnWVQEES+Dp5ga9WZt8jZfea89OqfZ6LI28tB1H92eEcyOEQQHudx52eC5tBgRnRjh
         wIhDoX2puuAC+T+JmQLUJsdgugRJfZMB50IIm48HMGcA99AvePM/gHhJt3ufW5ZrcdLd
         r9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578259; x=1796183059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2b0VXMdCxwEqSCTP3OlO/X4AxL36r2Zoj510JVt9mk=;
        b=Op8dLuuHomTj0X2SMGMNrUpUYMUzoudCQWHMIbXe9toPj6gcDUeJ9jJJx0QSxUYgDm
         KgMAQteadGrYSQ9trdHCAoxZ437mUO88wBv8Uli9ReOpm2IouYZKoz154+/YhfS6DOh1
         ++fJ7bIxI8WXldD1V4Qtttrc/T7yHpTnH3WWUg2KWmkYNNO8+yiLXSKcTLqb0UW2o3dK
         561lXtK67tpd8S+czMR2uHNyHx2P4n1Jmk9RYpSjzxvZRHN2/Cd9YHDaCFYvMUoiguqf
         MKXy4DkC0kEuu4HHexJgmqyPKTmTe3UfvWNRiPyvDmh5ge9TpoJ42BRY3nhGbLT/oE61
         7tkQ==
X-Forwarded-Encrypted: i=1; AL+hErF/fhAL7CuW4Bv/ecINZ/MB+yT6AZ4QomtXntm17QcScTjgmtj5CzjKVKzQTN8q/sCLqJPJk7Yy6Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z9pCjYOymNfTZE68Tolw6B0uZ5qnmSRTbSZs/T6gte66Qs5aKlo
	vQUYUK6el8kg3SfGPwx3Vhx6EMctgaN0mSw17q4z4WOcAIyBiYIwoleA
X-Gm-Gg: AZFdTZd28O/KFJ3FbHK5XkzpD4MVF+KV94G1zsRUieTInkv4HFmmmA6PFPdFMtABEpw
	bkOZYOUbjSCH4VnWEMaRnpfZzX1OhLxrxW+0J1nCHzwMkXtXIuYHXi/nw1l3eZRCsDXPRulNQRx
	6WrvQtJNFbBfSjWkUY7nObqX3b8+BlMd3tC++/WSdZc4JG8vmvzryWl3L7uo5GtMStOqyAidCqT
	JlK5nPoLTKNTVnFFPhhqmds6hsCZHJ3ry0WyYgni270TGddiS88IWtjhK5JMBo3KqPHf9dDqil1
	rq9My2N2K6+7G+OQkMgSyNHfRwuodm3SQlUbjIyQRF+GxbUzO5VtREAWwPQDsEU1xSqHnrf78or
	DtqUQiiFY9pJwrOc4eGDCJv5/R+cR+5ef0wMPX3C6rcND3JWwfsFBgCS3o5N5bOYMHD7X8i8bhk
	Lh5p/Qm3oJp2TIADJ2B8HjD7MvCOMkEh0x5OKzyR3nRVqefNH+u6YJqWB71sypH4szC+FkVXmie
	Z4IjotVoTMLGZCF8CR5n/RfZdZRJY4tiNDQ+cb7JnEQgdoFLHu6pCcad6P4J+s3R4JGsi6pbpui
	efNZbeF4sl9qW4VTrW3uqP6qZEXa8XnXHwI4zQ==
X-Received: by 2002:a05:600c:b85:b0:4a1:f720:74cd with SMTP id 5b1f17b1804b1-4bb8892ca5amr333720795e9.24.1795578258707;
        Tue, 24 Nov 2026 19:44:18 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:44:18 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:43:05 +0000
Subject: [PATCH v3 09/14] dt-bindings: thermal: qcom-tsens: Document the
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
Message-Id: <20261125-halliday-dts-v3-9-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=899;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=Gu7LEPVBsHDlbEA7f0+bCh3HrNIpvCrq8874bMnEMyI=;
 b=LwuvM0V2lFpMa4PY9K99qzfFeTZgXvTT9zRsWf5xnLCKTkxZox/BBQLcveRV+2SwtDIXcUnAz
 dTyT3erZvMTCCtObEN8DKkAXoSDLM9Igo6aZR3InSklVdITD6tCjFp8
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Temperature Sensor (TSENS) on the Qualcomm Halliday SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

