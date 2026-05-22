Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2495B3A6410
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779438130; cv=none; b=Fjw0dV4xUYOnCFLIJmw2zqOnknrE7+A2mBjIrPomfjYgYjaClc7xsjvu9m9NY2doDLlB6QoYfOvEGDgtTj6TvaetjFLeuI5X1IofnX75TlE59lsnZYQFxxia7srWMV3O9gmfhHT5ijT4Ta5xB7mpZp2pAxiGy71xVWzRVYXIa2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779438130; c=relaxed/simple;
	bh=X+JZGdmHTa+yImR9lFGIGG0JCJFj1fpBHVnJUsdElNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYEUP8u5mEbGqe7Y7Y7QQG3Ws8TaubkhGENQKz7Dz/ceCXvxx2js6W7lpo+oBoL6RdqjBkBqJLqjd3J/GecYGmfpkFqy3cFeLzYf0FCQNSSOrofLKvzRx2q4WsloXN3ND4UQ+/cpVcXjtxb1JcZiQH6at7Wnpt/W37g41PaPQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W+VoYilU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jUYEyprb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W+VoYilU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jUYEyprb"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M41MqZ1815982
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/UiZEin/CWLczHVZ/BWfU1j5gZYKxKRp02pNX4UGT9g=; b=W+VoYilUErGeURA4
	zorey+mVaIAtbttEJ4qbdsI1jSsvzNwRwYL+eS6+2xhXTygb4QC3LwManhCnXlsj
	7LL5+QmsqX9JI92RsnoQ3NkP7+FILeKm64E3cBEhDYUv8o1kOgY0LG6Haz2+0yEN
	AtfZXK6a18g/eVzsLyCHYfLEGRNOvqFGRmaxEKSN61xmdLSa3ivM+mczg6CgRJj5
	WludiZ28IpHQl5gNH4qi+R1wltJqB775KslYlcudx6uTGSGEFGjDnhwkWNV82QGn
	PxFZvDFDA27GFPmy91gbbJgJGWsW1M1gkMu7LopFNMnCbS4dERb1Jj/kXZQXBs56
	KAavHQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrm0yqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 08:22:07 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-83ef22f8e8bso4566892b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 01:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779438127; x=1780042927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/UiZEin/CWLczHVZ/BWfU1j5gZYKxKRp02pNX4UGT9g=;
        b=jUYEyprbagYfpRh7BqmuExdy88LKLUdSQQuxBJ4CRuWWUnHRNTCbROBf7dwOCzjXZ6
         Dird/8Ju1/KptjGJrPUFbXZXziXlCsq4AK+H2GPDLKqz5Le9sprjHsAG1LmePXc10Byt
         WVdhuU/M/mdz6Uj61CD83pTWG9mSsJhgGM0jWo4jOIU25IWc1r5CQOT75fn7NrpC077x
         74HFMzDSlOlYtx39LwUQBDa08jzLHT50FoA4J1SIepapf2ZFaY6ss8nQHbpxD5jQ/U71
         z0bcxlOji4r1gQ/r83fRKUXQ3S6g+yBp0NUQ5uAoBDuxsMJ6Tg98jn2OTQ2fROkBg0+k
         o9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779438127; x=1780042927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/UiZEin/CWLczHVZ/BWfU1j5gZYKxKRp02pNX4UGT9g=;
        b=LrnHC/syNzd/7cEJvEROyIDRVIDyqYaYTDyS6twVZSvNNM5bBK7tPVwuyUkGShQcIj
         y/Pyj+jQ4nkl7QJH7UmeTXkD0FMdkAZI0GFrgm2Bh50p7lzjyW0EYA9MZWBLQJYbF3zH
         3Rayx1fBIJbS5Ch9FRqPvkqBL3cYFdzM5rLmFBXWlhf0DPYPHN/2xY/Y4QbrBVj57I74
         VtuA6gamOhrDEEiyECr56evzMNW9l2CxnEvOnGEnfX840w3RHAi9/pjFJ1Yw2W36nYcZ
         IJebbkNKuCPyzJa8VXKUizitnAcr+6xdnmCTKq3dLmffFz/DroLPi5avksYdZrkshXDr
         v6Pw==
X-Forwarded-Encrypted: i=1; AFNElJ+zx1jwHVucL7yUrx0l8xfFUNevfGgeWt9LP/M7NauBQMakh5xGXzJl49G0eZWZe6hydEYNbGD3FA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWhH7gCvSi/vChI/6oCH4TS8TsvCj2f1XKCaZ1wVQpWUi36uz
	WEO3ImcPJnt3rZ5wobmqKuCOB/qnqDMqGBXEmU6QKEQmuA0wfr0IOSdZcFZ79ViO3CyOX4A2pn7
	LJQS2oyQm1mrAZi58M0Ig0GC9fi9GXxe3sNHmEl2Lv4ly65dMVXgeGMp7/4re
X-Gm-Gg: Acq92OEPCE3efIUYRIYPM3TgeqZOo9FilARwF8dhgxiBh/9P7D84FQkWOhuvOy983PK
	Y3cMDQ52kEDOcM4rV8Jd3lCf+3LxHVFUzv65rvIdCSdk8vM/oa3dM8Ui4vU6wBRc5SCjluCM+SQ
	dmweX0EnTfToIhg2OQL+YjunXT1zzdMegTdKyvagGdqJE4aL5Tnj2BafUJvPqKscPKE3/Kr0fNw
	0fhxS0LftdaWa/sbSDhYQSHwK3l/N+Q/6uTC2Z4ExDsLwU3ElER2ciqjpT8xQDewpIZ7YNK5xY7
	/KmCoJX2ETtXihB5pjlxc4uh9Y8bCsPahwYplNmkJfzl3MUygG7ieSadr5gawyhSEG1FdmaKHWS
	M+mdu+A37SYdFiQaNZJe5k2JeCastN4Lk6RFLGffeILttv9ZIqm8=
X-Received: by 2002:a05:6a00:2d25:b0:835:3f51:72fb with SMTP id d2e1a72fcca58-8415f5aef23mr2812318b3a.12.1779438126914;
        Fri, 22 May 2026 01:22:06 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d25:b0:835:3f51:72fb with SMTP id d2e1a72fcca58-8415f5aef23mr2812293b3a.12.1779438126382;
        Fri, 22 May 2026 01:22:06 -0700 (PDT)
Received: from hu-kotarake-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164ff3e00sm1431407b3a.54.2026.05.22.01.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:22:06 -0700 (PDT)
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Date: Fri, 22 May 2026 13:51:54 +0530
Subject: [PATCH v3 1/2] dt-bindings: power: qcom,rpmpd: document the Shikra
 RPM Power Domains
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-add_rpmpd_shikra-v3-1-632838e2428a@oss.qualcomm.com>
References: <20260522-add_rpmpd_shikra-v3-0-632838e2428a@oss.qualcomm.com>
In-Reply-To: <20260522-add_rpmpd_shikra-v3-0-632838e2428a@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        kamal.wadhwa@oss.qualcomm.com, jishnu.prakash@oss.qualcomm.com,
        Rakesh Kota <rakesh.kota@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779438117; l=969;
 i=rakesh.kota@oss.qualcomm.com; s=20250919; h=from:subject:message-id;
 bh=X+JZGdmHTa+yImR9lFGIGG0JCJFj1fpBHVnJUsdElNQ=;
 b=BhOwWKcZXaj+bii894zWz2DgvnRh8vw3KUhq0PJSU0/K11QS72WJXCZS9TcVVOFvTiwoPsRZk
 1rwtcnPhDC1B6fK51EyBVuvyLvGSQlcaTZKTzKzZYOwDvq7IKna81Bo
X-Developer-Key: i=rakesh.kota@oss.qualcomm.com; a=ed25519;
 pk=dFhv9yPC8egZglsSLDMls08cOvZKZkG6QQn1a/ofwNU=
X-Proofpoint-ORIG-GUID: Y7rOS5_YocwNG8Wgnk-NZq2mnAbgBaxr
X-Authority-Analysis: v=2.4 cv=Zekt8MVA c=1 sm=1 tr=0 ts=6a101230 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=jkam1OttE9FODJyLpI0A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA4MSBTYWx0ZWRfX/gMTmt2lTU7h
 T1nM58mLyGnpDXOBnSSg/MzbQta+VrWAZ2z4BIwLeL334av6PCfUqR2Iz5WYc1T8tE5mHAvLvXN
 vWJHI7uIeUOw2PrB1IYXFgc2IcrPCObtGTHxfz0zELEQi6VLaDBfiZibZfjaNFgha/u37D6+o8e
 ToP/6c5DxNLqlYbLOF3q70zjiZhq5U5pJHfiP7n/N248IbB0aEcyEzKqubLj3myK0xA+n+OtMMq
 82f/XuYATQRvc32HpurE7oaMDvpipGSfClU+bkyek5uEpSX0hRw+diUx+V5fVtJPK+1vrjNFb6Y
 qPbZlezM6bnLvbxRLSiuD7FQxlqt8xMdp5Oe9laIeh5SdVd1LmEk4eddYWklYVem/LTZiLTNKti
 y89pcnIz5ubb7T1jeeGL3V3eJAf8Hk4xJoF3GdRDqlM1UgrNyo6iPMI0CUb7cIHZUIagyofnPmN
 oP2fGLHz5oidt1mVR3g==
X-Proofpoint-GUID: Y7rOS5_YocwNG8Wgnk-NZq2mnAbgBaxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220081

Document the RPM Power Domains on the Shikra Platform.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
---
Changes in v2:
 - Collected Reviewed-by tags.
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

