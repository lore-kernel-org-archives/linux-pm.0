Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A2C3EDACC
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779180445; cv=none; b=QEoDb90SyQaajeSuRdz9AbvwNUfGudofmDklFTU6izuDqHVpPVVPvAoNG2erBDtxGNJh/C03glwiYJwR8ED9IheWrCxwjEoZJpsG9gA+ZxTSXg43ueuQ6PQMTV1EYoJ2WJf2Tl00sTlvyipbzM+nRuTYvU4HSWGkNN7tsI0oQ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779180445; c=relaxed/simple;
	bh=FYChXh6LOMkPsRPbvBAEquFZdOdEOw6j4DsMHrafNQM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=itGoPolGPVBRmycDhxvLsfss8E8QmOscQi8vUesWl4MRWBeDI1otFSKIbNtWlss9Kw5hx1/A7gC+/311AgIb6E800/c+rra1ZlBnGV3P8jwLuX2Rw7hRUZ+pxIN9NfVQBrF5XbvOD+5Tx+J4HBGaRkL+p1LPXd4lUBKwgRpzVj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l3GOZC6T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=blPDBNOm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l3GOZC6T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="blPDBNOm"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J5USXL2438091
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 08:47:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wXi/JvyH9ROZcM7qSRa6T63Uyudeqbzg5wLfF57DkTM=; b=l3GOZC6TJo+pnBhE
	iRr6OrptlrrVK1gJMgv9L4pSm40BGnpBAHT3lPRVcXkc8MROvgJ46hV40ueCCsIZ
	CmMq5bsjpFXDoJxWAddj0kft8sNQJN5KuL/jh9StbhSUdR4ecdYyx8Dw1/nbFEoV
	0YQi+EbB7jwtnIdRTqhHFSMEVb+aWJjcKdi1cjMouoKD8JlOYMs9gvIygusfbkbF
	pkuDKMa+Y4inAQFsBnGzkogg2icrz1opu+zSp8I53v+Yu0aaPZdahtdgeThDMzyf
	dk9UM3v2ykHz/9W912WZkMMYYWg1iw1AbnVOn6LDbPOjguXDQLdMQ7K+y9BOK03a
	MKAU0A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e834v43qg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 08:47:22 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c829366cf25so5121178a12.0
        for <linux-pm@vger.kernel.org>; Tue, 19 May 2026 01:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779180442; x=1779785242; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXi/JvyH9ROZcM7qSRa6T63Uyudeqbzg5wLfF57DkTM=;
        b=blPDBNOm0HDaUl2os4qjioPQR8KLGj6/5sgN+5eoOs2CmfzVJHm93ss3zBCng+Il9a
         3sVvF0N0fJaDGoZoE744G1vQBxzsdPzs3Mjsv3ByD2i6tDJFPh4Vtv/CN1mhrXEirY+V
         UaPqSaIN4OJY0U3J6mxNb1ZrUnJ0wiljLk2NPdEpYJvJ5cBpmai7PhOpPOafPbC3tUIt
         RXT7Mpq6ULKcRio0gmo8PFq+GE13VzxF28CLMgS9GeEUdTQ83yAlvtoSXLado23/QrAM
         oq3EIDdNeHzGDA7v4xnWxv4KCh3IOpuC6ibJE1LcGV+c2TO0VKsCiR7sHgTqckDKkuRz
         GvSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779180442; x=1779785242;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wXi/JvyH9ROZcM7qSRa6T63Uyudeqbzg5wLfF57DkTM=;
        b=bPDbEi8GyuCmTSTpBFEUe7PAiNxRIesb9JdQI+PmiStfKs+ak9/J87nGhTzC+rtlb4
         /rzXX/+Bi34XoOVP4junX9Oi8xjfLrezt+Jk0nRioAnSL5fKn/v0EGZuibkXBKfK7UFk
         hDStvkhH5kur/aEbVAPsUDbVFMNNanN7XCh+gpNKo1A8wZnxGeRvaeXEkbCaI/EyDH/S
         utxJXtxCw4UQMv1BAdWkYW3aHsF9mozvKJUL+Ay0zldOma1AUiRqhCuDKXQ2yb42V3G3
         gMBdivhfhk5IuiX/bOmztpYUE3AsdXWEAA5ecPhTGbSdNVnitqGUlKatFkPNofRF78vm
         oY6A==
X-Forwarded-Encrypted: i=1; AFNElJ/nsmTjv7lVNgsn98NMjCAcov49Vex5CqGAvMW77pIwGDJ51rM47rD4VM+bG0/CcDACZpuj1rYxJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwiKma31k6VWPah0PVVHudu8KGaZcyCHf6j6dKDRNkS6Cv0rx/A
	XFB75BpZW3pocILw/Bha19km/ZA1xwRb9+5z2cCC9Mbgwxou/eW3uh+qOnVsoGqNFX4BUaUK3dZ
	OTVyASTrBi2YQfWSjPgGsQEVKqmammtgXGoOHvGpW/viwHMA2za3kWyzFtLvNcQ==
X-Gm-Gg: Acq92OFjvj7bPbtYbNtSXW3U6iABBQPvpCQi3oAhTFJCkqFHCbIIS+TAZAkEjLfH9Ie
	3zKZMIl6tH5I8Rfbr9hoG4wd/A2dzFNoDMlW1/lh0bXRtTI6C8bZhegjBTEymXA07o299pnTCKq
	2+JJysS9iWXk4tA1+/sI+XtcrYKIm6aMbKMvrp7PEuGXXQt5ihBZlsu2lV+y4XuYvv9l6NzHNf0
	kujm+ZdNkaToT9folXxdLNCrBFF3XAj/TlHR5yxkFpA9b9oEBeeTiAZuj+hXCjbalX9ZEbOUBWc
	QpwObRN0N1FBnAjsRhfkSULv4Vmv8mnSdnu/jIo+Pmp79zkbNdXuvyo1L0ONsHqy9OY6jP/gprM
	v1ST59SC6y0yEdgML8iLmpRsKavdGMGr0OzkivbdoBHE95xBLMLz2d8/pYP05Ftu/B5aSBwW4/s
	66P0tmMY8wMuD8OLMhYUh4ZtDRljVv9p6wwPJ0pB9NDqDg9Gy3t1CV/jhy
X-Received: by 2002:a05:6a00:4193:b0:82c:9126:31e3 with SMTP id d2e1a72fcca58-83f33d9dc33mr19144465b3a.26.1779180442063;
        Tue, 19 May 2026 01:47:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:4193:b0:82c:9126:31e3 with SMTP id d2e1a72fcca58-83f33d9dc33mr19144431b3a.26.1779180441586;
        Tue, 19 May 2026 01:47:21 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b1f5sm17434104b3a.31.2026.05.19.01.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:47:21 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Tue, 19 May 2026 14:17:05 +0530
Subject: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm IPQ9650
 support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-ipq9650_icc-v1-1-4d3554c94257@oss.qualcomm.com>
References: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
In-Reply-To: <20260519-ipq9650_icc-v1-0-4d3554c94257@oss.qualcomm.com>
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
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779180431; l=1517;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=FYChXh6LOMkPsRPbvBAEquFZdOdEOw6j4DsMHrafNQM=;
 b=USJ7wLerKKsxs68uilX0BYM7aEederB8lie723jStmaXiDWVS+aZuKfycd745LDd7a8ccscau
 dP0h0BTjkHzATgNHrPwlRec5fC55BPawW7FUwHpODwadw5VqNuz1NO7
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=F9ZnsKhN c=1 sm=1 tr=0 ts=6a0c239a cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pVUAii-imZVRLcxyQZoA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: O8RytP1qawJvyEVtNwpnQyanakYPjTMu
X-Proofpoint-GUID: O8RytP1qawJvyEVtNwpnQyanakYPjTMu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDA4NiBTYWx0ZWRfX/GAZVliWZMFA
 GrDgTylQwlvfHGeiOg1oTCCo863GbFc+n6/L2ucXCrTJ3aY3zJGemwWay25WVy21Hjj9t2ACnHc
 jKmaAMUoQ8vDrYFVcOA0gT7x2+zsQPrI1XqAXKs5nA3j5NWqFMh2q17EMwv1Vnioi2qug7SwIR6
 6Zn36yaalYMaHclUS4Ui1Z+oNaUhKF1O5mWryEAw9QDBnp3q4XGGoQLzuC5gbsUEzM6UbdtDBcF
 Km/dOuQDTCFY4ww69UAehPL/jdrBhtLc2hhbLBp6u0Pv/9dWicG8YfFzXWPhtF/CznnmltM8SMO
 mbHYQjovT3NbSSHYJ07qNWLYXOkwVF3PPGAHAA40j7HatpWaS5LWuzR+AgBwyWrgBzGNs8g7tZx
 IWhP6wcTzQx21UM2ix6w1ioYlwhvE3YRhmjSgYj8ubyx0I6hP+K8xgOsIE4AANC+8UY+jhURybc
 IHMjYCd8kWFYxpUrMgg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605190086

Add master/slave IDs for Qualcomm IPQ9650 Network-on-Chip interfaces to
support the gcc-ipq9650 driver in providing interconnect services via
the icc-clk framework.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 include/dt-bindings/interconnect/qcom,ipq9650.h | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/include/dt-bindings/interconnect/qcom,ipq9650.h b/include/dt-bindings/interconnect/qcom,ipq9650.h
new file mode 100644
index 000000000000..023a3878cc08
--- /dev/null
+++ b/include/dt-bindings/interconnect/qcom,ipq9650.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+#ifndef INTERCONNECT_QCOM_IPQ9650_H
+#define INTERCONNECT_QCOM_IPQ9650_H
+
+#define MASTER_ANOC_PCIE0		0
+#define SLAVE_ANOC_PCIE0		1
+#define MASTER_CNOC_PCIE0		2
+#define SLAVE_CNOC_PCIE0		3
+#define MASTER_ANOC_PCIE1		4
+#define SLAVE_ANOC_PCIE1		5
+#define MASTER_CNOC_PCIE1		6
+#define SLAVE_CNOC_PCIE1		7
+#define MASTER_ANOC_PCIE2		8
+#define SLAVE_ANOC_PCIE2		9
+#define MASTER_CNOC_PCIE2		10
+#define SLAVE_CNOC_PCIE2		11
+#define MASTER_ANOC_PCIE3		12
+#define SLAVE_ANOC_PCIE3		13
+#define MASTER_CNOC_PCIE3		14
+#define SLAVE_CNOC_PCIE3		15
+#define MASTER_ANOC_PCIE4		16
+#define SLAVE_ANOC_PCIE4		17
+#define MASTER_CNOC_PCIE4		18
+#define SLAVE_CNOC_PCIE4		19
+#define MASTER_SNOC_USB			20
+#define SLAVE_SNOC_USB			21
+
+#endif /* INTERCONNECT_QCOM_IPQ9650_H */

-- 
2.34.1

