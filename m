Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175177;
	b=yxzWVYjkpYObswS9aBb/TmO3VdzNHV18CpE9nqoLs0opwDWNB65utoz7RGN8xOH4bMyt
	 zvZhtj5Fts0PozwJ4pFXr+dd4PxDn14+xs+W5meJKhvJqGZ6ycuRRxp2S0dDfwB3er4eK
	 zQtpu+lnkIkkts6HoPuMv3/+qgq0H4ynlsXrdk3AYMFqM9kImayMH0Pq4MWWSdfjEVEN0
	 /9bPyiiLkTB6uRhwTfQxQ1OuYbChmUtFQyeIPGCA+C2DAVKiPES3KpGh3wKI6x909kVKO
	 9IXyxigQh+zTkE8Em92xPpAk6CpkyO2vp9qdcZtRNLWdqQI/OpztGIir/jT01Qlqd3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175177;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qyDQUFF2Id/JL1J8lTWcyQHlP4OzxlWsI56SmrkK9Jk=;
	b=PUzm69ywnIkkn1xAPzZsu82OrS5f2Rf72b+AG50pecOF6z1SshqJNHCPqJ2LEQ8SY3iQ
	 KQnQKrXXXKWImbIXLhMW6D8ZfzWQZma4UuS0sNZOhTMPtlHJ7yBqT9ZxurcNN/ONY+36v
	 nz3HLjEXm56lQpusg582OMMHY3/TldHQya+ZccFluAxXCg2m3XqjyxBtivFdSgB5tRDYj
	 iCNp2XFr5vz0Mw8KESyyspTKODNBS55Tsv/8QMZnupWySWHn5/s8nLTU+XRD0QHCMxe9+
	 7AgOSUxNvvIcWT/4lbkLp2+hFhxXeB3AuAWnxPSyPDvdv185nj2ko6V2bSV+I/kCbwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZfQXcz2p;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cNv2EDOT;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C63606A320
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:12:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3C63606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZfQXcz2p;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cNv2EDOT
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69S4Q9Nu2753510
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:12:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=qyDQUFF2Id/JL1J8lTWcyQHlP4OzxlWsI56
	SmrkK9Jk=; b=ZfQXcz2pF3kgHWDp9VrfXW0NkFEso1q1QljvEXXSvaIq2aYTmB/
	PHB03hJJgGtkmbUWISDDe1iiyEQvjh+m9PxhNEzBO4eSgSQ3vo9b6zbe+X7OVjqA
	HeFGCsu6DWfCuuMHiujvOimGwc2TossBKvj+byweYHMw8J/u16Wnpp5900CZLfAo
	kE+PuJAdZc51lecKf+5ELfAmAkd13k51AqjWY66aEh7J7gFDomYOkSWw6SgD59IU
	6I503z0EY+w4E1vda9HfFmHmc+hH7zAmqHk8sKrnPYxKn3Kog3f+4jjjmwUQT9uM
	Dkn/VJm8+V89xcrKbLuT1FxrySRAS2OaPvA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy713733-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 08:12:55 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93caf7856ffso144297385a.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 01:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793175175; x=1793779975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qyDQUFF2Id/JL1J8lTWcyQHlP4OzxlWsI56SmrkK9Jk=;
        b=cNv2EDOT97A+yNuoCbteN4zGiglZ06L0FTJOOjJYwCbvfBn5DMyG0y8HiJe4jXWzMT
         QFFvAEM4TGLGuztVjXm0wmHRLe71dmU9+n+/wmApIIqyh+Cb1W919FSzSZVvqOVcSv2I
         nJHXK89o0Lw9oqaj9voBYdeIjiw3pj5lEATHj/E1nErk03QSNb1gOV+N5T/2chbwgcON
         522xB0EWgoEvoHmMcYLmQ45ZmKX+MBPsL3i+OYFZmonJE+Y37isHOOql/iX187Jj9tu6
         +ckYYoNAfBEgw2ob/LPoio6A+pI7MmZMRk7lOAS+k/zpW7BvZcP+2fwoJwcTG6yPS83g
         nXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793175175; x=1793779975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qyDQUFF2Id/JL1J8lTWcyQHlP4OzxlWsI56SmrkK9Jk=;
        b=F9W+2738V4aB/ZfvqFbADUJEhbUldWCvqefNNgie4Ej42eGGkCtMBCyfTc2qR8D07N
         B6QlYIb7LPiBQ/jU10UjNBkrun+mHLhHzsOccu3txcRAoTybC3VDcJxE7duufd9jkIrq
         Fi4M+18ofNDGQ1+O3ZiA/ocISU2Y46A2Nvga/SCRnjGr7wVohjDDARuXz556PjsHhB+J
         OPHEAndr+oa4PKXBJ+o9opwOtPmMZxsZ832vQ75VuiRPQpDNkUted43i8iZIFsuhj9A8
         ndu7Fr94tjVf8IJQxAw+kzZW3k2x69ts9M+dvLehrzw91Fnr2incumnraGPeqdwjn/iN
         6R1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxt3QRzv/Turqc5rOdGzWPt+a03CPREOTC0MOFzwtTrKhk+70AMyx6LQKV1oY0+8Jqb053DmdzJuA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLoAQI37O0xBsjzFM4uYkNNjLRhKavXLKohRR6RZQsooucqx+Md
	JvvHMq2Xg50N3NpU11hAiPbm6m5JElLwxx4b7ReS8EKfgGIYJsKF6141Hu8RQw16pIezn/mhpXr
	WehksUoSGtmoIVHZfgi6bP3CqLxns9vxbsUGoEyJtkP+hwhrPoM4Qf1UkR8irCw==
X-Gm-Gg: AYBFou3facR6Nhz66LHn2UOEy9hyCRA51Ir3OOEjwwwlmKyigWMEtC619DEuIWiXl/r
	nlLQ/9+9hoMDqxSEIMMMVIdO7d6Ez3Ynq8e5sbIp9LBspxggfR2n9utlk6V/eofbi8uScICblB4
	i/TTqKeMLUgsCvJtimY6cuXKQVD9RrYkRQFhtqslHzfgJotBCM7NN4b1xBM0vC7Sp+hoehJeLwS
	Swp2aNmkRMt5/f+PRLytixYUxqsNjdS/G0XqEW8T9flcUpR1Uodseh+9qHZ7ay1nJpWDXf/BNZ9
	CDCV21muVL4PwleHnLVa1cc/LAVPVXWL/BOqUZF5UKwg09gN5Mxfxly9MsbGr4Ffh9Sfdy+PbXa
	vQmwzthoFmVWHlYnImLDuaZsYVQkMd/SVS63P51H1MoOwm8+Pe8rmJdIB4nLcww==
X-Received: by 2002:a05:620a:6013:b0:93f:18ba:bf78 with SMTP id af79cd13be357-94408d1f56cmr185549285a.69.1793175174840;
        Wed, 28 Oct 2026 01:12:54 -0700 (PDT)
X-Received: by 2002:a05:620a:6013:b0:93f:18ba:bf78 with SMTP id af79cd13be357-94408d1f56cmr185547185a.69.1793175174309;
        Wed, 28 Oct 2026 01:12:54 -0700 (PDT)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3cfasm27072976f8f.17.2026.10.28.01.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 01:12:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Barnabas Czeman <barnabas.czeman@mainlining.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Danila Tikhonov <danila@mainlining.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH] dt-bindings: interconnect: qcom: Relax child node name pattern
Date: Wed, 28 Oct 2026 09:12:44 +0100
Message-ID: <20261028081243.38562-2-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5321; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=uUqlSTmTFtXhLMYp1LUAp5AuvOZCnusljum3tVLZO3I=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq4a57siYh18pb2JBnQeoruZi8r1IPtsM+O04l1
 yCZv9vFs56JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauGuewAKCRDBN2bmhouD
 1xmVD/9BheKSHIfPCUlrZWpdWQ4iY91ANpbyRdFKdONVcbu/flx71Vt8FSCikEq7MQtfmvxMgje
 xtzW1Vy0o0gCsLjU2aOemIjxBjFU8iFIGYv9nGS9V06VaXz006zZTkoiBu73+80As8KBAP7xX1a
 arV783trROSimoaSHVhEm0xzv1JzTxGXDl5VTqLUenD+vQuYFLcyTv0/YlQfAzGOvBYHi4pg7wb
 Ju1N75LEfEOWvCu4gj/rCGvBcviJvtcrAp7LmDTOXqUKUw7BSbViqpVp0QMzE6CZO8rqAFp+9UO
 BaiOqYJXkD6wOTD1p0NVRBgOCf3YlZlMDJmvSn2vPZqQG3332OPCBgvPOoHdB0+GkTQaP4v0+w2
 Q36yrlKfbbVKtTZ1rytw2RHeQ72OVq+dmI36oAzEUqGqCYf/S8ghE5+IXNM8ycVhRikl39ndFMy
 ATUEdWxGQeEPPpw/rC4jLt0tS+QACZN0HroPh//wZ2SsLY3TDtc/Y28bWLJoXbIImFDUOvhlk3s
 EgSft5+nrIQiHtjrsyEiISKNmmsNZT8pjs/Gyos2+0K9G13eK1jrtMxdyLT/H443mIQ1xPGFDYv
 zi6307QH9ncuWAaYEP96KPC72BVNT1kI+toSjgX2uvofcZPGz1o+lotTg1BSmHnLrbflQyKvpoc Y2pGE7x5ClTJMNg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDAzMiBTYWx0ZWRfX6iYKPIJs/y3U
 jtgLEcM+UcEz8JPJHR+T8qylRSuVpcwvp2p0n26cYWgNMiA3/sb5qxh9N5orN9/zNzLFBomEOBN
 IyEfTMf+DPgskmJWAbQwLdzDTIdiIjEmbkx3X/8Hsp5TDcNwaPilyvXLrmAKNpLQDhwBM9sQrke
 UEkMCjCPvVxfiMecVW0S1s4OxeryhavxXlUZWje1wsuqATOGu6vcaU72hZ9Or+zcqQl4/h1OPo/
 lngHdoCZpBv0iKuMMQ9kifUgr8H1PoKu9gTvyXsuI/c+NzyOULPKUliChdg9t1+6q5oebrJxvnS
 PS0ly6WObvzE3Mj4ynbeFrrkuNidktd/XtQulVrxeMrzmt+nye1xMjSSiGrNHMILrxUPXdyXq3D
 ZK8ab4BJ1oGVqXBeJE4gVrHMWqxIYAOZXA+Xz3EZ6bJyxNwxcdNAR4kqXPFTtmqQXEzaepyF5rY
 Oy+AE50Oc0KPn/49PWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDAzMiBTYWx0ZWRfX17KRUgcE2ox5
 2BGx/qr4eXSYX7sstmzwZ1VuGpJvFAHhM06kdqBYOMEIdnSlHBKYYgycwq6ZHCZ0nxkmzlW/DrG
 5JtpBDeUhMyDHzCo7PxpopL+OBstpi0=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae1ae88 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=KVRzILKH43C-bKGDRGIA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: I4Toj62F7XQixP1Ja3M65zcr5bIss2zr
X-Proofpoint-ORIG-GUID: I4Toj62F7XQixP1Ja3M65zcr5bIss2zr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280032

Some Qualcomm SoCs interconnect nodes have a one child, thus that child
should be named 'interconnect' just like the parent, not
'interconnect-0' or 'interconnect-foo' (see Devicetree specification on
generic device node naming).  Ideally the child should be just a
property, not patternProperties, but that would be an ABI change.  Relax
the pattern for children to allow the correct naming.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/interconnect/qcom,msm8939.yaml         | 2 +-
 .../devicetree/bindings/interconnect/qcom,msm8953.yaml         | 2 +-
 .../devicetree/bindings/interconnect/qcom,qcm2290.yaml         | 3 +--
 .../devicetree/bindings/interconnect/qcom,shikra.yaml          | 3 +--
 .../devicetree/bindings/interconnect/qcom,sm6115.yaml          | 3 +--
 .../devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml     | 2 +-
 .../devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml     | 3 +--
 7 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
index 534644cccdcb..f8ecfe60a8a3 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8939.yaml
@@ -33,7 +33,7 @@ properties:
     maxItems: 1
 
 patternProperties:
-  '^interconnect-[a-z0-9\-]+$':
+  '^interconnect(-[a-z0-9\-]+)?$':
     type: object
     $ref: qcom,rpm-common.yaml#
     description:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
index 56cdb77b369a..538115048d99 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8953.yaml
@@ -35,7 +35,7 @@ properties:
     const: 2
 
 patternProperties:
-  '^interconnect-[a-z0-9\-]+$':
+  '^interconnect(-[a-z0-9\-]+)?$':
     type: object
     $ref: qcom,rpm-common.yaml#
     unevaluatedProperties: false
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
index b6c15314c5c5..72b060a4a193 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
@@ -26,9 +26,8 @@ properties:
       - qcom,qcm2290-cnoc
       - qcom,qcm2290-snoc
 
-# Child node's properties
 patternProperties:
-  '^interconnect-[a-z0-9]+$':
+  '^interconnect(-[a-z0-9\-]+)?$':
     type: object
     description:
       The interconnect providers do not have a separate QoS register space,
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml b/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml
index a0c26de94ccf..456b56222866 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,shikra.yaml
@@ -31,9 +31,8 @@ properties:
     minItems: 1
     maxItems: 4
 
-# Child node's properties
 patternProperties:
-  '^interconnect-[a-z0-9]+$':
+  '^interconnect(-[a-z0-9\-]+)?$':
     type: object
     description:
       The interconnect providers do not have a separate QoS register space,
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
index cdae0acf3a1d..0024fd29c0bc 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
@@ -31,9 +31,8 @@ properties:
     minItems: 1
     maxItems: 4
 
-# Child node's properties
 patternProperties:
-  '^interconnect-[a-z0-9]+$':
+  '^interconnect(-[a-z0-9\-]+)?$':
     type: object
     description:
       The interconnect providers do not have a separate QoS register space,
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
index 2dc16e4293a9..c62816917862 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6350-rpmh.yaml
@@ -32,7 +32,7 @@ properties:
     maxItems: 2
 
 patternProperties:
-  '^interconnect-[a-z0-9\-]+$':
+  '^interconnect(-[a-z0-9\-]+)?$':
     type: object
     description:
       The interconnect providers do not have a separate QoS register space,
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
index 978930324bbf..ec08000abc96 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
@@ -34,9 +34,8 @@ properties:
   reg:
     maxItems: 1
 
-# Child node's properties
 patternProperties:
-  '^interconnect-[0-9]+$':
+  '^interconnect(-[0-9]+)?$':
     type: object
     description:
       The interconnect providers do not have a separate QoS register space,
-- 
2.53.0

