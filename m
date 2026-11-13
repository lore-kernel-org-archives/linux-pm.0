Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559480;
	b=ctqgSCBxdYLFNFflEOCqEJDqlyC8Nbw3BFUpExoVS/4VIYuL/slb0/z8NheUNCkl77Sc
	 VUsLqD7ugavxX691l5PBT2cakcUS35K3PzD413sbyXHAMSdI+EOlFpslLUMnSG+Sh2v1K
	 cWsW7mcaiUvs53M37tyFkyAhlhSvnD1RwMfFvIMxtWASBOp+vbL13V8HzSDvzhs76M8Pp
	 V95kV9tx5+hAJkXIzW+zbtxaHAZLP7359y8LbHW1LrCHYpAuBqo+kEbcyAzkAyT3+9D1I
	 nKKM8Eq1DGrhViJBJzHbl75lWvaA3Llt8H1O+RhhnuqGpYTHkMEarnAIOHGxDM4j2IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559480;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=BIrMTfyIonOmY1GNvBcsxJZZMZU4zQSdH0XcMZTdSWQ=;
	b=AnlUq0HGMQlu6AMYwinBmNKlcp4DzdDkrDJ7CWD5jrqoz/6eO9GNTjpLCyoze174kmTD
	 hZrcDx1a5PZeOn3y2xbnoEbWyxY0bsHFsX/WMj/zKqASEhttrLcYRVOiaCY/9OpAS0/e5
	 uAGOq7T4Tfpq/pJSvM1VqlEsS3VI5kfRjzl6qUelgxd0XRXT6oDP90B6fnufPrcy2z+jq
	 1Tymhy4n2IjaMz4+XCftcaMu0APcPZC1yYqcMfY/rmZx8Y+tydcSSExm1UZcZWl2n9Y/c
	 fdoRSV3ogDroCXfxKE0YrFh+0aGhDpupyW9XX7Xzuk8mluxNnRqazbHhBAB9XrYvSAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RWIx79Qb;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iwN8MxQ2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7612B606A330
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7612B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RWIx79Qb;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iwN8MxQ2
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AD8V1Er4101634
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BIrMTfyIonOmY1GNvBcsxJZZMZU4zQSdH0XcMZTdSWQ=; b=RWIx79Qb43YpODZN
	UrDLH1rjSOQSUi32mYZnnjk+SsakssXggJllrthJ63skr1a/VT87pxwJAJsDU9rJ
	kfGPzeXBXlk4EN706NzCI7yBOFYn9qzCW20WjNevdF1V2fkX3Jkcpe30tSBffXnK
	av8xSNTJG5xfzV8zuD4GOP2V6x8eCB1xEKdCE/zWC8U3SKXcU6DT/YAPyARnOB4T
	VwEzjqyVulbtUSze+9WUQqebcHrTd909jbld2fOTRz08Y1tRkG4K0aDLJS0VGAtW
	P6dPjB4/CZct+tJ1/qMQUxutM5agPi3StylX7OOgpDZBbqIUdcGPqv77i8Zt/xoE
	KwRQ4g==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkfdjd2g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 08:44:39 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-37549877380so978422eec.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 00:44:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794559479; x=1795164279; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BIrMTfyIonOmY1GNvBcsxJZZMZU4zQSdH0XcMZTdSWQ=;
        b=iwN8MxQ2nacxBJdnAKNmF+qjSyInIwnHoOk4BS1w2/0xBqOe/ig64jx8UTItnG+xBl
         +tBGE3SQmhVobLUWsdXYTyZRO4xppDjLY/e5mcmRSSC6e02i1JhPM7g0R1spLiTjjr5X
         P9gobvE9M0kpdgO9KjCfEPJ9Slxo6FYkzaqQ/sI23S4H/IicYIX3LROsk+VS9b6k4jOa
         DRKceva9GBXmn2bS8VjW31TFpz/VSCbUAtfhHfw+j1ps1D5GhNSE33VkTLHBuMT9Xcao
         J6JMG9LsDqSc6CreG/WbReXO2FZtZ2treeL+yENT6AqGLuYk05LchIysZmfAjR4ARsf/
         3I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559479; x=1795164279;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BIrMTfyIonOmY1GNvBcsxJZZMZU4zQSdH0XcMZTdSWQ=;
        b=iMxhHzgz2zLaGqL/5XT0g/CwVrIvfcuM6htzRMI1lP+yF4xA9aTMCDUZSHwwIQ+Na1
         /ZX3WMZyfFZi+NnPHzB0KJlz5ufniJD3X5MaWzRdopjYO/Db/B2nV/MhGMpfNRXbW0Mb
         2bGEHXOpK1OXAOdEVmm9njCTyn6su8fAS9v0ZStQKWSliApPfiTF4+5keFP/YZ/hDY1P
         /Oq1G8rIwMCTKaZJ5WvflX5609dXDNeOTp2ufN97P1FvWc9ylfN8SdPkUi89R1yxgJRa
         BavmrcNkXoqevlBVa5UXfWczcdoVF7Hh/Iw6il1qTrMLb4LBZFCUz1lY5UVAmqKRIVmY
         cFxg==
X-Gm-Message-State: APuU4Z/0i5K6PNmO7q33KgrE1r3FB1OAnZR4o0Y/S7DI5atRBmeIbT94
	0cLTrF33I5OURJ5476JnZNnZu5kb3GKLQXOF2wqmXtFy3uXaDzp0dOx8bBfBI6ha09AuxX+6Vzz
	vhDDB/A46FD1ODSidadLtNRvttcy7auZczLA8xHrz4tQrRngfL3c95yGlR+9yDg==
X-Gm-Gg: AYBFou12nGIvS83cs4KRWTI4EVX25N9CTvKO6gjAa8+Vhro/t6/UXRgr6EWUef2UhqC
	TM0TYLPJEjx5lO96djF6/37RJNMnNMl25bc6ihIGjSBzK6IJELzdZ5BgJ+1Jm+nXCCDVXPLM0iH
	K+Oe6iauZ8X5JZvETVEAcz3EAN2oMkwBSuX/7TS5vvQ3ziAFYc1/W3EMowlwdfPNkBNzd1VMUkF
	N4UtoArCScfDGRjv6/rjJX4brVl7vliS/pssUKSIen7t3w1ZPTreCLu2vp6xqK2ihm45pIFXXKs
	ZwedfbGw07o9/jyGRpC/h7zIOf/0osJ265BuGamPckOjxsxaCyS9BE6LFE9UVRlrZMGClfFq0uu
	+prh+UtyrpL7jSQi/Cyi7v27ciJdcL1/BlkfCUhkAobxHylWTDdTLgGLbkuoor6NPNTA+doesvI
	mEfmo=
X-Received: by 2002:a05:693c:8042:b0:36e:2b8b:a098 with SMTP id 5a478bee46e88-379684b6defmr1914363eec.31.1794559479168;
        Fri, 13 Nov 2026 00:44:39 -0800 (PST)
X-Received: by 2002:a05:693c:8042:b0:36e:2b8b:a098 with SMTP id 5a478bee46e88-379684b6defmr1914350eec.31.1794559478641;
        Fri, 13 Nov 2026 00:44:38 -0800 (PST)
Received: from hu-gkohli-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379563df84fsm9662357eec.20.2026.11.13.00.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:44:38 -0800 (PST)
From: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:13:46 +0530
Subject: [PATCH v3 3/6] dt-bindings: thermal: qcom-tsens: document qcm6490
 tsens
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
Message-Id: <20261113-thermal_bin-v3-3-878df6eef8bc@oss.qualcomm.com>
References: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
In-Reply-To: <20261113-thermal_bin-v3-0-878df6eef8bc@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794559450; l=1843;
 i=gaurav.kohli@oss.qualcomm.com; s=20260302; h=from:subject:message-id;
 bh=vwYmeuoZ5lHmVqk80h0qWG19XZnP39VU8XyF/LOm3ZI=;
 b=aeA7dvyrgX7CJFxmnzCADaVvcpgLvAr0AI7xRba8QE3wF0ZoOviqkPIDA4JfSv+d6Cg4VR9kD
 zLlm8CYXaUdBHj7wZgEROD0Gvk4uUyRquehwJ71pl/N8GmAhIHlkjNb
X-Developer-Key: i=gaurav.kohli@oss.qualcomm.com; a=ed25519;
 pk=IdNsqe8rWsF6dbpGHfwPEH9zM0nbOdRH72HxUT9qPak=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX7QPUPCkGHz4w
 BJzRJM++PotlFYphY7Ca36a3+DbF4zQGPcyqUhlFTbXH+ESJQeimeHK+zsmQNYYu3pRmnS5n8G2
 98MZNIdTAI7dTT5cvnLSl3fx2yOUHd4=
X-Proofpoint-ORIG-GUID: giiDhloIDtvcxpWKKf3PHnd3YjkBoKQQ
X-Authority-Analysis: v=2.4 cv=DoTDa2/+ c=1 sm=1 tr=0 ts=6af6cdf7 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VzBDfsQTI6wPN1YFWBEA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDAzNCBTYWx0ZWRfX4tjJRZqk0Le0
 y3+brWLj11lgT+g1WpwGXW3boleV8Xg7gzUQiVmY6+VenrX6hH2422rQdybeqnKModKcO3dJC9y
 LmPmm86rTjqyXFvR/2ddPX2Lo8gl6fDjCmzwCgJg9WUSrHPufpfy52uQhLIQT/8HSIJH6fmHAgz
 kNuQ8sYIvHD4s1ecm8r6arlJ82wJj/wDURIJFPx7HINIMpPuwtIJSuqQZQ719RJuMrObYjflkOS
 gZDJdxfdM52JlRSH82jUoWpYJac7x+pZZHz0XAVV/5N7EeWrEgNlFdrk3qH3hycQDp1bIcPTNpM
 9jxsZUmJcWquipEopXeIXJjIIqIiNtvaR92OS6eDY2i98GDtU1SWgUa3+PZe8+GdYnxC+pqcjB7
 tL8IAY+hllI7mPUqIgP7KNhMTFdntu2mrxHwTRzY00u0oFrWTAEO0yYDA0uQHR7bYPKYGjZRDym
 unzriI9/I5arxFnoxOg==
X-Proofpoint-GUID: giiDhloIDtvcxpWKKf3PHnd3YjkBoKQQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130034

From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>

QCM6490 uses a tsens-v2 IP block and supports hardware-binned critical
trip points. Add its compatible to the tsens-v2 enum.

SoCs that support hardware-bin critical trips read their manufacturing
bin from qfprom fuse cells rather than the usual calibration cells: a
single "i-temp" bit on hamoa/purwa-class parts, and a "jtag-id"/
"feat-id" pair on sc7280/qcm6490. Extend nvmem-cell-names with two
oneOf branches so these fuse-cell names validate.

Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index c78074fbcecf..e72d6b8b657b 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -66,6 +66,7 @@ properties:
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
               - qcom,qcm2290-tsens
+              - qcom,qcm6490-tsens
               - qcom,qcs8300-tsens
               - qcom,qcs615-tsens
               - qcom,sa8255p-tsens
@@ -245,6 +246,13 @@ properties:
           - pattern: '^tsens_sens[0-9]+_off$'
           - pattern: '^tsens_sens[0-9]+_off$'
           - pattern: '^tsens_sens[0-9]+_off$'
+        # hardware-binning fuse cells: a single i-temp bit
+      - items:
+          - const: i-temp
+        # hardware-binning fuse cells: jtag-id and feature-id
+      - items:
+          - const: jtag-id
+          - const: feat-id
 
   "#qcom,sensors":
     description:

-- 
2.34.1

