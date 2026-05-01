Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971A363098
	for <linux-pm@vger.kernel.org>; Fri,  1 May 2026 07:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777619763; cv=none; b=cSCTXUv6EVJlH0x9hMUFVrTCbtyC7Qv3diw45OOYTmovzWqFQhDw1OQxV3CYWkP4DbV6p6Wxz+hkjmOftsHjQACIJIJhXnY7V8bl2Vu1tzcjedrInW2mPC4gg/zFtLi3LXKh7tODlzTrWpxzk3haKCKW09UYq5lFOliEUoDpbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777619763; c=relaxed/simple;
	bh=rC0MP+UDjJ6z4KBZ4VVe+eGGfA/Rj6utO4SFjboOF0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltVLgz0OxM15AZS0r6b6jQ+2kMdOfyu3Yanx2Ev0kR1rlnLEw23dUl5jcoNNqiQrA28cXWEAdIg+/cD35L5EJFgMWzsJMxF5dbs/9b1P5lSEoa9BtwOJNoNKHT0y+1kfiaER/jwmXA+ZwGGIoj2Cwy6t+WfWZUv8OdscbnAElUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HShkWgiL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jJ4ALkz2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HShkWgiL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jJ4ALkz2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64118iG42473285
	for <linux-pm@vger.kernel.org>; Fri, 1 May 2026 07:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/3h2kXk//bdhSU1iT4/GR4vDmYrOEv2oj5XUR6ycJrE=; b=HShkWgiLvkDx/Dx/
	Vznbxzw91uwk/ppsaH+OjG7P3POVTYSRHNYhCj52vs5n+EFqQsuJZAarMmR8tVSb
	HvIWi5/YL0QLFTxFtJ3RSKTt8QUFf/endXpudGKYkQX5GlSR3LaMJVrMEgb6V7BB
	wIWWKMSoZb+om6ZeDiZaMVFWjomehSTEk9/RsUX5Y2qYTU+LUNIRfQPyma1tNBSc
	qez3O72geHra2gj4ugL9ChfqNeNbpgfmdpNi6IyUbO+YvihChZ0K0LIHoPlqoPX1
	b1DsUBZsntKIQSnheHUfeJGDNA5waSlS3oDQzDeM0zlWzz6aKShKeXrRTkao8zGc
	M02iNw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvj8m0p0u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 07:16:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fb969a4c0so2063691a91.3
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2026 00:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777619761; x=1778224561; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/3h2kXk//bdhSU1iT4/GR4vDmYrOEv2oj5XUR6ycJrE=;
        b=jJ4ALkz2150VMglfk9aJCnid5pJilXrmezyTKjV70Swz8tzUWyWUit1zPeUPTmtKyn
         NdUAa4dfEJH7p/DKUSvr04bfa5SQaODrmTy/O8ZlgGaB5lr31mnPfCI+VscVRZTguhyQ
         9t4htsvERimLJcIwU+Zbg/1i+XhiD3TqG36aTbw/ONjxjS4qxLHCl8ZZuTZpkf/CWyrO
         W/4UVUAOLWuvo4sHbrjshPUyQYw1yDUfq4dUH9SFxNcEKpQqZT8K9zFVrCbdPleTcWjD
         AwlsrSDpDVhTOw3rpFTyouEMuQWvtrSEQxZ5gd1JJUegDIqGUy3Xjf6o2VVPNaoK2Z9u
         IGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777619761; x=1778224561;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/3h2kXk//bdhSU1iT4/GR4vDmYrOEv2oj5XUR6ycJrE=;
        b=RtGIUZ1qajMtYBMgOc2sHmYEgKcjFHUJ37lUS2/suLOBv4mqofho6Nk7VOjshvX+LR
         bjVVslUAkL0KCD7jIcCToRxAGbocOnD0QJ8BxTu25MN9AerfGOZvlJJvDtgXfUCSmu2u
         vQloPPRldbAoyGwVj+rDoXvDnA9PY6EVBY/pkH8nZGczPNPpsclzPBv5Z4pUtbTbXdMc
         g1OMaPdYPS/NkQx3J1egBWKF/Zxm3708wPpEquUkD5NYQTJ154BJBEsZc9nL3+5yO7on
         svyqfluZ2AzCk6q/ZZ3307fHSvsru9deVw80XRe/xGYnvXVgFyuBL0oWcgGdH4V5vkWL
         Bekw==
X-Forwarded-Encrypted: i=1; AFNElJ9BVs3erMXbMj6rOAqcCRcmOY45yTVu1ofRImy1O9bX6nXx0PikaRrbNuKIS1nZSZKrBr5hYzmq8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WXlgtt8PScD/tcRxd85tLD1ZT+ghtJngsiT69Ep/GoIKvMCZ
	BRmzwCD4ggQ+8EqneQPRSNWXPTSK1vAyT3625Y1Es6WgmIutYa/0Y1/noqCT4S8cRrLylthfMab
	pM9l+7aZ5qpBcgDBEFtMplRWYRHPMYRZocmSwiP0ZBJmDikh+W2FiH8Xhn8PCUg==
X-Gm-Gg: AeBDiev9QCJccyfu+UtJUO4d3evbuiKddDjZb+ZdaXHjOLLwosfv1l/I5SteDuzdB0l
	CMlpq5u776TXl/kPYQPf5T5DdL7hlFMV3tAgxN0BOLfozdXg/PvdMcLEzku9PxaAaZasmHO/wSg
	SWWO3NCrY9iiaUOAYaXI+Vt3vIU4J5biLNcybRv4x5sU7NEPJXb9slNmwwWtSLURod4vme0NQat
	2BnRJfRZHWoATQm2FG7j89XfztA0zNUzC4v/jpOO5u04gHqdJLRp4Ks82sM+jsY4LuW8xutnM2k
	uV1uaNLGrhzP6t2bTdokCoXJQZ+2wFOOrepzICcu4gyePR8bARFn80VTZVIxBClZOzFG0PF4ezJ
	XHBYGUV/62F7QjWzka6870YQGfy1TZSwk+qBrq4lXaOZ8xfaTya9yukJhXDUXWyA=
X-Received: by 2002:a17:90b:1c04:b0:35f:b5df:448 with SMTP id 98e67ed59e1d1-364ef650aa5mr2022330a91.24.1777619761073;
        Fri, 01 May 2026 00:16:01 -0700 (PDT)
X-Received: by 2002:a17:90b:1c04:b0:35f:b5df:448 with SMTP id 98e67ed59e1d1-364ef650aa5mr2022296a91.24.1777619760604;
        Fri, 01 May 2026 00:16:00 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364ec00b094sm1424265a91.9.2026.05.01.00.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 00:16:00 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Fri, 01 May 2026 12:45:44 +0530
Subject: [PATCH 1/2] dt-bindings: cpufreq: qcom-hw: Document Shikra CPUFREQ
 Hardware
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-shikra-cpufreq-scaling-v1-1-c78b95f53b91@oss.qualcomm.com>
References: <20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com>
In-Reply-To: <20260501-shikra-cpufreq-scaling-v1-0-c78b95f53b91@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDA2NyBTYWx0ZWRfX0Qo3djNee5PH
 k+/PM0LcGJ92yLUf8XBcznS7ZYDTvYYra50beUTVIYqdkVQ1PoLpf0Owxj7uQ0LEFFEAjPM1HPY
 rqeKboyQLwq8jM+NrREbBxhTLkLW5pbKhzWQcW/wj9T6O99vU5yPenkxO4LTonvfRx2wDgGO9XP
 k5l3NzTlHjN69BfzpfQLzOgtAxZU+AZ8aXfwqeoBEGh7d0PGxwYvSVx8KkVOtRO1GgenhIQKqfb
 P3THOKawxmrlw6NgJSDYNOjaaxVTfQ6JkBT+NGE2A89XUlVX4IDiEgB/dBJHD0vTY/QH1s9Xj81
 JDV19zM5NCV2X0m9yQCaIWjUuaD4ffQVWUd6w3NTJL6Wa6ji3lGnrsiSfla4DhOUv+55HNdH9W9
 zogaeQLZhKWWMe20ac5sTAelIrED2BFSj5OiEBWke3gx84918O9tY31JGX/660PatZeDbiauZOr
 9kT7fcAJB+/b89KFVsQ==
X-Proofpoint-GUID: wBwZL7vTZyYZ4lK7T-4WyhYeqFeBr5Em
X-Proofpoint-ORIG-GUID: wBwZL7vTZyYZ4lK7T-4WyhYeqFeBr5Em
X-Authority-Analysis: v=2.4 cv=V4ZNF+ni c=1 sm=1 tr=0 ts=69f45331 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pnvWlMMwaXXunzEpw0YA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010067

The Qualcomm Shikra cpufreq hardware is functionally identical to EPSS,
but supports only up to 12 frequency lookup table (LUT) entries. Introduce
qcom,cpufreq-epss-lite to represent this constrained EPSS variant.

Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 98eb36bff1727dfe78e77a7f725d1dcab438c3d0..a04f0556dff88615a5b5ee759008c43342f49e11 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -54,6 +54,12 @@ properties:
               - qcom,sm8650-cpufreq-epss
           - const: qcom,cpufreq-epss
 
+      - description: EPSS lite CPUFREQ HW
+        items:
+          - enum:
+              - qcom,shikra-cpufreq-epss-lite
+          - const: qcom,cpufreq-epss-lite
+
   reg:
     minItems: 1
     items:
@@ -144,6 +150,7 @@ allOf:
               - qcom,sc8280xp-cpufreq-epss
               - qcom,sdm670-cpufreq-hw
               - qcom,sdm845-cpufreq-hw
+              - qcom,shikra-cpufreq-epss-lite
               - qcom,sm4450-cpufreq-epss
               - qcom,sm6115-cpufreq-hw
               - qcom,sm6350-cpufreq-hw

-- 
2.34.1

