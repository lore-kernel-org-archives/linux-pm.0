Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184410;
	b=IOz3aSmlHepQ1skhXnA1nUAMaFWGFQMTz2cVG9b/Ym/bR2gQG47uY13xSuvPZEKXv3nd
	 sDSmgEh3zcm9/FIi9bVkXXXoooabEGKsDHxPlUVMezbtFE2uAWRi34hHuO94hWg4yIKKY
	 rtgL5mVVE+UTC7eg5damiwMXuOdSQAPisUn/Mf2hb0MeMXsjwQwff0f8E+Z+BXGiwbJD4
	 vm0dW0mHM68WbcremlIzWP/up1woc8I2Pc1ZNUJeTFg+kJcgiBCqDngiuFmipjOc2id1q
	 oJof9QM1ba2H0zhRn+34JaM1cgr14+rAkWQarpr/17bPxbymU2PYXc5lbOsanPiiSrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184410;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=YFKLW8KNYAJNpwdl3pS8AB+PKg8ma9J8S7TqNdUzcMs=;
	b=INYJvysUb+wVqJmBuJ4cdtH2+dlwyzUOwzLDyw+G87uiYRedr3aY6ceTFWPNzYJxUqbL
	 4MEccnh+KPr2NzmNrUh61MisCa+RO1/thpSNut2OL2gqdDnyhdUVD+UfkvTPeYKilbwy1
	 /D/bo73egFBu54BTxRj5QH/rzzwlc2CtxFLumz8DqxczLUfu6c5NVHp2hn9GfDhVoQRzr
	 rM/wrjKOLNuB/XUPLYJLzYqsUerjEYAX5Sq9VZCtFCJyaiHWGzxZnpByUm11NyAz4FoxQ
	 73A9dzKLBELrH32sLLA0+1G/2o7tby7giNVRMTxE2BZfWv9OJybChBxcBzN4wxgd41w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNZuGQVz;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4BF606D805
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B4BF606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lNZuGQVz
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so228833f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184409; x=1794789209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YFKLW8KNYAJNpwdl3pS8AB+PKg8ma9J8S7TqNdUzcMs=;
        b=lNZuGQVzEHPj9v4icTTmtvLBfDYlz/M/Sso0f+SFCtPs2KLbjb7e5aWrWAAHlDGn5V
         SGl3pdyTe0lGYBspYgkiVZzMC9UMLvyqiThBXMz3ffInz2Og5B7p8DZZaCvSWi+9Zg59
         cXkTjnqyhcqHyZtPG68KQsJzc2N+h5/9KnHv/vXFMEzjkOcm7CJsLLed4NN76bwhSGrr
         NeAzNq3xQZI3yrF+NPzJK9DyDwjSrTfV/z+rhp5egW/KfqzqhsnCZMa8gNl9ktHPW9xY
         1l652jbB01osQ7vZJv25jdjL4zOEJSAhBOu1srktMxungIeE/pPGjRUqrb8Pjjq2CmXe
         dBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184409; x=1794789209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YFKLW8KNYAJNpwdl3pS8AB+PKg8ma9J8S7TqNdUzcMs=;
        b=FYlLH3/WYL8mYDeyunKIWxLJySF+Wl22EpDEX/2BNXldJ0kL3DuosH+tkcENILyr5Y
         Xrs0HovzVgu3E2Gyf10fzvIDMMLmKz8UuddcIp0NdA2wF9tAxqA4dtAbHq4Fojt4fmSn
         9BLGu7F20rblkDjOmwJqwWcNL54Tz8eHqABn58Od4z2qyKv2w61lXYJDMDMhCfV9xJVB
         GpsPVpDOJlKX/Si8uGBrbbCdiKQ2lm3t1rqJ/QINl1SDyjXVmvKhxLdde+0ZGCdbH4zU
         Kk5qAHKIrTsu+k+VwUfnuOiJdbUo5PJusqMkZL7g/WMCzM2hl/C0VsDAtJVltyMHNJQi
         MnWQ==
X-Forwarded-Encrypted: i=1; AL+hErHtDw3AHibsNOnNQvzd/o9DuzqQTpJ2MzCnVy4l+Q2jsq2WEIY7kp9eUAjwzQDdNX8YPjJLoA/izw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ly41VR5EHRSUFtjtcAgNUwjKvWHnVZUTMehDVMKWvvL7uLfA9
	Y7JsagmU5iQua25k0cuYFEG0umKHkr1FyfGo0LXZheNNs2bc6iFggzqo
X-Gm-Gg: AYBFou2fNalc76aLo89HezHA1gIz+CaYEtjjGvtDC7Tc3uvjD4mb1rfDtWmqJvU4xY3
	EkC0rNgWw3Biz13k/KsTLsvQnVpG3LQClpgdbb4Sezi1+BRzdGchkN1r4ndTwqWw2wx0b5Sc/4W
	STabCkONEQKEOtCzsoXK2vIsfsTROw6ePDgbHl2OC2bad+gNGvhHQ3uCmBV/K2zc3zbRm3E4JMw
	8FoVSM5aaPgX1kXhZ7LRg/5wNKIHAvur6cbjRej+CNGPXh1WWdhqagfX9H3mlGCRPx9O8Wxk2qK
	0Q6wWNpekJ/JgXlXyvLO+rAZPnlNsso75sFK10yRZmmUWbs4s6t5tjGkeYNKr2Q2CMh0GZRp8f9
	6a9qAHHm3CrOR2gKpcVlMvVhrXWnE+aRxnSWA/bKoci+YAEfzQp7wRK8Yhms5oXarZa20j/g5bP
	4NvnzHo0TgQAZjNbPDvNOUD149QurKsg3CShPsSNQrN+VbHItVnZrzolBQEAuNQXPW+He6C/zRc
	4W4y8Dj8E1j5HJ/7vkP60kdvXLnp9SMwsAV43L1vcXkBa9AxZFtTcM7jiA0hj2Nnbt7gHAELOkj
	4vZp0rH0+eERWZR+LkKWATLI6+SaNr5NlKnhtIBF
X-Received: by 2002:a05:6000:41de:b0:487:6f2:1a4c with SMTP id ffacd0b85a97d-4958363aef7mr5202460f8f.25.1794184408539;
        Sun, 08 Nov 2026 16:33:28 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:27 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:13 +0000
Subject: [PATCH 01/17] dt-bindings: arm: qcom-soc: Add Halliday
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
Message-Id: <20261109-halliday-dts-v1-1-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1550;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=tUWocDfAfCJsF3v3OtoKwfhNWUHIfuzBBTQPqmsMKT4=;
 b=6d7YwzTFYjop5p0/v6W6IN2CR4pGsNNDgYvAeTsTx60B++SOP4IVlql7QjUftzoP94efcMQBt
 9wyXGd+1Qj8DJV/y/ijna8Tz4UO7i/9OTJJYJc+5QBZZdn3iTw6kOCC
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Add Halliday to the SoC codenames allowed in Qualcomm compatibles.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index 179aadc86a9f..9d392329d437 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -30,7 +30,7 @@ select:
       contains:
         oneOf:
           - pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1[ep])[0-9]+.*$"
-          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
+          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|halliday|hawi|mahua|maili|milos|nord|shikra).*$"
   required:
     - compatible
 
@@ -42,7 +42,7 @@ properties:
         - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$"
         - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
         - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
-        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
+        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|halliday|hawi|mahua|maili|milos|nord|shikra)-.+$"
 
         # Legacy namings - variations of existing patterns/compatibles are OK,
         # but do not add completely new entries to these:

-- 
2.55.0

