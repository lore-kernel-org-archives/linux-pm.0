Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184486;
	b=c0UV1JeS1hGUM2ZVi526JyYXDkLMEaZUgMfvlTOCago1VQBbIVJETCDNnLyja9Tia2gL
	 gVOn1o7/XL2Z9RXNDTKBy/C+yWCDeKYYvnKKzChJOeT55YxZ/LI3FMzNNJHAYgsOr+G0c
	 Nc3eoHGDI3KJPPkVJnxxUbVrFGl0qbdKBHdieVs0TS5rE8y44Rfm3fL4nWAkQKGhxhuSK
	 mQZbe3TUQabynKhgSutqACwC1zq5p0Tv3i0r3Tbktf5/SdNaKcbT22+Tz+CP4rsBFXguO
	 dxl2WrggPTxn0PLH/TLitB6E4QLwZgtybrsgTM9YyG2MZjp0zJiVp+nyk8pWXhNS1SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=RVY15LYwgm0Qc/TTM/+0NaikfZtjUT6nkNDgccuwjcg=;
	b=0iMpF92w6zl0wJSJQY8Jw0Zgdq7NM5BnJTOvnTRd8sOt9o+bYuVpMEl6RmVF3bTUijs3
	 oe3OnAyJyxypEXrfHytQTpIdKC1OhNzYWl+hx8F+YpP9UjO+JjGN593TMGjm3UMpXTeLi
	 1Q/j+slO3uTyTpumUAx6FSt9Y8s8pQ7LsYk/Ulsp1E9OqzGDhclLt3bC61aYbO0JYaRJJ
	 SHpZdHCfxjL7FpuSjsLHWoj9ON0QMnWOP2QdbobZrFVsw7uNykxmrm3awun8AX71/hzXq
	 xqPRjNFIXMdRpzJHCzBVQtkjfmer3q4Iu7SWnk1Slq7CwowKpu61ScRlrRvo3PSB8jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ar0o+lOa;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE660A2624
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BDE660A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ar0o+lOa
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-491aaed7565so189479f8f.2
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184485; x=1794789285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RVY15LYwgm0Qc/TTM/+0NaikfZtjUT6nkNDgccuwjcg=;
        b=Ar0o+lOaLQ36hMaSQhz240QICDkzMHtmQDPTHSSCzgvKoRRu6+3NEyf5r8UGihmdVO
         YbL8kGYlIwYFzt0m+P3LcvsNsXWFp1DnoXb2XeAAeHKjD0e3mSdbFDeNhE2C064eHQKn
         FBw+L6yYJJRGThN5FTZYemlT04n3GfqgGq87rIHUjOJoGNcaF4/DfTtKARyZDeZ/xjrR
         b2ektKO2o/QtZcCAYpaDtUDybpL+f8B/n0nKzY3lo3ZuY+C94fC/nTZn1362e+1nZpVD
         khlpFRfxsUKvqLFNzImO1bvZjdT7ysUCEMcuRxy31zGl1OqROACCKC3fKd/G1KVQ4t4X
         QYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184485; x=1794789285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RVY15LYwgm0Qc/TTM/+0NaikfZtjUT6nkNDgccuwjcg=;
        b=CwaYwtVDBuEAMsnJHI2ZDRVcXoGRus8yksl+vAaeK2jtScrmu+4sXDwVxupiILWGya
         dbVPp04iZmJX/OzXK6Xfd4jbjv/6x+cl2rqh7HVSfbk2UEc/qdAt/SrAeuIQIl1s/XAs
         yt1tEzc7tbPJiotG0dRm9yZ/pK7P340KXxl4GCYSpGcRdZEX77Wl9EIRgR+8wd9mGEfX
         g3yvdn25EUP3v1lOjF25UC9Z/AaRWs0FPvbHa2bQCLR6ZOIF6TN1T6vvg0ZqPBvuXvFr
         9R0IhnxOuqJpXi5NpH8DZMHIxS6uz56ZeENNwYkVb/ispLsO4xdF/KjPhBsIQaaQjPvS
         Nsrg==
X-Forwarded-Encrypted: i=1; AL+hErGN+ASxt+UdZrwdwCuINm4jb1OdX7wjswN/d0OWMMctcA7g7b6bTEq3XGp6t2PXgvL9TCvuMuaqIw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+y3aMYfwX9PNjgbJw3eYJLzicpCcyhmwz9tA9CY+HnBXGZErbo
	ZnKUzR/fWoV62r0i7xe3VHk7diozOQoVcbeHNr9bV1g563lwZoxSP5wG
X-Gm-Gg: AYBFou2DDTVdrkphJ/zLM4a1sZltLyJ5j/ZwUlMn6HLDTByfwkEFa5ZF5ZsZMUuBEHW
	G+D9FmOGNRwmms7NglrRtfmK7uPwJRijXDSxNCLN28C8Nqpa3l9UTtLNGhIfzm3Ot6pz7KeFJ3X
	KxE0w7Mjz2xpdw9U3e9+X11Xyua2B0CZ4uk4qIixoDpDZkWvqmMU1lv5VtdJ2ufXCLhzOOfP6Rd
	BsqEBw0QuB3BwBGN+SfFqJIXyEuGf6widrSAM33j3DtyGBSo6OSHzPU++Tg/t3m0pWMYoZyEu4W
	bo0uN/ORl0hsVULaHLUy/gEkWz3wUstJ4ho+P3qbplECXBWl1Dx1klrrsF5uXHwZ8AmchKnM795
	24bLAVN2S4aYHHVGZIgObk450HCp5qgVl4+YYEgd3+IVfjMvzYefaJYmbI1wRFr0oukN4WB07uO
	TFkXHCkDqX6tGuvLI2kueI8Xiq+SkjLq3hKYoHo6B2ZQAPpdFlol3T+oStiPcIm7OjHDVjaK+4N
	dVDxMXRUjaWZ93VB/xSaKGlTnIa7ZZo3FRwESetvdz5GuuyhvLJOU7wdm3es+8ASX7+vQP9outi
	SEmPzlI4gVdRUO+xRFQg5gfSlb79eDRYri7AF2Om
X-Received: by 2002:a05:6000:481a:b0:48e:62a9:1a65 with SMTP id ffacd0b85a97d-49584690551mr4596063f8f.49.1794184484831;
        Sun, 08 Nov 2026 16:34:44 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:43 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:26 +0000
Subject: [PATCH 14/17] dt-bindings: interconnect: OSM L3: Add Halliday EPSS
 L3 compatible
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
Message-Id: <20261109-halliday-dts-v1-14-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=844;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=gWRtexQl3K6zrJ8s8OX25X6Fe6c5gXvBp3k5tSGU4UU=;
 b=pnbK9TbDaJw63lMsp+XBx3cpAT1m6LlRO8M5pm7At3undTaYtmQjFmjLHcmBIU0XLq40cIoX8
 jdWhe4OxgWuCqPNlp+TJGp7ld3LSdzNJFNkDbr6brDzv5M8VXRxZg8B
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the EPSS L3 interconnect on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index cd6685683bab..6c3475005a35 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -31,6 +31,7 @@ properties:
       - items:
           - enum:
               - qcom,eliza-epss-l3
+              - qcom,halliday-epss-l3
               - qcom,milos-epss-l3
               - qcom,sa8775p-epss-l3
               - qcom,sc7280-epss-l3

-- 
2.55.0

