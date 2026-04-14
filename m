Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6422DAFA9
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776139184; cv=none; b=VfajFPt4HYBCuWxSTcKkBv/DD3E86zylG9BACT9mAYTvj4HG4tDAIpDKuE4D7Mwu3O7YrxR12a9+/9mmqgIG/paGm139KzAhzSF40SmstcJUkhGuj4C7Ztp3Eimcz+msgXNo93soW03r3ibQNSCj4fUZ/hzhAN2tgRcS41IB8iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776139184; c=relaxed/simple;
	bh=QZYwBAG+pTDj217+cj+RjnBxhhvqSjs3QXHm8g/XqpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DKvSXGHPBRQj/alJb4RJzSFJyYpi9/IGsX3vIlrW9LITC10MrhgefF16DFtw1bT4SQS5AHqcn+xNCgv7p0GUWKu7uHr++6tVmom0F93TLkoZ+BBa03SD/aUTlJXto9/NDG08qFH5QZEesuA9cf+ZvQIXjYKS8gNJ5V1EaVbpQK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dVD7alg7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aV34tx0J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dVD7alg7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aV34tx0J"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DLDLeF363168
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=ugHwuPVgElZC0lXcMV2XcJCHfpDjLtZL1Mn
	qE+P7JYM=; b=dVD7alg72dbfFMCukGFiKJSVBhUR7CVENJ451KiBB01LlnZR3Wy
	8nklKbbnmsstNIhOz6o7rV2ZjMjN2trpJ++XEndST1AtOP5ldqp1T0PAoySbseS3
	NjAPhoHhjVwk3SpFsfvwS2Ih++Sdz6DD92IIos3c0nCvYHyB1EoozMYAuGIDmQDK
	8dp+JD7ZRXhxJ3XlvRd35y4s2sckck5b8OjraaZVYNznoezvjjEoCnVfNFP9gL2k
	VhFQScWCIUaWj8O6cS+l6a5Z6aYr1nXhqdkj+N1Nvwyg+pwZDvJONnthiZrCK2v5
	pCmM7bomYiuwXBJy+U0TaqbdaIjz70Uklkw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870rwp9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 14 Apr 2026 03:59:38 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0f6593ef5so7219550eec.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2026 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776139177; x=1776743977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ugHwuPVgElZC0lXcMV2XcJCHfpDjLtZL1MnqE+P7JYM=;
        b=aV34tx0JsdQFAd4jpSFA3Na2lyARkKGtH3mRpomBGNl9VxH/MtoJgSTNyiIaR1logf
         Iw07jdSE7pSNe/7rGx97mKnUTcZkmNp1BB4qFpSzOsOgWaKckyCaQ7cstCipbab6rY/n
         De7zHB3kA7kLMjMVHr8lOYxzUNJmg9jaxW5JL6Q49cpzFKC146dB/6LAKbPYGaroVKx2
         X1eeTD9h6Js1kckqv/satO2i7CpI0smfoqwxx9Szxy30ZnrTsE2nTtWReD9r0Ow8CjPL
         M5pMsXt6JZvmo1e5VMoA/Qs8+ZBlDgxAkdUmhtrM7n0LuM7nsxwzwVxsl/kyA3W3J+q9
         WKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776139177; x=1776743977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugHwuPVgElZC0lXcMV2XcJCHfpDjLtZL1MnqE+P7JYM=;
        b=e5MATSz8dIBD4fApQRnOpFThf/wtlfo1CTEAuhVEDvjDU7bSIdTMfvV7x+LM0nI24l
         qCF/MKCf2XnTmBV1e6uwSKI+yaLOKyXJeRfYEP+aTX9xEUhrxBrvR5kfADzSx82acT0l
         pw/QPPS+AQpHjHK4y415Nf3F5jdjZP3ssNNCKQDOOQ8MnvSiszP1CrBMSDNLkuLEIBzH
         inmp8TqkS04ppR6P8oED/1NFA0jEA0Om8y9Cixt1tTMcBIWGtw6s5i14lIJgI/XDn8bP
         m2OpY+EpJayStJMe5brJAw4kOOSUpvPmFhtL6WO27ryJrXU+446PYt+Ilp8FjN3p9WfA
         7nOw==
X-Forwarded-Encrypted: i=1; AFNElJ9fcLUAcZaB1xJxeK1gtbwXXKicMnvZEQBhc1ap5G0k+cliAebN6gbki4e9dZsONR8ufo5nKy47ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+oNed1Y4h7WCLSwPuUax70He8MQNqC31IMnvUcOwE9Tc+RnHo
	zoAPuFujZAosZPr5VTxE/opmwY2WgZHV/2KQFqEHOJhOEZcv+hFwZExC47QFsqTiLl6E5YnDxfN
	3pRG0KpahU37eUfcSeIRJ4V5Ck+61K/sJ3XYAzCy9KHM891SlWJ5yenn3KYX26Q==
X-Gm-Gg: AeBDiet+rE8zJH7kAsBS1PLxIz2VzUPXTlCloJMEIdSRUR0DodYpEOXN6SpI0BEEFra
	R+qWOVsPR75aSU4XpewMmdkBuTVKX4NFS8utM+aED9TVKUSTPgbLrwYcNljCGVbK3ebzPXvvn/l
	SNiM/BarVjelPAWZf/04MnQJC9zaw0bSvYFHKp0PLcZYdphzk0BnbIy+rYO9jlKgeKuUo8Nq1sx
	m43ol53/rOP3KFLqB0cWVrooCal3Ur2dK8xxor1Rp+zP0aNsL1yoG0NCGopsTRzWdvT+N/74ySP
	Dw9duxMGr6uvy654DKKNEoAgBsdNfDfMsdQ/26eyiDDsOm6kTMl/cVq7shESvwkcNnw9ddi/Eaz
	GURIRWY4+7xAEvCItKYDCvm2NFvkAW3DsLa48Yoo7fwZe+C1Sjh+sR88Ll0mcly73PhcmbUb9Yp
	jTJi2AFg==
X-Received: by 2002:a05:7300:2287:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-2d9db50cd6amr2384798eec.0.1776139177434;
        Mon, 13 Apr 2026 20:59:37 -0700 (PDT)
X-Received: by 2002:a05:7300:2287:b0:2d9:db50:c6a5 with SMTP id 5a478bee46e88-2d9db50cd6amr2384790eec.0.1776139176878;
        Mon, 13 Apr 2026 20:59:36 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d80acca4c5sm13949983eec.19.2026.04.13.20.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 20:59:36 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Deepti Jaggi <deepti.jaggi@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>
Subject: [PATCH 0/3] pmdomain: qcom: rpmhpd: Add power domains for Nord SoC
Date: Tue, 14 Apr 2026 11:59:06 +0800
Message-ID: <20260414035909.652992-1-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=C9vZDwP+ c=1 sm=1 tr=0 ts=69ddbbaa cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=9bb0FoRI36OxSVolPrcA:9
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDAzNCBTYWx0ZWRfX4l3NlxLazr2g
 gSIOPUXav/9GJJyQ5ssPK8DkOBSDYxw8fTP298qt/5w2WVC202uJtkuFk7073aLvOuE+GF5qdBu
 buGs0Ap2NiAK5ElBDOg0mjv0BYjKBiW+5et1ceZcvlDmIIywAN6vFTg/VLtwHKzWa9bhRYnrx4c
 BaoWsQei4UIYdfXEMpfkQoYEAjAePa2cE6BjKJN3dHbHyR/ebD0KLvnYOam2XOi9JnMXTAtFKJx
 wOEAcuGFIxLzDuzE1xWFVMNwNLSO5g2S6q8XKXStb6OTtBOMS/gygz0h5p6NBAw7ZLB+pi2WHnB
 68NOTgWvMvDjkJ7r0rZbKBaQ3BsFdE3nfLM1Vz0cnksD5WjCC5uGZAHxPNO709RA9EfYKGpjXHu
 hVg0pDoDoOA+x6+2Tz/l5WlwnVDjoBg1vjINL/IhswnCa+eJUsWalyETI0Mt2e1rq714F26Piql
 wmPIf5q5838+9ynFetw==
X-Proofpoint-GUID: OWldrSqBDRzRRGAi0XN73mDzOLDi1mZB
X-Proofpoint-ORIG-GUID: OWldrSqBDRzRRGAi0XN73mDzOLDi1mZB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1011 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140034

This series adds RPMh power domain support for the Qualcomm Nord SoC.

The Nord SoC introduces two new power domains beyond the existing set: GFX1
for the second GFX subsystem and NSP3 for the fourth NSP subsystem.  Patch 1
is a preparatory cleanup that fixes inconsistent whitespace in the RPMHPD
define block before the new entries are added.  Patches 2-3 add the DT
bindings and driver support for Nord respectively.

Kamal Wadhwa (2):
  dt-bindings: power: qcom,rpmhpd: Add RPMh power domain for Nord SoC
  pmdomain: qcom: rpmhpd: Add power domains for Nord SoC

Shawn Guo (1):
  dt-bindings: power: qcom,rpmhpd: Fix whitespace in RPMHPD defines

 .../devicetree/bindings/power/qcom,rpmpd.yaml |  1 +
 drivers/pmdomain/qcom/rpmhpd.c                | 35 +++++++++++++++++++
 include/dt-bindings/power/qcom,rpmhpd.h       | 18 +++++-----
 3 files changed, 46 insertions(+), 8 deletions(-)

-- 
2.43.0

