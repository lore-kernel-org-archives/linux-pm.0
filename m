Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF66E3AE18C
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784877592; cv=none; b=gRqNNwseA579V5GAcYGp8fM2oL50+TvV1xhwubSSTOHT+nu8B5zoFQcbYBG6rliXZ2DT0OZmBr7SsPnnjxjz3sNrZiQfsao1yt1SS5wY5cZOXHXK9ODr/i9knLu3vksQHNPluGDOXJ6qlMn2+ONpc6X8DN7q9JGj5V0JnXOzZ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784877592; c=relaxed/simple;
	bh=wZDWaODCyzp7t+O12ZO+CiytzMHhYNjkW2d/5Umhqnc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NI+qBWQhnbG5qwbSsYaI2cJEuOtPQl/89F33BWwKH5fpVX+NIRqP83BC0nftxAVIWyexmP9Z+93EbsTturLFeqBVRQmUpRRzHk6haGezfsC3qswdE8THa4VExnNMxbWbyUeBIT1KVFLtKpVkD6VkfTTIgeUWeb+H9D88k3dt9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SRfReoF3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NZCRgOwC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SRfReoF3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NZCRgOwC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66O4siG81897284
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	85c6fMwpf5j2iCdGRa9j4fuKaRpGB/lUr0+dZdRrE2s=; b=SRfReoF3mUtI5cLQ
	iPa1Rfmx16lH4+oLCZeIV0lGWOxyE6tIQVHkKpCPQXUCzkD/zdTgTqbfSTlHOkXc
	Ss4E3udo89bT2J1Yn4NNVJs72qofDVhIpC5xoDYT3GonXUzZelCynprqMEg414tk
	HbsrwjIZFhBLJaFUgee9nc/uwLm+hngYoczJDGbQzTYvTEUepKY0fXLCKv4pWEzF
	8kuQoXKADivj9b2CSh6704160BqH6mdmUwZzk1poOWGybNxGb0nFZrlE6i6NEsQN
	WFoy9QEBwJpDxEjKw+F43/jjw0v6Ypzx6t3L+g0E2SbGU+YHfbPPYRrNvdBDOBOf
	1NPkKw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm1em8fvt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 07:19:49 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc86a9ef97so3266335ad.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784877589; x=1785482389; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=85c6fMwpf5j2iCdGRa9j4fuKaRpGB/lUr0+dZdRrE2s=;
        b=NZCRgOwCvds9LWUSCtdCw6S2Fx6tIV10jVUZsPAtDgLvO5p9AYw0rs4OiIUG8D/7e+
         5YC4KreEzfFQZiqD1cKHAyV/xvooKLTi2Bk9F14eftObcSoZmgNt0gz5FSmW2UhlM8oX
         Jo4cjEKvjTnhCz7Ft/ezD2k/MtbJV4rKKFnqStKzWjmyvU2Dm96MrbxfeaLkyq7FgMhh
         Oq724RotBYzbELvGmdDZ1QtbEEeX5EZVspWe9oINNn4rV1CChU167MGnvEkP3nvDxhXp
         v7iVjRFDi75fPmdKcQKU4nPm7PyfSvFW0GyGQUQ+Jiz4VeuVaV+iv3H/3f1rIFIQbTlE
         Uivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784877589; x=1785482389;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=85c6fMwpf5j2iCdGRa9j4fuKaRpGB/lUr0+dZdRrE2s=;
        b=EBwsuIdnQGXXlYh+xvvirXIo1ACdtcGq1/hlSWit3EL6MtGaWztEiCCK9T5qqVPsBL
         6Yv/oIkeMpg67e4Ij0JOQDWvyJERKoRKhKMiScVK+CZo8I/hIVHHoqG/GnuSuJjMl4q7
         qzlZA0TOr8ERz8hp1obhzMIbkEcnjStlYi+yseat2fvH2MgsNdvO66bIbAcnYgVLXDsk
         38qAjwGNp9AOsiC4nkzFbc1NbiZsvv1cSbGCOdUETYVL35tZREs09jl/gmups5PjtsKI
         mqAiV1WfIgaEJD1IKNswnLLdjVMH+wagoYdcpIMXtxlo1WQayBnhPChCBkLGfe7dbu8n
         CzgQ==
X-Forwarded-Encrypted: i=1; AHgh+RpEYPGQyXS8jicDJw4vLYCDvL6BdahuwwWYk/AjT4SGyIrIZZDucyRutXGT5DL8enu48wV/FHWj5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4j94AOa4NRA5lWOivo4q8dK55/xXGzSgLT1oCcRbMwTNLasYZ
	MEhdRzcDUh1bYV7CmEzxrx8OFP2LTezA4GQcJ/bTT45RKnTf2IFqWlmm6fFHMVUHgHfuSuekXsx
	6NWFg9GNFLI8oTsmTggcTgaVJMC1qr6jOeO3Zf9wMuYqkXilsUGbKFlI0JB4MXQ==
X-Gm-Gg: AR+sD13OKLMs6xbEMmLGkNlTJhRmZOqhEz8sIL6LImHy8rP7TXJ/Bny3dc1hagyKG3G
	FeFNAT22AAlD9hUoZg5IKIkyHikl6UhDWIoO1L8Ggy6DQF1BdnDL6gKWzj7Q7vkB0CUAsBC20+P
	CjgGGPbsR+nPCcal/J4LD94fuy8AVSObD1FNysnnIPerzUWmN3HIcnahV6bOvN3pFhZYmB6ufcQ
	bAvcwFpa/bq97CpGruyHBLix1VysYezAVVNWsO7U2GqfKZcNcEPufIwqTdgsw63ylAOALOEKYAk
	dqLjqixIWQ8HuxCCNjgmwHWa9SuobQg8fvXnqZowoF7+K+2JJVo8ETITWYwF77wQ2VIXiU40EEW
	TMgnvmCumAM5nrnHcl3TvPZ755QQo1twFgWiV39HgZ+ATbEH16jPKNZROZzj2X4ltLr2aJ4J7kS
	OFHYQdNkulAWHXQdo3UR9WXaKlgA4=
X-Received: by 2002:a17:902:f693:b0:2cc:d192:50b5 with SMTP id d9443c01a7336-2cfa75078dbmr74556135ad.34.1784877589264;
        Fri, 24 Jul 2026 00:19:49 -0700 (PDT)
X-Received: by 2002:a17:902:f693:b0:2cc:d192:50b5 with SMTP id d9443c01a7336-2cfa75078dbmr74555095ad.34.1784877586957;
        Fri, 24 Jul 2026 00:19:46 -0700 (PDT)
Received: from hu-ppapaniy-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8efe3afbsm45993805ad.33.2026.07.24.00.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 00:19:46 -0700 (PDT)
From: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 12:48:14 +0530
Subject: [PATCH RFC 09/10] arm64: dts: qcom: hamoa: Enable LLCC/DDR/DDR_QOS
 DVFS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-rfc_v8_scmi_memlat-v1-9-cb732bcff1f4@oss.qualcomm.com>
References: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
In-Reply-To: <20260724-rfc_v8_scmi_memlat-v1-0-cb732bcff1f4@oss.qualcomm.com>
To: Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>,
        Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784877514; l=1007;
 i=pragnesh.papaniya@oss.qualcomm.com; s=20260120; h=from:subject:message-id;
 bh=8tKdt4fKJhT/tYsqDka1HLDRza+yiVyfZcS7BTSC5l0=;
 b=ElL7bMtCXym3FQCEHsNOAZ7OqHreyEim7+hA/4Ik410F2ff4uLS6Ygqlqda19xM3CYybnTvEV
 WCJ5kWpaYhwCMF/CKunvlKt6HUtpNwDIoAQtQGMSPWQdpDEw01Z8B8w
X-Developer-Key: i=pragnesh.papaniya@oss.qualcomm.com; a=ed25519;
 pk=09P9nFmZLXJ9+4Jx10ZK5rIW0Fmk79A/DLErm6aVA0c=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfX9IPoMMVJlPHI
 yz9afh3Q/LR5gTaYRF1rYfqpySc5jMElUNJ3J41vv484llYEbSgYjFxFfB0c50Wh9M/VnY4lAlz
 i3Xqcna9XdOWK3nj5ep1Ia5ZY+tM3LQ=
X-Authority-Analysis: v=2.4 cv=BIODalQG c=1 sm=1 tr=0 ts=6a631215 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=8E_iI_7X9U7aA52Mj5gA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: RhoxFsrQ1NNSd2Ear7DtFNvBcNFxlyMe
X-Proofpoint-GUID: RhoxFsrQ1NNSd2Ear7DtFNvBcNFxlyMe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA2NSBTYWx0ZWRfXwjRzHE5ftKJM
 50h6IFV4dyRK1BnaJwh7HqK5USXeOu90lM/mvlR3rAUGw2wWPd1qZNGqxk6OEaVlHu8C0watXuG
 zbIIriTuJHSDNitFop7oEn2Xxkd+WOuTM5BaRUiNRzNgQLmk4+82mo/xI4G1BIHsbVeFHUDCdF6
 U+0tMRT5LB0Hum+E/DUONqKJGQEURNFUk8UoDqOlYxC5J59UrlZtdzO3umeDKSUbEpIAQButtGr
 bDg4YFg02AH2aD89QZko2WkQ7KpOQto+0qh2rgQwEl38oqzMLLs0XTXn6ytBDu8hRvjuZ9KGl0r
 pG67IDFXq7MNjFGHMw02+q/Fw4Zjbgr9lxsQCMv50dI3dzOVX27l4GZ264kdJD++RiFU6dxkOyw
 NzWUi3YVhhvfV4WJlEWmqdVGXW2ZpjuT0KDJmf1lUFsqGTcrTraxHPUF/6KdUS2XtMYZyioObq4
 BWTLIv1Q9v9FtP4ssLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_01,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240065

From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>

On Qualcomm Hamoa SoCs, the memlat governor and the mechanism for
controlling the LLCC and DDR/DDR_QOS frequencies run on the CPU Control
Processor (CPUCP) and are exposed via the QCOM SCMI Generic Extension
protocol. Add the SCMI vendor protocol node required for the QCOM
SCMI Generic Extension protocol to probe and get functional bus DVFS
on Hamoa/Purwa SoCs.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Signed-off-by: Pragnesh Papaniya <pragnesh.papaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 09527dcf9576..e9e75c4c4da6 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -340,6 +340,10 @@ scmi_dvfs: protocol@13 {
 				reg = <0x13>;
 				#power-domain-cells = <1>;
 			};
+
+			scmi_vendor: protocol@80 {
+				reg = <0x80>;
+			};
 		};
 	};
 

-- 
2.34.1

