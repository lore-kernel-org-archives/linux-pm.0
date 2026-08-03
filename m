Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF8B3FFFB8
	for <linux-pm@vger.kernel.org>; Mon,  3 Aug 2026 11:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756420; cv=none; b=GJLjeRNHR+M2N46BxWdlA9AyNC26w6o6fiiEJsnqdxoSeHXtEmju9ci7wsCo1WNVwhYG9mzoevY6Q1YzuuXJf2bF3BZe4SsP18t6J3KHAk2dm4p/6OB6g7pROG5gZbJP8O1XHtxcVjjcjfcAHYwVbNiEkw+EywsPF+L9eYmWFjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756420; c=relaxed/simple;
	bh=0a3uerDoKfrZB5Tgg1SL1456Y9kzs8qRPFGqjo7ixqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqB5ZTXga5ARGHFYviqnEVf7ojPc59Hx8Vw8DFvSFvbacjLfNnu55tmhX8FKf5SY4eTpVNWA09h32K31v4HToO4qC5fP49Igrp/uSnMDfT1AHCn1b/geZh2w4KIWz27Zj+aJH3EeIbp2yJoznxKQzC59NfUcCRIA4LYq3wC7L3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pa0nX1qA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dppQrARD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pa0nX1qA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dppQrARD"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673B1PXw3759015
	for <linux-pm@vger.kernel.org>; Mon, 3 Aug 2026 11:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ffuPqBu/8rOZlIBTdR+zrCKZDd8+D1tKgdvy/Qrqixw=; b=pa0nX1qAoIHwAdgs
	jeWXUtX/1JVxyT184bdEohWIoGSWH8dmNbLgGmtjhbyRWsgiu+cCP5RpGCVDtm8r
	9zHcCYUQizPcz/StLbGBdlwZGC1GNiz/epd636aHfkqSg0hh1fzxKPr0G4hL74aK
	9xJJYt2gMO0wXKd/EPOQn77SS7Mcjc9zwanJeGB9LWWSz9aKlyd2HURPfUUqLQpp
	LSnG4GQD1/gYk6Z7tUB5KaM4hRXypdgSB5W9B2Ta9qriXo9rCRdz5if3JeZvxfoC
	t+yOk8Jcwb1/SIhn2iySnzmf/I98c8PTVFX2HPXh7lm9lvG71t2VKUdRaHaXE3tl
	MbMbKw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnrns8e0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 11:26:58 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso4065619a12.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Aug 2026 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785756418; x=1786361218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffuPqBu/8rOZlIBTdR+zrCKZDd8+D1tKgdvy/Qrqixw=;
        b=dppQrARDMy3lgFxDXSIVeTYaoq34AIXox43IbwsZ1MIoxC3BwAu5tQYsVvoIrQOCei
         hRmsepo+CFBoYepkgww8TNl/quZEUtkbxU3sZj9ocCHgsmsVaj+LyklBdnV0nFXfsCXn
         wgpj/0jJKK+u/rs1FvXVYKgTFgloeObCezmBMhgHhq1pwApx1KznRjzz4YzJOgbZNf9u
         NvE+s4NxyUkApUW2cR5S7C2YZjhIASOZNQUBBJ/zDLK91je/V75KpUYSsoqhUvfJf/9L
         IWT3wbz8fGFG4YaLkH+vUD66TK04WwkLDUIiFXuOcX5O3rKqSJ2Nm40fWDNwaCzH2vej
         N2fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756418; x=1786361218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffuPqBu/8rOZlIBTdR+zrCKZDd8+D1tKgdvy/Qrqixw=;
        b=UvnUIagUm8EknZCFIrxdkgx2HzZDx8M5GR9ue4PI8B7TLMqf8cM/70giI9MZOKTvma
         M1QbRTZv3M1WmowpgLDBkU5Uw0cPBbPgbo8XfhaAEeG6Rm4s7P6MFiyQA+kh4aDNHZdY
         nHnqKajN+2KyP23G9NyZwvukqtCCexO9TWm/8P5DsO6HDK0BPX6A/EgtiwM7GsKk3NYe
         SVOzE8uxlfo3B7cQcauJRoRgDMnV1s5kXbG9zV5Jzh/17JyUWCgGUCBPTQ22e7a4x4Vk
         /T5hIVKuJrzhFBJYE54xGW29/1QUI+dSruRwCbi5FfMtcm/CeUQsPjN0bxp3+Im8p6Sr
         gORA==
X-Forwarded-Encrypted: i=1; AHgh+RrmsAtz/U/TqwteaZlv2iGRpjmHmXDfD0X+apYaHxgNbXvzSgK1wRPm7grq3pVuX3Ar9VZoJBxI8w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl97LGQskOOfqn7oH3gdiJsWrk6pj85iEkecXqXCaYU25cOUJy
	WXfYBrYFdY/DOF+kli3VPYn3aB90i+eEvSRg7SloSH6bOs5bEL56zPMLkLu+w1XbGVZkp/Pa9jk
	8ixWmVIGW4bmeEJRR/3mvNw0HHZ01T6QDBvl2sui8Lcd9S3Uc0WNzdNpYNeyX6g==
X-Gm-Gg: AR+sD11Fa8aeO8DNlgsR4oxdQ1AZ0XsiOz40UCKEeE+my3R1CZMnBTASGAahLsvSCu4
	aJM+mLOqljMvtwSVKHWkyJ7rOnPjNw7ciIPSs573XViStPCdTQqFA6qoWPMWWFfc163m+8aR/rh
	9anUDiPgdD+KST5y3r5Skdt0LzAcEXinbj+VuomYie5X1C52CqfIbF6YPRznajoEYleXzbsvx4o
	QJbbaaOErjj6XF64vwykHxqWqFmdZRq4PJ6Lb8hvQln7fn+ROXHT9LMauM5BsQu3jIUYPVzGqh2
	+sDW1B297lfw7hGNQedKpvXD6S/QIfyC7DYTFk31lNqK7TZY1NnHTolSWGKZ9X3KVaOcVPRtLfU
	TDwzKWNye5+LXAMg=
X-Received: by 2002:a05:6a21:700c:b0:3bc:5284:4859 with SMTP id adf61e73a8af0-3c92a4d745cmr10759387637.13.1785756417795;
        Mon, 03 Aug 2026 04:26:57 -0700 (PDT)
X-Received: by 2002:a05:6a21:700c:b0:3bc:5284:4859 with SMTP id adf61e73a8af0-3c92a4d745cmr10759334637.13.1785756417321;
        Mon, 03 Aug 2026 04:26:57 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab132cc4sm29967043c88.2.2026.08.03.04.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:26:56 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:56:31 +0530
Subject: [PATCH RESEND v7 02/10] arm64: dts: qcom: shikra: Add DDR BWMON
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-shikra-dt-m1-v7-2-7fec8e777076@oss.qualcomm.com>
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
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785756396; l=1830;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=8WD7UGaCwVkw3Upd7Ap0jqc5HPYHE5cv7U3GK0CZTC8=;
 b=izsG5CdKYvEevD+LzcwtWMgMtv5Tx/1Sff1dK9BVpN9z4ah/0KkRwSykRqKB7R0d+rvl1xjjT
 3f3Jr8TYal1Dr+z3sJW7efjU/vR3lxtG+S1NXJvyMkoWhvuOKN9GaLM
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX4s7HoOoNEdXE
 AcqR3bYR/LcL8M1oecuPjIt3ysMZqjZ37IQ0EIzRwlS3keZIVtjmerASKIgNTyxbIZ1Eve0itHR
 UH3krXLiGIE1hYvaT4aIB2/gjhrfunM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDEwMiBTYWx0ZWRfX/UU9f9klr/80
 I/qysH4EMcKjo4w9ObhKt5zEd+ZMCIp2dTXLNHOrANR1O8uG13sVpl8sb2wM1G3HlIJdL/+U0gZ
 /N3CMPiQGWPFRRWZlG+gX/2ya+tn+gNDBITPy+Qz/AW7smGY3Lpk4kSzdcbkYN/VvxA8Dfa5nVT
 ZZRZ/xbvjbwD4ZYTlRsAgxbsC3eAcZts42UeeJ63xzIsq6R5z3WsrYiUDaDXEJe0lXItSA3UqwQ
 eEX+fejqQ1Sausdtlo80ZDQG2hL23HjhlVaG/t+MNeWsmchA6nwfvCWl9OCgkNID6oDozQgMqWL
 s+5Tsb33FR2jvAKMuJyqlhh6LLADNq0r6VFqdbQCCRzcS6qsyHFoy36YRcxEhDkDTSnbDzn6WY4
 Lh2hgIRAIn3moBR+teXeLCCss4yZASe0aMx4mOYxcTgVW/6M3TGrSpB4Z2A+VF1d6C1Q1Gi7hsH
 8Jn43fUpDJVpqH+X7CA==
X-Authority-Analysis: v=2.4 cv=Zest8MVA c=1 sm=1 tr=0 ts=6a707b02 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=iYP2JlN40lpobhLRj-8A:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: zoNMrvLS2W6CcjYEjGJqKuCxbydaz6rr
X-Proofpoint-ORIG-GUID: zoNMrvLS2W6CcjYEjGJqKuCxbydaz6rr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030102

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add CPU-to-DDR BWMON nodes and their corresponding opp tables for
Shikra SoC. This is necessary to enable power management and optimize
system performance from the perspective of dynamically changing DDR
frequencies.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 524c88615d08..3582352dcff7 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -661,6 +661,46 @@ rclk-pins {
 			};
 		};
 
+		pmu@c91000 {
+			compatible = "qcom,shikra-cpu-bwmon", "qcom,sc7280-llcc-bwmon";
+			reg = <0x0 0x00c91000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			interconnects = <&mem_noc MASTER_AMPSS_M0 RPM_ACTIVE_TAG
+					 &mc_virt SLAVE_EBI_CH0 RPM_ACTIVE_TAG>;
+
+			operating-points-v2 = <&cpu_bwmon_opp_table>;
+
+			cpu_bwmon_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-0 {
+					opp-peak-kBps = <1200000>;
+				};
+
+				opp-1 {
+					opp-peak-kBps = <2188000>;
+				};
+
+				opp-2 {
+					opp-peak-kBps = <3072000>;
+				};
+
+				opp-3 {
+					opp-peak-kBps = <4068000>;
+				};
+
+				opp-4 {
+					opp-peak-kBps = <6220000>;
+				};
+
+				opp-5 {
+					opp-peak-kBps = <7216000>;
+				};
+			};
+		};
+
 		mem_noc: interconnect@d00000 {
 			compatible = "qcom,shikra-mem-noc-core";
 			reg = <0x0 0x00d00000 0x0 0x43080>;

-- 
2.34.1

