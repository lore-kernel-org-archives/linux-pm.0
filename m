Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E886A314D0D
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779652178; cv=none; b=W2d99f/wi4NmaD42e8GgS88TmlXnOABpkSGYZXc+e2WWMvb2ytS8HsuqgMCtTSJlq1Lq7v7FMlOAj40fY6v0pmfYCQC/oDrc+Sb1lwA+4gPY6/sUZKwTNwtAxzRjm4aYXyHTMJW4UklKqYmA556suZ054dwnPKzL9kmNKlAxPsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779652178; c=relaxed/simple;
	bh=mjrd/5WRTtizVxAileTEcsI3Pcwm5BCTvACtsLVlxwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzDk48bcumMrzSvFRlx+PTFH9ha2ZJITbhIgg4wnaCVxWlyBTbShm+pAv3/+Q+D+raKRR0S+uhsEPPuDncn4UOqwy2abV+jS8UUsO+QCJGI3GkBsOANFHs/Ju8Ua0wNLFF9BO8n50OD+VUWp5CrQQGKKcBOcAoQzUYPvvsP6NMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LogcTLjl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XCrai2zR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LogcTLjl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XCrai2zR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OGqK7c119484
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=; b=LogcTLjlntl1XNsc
	yeqnh5YMUmrxODxq2K4HIRtiksiDZITDHIaGV2J4t9Y5hap7R8JTPgzE3/3zh847
	okoZWGj2T9vhrc4E1t7DDHPjAV9Xw2dJ1xIRthgqd4vV3bRQby6E938tsdcBswku
	ir4Gxrq29FQpejJkxccMOevias7ggrockSi12sM/dZPoLXzxoglSNDJFuIlE6Tgw
	bGW6ISeYds2l74VCrjo6qMGtao0qos+n1jWCpYGoxreIQXi6N7s8wLMooTXSCqiC
	uxLeeVi71KUXy9+d2WZyTQGScNJEkF3eQFU0nDDaDf39lrJRuM6SwdVdRjRwsEdx
	1bIK5A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3bvdf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 19:49:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-369166fe5e3so7695425a91.3
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 12:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779652172; x=1780256972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=XCrai2zRaSx7adJ2I4QNQkfKAXwE71GguAkz9Df19yG9l1i/Gs6HYX6mg5nproqaxU
         72WHgDwn+PUdKdmjETF3YvwEAO+vu9cifWUBYk4OPUXn+uqjQlAwoglMLcq7OSvvA5Ta
         M6CwTpmplkSOxnhtLXRwAmXaxA339WIDg9H+4OsWR0fN2lFy6MZQpjboybQsZJtQTPPE
         0lnqQglccMCWvvPjv9gkJueJMQ6F9fPJEqynM6QG6CFfaPNdCEzSFrg408HPyLLh2Acv
         5KHmg9Ef8UWdi/xnnHqhHsht8I9fsQitgeS9EBfMvqOjpqV7cautkmSIe+gs4q4AKpXd
         zhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779652172; x=1780256972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kf8GN87yWQbNdh+TSO3Lk6k7qhp0/6Kg3q6wFbgg+3o=;
        b=j1wZUrCHMILDyen2q3VVIaLH/DBJNymKML3bF+fUtC5LwIjX6d+FWanHiXtg5x6xwA
         RWSlFeetk7ccJ7qjxMRW78TFLY8JYObJd092Y0Vwol+pCeRL2b0oCqfozQEZgyhfGSVJ
         gdkcWRKbZzmUAasp7BYz1aSjoZGZqxgtgDCQda181SErGROo0MCRrnYv9gvPGtnT70d7
         8B19v6YMaSDh2oU2XIiGemIDxkr8lYy4Boa7LwBNi1PqmFOpLHgoh/9JHB5HXSeAeAJl
         QJZGcgRBl3IiYjWFe9wkfe2JYZYrpVVS4mfj9Lrm0OPFpm/t1a8tUwGPwGFKz/3Q3k1v
         NE/g==
X-Forwarded-Encrypted: i=1; AFNElJ/YyrEeRwPp757kxk8CjwY79DguGqLuAerjsayfUFEA7XNjdv5FN71IA7w++1+h4w0k48/aj69i4Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJuKmRYEhLcESPIPaG1DQrvnYrE92XPQZz/WKvgnUVANyf/bXu
	8xNqXLC5xMn98QoeCVPSuMrTput9YcOWlstB9sSapqvu2s6P3v2SJfpYXgF3d0gMLdzhvut5xxA
	TZKzgUKk9cOUoJrDTnW1xOcy5F4B1js6LqjrB168+6rOEUImDhvFSTR92RL2B7Q==
X-Gm-Gg: Acq92OHkc1ywBetdQ18xYNXfLwdIfvtOMFQkaZ5dnpyyEN5ZQ+sPtt1sWK5P3VY6rW7
	TbzoXADwQAysJ3/J8xeDMtK39N9z28fp3KCXSjMZfu8JrTcJflUvGBliqfgPuFI8UcpqaMweFqr
	/9NwQ5BQ5+yWJq3ZA3MFx989iUWxJpg+lBmjmPfpME5Z0JblIy5/Xql2n7LJyiT411qYuVX5QT/
	SY1benUkZcYrpe7saRBKgOtmdFR/j3phtBfLSBt7KGTuysvckUGzvFlgOhVetVmplmCvhUdMEJD
	+JyGEZG+YW5lyIBqJ15iTLJsKYN++7ozyzhYNHkY2LdIyKKFh6fV6pY3kn2MMxH919OQ+olM2Ka
	pDl/tvuf+u0SCowQLloUeY9T/ZgfxsjhcIDhi
X-Received: by 2002:a17:90b:3bc6:b0:368:7327:6326 with SMTP id 98e67ed59e1d1-36a6741ecbamr12524811a91.1.1779652172271;
        Sun, 24 May 2026 12:49:32 -0700 (PDT)
X-Received: by 2002:a17:90b:3bc6:b0:368:7327:6326 with SMTP id 98e67ed59e1d1-36a6741ecbamr12524797a91.1.1779652171688;
        Sun, 24 May 2026 12:49:31 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a6c21d4a2sm4725849a91.1.2026.05.24.12.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:49:31 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 25 May 2026 01:19:05 +0530
Subject: [PATCH 01/16] dt-bindings: dma: qcom,gpi: Document GPI DMA engine
 for Shikra SoC
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-shikra-dt-m1-v1-1-f51a9838dbaa@oss.qualcomm.com>
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
        Xueyao An <xueyao.an@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779652157; l=857;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=JRwNa7gj/V38SNuXulP2MlFnweDp961hhJdbueICCwE=;
 b=SJMty0KWOEX6DjZ0a71oPFOwID0hjCec2SeHsUbInB/1OE7qDGKizj3oNha3YZZH6bSMaZrvj
 cv5jqYpiPCUA39iEcakFA60bKj9Q/JudQ/Ojlo5t0q16s0LLJdA+U+k
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-ORIG-GUID: CKMPL71PSUbceOUKcmCzvg6DF5CdVAgF
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a13564d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=jyTGefxJr8I4-3Pae4IA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE5OCBTYWx0ZWRfXz25vKNZ7AfLv
 op0iOUxhwXVl319/pXtJvo9oO3VR96plJQPyfqjFKP9SlAWLjpxxu7gXvrMRkT6gIsPMpyut3zg
 VsN0d1oL0yXwUSRywq/9n1JiTdQaKmvHnjCwNIS0PkojHjd0vGqnZOjhQVMkFBVETN7fPzi6Mpz
 dKYe99LCBiJaUjQ3bhZ6kSOgihmnwhpRCtRSyLNXfTR8y+V88q2hXXmSmJcZpQSSaOBB4LcTpgF
 O6Wul4XbQevOzCjUTbM68NJY7zVq2qwjiHl+ia9OMJqEMVY3GKp9YZ6CNosMxverS78FvQP+bgl
 NmgNe6uatYXuwXmbfZo2mSVI2SIhD6HVSxSNQdymE2e3P31lTsMGA7sqN1JcIZgZJQb18eMFCxj
 rAu6Kw9njRy9git2reqcK4LRNeWLZ6cWz+S/D9CdPyqzKQO3NLeRIhRPjM6oPu5CMdmZnfgPBwg
 er4ElS8K5529bWQSxkw==
X-Proofpoint-GUID: CKMPL71PSUbceOUKcmCzvg6DF5CdVAgF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240198

From: Xueyao An <xueyao.an@oss.qualcomm.com>

Document the GPI DMA engine on Shikra platform.

Signed-off-by: Xueyao An <xueyao.an@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index 8f9a552fe30e..54dca623223d 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -37,6 +37,7 @@ properties:
               - qcom,sc7280-gpi-dma
               - qcom,sc8280xp-gpi-dma
               - qcom,sdx75-gpi-dma
+              - qcom,shikra-gpi-dma
               - qcom,sm6115-gpi-dma
               - qcom,sm6375-gpi-dma
               - qcom,sm8350-gpi-dma

-- 
2.34.1

