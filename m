Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB398401A0B
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756458; cv=none; b=BfxmHd6/ibp039/NSZ3deM5cfIAp3uQ1cuC5YZlz+ruW1WzLNpCoGeSvSP5bmr9CekWL7JBRwvn6jBgPGM8O3htvpFnhyyZXsQfiqtTK22ct+fL+D6zXXtvvyMgm8j0CIYKkBfoHrHCjWGPRh649Nd0dtu2O0cAcTLLgvTDtaSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756458; c=relaxed/simple;
	bh=VFjZflKqnu0BpKf8BG2jubESZoprxoc4N3cinu0KeQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dCq3MiQ0Z+xFyDeWOL6YnJ16yzwqNoXztKh8QB5s0eLS4jCiw+e0yy/2vAiYKpRYXdZ+MCp3Yyv+4w4vy9J7a6CLpLio3eYqmvJQufUMsjCG6gbKG0SX7+GMZ4sYbR9x/jQV43oWr9n1rjaFb+9rKAMiiispaRFhZ5MFd41FhrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZqbCon5Q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FVXNgi54; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZqbCon5Q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FVXNgi54"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673AdIwc3654508
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 11:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SZ9WcDRxB+6hLaAOmTKCi0wC2McgdhLLRKMxpcdRPgY=; b=ZqbCon5QrXjrON8Z
	Qto9BLWwQyffeSxS3yS9Cfs9kPuB+uve8qhxndCWcLJg1LfkgTRjYrZzwOKUPNVY
	yaYH9bNlPHx6lG68Tnmv1ZcfkiJPUJe5SuW47JbN4VS2LVJMxzoJed0JhJ4kRNsh
	JKrEyGVa0FDMpd3PrEDHOBeA9Ree+YRl5hzWeZnhF8j7nysT6c6j4C4Tkg0dV7Py
	+Zt1DPBe8DrqnPnRjOqD2TmZANvdj0OZXQ/UgcdSGR1puZJB1Ae0eOmhWAO/l2Yx
	0ryYd+8x08bw/I1pxEZQzTpuSFfAgW6bzb/RCz/u6Q7eq8ngPhE3uQKESuSx0UhD
	XL4/JQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhb1b4b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 11:27:36 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cbb20f82a0eso4602282a12.0
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 04:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785756456; x=1786361256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SZ9WcDRxB+6hLaAOmTKCi0wC2McgdhLLRKMxpcdRPgY=;
        b=FVXNgi54QXk0h3N3tkDsXvek9rzvW7e/j7J7Y/wH+islxV0CPm4ts2M1i+54Dqxoee
         M+KvZzZXFIVHkKYTYgSRCXVPmmLWHIThatgqxqIpdxDxdh9blCM0ani9+NRl6ByyC0yk
         ewBCXMTZmzq1qEb5rTA0UmcaUUXctutARfp77SUbyYhMaZ+1xo/b3WMWNthkJv1Om4VU
         sHVXgvEVBGt2+6Br7Hw8mHp/Q1/7TVJ4Yhxkh8lRfQbwCQbY5ftoG0NgT4KDkxkWOVPn
         BRcVQucxAd0iR15/gC8TbuaflAw91gTQ3AZru3jsZ4+917nLYRaOe6C0bjLP50gMM95v
         0xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756456; x=1786361256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SZ9WcDRxB+6hLaAOmTKCi0wC2McgdhLLRKMxpcdRPgY=;
        b=sDVhF+7gvXV/ebL+BPbwGi1FLzJSyeUBdCvjnuyJxwoAVBb5H1tgTz1ddvRsplJ70d
         xF1N7B33rKRzs3jUHb/ws3CVdhZKhtiG0RuGfNQWsxlswBDWjnTwukULccq5s3PJSJ8j
         rz8oSHd1gCf5yk338IPaIflM5jaF0wIRHn6CwddgLeRUg6aLXyj1b5pvWaj2HGAbUJhB
         MvJAIcAU0VM67qNbxx2TtXGCtC2FSqRe+zDyP6M/1/1baNrJpcPhPkvHpPJxMPvWOA3q
         Pg81bn15HWg0YVK6mIkeF3hycrk/ZgV9WLwRgak/DGt+JYoeqZapJz74RE8iH5q16AZO
         QKhQ==
X-Forwarded-Encrypted: i=1; AHgh+RpCQW+eZQZyVZ+i+DJvQITm+MBB32yIxkTQrL38qC4wRyRnZeWgWajxDZz/OvnQRJWV7r3IIP0kNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzRUbMSJO0JgSDL4HfD0nqHuohYFNBwkeUb7jHDLGDJzy6ZiM0T
	VX6mP+Mnf24nyCG+Pr8q72DNPYU570t70ZLKDNvSQvYMIhqXjbSWjYwBfKO0eGJQfeh17liRkSS
	eXQ71QuliAq45RR7qm//dblRn/zENUFrsVtAi0DLahknq1ulhDzsnbNZZ3CC5RQ==
X-Gm-Gg: AR+sD12oYUfmDfb922MUIfsesg1zBAZaIHTAmTbsMRUlxclzbUWDxOMO+m+dBiUOMNu
	O5rS9V2jrOsvxUOfoxVd1Vyo8beKw6JNKxLXLetbZbhKxFnjSmF5Q50qoa1p0x+fr6Jeb0YbgDF
	l8Dvi1RZ9gnEnVMcO+uDP2x60tiGdNWGWUcHIPZGg1SwSqPMz6XzXMDouLIFbC8Kpe2u80f6SRo
	gv1LTCu0ylhqQN5KClCwbc7ObWxUS0NNphXbdKz6E/h0esmAIDrF8CrqHpjG+FQjZfhJo+zZnG6
	u2+ALqCzhz+zUSQ+Gj7WSIKvXUihdz7kGHAUhe/FMs+PZHaunwBUJckaYMCwoPJdXe5ky3BS/x+
	kmiFreft0rjrd7xQ=
X-Received: by 2002:a05:6a21:7d03:b0:3bf:a1e5:ff62 with SMTP id adf61e73a8af0-3c92a812a50mr10080857637.47.1785756455669;
        Mon, 03 Aug 2026 04:27:35 -0700 (PDT)
X-Received: by 2002:a05:6a21:7d03:b0:3bf:a1e5:ff62 with SMTP id adf61e73a8af0-3c92a812a50mr10080817637.47.1785756455217;
        Mon, 03 Aug 2026 04:27:35 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm29967043c88.2.2026.08.03.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:27:34 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:56:37 +0530
Subject: [PATCH RESEND v7 08/10] arm64: dts: qcom: shikra: add WiFi node
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-shikra-dt-m1-v7-8-7fec8e777076@oss.qualcomm.com>
References: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
In-Reply-To: <20260803-shikra-dt-m1-v7-0-7fec8e777076@oss.qualcomm.com>
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
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785756396; l=1908;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=VFjZflKqnu0BpKf8BG2jubESZoprxoc4N3cinu0KeQk=;
 b=0NGDhq/no0QpDZlqvhzA+/KMQcjRX4za9rfdmBUkgfrAHYipdY9+YjaEqXFW1tc0S6UvNMQr0
 0QHHGG+LguLBcUh4RFSnfEfNtefxlbT2bJLDIGp4otfWUulTE+lYbPC
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: qVGuRSR7RpbDXlib1cUdSbkHvQVmr-pp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX59baOCNnKkrf
 LWZYBk70ivqqBxj32rC45OyISQEFuuuq0VSfjSKzYhEu6OFq2fonhFYfwwD1Qbakjo5016xztsb
 Iyz4ekhKEvUbfmYkEDZBI74yA//WQdY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX1X4TYvbRKXTw
 UHFrminWbtAaSfkMokzzNTI6sqkZyZ8QXTnvCLRpkJvGG7jhK+57uM9dBJl7q1VAzPKCunm9dFK
 /tMok1izyLgDHsBSTKV7+uoCvoQheMQvEwZ/5PW62m/vUQmu6+SnAIqDoOiRCTeHWzf4Xy++B2s
 rFERqbjAuXyTpWShsIFw9ksnCWQCnFvyxvg7g5BtDNmw1coRrY1X2bNhfv/HMOX8axjQ/5WWXV+
 miCTEpC9EGNgcOpIPOB9QzVhFiI0XE7ixigO4MaafZ8wpunquFmdSW3NouyyDPwsf2Mpl1l0vHD
 7nzTBTmV7OF4WF+dkrQr7YtJraUw/bO3TzRDD2KIiWi/b8uOYp1gnJKChZloEOF9LXRqIFmAQwQ
 HWAMbagmw5K09MkKiCNA/dGFlf7VRySHjmr/feMFuAoowWiw1oIq10NOGQcWE2Tt4Ul/UDuVqsT
 NQlHKn3teI4gEYn46Rw==
X-Proofpoint-GUID: qVGuRSR7RpbDXlib1cUdSbkHvQVmr-pp
X-Authority-Analysis: v=2.4 cv=bKEm5v+Z c=1 sm=1 tr=0 ts=6a707b28 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=QXJAvSDBUSNnL2LUfNIA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030102

Introduce the WiFi hardware description in shikra.dtsi, including
register space, interrupts, IOMMU configuration and reserved memory.
The node is kept disabled by default and is intended to be enabled
by board-specific device trees.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index fb0391bef460..efb02e8719e9 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2079,6 +2079,29 @@ apps_smmu: iommu@c600000 {
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

