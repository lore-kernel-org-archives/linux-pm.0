Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7903FBEC6
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777471816; cv=none; b=aqKel7THSuts0N9xLhn4xYBU6/H9Z19oqQvlKMzsjF5Zt/U16xf+Iqndr5YvYfROg/XyGvyp1ulgJ9cQW/DPl2OxISLrH7kQ5mz/7Q00315yuQNeRhV8Dt7JfjP7o5ciRD8jFbjj995mLhPINUTW9g4YjRcvcYZLmGQDm1HSH0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777471816; c=relaxed/simple;
	bh=ZmSPolJcVe+fEIAGwoyfQ2txKJ/fL7rgRfJjQ0veQkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rOyhG96JNK2fyFHlIoTlec5rw8y76bLYapHeZC9X9exEVBv6hGehuTHPbdouUCGIFFfTjscIAgpB7do9XNui+Z/kXhvW1cwbMHbnfunh/zPzg5UWJWcMi2x/jXyMCv1MnsGU6T4XmnWATs77aqzeqs0pAUGFrbhYVz4SszYqPS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S5emQm3S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DSY2RZxV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S5emQm3S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DSY2RZxV"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T8ppHo2094109
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DCmszfLBMo/STFogk4FjG87dVSfdVQhr5pTDwhUSFlo=; b=S5emQm3SQ93uC19f
	rFj5xSxSgWrT1L3UN/EO+sqoJMqjUsge7LyNQiGY+ZeN9t3IAnq4qYUCwKOW/82Q
	yAG3qY8MXWTp78p8wgAEdQfwL70v07BVzv18AkNGn9siTt7/TPaiAygmgsuNKBLk
	9hBmB/tuAEaWiGofKVYZ0aOM6nw7rep4gtNM14Ty3A2GNLuo4eTUMWro6yIciM8j
	trVcQIR3noPwvGCOkbjkEYV0Dt7xTSr2NEbeJgQ80rrEQCB38CnXPw0hVjJmRKMp
	j57HNHJDdKj9JfU3H7gW1SSkF1RX+XZqGGWYUSmoM+rBYSLHTWCcfLqHPwafhz5A
	53qhpA==
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com [74.125.224.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dudh3sm8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 14:10:13 +0000 (GMT)
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-651cc9f2261so16940509d50.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 07:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777471813; x=1778076613; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCmszfLBMo/STFogk4FjG87dVSfdVQhr5pTDwhUSFlo=;
        b=DSY2RZxVmxcCJfZUGv90iIpPNMOdu02ObxM//mI1zK4EZzt2GrYee3QOIPSPus2O2t
         uHJK9QxKMUFPcsxAJeckYb+Ze/FFfNWj8dGrY93d54/EXYC96Z87XFU3yZw/jAiZj8WS
         whBjAQ3aaOeqBnXn3vAAzMLbhhTJUpvvnt7jnj+Pj68QOz6PWG0dQbekxs79ACW1kXOW
         NteUOwsEqkMRhtDikOP3fpZBbrYjmsrh9ex3VlWpc9prDkNoStAKMHrCHqjnFuZqW70b
         Yp7Uubu0ExnplcIMQdP5mgtTOl3sNUncMY4LzMjzd3ClyrHSr3SJ31n0clFbz9Hhu3lH
         9Hkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777471813; x=1778076613;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DCmszfLBMo/STFogk4FjG87dVSfdVQhr5pTDwhUSFlo=;
        b=PooByEDasRCNPvhc8V2hCLYVLlpwYFIzgmsH7nj1T/GdaHXz2TyALeqnmma5nafwpt
         FAUuucYVndQ7gejqsW8VDT3+Fpo+F/8Gfa/d6v4pQ4qcrVvVjWTbHlMjztHuIvTTYpfJ
         FazjjktUFRadD5wKdJP4mFqcuZK5ARXCV25Ylwom1ZKm5ThwZ64p6XCk33BQm1nQtHHy
         Q+r6lZvDf9VxVoCqmWIg56jZnahE4PpsEt5BWii82LJxOoYq2aVyXz1lCxklXJJQJev4
         bOyOL28HtaIejVp1dDNz2OY1nbqtOjeBT8+rDzzIh5BaiWCye+pw5nULgBXJoP3oHpTu
         RT/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8bWjjZkkfF2GM1xYYTpv9T3AzOUiV8ThQbXiVyi2e2LhP++/QvVV8RkrJxiUJsRGqtRsRrYvJSkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs+u45Ilc7zQXkMrEbmaGg/j2baF5zVhYnIuPSYK+/VYR77Msg
	CHJz2+6i61cxjf5CjYpu8B4i7DjBRFQ3ghnswXE0YQV836x/n8D9sNjRJNw95xrZY0iRt64nZJj
	lCNlPUV08wjxqj8ObjNZ6CTLL3hN6iPJlzZY+DfY1KlOuPTiTKVrPkC0qDzWD
X-Gm-Gg: AeBDieumRYJNf0hr0mUofglIopjMExYrFh6bCXtPKCjoUP1sr9PDvTprQ+MDEH0ky9F
	0BYnrYFgWFatUek7haLHbZi4LTYyGdxsgotCEbvfqp0jyoYQiWiwh2+PY9Pn+msZ6jHkmepsdOQ
	Vx17lgks0pVJ/EECiWoIgt32og4eD9kdvCT+IV+44ya0gFd+kYiBvZfQHjwkhlM8l549HMlndCK
	QXfCxBjaWXR46KP4PCt/xRwoKe7qg4/LRQujisBQU8dTtSW5+MBhsYkpJMNJyPU132fYOXb9chl
	PTHW26/sKFc2SBfp6imsoe7yPYhE/qd9nYQg2D2JxWYFRWnTGIf4Y3j+qrJHbOC7jEBI8jvKlAv
	vGr7XtBKcIaYHRNApzKUiPwEq4S4kz4j7sE9WzQBgEx1As3g5LTjluA5zbZQTaw==
X-Received: by 2002:a53:ac90:0:b0:654:27b0:8881 with SMTP id 956f58d0204a3-65beed37a0bmr7079794d50.3.1777471812927;
        Wed, 29 Apr 2026 07:10:12 -0700 (PDT)
X-Received: by 2002:a53:ac90:0:b0:654:27b0:8881 with SMTP id 956f58d0204a3-65beed37a0bmr7079755d50.3.1777471812506;
        Wed, 29 Apr 2026 07:10:12 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff7ce720sm1286731d50.21.2026.04.29.07.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:10:12 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 19:39:56 +0530
Subject: [PATCH 1/2] dt-bindings: power: qcom,rpmpd: document the Shikra
 RPM Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-add_rpmpd_shikra-v1-1-fdba28564380@oss.qualcomm.com>
References: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
In-Reply-To: <20260429-add_rpmpd_shikra-v1-0-fdba28564380@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777471803; l=843;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=ZmSPolJcVe+fEIAGwoyfQ2txKJ/fL7rgRfJjQ0veQkw=;
 b=BA3H/jKRX9lJg2PzXkgvtqBVtv+fLAI+34GzeYlG37O/T2zP8y67LYopstFEWvnuCQQ+NP3Au
 azLDLQEmk2ED6eKcTHYdw2RIpFF7i77qetlkTIhL2CjxsRcvnpj5tZG
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-GUID: uROuVlp2Ck2vWtWp-SRDnJRFP2VDX5PR
X-Authority-Analysis: v=2.4 cv=A4dc+aWG c=1 sm=1 tr=0 ts=69f21145 cx=c_pps
 a=ngMg22mHWrP7m7pwYf9JkA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=jkam1OttE9FODJyLpI0A:9 a=QEXdDO2ut3YA:10
 a=yHXA93iunegOHmWoMUFd:22
X-Proofpoint-ORIG-GUID: uROuVlp2Ck2vWtWp-SRDnJRFP2VDX5PR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE0MiBTYWx0ZWRfX4OwwNiYcitv8
 oDThLkmULW3Y5Ishm7pQ6wg3dO17ZpWMCwZloTp8tSDhEcD6MCgCfURa3qwj/MlV7Clx1ViMUbM
 g9Zy4MT5MM8vrlgfBezJ8tRxhFIqmFXhDZvDUEDH9KtIywHhtUNSOr1ewRhMe8YVRKJrjLTb7f0
 h4kqU1DnKVkWvZSrWKtRx11FY53tQ7uPH6IpoU0oKI1hiWC9cvl5ub5ah+7GbnjIEJX3LFMxwoR
 Grhow5bSXcT+Q9xTxvNjlFAD3YDFq3igL3FiuyM6t83T8mCAKVlCcflEFzeDsbwYTBIhcHFhBpO
 c5zvtFGDhBwBT+BdiGfqgq+FJyJEebwxVSzlzUjRO0yl66x08kjLAmk4bD5HYbt+WVEERjtfV+r
 GG11Dd9qjus/sy5MOAxpmHXBY6OzXM7bQqhui7fA+2crHyRYW5urtCWP6grrr5COmlVrKf6/v//
 efPU6ldKWVq5N2Pk+Fg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290142

Document the RPM Power Domains on the Shikra Platform.

Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
index 0bf1e13a99646c0325b03fc5b3297ebada21cdb6..1abb4b733fe79dfa267e953f48219093ad759330 100644
--- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
+++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
@@ -55,6 +55,7 @@ properties:
           - qcom,sdx55-rpmhpd
           - qcom,sdx65-rpmhpd
           - qcom,sdx75-rpmhpd
+          - qcom,shikra-rpmpd
           - qcom,sm4450-rpmhpd
           - qcom,sm6115-rpmpd
           - qcom,sm6125-rpmpd

-- 
2.34.1

