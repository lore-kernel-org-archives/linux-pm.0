Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AED42E0B58
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 02:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776823530; cv=none; b=bIW28JFDOuE7DRK5OzoNSEjC9uzqIDMWqPE80QZ8gmCLbBWRVO9iOexJamkdSGtgeUz0nyBkmSrdexGokzIzBe949ob9CXeitdlrEalShfhvT1Alpa5fS5gyT4mwKocgVyX6hDVy/AmDleFmJ4BcAV0Vq1mU7MhIiQinFkQ1QJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776823530; c=relaxed/simple;
	bh=6HcvqUed7v2N5oBAU18sLlJgrkv3LHxTQPb4Kg3jVeg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A3Q0R0YsI4u3fjJ4YCJEZGTh5YPohieXcRqWQkYWPwUnrl+qIip5smi3aQjqfe7qI8u96SzJNXsl5UBjYHPBdQSXgxJ/TDVZSqNFVP0m6R7LpLQSHP5a7sh4pDFxOHSM8J1POacgjmHCC+BcPKmPJSOdVmr+7urzX+4CyIQONIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=i5J/0cCn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OIqahcPI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="i5J/0cCn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OIqahcPI"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LIZlCx4051051
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 02:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=M+DKp4V79NVJCum/nrwlat
	6stdUvJm51YY820HIGS6U=; b=i5J/0cCn9E4bzvVnKt4sXzyK4pRm/w/i5XdLoW
	2jLy6kSLG0XNF0kF74JEgVYktndSy3+/UtHMh0YUn0TvM/grF5aF8/CkVTfZ4lgO
	w1Llprb/znO4mD7uzwccOoZVMWYpfagSq59rYFvEjlZDg2cwUkPZahPp/7qwfEQS
	5LeN29eAbcgGUEHi0FlrJ/UKOu80IeaVrRlGpyti2bcryVMpyY9OUFpFjjN4KC98
	IymzJVTfEZxjTTGp77po6s3L4DQZ2YrLZBsWbjGTKOnmFedJP0ujIT/cjE9/ZyI8
	0koyRqeJwklVOi3W49gp5tv1URT2fEn1ioMuMH9xT4nW5tZg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dpenfh7wt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 02:05:28 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-82f460260cfso5132691b3a.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 19:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776823528; x=1777428328; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+DKp4V79NVJCum/nrwlat6stdUvJm51YY820HIGS6U=;
        b=OIqahcPI6eyzaWisT7WAZg0N6Ky9s9Nbyt5zGNX/Ng6njVEH1ZFJ28f9dhaSCQUjrA
         LPC4ev09TiVxnnqwt7GQfvEXJsVjOMlCi8dOawYdcOLQErhxXbgExCA6UKDjX4g9Ut3C
         Z9g+aXWXfJqDiV4FjEaXhaxKz2v+kJuE1NsmHS5x16MzmzA6C5iw5tahzAa3Z6NrTynL
         zpvg73be59h8z0svLf51j8VbWMXXzjNzCcmqQP0vuejhctkW8Qi8yMpmwxufRZLtbcEX
         wb5YujANlliP7Op8+0lt3y5oPO/1UdyNf91oHkRMaFxU1E5zyW8L4cRbD95SWeBjxY4o
         69Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776823528; x=1777428328;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+DKp4V79NVJCum/nrwlat6stdUvJm51YY820HIGS6U=;
        b=MN46Lmkb8be1OEyiuf945lBfuomFm3s6pcnMmiTsr9DPIJva+KrL5lPaLc2jaZOT+y
         oYYOwfJr+lEX7bevCryazAjrdVbZr3aglxkv4iuiIaYyvLRPCPDwbF5KtwjLb7lDXVPC
         r+cbL2MvIjZRMi+CdpoTJXF3XJclcPrmiE/5UvzpxbiObBOXzJL9EuEBAakjbLS//0Yx
         PCM31GlBdLOvf2e6PApOCx57C2poWGxXroLuXBtyU2zGrMd+PB/GAHG94GQIGYNGkZub
         YOaUM8EeogaWJte2fgxg9RZl+qKKvPvyGtyr4AzF1oOjuDtLiiTfCHOn+6WBV+PLaIhi
         CKZg==
X-Forwarded-Encrypted: i=1; AFNElJ+5b6VIF9ZlbhZ9bBsa02N0tiUTHdV6MZOOsGDFgnEobwBFwBRSo2y2Mppz2MQmWpz3AZRENYl7rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBX94SRzwOGuNKMz6zVqBe31WJ3zcUFCn4Ivkkgvia8yiuKyrp
	Pdpe7rwFew1YQSkiM702NePRIpRV7bmOVaJk3OLFSV8AOJYnozo8BY08n3rZk8sJatTjt1TDC4s
	d7L9TDnL5L0UPsAUqDTBErXuyaStr3i4frChF0wma7kdh9AuBNfpr3db27op/jQ==
X-Gm-Gg: AeBDievgvtTczgNkpefEo1yuvJJ7I5eNNKwWDdsk0CWRQM9Q97IWQHPoDkfTB1qZ4Lr
	6lz8m5f/4TsqTtjP/6kWT730+EocZWOEa4DVHsRtoXMSiO80GfSjsrvWbauJ+hIt9W0K0L7dg2S
	1NGu+mucAQd0ZPF9kHrmeD3MyyxNXOCbE7WIgIL5GFLZJ4CgqLocKdeklMRcavCHkjKItS4Mi/v
	S2G0w3C58xiygFL8M7ZfsCQVSkz2ZoOrGmAd1znGVlWEzOCJyQ7Fq+rEIueaBZjZ617EOlqWR4j
	9uEG5+ziv/vEpEgo6H5LhDdX4uHhKUCyb+4jwhMVanuF5iJqXbfMy5tdpt8qv7gWdVpyfdlUwZo
	Hi1VdEaJFh5sJG+CvscKffrb+Tmnj0UCDeMaUIbCSdkwwBWEWYh4qG7lL7tLzdBWK5w==
X-Received: by 2002:a05:6a00:418b:b0:82c:7383:3745 with SMTP id d2e1a72fcca58-82f8c834458mr21906651b3a.19.1776823528039;
        Tue, 21 Apr 2026 19:05:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:418b:b0:82c:7383:3745 with SMTP id d2e1a72fcca58-82f8c834458mr21906603b3a.19.1776823527530;
        Tue, 21 Apr 2026 19:05:27 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981be6sm18040368b3a.9.2026.04.21.19.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 19:05:26 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 0/3] Enable QoS configuration on X1E80100
Date: Wed, 22 Apr 2026 02:05:10 +0000
Message-Id: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANYs6GkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDE0MT3QrDVAsDQwOD+ML8Yl3zFEuzZIskE/OklDQloJaCotS0zAqwcdG
 xEH5xaVJWanIJyAyl2loAak4bnHAAAAA=
X-Change-ID: 20260414-x1e80100_qos-7d96c8b47bdf
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDAxOSBTYWx0ZWRfXxrgYY+i+qBmL
 m3VkY/AqASfid5pYnYxZKfj7OSRXk+KARTvUrmvuF5Y9LcAJEu3cz5++WoQjDxY3rdJzl2DQnme
 p6xQw+sPNRZf94a6uCLvUxaH9rxYsQoN1jrknCKZFmIkD6WTaILDPBJuVH61YQLThYqvq30hzsY
 j6RA4wf6hUNN00eM1feEtHEHJ7ynzQ/jJWSItdRSw3vFsSBWKMfoX+e2FhxAiE8WPlI74NScRa5
 jKAAOQVKbrqzkCoCpGGlu1MF3hIEJlS5J7zZt/fBpbHYROy/H1zt6u0cC1ZUTQiwXT8e0sc2P45
 LzRzUunjLJJd9FdmSrV7ADHs37m8j3dIhjxllSgVm61yxTaLS/9zuGyMq0okPaFtanTDnVtAa78
 dqG4ZsBqqbfo5joFc04fwOYIzegcNS7nTA7WjDIyCCSoF09HwSQIMx7/IwDRpnQ6ULSLOMGBUpE
 8nfmMtVJDvQyRATorlw==
X-Authority-Analysis: v=2.4 cv=VMrtWdPX c=1 sm=1 tr=0 ts=69e82ce8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=sTjs9E8jwIvs1E9oOeMA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 8UYcEwC_fOE93LwabnVuuDWk2y1zYXUr
X-Proofpoint-ORIG-GUID: 8UYcEwC_fOE93LwabnVuuDWk2y1zYXUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604220019

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
Raviteja Laggyshetty (3):
      dt-bindings: interconnect: qcom,x1e80100-rpmh: add clocks property to enable QoS
      interconnect: qcom: x1e80100: enable QoS configuration
      arm64: dts: qcom: x1e80100: Add clocks for QoS configuration

 .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  |  62 +++
 arch/arm64/boot/dts/qcom/hamoa.dtsi                |   9 +
 drivers/interconnect/qcom/x1e80100.c               | 485 +++++++++++++++++++++
 3 files changed, 556 insertions(+)
---
base-commit: e6efabc0afca02efa263aba533f35d90117ab283
change-id: 20260414-x1e80100_qos-7d96c8b47bdf

Best regards,
--  
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

