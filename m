Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B273612D5
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 06:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690019; cv=none; b=eDkzQPQH/7ugSYvd3snCsxRrUodUwIc2+tG4gpAdiySA+8ClbRrjyTBHkocy1m/xMrgeNSuc8+LOHtFbZTMB3LetioZRAuZDxNGnr8i2IrxIbYUQc1KIwsZjOCiWi61/xm/rwQtUOi6zoRZqdKJlJEWBBKvvj8LNKwV3YLyInC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690019; c=relaxed/simple;
	bh=960m/9Z4WWieVtPzeUUrnPor92ad2oqAsT2Mj7D2XZM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=L3/DEjDgEJd5mIUiKhH/fOmRKJQTjfmFroZlx81VPehLYwwMykxhv2mwNq3Pd8w7DsOhMsKHJQx9iByzbhLx5EIX/Wnq/6OCp4tbkLpXcC9rGu5xcjLDGsEJ/cXLQJkc2pWyDAiquCH1JBVxW4utZb7PpK9ZtC9A35dmlwhjL04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RHLv35Kh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=isx8k18J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RHLv35Kh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="isx8k18J"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P3rvM01457776
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 06:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=s41+5WfvaShROC2zOmEnUf
	H0d3wfCy6LO58hVmGT8XM=; b=RHLv35Kh1vzxIRgkpWf3Uw+yWk/5fNU0jve7hr
	ay6Sei9Yhm4MpNZ89O/j3XhuXFizncZmEczn9mV8nFMW/ye14338NmIw2tl+NlMK
	9FvU1E/RsxGQ8E7hvLFFnU6wwPSbdOIm3N0sf830QY7eoYKCoiJW0P11eSLhK02K
	Fe3aI902XEgytIRn1ElhQQyQS7JNyYGA6V2qXyNxRgF+ZEwcsFxxXL6RzRTvmjWI
	d9QGmNchdnzf7PJqn2QvktdAeM1YMPvg/veg4L57hFAAd0xsVgIs3lLq5+EJva1G
	Idv2Dnf0461fWrM3jVOcdcq19vDbMU+TbdICfI7PlA8ClZzw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3d6mm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 06:20:16 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c82c84be9c3so4159039a12.0
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779690016; x=1780294816; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s41+5WfvaShROC2zOmEnUfH0d3wfCy6LO58hVmGT8XM=;
        b=isx8k18Jhgzs5lGA9XjZI6XK2Dt/LoObpD0EaFnP8tmNandng9ZbU/cxs56IO0kiwU
         qp8a/n+96JVLXi52PbsBMuTeRpJ6zMseIYfKhOxYN2pBG0YMN4AVNna1SYgDnkFhzdDU
         KNgRzdfO8f5NgVtN2wlUtdFRHw++HI9Ok0BzvQqF0xG/q+uYHFL/v4vKW2KBk22Qx7QC
         XrfOlEdoLJZM/+5eA9L/82QBljoo9OE7o6GGnds+AXRTS8A6QFtHL0lUl8mOcVA/uzu4
         nGXtVz2Kupt0/FRKHrriMBZXlaOT0gBbfLnZbffBmY/EApuQI8IUOz9R3DPkA3JDVZFH
         4jgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779690016; x=1780294816;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s41+5WfvaShROC2zOmEnUfH0d3wfCy6LO58hVmGT8XM=;
        b=eo8tDKfaMUcQ0sbmqq+xqk6lrZjOTM5Q8PCu+u/xTAJQQ4FY3YAjvhJqeZouJgmyDp
         ie0TkbtI2OAQI8ywSGWCp+bGczV6w71AV1ZuYTDAnkA8/tWGqtoJqC5K3Yhctst8jkeK
         HRU9IvSe48EIOzWaYgWbGf+q+ep0rD+ohXCucZ7o0Dm8mC0+XBNqdYpNxk0uwDcZLfrd
         mCtQhIEhkL9f+3tMsa9MFzjSwdeqkTrERFs/vRJ8zd8PU0Tmx0tqMlbvmfkucV1amydl
         DzPAglVvciTSxS7hB1rxP9hpYcfXdYKHtxBpHT71kK+oqKIFAakDyb8l26kDXYzekVaU
         NHcw==
X-Forwarded-Encrypted: i=1; AFNElJ+jx2w+u9TB05rcMBw2ziAuTqseabF4WVlow8WTU6nVPCEQ9/1XsTRy044an2BSPGv1IEkPMZ9Uwg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNEsD2jmS2Z9Xx43B3nEr4k/K2l0RDIDAkKgWzdvr9boC1ltg
	i/HdBbx2xvHg5O90MsvGTl+fJqOkL1jGOcpZ5dsdNwX0k5qceGibz+nxIRYh6zSLp8w5FbSOItT
	iqKHplI2/g4kIXZxIKvwNXS1oH6TOBC02wxvH7g5RDf5AfXalbPvXhaCLhDxSbSpnbrPI7fuF
X-Gm-Gg: Acq92OGa/sWBiR2hSxvoGw2MPpvwUliaaL99KhYiNySeadckBBrmjrrisfk6qGHU+HD
	ruB+NPkurg4vfKCFefavn0I2v3eMp4wd+VtuGw8K0ykUeMCmVrcZJsuq/SlwtcQIboSLCCkRPxc
	HLyHXR+Q1vrGqpRLVDiq3miKJAIf17YsF/Ac9kPfPNbpx4ikaOWQs1cPQOFbBqvVzkLRIKUCSYS
	I1+QacWpvKt5p0+wS2zSPHzwqIruqAFiQbkjE3p6YdcguwinAPaf6bm6fnr/q2Fp3N7svbkgou2
	qP4hXURxqbwNXoU1cqAQ8fYawwX7+WBm4PfVDjcY316ooqbwaWNYsY5IEBDsHAsDKZhpfWTjxlj
	IOp0GjHoyMAsI6Myh+1Gt5MDU02ZeCgopShyB+0ZudHWyQOciRs1d3EN0CTHnKEaVsGlcxKtsxK
	a7dlalp1NZ6BG/MJI=
X-Received: by 2002:a05:6a00:180a:b0:835:405a:7e72 with SMTP id d2e1a72fcca58-8415f141d5fmr12115775b3a.11.1779690016257;
        Sun, 24 May 2026 23:20:16 -0700 (PDT)
X-Received: by 2002:a05:6a00:180a:b0:835:405a:7e72 with SMTP id d2e1a72fcca58-8415f141d5fmr12115749b3a.11.1779690015759;
        Sun, 24 May 2026 23:20:15 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fafe14sm10040849b3a.42.2026.05.24.23.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 23:20:15 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Mon, 25 May 2026 14:19:53 +0800
Subject: [PATCH] dt-bindings: interconnect: qcom-bwmon: Add Maili cpu-bwmon
 compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-bwmon-v1-1-b8f6e189c3e3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAnqE2oC/y3NTQ6DIBCG4asY1iVBQSpepXExDENlAbZgfxLj3
 Utrl2/yzDcbK5QDFTY2G8v0DCUsqUZ7ahjOkK7Eg6vNOtFp0bcdt6+4JE5olfQOtETDqr1l8uH
 927lMtS0U4jZDwvl7HaGslP8w0/1R/6yHPiguMYZ1bPpeaKGcRmMNeRyc0AN4b5RDKVptFJzBO
 yI27fsHveV/KrwAAAA=
X-Change-ID: 20260512-bwmon-ecb43fda63c9
To: Krzysztof Kozlowski <krzk@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yijie Yang <yijie.yang@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779690012; l=1281;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=960m/9Z4WWieVtPzeUUrnPor92ad2oqAsT2Mj7D2XZM=;
 b=E9P/oZH7elw6QqgFN5c/EhP+hAaIcUIKw9DSGy9l00gqmNjMDFLyuMb9eZg9sStH+Q1D7wk6g
 FwQX7VttMJ0ArIM9iz0fUPW9YMbX5hEbL/hb0tUg62LKW9kOoI12IZ9
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Proofpoint-ORIG-GUID: -WyfHikCFeBUl3oGCn9o1JBp2YXg0fMR
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a13ea20 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=axenEgmuRSwQYXswx6EA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA2MCBTYWx0ZWRfX4fXMfeV3jz/K
 K6nfGJDi5kZYM4Dv9spxQH58FhQgNvvcgUg62a9bC0DLt+fcDASh8W62XSREPUeq0mCGeERec0e
 Zc8hIFUrwPok6IHhdjZ1dnQt9mggk8NKWwXpzsQT1JJnOV0+L6o/b9NbcTOHLhcsKxYwHlHiVsJ
 L91L1ptyxGhbyEJuQwelzOcXOAhMC38dys5RItTe8/2O0IIs2ViNEiwgSqiYxU6+lOOINLDcUbU
 q63M5UY3K6wmShzMcFUjqHiTIbugD1eTVCmv+kQE2ZKhZZ0xfrjyJF/J/FWLp5J2kDxh74cErJF
 xyDN2hJe+OCykjlO4eAdiWP5pGRczpMlOgOMcLPrUfpD0wEPH2MAodmEnNluxyuJfqUIewq7weT
 p1WFJjc9dlpXTi+1tz45NWNwfxkhFg9csCDMhUD1kxVbiLoVxuoY2MJAh61aX69gZRoXYjfRS73
 Sm0T6MeCWnGZVDebbVw==
X-Proofpoint-GUID: -WyfHikCFeBUl3oGCn9o1JBp2YXg0fMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1011 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605250060

Add the Qualcomm Maili SoC compatible string for the CPU bandwidth
monitor (BWMONv4). This falls back to the sdm845-bwmon compatible,
consistent with the existing pattern used by other recent SoCs such as
sm8750 and kaanapali.

Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index 82b1d94d3010..7989db1aa774 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -28,6 +28,7 @@ properties:
               - qcom,glymur-cpu-bwmon
               - qcom,hawi-cpu-bwmon
               - qcom,kaanapali-cpu-bwmon
+              - qcom,maili-cpu-bwmon
               - qcom,qcm2290-cpu-bwmon
               - qcom,qcs615-cpu-bwmon
               - qcom,qcs8300-cpu-bwmon

---
base-commit: 550604d6c9b9efc8d068aff94dc301694a7afdee
change-id: 20260512-bwmon-ecb43fda63c9

Best regards,
--  
Yijie Yang <yijie.yang@oss.qualcomm.com>

