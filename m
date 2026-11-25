Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578223;
	b=bmht0afVDKGBSD9erM4AiwFv7pwnyhUgEX1OA/yWEu0oN4+/w+anBbHiiYFp9e+ujV6s
	 sK87KnqC7M8ZxWLO6njsbJeYnRj5dAzC8rzaaAQ02C8QkX9y2f8sjxHFpCdp1ttGQ1G1T
	 MKtYZOSHFbIfckuYPN0HyLZsuXpI+YdGGf+P/bXitEnRRNX9E+GtxrjOLC6HYJN+26ph2
	 ygaFNAPJT5sqOBq8DzVdhqhElVvZ38m2It52T1Icawu9dtaLFherCQ1LuUarcmS+nlUZR
	 Lbq73gQ0Rnae7ElJDZkwD9e8oDOro6ljttDj8Gz+EWkjAttFy/rjw+WcJByLq9qKJ0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=dpKnhnsaRxCp3BhNS6dMqX7R85atmEMYETrpv/6MbAE=;
	b=MvSdmgX8DvleOReNTDkeppv88e9h6Wz5g2RNhpl+7BSQYUVA8oP+IrlVIDogj0h9JS3r
	 BpSBuABLcddJiEScIJxf06NBEP78uf7R5sOtlU5EvSUKCgmAJl7ZpMKxWPs6XsOlzIrWd
	 h+9MOlZ4oW73sB86iRiw1R6cWAko5RgKQiTcyRJChvxJNWCLoEwluM4mXPMlBVmn5XLtZ
	 maUrZsTArnsGtSZKUbyKLeyi3IkLqg0BjHaE+UpkV8nxWAdpLSGLWYf0TE1oDjKed4+rd
	 sNSJ1n3CHTU+Ahv7MNLChWyo/h0WiDl6CTh2krRDFz2Hqn9jFfVV5W8unLAHVv0iGUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0gL35YaP;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A60D606A330
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 03:43:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A60D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0gL35YaP
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so35707925e9.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 19:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795578221; x=1796183021; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dpKnhnsaRxCp3BhNS6dMqX7R85atmEMYETrpv/6MbAE=;
        b=0gL35YaP581fK3jcOJPups+fF9Bbf8JIZtZt5mMf57n60XTFjn4kYofnxX068yiYH5
         FuQ0yvkMTBi4fEdB55IabfGWqM2T63H29uww7lNh8DHLTv1kOBJPGaeo3AMOqMSSU+X6
         3LdUBD9U4cj47O/R2+eBKO3iISBcpxscvMpW/pqZcRplromX81Z3/RuRNnC5/EG5rPmk
         BQKfdN7YeHa+gsvJFgUsSAByJJs5MW9Pda01hnPON69QF8pF0jxAMkykIR7oUfizwaCg
         kbnLzik97Yu5Gv5WsFhSEW86b5D4gcno5s7wlSNmKItRT/jR3gKoc8KIJ8tUtaqOPD+Q
         iaFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795578221; x=1796183021;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dpKnhnsaRxCp3BhNS6dMqX7R85atmEMYETrpv/6MbAE=;
        b=tX03uZNPeMhEAFqveFF8FN2DawrLJTGvzIVOcL4OmPqJjZ5vurih7N2+mtjiTd3Iw9
         e4WMBLbaxNZaeu8OSNR6IVajShvngRsnY6GHuQ1n4vr+VCGDBz5tGVe8T0qTPSsKaqmh
         IgwUTl4ypMJstJyVy2ttgNKacWmQtUsBtGKqSgtm6HwprUAQCtxZS7QpYplZcXjkd78e
         jHETIYpKELqoui2cV7Z+gDwp/3Ftn6ErVtj5hf1vL8HEGBb5TGIHIM0Mpd2kPRntfrsV
         qsppGQYLZglAwHHbnzhrEHfDGP6yt9tq+9sFv+Xu+ytgARJ3NwBWmCTefWkFa5eQ5/+d
         6BlQ==
X-Forwarded-Encrypted: i=1; AL+hErFSbftqUqI4H8AblFyAY55vmDNzRG3mr9WZK7PXsT119UKw5SEl3K5AH1Cfk1KViaurVLaNy116qg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/oMrZd8lI2bUvMgKF5gNvp02Zv2EdhBaIGElg4YNZ2XXEEy4Ui
	gRk7392BnnOHSuudzARy3jCFbYWAAQMHdDuk9dFOh4GX3Z0tNtBYpixv
X-Gm-Gg: AZFdTZcW+zaxFqrzVYyoRaQamIPfHPkTK2reIM3YIHAI95qgmu46e/TCmaLoRfyvcix
	NeU6vFWRekL3LvoLCjt358SxV3UKaAc2ScJMMKjBRKNZy0pjoxqQLApFJQunZMexS01DV8bWubv
	dsoGDsuq6IHqkTLqyooVmS+fxcx0R32Rdj0f0KGYvASapVWUJa/mTr8tHAJKcyjOknS/PKW7XOs
	yNBqxXuLxhuocdw0JpxjthyxKrhtagSaw0dP6ukRpMBKwojq7/WJr8v77CmGOtjQEkR0c9B2UiS
	o6jaP/LMKL1dCHd72zpuCenc5fTH/RKFS00MMmEiWfX4bADaWDfyZDs5m2M1lShwYQX+X/1SBGd
	yznarFR630Kc53Am2DXLbcCwrlD4uixsA5ja5DxmpO5rQmaWTK5TXOgrvtitHgacW2ZK9f/UOy2
	d6ZuF0kqdOdcWA08KDT6TwR0KmVllJTzTFrcRMg9fdD/50OE7oA3IOSeqPnV6qn07jix9Yf5OMy
	cd5Ch4y/7Vu8DszDwjPaj5vXeb3z7NgJpXDLGAgJ4fAz1AFZ5BlVRoIyuQS9k04btYpDYHqE3fl
	AfV8F7jnwERs63WZIEY7IT/73g4v3ZIyGELX1w==
X-Received: by 2002:a05:600c:34d0:b0:4bb:6a5a:7839 with SMTP id 5b1f17b1804b1-4bb889428eamr328092505e9.34.1795578220699;
        Tue, 24 Nov 2026 19:43:40 -0800 (PST)
Received: from [10.32.31.239] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88402ce9sm391107925e9.0.2026.11.24.19.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:43:40 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Wed, 25 Nov 2026 03:42:58 +0000
Subject: [PATCH v3 02/14] dt-bindings: power: qcom,rpmpd: document the
 Halliday RPMh Power Domains
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
Message-Id: <20261125-halliday-dts-v3-2-5c8311c0b70b@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795578204; l=1076;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=2tteAd38AfHrvk8Awl3RAniXNSdGBzL0LwEwE8e7LoI=;
 b=5C7/JmmmJaij3ZDCjC7taKHJ7ftfQrXNJKeux4QbuaH+Zgcx8qkDlh+sISv0oWyhLHGJ/5oZb
 fvQPpset2HKAWFH7uV37/GtdVaAFBb3EKxSiKjnd+R0Yi73lf00uJQF
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the RPMh Power Domains on the Qualcomm Halliday SoC
(SXR2250P). Its command DB has the same power domains as SM8450
(CX, EBI, GFX, LCX, LMX, MMCX, MSS, MX and MXC), so use
qcom,sm8450-rpmhpd as the fallback compatible.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 8ee1c25a7c9d..663baae9cc64 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -82,6 +82,10 @@ properties:
           - enum:
               - qcom,maili-rpmhpd
           - const: qcom,hawi-rpmhpd
+      - items:
+          - enum:
+              - qcom,halliday-rpmhpd
+          - const: qcom,sm8450-rpmhpd
 
   '#power-domain-cells':
     const: 1

-- 
2.55.0

