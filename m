Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13C390991
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262747; cv=none; b=mZ8u902ioHOuk591RKTHk6BWWygNGmtNqgStLNEYkw1uLCy2vMRRP2ezCsHLd07oJJeaD/fA6y8scqX0nHp7/mYfm59cGdCsu0PrMp2l9aTCZCESTmtcmWbh8lVSyCJQpIjmJxcawPYUiIg2Zcoy2yTWisNdeDT2dX2CLVxRnp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262747; c=relaxed/simple;
	bh=Zih7KT7rbZ2mj/QKEzK4AmdUtW4xv24Z73EMhaqiD84=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FGuvWJdNYFRLpeZW/cF1tRXFqoE+Dfd15ch3zNQUKhcj/V3Nfqx9/vb/REqYCE2OB0AGJOJrLiDQjHlA8rdACT4pkj69NH+xrNtXviQl1nu/3pEKG/kHaE4o+EP3R/hgrgqhQ3cYhd/0po7LUvLvNK5vYCU0xLvdPqa+51nkrPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M2K+aKlc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KE/90ZPq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M2K+aKlc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KE/90ZPq"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62N83jTG1364079
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=x/OLnIO9fkpNLTzR0JWE3L
	icFcOOe/mOWBVjFBi4eWs=; b=M2K+aKlc7KYqW3BNTKA3SHjpBuzKBnpDeAlk31
	AnBnma52NUS54meX8sGAI1VXaztjUW8pSBTFJZWSj3H8Xmt0oKY1VKq7DnqVOmL6
	c1sYy53Z8rsZqB3v1vl/nDv24kE5cKjT1V7nKz1Wfz/UlQuDudBSCbe32LVXBms2
	R2v0K7zj+0uOdHWRK9UMdK4s0cPPwBak0cp4la2ksyWcyY2rHsUi4xXQcWkBIOEs
	sqHgdg99lPN50A9LWQtVfQ28EYvluvd85tneqJBoxT0rqbjNBg4Bcz83NBWNffL0
	pzmIrgUW4hCvGNQbfeaesSwjVQgG4cBiQ69ieaMBxrLVO+LQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31p78ktj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 10:45:45 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2adc527eaf5so309695ad.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 03:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774262745; x=1774867545; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x/OLnIO9fkpNLTzR0JWE3LicFcOOe/mOWBVjFBi4eWs=;
        b=KE/90ZPqwwcUnqNyxm88qdpA4e54JZGLAgGJULCkivC/Tm0wUaktHOwBTXm8quasTv
         c47um5LQV7vL2twTIKHlmS3SBfrc2NGbgAFA4ogncoKfgdh6Lbf+2/GmDFpX7Uli6mUY
         vNHvw4w+vuNTwwIRl2znmFWyh/U3ZVkYCtwpZAtADzcYC0ro13RiC1wXx/69XVKd+GW0
         nFx8eC99d7MhGM8I/gE07FUcsOkP7v4Wk2ji0dwcFt59bQJEa8b23cbY7gqQqAgf4i+Z
         Vy43MRWmowXGtvF2/6BRWFosv53oRy8k1mXSsFKhrAJKiLCxPfms4eKyewk31Sfo0mXc
         cqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774262745; x=1774867545;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/OLnIO9fkpNLTzR0JWE3LicFcOOe/mOWBVjFBi4eWs=;
        b=IcekCE6Ac9HpXt8W1h2tH46CQ5MXVJrkqokkCGkahjufOMKws3cxkjICsTQrD4JVmM
         jfx1+NNSPC2vQDFFEfolypVElt0pO1bMXH9F2rICs8qDSIEISlqguKuW7x02j8geYF69
         BUPkOFT04/K8BVeW6rPJ1EgfWlXE7Ssbg+Ii0L6rvjdkVHxk/Nck/1Vie1P3w2DtnFrA
         boYpwvxDR0T2ffkOmhTHb1oc2JXbX3f/FF76bB9PzsfUJqFy7gJdPF6/j9rZqzOJal2a
         lyaX8iEnnPBq6Gjt7xoaRTRw0NpSSPIfOZ7vnMPOpx/QQxBk/LWpvERMheqcFhm/+9YF
         CO6Q==
X-Gm-Message-State: AOJu0Yy+lYcR6EeCoaLhycDhZ8thGO69om7vi2z7YZSImuaV2ns95CFW
	D9KGINg5KlhKSVvx/JIz+pzFBG3cQ0B14qc6nHDPkkyhHYDgX2lIpOsp1BcW1Gdcb5aIlXg34Rh
	dk774ttaxJGz7HfVZpcbh0vshP7uEqoknPZIrwTahP3vM6nX7/oyL9CI3pTZt
X-Gm-Gg: ATEYQzxZsak29gno48emGSc6dfOgDrzFudtemb6W/9Xkq828Rft9/CP6qIUkxSr5Ae1
	L+PxJypyaMYJJoDVeA8ZWsyj5DDmdJwlIB0EL09zlchAIofrsb5zX9lw4p4Of4bVUWFYVqllqU0
	Kq+6oMdvDf5M4DVVi2WTPNxxus/F+wb5kBelejg4ky/wShNsxHlnyZ8BPozQ7cadHMnvYEstAJY
	ZDVv7VoiH8gli+TdpDrXhGsnEl3h5aB3pTlN1VW3zXaH1ML15TciUWJofMcuozmeioMW4C2QT47
	1T+9a9ITCIjO+1mwuLO+H+bfpXK8kbYWgworPXALIeF973UZDGukqg1ui5k0ACg6LjlJ3gJ9jMD
	vo1pQRxCueLI2EAC8m4j6+TvMJnhn9yWWcFb2t/DzqXRP8rlxLSs=
X-Received: by 2002:a17:902:e846:b0:2b0:624f:8edc with SMTP id d9443c01a7336-2b0826cb353mr111933115ad.12.1774262744467;
        Mon, 23 Mar 2026 03:45:44 -0700 (PDT)
X-Received: by 2002:a17:902:e846:b0:2b0:624f:8edc with SMTP id d9443c01a7336-2b0826cb353mr111932695ad.12.1774262743508;
        Mon, 23 Mar 2026 03:45:43 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08340c2edsm123454225ad.0.2026.03.23.03.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 03:45:43 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Subject: [PATCH v4 0/2] monaco: Add PMM8654AU PON support
Date: Mon, 23 Mar 2026 16:15:14 +0530
Message-Id: <20260323-b4-add_pwrkey_and_resin-v4-0-abef4e4dcc3d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALoZwWkC/3XOQQ6CMBAF0KuQri0ppYB15T2MIW2nSKMUbLVKC
 He3EBcucDPJn+S/mQl57Yz26JBMyOlgvOltDGyXINUKe9HYQMyIEloSSkssGRYA9fByVz3WwkL
 ttDcWU0UY7KHImwJQbA9ON+a9yqdzzK3xj96N66GQLduvSfg2GCgmuOEsqpXkgufH3vv0/hQ31
 XddGgda3JD/WLT6+1/II1dmqpCSKgDBN7h5nj/JDL3FEQEAAA==
X-Change-ID: 20260226-b4-add_pwrkey_and_resin-2c04d8d53f5d
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774262738; l=1594;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=Zih7KT7rbZ2mj/QKEzK4AmdUtW4xv24Z73EMhaqiD84=;
 b=C8p6VeRhjNEFT9pE0+rsMliNwAVAR97yIyivcZtIM+jEhru5JMJRtOfUwrz+k9Nxb4ONW34eX
 93Z/tE2AcZfD8wcyVv+Z1kUxXNrb4hKR9E/I9VZXObutdJHrbKTDADr
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=69c119d9 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hkPachF6C7OTRM8muywA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: K5QDhJNsKpL04ou2ol8YwKRJmgpzMyjd
X-Proofpoint-GUID: K5QDhJNsKpL04ou2ol8YwKRJmgpzMyjd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDA4MyBTYWx0ZWRfX1Je0VmuTv4KX
 pPjsbdrhtLtwfskNd5DKP9jk1o4rJL5MJhiNTHlt+7gAMxVlGA0/awK17g/1cAgClRMkokNZt2o
 Priv4UITjL2+Rg53vhlPu/qZGPhfOw7TqzL8VP6l1uIz6OW8wy1ki+XEadWhfQhQox/PetIDap5
 hPIDcCBo28o8G7QcM1W8Xj7vyM23tuUMNGkg50z96ChK5gPbfDLggMRMSQg9yL8NISnnvdc/Xql
 DuqqSqLAuiOG/3JY1Yzfgy7wXTYPOPufycJJMV2qTKdVgxPDOc5309JkarkGNqD1aX31w3dI3Wu
 g8QpafwvfCHdWFrVJxMOGrN5/QIqr4sema0iuZvpRD0Y9oTcpRkS8h07gWqy4dqK+rcAeFwoovN
 vmIopNQtTdIaJBuCf0SNex9w4BV8OeYtB+c5mwcACJlKBtzejylq/3TLY6kav+1rGXKgvi5B/dP
 BC+wxliyaDsmvR/uWUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230083

This patch series updates the PON power and reset dt-bindings and
device tree to add support for PON power and reset keys on the 
Monaco platform.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v4:
 - Remove the contain for PMK8350 and new if:then for PMM8654AU as suggested by Krzysztof Kozlowski
 - Link to v3: https://lore.kernel.org/r/20260227-b4-add_pwrkey_and_resin-v3-0-61c5bb2cdda9@oss.qualcomm.com

Changes in v3:
 - Drop the dt-bindings of PMM8654AU qcom,pm8941-pwrkey as this
   patch was picked - https://lore.kernel.org/all/20260209-add_pwrkey_and_resin-v2-2-f944d87b9a93@oss.qualcomm.com
 - Update Commit message and disable the resin as suggested by Konrad Dybcio
 - Link to v2: https://lore.kernel.org/r/20260209-add_pwrkey_and_resin-v2-0-f944d87b9a93@oss.qualcomm.com 

Changes in v2:
 - Introduces PMM8654AU compatible strings as suggested by Konrad Dybcio.
 - Link to v1: https://lore.kernel.org/all/20260122-add_pwrkey_and_resin-v1-1-a9fe87537816@oss.qualcomm.com

---
Rakesh Kota (2):
      dt-bindings: power: reset: qcom-pon: Add new compatible PMM8654AU
      arm64: dts: qcom: monaco-pmics: Add PON power key and reset inputs

 .../devicetree/bindings/power/reset/qcom,pon.yaml  | 32 +++++++++++++++++-----
 arch/arm64/boot/dts/qcom/monaco-pmics.dtsi         | 20 ++++++++++++++
 2 files changed, 45 insertions(+), 7 deletions(-)
---
base-commit: 877552aa875839314afad7154b5a561889e87ea9
change-id: 20260226-b4-add_pwrkey_and_resin-2c04d8d53f5d

Best regards,
-- 
Rakesh Kota <rakesh.kota@oss.qualcomm.com>

