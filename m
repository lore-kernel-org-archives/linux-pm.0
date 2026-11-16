Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794864457;
	b=rlY4NuTTgLReKSfYh6Adim7Py7lZCvwevXz4yhTkfbIiNmPDogMrwAX3FpyCCDjS0sUH
	 f7YpDCBiguGpAZ7BVkyh7NQq4wWxfjdGUrZYLwdHqCRqVNt6gpIZOOBpXqAhfYy+NIpy7
	 EvFV38vQeUa3KEwBAoLpE4cn6RIZgf0eX3t+HBQT0Tjrink8LdBtT5XcM0n5TnMXw3Fn5
	 BZWoIQnHNuGHD1eisi10arGH3PMwjWl2Ls8CQ6Mbh2iP0EEb8sOwRpYRDWO0Ich+XVMW8
	 /xZxIPlIw/JIWZc39b4dXDnJz14aeTNLdbsXy5PAznx1ESY04LNzVhYdSWxc05+JlAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794864457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
	b=Sy/f1d6gvToTHxFLqwPhJOxZtd8WsjA02vF610kIWSTRG6Mh9Swi6qvFvNTxon3uZcZV
	 JBmrc/iQca2ew9rLEIuOQtvXMPUA/RvXvH4jBikU7z8oH4bSjO/XuySU8a5eIA61wBoEG
	 csDVGaRN7lYPxJi+Sa+qQstcOxOt4tfesmHgL9SK9J8uY3rRt0t+mMu2+MGkV21X/xDhg
	 K/Gs0TpwhE+YblGu4wV4M1LGMtoU80k1bE/NFxw6wU5C0wKs0QfeQc3dIn0C5yTmKibNq
	 mpQU62PD9P2rxjHcm2xWOqwyeMrJKxjwzMC/Adj8UFRadE8ExU4uvYN+mpBFUQbo+fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aEwrHomr;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76056606A334
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 21:27:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76056606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aEwrHomr
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so3551455f8f.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 13:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794864456; x=1795469256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
        b=aEwrHomrXoLkAiILddo3V8DFgxCuIXh9nv9z9CGp99Mvv9q7rqS8WWfJjEVZyPKHzl
         BJcrzkqstHqVy4gz1/y4oTWYkRx+2g14yun07x+dBnVAXWbxJ6Pi8XR06lfkxtBvqCY9
         iLfFme7fheT+0AavzMAdfuk0LNIbBb4A/fuWyckPSLx8IQoPwrMmA2E7Ut++Patm8fWZ
         5Z3yyawCVkfdeHckJNnYoaWNHRgUbs68NL4nZXkxamHwG2zmOimO4uoTqxyi0KJ8H74v
         KgRMh5LPcsoko2D3/7aPeGtRlw0wksD9UiL+6PyQMe8GGRsHDiMrNoZmXU6ZdSAHjYHb
         hHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794864456; x=1795469256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bHyunwqhqqpQQZSm8FsYLG0nPatLuBc3TvD/xVa6m3c=;
        b=Uxy9Nt/CKcPznqUrSh5TG7VBjX+ZnlMdoZrgPcTlFnbbmEu8NZbJKCm/LGVRc7eNZj
         MyVlw14iFL0GY/aSIA1VPOEpD6zv77KsBS4UOFLFzR9PQ0Ne0pacd6b2gXQpAlDZcpvP
         SufiT+uWxcIUMZH36fht4W+gLXxp7mq5Cw1Rl2uctsAzbIo+D55sXecqi7Ajc8ab6Hbh
         1G5ikHCetNmzfsioyW7sRgQitM3k1fY5n4M0+ijB3MnFtvIcX1dvBgkhOsNA/p1ZDJff
         +N2Ar3rH5XUtVxsQPnNvwp364QXpmH62O7U8NS/4h9LcYoXyZ7eADjCnm6mBjlBI3C7Y
         5VjQ==
X-Forwarded-Encrypted: i=1; AL+hErGfxG9gmau1JCNg/VqS7+HGJ7rsK4NS6UkZzFqEF+lFb7BE3BE129Ll0X7j4uBvc5R2ncinSdKO/w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+XdjxhnCq9wtSBY4i5Fv5u70+kBxfMZ3VKqXOV3vsmdnmAGwjB
	Hf4MnrGfDvglRIiczNG7fHSe2f3RzwBKdfQsjH22SkJagmv9lfmMGsLf
X-Gm-Gg: AZFdTZdORLH8SMwoCuMnNb/u84JWioHuOSs1eHTtsyF9Om6UTHLf9WiW+3G8zhSNivM
	VHWQZzoJGhxHx8aSoTNTULvnIbfSpZ3U7TiOdhNGqzhGiDZRufqyyr6DKPL3Z9xrMYjV++Cd2JT
	enQambuTMVnses56Y3lsu4jM9X3TdbrSH5YJcqV2mGMlilKr9rQnEQ3OPksBSQpcHetsmreZQX9
	ok4OLIppGr79iek2q7ta/zHabfLsnGZsrq9Il5fmNuK6baPNln1vQju0yXAOSdCDEL3OK79vY2Y
	spibN6ypv54kK/u1K/xXIx578apK00kBjQSUS+QALaQii2l2nu8FcG/ORLvpOGJ8K+KDhkS/N56
	lIZTPJQ+gJ6gk4ZPAma68JsscE9YmhK2bDTuhls7xNUEv/IMX4kIC4XMoRjrcAnSMeAoY8ykzcG
	0lujzfYBXu6X7ONe4kg1Ch9zO3zovm9J9N4HibOOh3TBtyOE5cPyaB75k/C6zJ0pdU5R4i5Kp2V
	4csE0ASJxwaySf/ObsgezylRRdv/stRThMgqhf9izxKht24w/psib2JB09Qt8Llc56jxkC1BRi+
	RosAu9EfQ4Dq+9BBJJVmN2cSyXPMLnXTjN+AtFeI
X-Received: by 2002:a05:6000:25ee:b0:490:b23b:802d with SMTP id ffacd0b85a97d-49c71d475ddmr22315194f8f.37.1794864455894;
        Mon, 16 Nov 2026 13:27:35 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a378138cfdsm1260150f8f.58.2026.11.16.13.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:27:35 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 16 Nov 2026 21:26:26 +0000
Subject: [PATCH v2 10/16] dt-bindings: thermal: qcom-tsens: Document the
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
Message-Id: <20261116-halliday-dts-v2-10-2c92438c6c46@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794864382; l=829;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=QaX1Uqhi9JFBTyniSmrOqgkrx65fb+cn/pSnBpltl3Q=;
 b=9cBm/5Mi8IeF1ejOwJZWQD4SfyJ7BWDjVcE5y5kBsTodKh6u91I9h5To2Rc8ArYF4KPYJAO96
 griT0U/fTv6BDQooM53jxYIwB3vuzMj024ajCLGGuHNM9Pf4WE6Noed
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

