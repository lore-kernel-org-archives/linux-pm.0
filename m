Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A42B357D0F
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971496; cv=none; b=HO/1zMQ4/gI8XGqN2CJIywi/8SPFmj7VB8RWe3oCHs7pi8F/hv/ZJVCaeuMZaGOesDuQgbaQ9TdFRAw4StAaxHtlCAqvbn/rJWB1DmjHl3spPo/9KXByvri0yIIcG38iZI0Xnh8CCWVk0v9u6OEBtG3PmIr0e63ztp2Qni8vFHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971496; c=relaxed/simple;
	bh=sbRcTEeb44L+08dKreeQTiR50to36bm2tH/jEQ+fRXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U/iCwzC2GhATaGTShN/xxqHo2a7haq+xORwOxlWFXmWAkwUuZd606knZbg8BIHt9ImYLkDXvcRhgj9Pa1omxLw47JGiOtYa7QcZj0MVkWPfN4UdOFdosNK2mKXx59HxACcOhPZNzLRAZcQv/QDeVeVNLoDw0J8y5hENg05+JRK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UGO8KAbm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CCR5pIO5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UGO8KAbm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CCR5pIO5"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ97U82275552
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pW3/eYdiBNHzYmsNVVqfzYe8CiL1sfBuzUTnSxzi/2E=; b=UGO8KAbmjpxzI0YU
	o24qV+lfAKSboVc9UwWcBQ/TPiywloJ03yC2iOJ9M8webTA8IoPWe62EIsPVbBQO
	bqeCx7yfg+8FhYeDVhNQ9l+Uo1O0xZ/zc7S3b8KT9MXSds+MRRAaduRBW2zsz/48
	cuCITQxNoaruXIMMMNtceMliNKT9Ca4nw94f+aHWy8DsDffEjH2ZunleD4foEd/b
	Kg2My11S66bILO4XYjw3r7iCsghl+uj+UlFjV5RRHzP7uRh0vtHNJRqtdLT7ODRv
	dekDlUqo+ix8x0hNH8j64F36AZJ7dmTCvkbpvLZdoM27FDgZwX4lpS7J1PSXJGa0
	77st1g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p0hpr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:38:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so2285726a91.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971494; x=1784576294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pW3/eYdiBNHzYmsNVVqfzYe8CiL1sfBuzUTnSxzi/2E=;
        b=CCR5pIO5Uobbth4Ws58z1HA7FXcBiyUf9v5HJSMIlCdi40g8XaMUM8K2hEB3Ck2XOS
         /OrCNGjquThCkxx1AsGOz4+LQFw/5miT6AiaZXO+/hL/U1udTn1UttP9/ysYM4tZ5N5C
         8AQo15b0NnJtSS4ebmCVo+4IcN38gPY0dWcYyfiZpu8eqlsqczM/wcM8kDFXcxkMOyVf
         bqML6wjjexlPfGRAeZ1TXBS4oBeSDYKeM757LgwpXcvNzQ9spw1LHopC5q2BOjbmqe89
         R3w82v7DZu5DtY0LpTRY1KC1AIpqbVoJhnSM9O0EItHS/OciGGl1cffCJDkozAnZowPg
         GtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971494; x=1784576294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pW3/eYdiBNHzYmsNVVqfzYe8CiL1sfBuzUTnSxzi/2E=;
        b=dJ1kN2sXKY4Y8eFiI4lxNOqVLRIKWjbwLddvHJiSfVtrw/C+0aPSMeV3Vek5G6kLYF
         I7Q+Tf70eYhd02aIXXgeEQ0uItSzKubRG5Xi6SZ1HQ0htnrOmyqA9dvpY50g7y6/RoyC
         E8E+Z2j9d0CO01yqO+/4H8HN2tSzSvFWWOhn3sKCyk+Ty9yAfBrpxcPErzf6gD7uQ2vq
         vOXr+MEDhvK+zilLjW1JHqcCRVb6mOzo67liX4YMjZ3i5I9pdwFWBxg1mifsMyAGKVzG
         XwS+kZ7YRijcvO7K6dXmKPR3gb9zD9lAzhagFyg0/HQ0A5MJqUtT5KuhwAuVXdXpMmku
         zLcA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0efVrO2qR/ViFCFOMFAFWKF/Ekjsn8glhn+5UCzYiKOVBN+oqiocQ2qmMYDd5wRyHlMNClxt55Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxHZlFpuRzffS/lHu6Yj6egWPqbytFCpF2BXZgydBneKmn+MpRd
	DXKzSf3JHTxgwyYOw1I7xfdf6CDNFzLRfdDuzhmxxjIyz73EOCPuid+6syVAh8a4YTQtR4VitOx
	zhFve1Mgg3c/+pW4MHc5p8/I464BoEw5BfBLoSOThV+GeR1p+YsBlzCx1UzBNsA==
X-Gm-Gg: AfdE7ckd7RBqeIJ8Zy7YPKJBszSY7ef43mpswbsv2NgipCrJtspeb75FQSr07TbvA2v
	yuNApZHu9agdOp6O86T+mY8DXUr+fIkYPgm7oT+QkxPypG5MdVmfXuwhoz7OWQBkDeL+h0ZxI8m
	Q7oAGNftviXsuAssZIuSk8zBJKzFlpNs+zUVox87C1T7Pw7uR2V3erQuBrfRe24W2RQN1iiS5mQ
	iiasZIk/jiKkjUvgu9l4j5Itm+Qp45lwl/Dkzc13lrAEv7ZCFivZnUTw8yiEttdgjhYviOlPzE0
	BY4uFlIDI4R88N1otmGhaW1vXuG0WLbfxB5Vf7AU4gEPyKzx1mkLFCuHjWUseBt7rPsAhqXvrtA
	DAHxgUKTTV+dhZkOCxEcXP78j5Q==
X-Received: by 2002:a17:90b:1f8f:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-38dc75eb7d7mr10201299a91.16.1783971493818;
        Mon, 13 Jul 2026 12:38:13 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8f:b0:380:105f:8ffd with SMTP id 98e67ed59e1d1-38dc75eb7d7mr10201280a91.16.1783971493399;
        Mon, 13 Jul 2026 12:38:13 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:38:13 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:07:00 +0530
Subject: [PATCH v6 11/11] arm64: dts: qcom: shikra: Add
 gpio-reserved-ranges to tlmm
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-11-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=2134;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=sbRcTEeb44L+08dKreeQTiR50to36bm2tH/jEQ+fRXA=;
 b=Wz4odGLEk4bkPwCpS6QykF+GmDbi3S5JMmJswgb10VehZPDUbG3zVfLbP93tww2Va7rxXbfIw
 rLl4xZkiA76DT9lTTy0QbYO745BIl9AEMbc2Omp69KCv37t/ynPv94p
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX32BNC3YsQTdk
 p7R6tLzyHsOpQ7oOj38dRdowCBsu4w1l8XUhFD/uzdxkw4hjG04aV9UEwbbw7dHRkxQ2uIFw7op
 WY32XVbUtNV4L1cyl6vNyJLVu3gQH8o=
X-Proofpoint-GUID: Bda3ykAOQPKWcN-df4D5cpAdy1k9MMO5
X-Proofpoint-ORIG-GUID: Bda3ykAOQPKWcN-df4D5cpAdy1k9MMO5
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a553ea6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=KewF8LS1X-wPzteKbbsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMyBTYWx0ZWRfX1UiR98h09zbx
 uosHvYO46iAPYvbQTHivlx8ezESiBYANsrPRchM1g/rtaGB++Kq36cYuIkVRaulNH+Tb85A2XOF
 B9H/6IFDFut/C+LXOB0yqdevzE7OuBw8KgGvxVhtqkXLAWyI1+xligpT1ldPzX11OlpRSlAsDEn
 e6HtElQW/puSTGFd6lPtmLutynBcX807e7ZrFBJm3RbT2UVuhSr7bGWWIOOPG9LDx2kR3BxRxm5
 0DSHppeoRrK4Q9s0MXUs5CUWbhdtgwtyz+AreOya+wAOSjdrLYPQOeRQ4HoU/brofUKp/TduOOH
 QevLQ5QVeG/EYYMn5l+K/ZVKQbIDRUeVs63KiFQhU3Lh5lribpircFTT2otnCHWmSf+aVlxg5fn
 5SzjxMOIRkmZSC9hi6dtbD1AfUGefjO3z9K4zcx5NkDURQNWsHCUY2kPyqv6EUsxFzSpe1BhBs6
 Zr+yp7G6VyLlrzV0sxQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130203

Add gpio-reserved-ranges property to the tlmm node for all three
Shikra EVK variants (CQM, CQS, IQS). These reserved GPIOs are
inaccessible from the non-secure world and dedicated to fixed functions.

Signed-off-by: Anurag Pateriya <apateriy@qti.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 8 ++++++++
 arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
index b112b21b1d79..10d0b4533009 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
@@ -57,3 +57,11 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&tlmm {
+	gpio-reserved-ranges = <6 4>, /* Fingerprint SPI */
+			       <14 4>, /* eSE SPI */
+			       <30 2>, /* NFC SPI */
+			       <138 1>, /* NFC Secure IO */
+			       <155 11>; /* eMMC Boot */
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index e62ba5aef71f..a56ea39a7c08 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -57,3 +57,11 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&tlmm {
+	gpio-reserved-ranges = <6 4>, /* Fingerprint SPI */
+			       <14 4>, /* eSE SPI */
+			       <30 2>, /* NFC SPI */
+			       <138 1>, /* NFC Secure IO */
+			       <155 11>; /* eMMC Boot */
+};
diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
index 727809430fd1..3a6962388dfd 100644
--- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
@@ -57,3 +57,11 @@ &sdhc_1 {
 
 	status = "okay";
 };
+
+&tlmm {
+	gpio-reserved-ranges = <6 4>, /* Fingerprint SPI */
+			       <14 4>, /* eSE SPI */
+			       <30 2>, /* NFC SPI */
+			       <138 1>, /* NFC Secure IO */
+			       <155 11>; /* eMMC Boot */
+};

-- 
2.34.1

