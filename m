Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFBD3101B9
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 08:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180440; cv=none; b=S1xmy/DICusprDugWDwjWw1y8wXrwc0Q0J26awqw7vpmhqK6ugHbu5Mt3jGlWrUphqhlHkMRHzP8rT+QVbPhXsI2xSX0kbx4kulil9ZTSg/xr4m2jQlbMXOz0ZPb3yX+Fq5/ZwDcphMeiCV4lW+qYCOOBZpn52X/ho6clAK6Mzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180440; c=relaxed/simple;
	bh=QIwfsEFy/PkegK5poQuZTixC+HSGKgN5Fy/Unu/RWDA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qhUHFfvrw8XXMH+8MDVZwLTojxNeXziDKfIrlPGajoWtdFD26B/i6Bcy2CPQCskuyWgvV/alcCFWFwAwMdL5wzYSjPtRzL+RcAjT4h7Km0qmysjSqQhYAq7GcFdbwsTXPmUSvX4IpRYb0DrKjSKIZoSkQGPgh8BTAroDMkcZ0zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NCl54PNd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IGhg7dht; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NCl54PNd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IGhg7dht"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J3sG6d2482374
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 08:47:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YTzof/GAHtd/VEBd5A2iXv
	0++GjULzEE4n+pqgtZOto=; b=NCl54PNdhqQv2q7JAxq+j3hrZigRCXa7iMsPVS
	cRAmHIajB4PzSruM6psz0v7gBiJj2thwkq7Ztk77MImHmrnUFHrBjDCU5SBOh1y3
	topEx1oAIxLLTL8k/yyV20m+gd8HZ5nnrcZVwpzycB1MMgLZsUO6lmFSi8lF2WHO
	2SFQzoKWqGTOibuVX165uDcV0D2pMiPfG9GFDzKDgVgZ6j8TFZrLk8JzjKJyfpl2
	FoTIUna0GITFh9Z1aiyXKLGP6bxLl6VHo+L8xOFHuGQ1tKou7OqwBG4e9aAR3zpG
	rmWtQdZs0DpFnqVviHART/o7z+Q0M1gAoTVH29/74enH9F3A==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvmc7q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 08:47:18 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82f756ebd0dso2031019b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 01:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779180437; x=1779785237; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YTzof/GAHtd/VEBd5A2iXv0++GjULzEE4n+pqgtZOto=;
        b=IGhg7dht+2Ikc0jFOiubfXYn2+DXhs35fpfkHjJ2A1hf1TVO9ZZT7JHWUxRQotGgTD
         Pb/ovQH+0kr86k7htMSDpiasx03AQjyQPL+xt5NBVO66Y4TLXInQchTlb70U41jpSCtu
         vuPx2Dif4MREUscU+1fo6A7NltGzv7mK2LVMaGXSdpWAKc6/NgQfFtjV6KJqKVOAgMI/
         yMbsvmSplGv4GzjRpv/TbaVMZq0u5/+NoZp0U1tFpzK85OjqmKsUGkc04TbwzBkdXLPU
         QDOtCrFuP8Vd28azvntdDbJrHNJJeAXOi0EMOEaRFtkKCGEXiUEFkm2xBKx18vFZSpiO
         N0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180437; x=1779785237;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTzof/GAHtd/VEBd5A2iXv0++GjULzEE4n+pqgtZOto=;
        b=qAPRn4jno8VZ4MgbPBYa5bpaoCIlhsk22X7BLJC3GF0/fwvY70lr0LMWv0b8uBIM+B
         5gs4I7gJgHHl7x1qYT2Dz84j6ri34ixnOPO/sn+MDH0vBRToYRJOiC+sqs1Geo/7RgJ7
         qLcDeW6tRpHZSsA9QthXc0gcLmwKxQGsW6vC3NMiWe0JwDRJLd6OLcdoPXr/mD2a1vcS
         yRwZ+q2Gm1k5UrtXpCGUClth9LuYSr4NkEkwcD8C6SLYnrO5fRQx2OpPhukrC1pVVEVu
         ++obeRkHuj/q1AxnFiGsaHuuGGcS3hQWrXlm1UB3V4vXJ1jLLED/7OPpG4C3dPpAQUV6
         imQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mbLM9wmc8J7uHdhAnSaZN8CEnuj2Ok152dPtEMTiW15gbvs0+J/M9w9f1pdWR8TCwsQKG9CUfdg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SkWmaw/P4WFa/7q2vjHcuUC/jwSqUEHcpUrl1u1iMEEVvt3q
	Ig+8OMu8kg+pJkLcICv2xSzUytDowsg8VXyhZlrJx9XMKW4a+ESUKb7zOWUS6CqPvNyIM7djGPv
	07uj3Exr8mPN+Za10iojWhS+8pg31WPniVO/LFXMWCfsn/gawcTGFlxyT1LHCSg==
X-Gm-Gg: Acq92OEexRqPSPBra7A6wPJsn/GGSC5ydf4MRv5L83bB/vsd77/PVYrh8+FkM4MUWt/
	M2csh0N4txyyquW4b4gF+todjzW1BBiq89ip371zMhCDDwf5gG4S5PKVoDtDXJFvYHtDmb+lIHe
	SSKdP50DJpoZd6MB+JO5/+8b/URY+elVHyRIdjcf3fE0mGzbXUBd5BTJbi+l5obGKO71At5rxVg
	k0KxhD6VSCefvHEdO7bA5t+5oBX4fYKKfCWWKmu6AjYKAbUyGLuSTC+gbLmhGBbRsZ2A+zus8sm
	2aAYgn5QCdDPz3n/kU3BWVawO1XwNZE6OKTtc9m8M7I+AK1qD1ZsSWwL4k8KauELxTs9Q0xhGOX
	KgJeRoYpqH+1Sps8OgYi8dNlNl86Y7TqUYIzAA+vFOUy3JaHGCEXjgpDqm0vdz5PnDZKhDw5dVt
	4kg2I2hHYs/o9bAP9UCgb/wMo6KhLAT2XzZqb2yMIpKDmHhS4xrOxj6dptMRlUmLtbKCY=
X-Received: by 2002:a05:6a00:1808:b0:838:af72:fb37 with SMTP id d2e1a72fcca58-83f33ba71b2mr18162212b3a.7.1779180437058;
        Tue, 19 May 2026 01:47:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:1808:b0:838:af72:fb37 with SMTP id d2e1a72fcca58-83f33ba71b2mr18162177b3a.7.1779180436563;
        Tue, 19 May 2026 01:47:16 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b1f5sm17434104b3a.31.2026.05.19.01.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:47:16 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/3] Enable icc-clk support for Qualcomm IPQ9650
Date: Tue, 19 May 2026 14:17:04 +0530
Message-Id: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIkjDGoC/yXMTQ5AMBBA4avIrDUZTYm6iohUDcbCT4tIxN0Vy
 2/x3gWeHJOHIrrA0cGe5ykgiSOwg5l6EtwGg0SZYZpowcuqsxRrtlZorWSOCpVpOwjF4qjj87u
 V1W+/NyPZ7V3AfT/0WdkGbwAAAA==
X-Change-ID: 20260519-ipq9650_icc-994280404adf
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779180431; l=914;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=QIwfsEFy/PkegK5poQuZTixC+HSGKgN5Fy/Unu/RWDA=;
 b=R2EEDUaXovgm3VTGTrroPHraEl9Kvny7YPrOQvtoj3JTq4MWXcgpQaljwAbgW86YJUec8JgpA
 h/3k491oWX6AFc7cBfJMj9pxBLrJm8G+E/Pj9BKJSsDuWpQXmuq5yyY
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4NiBTYWx0ZWRfX4KPVK27nd7sX
 AuvYFdtF+6yCzY0S8CfVsaeCxLRfWsv1yyOU26M0yhn6b1xehnlm5nDS5BrMdSpQvI7CPmm9COe
 xY1Ii0XLjIG5gAbasZzlAtP95VZ9D65gEuOj0WxZTJsw9Xu7aMt6FJPBM3oodIolwKsh692xA3L
 vzpCyWKYkyH6SJSZjfguWWOgOEZllngXSDFbKWDpwXrBq70q31kAHxoGHixTZBIaNY7CAoE3skB
 8xJrCg5E0jUmYTK5Herz9Gv/0hN9wPZfj0vO9/aPFflS4XRHCXdbIri0DAOtwwgjUk53ULjWkf4
 PQ4ivij/ZHHCSku5fxDv9Q3QtNM1XT3uikV2uSSB2fUUSMb9J870LQ74tgyEKHopKc3rHdfrspV
 ZP2ruNiT//xEFK5gimGOLV9kWLP5rQM97lowqTcjO1uyjNztBNlNmngrAkkoonQp0PjO35/+Ofy
 gbISn/aBbxdhxRSmy1A==
X-Proofpoint-GUID: RRXocqaBGiqIYYaMZthloEu57KF3XWv3
X-Proofpoint-ORIG-GUID: RRXocqaBGiqIYYaMZthloEu57KF3XWv3
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0c2396 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=AmmTUv6NKEHWZ0q6wX4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1011 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190086

Add the master and slave interconnect IDs for the PCIe and USB
peripherals and enable them in the GCC driver for the peripheral
enablement.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Kathiravan Thirumoorthy (3):
      dt-bindings: interconnect: Add Qualcomm IPQ9650 support
      clk: qcom: ipq9650: Use icc-clk for enabling NoC related clocks
      arm64: dts: qcom: ipq9650: add interconnect-cells to GCC node

 arch/arm64/boot/dts/qcom/ipq9650.dtsi           |  1 +
 drivers/clk/qcom/gcc-ipq9650.c                  | 22 +++++++++++++++++++
 include/dt-bindings/interconnect/qcom,ipq9650.h | 28 +++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
---
base-commit: 80dd246accce631c328ea43294e53b2b2dd2aa32
change-id: 20260519-ipq9650_icc-994280404adf

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

