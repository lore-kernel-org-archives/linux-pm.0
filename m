Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184439;
	b=B/pCoFH5bIg7zrRHyrpz8ZMOogLS8yzs0gDtGJCFpktKzBRBcthLDbIrldw/HdRe0nei
	 26rUJguYbap7+abF6TELGBSZzoGJ3004PVVyo8/nlmlpV1tX/7riqB7nvI/gltXkaRB0c
	 rRD42D7XO2SNrC1PyFCSHcMo5TUR/KS/8+yaHXhLAb9Dydr/o3FTRlK4+BZb+Q0c6+Q0E
	 wx3zZthrLFay5DILyZyOzCKEVPgQTxZZ3B873LdGwoTYE5Rn6IqAqIW+2vZXBGQR/s7y0
	 Jydu4cYxBM/R3DF5Z8SW+Fo2xerELtfx/SvMwVm8TR+i8wfbHvyyZrLHGC9NOiut+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184439;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
	b=K8Tpd1HzH7zA4AfiKp996O47yZkiyDeVTLQCQ74FZ7kB5+xBTGr4jN1AS9sjl5SwONyU
	 Vd7AT8yhZguqARkchG4bQpRwsMs5DyqPpkcHM4Q68r7bHvMVnfu9K/llZP2M2uugZdFYZ
	 831IwuPMnZg71dxN9FFaNT+XO188aCni9Jt/8eF7qzcNmrgDuHyKawPzeB8javx1BV0h6
	 +OYevQ3y8WlLc+JuqUn5hysPj9UsOerCo78LwIotJuoAn9q/N+ZxkWwJVPNSjOG3QZskA
	 bOh35attpaiAjFrulSCqRU//YSz4a6WBl4W9EfFuiThNTwaKUOeirPSvmzEIn+hyvuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mqATGSDg;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5936082BCB
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE5936082BCB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mqATGSDg
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4910b863b84so218753f8f.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184430; x=1794789230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
        b=mqATGSDgOcyspCGm0r88zz2LKvOBuTSrflTy4G3x+OmZ3/e6m92wx8lwDFbkWU/2r7
         wF4RvcborS48J1HQFsH7E7pQgiQNwsPdfK59/AT1PhF1G8mvFKr+CfuUUZqZjulYaEup
         ouJz/e8/k/DLsRowKga8BFqAZDnPgMt29Cmqfeh1kSkF5wRiiYm0/AlufG1QlkuycLwj
         rEpBeHEkXJziqZintgY94/c64b0LNVR31luc5/F2R95zuMihuSOw0tSRvV08J2itGF5Q
         e6yNkFjWR7cidQVwBnB5dheZp9Tw2HuJb8BECeTsjwwMmrbGM5Ib9dRsZdyiCb151RhX
         5M/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184430; x=1794789230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
        b=fbvZfZyKBxR1jIGcGGatj/JJlQObsbUhHmYveDV9bCgZEBCMcAz06LRpOC31078mrQ
         p8U072vE9vxrUVSuzOEsDLZJCdNWqcvXQt/Avg7mK53OGjHyug1btwul8YQAY/qt2Rdg
         0uAtOhZDzXj2W3jjGq6O0h8r0t88YCLnl/7fN3YJJhGETCSPAVoxzZZD/cBQeK+w2dsS
         LAznWBCBIw7k4az/hYXWPEEe4euVbAKMSxb276OmHDCk0JIE3nVdqZ8qUg1tsb19zjlq
         Ca1b5z3OATWumEri4LHniAVE0NW1YWy2M4mMbcM/N6N5lyc2xnfktOh3zEhmN6hgmmHw
         ET8g==
X-Forwarded-Encrypted: i=1; AL+hErGKvzDTyDBHvscvO4k9/vhvM4IcchgO2nVjHb+p/5bKJ2m9miNzGnltjYQi8K1OF+XG1jT1qb1GXQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+F9XX2dUpgEBMqA2pqfPLwMNVWT/TFfW/84zOG+LX0u52OAwl6
	tA1VKu/yx35i7iUJ9A+UojAxCk09tfMFrylw2TCnN51zFw5Y7+xtcFRW
X-Gm-Gg: AYBFou0U/HqYBaB5qGNjxepc5d3BzIyjqYpl8+26eaQo6Noruffdy0gFvepdYLI3N5+
	u/eV5ZhoWx48hXdbK/twwqBEdZBVnDkgPdRDH5jdtMV9FssmoLTG51ueLqIGGkooF0TVNc+CTlK
	yBMoBIv5iX6uwvD56A/T9XrYH/bPvukePca+CDBbBzQEh86uLAbNmtaSsOvH+77mL3ejbVK6dk0
	l0Sm035fYxDMbYSvZh5UPEUvBmpw7EMd0qVyQmm4ZYRwMFXYQeLiKgC2et8od9rhp6riH4Esupq
	lRuq7qOOaAysKJy+j+Df4jTeaQ+QarBRiTl0bFRnhDRmlNEyeGCikS2BE6L3lSDLojqHixHP8iA
	/I8l7zw6gRApEYUs4H6pzbS1/oOWlaELLAGZwqus0pBpPhA/NztVcF1MgECCH99pNo0tdP/uSWS
	UD1g4wxPOuXavwzvDrfFgUcK+Tx1WXzCwUnMCG39jpVBJICDqvAR4ij55qgf8+PHf74/+wAY40w
	KRzJE3i16VJrGuOLdwvqNlhRYIn1y4B11oVJwCfothB5irWW+FuxqoEsu1p+xK+sHLDC2j9vStI
	MHW3XF58SycGgpD6by2En2u2CcmVHRk/awjtUtlh
X-Received: by 2002:a7b:c34c:0:b0:4a5:9224:fa10 with SMTP id 5b1f17b1804b1-4b8205a7b74mr74612065e9.18.1794184430004;
        Sun, 08 Nov 2026 16:33:50 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:49 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:17 +0000
Subject: [PATCH 05/17] dt-bindings: mfd: qcom,tcsr: Add Halliday TCSR
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
Message-Id: <20261109-halliday-dts-v1-5-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=720;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=sz0jgm6yJ2qfmdfMMgsqR7Wg9ExS4UZymLewfvVCvH0=;
 b=uUjeKsqz31kCcfPZSa8Z47M4B7r1CADYAoSad8joeZDRvAbLwLDkhf9ZDymLvxVoerAVE+UqI
 g/farVtv7C7AYkuFx6U6v9lz+2+4yx0RS/OmA8jjU0ljraJ4I1qJLhy
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the TCSR block on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index a021e4dea486..e8a681b5e6ad 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,halliday-tcsr
           - qcom,hawi-tcsr
           - qcom,maili-tcsr
           - qcom,msm8976-tcsr

-- 
2.55.0

