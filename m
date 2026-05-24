Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBC530B521
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779645828; cv=none; b=jsi0ckqeWQRO5dW8SNuc4dYHlco0uYOLbn1n53nZpJF4QkEf4lN3CdCBOiVzBLrpUngvURdssNOj8YR9YbtAIuFHS/OYWBr7KTbqDKuikr/0mAotFXi4f7cZ659hmRleQHYq/wU3mErdC9hZ+eaPtnqEf7eHc3j2KX9XajsamZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779645828; c=relaxed/simple;
	bh=lPQjOebK0gB5D6eZ9BckZJv2E8FJic0pghKbDN+Wwig=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CXdLmzM4SjjuLJu8Ffl/c7BCtjMKIwl3id4goU3gs1ansY93Eg6KpmHjpPiDJA9QjmsUHdh4DkbL3litwdZ7W9ipZskWwZ7YgwVchOmgSnULTASAqHPIi383J8rM7FNMZ1xIh+cQPqg71+Dff90DtVF9yyEAtEXDo1fIELsvo0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UxlI4ccd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GzkEPaFV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxlI4ccd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GzkEPaFV"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OHeXh5217228
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:03:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0/PAng2Ozse+DKmiO0SrBcnJmRKiMxm4xteIGLoR4+g=; b=UxlI4ccdIq/EivAb
	qr0mFt74J3Zuz8mvj0o0xuimQ7uD9mYCVs7M5vAMQuG3o2UBVSUQBGa4ajtqx8lt
	XG/M0CvGr9lctzUAN4ctiS9ySSYHZlBSDalkh5gL1HfLVO3mQ8zkPRjE+HINRBWm
	fM6KhkzbwoA9DElSR0371+IgLVNdWqxQMPEZR8pWoB0JpOfCQAFFSNIXw9BJ+cWx
	IzKYKzqvAMDJEGPU9KrM6WS+lhCOxWm/4ma6vsioh5avmHvOER7V5KR8cv/NtyQs
	WSLAprmuF9joOidbbLBWAQIrfzeOjrBifTxImp3xLZQx+A8iu80ASJyx7rHQYtgk
	UJEShw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4f3bqd5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 18:03:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-365ff2ab7beso9203870a91.1
        for <linux-pm@vger.kernel.org>; Sun, 24 May 2026 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779645826; x=1780250626; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/PAng2Ozse+DKmiO0SrBcnJmRKiMxm4xteIGLoR4+g=;
        b=GzkEPaFVrpApjzKZ8UdCCoJGyR7cG634YCUtOsUbVOJhFXDOg5QdadXOgd9B5nWsBz
         mfJfz9UAT2VKOxjv23xIfwtOAK7omSRSyNE+0KxdqRB3VJdHbA9shiomYHq7OKDLuJQp
         BppNj/e8TGMphNwEpwYvLQRzxBxOC4ywF5gYTDVf4afB/n8AHuXL5Qb+oN05AwR+CZzn
         UUcecsXFZCJ9D3Fbp7TinquwoeZKq1sHlGumaCJqIq8R8W+7P7WZVvaYvw14FVZxjNUV
         pXtoxy9bwkxLCfAB+I3HIG113UL+NNkAkp0A0PjStKfPjLRbtEbZ8Dz0zQPvJ0Nfiq18
         N94g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779645826; x=1780250626;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0/PAng2Ozse+DKmiO0SrBcnJmRKiMxm4xteIGLoR4+g=;
        b=byDjgmfPc7TO6hPkKq1RqaSvZJ5yisbClEI09iI1snDOyBdPVU1OKORSf0AiC+InH7
         cM+DskvDXBjulK7AEi7C64IwDHiLkVJW9ez7FZEGGj+IyxJSnsY8TfQwd8Um56Yz+e2O
         0g2vOkF+r5qX5KaXTxWO6KTq+e/Vs56Y7J3mahNzEG/uGi45KclePMHbSMedYs0qtixh
         Xs1BlXoYKToJH0gR/fPXQFdjhEb373w5SaaBiSi6Bm9z/dbqMjcicNuDRtEfWlztJ4JW
         6212rmjUcVfXcfveiZfVxdv47ClLIi+C1CbJlqWNCRMHIhDy5o77tOjgSwQv12j/5JJA
         JSkA==
X-Forwarded-Encrypted: i=1; AFNElJ+i9EdU9T7cheBSGPrQSvFac7vDY3Ed8y1r46XHV2RK5RSihN0/xlOvtD6s1tfZc2GU1RW1XZureg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYyN70tFhP2ky+EniJKMflTQA3FzlrEeAGqGxElCr2mgFOnon7
	AU7hQPUadyWrGBqbrtzicUVAQIeZdU54DsOPn682dt8qnZWIOgvQYviPAJ5XsGx3SV2CSRo9EGX
	OBT+XPkF2r7g0eSIGTN5El3PZ8TgWFiWNESs9/12RDIfK93qR0zemoxgWI6ZyuQ==
X-Gm-Gg: Acq92OGNctxXm6S7pyA9v720uhfWSn388GO89L1L0bznu4keaQxFXyermFkRoK7dX62
	b2GLcYf7qsl6rHgzB9J9s+a7DKrHEshuJyRripOlikxY2l8rpiiRlwwdAv7Zpxo6iaqmprRYABd
	FmFUSywmdyjTAycpBK5FMVgPheqcDR/dhPkMlEEDvKGIbUE0AOI9SmbM7GJo8ZPhkWc90khJWkD
	KQfCRgYgYSncLi4niDDFCJ3J51dkZ51raj5wChu6y1yF2xMCSZb81tT9SFBVrTKUHLj8Ww5ruN6
	zp9m3TyK6zzAjQJ4Tf8o4BAOeWHJUBeQIQBT4+qhWtbqF27YwucCbnlF/67ALxJidCygKTatWRy
	ebwhvR33UROK311DogPds1V8RryuyNC24U65whmfJ3D5t
X-Received: by 2002:a17:90b:560b:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-36a6bb5b91dmr8417810a91.5.1779645825710;
        Sun, 24 May 2026 11:03:45 -0700 (PDT)
X-Received: by 2002:a17:90b:560b:b0:35b:d795:cf5d with SMTP id 98e67ed59e1d1-36a6bb5b91dmr8417797a91.5.1779645825209;
        Sun, 24 May 2026 11:03:45 -0700 (PDT)
Received: from [169.254.0.3] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a726348e2sm7252659a91.2.2026.05.24.11.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 11:03:44 -0700 (PDT)
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Date: Sun, 24 May 2026 18:03:35 +0000
Subject: [PATCH 1/2] dt-bindings: interconnect: qcom,shikra-epss-l3: Add
 EPSS L3 DT binding
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-shikra_epss_l3-v1-1-b1528a436134@oss.qualcomm.com>
References: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
In-Reply-To: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Proofpoint-ORIG-GUID: rpV-Sk1k0WUCbBQXkoodUI2vNFoIe7a3
X-Authority-Analysis: v=2.4 cv=WvYb99fv c=1 sm=1 tr=0 ts=6a133d82 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=O0_WEpH8e0Iti_Y8aDwA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI0MDE4MSBTYWx0ZWRfXx6HtHlLXxy7v
 fge1RbmLv72I74GnijiAp3pYGoGdyGj5EX89FeOxlr5gKgsCHUET5Gm7/fFiq3A4I8Hjf3ZehC/
 LppUk19TSIwiGyVmkCJONARNp0qg0ojDzD7CdTy0WsaRBnFITHLqozzcgJCcKPlPQz7J6+21mlu
 W66yM4ZCxnOfI5gTngLZixtG5fktGG0YilmLSoN2ka7HKIkZfs3waBunNlxn/PHrjfWjukCVPbe
 sJe7wAlHE+Z33bd4W9K5laJii43gwBIjPJB4BQq4l9dnhUhg2kJWx2HnWOPzjafiC4XDBcKMdJa
 h/QerRMBvMwCM2Yw0UgC+jvCgxhQcc4FAR/swHj9fvo6UbpbcmgQ0PqLPYFy0yoolhiAMHDZz4Q
 VKAToNcIQftme/rJJGgj2aDfp2vhuA8fGa5WED1fAIWb0zD7eMSE1E/5EQltq00ULguQ0M2/kMR
 i7q2QGQH9/2E0sA316Q==
X-Proofpoint-GUID: rpV-Sk1k0WUCbBQXkoodUI2vNFoIe7a3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-24_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605240181

Document the EPSS L3 interconnect provider binding for Qualcomm
Shikra SoC.

The Shikra EPSS L3 block is similar to existing Qualcomm EPSS/OSM L3
providers, but supports only up to 12 frequency lookup table entries.
Introduce Shikra specific bindings to represent this constrained
EPSS variant.

Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
---
 .../bindings/interconnect/qcom,shikra-epss-l3.yaml | 60 ++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,shikra-epss-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,shikra-epss-l3.yaml
new file mode 100644
index 000000000000..333ed40ea8e9
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,shikra-epss-l3.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/qcom,shikra-epss-l3.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Epoch Subsystem (EPSS) L3 Shikra Interconnect Provider
+
+maintainers:
+  - Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
+
+description:
+  L3 cache bandwidth requirements on Qualcomm SoCs is serviced by the EPSS.
+  The EPSS L3 interconnect provider aggregates the L3 bandwidth requests
+  from CPU/GPU and relays it to the EPSS HW.
+
+  The Qualcomm Shikra SoC EPSS L3 supports up to twelve frequency lookup
+  table (LUT) entries.
+
+properties:
+  compatible:
+    enum:
+      - qcom,shikra-epss-l3
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: xo clock
+      - description: alternate clock
+
+  clock-names:
+    items:
+      - const: xo
+      - const: alternate
+
+  '#interconnect-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#interconnect-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    epss_l3: interconnect@fd90000 {
+      compatible = "qcom,shikra-epss-l3";
+      reg = <0xfd90000 0x1000>;
+
+      clocks = <&rpm_smd_xo_clk_src>, <&gpll0>;
+      clock-names = "xo", "alternate";
+
+      #interconnect-cells = <1>;
+    };

-- 
2.43.0

