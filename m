Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14F6329E6C
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652251; cv=none; b=TBC7LysVDXokcx3YMrWmozO3AuP1/v89KTMl4/Wvn0Lg+OYZYV+9Pty176wW+ErCUzR52hmc/pgq6dyfUVUlUigfjK8B6YrHPvSCjndLngyBEtEnlq2MjJn6JRjW1e4iK+VgTtHW5NAYabS83dPHDe4eC4X50rIQtStDaf+oSns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652251; c=relaxed/simple;
	bh=QHs53WAmeGFMfxkmSZB5/SkFtyoQnJo08LrqI81uq3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iOzi3H1zbhHweWQGaAK5FfcisEtN462fD6y6Zz6mg0S8Xe+iXl0iWbpVd9CN3A2APY2aRTFkRsWPziiTXSKvtZM4PK0todLBtxIBfXfU8JPNNqR/CBPXMQsrKjaFwe0DCjX9P9KSrcwZr2xyCpq/hQEQW4GkvIZYI1muDcztBT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nu5pLaU3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dmW1C5lq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nu5pLaU3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dmW1C5lq"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OHeXkT217228
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kEUb66gxJlk7bkld/NToFu/2Ms1dKDjAx8+uGsJgYsQ=; b=nu5pLaU3yp0/nJ+W
	7yOSyi4NZY4LbZGLX9RudoyGxCDeA+YYhMFnKCw8uGknpEhg9w0sn9l8wn21NtVX
	IcNwbg90N45DWVyw7ZsviAefX1YI+TUfFXC73zq87JGk3avMEz3QauWN8teQzNid
	A3YW0/omlKXUqn0wLinmngf/5hu3aUYQ5h8qM4w0n95QjqtKXiFcqyXK0vKH7XVV
	F9lr4LUF6LjtXwJb1trza/f/R0TxTMVdBUjgjEfVY8uFlv5SnPdIQfQiCr/PNNAz
	utGySmlkXSS/5no45C739MYadAXnQ2yWzMy42F+DytUQaur+2T9bcCcOX4eovQnx
	3mNNZg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3bvgd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c82c935e048so5655823a12.0
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652248; x=1780257048; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEUb66gxJlk7bkld/NToFu/2Ms1dKDjAx8+uGsJgYsQ=;
        b=dmW1C5lqlMum+k6hDFrQxkr7q3rY4rfJlp+SwweidI17gmLx9YGbpSfDcgafrOw6vJ
         Hf1I26lDpbe/ynlvrr5KNdWDXjBs17b9c9f4E1vgAEO/j4/E+Gnld5GCAQEzCFk3E3MR
         Nn+F+6vu2gD1fYzhLZSNhcNoCCHRnDEbKXDzHhuUO6vrk0Djg5mhnCP6/rr9oPD1Eqi6
         4ztJagTqxm5Q1ps5t7bRxfpcPawPfqmknsUG1u0QMzJhV8lZ7g48BQc/lcn6CQIfs7XU
         qAK54xJUKlcpjqFhGmsGU3VNgaXeY/8v8XIoUflm5TzH1cr2LkCHcF45f7LVe7EzPKBY
         wfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652248; x=1780257048;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kEUb66gxJlk7bkld/NToFu/2Ms1dKDjAx8+uGsJgYsQ=;
        b=UJpxMLWnh6bKLUKLzRK6n3i26dva12RxGATVcLV2hCKpbhYYWndmF1xJtTWKywVoyJ
         1khd7YXvmfBJpCuUDjn9FUs9BsZ2O7hRUpvSfwNVHMSERtrq2zbU9n4W7OE/9kt5tWrS
         UFXY2PkERxUdYOmvTAj2coO7j2u+D7SRmFcRTHdHP0mJjrsJ3pL4Dv3zeVQDTD5fmJxU
         zM62MWLBvNHwpRr6e4Ch7w4Ly3rDaf26auBknAkwzzIJwfaEmOJMPVZtm/wDn7kMQe1x
         WUcXgU2XQYOaqbW8jS5uvpIE/ZIsAK5PONA72tueFbDkdQYiscPPY4bJo1zd5Ua45GEP
         Rbag==
X-Forwarded-Encrypted: i=1; AFNElJ93hqSvEKl+JNFPFYK1Aju/GlcYvFMSd+7p9qj1t2KoP8y5aocq2wlx3ccl2BXwxHa8JAZPV+7eHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQP8ycj7Kxp7wdaxMlVd43E3So0+WCelpCzqrgNpK7Gy9z0KRN
	MQn2VBETm4rwQ+WYZZ3/gtNiCxGyOt9lxDtjNQKJ3FRS5RHIwU/njW62y9AlG8gz2uqYa/5jd32
	4ERi8pkJ2QUk2FDxVCWPiJPFYFOhB9ZJlIlCtIwl+1G23FPb6XBP0EIu0QP/73Q==
X-Gm-Gg: Acq92OE8pJ7yS/zwBNvTZ7+/b39x7jq5b+vJAuZqlXHtuEOyXiSXgu7Uo9tB1TFnPft
	Or6zVc/5f8tsu3+7Dcl00wlwNwKON7D/5L7KrN+hjQ/A8m+RH1jypP7DozafZXTOywmTq88lfuZ
	jFHbk6upSrInUXaeOWqN8zA+ieVkFItIciDI38vuwMnujDSLMB3wA/LI0LjDCvNHZNz6LwaqyUk
	YfbHCrpll95i9vc0IlQg8Zs8jxsi4FYeHtPYWDWzV0NAdqaNLzUMOdPAqjj0azOfIwYXFitDM+Y
	QfcaHbluVUoGwVZZeXZlrGW5l9ak5DX5kKPgv00Jv/g1MNMAnN0wcd6TU2mMwcZhOfa6ab4DJP5
	YciGpSv6QWjkzcPUUDsBnM7wiuZcNnbIffRve
X-Received: by 2002:a17:90b:1d44:b0:369:7944:d723 with SMTP id 98e67ed59e1d1-36a6bb5a6bfmr8169648a91.4.1779652248335;
        Sun, 24 May 2026 12:50:48 -0700 (PDT)
X-Received: by 2002:a17:90b:1d44:b0:369:7944:d723 with SMTP id 98e67ed59e1d1-36a6bb5a6bfmr8169634a91.4.1779652247865;
        Sun, 24 May 2026 12:50:47 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:47 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:19 +0530
Subject: [PATCH 15/16] arm64: dts: qcom: shikra: add WiFi node support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-15-f51a9838dbaa@oss.qualcomm.com>
References: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
In-Reply-To: <20260525-shikra-dt-m1-v1-0-f51a9838dbaa@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1721;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=lmXTT1nlWiT0OHoqXSzRACrqa8lWFzuUSv43JPEixBQ=;
 b=WjkSsJ7S+eElgpBj6JCE03TqhmeeNHI/Z8Wif2z1S/SIogfB/do6Q61Y0ncIyB80iu/oJxFHw
 4NAlgJz+UEyAWUbpj5kqSRTLhyxupZ5odlJv1Nns4/V1vZlm8LiQfWt
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: zBXFeKRZXp9b-YFZ26qbYiF_rUl98ZaM
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a135699 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=QXJAvSDBUSNnL2LUfNIA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfX8DHwdT4EtAvN
 MH1CGbM+zM8s9EnhSnFwIyFYn3WpyiA3U3SoY6rKKmqZeuM3DlJ0/6rMa4sgj8kMY2ff0RPG6HZ
 Fp2WQqkOu/PpEtBoCTdm+PrlcKcrTPweuJsfvwSiQjFhOtxfNDOW1m1vYvbmiYcqdUIpwvA7Rtp
 BfOiw2yfjlqijCyChJfyQd7zbQE7Kv/1jfr3l87kluXaKeombWoUjaeCFYNI9p+zQvrM7/PN+Mf
 H707zy4KdT6+nh8NWH+o7dmAnGvQVBVCYoIK1k8xhVwrKn7uNp1KR7Ra+ODxhI774Vm84lRFMhe
 vdakhcHOTCONAbRE/NHBkL+VCNn7dHoFgMDTWunUEPvWADs/Y1d5ool4AY531vIX0gUVi1bVtGH
 8suI76DvJ+gKsJ2cNRgf0RI8L5XoNNQvHgfLcfkEgpXnoYC0Xi10DA6jc0QN02Oxy+Y5wtM8kY7
 rRSlEmUyag+y3xfZ05A==
X-Proofpoint-GUID: zBXFeKRZXp9b-YFZ26qbYiF_rUl98ZaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198

From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Introduce the WiFi hardware description in shikra.dtsi, including
register space, interrupts, IOMMU configuration and reserved memory.
The node is kept disabled by default and is intended to be enabled
by board-specific device trees.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 73681bf0e3ea..33feb6d3f73b 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2070,6 +2070,29 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0 0x0c800000 0x0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&apps_smmu 0x1a0 0x1>;
+			qcom,msa-fixed-perm;
+
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf200000 0x0 0x10000>,

-- 
2.34.1

