Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184466;
	b=pzwHb+wE13hgc2YX8j/a0HYRqRB0m0RjHs8F2wARswJaQ/Hba9eMG2wkteG7CRK5/Zzh
	 EeZY49pyw1LMD9QjKc1XwqBDJN0jy68Os+S7HSVt/X1iD4kfLspM0X3ZpA3cmJCUkqZ7Q
	 o9WYUxRPVeFTK1yahkhVHnGSLz6qWVr5szyf26WsRSSLXVFM21x3aNGzthfAz+NUz6TjY
	 9Dt31oQjh2mt/Uet5y1k0F8GbvKTF1oYIcghuRGN1T5HRYz4ezhxp+K4TC5Gk2hoInA7X
	 +ybsBbY43p6IG2f6970FRp8HN76mSTa2mSXlxCquLqP2JeUWJGnSaa/wAgIChVPuPTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
	b=DSESbZ+aHrnxgbuSqeL61gRcGgcpz992jvWXabpBGX2BKtlISDm4/yLd5HRc2ONCjuAY
	 AhReheba7hdfUYTAb700mT2+n5zYGNveg6r/iNN7RUvInwb8jCsRVkik1uauVZ/rNH+lf
	 3qT95tSWWnaEzDDSmJUnBxUWjK7VA0Ahvf/tao94u8+wDevZp+JGfT3zZp/+PX0Z8ZhJr
	 MrPIx+n4eVu5HMaz/sLpXX/JNXuo3i0SdQEqfD3bD5VKGdCvt5x0/E5mJnAZ/phqgBmlV
	 XYD6U3it+U+wMvdfctKuvJ1AodO+BBE5Fm2NxddDUjdzcsBNiOp1xwIKV0qyGZQuj1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXTbJrRO;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942C606EEB6
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0942C606EEB6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qXTbJrRO
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so187643f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184464; x=1794789264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
        b=qXTbJrROM77jrmCM9vSlEIFFKfBcarGsiF17Y6oDUL7SOkdiBhgFQr0+YixFQkWEIf
         bYD8oFTkhS58HuFfPLn9H6mX4m0ZZAxM4XzrERkTjpzB3SJLNHOSvSsV8AC/tEppq8Bt
         MGZppWqXbepkL7pMczc33p3cmiQFuRy5MYtLQQte/3bTxKRjI831KG5f3FDqNUryqnyB
         eEKohYIZ4FVRnbdpdXsFLSKFtCHd8jPmqTgGo4qq2x89oY5DmmCjomsXCqHjt6mhmPGl
         Xat49iJQqtdDJ/TsXzGZbMNuKHaq5TRzEMhuqi9PKjPqnxRIxqbDKnE/ZWsFJw1NO6tJ
         UnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184464; x=1794789264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UNI0IawohcjDnjoicCHviRRe2GFEz6OyLASUQR+3Ovw=;
        b=HiZHNabOuOrnyioq7cI4FewiY7QjlvwsRl8M03fyTzf3Goy3JqAAIX+cImZA0XqE+b
         fEjp6Qs38UwcOZDrxcOgL5+KK7+KjycYWmc8AtWS3fXHvjBRT76xfddgxfXDkzh/qVB0
         NuSPXubVHSVMmAsAYzQNLBDcpUqwQfb8lbt6MQeoA80GaRQ2WWTSu/HZm1iVatMEuONH
         CZs7VYTQTogS7Hkqw4SnyO93+CaQiD1TZuSh3UFvpKMpZW7ohuXGUbHZNuSTya3NfcCo
         9651zzDjWz06+MjXzq/o6+in2FQXsYeh41UxfU4Qk8+UfWt5P+h9+hkCxUhzeRE04L9V
         riEg==
X-Forwarded-Encrypted: i=1; AL+hErGyNeVI68VuA6hghGetTJPmErpq6phgjzG5Xygikv0y1atQLyV/oVsV/aowcR3pO4kJFDmozD2MJw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Xb2jt1H73x05+vudjy+mQq+eZqNh4bI9V2v7Yum9X3lIkdbUQ
	hLT3EmU4UGeXFESN7ugaiR70rvs3A1h5FvWL0NMFeTtjwtmW7AzLnE3n
X-Gm-Gg: AYBFou37Ai7YtaRIfxA160OsF1EJ45QgVMxCNH71yMJc9zY/nc+ijP3Bnm4/X07Ae4/
	tPKbaPpFmag3gWKMENevokcwNLtRJUSfBjEFwD/4Bj7/2diHAy0ZUa+paYCEWekL7QP1APUBIk3
	ubiPNbx9jhHwNiDaH8L4hf1KhaaW3jqfsL1PYS18lggd6SBsY236ubCCh4b1bPg2AotaGhaZinL
	6KFF3/XvVt6nWjBLM+iHuz5vkBObv3YIXCUaAmJ/l59nsgYkz4lktFl7IQ6/ifKn5Qb5sfZkosJ
	kOwsxdoNxHhAPjwbQh2a08o7Ft+w0GABSxKBQRGv2RxwZNcERvLrAH5ogW8oP3t64/wBOYOimgt
	3Cky131tjEYmcH4cS0Hx27Ti1gLdSTWHkhOnjcsdLFZK/BqmEmLLynimgJllgl6dPSc3svN3GbW
	SpO9rhcAj0N7lLagmdG70vUU+O58qHrctGKBg5QsqrxzP7yV/+wCrp14B7EWohOrNzbWBmMhkEF
	eU5Fq0A8YFeny0l9Tt3JqcTFKnXzUofmaY1R6sn73nSjm5mEHkJLOxew2MyPsvGw3hNpckOgMAv
	W2G6Ymg2dPIfzbFY2m2VkL3eAWdYbrAGy0pzphoE
X-Received: by 2002:adf:e19e:0:b0:48e:44c7:bf0f with SMTP id ffacd0b85a97d-49588ce1818mr4774036f8f.25.1794184464442;
        Sun, 08 Nov 2026 16:34:24 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:23 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:23 +0000
Subject: [PATCH 11/17] dt-bindings: crypto: qcom,inline-crypto-engine: Add
 Halliday
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
Message-Id: <20261109-halliday-dts-v1-11-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=921;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=LNBr+b73CKCaJq+Lcoy2dBwwEKE3EuPIoRzvD97HKJ8=;
 b=/dOrZ5kbZXiJ0bcfGwkBHl7a+YAKGn1bUTdYux1Y38RVDKws5L13g0SU1+8SFR4l0gLQgTvYS
 wprUB1wAKuOCKc4gs9aCLEB0eoMZXLaWUvR2Qma/3ofWIp9EDkckTFe
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the Inline Crypto Engine on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
index 23bf98c2b9fa..1512fd1d7471 100644
--- a/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml
@@ -14,6 +14,7 @@ properties:
     items:
       - enum:
           - qcom,eliza-inline-crypto-engine
+          - qcom,halliday-inline-crypto-engine
           - qcom,hawi-inline-crypto-engine
           - qcom,kaanapali-inline-crypto-engine
           - qcom,maili-inline-crypto-engine

-- 
2.55.0

