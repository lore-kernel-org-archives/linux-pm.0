Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A37A932
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228646; cv=none; b=FVA0+BoGAQMKRAvhtThyIoZfEwk9IaHzWMjdp+wjxVK8A3PHOzRrYkIRm1IQbH3mCYQJ8JP0BmbSkzHLqyqNrlj3iEOyJ9fop3XUTRgroE0eXk924g+gPIlysA4rUXdkCW4qQYIhqtC6ht9BzLgBU9z4w2swhB24PsIgv8WuDRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228646; c=relaxed/simple;
	bh=nooIqcP1KZppGTp7stNNhr5DaRnd3a7QK5NHg3OEPJo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Q764C2oOIUh98VRbEP3sFDGXGYowb6NBr/5gBxJ5H12P0yOtfNuVV6necUBYPxgYonNkhH2VYKilkH6Lr2QfvHanB0l7bXgvbI4kSVlSaDFNDvsVSbjGr0PcTyxloIM6V5MofMELDhtVzpo820ZwImS/8Jnydjx12wWyIAF3NlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Np0JdmM5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EvxfoJwU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Np0JdmM5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EvxfoJwU"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N0PcPA1493622
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FbXvEP3nYVrkLWj+0fdWcG
	adpdPA4IA0DWc0/CaJGxE=; b=Np0JdmM5gxcAwhi964SCGyuoFNLYbQ8uiU3JDL
	Ep++3ZL9RRfVzJZz/tCAwr0jkrWcYpTupp+RCCp7kRbkASV7psWtsFA35Lp9QoyY
	HQ+VCDG2wK/bjwCCeHXLa0kZtQJrEzlKvvFmxtXHb1y5eGRSYaRRlnPoZqVCQQZz
	9R2b/AoUX7uxNg5hdDG/7NhcY+zhjvIVH4kLswp5jipO6FVteKzug2wWfRdWTqGM
	Khu/uX+Ly0d1DbholO23sEmFJRl/o3jY9Yxv51eTpv8Du5wEnB+a2qT00vb07Shz
	XcCfnWTrp5MCeTbaWS1KHAEAjXBLaz09qSQednA+Ep1vOk4Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kq5u889-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:23 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50b31cff27fso21163511cf.3
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 18:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774228643; x=1774833443; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FbXvEP3nYVrkLWj+0fdWcGadpdPA4IA0DWc0/CaJGxE=;
        b=EvxfoJwULJSO0tfN3u2KPb/TiRSne9DbN0RyIBv/CsAAPCxAvv3T15XeyDQrX9AsWW
         18umbSkgW2Dybccn70L2F5e/OZkMjRoULXkbiX4CEQYyQBr5MW7mWIbwdQizQ0LS/E6r
         UU0kZhI2sdc6szolV6Qb2psnnnMq9VJe1ucbp+2U/kW6zlJBEC1R/+CQ2J59oGZe2Er0
         vcmhYDnuzweiizjbDM9/FwSMvjZP/54bfeDEJL54ulX1k3PAvPD3vkCC4ABbbuC8bEYP
         lCoAunnEBC1fGwPvSqCcowWfMAmrJz9duGYnBQz6AiDo1gT7P09SCyJquXpupMFOReXP
         k/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774228643; x=1774833443;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbXvEP3nYVrkLWj+0fdWcGadpdPA4IA0DWc0/CaJGxE=;
        b=hYcqJJy31Q0rfp6eQPIo8VIwzG02D7122T0DYf65S6TsqQSYl0WarX0/BWw10TOW98
         KZXMiLokCVZkw2r+ssNp0XIlftqvh6FGkPLaYsOTcH/ghUa+0J2FKeJx9pqsIRPOFd0w
         hHcnB+zJBghwNRkqW3+LyZNzbF2cxTlq4fpZMZD3W0UEBqIydhGzjhpM/Vvq4RqMeGL0
         nx30LcBIS2B4nKZewJJzOMbwNuOcgU3RDiAGmMh1g+BC93znp3ButbBu6oGvTbctVbWE
         csj1HD6m3zi2ipHKO5KVT0oiw42QG2RC0kpObjhLXJnsFaMFK0swxxhy/BAf2wt22Xkd
         Dn6w==
X-Forwarded-Encrypted: i=1; AJvYcCXnmGTStdVNVxJsHSDJ/yY2JzE+UAD+H0hzxk7+NNJazd2oYWlCk6dgYCje8syfQX6ZfBmRdTYyIw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyYHR7b/x7ti9Szicz5uYUF50bFvpTPGakvGI2Mq+0xi/dIBr
	YAv900OtH2OxN2qILIY/OhrfN3yqEbOygS06RY7PRf/UtuM+WlxW8eFtdiofb90MgT/Q4Cx+csF
	QQk+9HQuzGP15rl3pKISJb9FET6DJ78q0BYXIOML7t8QAmJQIOubt8zIy74wQAQ==
X-Gm-Gg: ATEYQzy1Dv6VT8OLx6xHJL01MMa0MrOwkq8HGfOVXm/uFtVmIrvcKy8XFuBpS+tbm3T
	6DRDWnRAhWEIDh1JVwUg5AZdHUCOup+xjEXWFauUhTNIK40SJthFdH/Sh8a0hSbSJL6g+c8fGKJ
	vJ56GBtR5fCfImecugvCJwMnWkg0f1UMN665+Bwnw/5NokK5S++4DBkZp6W8TyIHeTZzODooD8+
	8TUHQ+9VMf1Jix0vtCDhe5jOvKHYOGfb+X/f9n5PrhUEnYHQ1dsxCwwbFnh54WbQP1H+ArKTr6C
	3CMHTWB8VyXZcBYmDaQCRO+WGa+/oYIOYQk5qAypGCDqZrMKlhDaAWTJAhh56XmuvjK74z14U1B
	uPncEr7sHLm89+MKz7+4RRDpK75ZKdFcBlrJ35Gwojw141tcMlq3J3Gr6/A6iXmbIcT69T5CX8s
	jaDi3acdy84k8NpJDfOjte7FWUuKOYlzPn/QE=
X-Received: by 2002:ac8:5745:0:b0:50b:40a6:29b5 with SMTP id d75a77b69052e-50b40a62ae6mr149085421cf.42.1774228643077;
        Sun, 22 Mar 2026 18:17:23 -0700 (PDT)
X-Received: by 2002:ac8:5745:0:b0:50b:40a6:29b5 with SMTP id d75a77b69052e-50b40a62ae6mr149085101cf.42.1774228642472;
        Sun, 22 Mar 2026 18:17:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2853050e7sm2216150e87.61.2026.03.22.18.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:17:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/9] interconnect: qcom: let MSM8974 interconnect work
 again
Date: Mon, 23 Mar 2026 03:17:16 +0200
Message-Id: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyUwGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMj3dziXAtLcxPdzORkXYPEZJNkI4tUQ2PLRCWgjoKi1LTMCrBp0bG
 1tQDt+yopXQAAAA==
X-Change-ID: 20260322-msm8974-icc-0ac4c28e139a
To: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1654;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=nooIqcP1KZppGTp7stNNhr5DaRnd3a7QK5NHg3OEPJo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwJSePZCmbogNPffCLDsq42MUZ00v/ISv+zfOH
 m4Mx4wGGmiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacCUngAKCRCLPIo+Aiko
 1UPUB/0Rq2hu5cvPMVq3jkrjU86m10XlmEzDN7e90QlTBgpcXed+w70eEa2m6L1k9v0kQldVo3I
 k1RX9RweiRbaYG/nGetblxpKOWSD8QK/7J4Sww6D2EUozmkycmfgzYYhxAMfXMZ3NwcCkIwuMbV
 VpT2s2ROhgAP4b5RiEKfjaHWMCFyAWF2VB0Jmjq5VLAlP8IR72XwI1UF16MoG6NNNpeWSMJ/hjG
 2f45eibc+pY5pethZ13wpGQ+3zIvOuWr/UI+zM+nnbnRfX0vlX3mg/nLelq0NwKBbFWpIvo25nZ
 USxsLuIQjXj2yM/d219ZpQvu6VGWJn3oUqzQB7I0IhHCFzOh
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=GNoF0+NK c=1 sm=1 tr=0 ts=69c094a3 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=UYl0gxALbNRs-l06lEwA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwOCBTYWx0ZWRfX29AcpCevsMcA
 P3fDTXi+eEN1OTX85ZMr90euVzKgGxLN99MlvliIMh4+77hn/+mumGhoKUhDPRh+jHuBeEumt0M
 27f4kOXGckgBkt6b9SM+0C5uN7g98BqQRPUttqlgED/drkuv/GOJypBT0ZJZGjSHzaVNVHzI5XF
 5yxeeist1hIipX/kqoQvNqgTGzjLlId9ZCs5CRkUDJ0BNdxttx2loHNH7vYZGEaLRMBmmxndJ/g
 EKapaK40gtzqqQ2qWaHYbRtTnP09tGAK5YJXD1zh83qaTKw5t/+oYZYR4NS0CZM4dzwujrh4sEI
 jO8bA0D6fL2Mg/1DXtrPGn5iiUO81nO1CHmddTOyEsL4IXVyfa41N1GCVyjpY2cyXltXbC+54i0
 YJsk/FCNvSAUWCvUhWDzQwyd+ZDSBzrpsHRhvJRumT0JuFMKA1Kr36vjzwCq1+NjXddwlV8hgtp
 7H5muPY8dLAQiqmcxOA==
X-Proofpoint-ORIG-GUID: NGTt6khI_dAW-d4_h6nT6Uvw2OtciSjs
X-Proofpoint-GUID: NGTt6khI_dAW-d4_h6nT6Uvw2OtciSjs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 suspectscore=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230008

Commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out interconnect bus
clocks") moved control over several RPM resources from the clk-smd-rpm
driver to the icc-rpm.c interconnect helpers. Most of the platforms were
fixed before that commit or shortly after. However the MSM8974 was left
as a foster child in broken state. Fix the loose ends and reenable
interconnects on that platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (9):
      dt-bindings: interconnect: qcom,msm8974: drop bus clocks
      dt-bindings: interconnect: qcom,msm8974: use qcom,rpm-common
      interconnect: qcom: drop unused is_on flag
      interconnect: qcom: icc-rpm: allow overwriting get_bw callback
      interconnect: qcom: define OCMEM bus resource
      interconnect: qcom: let platforms declare their bugginess
      interconnect: qcom: msm8974: switch to the main icc-rpm driver
      interconnect: qcom: msm8974: expand DEFINE_QNODE macros
      ARM: dts: qcom: msm8974: Drop RPM bus clocks

 .../bindings/interconnect/qcom,msm8974.yaml        |   28 +-
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi           |   21 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c         |    6 +
 drivers/interconnect/qcom/icc-rpm.c                |   18 +-
 drivers/interconnect/qcom/icc-rpm.h                |    7 +-
 drivers/interconnect/qcom/msm8974.c                | 1637 +++++++++++++++-----
 6 files changed, 1274 insertions(+), 443 deletions(-)
---
base-commit: 8e5a478b6d6a5bb0a3d52147862b15e4d826af19
change-id: 20260322-msm8974-icc-0ac4c28e139a

Best regards,
-- 
With best wishes
Dmitry

