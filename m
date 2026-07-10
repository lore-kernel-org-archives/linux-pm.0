Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C378403B01
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677475; cv=none; b=AMNKunuDrIuBPW4dm444GkUCc+oQ1DK1JqZjZvXh5ZS0Ftvs9Ong5d7gM/djE7DRQ6iaGyI+tXEkVy233VM8e8hJx1InQ2PGxqEo2AbWGEvYstJNcMrPhZdhDTC5IYMqKLu0V/td0jUxyKjtwMypEy8bA73OL+i3SOR5DjVxvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677475; c=relaxed/simple;
	bh=GEXkKTQcMMDP/edNVqpiosVSMOlJ5AlopPURs9YheQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJc4lQ6znHOwyowiAdxYAWy83nqHNFv1V6dpqSVDL7WMVQZ7IpdtHneGy6iobfL8m/lmyfEKir28UwG9VZct82rMdvIqAoakxtczIRlxW1/10sXKjNIssBmLOZJZks/8GRigOQR8f0cFoS6QXXJl8LvmHmG2yxm1n68lZXkyQ/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QTfkrBSC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a3EHxBYK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QTfkrBSC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a3EHxBYK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dILP172051
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PGp6Gz4cU4q54LW0ORFzAwYhub1+CHS+HnXdjrR+z3o=; b=QTfkrBSCtwQYBIgA
	9/BP+CdDEcojUzMSbjD6hDcxDj8iBVqDkA/tXoLBhE5W51fgAlZmwbyXbWKUWvBL
	kzc1IECbrgNOXxhmMKGBQhMMz1ZMsdNX0wchJ1cbCfzFBskfe7JwuFYh4PGX0Ax8
	JejxBKj49wmapeykb4tvy/J4a8fT5DiRfxZTOergejvB7gc9TLk264PGv04zUUjq
	lK9pV0nXrZUkm0DUswJvddkTB94HlwmZtg1Zuk3p59SBj2OM5kW6tN0yJDpoP88f
	VLs4nyBA1zWz+iwb4+OFt0psbr9GyrAKA2ke5xPWpiixmTKG05dyi4MY0NYFDZv7
	wX7c+w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe9xax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c110a3b6aso10114601cf.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 02:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677468; x=1784282268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PGp6Gz4cU4q54LW0ORFzAwYhub1+CHS+HnXdjrR+z3o=;
        b=a3EHxBYKq7aRCD2vIozgBsn+Jp2M3HaBecMXWmXWuHjFcsGAACLwNNh5Ogypyk9qe1
         CBrs20BUrV0LXTBjhgNDAKtvuk7WRJCD4CfEHfCeo2AkCrEwwW3cS9KMuyp9ShYY3rKT
         1zU/S0FHCmoQJHx7TlBrrc7Hmd7KgExVFyrYrj2dr/d4u4zrw+B79StqQpRtPnW4hOgx
         gfZu67f6pA8kYbRFLzVErOzKVwO3OQFa0DvQc01GLvvvWTeFNqRhAabA+iEhXcZWhbbi
         nXcIfeSSYB1GoIelL+LxBA+ZG8itzQsZtDchZSfb2yRFGPm1iw6GkycUOOWW1MiljkYN
         DSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677468; x=1784282268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PGp6Gz4cU4q54LW0ORFzAwYhub1+CHS+HnXdjrR+z3o=;
        b=Vq6DvBIeJz2UdG6t2hngXCnX8YlFEH3LUx4QIwatG+zaYG61SY0oHpymSSKfGx45FW
         6fM0boUe9rfS/+X3fRL9meO829GlePp0mn04IL0njeE+VEOk5jcTT2tcH2sCXL7dr9JT
         wsX8JUbNgVREJV44jCxi30Y7spnG3pd0mG+QgqSKD4F7fBTDALF/9NkXC9LV4Lhi35xa
         PgBAEwlRkdxq6ArpAjnA5mEKqe63tB+tpd7yYHrYkipkFoupU+IU3X0SZid+rTozuU77
         /OUE7oHHxXLabMvdxULjrJKM73nzpHzxIRqvnnqQPoWuojT4l3OKX8CeWRGIEQAFNUw2
         7Ugw==
X-Forwarded-Encrypted: i=1; AHgh+RqHM+lQjSAi1a8KuzkMLl0gYgmVc1vgZ52TwyprwsHAw2TMIyJAxIRWWiUtcMzLheL6ySmkIrEvhw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsW+r5l+pTZ9x6lKXbHGoK/MUALHs4w5WuRzxdYVGZbGnruZve
	Hml6AdxiOAjJGsqnnSFCQI6KxpQ7yj73GJQZqjb6R/5fZE9VKDE/lqpFXBXky31RqXpg6oNdmXT
	SkfF7U+1rO9GZPRfkdyuTOSVB39xqIlNw6lhuC7i2vz/dI/GewpfU6prDA/URtg==
X-Gm-Gg: AfdE7clAGFIDQA5q61IkarUjyJs/GUM/rOT17d6U4SWUe/xrmmi+u/nabPbHex+YF8o
	i9dIeR+IUvV1jlYhPcaijQRVyCMpDFUwCAXJaJAvjxF2LCDbXwdDEtIt/HXD5kuiplfVLMljBwJ
	VKjZRkTUmkVurLcKWAv+ihppdA7xFreWpTr6itV2d9mx/kok62+EYD8nUwpSi9oeyCFV90R0YuO
	Ib7JL93PH2vsTnpxTI+YmH+MGkjEUKAkku66cL/JaVPJiDCAWoYWw6H21s4kvc1pqfpihMZndJz
	EuY26yfBRnh/lPi959nviHtQBSyXVQHOtQAdl0V5xda5J8ofTfG2xAe3G8wYH+Omtgr5c2+0JPv
	Mh8fp1A1pFT02MfluEPI9KmE0r+ETKF8vUWbnHaMKBDiDtqEl4tnyrrmvYY8fV1BgIWBuZgWaGH
	td+2opng0kFq5LPsG4BwAk5cJ/ZNZ+SeEOCnz6gtZR/HGJrWAHVYCDg3YER8staGFIDIUPK6eUH
	XHlbmnZo/IfMemhEbl9
X-Received: by 2002:a05:622a:5809:b0:51c:7b12:120c with SMTP id d75a77b69052e-51c8b4bc4a3mr138323601cf.74.1783677467976;
        Fri, 10 Jul 2026 02:57:47 -0700 (PDT)
X-Received: by 2002:a05:622a:5809:b0:51c:7b12:120c with SMTP id d75a77b69052e-51c8b4bc4a3mr138323431cf.74.1783677467625;
        Fri, 10 Jul 2026 02:57:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:35 +0200
Subject: [PATCH v3 09/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-9-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a50c21c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX4Bzy+L95CouI
 y3LKbvpru23XZelh+I9v7X1dY9xgl40YwRgTRP5voHATeocRtMmEFOsiNRoYklT4mZPr8o7jNGq
 kKEzw9rAAxLAbZ5TFP53C9WaERCmgm2LS1B9wOxHTrA6d/DYBpFGyErhPRNc5pp8oJc4dAc+N3Z
 ReLqWJgKsU8mC2DEW7LoFWAfW/gGHmrW9hiHOnAOO1NlbJdGoQDzDqKwbcDsTqvlB48zopQrm4w
 MLQv6iDNKUDuM+efVFVADCv18kZ5CUQ4Tg0S4Wz2VLOjkZL/31j+ImpEGCJaEESdU59/MkVBJrL
 C0rEMI+IXJQgjOUWE+hCEvlsuCT9BxUZUk7DpnWs0d6zYnwAWS+HCyzCmJK+bq8/wCvXYNYDFPj
 UtVnzwVSql143gNR/YP2RTJZJDfTrfqsQEo1JwtRIlQ5CtifZpTAFUXv42ouvM9RNk6EPhPARAm
 qkNqlanYRuqslVdacXw==
X-Proofpoint-ORIG-GUID: 0NcDvRr6k0ULLuJnxz37EBvymZ2CeF99
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX/VQLd3RTac3s
 /NAOeD+tdTr1BbR0Y6E1P4I5O9uP/C7IqdlyPcb3SrPtuusBsByN2vmSk2fRAANQDFB/gaM9h+Y
 HD3Wr+11pSyaKvLtnBbaA+lVKCyGRlk=
X-Proofpoint-GUID: 0NcDvRr6k0ULLuJnxz37EBvymZ2CeF99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 module.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
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

