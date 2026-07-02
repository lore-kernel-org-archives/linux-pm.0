Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D6A480DE5
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985862; cv=none; b=hojXIaU6jBE1/zzTQKvP2KhDdLnQfTQRHG6NeQRm6KAfctB+YIMfZ/ce5hNpj3FGnz70M3x9qNhFYekoKxfdBM1mL4kUg/+rTWNAlkxIImECvx0WElmCXuwsfgiwGRE2ZxOL0L5WC/Hilicf84SJQfIHvecKBJ+Jtye6BWRfVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985862; c=relaxed/simple;
	bh=9nJ4RWVS4xD358qxJqQ8mIalRRMghPwYWOD3PcvvDzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6DCYp09DQYwAr05JE0OaeiHK9AKyxmCSGCpLP0H1BC12Dm9vpyjU7vXfVebg0cw/3/Sz5I+U1KvuEv7FMi8XmABfnMNvoH3gqy7zZdwOVilHdkHqszflihB4uBdFvOY6ksgyhgez68pyE1pljcOAn5RP23hfhjvqwaLLvEUT3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SU58JKpZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P4TAIKDU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SU58JKpZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4TAIKDU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6624i9d93590859
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 09:51:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=; b=SU58JKpZQ1TjwFrn
	4MSRJTjLcePUGT6AUoeKIzdQrUEvnAJXDd7F3ryH+xEBPSxxRPpA0xtXsSrYsJNX
	4n21fNyCVtfmpUzZVNZsJHqY7O2d7BB085k14JZQkNH74+P5dubFlYJBBVQgmbda
	VYl50ymI6+a061XPPp7VVcWyN3LW4KUPs0aPCl5f2G28WiLdSvs0pI68kpCllgGd
	hK8Wa6Azb/v8gxN8+QZGWZ/k4rWfsGRi1+0rh/qMUpVNVZxOohs82UWkaxKHi1k9
	1GZbW9p/DxJzw7FwyokH8HwU6iNC/6sb11kZM3dAtXAS5q1EbW8NmeU9ZlujX9RF
	AvRKaQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5h7n94h4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 09:51:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84240683a82so464799b3a.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 02:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782985860; x=1783590660; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=;
        b=P4TAIKDU6wwojf5cQ3AoqAZYNm/zFU4rawhykzLBgxElve5yARnHdj6ID0QSVeLqBx
         HDrefc4bD7K9LNGmSrTDqykWADEpwADwcoyoMgI6xfVFQyK/K1Us/40MB2CCF0vakeSj
         U8ZULWuONkgL51TC9EpOwXRTDXTJp8/Abg9FhIF9gcspxHOVxwfFGi39nVg8fhXX8NaL
         eu0fohNc0dx+po78m692Tk5v6s+W2ViIC8ivKgfIWURGfUEZMRb0bJhckh/LZqWpEYVw
         xTi+6XNXMqwsVO2rqJ6AITC6wWik+huTjYgA/W+c1S+KB9JIuhNnOfJibvFeC7fgipmN
         VlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782985860; x=1783590660;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vFBCjbnFRk9zVeIvP3tFUd0Va5w1MdMedUCwfWkE64s=;
        b=jRonHctxhrXaEZvobomZD8Nm8mq8CIuGbC3Mxi+vMgBYPMq9f1yV3f4aP7aGz+GyTs
         LsBdGUz1xNppsvEhSGutZWpXdxAd/ZpXbbR2DnKOt3WmSd6ANG9IaIvm7j72JFee5A0R
         AAl9yGIosNp/rDqDDKPwAkeDyAmu5qTcwng9c0CvtVN462uGlO3ObTFRrkI6lQ5u0zey
         8gavvyRd8KN5bw/8wPm7B2UO66ie5H5U/cZHmcQzQWe/eAlwmTTW0l5TYnILu+j8DI+5
         1UVlQLz3uo/Z4hWiztWqDa9V7XdxpwlAkmNtelce5WI7G9dMNQhKvonRg9zjCTcq7d64
         emNA==
X-Forwarded-Encrypted: i=1; AHgh+RoGa30m3WhgjTPW+llMO0PaEu4F+B7Q7hExM7d/8pfmZlMyhDyGmqyG0WQxqbz2bSYx5J0PYHCiVw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJL6UYCCMxmxryFgZTsNf6E1S/iHYCADeKg0SfjuZP1p/HW+aQ
	E33gGnkNBX2gmq52qcQtPSy1/hBN0x2vpcBrj814V8BYlgcYq/yN6MCTVTFLdw52ocveyH9KRuZ
	OHD/+gHZFGkN4OkmhQGGpOmFhqkLzW+jhTUYwC0d19UYeFEDY1Hw9cr/ODNQziQ==
X-Gm-Gg: AfdE7cn964BlJ+AeoH/SXy9gGD3E1EV6KPE4m3pYoCOHnlhIZzKs4PDjEMhbfUH2e6E
	m1RxLKbQZDjUgH/61c0tBqHTAcRkchLh0MXwf9PVccAp6mhm37SWAEyDSEXDRhba/mBjNYXV6Az
	wbJGfUFFbW5mQSxqq0c1aaap0H19K334wvEKcXLE4H/9jpkNhADwRoGWflCs6Fo/SJQdabp7sSj
	dwXiiNJGx5KMGX35XAJXhQrq39U0rZ1Uu6fTORguT9i+qVOM1yEH89ELB1aUZ90z8kCjNLYCNh0
	lN8Mf7jp5c2BLi9h3q/yiPMGhg9XZN6jLmG6XfEbfbMT6GweRLtQRGxiV/QIy8deIQ2nC2op/gS
	S/POylyUWc6Vv1R1DXn+4X+hQ2w==
X-Received: by 2002:a05:6a00:2e18:b0:847:8704:1c57 with SMTP id d2e1a72fcca58-847bfaa89aemr4615527b3a.31.1782985859789;
        Thu, 02 Jul 2026 02:50:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e18:b0:847:8704:1c57 with SMTP id d2e1a72fcca58-847bfaa89aemr4615487b3a.31.1782985859351;
        Thu, 02 Jul 2026 02:50:59 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847cb78ee2esm1110051b3a.24.2026.07.02.02.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 02:50:59 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Thu, 02 Jul 2026 15:20:43 +0530
Subject: [PATCH v5 01/11] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-shikra-dt-m1-v5-1-f911ac92720c@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
In-Reply-To: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782985846; l=1132;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Ie2wM60+tAThpQPFlruvov7NzPvO75/SEoFhbJfHGt4=;
 b=ZIP1YiQcXGJE7g4pWoGmEXtb3ewqdC70YHVWz4xY5O6bKf8/cGA0aXgvVCmfw/GSOvWdwZmDR
 qnvxbdh6KvUBh6CgpQnPLnXZMjWULORJiFdySKPDwY1W465wv0Hyjhv
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfX8qJyFs4Es7vO
 2EzDnxSkkkksK+EZhy+Sp/q5ubNHyQZy2mpOer1Lsm0eSw4vnWsv7Wt8FrSclzDCVJe5CUMXr8g
 rGYp3w3gPajq7MGaYIPtQGSlFDrnZiNoJzn6rlhjAgwmr27/U36DJedOLsW4IrY+ZaXjaCY+hHt
 FMmOvP5ClTTdaow04Z9iJrIIh72HOs1ejNZcpf9J5cHMYttYWF0UcL6ncCYB3WmbI+J32D5OCvf
 iWbWfIf1Bcy8sImls3CFodH18pCXJkdD3tImcVldSdGEygkHzLsx+E9y/sTnS1/glw72oIeoNGs
 QVdjS4j+E656l/vn98Tg53pw5BbiSdqd3Vw3vJQZ00s5ar6yNsRVMDGhxMFk9xpqxH1S6IEnIcx
 nIlL5lB/aMb+RdUogBv2UmVfO4hZVMp5y+NRuZ5J+HfI3CbhLLYIGxptAN3uY7HEuoUiTKqXSfX
 PBE4SasTKeXQhtar/aw==
X-Proofpoint-ORIG-GUID: 9atEhPyUmcQlO6JOnZiBOptbYRu8css4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEwMSBTYWx0ZWRfXzHtVVcM/oNv5
 iJZ4RTrAYCq1T+1eYoXYbdO/lyoSpqTZKtZ/FdsIb22Nxd6jeDZgNnVK07eGbuaAUKaeg9CP+ZS
 zb304grNgcjcMco9hPykR5554G8npeo=
X-Proofpoint-GUID: 9atEhPyUmcQlO6JOnZiBOptbYRu8css4
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a463484 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=s2Q_muabT7T23weRVv8A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020101

From: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>

Add the Qualcomm Shikra SoC compatible string for the CPU-to-DDR
bandwidth monitor. Shikra has a BWMONv5 for CPU.

Signed-off-by: Sayantan Chakraborty <sayantan.chakraborty@oss.qualcomm.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
index ff64225e8281..8f6c937e44ce 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8998-bwmon.yaml
@@ -52,6 +52,7 @@ properties:
               - qcom,sa8775p-llcc-bwmon
               - qcom,sc7180-llcc-bwmon
               - qcom,sc8280xp-llcc-bwmon
+              - qcom,shikra-cpu-bwmon
               - qcom,sm6350-cpu-bwmon
               - qcom,sm8250-llcc-bwmon
               - qcom,sm8550-llcc-bwmon

-- 
2.34.1

