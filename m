Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6132135B8
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228667; cv=none; b=qYi6qZX6IIyVp3TZqrUNWJ5ZH4VCbv6pxSyMmJvI6fXOv1J6pv8VK02k2sY7eLIzGJNFXT1eJ221OCKFDZa53ky6EKGDqdxYRuRMs0AI02IEzI11KcdByWbbDGwFtogD/iCuRDx/h6bfhhS0KEUL3DfMiavOeET9cC/ylFwSTK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228667; c=relaxed/simple;
	bh=baPUH0igjJNSAnKp/z9q/Mft9PpLQiCQHPwVsNkTz04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ijTgvqp9GZHozJ7tsP9P7QJjyeu7Vj21QDLOgZM8Usyh8Glg8DDuOlLN7hGp2P26zHCReOF51cAqYZOAFfC2r6Uu6bJQmJuBbHF0rARuScP1GQjj5Z4pS6hMyFq4TR9vBuadh8JiXTOBLp+WdMi6mTvieDILe3tZJOb1ruipSfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LWqA7EyW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WEUY50VA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LWqA7EyW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WEUY50VA"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MNH2DO222291
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/t8SuqPVuhwUVvBRrLk1Dc1LxggO0aNoDGEAzNHrMwY=; b=LWqA7EyWPoIlDTJd
	cltDGAVCAGwfQo9jH2HK45UOLY1b9QRajzYyu5W044ec9DtRpi1DwmY25ExDfRjH
	5htAAY/A8nZ3Wjy7oYOiIDrEF2aWV/+LhXMVlikXkLX+VZgGNU1/HNSNoLkPY6x1
	9d1dDZJA7xvAiH1LsjdLQGLNRtUu41hi3M6Hjih0pR31P80mSPbvKrbXWJi9gaQf
	wzueF8A32Z9Zq2/D8GNg5DVnKjxMhuFqSY6Y56nbxgovtT1x8/24+XzcEef5xQiw
	MLAdjM+W8MH0v5qr9/NUXr3xtcsH024+dGoIkAu5bnu1ngPltiPQAyggK0AKaKO2
	odH9pA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1gpk3eny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b220c72bbso22409701cf.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 18:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774228665; x=1774833465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/t8SuqPVuhwUVvBRrLk1Dc1LxggO0aNoDGEAzNHrMwY=;
        b=WEUY50VATJiUV0Rd2WTS1k30mUM2w+C0W+/EayXHI4SWxz75gZSLYs54FyaguTMDby
         s7aqC4rPhLPeskCK82Pef0eeEt96de4s7rGuihHUA4y+fkE80+C20mISo2JXEOR3HUhO
         RqPhRwBrqzcSlsMmgM9u2SkymYlcs4Nf+hiQMC8PfSAjO5QTBTvPtJGrgicbhAbOCjjy
         L0DWAaPRAPuKBaISTf+t2SfxGum8/17kkNANyiopeBRz0WgiqlgXSmcXvkWspXO5Yj9G
         BBUXFg5dGb7T8KyqyF8aW1lFA73e8zi6bj5dDalA1u62P1WNpAcyzfS/0+8GZ2IjD8sF
         1ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774228665; x=1774833465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/t8SuqPVuhwUVvBRrLk1Dc1LxggO0aNoDGEAzNHrMwY=;
        b=hu5MuPzc73mNcP3ht3QUI52ocZFb5oQrcInrd+S8K4a3ZdUMfvA/1WDLUk/Z25xPku
         hVtfAzuWGhorlfu+ddbgfqz4EpQQgP08FP8eGv17cSW+953V4lOybkVHHf88DVN5ht20
         RDUsDWNPZLA4bBz2MeHv3q1SFKzLxi709yW6qhryEsGaU6rZ36RlRG+55WgVS1aDP9N1
         mPLT9V6PvMju/Wu2NBzddX/cE2fqeLqY4NUr4jyyeGvm8Ep9czll2lCUKRLmGfeQ4Utm
         UopWAoNiJ2HVHfI0kkPeU3YiZJD0b85BGV983gZPJQ0ckhNNMdy0LiSOEx/D69SRwlHU
         zp6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHgMFcmPAJDXRjfUjoA0GbP+obe7GSYa2nEKU08Ar4X18aCG0RPhjJe8zpu4ztRyWWUjrodIeqsg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ3VzZVOsQxnrfoJ4uG5AcvwzZLylZPscoS2/dgPtTdfsqdslt
	Z4NhwnOBSzCRtqZfpkHzCyjakg17NSC+DCPvWXElpWBhzrPCe2usA4X462pMJ2sXOcfpKq53Beb
	52wo//o8VZRxLpLRpQgJzuXp/QA1fT8Xz4gdLDU113bjtv/rokabRnZv0dOx0ZA==
X-Gm-Gg: ATEYQzy4tQMD1poH5asd1NFB/WT3z4yXc8+b07wB5AGTLPyVxXqA9XX5ygvrE7gJgo+
	WW22gZxst+7WMJDs+hDF9TzgIpIWZsL4BaikMag2L6ie5uIT6i41qIYSX/nRoPoHcGDlKlNEZh5
	qYlNkpXvaJPimh8EEjGj61qf3L3JBUCagC1dCsbfHzG1r0tYolMNI7hsGb1mCHW6eLZX3rDcuri
	Z0EjSJ10E7+7aUBdlc1jXE6D0Q6DUeZNu5zOmSuzmsej1m5kfuUKiaRYtLJI9lcCvANcsRwxyvO
	xTWBUZ5aBtOpNT0dYgYHKJhEqruyj4MJ/HhULyBVJq0sW3cZU7Ju4Pmq3LH6Pt3bayRm47lS++S
	yOTw0E+LD59wpld0HG6sf+oFWgYRP3iFXL+WqPFi0/6FmyaEfCx+FNdSvO95y57f+A20hbSw34k
	ZE9N89L9JLMd0H558obec/2wUzth1dae8M3X8=
X-Received: by 2002:a05:622a:1e0c:b0:50b:3ff3:f4a7 with SMTP id d75a77b69052e-50b3ff3f592mr140884051cf.35.1774228664623;
        Sun, 22 Mar 2026 18:17:44 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0c:b0:50b:3ff3:f4a7 with SMTP id d75a77b69052e-50b3ff3f592mr140883661cf.35.1774228664204;
        Sun, 22 Mar 2026 18:17:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2853050e7sm2216150e87.61.2026.03.22.18.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:17:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 03:17:22 +0200
Subject: [PATCH 6/9] interconnect: qcom: let platforms declare their
 bugginess
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-msm8974-icc-v1-6-7892b8d5f2ea@oss.qualcomm.com>
References: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
In-Reply-To: <20260323-msm8974-icc-v1-0-7892b8d5f2ea@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3957;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=baPUH0igjJNSAnKp/z9q/Mft9PpLQiCQHPwVsNkTz04=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwJSfDBkeGmEtVasiV4Gql28ow9equeUMsxQR7
 lfteiyKvuGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacCUnwAKCRCLPIo+Aiko
 1a6yB/9limDxU+rsTOQYqO6zFcA33pv3UVDDPBkZ3Io1fw6LtmbqOP2iSihUjzcvKE+4IU0OriG
 oNrZVtHmsA9zpYz9LxYRgqRwB3lbhKXrjV/i9yV/1q9H41Q1g5Mrb+7p3aDCCfq5IlesEr8Hcw8
 J/XVqfYoWdsdwKh9xrbU+dcn7230zUgt1nXMaSu0wDARWkZ8MawuDILju0Ie3BO975E+7YPCQ9r
 V2w26bHIEBlzEk2d/JWTDDkPSf7eWnguBd0mJP0ZsYbPA2Mfs/3FNcG5HSlHX+rRywZ5tKrBn3Q
 hAJGKyrHFZ485vmAv8Ms7GpqzO3boMlY7QZ4PQBwf1tNMdim
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: LPK6CThJBRS9avDceGPI4V5Ym0eh4Epj
X-Proofpoint-GUID: LPK6CThJBRS9avDceGPI4V5Ym0eh4Epj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwOCBTYWx0ZWRfX14v2iztfoGyE
 1ToV7tkNNTwhoq3J2nuQsuMLwWQxAsc7gjXPxSee/lLAikJ63b2SpAy1K2FC9LvJ0py5N48+Bwp
 1OhmRAY25OJOzfA8+hSzW+srEw1NWihYc0HW8DvWWsKfO2A8AI00e7NikKDnbAyoCW1YOM3WmRo
 hw/Z4wQqXlRtNJuDRL9Ju6K6Xd63oQ6/7stFomIYLVlvJyZ5IDq+wBeRnImU5vqPAj+wflM+WCw
 iXIIKquwT+s28O6mFflpRBssI6vqclrwWxjSWZ6p16N13BjQFboHeBTcYujYX1ot9ctfkg6KfUE
 uyv9j4KWN90sRs9YcVT/jN2GKO4fTWjIOxBGy9jvOVSi78UIDRuyAHAqCUExV1V9JteIlozEnsc
 gSOIkNEVTm2S5KcPPhIx+lpKtyEICicw+UKdyoexyiHjdkIIqJCSQ0ODMGFFT8l1jUO5rYOhqHX
 IvWAg20UZNj5hTg5P1Q==
X-Authority-Analysis: v=2.4 cv=QKhlhwLL c=1 sm=1 tr=0 ts=69c094b9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=PYMLbkgk4Fc5e-Gbr9wA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230008

On MSM8974 programming some of the RPM resources results in the
"resource does not exist" messages from the firmware. This occurs even
with the downstream bus driver, which happily ignores the errors. My
assumption is that these resources existed in the earlier firmware
revisions but were later switched to be programmed differently (for the
later platforms corresponding nodes use qos.ap_owned, which prevents
those resources from being programmed.

In preparation for conversion of the MSM8974 driver (which doesn't have
QoS code yet) to the main icc-rpm set of helpers, let the driver declare
that those -ENXIO errors must be ignored (for now). Later, when the QoS
programming is sorted out (and more interconnects are added to the DT),
this quirk might be removed.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 17 ++++++++++-------
 drivers/interconnect/qcom/icc-rpm.h |  3 +++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index aec2f84cd56f..23a1d116e79a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -204,7 +204,7 @@ static int qcom_icc_qos_set(struct icc_node *node)
 	}
 }
 
-static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
+static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw, bool ignore_enxio)
 {
 	int ret, rpm_ctx = 0;
 	u64 bw_bps;
@@ -222,8 +222,9 @@ static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
 						    bw_bps);
 			if (ret) {
 				pr_err("qcom_icc_rpm_smd_send mas %d error %d\n",
-				qn->mas_rpm_id, ret);
-				return ret;
+				       qn->mas_rpm_id, ret);
+				if (ret != -ENXIO || !ignore_enxio)
+					return ret;
 			}
 		}
 
@@ -234,8 +235,9 @@ static int qcom_icc_rpm_set(struct qcom_icc_node *qn, u64 *bw)
 						    bw_bps);
 			if (ret) {
 				pr_err("qcom_icc_rpm_smd_send slv %d error %d\n",
-				qn->slv_rpm_id, ret);
-				return ret;
+				       qn->slv_rpm_id, ret);
+				if (ret != -ENXIO || !ignore_enxio)
+					return ret;
 			}
 		}
 	}
@@ -361,12 +363,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	active_rate = agg_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE];
 	sleep_rate = agg_clk_rate[QCOM_SMD_RPM_SLEEP_STATE];
 
-	ret = qcom_icc_rpm_set(src_qn, src_qn->sum_avg);
+	ret = qcom_icc_rpm_set(src_qn, src_qn->sum_avg, qp->ignore_enxio);
 	if (ret)
 		return ret;
 
 	if (dst_qn) {
-		ret = qcom_icc_rpm_set(dst_qn, dst_qn->sum_avg);
+		ret = qcom_icc_rpm_set(dst_qn, dst_qn->sum_avg, qp->ignore_enxio);
 		if (ret)
 			return ret;
 	}
@@ -509,6 +511,7 @@ int qnoc_probe(struct platform_device *pdev)
 	for (i = 0; i < cd_num; i++)
 		qp->intf_clks[i].id = cds[i];
 
+	qp->ignore_enxio = desc->ignore_enxio;
 	qp->keep_alive = desc->keep_alive;
 	qp->type = desc->type;
 	qp->qos_offset = desc->qos_offset;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index ad554c63967b..7d1cb2efa9ee 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -51,6 +51,7 @@ struct rpm_clk_resource {
  * @bus_clk: a pointer to a HLOS-owned bus clock
  * @intf_clks: a clk_bulk_data array of interface clocks
  * @keep_alive: whether to always keep a minimum vote on the bus clocks
+ * @ignore_enxio: whether to ignore ENXIO errors (for MSM8974)
  */
 struct qcom_icc_provider {
 	struct icc_provider provider;
@@ -65,6 +66,7 @@ struct qcom_icc_provider {
 	struct clk *bus_clk;
 	struct clk_bulk_data *intf_clks;
 	bool keep_alive;
+	bool ignore_enxio;
 };
 
 /**
@@ -136,6 +138,7 @@ struct qcom_icc_desc {
 	u16 ab_coeff;
 	u16 ib_coeff;
 	int (*get_bw)(struct icc_node *node, u32 *avg, u32 *peak);
+	bool ignore_enxio;
 };
 
 /* Valid for all bus types */

-- 
2.47.3

