Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288344AEBD4
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214212; cv=none; b=YXMyrBpm57xGFDFcrrxfrlj3Zl5PceXOJzo4aBWuXqmDRAMPOyiA7d60jlVYXRifzjbTQED/b08L1eaq0d3o6EHBoI9Scmc9lZ5RLjWOiFyAm0cl6NQOkJtj1DSDDH0pSW8cWZhsjJw62S2p19t9uFbDjY5Bh6086jF93IYhBfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214212; c=relaxed/simple;
	bh=QDTDqAg/tCq8IxKIyc6SEdBw2tY1qPENGerQu3kSrA4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bgRD2Vh7eqzLtmUrBTcXQc9sFwdknE+9bwULRlh6Vh7gpx4PT6dMh+XSfY19kXDFz0LNykr4KFe8+ed7z+LxN9+vEmMcZmCvOLWRbt5cJSCeWh4Egn06V9/OwgkmyBYO333YXYJOYuGvLTdLFzOgQGjh6vRJ/zeBEfGz8hX+mIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NLbvdg/s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WjJ5Rexg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NLbvdg/s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WjJ5Rexg"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695EP4UA1358655
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 15:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	n6/EPwoALiphdUI4x8Ok7eZgmoLur5fH/prziCvkMZo=; b=NLbvdg/sb4I+GhIK
	bz4aOkJ/XCt/mjbv3ejZzZa53OgZRSoO0kDEWSvI3mYzGFusA8L3ybf9KYh/BGhM
	qmEgMeBTLiWooYWmIg8WhYuWmA6IdujayBT99ITZI82moj09KWLTulc+lnb6ecDQ
	4btQ8NbdWZzQ/t9jNL52LL5gRnTIVmUKI3FvpKJGrfQ4azdVufbfNnpi7nLFkXfd
	lkZ4QgiaSOF7cpfRL5aUBdyTzpx1FjKGkHUayCqHRMMv6qiaDtpz7YRTScZ82ws+
	MOTniLnCOuBmQIq0GTKUdf3dymOHS59eIFIXzCLlb73C315bBEAIj6LgnuIqXuWz
	tkTyVA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4cvngf7u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 15:30:10 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8881a7875e5so1326643b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 08:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791214210; x=1791819010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n6/EPwoALiphdUI4x8Ok7eZgmoLur5fH/prziCvkMZo=;
        b=WjJ5RexgCypKWw1X0SeCBWIe9bSDXYnydPN2Tl6QWB6V9sPz2hg8tS2RF/ry9/iabp
         He2QcuaDKommG8FhK/8aQhYz2GIoK7KPjxfKGNjqCMFUFF9wCdnhwkbLsjwYZTk0kMHR
         cPgpm5UOErpfOE8DBRINSAdl+tG4tQVEgp9i7Caax5kYrXZROZHhwybf6SLunZh77dbB
         TJm6n0dcbjNtpl+pSbMdjzRzjsllfBjMr7hAf3JcKTiW4IYBoIdXcW0YvcQEu9skVEUP
         0p9FdP89ZGxhgQsSqeWbKq84F8CQ8ZwamhZl9hEE/Gj4/Eg6VPhXJ5rW7FMZre4Bu8CQ
         UUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791214210; x=1791819010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n6/EPwoALiphdUI4x8Ok7eZgmoLur5fH/prziCvkMZo=;
        b=QAxG8xvQi2djASaIbkOxIeyRwerL5a4tHvL4Fu+QnjojzPWhh13uLwYi18BBu5gSh0
         fMyMO/guOK/2ARMkxzwxrQuGDtEDZeRC7Vt7w9GHkOEecjsAPdYE7AXyQzrgnJrCrYmz
         R/5Uwb6MPk038kbNoPdIcsRiEdJAKNMd4C0lgCzVLClm/Q10uGBVwgVvLMXqLY7Nqyzv
         UzM9RhjWxE0zFx5bnrc8yPOt17n0CqgamIs5mQLFRTPRfjbwL8eXWuDfj4RjhCRSZzyH
         HOPndTN/JkohjBz9tCtLcqQ3jCDR43RS0NZhf4HzuqTInSQp4TdlHQhbStEnpmm6WWDj
         ZNyA==
X-Forwarded-Encrypted: i=1; AKwUvBywVVCINV3M88OADL1bt52aHBsRP9fei0OyUe7GaPeHstu/aGMvObcAcIyjzMfWSPOhLX1JGRgfrg==@vger.kernel.org
X-Gm-Message-State: AFuF++kpOs0uYpF8RDgmB1+lPw8BveXmJtiGtIJUa31Ge8sqN66pjJ0t
	TjOWKmBXBSip7pnjXIPWZiE8tQ00aF4J6oBPfgwFZ68gfh8AiZnmS9ZdxQaZ5E61wQeaCaxEvaQ
	nvsq/9gfQYU8ltMNfcSoY/pdeGiXjFOwfhQGTDhkmj74GdvTZmQOLy2ogQmkd9Q==
X-Gm-Gg: AYBFou1pm9hA2QPnZMewiQyc3OJvKlxcp1DQwYsI8lgICmuI3OajFsve+BffQIa124E
	e2LHJVgVJhXP5iGKXB2X7nffe7RnTLN8jXvfHXh+SfGooH3PcNYdwkXTrWb+vMhsZFroxyzxlgG
	YmoX2KQPPmS66nzbzd/ia6ewfZzdXbuLD/UZte2GRI8oLK9h3sD5yBbPu2YWDP+Duf9rB1g8Rns
	Q/Fppx2ohPj60RvC0JVPSO0LUoi10I4HtW3Fkcar0jjU0nTE+bES1xIsh2I4QjxNLVM4wntXq7S
	r1fYcPLfQp+dX5F0r8l616a63Sy4g1XY+ttXEdbXwxx4llvH0nnaAyDT4WyHuTcyLt1+rDGFX0P
	yYcIey2V0npHfCpxM4iurfCdsGbv/
X-Received: by 2002:a05:6a00:3e1a:b0:881:d48e:713c with SMTP id d2e1a72fcca58-88af76cd0f0mr9426415b3a.40.1791214209515;
        Mon, 05 Oct 2026 08:30:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e1a:b0:881:d48e:713c with SMTP id d2e1a72fcca58-88af76cd0f0mr9426370b3a.40.1791214209002;
        Mon, 05 Oct 2026 08:30:09 -0700 (PDT)
Received: from hu-mkshah-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c792ce7sm3681528b3a.41.2026.10.05.08.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:30:08 -0700 (PDT)
From: Maulik Shah <maulik.shah@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 20:59:44 +0530
Subject: [PATCH 3/3] arm64: dts: qcom: monaco-evk: Add suspend-only power
 collapse state
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s2idle_state-v1-3-3c402c66f388@oss.qualcomm.com>
References: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
In-Reply-To: <20261005-s2idle_state-v1-0-3c402c66f388@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <maulik.shah@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791214188; l=1489;
 i=maulik.shah@oss.qualcomm.com; s=20240109; h=from:subject:message-id;
 bh=QDTDqAg/tCq8IxKIyc6SEdBw2tY1qPENGerQu3kSrA4=;
 b=7WNzI0l2tQ7h/frVTDk5ybc/Ck2QTW6pUvVS7UKErAsTO0194Yw8I6I0qxC9dhaAqHug40Wip
 0tPasdOOjwyDRmaShvQmC33IHokcIemcgocBqlZvsmaN915o85Xqhqq
X-Developer-Key: i=maulik.shah@oss.qualcomm.com; a=ed25519;
 pk=bd9h5FIIliUddIk8p3BlQWBlzKEQ/YW5V+fe759hTWQ=
X-Proofpoint-ORIG-GUID: zAbsQQekyXX9SnBaN9GQWJCb3pAHi94F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfX+VvBIC0yjm44
 D7j6K9wuXe8ydilHRE2+4HH3avJShoyj7PmVa1fTTmCvBNH5OX0n8Scf86M1TOH8XUZPY0ZIWKQ
 E3TeZgnDw6cvqWyWQPyX7eN1xbIJdejRf4/5MOKN6+ErxVqGV1EdcCjljqLiW+Y2X2WgryJhcDi
 PBVb7g78RGbdx+TnYSp7fxA9lf4EU4YVxfkRPf3DycJ2fvWxvpTAL1XrzxysJLSqKC/szKS3cNQ
 WgQE+HSMYuQ+GoO0opY1+ubU5SXk5uGimO5BG6b8q2AnHSXicLNVTd/UG/dERz4IU297Im96Fd+
 sy2uyFvWnGjqCOPVdxh7aRNs4uPimDn2eSiLOP5JJcUNW20xtFbaJKVsnXVJo9JDK9SQ0d8BnsJ
 BSD0Ylp2F5VzFm/kCwHmUoq3Ba8eQloR15mSZFVstr7qNEN9ip8sdSa03nNgZ6GfmHEgOwKjFDC
 1K09/0vz3obuGm7Fzow==
X-Proofpoint-GUID: zAbsQQekyXX9SnBaN9GQWJCb3pAHi94F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2MCBTYWx0ZWRfXxczePWTv4gFz
 88HnI/EiM/v/dRm9ztCat3btBjVe78mytQlpXujem7BDBuTBDxZwL+2HkEXxo5PcQmU+/sb+3xA
 nNyuvHFue8WU11wxbOmztSG9SbzUZEs=
X-Authority-Analysis: v=2.4 cv=ZYeIpcVA c=1 sm=1 tr=0 ts=6ac3c282 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=JkMn96IHD8b9Uh7FENwA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_04,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050060

To achieve SoC low power mode like chip rail power collapse (CxPC),
the Monaco EVK board with four PMICs requires coordinated power-down of
CPUSS and the Safety Island (SAIL) subsystem. This deepest system power
collapse state is reserved for system-wide suspend (s2idle).

Add the system_suspend domain idle state, mark it with system-state,
and reference it from the system power domain.

Assisted-by: Codex:GPT-6
Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/monaco-evk.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/monaco-evk.dts b/arch/arm64/boot/dts/qcom/monaco-evk.dts
index 539c9c80a808..b2978be6823d 100644
--- a/arch/arm64/boot/dts/qcom/monaco-evk.dts
+++ b/arch/arm64/boot/dts/qcom/monaco-evk.dts
@@ -80,6 +80,19 @@ m2_e_uart_ep: endpoint@0 {
 		};
 	};
 
+	cpus {
+		domain-idle-states {
+			system_suspend: domain-suspend {
+				compatible = "domain-idle-state";
+				arm,psci-suspend-param = <0x4200C344>;
+				entry-latency-us = <706562>;
+				exit-latency-us = <706562>;
+				min-residency-us = <709987>;
+				system-state;
+			};
+		};
+	};
+
 	dmic: audio-codec-0 {
 		compatible = "dmic-codec";
 		#sound-dai-cells = <0>;
@@ -772,6 +785,10 @@ tpm@0 {
 	};
 };
 
+&system_pd {
+	domain-idle-states = <&system_sleep>, <&system_suspend>;
+};
+
 &tlmm {
 	pcie0_default_state: pcie0-default-state {
 		wake-pins {

-- 
2.43.0

