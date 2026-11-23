Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442187;
	b=Qqjr2o23tBS+dSGgvaJAerGdufvzRcuN7AWopmD3QOqZjgl6LnI6eqESaUJPR53kLgY+
	 mpfAvo4nk7QTDWgC2w1n+xamsmHjN3aTzkCi/vWjMr+j1Td0xXx5akzCdIfaF0+9+D7BV
	 ZyiEbWDXucT3aTjEG+P8pDWIwc10GjIPJUJXha9eS/6D4RzQKiK6zxoF/EJl4y+sHieDn
	 ft/3QLde+onf52OnfxqJjRf8X+/KK6Hr17By21z1Q4d3LmFBG5Bht+5ApPTrv0aKb8A8s
	 tjKVEWJ+4b7YN3c/HNqObw5c8+c/F8SPA1wQbU5yyAyUGqwppbVpwKeaUJDtuxbWmJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442187;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
	b=2XwQWWnzf1DHH2KjpSaUgxVv9+DUJ5y4LG5JGv5kipCyoYSZOgV04pxw0nX53J0J/caN
	 sE5LvvsWi+K2x3ROcmKwJf3zvCkAVyEVC/UgkxthihhRgC61a/FX9ugnpc9CrhISEjiKl
	 mPkaTnnGEbTztPXhr6PLrxwayz0oQLiPV1qpnTn2EndEttRHc1fki3yrDGJO6L9PITact
	 tXkYcfBYWbPSDp+bu81mg5q4un3MpW0R01uwZzQ/5sdqqT0BtuyiFcVbgMuest4cax7GM
	 9CgAggM2P+NExHR9GPPP8Lgz9uPItoSIIU0k1AeKRDDmUup728T98K8fv0wFbMPip4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=abTfYYKd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DmpkH3NC;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193E606A69E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6193E606A69E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=abTfYYKd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DmpkH3NC
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDL6uR2086193
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=abTfYYKdVVxr89hG
	gG7xas1cvb2O9ZkTi3giz7uXwF+Wl/+Sa0ez4lSmOqUee6+Ouh+3ZhMPOYSoFL5H
	NnZTTBtSE15Gxh6LGjXJDDTw7TF5FNfsXC/Uy3ufbPn/PZ6bqQiXyoFqCeJDo44M
	4GJVH05GJvJS0KACNC4YSisoic9I2dpZKVEsxEiMztK3gNtCHXhELui7pQzOuLNI
	A4wnVzBtjZQnOMF4F18mDhRPKtbEMqS6rvmellhk6GMgL4qZmNz5HQphOUUd+IbY
	+S6cp1fIcIG9Gm8UembnMBIog2Kz+J4gLllY7nVXw6xBEtRxGLm3sAlfkS6OxGVN
	RMDvww==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4fy01nq9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:26 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e92aad34aso605271085a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442186; x=1796046986; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=DmpkH3NCBuuRUnlyNwToYClpWU8Fij3c4cxS9TEoMctX6+TJPycE368lwVpDZS++IL
         lTuPhzwR71zgAE+NMzHh9utJh265CjYOqTjCOVgahIuoQkltX7BZBZzCrGJK3RePKr1i
         f9/05QAV6CKVAcQjygXZr3rBqd5k9V4cFSHOys6G33G/nMiHrwfM6SZSQb0oPiH6PPxB
         El7PslY+/s95FZlEYR+cW/asEj8VqS38D69+UJbLluh6uiyQJwFJJmwmm27HZ4jZ7pGl
         1h3ykO3MQGBmaPszg2wavS0j3u6Dj7Nz6otnSW3GYfo+ntw1Or0Z8JeU8Huv1oEgET98
         vTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442186; x=1796046986;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=i6QwZseFu9OfGqr2BMOiAPtbvCdB0Mbc6UBzM+5Q8IMYTb29zyzTl8/hdaZ/f/yHOD
         fg0JsKJuP3H7G6NG5PYh62Wg58MLvL8UUlmjYCeotCB6ax+iCN554L12tHVpbJrrYEBC
         YCQQjrFbF1CIBqq4cUOoUwrLHguPdii7ShAOUutMNAJGZ9x5rOXS3BWuGmzzlv1wB04C
         jeWsDapR5lNrn8HO1IO0iMxeBSWn5Oj6X6cwVM05x6K7IMxc3aqKHqO4nRTh6SZQ/w36
         H/klmB0P3zHGqaVQvpXPwOH8Sz6GFXgb1olJ/eHMPWSbG6YciYhHet3R8cDfPaSaOnzw
         Q8uw==
X-Forwarded-Encrypted: i=1; AL+hErFfCgF7kDKWcTnyuWgnq/bRwsHv2wu5kzUt1JEYk4CDNTQrlkX4qzmryCLbi8HlRic3spafx4Fc1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7jJUTWojUPnnw479tUbnflpp9zTDJBLd2fYnULl58osBtlkFH
	yh8Yv16caALz1+3IoqGchCR+ApN3Lb+E/SCY/myyg4mPWAiXbxvWWneA9dFPT6HAm9cG7+JE26y
	oqrtGwJ5vQ5jcmDsx5+/CWjg0DXSSf5yUuEr40GOKUjNfIqy6RjpeclNI5gseYQ==
X-Gm-Gg: AZFdTZdHSRBaXIS1J6TIu7NyySrPr/9aUWgYbVCOE1McXQReX+KoDYlhxqjEaEBqX09
	qvNAt/w7dQcdi6xD5rDkNA+b/0UZzOUSyvU0h7cns/FY4KMbnNBdDKYYREJp5pu8dZGggY5yGrX
	m5XUfmsurRdAoEgI9N2wVrzBMk5LSCNqIS/KX3zRyDqcUviD3cywLmM4453j2RVgsTAhEmHUwxq
	K+DAwu8NGSWeG/QzSmAENsQ4BGIRoUmSQgc2+C2JPPfRLdxgpWgYhivqz7JFQ9mGpYehU5cziuM
	8EtU5rQU0mx0PS+8ODJNOSobL/cFDkQv85KmgQsMcfTcapY10d02cF0ROzc6rrZ0kke/TlnptkV
	u/IDSfW1aa1faaiQxtxegd3To5XsO/VWxQ4+/B6jDwimO5gssOx+gqHwqlkxMO3cLwGz/s5tBN4
	qoNwUaIWjtZiQHt9dLIJMjwkTZF02CPt8WZ799Ssd0OwLloFeXl0D3V8wBoCx3pUNXhnATaSn+6
	T6cyibxCuHmmQR1xMsjB9erzXRe
X-Received: by 2002:a05:620a:4688:b0:949:b7e9:5d18 with SMTP id af79cd13be357-949ba9c4c88mr2022361185a.16.1795442185695;
        Mon, 23 Nov 2026 05:56:25 -0800 (PST)
X-Received: by 2002:a05:620a:4688:b0:949:b7e9:5d18 with SMTP id af79cd13be357-949ba9c4c88mr2022355285a.16.1795442185001;
        Mon, 23 Nov 2026 05:56:25 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:24 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:14 +0100
Subject: [PATCH v9 7/8] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-monza-wireless-v9-7-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX1WL4U94ngZHu
 vOoYV6A/j4kD4wjCQp/6R/N86LZ7Cc00JHcSEhCZKRqE0Xm0Ov8699bIsDoGIbW8ni40Sdc4tVI
 TBwjXyRcNsN12YHW0Cjyne18tep8ihiRGo9cAzAgkDkHChKj3PJAa+4Bt22bBNkM4hlIcDhgUi+
 umsbNbJ8HqWXm13Y28Qer7qVU41LLE6xLK99WW6EHHgO2X4LgLeELDv3rbS2M7sJMC12pkJAASA
 kBElwqV0cnZg6sNJ7B5Nbd8oXb9oZtlAn209AiHRmX95LCRqsn1oXvC/cnj+ek7I4P6Hgzf5UJZ
 eaLbBGCxBIhpmLaoVnR9mV81TD7itUIj2vactzkNzw/9sTeBhyYK0+bKfemnWs5TFwYdbT8wgv/
 UVQF6YfTKZKH1Ql4s4UZtKc8LoalJA+X6Dfte6WsdiXUasefvY02YXwjRird6KPUVA6JrRNwldF
 3vMc4Z/1HRyQ/WcerYQ==
X-Proofpoint-ORIG-GUID: MAwFiVW4brS2xDfDou0vVnwvLNJxt7GC
X-Authority-Analysis: v=2.4 cv=QrXLTlyd c=1 sm=1 tr=0 ts=6b04460a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: MAwFiVW4brS2xDfDou0vVnwvLNJxt7GC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfXzYr+HhDUnENr
 qh9fc7lyYsbGohVFXHOUfIAytCu8UrZjUFgUq9+qIIA4Pewwh+UANg+Rd32258dHghk4FHTVPuS
 U7O+zg7YZpe+Q2Wem9s4ivFXV/lYAxw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
Key E interface signals but are physically soldered as an LGA package
rather than plugged into a real M.2 Key E connector socket. Such designs
are not actual M.2 Key E connectors, so describe them with a dedicated
vendor-specific compatible while keeping "pcie-m2-e-connector" as a
fallback for the shared signal semantics.

Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
Arduino Ventuno Q (Monaco Monza).

Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
The Lenovo Thinkpad T14s.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/connector/pcie-m2-e-connector.yaml        | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
index f7859aa9b63469cb43919c0b5719c18694c5364d..ce6173a0ec41cfe8ab4a5780940999c18674ab7e 100644
--- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
@@ -17,7 +17,13 @@ description:
 
 properties:
   compatible:
-    const: pcie-m2-e-connector
+    oneOf:
+      - const: pcie-m2-e-connector
+      - items:
+          - enum:
+              - qcom,pcie-m2-1418-lga-connector
+              - qcom,pcie-m2-1620-lga-connector
+          - const: pcie-m2-e-connector
 
   vpcie3v3-supply:
     description: A phandle to the regulator for 3.3v supply.

-- 
2.34.1

