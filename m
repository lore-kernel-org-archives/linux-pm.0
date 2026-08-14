Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AF9421230
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786692862; cv=none; b=DAIpVZJLOScVijBeWZKIstmpWFyv4DHnkHL2Lnb4a0G4bU60AIp5+JC/4dDbQh4HCE4bM9xwvHjIxiIZEVU0WRBBKv8JqUv/23AOfVuU+AVCWY6klaZrDDbVJJEvaTWAwRJNvsfr5D3wP73lJ6d1sNmY4ZpLat+RnnUYjht/IQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786692862; c=relaxed/simple;
	bh=n8GV6PoSXN4cpLFiEq+a5b/GV3P0P7iPA8E23y6lTkM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mcvopl3dr4z2xR0MWwdwpggd82kaBPoPHn7PmgJ0xvy4VeiTC09a+gTEfLo5+L9OQEdStV2usc89Rz/MB8N1SwjIoHYePGZLD+g3gUhUoSb07/q3KKvbXodmlpEMcRbXaao+rqKKn21c8Ie6jnFYR321ENFK4hJaQEs8SlMozhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iBM7qggQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J+ExaO0X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iBM7qggQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J+ExaO0X"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4QYGS669314
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GDi5NsGbxyIFciNY6O3JO4DjZ5N5Ti4JWxUyYD9feU4=; b=iBM7qggQJH6GlKGE
	RoyM7bsCwwIW23yScNYe/xWWIj/gDcu23CbE53thgM4y24K2Y+dUxq3fLUrIW4Ol
	2/B+94aXS/6ztYwEA1xXBQv20U/duE9iazZdH1i9d6MHg8qx6i07sAAovTFBYuqy
	FYA4zh+gVEYRd87S5KlMPMKQFBWPKKl/BJ7Ax7ibnBg3SGg3glA44SW7bD1bz7Hf
	MX/HKi09+wKRt5hOkcKQBN2k5xBVTJvdi4cH8NSpakoJfWL3N1jABYX/fTo9AaJw
	8xC6aGfi40IoR3JzMLCAzubsvVOj7rmEqU5re0neIn+UwI3oxjl7u417Yzq2VDM2
	cL3tVg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h1uuacx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 07:34:00 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d04908139bso11302155ad.2
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 00:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786692839; x=1787297639; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GDi5NsGbxyIFciNY6O3JO4DjZ5N5Ti4JWxUyYD9feU4=;
        b=J+ExaO0XR7HqT4WnggTZglBt/66LCaIkhOqj3DXDffSs6oZlga9bTsZQ47vhSaw2ng
         UzX2d8Vevtq5Sf/uf7m9ZSyNmnj1plPY7aAIkUxydWYRbHkbDuSP8Qh5SZLacca4wNkR
         ERelbQ6x/p0bsdP71RqX2TDGijP833zruYa+kbLacCuaEaob6pE9AaVWo5hc3kQQJOcA
         HWTRExkML8y8d91S3RRoCciObkhj5GLk4AZKnoK1pnJel4pGpCtODXTqbPZCzQW3wu1u
         ICcLnejO/lpKXz1vG0uJ6xhpzN/3IeQiSRRsg7xEkoFc/aZGPGspAnt528Dv7mx0zgnx
         eusQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786692839; x=1787297639;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GDi5NsGbxyIFciNY6O3JO4DjZ5N5Ti4JWxUyYD9feU4=;
        b=BHz3SyK4Tu55kJOeTxKH7cDXYv6gJJCrnpTCz23+F5/51eJkKRRcfOZQvbKLQAnmvK
         3xCgQgrI/kHWCuduuEtMTXvWjTCg/DovoKsa2LATrtcW7SLx4CqX5v9eVcLqWaq6OZQ4
         jP5/jkvbvcXCETrXmCilt26pUXZke2V0/43rK/g6PwxGkoLwTlnQbIP2lUnaGAnXsjI5
         BdXr6rs/+DGvupYMDvCWESXIZ81AW7rR7NbEhUhrzDh2PAQsav5umPOJg1IiXh1UCTuE
         Nofs5fh2EBnTtWqvFLzxU6p0OPeQhvdmO4GD1ZPi7Sn7nfd8pAFi9I1DKZ39znl9/kxX
         7Upw==
X-Forwarded-Encrypted: i=1; AHgh+RoMMqLSCD10NLZ2D9exSlbkVqVeilaLyS6ORJMxdZ3/6AJvE9aJVH9Ddqmq+xhEy/waZXPpOwJEEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsiE1dZ3JdJqmZabLtHIADAlh9PnCZESIGpSPJo7uMj5MDFLhb
	IFU/jikS3n8UAp7PhbIkYFwtadOZFtYA39YtFgD5HHhFykX/QXnlEyeQVBCnZgcQ/x2rS+B4fOp
	ZsdK3cg/Mhx85ghMW2A6dQ+e1BjRmA1QJVbPNC4Wj9T3df8MXRVtuUN8t5XxerQ==
X-Gm-Gg: AR+sD10Z7Tz6dzlyIXYuN4TsFSahdF4BAfNX4piaU/F23efk7sWEmeSLCcgkdtcStAD
	eor3Hj6OmMVipse87BhwlsLVUv//rvY7ypekUvxDN+3Y9O6Evikx89m/80sV5c8UgoElOa+NRxm
	IOcw63DkcHxJvmrHbLyLvnUriA7OXziVNofbU/OJ6/TeQHgv95RVWSg8rawMau/2hVkeFr9/ilq
	c+uwj1pGUStWtYUY+bTxg+kEdMyaaL90L9BvnuU/2i1r9DHLEsxgvBmzMV5ltW74IFSRdBBXhzl
	bW4B3iCmtGd3KvQp81bcG5Jsrf8x+N+qWPgiEpGS689GjCIPj526kcO4Bf1h5nQe6b9cfu4c9oO
	GOIFupwIXDY9c8KBmUqDzb3y+GW3b8arvpnJKwv8PKQz9wa53T5ykx0UI0GClIacGdex+O9pHXq
	9E7dP6Oo+PbAs4oEoU7pOZD6Y=
X-Received: by 2002:a17:90b:3fc8:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-3933b762b96mr4310493a91.7.1786692839054;
        Fri, 14 Aug 2026 00:33:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3fc8:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-3933b762b96mr4310435a91.7.1786692838641;
        Fri, 14 Aug 2026 00:33:58 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea804233sm1062280eec.26.2026.08.14.00.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 00:33:58 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 13:01:45 +0530
Subject: [PATCH v2 14/15] dt-bindings: arm: qcom: Document Kuno IDP board
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-kuno-soc-support-v2-14-3079794f0f73@oss.qualcomm.com>
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786692714; l=2175;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=n8GV6PoSXN4cpLFiEq+a5b/GV3P0P7iPA8E23y6lTkM=;
 b=JnS955wsV2fvtkKSqmnST9ZqJcRZDmy4o5dUDkkHBhJd8gneTdqyf4wNaxSCaWi7HMrU16dfE
 hm42/mwko9nDFSCzQaIXYjmVgEsBn0PKq4PItkLcZdtJhhYwrynoaWZ
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-GUID: WYOhFDthFbnUoNefFAiLK1PuZcX1QZDC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX/rD2ZEee4/r7
 TgxzcxPjfI6suOrY771Y6zPTF9lu433avRBUSPfQnhTYp7oFmbaGN4LJN9YaWR4fLc5Azm+iGSx
 r9cvD4eIkj3U/8aVN7KK0bRzXDax0PBw1D70R7C9FeC2E6FgbxOq7l8Z+Vq7jWUHMy3suinrIf0
 13mA7bjjOOudiSBE7Xepm5Y1Uwh5QFAB3RsdVuNTN7cPoL/6lAAKYn03nGdbxddmPB+k3sSBDxQ
 f4j49BzcHcCoQ4NKnewpgSN3aj/nVJSUlqNMHrtP4Ca4U6D3ETLo/iq/QevGTxDwY7rqHU634GM
 6XBP2syaWC5eIK058OD6zaYFUVY8Vvk26LOUZeLI6hqdzQfYBZ9krhK4PjdipGDZKYdx2o3eF7G
 UPXfqWOB7bb1TSJZ3D+hU6iP7Oza0Aypge6MNWQys1aH+R9QudBXciaRrT0wFjtp7eXkeMZZRL+
 bBQ+gnfbDxB/6GSvfkQ==
X-Proofpoint-ORIG-GUID: WYOhFDthFbnUoNefFAiLK1PuZcX1QZDC
X-Authority-Analysis: v=2.4 cv=HMjz0Itv c=1 sm=1 tr=0 ts=6a7ec4e8 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=vXfy1ps2I0IJequeNBIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA1OCBTYWx0ZWRfX5PR4F40hEcyY
 zWlR8/sAkH/OfzvlwaqxDN7lPX+1l22lc180CcWRYlR+g5miyjLt7vgTID8sK2O4mGQVKncKFW2
 L4MQ0LuMFa24KhSrXM8KLCiYd08E0aU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140058

Document the Qualcomm Kuno IDP board and register the "kuno"
codename in the SoC naming convention schema.

Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
 Documentation/devicetree/bindings/arm/qcom.yaml     | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
index e7160b63d814..179aadc86a9f 100644
--- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
@@ -30,7 +30,7 @@ select:
       contains:
         oneOf:
           - pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1[ep])[0-9]+.*$"
-          - pattern: "^qcom,.*(eliza|kaanapali|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
+          - pattern: "^qcom,.*(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra).*$"
   required:
     - compatible
 
@@ -42,7 +42,7 @@ properties:
         - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1[ep])[0-9]+(pro)?-.*$"
         - pattern: "^qcom,sar[0-9]+[a-z]?-.*$"
         - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
-        - pattern: "^qcom,(eliza|kaanapali|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
+        - pattern: "^qcom,(eliza|kaanapali|kuno|glymur|hawi|mahua|maili|milos|nord|shikra)-.+$"
 
         # Legacy namings - variations of existing patterns/compatibles are OK,
         # but do not add completely new entries to these:
diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index ff8a35df7862..ca02a2f0396f 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -175,6 +175,11 @@ properties:
               - qcom,kaanapali-qrd
           - const: qcom,kaanapali
 
+      - items:
+          - enum:
+              - qcom,kuno-idp
+          - const: qcom,kuno
+
       - items:
           - enum:
               - qcom,mahua-crd

-- 
2.43.0

