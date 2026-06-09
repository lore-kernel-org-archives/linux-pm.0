Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20CF383C66
	for <linux-pm@vger.kernel.org>; Tue,  9 Jun 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780988103; cv=none; b=m0I6Av/PwceB3QXYX34YN2asDzrJgnd98IuGmpQcmj2iSr3CH6JX5Zww8L04xhsS2CO6qpAmflkLO8UihB52Epf/kx5A11z0bVPOKH/vumvVqsVQNyAJQN3omHGaSALkDfuWjy2ndlNFPDE76zhAo4RyM/IrJOU+1qDqzqeU+8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780988103; c=relaxed/simple;
	bh=to5r01E4yNOZlKCiXJbFoRfL797dldzR1knX3M8uJLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cvyTBxUslO9TLlY/bpNChvAHahCQ+FtcW9aOkRbT78DkDtjUVXAy904j6rgwQD+2fWQ8qE0DIfxwRmBb03fzSt25a+TplB+W3CMQdgyrFmIRq+A9QDdDjWZZPFEK2xOUuw8ZjqHSwdR2oHkO7/BxvzgJ0YPZyv7+o7fw4X0qvmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gFr7uKY8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ze3KlvEl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gFr7uKY8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ze3KlvEl"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6593wbdt1060955
	for <linux-pm@vger.kernel.org>; Tue, 9 Jun 2026 06:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=c/g4sSpc+Sy
	20+048o86PNPCNwK2/z3cWgWlvqarn5c=; b=gFr7uKY8Nm1Et9Z9AkOK3Mi/LrC
	C73sEZSdyenSYuYHZYpAGaEx5T9qWoF8id1HnRIquHzSznjPBlc9mKTrfmp6NSzC
	wwe1NuO8ggiXZ4hNAxrf04A6QwTCI5RWXBIwUQA+2lTcVTt4hRc9UgOLw3mUxx/D
	4uI+gO0mX0daSRJt2NHE9RPCKixS6cpN7pbNwB8+7tFPj4YoTuPBkTYBlxm+wMXQ
	Wd5BakHIrB8M4iDfjBQKfuPlvEw4R4QjLVg7X+SN6TFr0NttI8Egx6G0ZNKThx+W
	YPqYbdX51qYcYgfn6iZYCdtZ5h8Yzk19OHF9+A+QHZDoRfdP9derGvJVHog==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun44wr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 09 Jun 2026 06:55:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-36db995d083so3680939a91.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 23:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780988101; x=1781592901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/g4sSpc+Sy20+048o86PNPCNwK2/z3cWgWlvqarn5c=;
        b=Ze3KlvElQaPxbynDbUmD9jJdFMxnfgclBpu7VYrFJH3g12v0XRy0nFSGLeEOqgdHva
         RuUHpog3ZvAFER+oYpwaef8dt26SPHcgnWiYaBOb2mw+2JkLwOShOZX1REtWHdUQh3oL
         kMKKb59dT/rY5QaFKEaSOdbKBIAvyidZ0vL2jQPSPf63fiHgDYgfitVpOkn4yH9FB2md
         hzqiVHZiZG7TN8YEXLGGBqK7tW9uZ0l09mU2w3IlTBW45tqK0uzoGIYgJHvffJI/thYk
         MZ6BF4Q92dDiT5wxIwr0wQGCRqxsz1zvxdjlHVCM0h4L2er3wHzYQEJfrQTnu7AgNnNi
         ldxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780988101; x=1781592901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c/g4sSpc+Sy20+048o86PNPCNwK2/z3cWgWlvqarn5c=;
        b=qkuJ84Avh6LKzA1cIovCSht4pPDdqOC2/XRltptzg/gPjBxInU4KjupLMVa5+IySkp
         +cbdV+FSSO6B4kkp3K3Zja1dIkgyDJiR7Qi7nrSVz4ySfduZcqXhI6E2uuKIGIeImdc3
         0UcxgCI2N04UF5xMdJ6aBthJAW0pOaQv42DSqwJIquGO6Nnw3yuKI4dxZZ7Q8DzF4Y7H
         NRh8YOrCvQGtVf+xwhKfVq21Rsai8MD8HSrz/1Vup7sJM4IAVvo/bZq0OZVhk1Ej3dvu
         iunsr/rvxCiw0RYBHjrODozlLNAvqCnbB0MPAqEHj+m1x6862Q21+xFQ1TCay/emoFTW
         3OQw==
X-Forwarded-Encrypted: i=1; AFNElJ/qPHxwMmbQEg6S2w9QpqaEJaXIGQYV88jfNaHnO1xJ4Afrb7b0oQ4Nxqv30ZPIdnfyhZjR0QHCYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxREH1uZ4DTbH5lcluC+Bvn/ia/r7h7ewDqeCm2k/SH41fotmrR
	vEc/RCHvcTO6pPHF0v3Jyi9ipn8uJ2eoSsnJRJsQQ1xLhGldH8IzHdMxxgvS16MZA48jERjuAXP
	ItUimnnF/Jnn3RTRn4S0Lo7zT+Hh3IZdMjePYLsaInRhvHqy4oWG8fP5D3Iox4g==
X-Gm-Gg: Acq92OHsuhshko2DqsYC1vgHRK0qwp4FDEoNrNx9XvHXR3gKQJReJzX0wUciyrxA14l
	eVPXDnSZwO5lywHgYeGNiAt3LCIR0UqZrpb4jZw+TyD54/OIWyzWQepXqhK+inivxR/eEJfgW+b
	4P67VgqTwIaVeCe82697/dnw+pqR0SQM39GTAbHNEzyBkVv81DwiLsyT5UBom0RT1+X6FlZ9Baw
	H35NlqyrX7iBmql/sZFtTSUZuHHcGczt9ix3OtXQoRGzXz6xi8OTmMD12VWDXOPAI6TgpATiScd
	uQTZJXMrQ9pBY5tPUDvvyTHgGmTZU9cwv1dfYQCN97zJrUUQNPglHVNKg9trjy1Ofw1NDtkU92o
	GWGsuj7r44odpdfk6WQkJ3PEErs04/bMOxZIrbuUT0+/xgfYz6sadk0O3copgoHaLbv8dvu+HN6
	rAdJdrgNmMJ1vx/ksH9C/PhnHn7rg9sClvUOKLUhgX03xX7lXFbRriQ9b8rvQcgQ==
X-Received: by 2002:a17:90b:4b0f:b0:368:78da:803 with SMTP id 98e67ed59e1d1-370ef0f15c3mr21274087a91.12.1780988100625;
        Mon, 08 Jun 2026 23:55:00 -0700 (PDT)
X-Received: by 2002:a17:90b:4b0f:b0:368:78da:803 with SMTP id 98e67ed59e1d1-370ef0f15c3mr21274054a91.12.1780988100181;
        Mon, 08 Jun 2026 23:55:00 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3712fcb3a9fsm8607926a91.0.2026.06.08.23.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 23:54:59 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: thermal: tsens: add ipq5210 & ipq9650 compatible
Date: Tue,  9 Jun 2026 12:24:46 +0530
Message-Id: <20260609065447.4024695-2-varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260609065447.4024695-1-varadarajan.narayanan@oss.qualcomm.com>
References: <20260609065447.4024695-1-varadarajan.narayanan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA2MyBTYWx0ZWRfXydlbyy8aINdu
 JP1Vd8iCWS8WJo9jCZxBoO3cR9/EGdC1Ks9IHRmrp3xlHF0hD5jlB0a7nxw0GHw7/G64D+NnLtJ
 2dqRleHkXHjWw9SYEqBtysJKX6ZezALUeH36lkshzdTpQdhX7CmNlZ2P8UxjcA/NsQbEEe0aSuA
 KDPD3MstuIOsSAh4Q7DODCxEIRdG3lpCENzByCbBpMMEW8AkuvM2aPLiqIZPVtcgIJuf5+PfblT
 IpughwVi2M2Mmux/ZlGmz/JI0mSBv+ATS2XtQq8EjJC6uXH1Ki6Z2+VQl1qOVu1J++mVsu7squ9
 uoxJtPFBnXiYqHksjRFCOKcLg5TZvaIGLLnB8Uwyi9vlT8RS3fUVxUQEf0iHh+60/uIwxomaDUp
 Rof2/hUPB8gaWemTAuSQMXk05FJuTF3CPjwnj08BfuCX4uTocGmYq9I53Qs5kEnsjtj1butA86w
 8PdPBSEGb4liOrgexQA==
X-Proofpoint-ORIG-GUID: 0Uh_V6WtAKTDhgMdjHKHSz1C_WIAaoaq
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a27b8c5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=Cj70nMFs6DzugLwqs6cA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 0Uh_V6WtAKTDhgMdjHKHSz1C_WIAaoaq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090063

Add the compatible for the thermal sensors on the ipq5210 and ipq9650. The
ipq5210 uses ipq5332-tsens as a fallback, while ipq9650 is added as a
standalone v2 TSENS compatible with combined interrupt.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
v2: Fix fallback definition
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 7d34ba00e684..a927650c119b 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -92,6 +92,13 @@ properties:
           - qcom,ipq5332-tsens
           - qcom,ipq5424-tsens
           - qcom,ipq8074-tsens
+          - qcom,ipq9650-tsens
+
+      - description: v2 of TSENS with combined interrupt
+        items:
+          - enum:
+              - qcom,ipq5210-tsens
+          - const: qcom,ipq5332-tsens
 
       - description: v2 of TSENS with combined interrupt
         items:
-- 
2.34.1

