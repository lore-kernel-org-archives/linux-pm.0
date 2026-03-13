Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5287C35A391
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773398089; cv=none; b=jLoxo8fFdNHHKi6/SPgqX7cbyXPeW0wQnhCqrKoVhdwzyZDV6vK9QK2OOgXHSLRY0+8QEk8YkB2mBx4To9YefHqSGDGQah/dBZZIcoKIG3KxqrWRsrsENc2GhIhNTbUYziue7wP8t7vpjZmuoHt2WM4VQdnuLw7U1a6TwPQ602A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773398089; c=relaxed/simple;
	bh=3PpBIdeOtKTzyhlsHsVNBAIFsax8TWLerLyx3mUH548=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PxbDfwKwUPj2XRUXmC2OxC96DdPXne3c77zLcETcvRu2kXCXc+joHvs7Zs/gwea20oGeWvxTav+9ofn0j5mItcPlZzwZcyVGZMD9sI649hDnlaLadtUw5Nw/krSETwZGMOkOb5jtPmYKP9nFefpeSH0er+h87eGMrTlJRUTKBBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oLkd3JbS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dmlmt1fg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oLkd3JbS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dmlmt1fg"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D7JLYQ237704
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 10:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mBce1COGqHy5J47gx3y6AigzXU923AAD9JmM92KYPYw=; b=oLkd3JbSYZL1OV+Q
	yKTA2nhxr5A7b3E7LB8kHKklus4ERyvITirXeuEGWBemKPkOK34+gs8UKq4BYqVD
	5prBkUJwQwC0jMmHX192W57igfCk4vKjYxUMcGfdiFv7AULpgAkZEO5cvbVojWRy
	UbdACTrXzLAi/ccF2Tb/ogq0qHmc53X+FFt6SCuvlHUaRaPJrbYBlZ+x3N7J1DhG
	NEZdsuMjv9xk1zS1MypVGf1qj5Qv4ZES04MFHjc4Cn4wQxmsw3RsND0+tNyNXtUN
	a5eEUzaIaBsDdnEfuvwGwb1/TJGa+DBg1Z5WrBvTmxR7a8CKGJxlELrTuqJTlBIe
	4tXNag==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cve3d8pps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 10:34:47 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35a02f3b8e2so8688880a91.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 03:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773398087; x=1774002887; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mBce1COGqHy5J47gx3y6AigzXU923AAD9JmM92KYPYw=;
        b=Dmlmt1fgt1MmHO2yAHfwOiGVo+OLZrgD2Cc96IlpVHnSO/0KEItTecgVTcV7Yyfvr3
         ZSjIk4QR9gFpu+5Xq+eDdPfe/9T0ehnjhoXNdr6gaAF75lBwrbgVF3hLqKeNS+tyucmV
         YV8hH/qrMdBkaXrpsXR5Y+Up9MHkkSwlez7cSR5cMjAxkipOWqrMhr1BxRSbwGVxKarO
         5x0Ic417SYfE5rWoCI6HI1tc/jpH4QAjw+fmVbROY/wCGaB3QtHw38JtL9MCGqgFnFgd
         6rpLzP9+fCk607c++/y9oD0g9dCdui9Q0v7TybVW/TSKVc7O8KNYeCitzhmRVcs9Kd/P
         0T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773398087; x=1774002887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mBce1COGqHy5J47gx3y6AigzXU923AAD9JmM92KYPYw=;
        b=ojY7c8pFGNVeXhhFcwjOHtc3qZOn4DJmvSYnamobCyFMPyXLSjdJts2O9P0/slCelF
         e8PeEGQCx2rahoY0FnYX8VmJ06aSbqxcCl4n6ij/OouG6w/uOhkF8C8kURuLaribRICE
         Idy0DhEorEWocxHWVCpDfESdyBBl5/fLAko6w5434Pjgul2744q7/kzPSBYZp0imVKwF
         dc4B6x1gxKOsJz1vGIRTtIJgTfqpZrPZrFoJLoW3q6WO6pq8Rmxkb++l7Ypvlhq7vCQw
         J0FHuo1Pnx8LLmXCV6F7+bM/Biv4k7JtL954g1kg8fy0QXLbT0GbTd64FJVKxNou0Y1+
         tvIA==
X-Gm-Message-State: AOJu0YzucW1L1tW+GBe8NVqZjZoaxOQWs833Wdw4FDJA7nrWCojZK94a
	9v1L5CGVgDuOs4GTgJiy6PnTl3/9CUN8E8KtPlCvx6hP4tXuHZg/xAzYq74e8qC2ILwGvrouR38
	M4veSnbMgpnlLg7P6ZjymkBd+Hkpq6GJdaJY+cxA8QzTZG5WMvBnQWEY8TPJy0A==
X-Gm-Gg: ATEYQzy9oSdOdOvlTSuoptkK3cDAbJx4WV8WeHOMby+n4K9nWmKfa5zZ7coRczEbXmR
	WA0BgV59sI8gNPlq7KBzcMopMlWUnuweB7GgEnAt1DYn/r0DUTvO8k2Bpki0IRAC7LjCfgysept
	ucGBm05U7rhNsvAaqxxKrm9MLn0SRALuJcdrSE7gTNp1Hv8WSmOInRsID1Bt8wi34pP93ZnKz1j
	0gIKN8yYSSf1C5FrtByH6S2MlJuUdiGfWHgQ9k8LB28YN7dF9Pq0hUW1GxNiRE/KYGgm/WkKiLV
	MFDR8tR5BnpPaSOlnQoo56J/On51Sj5ppG37dNFRyzduJz+ufoi4/+blEcGCgSufZrlQXRqoBam
	8DpMGEoZZUaaeJX0sX7yjqz2CTPcISlWSNgYIhp6bWKlZk2LNy/g=
X-Received: by 2002:a17:90b:1d08:b0:359:877:370f with SMTP id 98e67ed59e1d1-35a2206402amr2752690a91.17.1773398087110;
        Fri, 13 Mar 2026 03:34:47 -0700 (PDT)
X-Received: by 2002:a17:90b:1d08:b0:359:877:370f with SMTP id 98e67ed59e1d1-35a2206402amr2752671a91.17.1773398086633;
        Fri, 13 Mar 2026 03:34:46 -0700 (PDT)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02fc8465sm8055383a91.9.2026.03.13.03.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:34:46 -0700 (PDT)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 16:04:17 +0530
Subject: [PATCH 1/2] dt-bindings: thermal: qcom-tsens: Document the SM8750
 Temperature Sensor
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-sm8750_tsens-v1-1-250fcc3794a2@oss.qualcomm.com>
References: <20260313-sm8750_tsens-v1-0-250fcc3794a2@oss.qualcomm.com>
In-Reply-To: <20260313-sm8750_tsens-v1-0-250fcc3794a2@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        aastha.pandey@oss.qualcomm.com, dipa.mantre@oss.qualcomm.com,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773398074; l=873;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=HeV6oB0sVZKpwZNKBC4HdxatIGgsL4LcpL//eKpKWsc=;
 b=IeCREOAvQRMw935aWiQ/GsdkIGd4XTtsDIPW+yqyx1/cGge2BTLSQ4bTMJyq1OjV+s1zFW9wX
 F0GiUtfeYd+DgL/kgVAa/gyldvO993xCQZt5EI5EW6LIXG8Y+Gw8Unc
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-ORIG-GUID: Ue_1cqfijq4oE_pXEzfWz53jNp9EHKal
X-Authority-Analysis: v=2.4 cv=FLwWBuos c=1 sm=1 tr=0 ts=69b3e847 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=brCocUxllU0CA3szuAAA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDA4MiBTYWx0ZWRfX86FYnydswoZ/
 VGN2lS2z0vQ18RctAEZZCvTBOju6LVThwHfi4bF9UQeK5f8HIQkSRzrD3paZoLAZs5Bq+Z0T/Av
 Jaz5kWRYok9KjMQsZF96OtAMs1J2Rq3gTnjNayRXmpYXENNL7Lv6eDimXnxuYIjp3B8SE+xdY7f
 pWCD/LXBVGxF5lF+4u1+yKCJFsTx+t2MlZl1qbIbcIpUmdc2CbtT35amu8B1zzqjFXmMQNYtE69
 wbn8ASaEsFHkJQi+G3/7xzmSOaHQEEMXK3/L0juu26lVAj5tqqrDuLTQ1SLhGSGdDTBXkG35SeA
 idgKyPn5l27pff4jqfN9G+ENodLWfEehPgft1KxUSZApuHD3FCn3X2K+umpmv5Z3cZSgC6dqkq2
 xtIT2fjVfXHISfUxe9q5YJstI/JgBVTiAspVywVKlDo3kfBJJX1mIkbprqGTMm8xDTibutMNalt
 14jLTVcIv4QyTOXKR3A==
X-Proofpoint-GUID: Ue_1cqfijq4oE_pXEzfWz53jNp9EHKal
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130082

From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>

Document the Temperature Sensor (TSENS) on the SM8750 SoC.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 3c5256b0cd9f..57f1cbb4c188 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -81,6 +81,7 @@ properties:
               - qcom,sm8450-tsens
               - qcom,sm8550-tsens
               - qcom,sm8650-tsens
+              - qcom,sm8750-tsens
               - qcom,x1e80100-tsens
           - const: qcom,tsens-v2
 

-- 
2.34.1

