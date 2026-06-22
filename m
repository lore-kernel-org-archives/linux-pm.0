Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8638135C1A1
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782108421; cv=none; b=fm8NdMsmom2KNikx/krT9gc0TBWvRbr+aOK9xjVw0HJTGeWkD/LU7Hi1DvtQnG12WpXjLNZ9lcCQeb2cTT/JOZluKeAX8TtuJccZxrS7FZFA+qvph/b4t1KnMUzau6mKge1h7H1Gi85r/CCAb2fPLPVJnEJAfoaZMXox99FLSzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782108421; c=relaxed/simple;
	bh=ubLzHNuLOlqyHCkLGy0Ft+KI4+N2WXl04jTpiJEwBvw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k0oQ8YFzPn/Pr1aBoCb/JgZnMz6HHRppZraf/HdKXT7hrdHeDAYHVUutjWEeoCTjVKSiVYOraeoeSd08h6oDJ42p2URTzXTCVC3jgkm0C1H/6FdDzvn3M8n+ctiwuzRY6pLJOy7eTqaenhPxk4luY0kP/g2O1N880c7n9Ml4j9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LwgxFQRd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SQ+om3pJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LwgxFQRd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SQ+om3pJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M5BKTw255319
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kg/rF3NAlx/Bq1/cawAmea
	0GVMVsUfiloyx/XCuDl50=; b=LwgxFQRdPTw70usH0IUq/QoUIrmb3uwdBGn5gG
	cxJSja5ZCsxbKki4076MjwxAxrbroMkXrAJMlJfffp+VjMMBKsHGhxMnnoyCj1Mp
	0DfestD+u5lN47vWFB0mYQHiKUJC+Iq+VdLNWZnncgBzPBiv1PM/ZXrUCMiSvPAj
	EQA8O0vZUF+KSMnjWtT0P32qOGgTR7ftddpXC8ZB6kAUg/UsvIBJ6IH725SIub+0
	+gD/ZqSO+LHtlQeIv1iT82C54/jBe6Sq29eAy8+Me1W9rJ8s9SEnVxE9V50Zww9I
	Cu44PTcf15WbpXNv/I4N8l8YQqZEnXXf9EAHPLZ4rdq62vYA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewhv5n43d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 06:06:59 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8428384f31fso2844278b3a.3
        for <linux-pm@vger.kernel.org>; Sun, 21 Jun 2026 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782108418; x=1782713218; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kg/rF3NAlx/Bq1/cawAmea0GVMVsUfiloyx/XCuDl50=;
        b=SQ+om3pJ/gmHS5wlIMkQRP5AD0Dkf9bXlTnqjnZoQhjyE6Dz7hmoW5Awa79mYLez4J
         f4phV8+0+k7WyovZnM4Q0XtSLtkKkzyIZcNsSFIYg3rJ/0/QoFF5DxCjl3IhjKjb+BrM
         uEqmzCOAy8ivG19wzLhEPimOH5NL/Ohh6CRWmI4yLMHwo4mO2KxsguOlbXQ3T2MGNk3/
         +wnqGBl633hCgqyETdKJr2uMz6z1GObrQxK3+Eu9M9BfMXHW6CNjJD+GQuvcA6l2bIXG
         H5ClgledkI2jzcwzN5fDN36annBZ17wfVV1khK2P6BU58wI+NHxSA8jJqXr0NRoK29dH
         ZvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782108418; x=1782713218;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kg/rF3NAlx/Bq1/cawAmea0GVMVsUfiloyx/XCuDl50=;
        b=dhWNBOU60Uz8or6mafoepfqvnC5BJ6egNuOI5eH2dAxx7y8fngHImW9M8c7kQgdnat
         m3QeB1lC7UnzNZp1SouWCP6AX+28WJaYdXze8aZvEW+UIgytnmip44yNZFMs91hID+eP
         i8qhpLiuMxH3sD3EJaLf06DZH50SHuNekQoulhY9o/pN/YlrWLaWIzZs0d3hObNvC3qv
         uSyupBsBbYoKPTz7U6mJNR5lBwZFY2eSQJZ7RBLnmtxy5Ia8CwPDkmlamJFgn4fts1f5
         H9sPgi4yP+cuGRLeAW+uVTogslJQv4J7TqiNHJsuVC74qKdUxywlNH1CYatBaJCmUR+l
         e1XA==
X-Forwarded-Encrypted: i=1; AFNElJ+SngcHy70otN6moLksRH9lLP+VMOZ77vF63PX8RJl2L+uQRnIlK0ETphSIdlbUGf+foCCqhS/74g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN8wISkQwku91opyQijbrdrUflqTpO0IPzitAvGX7/lrDak5ZN
	s6vaD7a9CYB0DEHFVHniAoOW8JSxrJnd2F8gePP0Sypx9HZpMWLR5DAxmiJ12YeohAStcBneUiD
	ubEHYc/Yj2QTrX4YjUVdDWMwiuFAzshPI2SRBI7jthI06EU7FkNAeWdTcWI7+Sg==
X-Gm-Gg: AfdE7cnBgwk9gNhgFuWyjepg4ZnA+UY/+/7F8IEO7scu8K4KQevAd/8G/DxUYnt/FNM
	x4Gui4beI+PCTlr0MY+k0bq/q96NyYhCvE0ya1lFo5RrSivT8B+k6pwuyhW+UEYZZvE/Wv9qAFy
	P21IaRUqOofmlfeFEr9S31Z348n502ZTZTBtQ3TFeK0ZG2cUx1FiyxyWB+aGyh6+6LPkv8PVNiR
	dsaK641Wd/oQN7jx0XoYzky+Df7wBu2GlXK0QgZ3UQnivTbjY4nx8zbuVmRnsMeakqp1QzJpk2z
	U3o/WFJTa0tvxU0Xlr6D1CcSOBgg4rgWeQr8raGlGBbv19+qH7LjeH5YKlyo8QYp53HL3AV+Kj+
	Ae8O9DEuaWG0EHQQYpDPm3Uth2NOasAsqmg==
X-Received: by 2002:a05:6a00:2883:b0:83e:f208:b113 with SMTP id d2e1a72fcca58-8455078c6e7mr14329406b3a.7.1782108418227;
        Sun, 21 Jun 2026 23:06:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:2883:b0:83e:f208:b113 with SMTP id d2e1a72fcca58-8455078c6e7mr14329374b3a.7.1782108417790;
        Sun, 21 Jun 2026 23:06:57 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84564e7696dsm8040520b3a.37.2026.06.21.23.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 23:06:57 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH 0/2] interconnect: qcom: Add support for upcoming Maili SoC
Date: Mon, 22 Jun 2026 06:06:51 +0000
Message-Id: <20260622-maili_icc-v1-0-0aa8286e6748@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPvQOGoC/yXM7QpAMBSA4VvR+W01hxS3Imm2gyNfbUgt9274+
 dTb68GRZXJQRh4snex4XQKSOAI9qKUnwSYYUGIuc0QxK564Ya1FkUmZmA5VZlII/Wap4+t7VfV
 vd7Qj6f0dwH0/0Ge0HW0AAAA=
X-Change-ID: 20260622-maili_icc-94001df2a4d3
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA1NyBTYWx0ZWRfX4nzlXX/AQGNz
 A1Rmg65J6OGPIK2r/xMxgf0uCpeLPO97oF2cmEnPfc5PUevm0GWuwFeNcFDZbYy8U7KsoQNkwIf
 /xeZhw8b97EBbP8fEKq9P8Dho79IbxilRbwBkFpTTvRHdY1Uef2w6XqV+mE0w3fKSI2eF/829Vt
 pegHwlI5uuX03HC+Zcqqx5NKx7F0i7DKHSwQJlF27dSA3CpJCVauyWaHQIj7aBHkwibQAJAgXt0
 867/M3ofle/xu8ENjuKO6lrtT3TpIGURq20xgiJ2bXATPEmZWw8uoWmHPH5v/ZOXV1HePQIl+7t
 mmyB42YA6QnNM6L++ERFE/j+HcBIWV5sJtsv0Y4vi3/anSKPswFuQIQG7lrcbyRrzrQgohieAV4
 0YeSI2JAeBfVJNfSKYx2I9mcQ9z8cGug/gP8mk9Uovx+xy3LO2FIf7L035mqqU2bqr4CMy2B+9e
 UQSCZ5C9ifqPEUsByzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA1NyBTYWx0ZWRfX1Lbh0Wjv4EE/
 rkOcsR5vgqCS1JlkNX+yJYkLwg4/Kc2RR3YRno2yugUBPc4GAAtWH1cVc4UIFKkcwXKwboOqSw9
 Y5uICsZcbzbyJG+N6R/jzfwlNWe5Acs=
X-Proofpoint-ORIG-GUID: dJS-6Em0ZGpXNJdRPWDf_h1UULqdcYPC
X-Proofpoint-GUID: dJS-6Em0ZGpXNJdRPWDf_h1UULqdcYPC
X-Authority-Analysis: v=2.4 cv=UrZT8ewB c=1 sm=1 tr=0 ts=6a38d103 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fnjDL_6DDnU8g6YDtasA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220057

Add interconnect bindings and RPMh-based interconnect driver support for
the upcoming Qualcomm Maili SoC.

Device tree changes are not part of this series, they will be posted
separately.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: qcom: document the RPMh Network-On-Chip interconnect in Maili SoC
      interconnect: qcom: add Maili interconnect provider driver

 .../bindings/interconnect/qcom,maili-rpmh.yaml     |  127 ++
 drivers/interconnect/qcom/Kconfig                  |   10 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/maili.c                  | 2091 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,maili-rpmh.h |  172 ++
 5 files changed, 2402 insertions(+)
---
base-commit: 3ce97bd3c4f18608335e709c24d6a40e7036cab8
change-id: 20260622-maili_icc-94001df2a4d3

Best regards,
--  
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

