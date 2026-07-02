Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D09D3C09F2
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782989195; cv=none; b=i+KYi/AdBxUfQ9kLRw0LR1JcsMCHZRDnKI08mstdA2C0qrtH/mq17sK+G1N3fHDT5r1D1M2WmtRgmE6S/oDY0qwDRoOb6FFFEAdnmBH4JzxQbcNg/W+wNOtPu1G2Sj08hLkLOMcXGW/cSja4ChIsIYeLo+y/HBM+p7KK6gQIj9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782989195; c=relaxed/simple;
	bh=is34T+5VZ9KaYEjSCb0JcZdk4sPIyzkgjH8dnFiyzis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p36el54OsyL5QiuDdG9zPZ/sREEDP4iJUKV6N3K+AQGgdXdw9bJtAp2YMrVvlhsNyXggl1RH/O2d9B55PoFk9Z8T3rDxO/uVdLKmIkRlcUrzL3SCuY7jVGg1OrJ8uETlSjD/npR5fbisNfFRh8IjxOKYNR5oiiATx8O4sPE4KO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h3sfoino; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G98Ea5vQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h3sfoino";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G98Ea5vQ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662AK84x3591746
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 10:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	06u0obT0KsD6NADPisjbsieo0SuABc6UWVTociWVLUM=; b=h3sfoinoK0nxFzSb
	DoBM7khU5lQ+Cj+THPgP0Vdcf4tzaBsa5RJP49PMXrV1+k3cNCL6tbA79zZIQoQK
	h6QHyiJ/LFNTxpPzqLWmNy4Z11/mB6h6J6xqypWZ8xPa6ssv8H7wWeFXYi0VAukN
	pNzUuBx6Id1iXH1bZR7T75YeSuRK4M2lDGmTOv2zUdw47oKorZXgExv9yQ2E6S+l
	LBQP4ZuFcFEQ0RI0ZTM+KMp2gBJRz+w1OD0ksrufSA6Puuky3dZc37Z4xMzidfLV
	PBBufFUBuFe1BshiSp+blaHfNRmMYr/28DaC2Q/UQBfCDKjJjdSgy1a5f8wgANOj
	mqWx5A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n9ady-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 10:46:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9203d077d77so279197885a.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 03:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782989192; x=1783593992; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=06u0obT0KsD6NADPisjbsieo0SuABc6UWVTociWVLUM=;
        b=G98Ea5vQWXDnmdlYUne63iYgRb3jnQ68U0gQG7ljW4mpKVy/v4YabNrfgqUL+dSWXu
         nXV8Kq1nRdJJxmVBOG3IXK+5QhswEjin4E5/qBi58aAFW7w3J10fvuqnsXvvQAKUFmLP
         PiwButOjV4o62+CvxegaTqmEp2TFG0vyRyzui69MiVdYwbMOCIsxnf1Ks34oZbBbPol/
         FpXKv3t1VIvaanYOZnBY56G+KJwgGMVovfEdutdtF3PmIsxcs7LtX04C8M8iuLX8/dWM
         TP/YVjPVvIRY7zJcwOd+LwLdghcvEWBETlGEJWarvIPGbRjayf3yU8QeMhDqZN5cR/Nm
         AAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782989192; x=1783593992;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=06u0obT0KsD6NADPisjbsieo0SuABc6UWVTociWVLUM=;
        b=q2F2VctdNnBXGICAcm/LoIM5Lxzo3LGGAhb9E9WIYzwW5ysFDNAzt2AW77yJ/JwVEN
         AAZBAnJpAjC2Kv5KeghCHIhyqaLYi8A5R5db4mDJIcz7wdpcPynuxPYh1F1AGNzDc1Uv
         BgsSsVjBUirKgZYVwzdiCq9jhXqJ9+a7FBy1wVnAj/9YGCwuOKVheylHeWntA4OnRThS
         y/RpjyEWCpV+qvbLuTbR5/I2UWMlYmRVCkJ0DPCjce3tlQ4L4ga+A1yvWY9cuuxGzIlp
         3w+E5e6RpgztPp78mdKsnJiNvJNKXYh6g56q1jhvR53jylpEVI24B9f3JAUIXvUryzw6
         7l8g==
X-Forwarded-Encrypted: i=1; AFNElJ+qII9BMzer3P3AH3K3L4WKShnRRZ4u5Q8I8ntckD3HJqEahMPOAshlWZH62iYRQvUVMMn2rIXfAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWWadtC+SCDm77G0aYO5zShbRfmgL89oHmqC2J6zrgBmPbunB3
	71z4oqjdtlLQ9BwO7X3fIrJPjNttWwpqHXt/ktwByB7UvcKVfjHoh7R+Frur0JH69v3DsnVBfjC
	1IMAouBQtkr5j3E6pzwbtQWvdNF8/tR05GdgBEp5NTKlnYwM2cgliByAAEY378A==
X-Gm-Gg: AfdE7cnP8iyKdUHkOABA54Cp7PNM51281CdJiKmR2lmfPErNO7x+qTW9bAhwyTm3NGX
	uAyKl6GdopRWCEmh0zi4O9ZSalWOzd4zWiIflm8D6RFnN7krNyhtnDs45WKuSOnqxZbXu/Tz1aL
	VyopzFupTWTZkl6ZUGnMBVFOGE946KbkCMN/vCOYAp97ilgRdn4iv3zkzay5bFr2DyH5hg71o9o
	9pSu0gA0enr/qn7Yc+DidCLiV/3D1OK8FuK/imYWx9IKqNp9BOBJkJn3wYuGM7HSLARstbpJBf1
	PqKRnh5FEbi+l7LKRBKsb7xFaeH/1mq9oVBVSLY0bk2jQmMnoRids951xDgk7WD6TrOGmZJtrkv
	aGPbCwGU7Felogmb/ArSSec5swQA3d4AFG7Kepbv6tMlDw8Qr1wlayjimaKN307iy8EsV6PcSNm
	pfLF5v9wOBq/T+Wg8wFJBGYUUXntXDSFssHCQAv5bpzEJH8K3F0OTzopSA9urPfNI=
X-Received: by 2002:a05:620a:29c8:b0:92d:e54e:72da with SMTP id af79cd13be357-92e7aff4b39mr630185585a.22.1782989191779;
        Thu, 02 Jul 2026 03:46:31 -0700 (PDT)
X-Received: by 2002:a05:620a:29c8:b0:92d:e54e:72da with SMTP id af79cd13be357-92e7aff4b39mr630182585a.22.1782989191402;
        Thu, 02 Jul 2026 03:46:31 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b5ae4959sm109689666b.0.2026.07.02.03.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 03:46:30 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 12:46:13 +0200
Subject: [PATCH v2 1/4] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
In-Reply-To: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX1aiF7n/Q+wyv
 0ayRvNWKedFNO/GNyi1tVQPyZWbDPEFRH5d4AOTAwoQ8VFxIj+MUQ4Y/OjiQ9ZEOBkPSA/xJAGG
 DFT/0RYdSqtUE2Lg3HMzigy4+GG3D2r6EQTFXAtkeB2cUa/Af35nu/1qZ2Pe3x79g44ZxYelHRx
 trWtyeP2ZQrUH6wJFTRoWossFO4TDyEUNj57Y5k1Z5SqNGl6p/SINCUhoBdVZfu+qTGrHmpks0x
 J3r1avXurat9yJ5p2+N5d/aYNPl4lezibkSBkYwL6FQa3DuzRwpp6Ph7gexlEwE3p4o+HzAZE8x
 qbhRLyNc+0xQ7MY5u3ul7A9GEyzEZZRkQ9vBWZ2hjoIBjUcq+DnMtwIe09o1Kffjw7Nob1Hb7fq
 l0QSTa6EnBhzAmWA5S3HCM6LjxrtbZfVy8t0qLw/EeNPBDoD8w9RohzdbO7Fz7zTnd3EDL6wKb6
 FuKAu+ISmd6mZONYD7Q==
X-Proofpoint-ORIG-GUID: xo2O2jnsFuDvCGy_ary3_rcM802SGEL2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDExMSBTYWx0ZWRfX7oLFw0/dHqw6
 UCD/+IuxSUcbObqrfGJU1LD/cTepwqEDENqJ4rsGFazflPh8oIpuVvkFFLsUHsEyWlwZghR6/HZ
 Y+ca/dGK38Wi41WU706jcocYe0CXIT0=
X-Proofpoint-GUID: xo2O2jnsFuDvCGy_ary3_rcM802SGEL2
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a464188 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020111

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 module.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml         | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..0282c6ee9272446064a99ec6314a5ceb1721e0c4 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,12 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1

