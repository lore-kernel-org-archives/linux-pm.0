Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5631F9A7
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652231; cv=none; b=Z1F0YEcn2QFz47KVqAn4clhPKDQzZehR9LEz0dbtHgGSKeHfJEZM3IH/mIqEG4L7AaGg+JevtJumX0r5vXPACoejUqvPFanqqF8MKqczUwjwZ8LGciL+79e7H/MxhSnm5kSJaRA0TaPOnVCW7wWJQ8U7fUWcIX5QkgfeoK6GN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652231; c=relaxed/simple;
	bh=Vz2BIF9TW4ki6ziv8QKNjfSxoTLe7EEEgTXv+K8gJlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hTaTz8WUwL/Rs1XXo57xXZCCDa2pkFrkeZMKejkhElhhVvmm15EaQK0xjVuBE0SXBxFf8apN9NiOyPmRDhgNi0f9l5EvYtFpv0Sdbjocfv0sPUxSYbHJtCrvicEm+UyaT5hxHPDPllqChWJeA/JwDSjxlmR6NTrqSAKdA57HQEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TzqOMA7E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QC6n3htE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TzqOMA7E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QC6n3htE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64O1K3W83421462
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rlad6Hzrp4mTjFgHb04nT42FLPFWGLcPO3WBhYIif38=; b=TzqOMA7EUZjQeR+1
	jU7v54wSvs7zdsKYZl4Of+z058pKt+czMcmAInCzPKmDehbJEcR5pElDNwyNk9ju
	nyy3E4MaNAP9YceXK4HS/2w+6mY8XRKt4ZJgn9q/zM+Mv8Nn/QHnIpe5OB0Lc7M4
	quvKZoXp9lsib94mwcZYyDEmesiaPPe6l78NW5toydJ452LtfotGJ/79HF5T1Ohn
	ArJEHo/7hgikONlkcKW0ivNXwGbr/LUkCqLXnqB+wD02FH63sRj+k5m+1xpfd333
	QC6qAhLfCQTiH1promgP8UlPiQrGZ56Knafirs25ISH+tairfKJeNshBT8HHUyqU
	yYnuBA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4asuwag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:50:28 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36603ad6709so7395622a91.2
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652228; x=1780257028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rlad6Hzrp4mTjFgHb04nT42FLPFWGLcPO3WBhYIif38=;
        b=QC6n3htEuEK4GTgunl7I/zvYMRWeZIh3Rnt9P6Hx18M97+VggfvWnSLy0nNQ+raY8H
         nAETv83P4ciQO3OjC0ijQstbgPBGE8XtgGF/KjSuMJq3/DfWOL9U1ETEF+jUgcK39BXW
         XbvRHeME+LFNp3DPIUW0ONGMj3OOUUFCC3X/L8SZvx/oM1kqzenS+fLMCH96dtaS+Ksh
         zis9W5TlwB/hB4VZW653pELvRQQPv19D7XnfzkuQ4AFBFnjLRpGD0Nrk1KiU2/5xdBLi
         qiq69sw1YSZ/BShK3CuOv9Q2VluJsUZ6mYuXm3CiHteFeRd+1ki9nw6NSKEaY5Y4RvBS
         l+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652228; x=1780257028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rlad6Hzrp4mTjFgHb04nT42FLPFWGLcPO3WBhYIif38=;
        b=U1haBGzVzvAPewD+QJ/iZpR9MEkH71CUDzjYMcgk5/4vbhvGCfx2T5WTL55nz0Gkkf
         QmgmMJgdv40WJ9inZcnJC24DXpEIKZWGC7tgdaSDeU8pHKvCXlvc019QFEcZnUbXG3Lm
         CX4cehOsO+MBsFVbwOFcQu4Gura9R3kYlcWgfqz5RMjrfBBGEAEI24LpkFG+QKzSS/WV
         aY6anW9pOJXwcouAxH1LcCas4HmAd8Ht1AzUtS5kX1NA8jiXk0TS8YHkrxWEJE/DkvSo
         Rla+clU1uhIZGzKIxdvatfVr+hsgFDdeMsWzQksUBDsJ6NQfXESoYGb2t3lQzDhy7V0B
         XzKQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ajvpPlRnqJK3D9flrbdxGsfm9uuD+0V/gp3wkTwL2uIXJRxOPdOP/wmzuGuo5g15J4FKV7S7OVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwckzZe5SsEpI6pspRd76L6podR5jtEIo+sfJ4ahV6z4INqy7T8
	tQCekAVdAvqjMsGoD3qNYSXHUXuh+E4APcRx8f5uyXz0GvDv3T57yFlSxoKlhXE6LzcM3GI/drq
	Fb6aCA4X1PTtG4TzGweaDQK+oXsMav73Hl2JmXRqiPA3N9EOu4+nQqz47AcfUxw==
X-Gm-Gg: Acq92OF2fn9mallSQTyPfV8FUHO6UGCtta/Quq85UMQWD2wKB5zqzzZwZt5SSqCTz/4
	Z/rhAnogRYWUfpjOoTI5ApUpeHFfRnDpuU3pdGoED1FyeoEZGPG4hvCV3KmylyOWvHoG2eXToLm
	6zAwCKi2KAa+Um6pkGQs4pkGYKYCoqggqfpyM/qQ75HKvRuCPS+wZAPcRczzhoPOsigoViQ9ZhS
	p5HzGKbbWMAhyTlwPXtSy4OkzyNc5CydL+UxWb6+1BSh7yoMhmOgXWGBzDuvtJ7TwZVDaxLLRiv
	MDEpXDaHuPGSP3RPA2CTFT6LO2AA62RgZdRD7sghX3bbV1BsMrlgz6LOLKVBwF6t4whGnaUK3cu
	xE38hpknsg7djfEUzNxsT06bfoZUuyb4Gw6vK
X-Received: by 2002:a17:90b:3887:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-36a6787b0dcmr11506409a91.23.1779652227789;
        Sun, 24 May 2026 12:50:27 -0700 (PDT)
X-Received: by 2002:a17:90b:3887:b0:369:a359:b181 with SMTP id 98e67ed59e1d1-36a6787b0dcmr11506390a91.23.1779652227058;
        Sun, 24 May 2026 12:50:27 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:50:26 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:15 +0530
Subject: [PATCH 11/16] arm64: dts: qcom: shikra-cqs: Enable CDSP, LPAICP
 and MPSS
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-11-f51a9838dbaa@oss.qualcomm.com>
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
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=1019;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=GucbWW/nFHFiZEGD33wM3Rnwy0m6WPWGvo2JLbPdcsg=;
 b=YtSelh8auZ7dVbUaHH25HcPzgxjdYFncvYyVzuCZoNg4OFHJajNckigAF0yuiXoxr2kmgm9DR
 fo9e0R00o+aDH5ZUa2oFGCNiRCEJnr33h7K+yjKzpj5T+UCAhnfMNDq
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXw9pvP9T832Vr
 Bg9cmk6uB/0l1v/15l+rG0LnJL3LE+u/N5lm9ORd0CEmKkQxYWyjRThWrQmuvKeGyt+5P4f9fPA
 IdYg0CsnuZtH/gwECUwNUPBpWS5FTnOF+e6Ukgc6gFxSDNrtIfj7FLrmoPzS9vzd0WJeTuFaR2e
 n9k+AA4fFWMeULJ2XmBJrwDL4K00Sz+SxJXe8Pmm/jjQIjHUmGTLYpshR1Vv0m6q4neruUDdQNi
 b63GZT+WefkQHNPtnm0MZDos4k1E99eUUUvQyfy9xxBMWZvDDTyCQpX3KUAk12ZItMkm8I14a2t
 IwvJvDZMnwvHy305PBjpO10kZss+DVViw3Zvvgd6RUsC24w9RYUCYFz/X6icgyWps1gQiT8NYx0
 EKoDIIsY0RNxpg0Z5TzAD1eDrTAhOHepPXADcCtGd7ZBNx+dlFncKfrenUKNQEmrqn3vZAQyUPF
 Bfl+xPVzKIWO++w14iw==
X-Proofpoint-ORIG-GUID: T1EpJN4DjZfB1aCz7cuII910VP1N_Ql0
X-Proofpoint-GUID: T1EpJN4DjZfB1aCz7cuII910VP1N_Ql0
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a135684 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=0ebg2YenFEddjv6MTxsA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605240198

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Enable CDSP, LPAICP and MPSS for Qualcomm's Shikra CQS EVK board.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
index b3f19a64d7ae..e62ba5aef71f 100644
--- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
+++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
@@ -23,6 +23,25 @@ chosen {
 	};
 };
 
+&remoteproc_cdsp {
+	firmware-name = "qcom/shikra/cdsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_lpaicp {
+	firmware-name = "qcom/shikra/lpaicp.mbn",
+			"qcom/shikra/lpaicp_dtb.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_mpss {
+	firmware-name = "qcom/shikra/cqs/qdsp6sw.mbn";
+
+	status = "okay";
+};
+
 &sdhc_1 {
 	vmmc-supply = <&pm4125_l20>;
 	vqmmc-supply = <&pm4125_l14>;

-- 
2.34.1

