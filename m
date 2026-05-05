Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09C38F23F
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777999282; cv=none; b=bcXakhnqV8zg83r+x4wMifzthTcUsSOs5jhCTdwgo98DbhaAzQEYSgovgsCWBkUeWKLApuEC56foXMBM84XPurejNi2d5gh5k+UlARjLlFrhAmHJboXBtQrNmMQo5G+XRBIaifOKWVZVcIjNuUTDdcMrINiGE0KRCq+jxw5qiyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777999282; c=relaxed/simple;
	bh=n7q+QSOXUUtcuOdBhewHOjwiqkfPLy8l2ei+/7DfsXA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rYuzNXSdvxG54nhhLEJw4V7sM9vEaAdqdscv2SmJK/loh3FA/iaFWteBV+t55K7Z0/ppx5ZyWfXT1oAXOdUE3kqyAdkEDmE7UT4wquhTTijyGqdDRDELJ6rUMHYEtiPNk3BbshAmuhxvh4ildClqWsTC/3futeJDZHNByMr42Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Yd4oFpP9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=duAUqXbU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Yd4oFpP9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="duAUqXbU"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645Er7x3248146
	for <linux-pm@vger.kernel.org>; Tue, 5 May 2026 16:41:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Sj+UnhV/J0x1Z5m/JKJpix
	jg6zZ5soqB8xlRmp4waiY=; b=Yd4oFpP9CBs63EGCPKoRhv/Kh1nMDRaKmVB3WB
	CtNJ9K6sFytNjTlsKd0nD2xxTBOvTMPCIkrZToOund6szUxryqINF1GHsdpfIiTv
	W94I4ieDGX03FIAOSmzysmLlzkqTbaDtzh1FhUrqz3sLKi2tL14hI2DEOXeosG/d
	gdFiMW9iBvfvt9GlB7oAQIFl6RNhKBEylXdCuhtYf99depDRX3iT5zKeUcz67Dbv
	3+ADCQAMtMbYhM5s1TT5bqzMTG1GraS8fY9fsQqt3SJooE0POc51DMZBobJr/IFD
	JH4L3+OJcnBYAMUTNKgJlrQs3Jnu6eMDP0lG54vbmdCS7rpQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyjq40f7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 16:41:19 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3594620fe97so12898671a91.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 09:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777999279; x=1778604079; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sj+UnhV/J0x1Z5m/JKJpixjg6zZ5soqB8xlRmp4waiY=;
        b=duAUqXbUxIJPFBbaJkAhr9Ik9B60Bm+MSg9w1F81gJBAZERYe9vPPDBufXmvtT9Eib
         7v9QxSDjLOBHIVsXMU4t20lsGoB5nAjL5hwv+tn004gFL8qDNH6j09vNLMnzy+ZyRgnW
         ttdAm1YodpOv6OvCt0UeHhkcdOcPPppgcUBI5O3+ko+idQ18tgYAYqCau9WSxja6v1f9
         Q5ngoGjTg14Z83gZDPwyr3rLvYtIWMXuxUBiN5C/P23i86CTcXq7KB/JLEMhtRQTxlIs
         R8ZQhSRBpZgzOTVC0amGBSqeXhWiUB6aodgamYOnIuViHpuJVjWOA/mekvah6svlqRif
         AuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777999279; x=1778604079;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sj+UnhV/J0x1Z5m/JKJpixjg6zZ5soqB8xlRmp4waiY=;
        b=aBxZEqlJ+TCcMmYZuVEKs+Qp4wlqQODvZgCQYbidaXqiufV6MYhwYdcSDZSY5/bgat
         NQegHJFodmLdnAVjRwo5bMXv3qIiq8+2tlFDKnKl5xvcYq9IlZ8J6Gq5UdPUDxVqUJ4M
         elP03o6JwYGACaMNPQOFc98mXYLoRy+fKHffkuWCyL68HuJcqOhXfeovGv2dzfxktRC3
         R51BnNVXJKzz7/gmCR4oLLmpe42fjwYNwsilUyn2/62MBeogxD8jHEqODCyIdohP5qHT
         7GHctARXrgFZtARieeeTtBgtuw3h0ndVFe9xWGT2AwZAxaVHiJ9nXdrUQmHfPo6AJdy1
         cPEw==
X-Forwarded-Encrypted: i=1; AFNElJ+PYm+RwqH147fH3sA2XlFVfLrjxYddvaBFzRZlrroxu6OVWaM79JIoZcJTF1rDBwOyYILakCoLRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwB8ohumEpqdY4wKlXnFhnT/75Eai6SW4HJYCUlS9/RfuWphTeg
	tDNXWyuWFloJ7iLnTi0E0r42nF8TaPLlREhNnB8VcdT00yzt4dqeA2LN/mVlUsqV303TSyCSk/e
	wUz2pCBkdojEnPXFQ0wSpH9EWhD9+2yU6wB4jistZJsMPAuoz7QEjS2v5gOmDTw==
X-Gm-Gg: AeBDiesBhA0MOjXsxpHExYIF3UZ5SxG+DgF/S8kFT9F4CHvlb0eQctbk3QsdJMedd1L
	qALRtoxOt3IfGdYZewiJgZnO5hANfPZQt1wIZgEwmt5oEcUrOrBk9O6Gv+3x+/5krKkxlN6dcUz
	UaG6iMw9twuL0asuz/9zLSyG8R36SmaDUSVcw6uQS1rat/Hi8WY/LBRH869zYFnXgbSIY1a+GN1
	fTNJwZx5pMZBX7SFLRKYecUAxDrHLTzxJPunQMkw0PLu0tf3pYC60+cRXk3JX0PkqE8mp/XopO6
	dSxHs1GPTECwWkP7/3FxPtJyQ2kdmtZ/SgqDJVAp5ylbYhr3TMLqgnTSloKQ381QJ2fVEHIEI9Y
	L8FK4HTjFHGdU9s/OXqMBxVzMmp/TmYgTOnCKLSMQdadjhgsJhghMmwc=
X-Received: by 2002:a17:90b:44:b0:35e:3e86:e2d3 with SMTP id 98e67ed59e1d1-3650cdd0a99mr14726270a91.10.1777999278863;
        Tue, 05 May 2026 09:41:18 -0700 (PDT)
X-Received: by 2002:a17:90b:44:b0:35e:3e86:e2d3 with SMTP id 98e67ed59e1d1-3650cdd0a99mr14726238a91.10.1777999278386;
        Tue, 05 May 2026 09:41:18 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364be00b175sm17944836a91.9.2026.05.05.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 09:41:17 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Subject: [PATCH v3 0/2] Add interconnect support for Qualcomm Shikra SoC
Date: Tue, 05 May 2026 16:41:10 +0000
Message-Id: <20260505-shikra_icc-v3-0-8e03ff27c007@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKYd+mkC/23MQQrCMBCF4atI1qbMJGlrXXkPEanpxAZto4kGp
 fTupnWhgpuBf+B9AwvkLQW2XgzMU7TBuj6FXC6Ybuv+SNw2qZkAUYAUwENrT77eW635AY0mo3I
 UomFpcPFk7GPGtrvUrQ0355+zHXH6vhklqm8mIgdOUsmqAkmNwY0LIbve67N2XZelwyYtio+Qg
 /oRRBJWCGWBJRIg/BHGcXwBmu8G2+0AAAA=
X-Change-ID: 20260320-shikra_icc-b1fcef45122d
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Authority-Analysis: v=2.4 cv=MYxcfZ/f c=1 sm=1 tr=0 ts=69fa1daf cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=OZudk8sDxFVV_aZhaj8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE2MCBTYWx0ZWRfX1qAZKIJXTAiB
 57rn3tl/945EXBXPFTikUPn9n9xUjv4OrQ/O45spWccKNnGP9CrjIN/96fMu7MOxe7nRHxefM1y
 CIDE6T1MjMoGIH4zuERJzRNTO8BlqCmuU8CeOkAWVOhiRxX/5oQbIIWQDxATQVl9Zx93dZuHlFl
 PjT1adoU+blvYLWNvgMPx3OpmOMM6CG+UYNnX8mOGxNn+fTPROWna79HHJqYG3yYGKVryFtPE4+
 ywEWpcyyXTqGLofrijMKqRzQ2cMHupRYQrqdr4MAcMc8lX2nDfkWzc0gcrzlb9jur1SFizu5Xqu
 mh7pNfWb6fJ9NDf5O+qxLZjzCWADvEfQasWBAsHx8uqjh//jE1rhHBuYhcn1QXpK/au+si3vuyU
 oziu3Gx5OzM1NKPnIgdNwde2MEIg4xHdA7EI/LeArjkVd2Sd+AgJF+vMcMSgLx/3ZSBnyAkIAc3
 ImnDPkGzLagSwsmLQ7Q==
X-Proofpoint-GUID: Xf-rjcCNU-x20tk_8K5bg1PKXy5xh_RS
X-Proofpoint-ORIG-GUID: Xf-rjcCNU-x20tk_8K5bg1PKXy5xh_RS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050160

Add interconnect dt-bindings and RPM-based interconnect driver support
for Qualcomm Shikra SoC.

Device tree changes aren't part of this series and will be posted
separately.

Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
Changes in v3:
 - Drop labels from dt-bindings example [Krzysztof]
 - Link to v2: https://patch.msgid.link/20260504-shikra_icc-v2-0-81076171e010@oss.qualcomm.com

Changes in v2:
 - dt-bindings update to disallow patternProperties for the NoCs
   which don't have children [Krzysztof].
 - Drop the redundant clock property checks for child NoCs at
   top-level allOf:if:then:properties: in dt-bindings [Krzysztof].
 - Link to v1: https://patch.msgid.link/20260429-shikra_icc-v1-0-e3439903edf1@oss.qualcomm.com

---
Raviteja Laggyshetty (2):
      dt-bindings: interconnect: document the RPM Network-On-Chip interconnect in Shikra SoC
      interconnect: qcom: add Shikra interconnect provider driver

 .../bindings/interconnect/qcom,shikra.yaml         |  134 ++
 drivers/interconnect/qcom/Kconfig                  |    9 +
 drivers/interconnect/qcom/Makefile                 |    2 +
 drivers/interconnect/qcom/shikra.c                 | 1837 ++++++++++++++++++++
 include/dt-bindings/interconnect/qcom,shikra.h     |  121 ++
 5 files changed, 2103 insertions(+)
---
base-commit: 9974969c14031a097d6b45bcb7a06bb4aa525c40
change-id: 20260320-shikra_icc-b1fcef45122d

Best regards,
--  
Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>

