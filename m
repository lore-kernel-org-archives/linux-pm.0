Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FB535677E
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971437; cv=none; b=F0ye5rBxv7fXn33iIA+5IX42P4MfG2u2++RAi1VGwVm4CxaVCP1TQs9gKSS35y8G67+Q6YM+qUHncT9cKGJbaWes/E++9nNDy/O/XhgdCVgnFcuZf7LfgTT10Ox3AvHae+OMCFExQ/PLWUIk5KyhvZ5Vh0OXEPOLWrypuXTzMhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971437; c=relaxed/simple;
	bh=7PXb6tONCWiJcT15/yOyr3WnjDDS6peuFjileV+wB2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJe17bzaORvnQjHGRqSuBOT8VPhgAchHjZdFBgTPvoBpXbDGZOxDC7JySnTZROj/eADEJc/hvzCGENWbq95nCsVZJh9FZPdBVSPigRnAidZQ9HDoVmXkZlc3vNQPMDHlTmu3rl9U0ImRL/9/4FLEhUgkvHQeF1jdzBFXKVNIqbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EJSZ1r/A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jlWbMlrA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EJSZ1r/A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jlWbMlrA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ9dpK2460913
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XvecEd/wRZ6RX60LThPvAmUEWLJBuucyCsoY96VS+rI=; b=EJSZ1r/AesPK4O8p
	VJY96MT8i2e/b0Ym2cjWZM4+j5esJ/P/CqoJ/wbDW6tyEKlFJh4xJgVjvrqvrV2m
	rC0F7jRwjF2bxA8CZ/W2H1psiPThlIoSN5X6/pk5//behP4/w0yUQYihTRPFx8tY
	huGnJAScCfw+ck58tuDlPjbxbKrOconGK9tgAy8RxgINKywHAhpSwcNhsmKhQEOd
	i7b13SNPCymgdQL5E4oIME7NxGj2Gj47oy+GlwD1oq0pYIq0rtHP89VW1AZyFQGT
	McZLOFzjkyYNsNBHUdwfvbu6zuDN92fpdkmHbp6RlPrABn2G2N8WkiS5lPzHAR3E
	ohTAGg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda2cg1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:14 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3810960140eso3751940a91.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971434; x=1784576234; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XvecEd/wRZ6RX60LThPvAmUEWLJBuucyCsoY96VS+rI=;
        b=jlWbMlrA0Akqa5L3P6jp64op++9af5kRcMwZarXgopa01ujfVI/j3G3ljI7z0vGm36
         epccUdWq1J/2O8eLYGZiuwOJgoKpeNWArSjNwarhFfmetpLQCJuXSILgrOetW1l/RMQd
         vhvP8BX5T//qBoifa7X3UPKV99tb8+bsLPKkZwzAep0UMU10eJgemmA7WAx7sQnbT1q4
         NQftk7x9gdDfcPb4O3sppqkrnJF7NA+KRrDAvn7VJmbZC43hvOrleyHwcBP8OIxtvjLu
         lPpsUxjcRgOwEwHJ0YdApZWKARhR8OSYE6JpAhhAVppvGHriWWa3oc4zUXB9fwya7PJn
         1sbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971434; x=1784576234;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XvecEd/wRZ6RX60LThPvAmUEWLJBuucyCsoY96VS+rI=;
        b=q8wFIzy6+m6C24Kuoof7jBtx3CHBOVVWNGJxBpf5Ch106LoVWgGdrAgau5vXm1TQ5a
         fQUvybMoOPrDebFVxxtCE/nfPeYOYaxF0nnlAv9tuvP3yWo9iV0rJ/lJ3zFTavek7gy1
         HgRr6yPCS2p0sDQVNc3wrYa0MnLOttAchnmsE+JlrfEHgriQKCV2v9y3l4prM23XcDQ3
         J9dtjU2bee55n1nm3w+J23vRSe3t+I8bs7V7F6mqD2xamj9FHR6zjq5MLVN6J4jZ1B+6
         UfDt/Q97RdaUmCmuYzFB7KKc764jz1jHdMC9DBSQo6FcZ9MQnxVmHmZdpASqCZ6jOxgi
         t0xA==
X-Forwarded-Encrypted: i=1; AHgh+Rp8uA3COctagVEfLb1quSQtJZU2PkWWKvjawzGw1DbDCskejweXSuDTI/FCbDgsLN93S2rGCHPu9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUgZcXM0P0cOsK23f532cWEsRK0Tu8YIz9RZA4dUS8NQRzV92s
	9d8Qpqo+ThICKcUo50SoAui3xkDkkNYhLhRzmK117s5ktDsJDU4rboVYqUOFGrMOz3xQ4HVVJ+n
	07ODQp0nkxf1O7/OyOLHWoEuegHPhoY3RO5GGgPsv1s8ByVhQLLc0ixP4fNVldw==
X-Gm-Gg: AfdE7ckpSIp0jTWpIbRAwYMQvQfg059ebpJU1MQnwpfGftPUlT6UCK81YYk+UQ4K/HJ
	JF8ELjKglPiQlBsTb6ePD3Mm1Wky8JmGTSe0jfa4W2O2MRI7+Qb1/cijE50VLUP4fADgZx9c8Z2
	S2UB0i9yndguBtinn3zO5O4qWpqwXrA9MOUL0871OyUhrbkljPc218UMwPHzhIdcYqa7MaULT1L
	6ECnRSrCfBmjd3RQl47LbHCQD0928a70RaWC1/XIz5ROiuP/KGurKD9vfkSW7Lanx5Q/qaDtXXn
	zIhFkG+lgytNclZD2LRAI1eEL/UyQ5lohIdS7VuPASWWormID3Zj0Zjw6VCfC9AqIOI5xY2lfOt
	FZ9znuOXMRYqvHyXOdmhtHKpcWA==
X-Received: by 2002:a17:90b:3911:b0:37f:9cdf:f0b1 with SMTP id 98e67ed59e1d1-38e17e859aamr339878a91.32.1783971433946;
        Mon, 13 Jul 2026 12:37:13 -0700 (PDT)
X-Received: by 2002:a17:90b:3911:b0:37f:9cdf:f0b1 with SMTP id 98e67ed59e1d1-38e17e859aamr339864a91.32.1783971433488;
        Mon, 13 Jul 2026 12:37:13 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:13 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:50 +0530
Subject: [PATCH v6 01/11] dt-bindings: interconnect: qcom-bwmon: Add Shikra
 cpu-bwmon compatible
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-1-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=1132;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=Uv6ZvEASOaSSEeDU/bFl4MtSdU2PqpdvHwxUksopvic=;
 b=yrHF/i37zl1zmdrt3gs9W1sLUEm408c6jGIwoKDK6OzwLsIe01Vofd75p4l3joycXpAFUNsTI
 F9MV/qV2ySBAMDG7uOw765odE4zaf8YB3PwAfZy5FB6VHe0+UYgWP+t
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX5AXwcPrl36Ic
 Cww5138DjE6xZlcBzSUVKqVMTCK4nW0U4KBz24krCU1lllgmQOO1Acf4dr06llsfVNeigvIkeWF
 FjrPfyFVcNgccF9lLVI7EjSmjBkkOd4=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a553e6a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=xRFGNxSSmkLZXw3MVBAA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: iEi_Vkxcyh-qpA39S1UYKn7zWzdc_ivN
X-Proofpoint-ORIG-GUID: iEi_Vkxcyh-qpA39S1UYKn7zWzdc_ivN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX2e+hfUVkzXkc
 m24Tt2acZvwYrU/nAY8pdJDiYLkZL1kYRaNMOrtgjN1MxaNKHqiCORT2SAFYCjeduEjFBI6AN+3
 afrwcafxD9l4nF5WGxH/p0/KJLigoShjxFV0ppAi8CjXpWfm6YKMNcLdDDWvpxlNgZPpArL4zYj
 LB2HxizqkuXt31SBX/IxG3v9UliYVxFvJSawLxxFobMCwuWzI+wA2WFQdqwlZL3K6pS1GVHfyMH
 9/vN017FEvveFQvjaOVnAOJULYFIy0kIFHP0CjL5eCuiQSBgXEtEW8qWyKjbjRLTRXnbPBXRocr
 IwIrDHfvmK2zQ1Yvn0/DxwFU8A0xYtTLfYKmR64Cl/DX6CxcsTHG7HDFE+CMTJsLl54ZSez3l3o
 CbJL5wCSOcy/vD3R3y4RvS1SeFpi7IA3st1JbDYDerV6r9RTh3XXTB/ta/asDSJrOjnzUWsV+ms
 l1QAECX8VtloXZCfxZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130202

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
index e002e70580f9..7474193c59cd 100644
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

