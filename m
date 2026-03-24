Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BEC7081A
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311076; cv=none; b=WMzGkT6Yi9bPu3v9GIpon0M5pO1q3iPqi5qST8SgenlXTI9SC8xRvmbLH4LIW4YPJCKFcU+dZeYkdsSHCeG81eTnmcpxivUktgyxg8a4xtdJtFE7vqE9eawq0cXOD/35pjpuilp82+RvBHnxKcCw0vuFfXc4G6FpiKibYZmjAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311076; c=relaxed/simple;
	bh=Sy6oJd+KnyyD9Vs4BTyOzyQv0pft+AOfiX1PY1GJ5ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jYqm5xVC4DXNcsMV55ceoe56y1wDmZ00aP2ol2cDUr6PLr8MveCNF3fTnc1TQAf2jk/yK8ianyz09Y1oMYSRheHZssT9/I5LydSPbxrdppEv2cktvGfy5UZjcbcYHHIECuqUZ5VILD7KzawjTQEcRWVS8Svz4CTAUgW2JniDQ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=krqEIf61; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FncjK4VG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="krqEIf61";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FncjK4VG"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqVN7943490
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V8hgelKstStZWzF6wWy9g8MQYVLkYeFx+q9MUtvosxg=; b=krqEIf61AAWJpPYK
	CUQSiNy8MHr1jvi9QO0nwhWS8IDmx6Txk0Ol+SNuILomF/bGOvXctBgW0PvzR4Lb
	dut4gs06FnksGEomNCpEn6hjgqlvuYIlDLmyOnuolzc8hy9M+6OEWqSjad1RrAEs
	hl8ntbVH7X1kTY4IfuZ3ZBilMjIzEGZOtob7JeG3IdY4zMPCTJ5WQ1cbi4vXpZjI
	vAVIaQPh9lHjldgMGgR6Ewpn4BSaP7AowWRDUC3DK/Hs4ewJ0FeN2hsmDUxRy7RW
	WtsFoSJn5P35xEU3d0Hh+ArO2XwL33qFVqIeB5yKewyRdczFNCygHrnKEKgpo1yX
	uUTsiQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vktc09-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50925fed647so47390781cf.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 17:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774311072; x=1774915872; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8hgelKstStZWzF6wWy9g8MQYVLkYeFx+q9MUtvosxg=;
        b=FncjK4VGX15iPtW0HhDxTOaMY6DpnXP/2YKj91UIy76SeYloJQZmjttlexDcY3f6L2
         N1aAWJEP3j42jj7pshoCZ0zUs6m6wyKgwxDz8ojzhx1S1J07gTF3sbaptPW5Y+yJ00OR
         A1gFGsw1fFpLZ8OXdK0FS9gjDQySPe9hLirpMHGKDAGE6i2MB6qQ6nnR4KjVGLmmLuw+
         yEXpBsLBITjh2354KA9st953JldBzjIhZ/mizfAoKAfkMrnVn0iPVEMKGEozz4NESAhO
         TOIahuZN6jEnpAPBNY33tk0OQcqS7w6qKjt+sr0B03bNt/wic+oisxp5Ler5ZtgMZZH3
         A72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774311072; x=1774915872;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V8hgelKstStZWzF6wWy9g8MQYVLkYeFx+q9MUtvosxg=;
        b=cLlLwinuvxsayX4SNEPiNX9I5PMat2hnL3+uobvl4yOGRFHFfaldM0bHXnGYRDosns
         E0s0ed0Qq/+7xIfWsod/A1S2G6Zur2+gpkKPX5mgjjJINF0PZOOO4qnKeHBJ3tAr4EPt
         2IaWYXzDJ8GDJicE3XpyBVxrZ1e374UjyRtAi+stNzWAuR+NiCviIWQyoxVO3b5aFZga
         pDc+3wrqp7WkTWbx4epslVIUgdQCgi55FcXbaQ7iFJNRgLVxShon3ViAP1Fp1wOMZ1Bp
         A/o16rrITvHE9y/IjrwjIEydJtOX/BgmRgpvIm+DOxHYZPfAwiVVeB7NppNkRrI013UA
         1zvA==
X-Forwarded-Encrypted: i=1; AJvYcCW1FCb69Gaa/S5BBoceF+eaZRjVoG616a8p4gyxfswfEzkWzdDWefbMf4CQggGpuZuS5dTOuxjZtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXb3hL8oma9JTrDyJEC352IK7QiqWZcRy+IFLrG/xlmea7jNey
	GRw0s7Dz9h+5SGV7+ZnEkcU44F0rL5x0dMOyZgrSW15qS8ejjwFIdS9eSrBCzHg5u0HXVR7ivc/
	5vJ+JfQFgUdT1Rt+k02I5NXDwVx6qVyAZyuZUC1Xcf20jpFoivryUKm3DVewzpQ==
X-Gm-Gg: ATEYQzwYbnR5nV0fBtCX5m58mPkTOr2sN07NJ21L/o4TCl3Bq50Xeb82r39J++Orj9L
	qL/cZY3+a4+dPPFDRelipQDLXmj4s+sq8dE0PLGBhE+Nzzjb0FZVpBUUZJIMKD9S26f1FA6rr4e
	RpMWyLW9q7SQGxupCeGTBu3wWXSu6R7jDbL13NiyCkps5ho8DqTiSQQNgYLR78tUdOpP7Nb079y
	AndQkz0w1SMquvCaV3qb1V1nVvEr5jiUq8SMn4kf0tfTCAd/KldHEwoExoQ1ANcQ7z5/qsYdGjT
	qScfYE+LFg1fWQcscbeC4SdGGzLhGHQ6LsGzhOp83whWrzRHhoLqppZgxRQWVDst/EJC133VdMJ
	N0ArLlLJdqppacRks2kjoHseceY7v0SqJW1Z1xXcglvsWj3tWdDUBf6rj5u5K/A8Htk/4/a8nk1
	ZwBeHlnWrY1nhqgitFF608IFuZHhHjuF3QyWg=
X-Received: by 2002:a05:622a:1899:b0:50b:506d:736b with SMTP id d75a77b69052e-50b506d8652mr131634761cf.47.1774311072069;
        Mon, 23 Mar 2026 17:11:12 -0700 (PDT)
X-Received: by 2002:a05:622a:1899:b0:50b:506d:736b with SMTP id d75a77b69052e-50b506d8652mr131634421cf.47.1774311071657;
        Mon, 23 Mar 2026 17:11:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf99820f6sm30339021fa.19.2026.03.23.17.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:11:09 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 02:10:41 +0200
Subject: [PATCH v2 5/9] interconnect: qcom: define OCMEM bus resource
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-msm8974-icc-v2-5-527280043ad8@oss.qualcomm.com>
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
In-Reply-To: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Masney <bmasney@redhat.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1703;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Sy6oJd+KnyyD9Vs4BTyOzyQv0pft+AOfiX1PY1GJ5ag=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwdaHqbmoZNiGrolPxRsj2zZrjenjJSqnqdP9W
 ztUxMdNDFSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacHWhwAKCRCLPIo+Aiko
 1TgoCACUvtdtzarbR8m2arr844FyuGwCqDMhs/aEAswvKDxAPOPUNSBezvQ6LBXJchB4ZaXQ1XC
 sEww9INa5Gif2fkZBmfIJsU/5HIjRetYUoy1nzlIb+c1GY0yFOKelaFV/wCKK0dn/D2XlE/djfb
 KXKwwlWu6H/1Z9bosM39Gp39zMQp7UMIEy1/sQCjmanOzoCBM294MasCUcGJXrLPkcGxYyj/i8F
 oa9vi8S5hgmnUO0xSTUo2hvFs56IsdKTsSo0ZKD9X+qM/sSBSKD0YIm38KLunHi71yXZ2v+cUB3
 d+zQo9XggIbX2gmL3wJblpQ/pgcCPE6HL4DcCIqONjMyAKnk
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAwMCBTYWx0ZWRfX5TXUtJxPNgTU
 X6nKqjqg1U+IVj5r5DsDWx5z+PkaF9STHhC8G202OBsyuf8V2QJiSVDt0UBprqqrPgl+macMgMw
 O0hs4iFqW9lRkjHD3M/goQzSQhfJu/kXWlQdlo2OgYTgy0UJ9CDmm2Aysom5FEjCu90r5DLUwEF
 kfRONiuWcmvtQFjRbIMNi7BrFCKqlhw5YDaPTAi9TzZQ2q0ZJ/tOLn33Qeng5+GRIjvW/zXnY1x
 DMaS2vIEMcbkQqSeR0g8Vw4tLaA20QJK+ST4vfEZf2Y/UcD8eKJjBRkNvy5imbeOAZS8CHg8Hc3
 hfA7cIjZ4yi0fqBLfgrwX6Z6nr55HFPqLrp341k30Az+BwewIFUxG6pTwnU5z5OSVjebnM2AEt2
 v+EK1KBLWN7/5Cv6PHse+kBQ6Q/ye59TZW2kpyw+vLwdoFxBNna+qfvhuytptldWtU6qFEZBfun
 pNZ9pU8Yzb4EEVYvYcA==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c1d6a0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=20KFwNOVAAAA:8
 a=EUspDBNiAAAA:8 a=zOyvSeg7rOUdy7vhyckA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: GdGJ7Go9wiX_pmCdTfLBW0J1Tw3uAEJt
X-Proofpoint-ORIG-GUID: GdGJ7Go9wiX_pmCdTfLBW0J1Tw3uAEJt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240000

Some of the platforms (MSM8974, MSM8x26) require voting on the OCMEM
clock. Add new resource for that clock.

Reviewed-by: Brian Masney <bmasney@redhat.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpm-clocks.c | 6 ++++++
 drivers/interconnect/qcom/icc-rpm.h        | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/interconnect/qcom/icc-rpm-clocks.c b/drivers/interconnect/qcom/icc-rpm-clocks.c
index ac1677de7dfd..69846e26f46a 100644
--- a/drivers/interconnect/qcom/icc-rpm-clocks.c
+++ b/drivers/interconnect/qcom/icc-rpm-clocks.c
@@ -31,6 +31,12 @@ const struct rpm_clk_resource mem_1_clk = {
 };
 EXPORT_SYMBOL_GPL(mem_1_clk);
 
+const struct rpm_clk_resource gpu_mem_2_clk = {
+	.resource_type = QCOM_SMD_RPM_MEM_CLK,
+	.clock_id = 2,
+};
+EXPORT_SYMBOL_GPL(gpu_mem_2_clk);
+
 const struct rpm_clk_resource bus_0_clk = {
 	.resource_type = QCOM_SMD_RPM_BUS_CLK,
 	.clock_id = 0,
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index cbf0a365839d..ad554c63967b 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -151,6 +151,7 @@ extern const struct rpm_clk_resource bimc_clk;
 extern const struct rpm_clk_resource bus_0_clk;
 extern const struct rpm_clk_resource bus_1_clk;
 extern const struct rpm_clk_resource bus_2_clk;
+extern const struct rpm_clk_resource gpu_mem_2_clk;
 extern const struct rpm_clk_resource mem_1_clk;
 extern const struct rpm_clk_resource mmaxi_0_clk;
 extern const struct rpm_clk_resource mmaxi_1_clk;

-- 
2.47.3

