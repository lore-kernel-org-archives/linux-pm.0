Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCAC32BF4B
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971640; cv=none; b=hJ9wfNXA9JwAc3jyy5g2AOuASzWo3DIb+CbHJme8fEJPVJyKaD5dXIH3F7RdOHC8RqOaaqrCMzf0YSiTGaX5UFTUs6F4XyDs8KLQBsO+239WOIdS3KtpMatsfJ0pes0jP1WmQk1/iO7D5/IhLQPFXhNc6oEMwwgAn4IO40r3R9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971640; c=relaxed/simple;
	bh=NHRsT6JNMGdlVVEykow6bHQhy0Ht4gerx/Zd8NvExMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XD4EPm59Ih1eOf+Ic3pSHVo8dJNC01XKBFsga4mTR+o9xCfw+fKAf9UifsGhiFw/qGg9NhKjw2DDAgQkBpqSY5b/MTvyTZvFFK/15OiSipeX0XDhrIPEYPHWj4sZGSGdYeWG0YFPeG18SLWlfMN+bYWDBDsRu9xhZUT8xrHxDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZwkbqODr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YvqQF5nx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZwkbqODr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YvqQF5nx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L3ZEFI290845
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nbMGMuHirphbE6O5+vqfS6c2itNd3oyQVocKAGOT5II=; b=ZwkbqODrvT160sDu
	06UclUEhAV14/M2M52IralsJ778rvTEKPMcjNhsBrlmGvB4/0NkC+dcMgNfvBEjS
	v+ev5kVCYWuWpYfK0qAh7+7yzhOIPfvI8nco3+XwE4dQu9VV9NAiBCafH8E7jM6I
	BM7SVK3mX2iwDZucGTyzczmHd2upCLV9qq/VFMcSMgGh4u1Uly6D71o3JbeAr/3S
	BAoXpzMGLA5h1JtVGS4emilt8+zcQxM5RBzrPx6dL4wOoOKMRVFFG3JTLfeBJsUi
	Wh/JBgP9p3x95K+B4ykoL2gE8H/OmAFvL6AoNJ6wdaXHtizUOLw/f1wtHxYnmQr+
	E5KusQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gsjfun012-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 06:20:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39e3dad7ab3so3688389a91.2
        for <linux-pm@vger.kernel.org>; Sun, 20 Sep 2026 23:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789971636; x=1790576436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nbMGMuHirphbE6O5+vqfS6c2itNd3oyQVocKAGOT5II=;
        b=YvqQF5nxBeSggwba2YeBGVZ6P8FzmlYPdVCElInAZ+Z4fQVdLDrX4Lz2pjTZERXfqe
         7yoKCVbwcNLNFUeaMvGPAjszkaIC2G95Nwx5ciLefqrViyfH8ym3LOwZ26DrJEd7BQYf
         ERiy5k3lVdfYR/3UQdJkQ2h9ouK/MgT/dwu7LKZy643wxts3uTHiVFXG6B+Y/jgc4Aw7
         s8P4tM45LVAGmmDqGXeHNstgF1ZQ32s+jysa9jwmh6/6hG4DSnlDQCVDtzzA4dFzmtS6
         AB69RH37L79A5aYrhuhG7/joWUI5ixc5sLYlpGpkqGac6VzkXZD8Tflojn2UPYUUMQWK
         cheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789971636; x=1790576436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nbMGMuHirphbE6O5+vqfS6c2itNd3oyQVocKAGOT5II=;
        b=Qq3qwIKi9oo670KfCFQ7aGwFWfVEMbjNEy4ikYzCqWxkNsv7o7aiVqOOAbrtNoxfbn
         9ZdDnUM+E9pvTdfHzCu0zjmGc54JMr73ss2mVktIhohGdv09jh5oHnTViwZpBRmHYWN4
         9r2SAeLXQdFFhVl7ACXBRKFM9kiyzQGj0FEvlxFOWjIWddMAWAFSGZDcPnFUdCV2W4Ei
         Bty0cO9nxwtZ/6hT9sWODx0cHp7S/SKS+PS+rjDvZysqQBZLFSK6wBuvEh5KglsSjXbr
         m+BK1yGtXhF3skiXKvY7TiweJUuR9iSzzkpknjGackiZGZF7KLll7zpXb95exoWNJpAL
         pc0Q==
X-Forwarded-Encrypted: i=1; AKwUvByBwdsonbCM6dx6AOWbHBob6bk54HiwFy8sgmyJDPQEYuc8lHWGkmjctVdfZbp/s7TRF/QlH2aqAQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kKROpribR8l/j8icB3lqK1S4Bf1C+/NXI5vBuAiPewGe7Ub2kQ
	gB2z7romfiMrdbU7rarEUJWQP8WT4a8jDP0vSaFCEDt3BiIlmSuQovzfKY+/Zia3ad4DaRFrEkG
	IiC6brPp87c28CBbVO+uX4S3ozd2ePrIg42yNN5s5sW/URo5mft5Q6KxHCG02cA==
X-Gm-Gg: AYBFou0d6CLhlFbQZHfH286y8/V6+wC/q4tmW5ENEIN9wXKf3ptFGriH/jkV8bxh5uF
	cTvMUJY1sVgDnmvu7tPPS7cKqHGZViyKvsJKe10vMx6urhxONDW5XP92hsOipnyQHSj9xzUAcBp
	aYj6DwfkDk1bPcdHqB/XcllITSqkktibvUAzToYe16qvqocbUJfNjoBCAIf0iHWM3iAR5Qlla5l
	9kIkocF7jisFk0IW8vSJGHNrnvLcI+a7jaiv8vtzXywHZmPz01bGmzxQa5usgUAyMlnzp9AXdrG
	NF6f3uY10f75aYqfD1e/fthA4eKlZcG4ZwoDhAGxqPKpT2WUaquZmfIuBMgwKGvQGut5OnYGXLi
	R50ZHvHtDyjITGmJtEKQns0j4AoHe/EwyyEXPo4FrDHZ04B2yn4QZ7fpa1V0xrkuDEoeilWE537
	wTBGbvHuY45WQ6vKRI/Xg5RDgn3bJnPjTFGw==
X-Received: by 2002:a17:90b:384d:b0:39e:6c6a:2092 with SMTP id 98e67ed59e1d1-39e6c6a2289mr7962857a91.51.1789971636359;
        Sun, 20 Sep 2026 23:20:36 -0700 (PDT)
X-Received: by 2002:a17:90b:384d:b0:39e:6c6a:2092 with SMTP id 98e67ed59e1d1-39e6c6a2289mr7962845a91.51.1789971635971;
        Sun, 20 Sep 2026 23:20:35 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c331d3f2csm14091444eec.28.2026.09.20.23.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 23:20:35 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 11:49:40 +0530
Subject: [PATCH 07/11] dt-bindings: qcom,ipq5424: add NSS MEMNOC clock and
 ICC IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ipq_clk_changes-v1-7-d242e3d49648@oss.qualcomm.com>
References: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
In-Reply-To: <20260921-ipq_clk_changes-v1-0-d242e3d49648@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Varadarajan Narayanan <quic_varada@quicinc.com>,
        Dmitry Baryshkov <lumag@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>,
        Sricharan Ramabadhran <quic_srichara@quicinc.com>,
        Kathiravan T <quic_kathirav@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfXwkWYACniQ2Y6
 Td68Rr3cAxxqhPlR697ER5uXrK2c0Uy3fr6UDQLKY1esaM4cMCCR1G9B5hzYrX4N+xqk2NtNvHm
 inrgOwCEze/bfef8x6cEK59qRLsl5CY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDA4OSBTYWx0ZWRfX46Cqm0TRO6Ms
 3zLJSvCkSUWbMl9UywHyKmmw04+XkMT9y5wm+/TJrkDG34Y3NBgNjyfuG0/o/SWwcy7GFXqByuw
 xG5Ee3Lco67VxLK51egvSukprHfj+SN/g+/FSJw8sy/l/ocvowQ9+Xpj5dDddCrJJW8udh427w6
 gupBYPLwMZLFhCcDgHkwc0ZR3ICsI5hW1UjSUXAyaCzJ7acpjTNnDSPKfCqORosWfLbYbJVU+/c
 PUoP01Y7N1CDLtr5vcUfDsLTxD4RWj3F7UBlo0wdHWFCX4U7EjYVA5enKi0YP8Z5jOfIgE3X3Xd
 veXgYiyrLYP+wOP7cMaFSgwaDnSe8U+b5H5MVx21TVhVETuRTCSar8eOVHYx96YHkJ7+M2rgl//
 8lHJpaZ30wPmHT5XbzQTFXSZDZhdkaXTs1ZCx1hDqNtadKl/6gHz6rrIM2YhrDFthBrYSK614me
 em5eneLlcdXxNWHKVZQ==
X-Proofpoint-ORIG-GUID: OQnT9EBfL_WAMPLIKJHoo0DiHKfpZNpr
X-Proofpoint-GUID: OQnT9EBfL_WAMPLIKJHoo0DiHKfpZNpr
X-Authority-Analysis: v=2.4 cv=QKv91QLL c=1 sm=1 tr=0 ts=6ab0ccb5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Y6j223gtehf2z1fR5tgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210089

Add clock IDs for gcc_nssnoc_memnoc_clk and
gcc_nssnoc_memnoc_1_clk, which provide the NSSNOC-to-GEMNOC path
required by the NSS block.

As these clocks are exposed through the interconnect framework, add the
corresponding ICC IDs as well.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 include/dt-bindings/clock/qcom,ipq5424-gcc.h    | 4 ++++
 include/dt-bindings/interconnect/qcom,ipq5424.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,ipq5424-gcc.h b/include/dt-bindings/clock/qcom,ipq5424-gcc.h
index 3ae33a0fa002..b736cf42e9f2 100644
--- a/include/dt-bindings/clock/qcom,ipq5424-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5424-gcc.h
@@ -153,5 +153,9 @@
 #define GCC_IM_SLEEP_CLK			144
 #define GCC_XO_CLK				145
 #define GPLL0_OUT_AUX				146
+#define GCC_NSSNOC_MEMNOC_BFDCD_CLK_SRC		147
+#define GCC_NSSNOC_MEMNOC_DIV_CLK_SRC		148
+#define GCC_NSSNOC_MEMNOC_CLK			149
+#define GCC_NSSNOC_MEMNOC_1_CLK			150
 
 #endif
diff --git a/include/dt-bindings/interconnect/qcom,ipq5424.h b/include/dt-bindings/interconnect/qcom,ipq5424.h
index 07b786bee7d6..50b883b16a12 100644
--- a/include/dt-bindings/interconnect/qcom,ipq5424.h
+++ b/include/dt-bindings/interconnect/qcom,ipq5424.h
@@ -40,6 +40,10 @@
 #define SLAVE_CNOC_LPASS_CFG		35
 #define MASTER_SNOC_LPASS		36
 #define SLAVE_SNOC_LPASS		37
+#define MASTER_NSSNOC_MEMNOC		38
+#define SLAVE_NSSNOC_MEMNOC		39
+#define MASTER_NSSNOC_MEMNOC_1		40
+#define SLAVE_NSSNOC_MEMNOC_1		41
 
 #define MASTER_CPU			0
 #define SLAVE_L3			1

-- 
2.34.1

