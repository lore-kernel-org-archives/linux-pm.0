Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75B4E3776
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985917; cv=none; b=BGTOn1R0YdSdRYJXYYCwRk6q6LHSsyoo4ebwkdt+6e+H1YdXqJw9Tvo0sor+Bnpnbb3f5qgZ1pJmVruChcJ9gSSAcf/3dx9PxhEVW/ba48AjEM9XnxhHV8SpcU1z/dEBW6UeLFo77oOc8qrnlgGGqkUTw1AhPvsKcfJQOYBFhuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985917; c=relaxed/simple;
	bh=zrxJFa4VPwsYcw8XwQGDYVBpixFGlco1FfRkuJ8EAgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EsEveJB12aGJhtiBmokxGiU1rKpcQ7DlWoxOEvDYf7ruLC7wwguYcTOVu9OmLGX0M7e5ktgcK8osd04IhaEX3YLEeBbS+ARbedfJrnd7bP9FQAx+up6KIlYg8KaUDq1tlNoAZbNe1xG/RtY+g94CS/3w3ciN48rwhO/0Gklog3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jpRsmq4t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gbQgrRFI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jpRsmq4t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gbQgrRFI"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629nbcU4139702
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 09:51:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	755Kmru2NNLSqWs38B8De3HgJThqhmh0GCRqXzxW0lM=; b=jpRsmq4t/cp/kxQK
	HLI/vN1cBYfP5j7CzPNM4KXL5hC7zTh4lIKd+OSTRA8WxYrnLcsGCTG/BiUdyhG8
	Fhgyb43+jZn7VggmFRfBZbsbE4yrW74emmSa0Y/uh9Tpi3Leg9/+m2LJsx6wiQag
	ycynclZHqPY3U7qzJBOVmFUuewvHGeOlh86UgbQ1RF4oDQ+zAbu1EsUeVJfwHQHz
	fNRTP2F+GVliIZxw+CLGAuLK9zcehya5UuDrZT7RvAgR1SyFI2+jBueuKt5PMc5g
	8QgWqIakNWbgr+DgNgsCvYG2rOEyY+pYK1dZfWP5Ks4ELUyYiO5/xSBnQZIkkDuE
	lvejkg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5npr80dx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 09:51:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84777e9b51bso3171207b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985914; x=1783590714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=755Kmru2NNLSqWs38B8De3HgJThqhmh0GCRqXzxW0lM=;
        b=gbQgrRFI3rWC15tX3zo9DLL8qmPPP+UwuvOstRl4V1sVgvXq2P+EvzLGYhfdaryqeQ
         eRA/DwJOropQYS3kSf+T1Y3gp132ztfbBb+5YpxAqSIBW7PJ2okYFom5AL8kZrTHMCC1
         nNfWSDSxEXzVGYJ+nsvrkwPekGoeKzj/XF/vOttgpsb1K5K+q9U5L1g+TmlNl7EMR3q2
         I64lu8tbpR3Uki7d6i69/t+uRTOvi4TN0uDIDJdwyn2k7ilOfaoshKcM2Qkk7WRZpbI3
         IEShsojwl9V+UldIZ+eivtMSNAP2QxqhBQNkj8X4T9ElIPFpfYTSHWQMRVlnzrmNHmqb
         IXmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985914; x=1783590714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=755Kmru2NNLSqWs38B8De3HgJThqhmh0GCRqXzxW0lM=;
        b=H8cfO9FfGw8c03z6HYt/mPNSh4BFYPwrMajZHhFwmVDIhJlGLZ7vA+pAf1T6lX4YJv
         7BENxPU58s6j40MB9Tz+7BJ6BuTFyBvTq/V01YwBfr6xluyRXkBUGLwzdT4VozS+oC3e
         QJZEBQUqgCTxtXLn3ekHjXQaSRxNEVtasL3KuBWLA7kG68eo0sfAN5RA/vIRWEVfkH4a
         SQdaYBxNDtopw1fPdChpJ0cn4svOR2y2Fa+KbrZi/kyx/kAbsEYtvJAvzZzVZcXc+Cv7
         rF4Ju6XFsbZi3gj/nzQtGs6G8jfxI65UzTX5SMATz28z9UL8u1LCBcLPcfH1oV1iOQDm
         8lKw==
X-Forwarded-Encrypted: i=1; AFNElJ9fcVrGZmELnmDG8VjkynjHUWDCvd0KX09Xr4dhbPZc9tG4K3Mb5c8asSPcKpANUvjc/dSX8XAu6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpADAI2/wx3NEsBjWsRFvUMVYnqWjzj7bQXsQDDfdj63yYCM83
	r1vnPCFg715wtYBLLwoTcx/NGSLFz+GZuaj8Tc+PYro8PqNvyMgmCt9E0aWvZuEdPCHjKqLhyJ0
	ZuvtC0UiNFga+JnKNwrXuYyMtODof1t72DkK4YPuULNKYhkpIKCZzk1fyAk388A==
X-Gm-Gg: AfdE7ckLrqieBOzaJoXpPOAsZn7t2dOWVnAhP7fJ1ttl+jVYiO4lVAzlLJRUNMV/46v
	hyVqF0PdCeiqdj+FiHFsDWMnGDcgS/5ZEa4UUUrYZJdS5Ar4xnEMuSX9kioaDbb9+Fn6rKwAgoi
	jVjHZsjKJPyA4gqt+zx5o+CvtbhQ/VtrtYPgbdsYTmR/mOVGwmEie1Dj+KLdbHxFMoDPQXL0ftI
	xp7RLGfu7QsxJxM4RxmYrGBVNzBcp4FO+GugIMS3vZ0PBq20ZxgW2mvtQ6PLNRz1ZT+caGGQc/b
	F/9w4IexTE9PGnepg+OlVSIPdaX31CpNXMv0x3W2a4bY9m5e8jQ93/CnPzpRKIylRnIvuSc2OJE
	3UujYEyUVTas8WIKOIGRqUg8NSA==
X-Received: by 2002:a05:6a00:908c:b0:847:752e:3631 with SMTP id d2e1a72fcca58-847c5168793mr4391063b3a.46.1782985914511;
        Thu, 02 Jul 2026 02:51:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:908c:b0:847:752e:3631 with SMTP id d2e1a72fcca58-847c5168793mr4391012b3a.46.1782985913936;
        Thu, 02 Jul 2026 02:51:53 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:51:53 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:53 +0530
Subject: [PATCH v5 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-11-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
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
        Anurag Pateriya <apateriy@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=1832;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=zrxJFa4VPwsYcw8XwQGDYVBpixFGlco1FfRkuJ8EAgA=;
 b=I5ZZiEPU5ocYeFh6TIaMz/FgAsPVoIRMynonz30ynq7Dr+IIy9F9bKY74X0pIfNiKV7EWueOq
 aJGqc0zwFjNATrCR14kATNFy8eVmtsN+hrbza266iZXRgLbeHHwdbQc
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: 2jnn7DaC1dZKTU094zJX7U7woTWQ9qw7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX29xbOqBwk59R
 S8WhMWrrVTqXmkzWSxH4fQtwn4CeI8lefbbXEILfNGCAlCrVwf+4cWKT9SuJ+gNImyawKWFMQWD
 C8T+IAZ465S+5LpHzn9hwu9V9XeeLl0=
X-Authority-Analysis: v=2.4 cv=NsvhtcdJ c=1 sm=1 tr=0 ts=6a4634bb cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=wm8cDCIBuLkz8hnEg_gA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: 2jnn7DaC1dZKTU094zJX7U7woTWQ9qw7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX6xQX6LPzZffU
 ApOHYjRMDKKZq8CInFClFGWxg6ZYcaFWFkqcRTiQ+E3HXX9wK7e8TgnfUH/43g41kTTMjLQ+8VE
 tWG7maLRnL3/RMwz/6RzTIzkxiZHvmtdoHPutJ2ZNARkRh+1Da/cH+SE9d7YcK8sed6bVJu+ZVr
 u2f2qau5Y64FgjLbJAKtyfEel2pSjXBWI9K6MxAK8rsZUFFvI/rfg2ysDNQkgAUUZ+5/fSKcgiG
 7p48Ex4b5f/E2fpLKv7FXV9AL+Kakc+tKqZvVOoV6r0rz/X6ezJuanQvzRMF1ltc/vauzURr1N6
 +ulZ9Q7khlUy2ydlPaJ7J9pk60RVQoHlELsxN+dfdNxDZV0VLPt25pwaTa0BP/gdirVChO82M46
 ll6zIGP955g1O0q/r+P0L8wbubUt3viPZxCVRJSbe98Fyr6xlsc6OfwPHrzgdwMgyX3WJQ6Ga3F
 wFbjDidQT+D14Ri/Gfg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101

Add gpio-reserved-ranges property to the tlmm node for all three
Shikra EVK variants (CQM, CQS, IQS) to mark GPIOs used by the
SoC internally and not available for general use.

Signed-off-by: Anurag Pateriya <apateriy@qti.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 4 ++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 4 ++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index c9409ab0a3f1..269e11bd44f6 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -66,6 +66,10 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <6 4>, <14 4>, <30 2>, <115 2>, <138 1>, <155 11>;
+};
+
 &uart8 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index 58fed6cc5925..ccf8f856e994 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -66,6 +66,10 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <6 4>, <14 4>, <30 2>, <115 2>, <138 1>, <155 11>;
+};
+
 &uart8 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 864c0d2636e6..743979b5ed5e 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -74,6 +74,10 @@ &sdhc_1 {
 	status = "okay";
 };
 
+&tlmm {
+	gpio-reserved-ranges = <6 4>, <14 4>, <30 2>, <115 2>, <138 1>, <155 11>;
+};
+
 &uart8 {
 	status = "okay";
 };

-- 
2.34.1

