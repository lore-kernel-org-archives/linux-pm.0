Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6A44E038
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485060; cv=none; b=uq+5PiiPPt6Gv9Hut6tw0qszpn2+l2HqzVPg1vyO6r1TOaA+/xELNBzavvXtk1HiCZu5DgIykvGVmj0gpKlQxiu+d8ir0QRRvkKzWqEkSijh+j/yrjQ6NrDBs5TQiSHeDPwq/vvL/co4RKxMzDiQjVS6rH9FEoHCIzP+e5zM38E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485060; c=relaxed/simple;
	bh=1dObgRDzgUT8dRxMLMRa/R9TRzn0laSrkEbhmpC0VyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owmOutqmow67rZkGv6rHIjfR/StMjMEpTH3RwwIH8gPgVbzc1vy/qKtYivLfu5JkbhgZIzgrLJEYu9/RlGh9OBURHwG3fdTwyRtueHGBwOnKi1uG4FdQ+5cIuKaTFDMR/fK1t2rztIVt0v6wQZsD40KxTZeUYBTOOGOwOqypkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IzSoM0RR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d184VGCJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IzSoM0RR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d184VGCJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65395olo780673
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 11:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HGgysCkU5Fxr4iYQeCoa2SkvebPhhyRsY+oXXx4ZaWU=; b=IzSoM0RRdKxOgb2+
	GBRNaAckI0tbIx9U9k2mFDbmO1w8IYfgB8ZolDD0C4zsGRs3eARPbKsFcxLGMo4U
	1YwfxjC2fsJOdVg05iyOfKr3oEXobRrhNELmzRLHvJo0BrxUgSRdmBIVqEUPQxEU
	zxqsCkNDH0l0KdfLtNQ2mMN4jgSHoY79ifJAI9eTcH+r2VcvyoewHc+K2QM8oAr3
	pdSIMX1c0Ec5p13XY05xPAiLNYvKlAqjMiPAy9CZ806O8LkEhBfvkHfQomeK/FZ1
	z/m1qDc0CKTlDAKfqdWi/1ctG4pRIVhIMc7dmLBtq0ZoWhcrvco7A7nXtYAfCT3c
	gfvcpw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejhbb0grj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 11:10:56 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0a99db8dfso43345705ad.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 04:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780485055; x=1781089855; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGgysCkU5Fxr4iYQeCoa2SkvebPhhyRsY+oXXx4ZaWU=;
        b=d184VGCJ6Q/4hUU6u1jutY9LIycxLeTh/JU8xwvA3QS1j5TNHvH7CT+aryW8IZ2rDB
         G/yKnJ2w7u1SdZRP8NLw8kwFTtoom1SdgIsl2c3wG/iIsElW7+9Ut23N7YaT9uODG319
         DDHwfjm5bAw+iBU8cCwLpF65+B3HNox0dDBAkNXF/1FmvvjqKUhHZBgN+O+J2mFWu1wV
         wkt0J+SxLwuE7e0uQah6tQtchVdjdTCADUSfNjyIO5qjCZ4diuOUirdkWqjU1Q194qBe
         UK1o/dVRVV9OC+q4jJ82tn5SPuIPklOJRxsXQY4KkHz95hl6u5JLu6cyGUMn8vlWuTNR
         kOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485055; x=1781089855;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HGgysCkU5Fxr4iYQeCoa2SkvebPhhyRsY+oXXx4ZaWU=;
        b=QVrBaaRhgHy3H0ZGwdbi3MroCFJpeOfEWV9rqjx8ZrAzEOJgL0qFfelcZZswXWwa56
         rHFGdhgi4V0jHA9a2o0lSa/ixBSgqLxBBNDqgzCHPnuTePrAjLHF/2fOfCFMuJ52+AXg
         THhpnFOjceqifqJxIfiY4TDEceQUipjTPW9RV9FTDeF7dNeXwncAHNHVT7yoPMN4/S+u
         WcHsXbp/R5Ihl1Li5vb+ODZOTdTERvRQiXj+RPpMxq1EwkRdMUwZvl+3EL6rQ5AFtCjd
         YjXD7wYvoFNeqhrHeD+TbcADuD4pbvvjewL7FlINcRZ3fxBxVStHEGT8QivJo8I13S2t
         0n9w==
X-Forwarded-Encrypted: i=1; AFNElJ/ofH9HB9MeaRYVav7MFsGbarM5RiAIhqplh/eUZKUPwMf58dNjiQgdYJlqlCm7L71cTAlwQvKgPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgPbAdvepumzphyTEmBsRYcvVTkPe0QlLeloPjrV2GiJbSYxtL
	C1OI0NtoogTs+sCq+JYnHD9c8ZrsmIPK8AKvwRWKxYMBRKQK5/fnqedaqI4K7b++B4ZrjQs4AuV
	bJ59slRFSLmyBal5T6srovPKHtSWqV1Sxlas23LYwEU47nyzDOp6/Sldx3i1EPA==
X-Gm-Gg: Acq92OEIeexVm+fbx379FrH5jViMh/Rut6ACFfr4AkAKwEd3hTaeaP3+mQdGeMYReJz
	v8di26bA00yx9KF+Xn5vqMBhF3QCE6u9emL79k3JFcpJVfwg8Sa/G7iCdj89VtIZt57aHU24aCe
	t1Jy3hHCkLB9M5oXiKgRtiMQTb2AvOs7POJucGsTUjShBiWzIZcA1u/6t7YbHCugyI2RqAkWJX1
	jSr8mFZoHkYSmfLs6wG0UNaLmekGHZB+eEolVC7oRQsypAcmtLG7O2n61XS+jW3mAWJKcGtRbTt
	9GtLxa8xfXeLbZAskj4Ge94FM7vTeyNoRt/rmvuoVoPVKgAofQiyS6Ak1F4TeC3WtdxKrnv606O
	16Nb/s1m84IY0EMGHSqxaaPdJqC+aZbUS0LPt6hyLpkcTkoqgkpTMcMw=
X-Received: by 2002:a17:903:3888:b0:2c0:ab82:6b9d with SMTP id d9443c01a7336-2c163fb26ebmr32182765ad.29.1780485055413;
        Wed, 03 Jun 2026 04:10:55 -0700 (PDT)
X-Received: by 2002:a17:903:3888:b0:2c0:ab82:6b9d with SMTP id d9443c01a7336-2c163fb26ebmr32182345ad.29.1780485054984;
        Wed, 03 Jun 2026 04:10:54 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e636sm22148805ad.51.2026.06.03.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:10:54 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 11:10:37 +0000
Subject: [PATCH v2 1/2] dt-bindings: interconnect: qcom,shikra-epss-l3: Add
 EPSS L3 DT binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra_epss_l3-v2-1-480cdb5abc85@oss.qualcomm.com>
References: <20260603-shikra_epss_l3-v2-0-480cdb5abc85@oss.qualcomm.com>
In-Reply-To: <20260603-shikra_epss_l3-v2-0-480cdb5abc85@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-GUID: pUHa1hXIqqkhQ2HXId0-h0o7xSlUqCg_
X-Authority-Analysis: v=2.4 cv=R74z39RX c=1 sm=1 tr=0 ts=6a200bc0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=_8IM60h0k0ddrWA-9CwA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: pUHa1hXIqqkhQ2HXId0-h0o7xSlUqCg_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwNiBTYWx0ZWRfX6XokLhjF53oj
 e4ygVn8sHruH4oKqot9nnl5tI2HktxPm3bEO0JOtj6UNdF+2Z/03S806P3kS71MUc1oB0sR9DRg
 Uv016ciH55AsKWaqAqzYhk4mKgbWqdnndaBZ0a5JdYTQVb33qeP8EucZDm0s/bsyCzwOK2LBEeM
 3Bf7W8NSbg/cJaBVl7ZVc8bew1MhvSxe3+lljQIY+wHP3vLxQNHZiNFzf6LJo03wCHFLy+eMGqt
 ALDqUhIxwq7T/m9bRwMFs64+8maPJmvNEQguDCBV3WbtZtlled5oWmFsMM9H+LQUy4YF/YWUXU3
 qujJD4YWIpPWVE0sQmUJ+LgnbwLRF9qJy51Q20CuTJyBZ5ECVilVb9DILUn3J1K4tEJWy5RAUKk
 TPHajv1NhSkCFpBrL8pcdzizv4dud5vLwzSz0+eY9Ku7Gt25ZTXx5J1TKjoakTkfJr0Vl3syVyh
 rWu8v8XAIKhrDHk5WnQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030106

Document the EPSS L3 interconnect provider binding for Qualcomm
Shikra SoC.

The Shikra EPSS L3 block is similar to existing Qualcomm EPSS/OSM L3
providers, but supports only up to 12 frequency lookup table entries.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 41b9f758bf8b..3b8ebe17a976 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -17,6 +17,8 @@ description:
 properties:
   compatible:
     oneOf:
+      - enum:
+          - qcom,shikra-epss-l3
       - items:
           - enum:
               - qcom,sc7180-osm-l3

-- 
2.43.0

