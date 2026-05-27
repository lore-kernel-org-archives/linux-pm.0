Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A25A2F8EB6
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 05:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779860239; cv=none; b=gMb1YH7WCXkRlIpbrVNm+Q+esPywSRIv+pgMuwBB4rKot/3rT9QxclXqtgPCQvH2HBlcZIhe6nlreSc4GFxu96YWFRXEomq8NNv2H100dlqKRjy+KWxQH5bN+vE/lgilI4aiy+xNrKKC6INm5GJTq9H8SOgeXUb8KyfiF2kp8cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779860239; c=relaxed/simple;
	bh=36ClACXUF+S93hV99kFRclkoIYp0sJpJ4LbEPDHyAYU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fUG18eVxbnMhYdXrWcrB5ZuxLMsVF2PLB1MsGXtXF5aELGHkNf6lYC5nvQO2NA8jaNkWxc3A3DIUrK6LRTK1Fs9AvxFpluicVCBn2CCPRTASb8CP8gNAMx4UgdZWr5TdXwGjgTKUV9Inn/SmMAYnIl3UQ+Ru/KQZ+GH67yHALYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lOrQbIfF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=As3Sc9/J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lOrQbIfF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="As3Sc9/J"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64R2Wklo190109
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 05:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=X49bnoWpugg91pnqIUZxny
	eQ9LEoq+2gyaH12CEWKSo=; b=lOrQbIfFgeyAJ4Fvk21pxdV+JQKtkxxnTyFj+k
	D5OkA5gOXXTbzyP81gWjcXhu286h8L/JQ+xyFdgARZM+qaJsVWi/K1mFfqdqoSNs
	p+Drt3gJyo3XJJDczbplj7xNxwoLRl5OExkDSs56sU+qnxihzJFCMvPOMole7uPV
	3FesfUqIA0nN9CMus3Qs0xXYHPv2bZgomN6RCC8xFzACj2AOcyaM8zAZYKhTsvIe
	XuWLWakKB2rIzI/GhL47NOLPWDmiNXnPajqN/FJBGSXgr4lfpKCRuYcqohHnGZSH
	gGvSMh/Xx6NF1ACsldHThhmpQlNgxDS4ir9pg8ILQ7hb/Ovw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edh179svb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 05:37:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2bc977e6aedso121488245ad.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 22:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779860235; x=1780465035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X49bnoWpugg91pnqIUZxnyeQ9LEoq+2gyaH12CEWKSo=;
        b=As3Sc9/JzHF9tzmOsS74Rm8/j/X5Ihb+4pj7lWZbbiCeTSZi97ZPmJG0xmjaq9fIkg
         lQ7jZyazoX4KvLDegpKrF4Q42hh9Ql60568i231AaoR98BDCeogGg8Mkb9I1QG3O78H8
         imeXnLsFaIM4QYmPx5+PLFvTReyeL5o11HCV09nTdJgi/W7EpfcYBYIAQXj0adepLsDF
         7e9AJ1LZh+80aoXXVTc26RV4ky02zJLLlG+Pjhshnvt768Y+5KkcVMN0FzO8OsB6vpgb
         SKsg02yOM7kVHa4nfq8TfhsttEfN9OJzXsJeBMmMeFpPwUY9LlH9OD77vvUWWnuGM9h4
         PuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779860235; x=1780465035;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X49bnoWpugg91pnqIUZxnyeQ9LEoq+2gyaH12CEWKSo=;
        b=P7mpvlLb4pmx90LdyQD3NInzIXYtUSYqORFaNhI9ZrEtMbcajAgVxRfTOC6bx1CEBx
         HWUwWxGT+aPwz6OooPizvBmql+0KVi2JSw0oZYT4/RUemabY0+3tDljrCgCTOPMzqHqI
         lW4JAxrWegJSr98t1Z1mAaeVZe8vkEqiK+h1AQ9Z5jS3UhQ7fWZCyGgwAoajVSy2qDF0
         uXC+vM16D3c5US0rtXGhJNPGs96nkWqDqvph3hGAYQS3DSjnddlrlN5Oj40R6908CO1m
         MIdA5GHc2IvjK+JAhmhvWIQ5zq+SIJiklJM2q2xHuypJ6CYIMz2wSkZxG3SFjzDZja+3
         Nk/w==
X-Forwarded-Encrypted: i=1; AFNElJ87Kuua1xNqsCFtRNuJmF4r479MNVXJrVEEJWNb1rWc9cCafJKVsBY4NeYKuQzAoG8xJ/cqSZtsag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDnm6fpzrksKREGK8tyc4xN6piNJC9yskWduUWKm4/LcHGamXj
	zzyO7/cbOL/MNR7PyIxZDfPh8PI82pJPw6zne8JMjjK/oa/vZXSS8QF3UTjLTTuUXFv0gSbjcAf
	b+xhD+Ungd5i8skp/Dl57SYJvOgT/xCNhUra3fibPC3BgItjCNo5kA9SiDB8pkg==
X-Gm-Gg: Acq92OGE/GiarqN7mEvvlxhQ0unUIyJW8LLpqc1x7qGEvkzMvXnQg+W9vw9g+Q3xIkm
	uHGMvzi/UBcvuwikCugedh6Qu+2N9C3Y206XMCO9QXM8wCDbp+RRY8SlWdRGuN9q1LPLjSoWCrw
	J3nckt/HRoJ5aeowN4oE3WOQNO5Uut1/i1TLQZ5LYc252z8IfRx46wqL/YwVofNO1L64ByuxeSw
	2DdfcyetTyErtfevA/oFu/pjx8RCT9yS8X5Onq+f4LOoz8JuBkIXBCdbv2eJpwK7+DGnDs0SUa8
	JxxVw3r+KYn282EM3/1BMRT+ZCl9mUGqpN+iH8oROfBOOCrUfet37OzQfDJMKDQZU8yM99wTwL7
	dxsFmpY8vXUsD7dJFrPKHG7/OWyVt4VahO6ju8XXX91es6eJIpnHCZkY=
X-Received: by 2002:a17:903:1b70:b0:2bc:cf06:6835 with SMTP id d9443c01a7336-2beb0346047mr230299165ad.8.1779860235528;
        Tue, 26 May 2026 22:37:15 -0700 (PDT)
X-Received: by 2002:a17:903:1b70:b0:2bc:cf06:6835 with SMTP id d9443c01a7336-2beb0346047mr230298895ad.8.1779860235068;
        Tue, 26 May 2026 22:37:15 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb569592dsm136338585ad.16.2026.05.26.22.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 22:37:14 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Enable QoS configuration on X1E80100
Date: Wed, 27 May 2026 05:37:08 +0000
Message-Id: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASDFmoC/1WNwQ6CMBBEf4Xs2ZK2aQA9+R+GGLosUiNWukAwh
 H+3oBcvk7xk5s0CTMERwylZINDk2PlnBH1IANvqeSPh6sigpc6kUUbMigqppLz2nkVeHzMsrMl
 t3UCcvAI1bt51l/LLPNo74bA5tkbrePDhvf9Nauv91Fr/qyclpLCIumrIIObF2TOn/Vg90HddG
 gPKdV0/8/2FHsEAAAA=
X-Change-ID: 20260414-x1e80100_qos-7d96c8b47bdf
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: Pkfezk5Jx-TTSfV0208DZToGHIIYTN51
X-Proofpoint-GUID: Pkfezk5Jx-TTSfV0208DZToGHIIYTN51
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDA1MSBTYWx0ZWRfX3sc2BfnEdUMm
 pro0mRbgUkTZVU3F9QTwZCPP97KrsGI7MP9C5EgSZ2s0q52qsZR3PdWKrMW5fbGWftUmJxJR5QX
 Y4rZLfwQayWZvvFs4BhszwZ+MicJOSZeO+b5s84bh6GzV84NENYsKYqr3eUze2oZVPjIoBjNMc/
 QSKxtmMLdX1kG+zx26DREFgY9kGo/lgcNIfdbGPhUXXpPjNwAgvUt6BCO9CjPpklPZPYcmDurau
 9GIDGDY5Ei3WbMJ8DaYMs0DG8gjJymUu9lmPkiaunrOcVVirpda1EgXVGnwyw1IvVx61aCG2RY7
 6I59kVgyZCjER1p/rMHVrJDxtAhWcEq5pKf97O0auj7AgmPRVxibg/Yb7+MXeQnidmSflcEyXjN
 a6HkKFf5bO/TEKueu9DWFnYTbdqecGSUZjHwNgs8umuySzeUFexmE8WQokg6xMBK8PbdAI80W4E
 xiY7a6WDO53xe2tZFJQ==
X-Authority-Analysis: v=2.4 cv=Gc0nWwXL c=1 sm=1 tr=0 ts=6a16830c cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=sTjs9E8jwIvs1E9oOeMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_05,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605270051

This series enables QoS configuration for QNOC type device which
can be found on X1E80100 platform. It enables QoS configuration
for master ports with predefined priority and urgency forwarding.
This helps in prioritizing the traffic originating from different
interconnect masters at NOC (Network On Chip).

The system may function normally without this feature. However,
enabling QoS helps optimize latency and bandwidth across subsystems
like CPU, GPU, and multimedia engines, which becomes important in
high-throughput scenarios. This is a feature aimed at performance
enhancement to improve system performance under concurrent workloads.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
Changes in v2:
 - Update the dt-bindings to make the clock property optional, since the
   device can operate without QoS, preserving the backward compatibility.
   [Krzysztof]
 - Link to v1: https://patch.msgid.link/20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com

---
Raviteja Laggyshetty (3):
      dt-bindings: interconnect: qcom,x1e80100-rpmh: add clocks property to enable QoS
      interconnect: qcom: x1e80100: enable QoS configuration
      arm64: dts: qcom: x1e80100: Add clocks for QoS configuration

 .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  |  72 +++
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |   9 +
 drivers/interconnect/qcom/x1e80100.c               | 485 +++++++++++++++++++++
 3 files changed, 566 insertions(+)
---
base-commit: e7e28506af98ce4e1059e5ec59334b335c00a246
change-id: 20260414-x1e80100_qos-7d96c8b47bdf

Best regards,
--  
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

