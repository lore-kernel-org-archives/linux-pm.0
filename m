Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030503CCFA6
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534670; cv=none; b=ZBaV0F05G2l3seQutL97ji7e0nJHUfHn12f9N+aZUMXsitraV1yopzwB9kXhFnrEs3CwuOvGtgCsScpU2fyW7kTJH2jglkAvg4QgO8RupV9kJkQMHtvcRuTYqzHILs7tA496a52c+AiqzGVEETV98OKC4vpOEvIMSLyu6cV3MLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534670; c=relaxed/simple;
	bh=xbR26F+2IK0SwAaQUmAO2+Xe1VwKVtt+NKXks4bobiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gt+yD9wM8BIJe69iZmeLiSFR5kfJj06Sh9/qgeuZNsiPd9LMz9tXLId6D/JJSGebW1xa9+VlT3Xl9Sa0dTsjkmuy1rKpqAa2G8/98Lpaa9sBtSSW08K/3/f9/2lQsU7eyHXvUn5zl3VX8060+PR7AZJfFrQ7aIkPGuFwHCzzOAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zzb3Uuxb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=My88WpM2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zzb3Uuxb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="My88WpM2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RYcT1506323
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=; b=Zzb3UuxbLePsf19z
	VswifbdogvpjyA5p1PavnkbKMv0olLZEgWqdiK+G9OQgGtvnnjfeLWtOCPPveOv0
	5n6sZeUQzDULQK+9/Xe+b216bmSzI2a2Cptuab1M7QgBLYGs1RVivj5Nzcbkww13
	yJH05x2VQJ327Fdx9k1EeZ0pxQDB7J2/nhXJ4wUeHLYaZbkyqVARlvipZif19H+5
	aMjIPznq3xl7JnKyH+ALRWFjchDANKMT+wllLoJ20Eg0EsBo5pxV8nnvjPoMpF+u
	a2L2Ccz5aq7GoXdIUDghFrtaILLXaGsTxg0wQ+d0I3IsG+tysUH+uPKnTWF8uBWZ
	EHDVjA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2bvw31y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-520a00c7a03so95470691cf.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534666; x=1785139466; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=My88WpM2gr1AKY9vCuENEKESZBIi0XiDf/Sg15JkBKm34RNH/j38nsOul0MPreU/SH
         OVsEF8kmB7kXjpaqnesKjQSXzXdiQBHVDzT/ibIbMLUS6dRU/L1+y3YjxjgEllM2QvVQ
         fGdB/B3ApquHMkPj2qZ2Qv3kzgh6689fl6jdRucaLNBmNPzzw7MKu007nN3k8LEC+BuA
         neKKXcWIPNpC0sTgtEk7k50QYvNevwGLCY+sgWhKANjfmIWBbalkWbi2G0j18l94Ui6+
         KYqYe5iUv3MZSv8Anf9GHFfETe/0AKoVbUFvumdjqEaN6gU+Npn2P2jrYAuNQZWHMXIm
         rUnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534666; x=1785139466;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdPleMKS2IC93aynK6NEkJ3p446vokYhvbwvmK8b/Kk=;
        b=BD+d2AGT6YjCHzQ3hSYHkOduIsiSZPnWGvjK3P7dY84Ld1IoWc9ffsL/6RPmoTEs+7
         0/Jdv1mdZBAhCe7nOo2v8sGAQiCjYAEpcNjXSRMFSQKN7gCmTCVQ5rcsPGSEwDArO2zK
         rW3WnLpFEl6KO6d1Jqk90zowUxUgX3FDXEn/iSo+5AYld60+cR85yydp8yhVCHBlerR5
         9ydIg5tiPh+Uq3I5FzZpyqIg+L2/mPvPwccMixyW8sCEyk87rBId4BFJ6GZBrCsQkneZ
         wgZuXymVPgNFN0jRS8RVl9MUpp06w6XzwwJbN0GF21oW8/l4JxB/c0u2LAQP263BY0XW
         kABw==
X-Forwarded-Encrypted: i=1; AHgh+RqVNIJjYQ96Dv3OUdPsM1BIolWxA/+35jQTNaermA792iCP9x8xs1Dn+8R4Zh/Y3sXVtiJtP5E3oA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8f1rwq5n4ZdPQQ1Tcb7teUsvBr8WelyeR3GjGjJJR85k8+HeC
	9JXrsQylQe1n6BK9fUkjVH0zKFz19BBUuT8EscTkxZjj8fL4uEbkEhJD2EtGJa/YYG+Pq3yd/xb
	Q7xJ+pcwsA9D22M1Kmb6PqLCaad4GosPBTde71wQ//YTSfYrYnwsBalAVYN+KmQ==
X-Gm-Gg: AfdE7cnaCB2po+I2TQxPPgbFjLFk+3vAfq5UNv/IRZrtu6zTwCpQIIGbklxgh3S2fSg
	d1fUd+q2vajNjCXIVAwtn0Bg6U7cz2ZlMd692bOzCUoNvJ94Wkt2VSWXv2PLXbWGdRh/NT+hden
	37CK9DkuT3SnrmzR6BkVKP4hW3qWWmqXPlxlPDB2xrp6k3T9HFxUVZ9dSzU/PqJcnVOnCZoSewk
	Os4DGhesi37vEToFShtQMOK9GaIofgn4x8YVfwpkmOwf27V2jF8C0eKkqf/sfSIIJB6E0BmOvDq
	NaW7SCmtROyUPpJr6YoVaeq0vrZHMBAU3ZwtG0vn12WvIYiXjaVQhm3pSSxIcJy16XtD1Ng/pL9
	2RyT7ZPtf1UdqSosVpRAfwP9e+f7W85JT1nf1q+DZ/kUj0BHHgtXY11fI8uh8+X42s2ZVGT0qer
	EQp1gZKhPfoRsA/KtP2ZLpdCTSL9nxPt9VrkuaiJhYYrj3JitBKIQ=
X-Received: by 2002:a05:622a:1b88:b0:51c:1027:34d4 with SMTP id d75a77b69052e-5213c8e37a7mr124754391cf.11.1784534666050;
        Mon, 20 Jul 2026 01:04:26 -0700 (PDT)
X-Received: by 2002:a05:622a:1b88:b0:51c:1027:34d4 with SMTP id d75a77b69052e-5213c8e37a7mr124753971cf.11.1784534665522;
        Mon, 20 Jul 2026 01:04:25 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:24 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:11 +0200
Subject: [PATCH v5 09/11] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-9-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
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
X-Proofpoint-GUID: G8CCvDmH13pXmlJy2XZAb9zNNHfXxCVN
X-Authority-Analysis: v=2.4 cv=EcH4hvmC c=1 sm=1 tr=0 ts=6a5dd68b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=M8sXMW5dAYDte-7YvdsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX5975d+0C2ZF2
 hM8JB6dOFWeaKjJTDSj5kqJJpkbJ1yTyzFlCBSQyCJZjAT/KMW+WIF9jdu8xpOjeE8XC4vzC+ku
 tmnG0PT8M4zb67ayi+rkfCJdkCW60D3endqncDZ8NjvbTWxL0oWJtCYtLyV0s1qow4Wmtd3BkQY
 VvHR7OohRHdoq1CJxdHkCrjstr+we4ZK0kPAA0qA81flfAHqhoR68vyUvoweQdCEN4dbSg9iWEZ
 Samq/+jSC68dpm7xeUSvF2LDPWQY7sqcdIHygSx+eTgecnhhZgff5+AVJoRsFYdJ6Oajq68JEUL
 49SzXBoGpv/5uNp5Ko3n0cMmrZYQfJdMlJ/ikNtD9Pb81y6XtpmZRFs0Wqes5enJBRI30CVyimZ
 34f5hiSLtvyIhSfLxzJP7ZcGslMvy8i9zTvNNITqE/PmPj5zD5iVAyWQ59ZY3J+9UikSHU556wO
 CfGrSmpwO1YBE9+zwtA==
X-Proofpoint-ORIG-GUID: G8CCvDmH13pXmlJy2XZAb9zNNHfXxCVN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX1CMH6oVcgAFt
 d6rAXnMT8yNZiPbcB14DcfB1tnUOtWUCFjLL/DWKxB/JqCIFM2dpTpPfzt1Kjcomu+OLGg8UZor
 ZVBy8tcxBqM2YjAGy3e4vbu3k1hE0xQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

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

