Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD344534B9
	for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2026 11:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485985; cv=none; b=a+UPcVs+UnbHNuPdoXCzJ0Dpc83T7M5di9h3iWvwFU4rShh7s3ioXRur+NJcbM9Q+SfARAWC6zUYqIhsLcBOdMfNK+tu6FClihh8M7QY9+gIdJG7l5No3SskOeVxHLqONxdUS9e17zMt6QrSSPR7hcpFAzjQBupb9yqTD8pA8Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485985; c=relaxed/simple;
	bh=1dObgRDzgUT8dRxMLMRa/R9TRzn0laSrkEbhmpC0VyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OqWR/wOqx+yc7GvIQwQXSLx/8QODCm7CGDBtM6qehlTWt4nLuF/SLSRyDMGH/EYQ/SbohY6Zb6WZ64CpDIMsDKnPqZYkPm2vnrnb21KnUdI2427k292PcYrJ2YIGztNo7kWP0v+71YTVrvdSkcoMhHAlu3gtw784asiOr9LP0f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=De3SH1YN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dwaIVII9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="De3SH1YN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dwaIVII9"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536Rgqd2077120
	for <linux-pm@vger.kernel.org>; Wed, 3 Jun 2026 11:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HGgysCkU5Fxr4iYQeCoa2SkvebPhhyRsY+oXXx4ZaWU=; b=De3SH1YNZhZ2j7Ej
	EyVBF3KwV+RzjbMdLPmqPDjoY3R+RZo/zsbfqLCSoBQjNUcgUVsDfSxcrKzzBcur
	rckxjwtZKtrpsTHijuWlQyn0d3C8ftWAgwwpNbTiv44Q3r1zbl4os260zMLqaNrS
	23YwXh85y9CDIBDXwa4fk4mty44yhEKe9bQf8SH5BAHMuO9Mtp4bfD7FawxdpvCR
	K0IVNHoMDzOtm7rDcaB1KjaHhdsGV1GBw9yem3NDCiPB1Sgg2IjONh3Ar60/No4I
	PjqbTENRIFXoHcAlXJ0pE/051xt7tEUDDHexzZ1lFUWKPD9hqNMrNnqrB6nCwUnU
	VotjtQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejev199f7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 11:26:23 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c36f1cc0so65611065ad.3
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2026 04:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780485982; x=1781090782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGgysCkU5Fxr4iYQeCoa2SkvebPhhyRsY+oXXx4ZaWU=;
        b=dwaIVII94612wbCgVkjFSPSEwvul3ZOEPQcnS697biQ0aE91M4dAevCgDb+RnSVeix
         0F8yKdyHsL7nAdYp0vyb89IL0prCfyke8oG/FvSaii6OFy6keWgkE4loJTMHD22nmtwt
         U3z0SlHxcWXS4ZtDcxf9pSaUFe5A+5NrLMhFpdrPNUAYVm4f17OQwW/KmOTrT2rUrOBL
         NUmuedkSNwVmAlCviWl1xIUdYChyZ1KTF3b1jFR2iq9ivLnp43CjKAVXUxuDKMAXq26w
         s5Lpmpa2Hli7co70cB0OOq2ooBqYrxdyKuc+d11TywssSxVtY16rvfq0wyhkZpiMLvb5
         fJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485982; x=1781090782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HGgysCkU5Fxr4iYQeCoa2SkvebPhhyRsY+oXXx4ZaWU=;
        b=a/DHA2lpqJGHIRwVZOQ2RtieU/BMKrNYfWkT/Tdi1m+v3Nnh14Jjsg1QyRyHjqh710
         91SyvG9TwC2w0ex2jgYFRD8EIZu3NMlYaiWwWOfFXMOaq3HVrOmvtJKqb521t1O6emVa
         UQM7n66V+F1kBQ/EkMTPaVHcRXSFrwP11tawXUYif/CPHMQC4Qar/U3CYDTlAckRvCUB
         C+y9hH2t/oT3/XLi/eXJQ4lT9uz6F5dOLpSunPXXQ706dcwjn8KKkbBvm0q5dgpkgsSB
         rbvHAiQM0cLC/l22uYQs+f9mfe+OJFHv8CcFgPjFLOsrau7fZhqIKJYf+F60RO29ryaW
         gHlg==
X-Forwarded-Encrypted: i=1; AFNElJ9USJiMoVSajp7KhmeCidAiGYlgH7mmQqKUT5vJN8zXGmDyvFjjPWpBADRUZ/4ArSdlzXeUha6yoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yym9fvStahMkIT3g27e82gdTYCLVsD1Xu5JFNbZaElAOIgOqioO
	EeBuLhrlBd8/D2szkUpQAvAM0pjMYbg5/CR0dDGgFDQsYL8khzcHso2ami0rsF3ApQVvP4qvXKm
	/kvlKSVWh9b1tVNDabTcV0B5lz9/Tsg5246JgAhxSnCAe/GV7VZZiRr6vZpfflQ==
X-Gm-Gg: Acq92OHF5EsZXq5og4t+4hmMohyD62A2dS5dMWHZzz0tI3PGSfAnAfrP9uMu7slVY+/
	2xUFpLg40m3Lse9U4+UEEZzjfIHaIlrInRvGQVAMAip1Zbi44YdGKk2eQU1Y7sBjoJaB+Qa7kUW
	MjXktlxJqocnuw0iaZDoFPaVWD30Y5ym2jKpZYRRa9T1W8jKChgjDHwHRAYj9SPHm8+yUNoqDe/
	uSt+1bg1DBkI0BFm7IIcAqZjYntShZgyDcjCy5bmQSRl/hMZOAAcMNcg3x7g+C8jWO9pH0uztRP
	PHW12g7vhYF1FhgxjZK9G9sBUWak9QUTPQvazbvN3BxQQsecH+/nElBPgyS4WMO0XN5bEAsoTAK
	f9w+Uzl7fkv/Z90/u50sW92qkpmWjFAQwdBD6sLd+aO31yp9MoeVQtH4=
X-Received: by 2002:a17:903:28c:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c1636143fbmr29375865ad.0.1780485981975;
        Wed, 03 Jun 2026 04:26:21 -0700 (PDT)
X-Received: by 2002:a17:903:28c:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2c1636143fbmr29375615ad.0.1780485981543;
        Wed, 03 Jun 2026 04:26:21 -0700 (PDT)
Received: from [169.254.0.2] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e0ecsm22704275ad.45.2026.06.03.04.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 04:26:21 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Wed, 03 Jun 2026 11:26:12 +0000
Subject: [PATCH v3 1/2] dt-bindings: interconnect: qcom,osm-l3: Add EPSS L3
 DT binding for Qualcomm Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-shikra_epss_l3-v3-1-3c2e0b796e78@oss.qualcomm.com>
References: <20260603-shikra_epss_l3-v3-0-3c2e0b796e78@oss.qualcomm.com>
In-Reply-To: <20260603-shikra_epss_l3-v3-0-3c2e0b796e78@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: 2-lEhv7ZhCA_9ybPrMIQqZ0YCGtYeKJO
X-Authority-Analysis: v=2.4 cv=PNE/P/qC c=1 sm=1 tr=0 ts=6a200f5f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=_8IM60h0k0ddrWA-9CwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 2-lEhv7ZhCA_9ybPrMIQqZ0YCGtYeKJO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwOSBTYWx0ZWRfX0uQK4nuwtZcl
 inEfYH5AC2KuG67eRE0eZRCkhUyp+N4tdNhNazBOs9l0wKCUyJgFctiG6tkXMohxFfHXLn93JvW
 2WF4/7k8/9uqwghIq0xVp6Y+VgJSJE46u+oPfBD6vb+yPMHBbzQ+1pJgAeIryNSnG5+vwBhVBcS
 zWcFCSfcEy8ea8EmjtbK51rl/OvxXZOB76GYZ/wTUWNytjnvs/g0oFBYueh7FOW772+BF3KL1kc
 2Vgkw/QmbqRLFZ9j586pBe92iWPvBj+0dazF/8PLa1jqjSWt2J/gfc81MBkCsEW2TTmo5bqb03P
 1wpNhoKGGjT4HoqlH0hW+iP7EUlypS9JtYpI+q5oJcaN8Ryyt4IyZNilfumhV1FWlYSjQifEbgP
 C0wa/Eeq/tbgNQvuG98TjOJlp5u5kAx7LluSFiLt7K7W30lugI8t+NgqOhhqnEyPSAKKIqnX5f0
 D0PRfYSFyPJIBqyZKHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606030109

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

