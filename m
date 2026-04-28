Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707F44CF5F
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 17:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777397576; cv=none; b=rKgGLvxah4fF7JYUwqybPRta2PnvP68juRG7ywybsbOB7XcaYdCUSxVC8DnYf6kBHy7NIC5wj1TDM7D92VN6AS8enSoDT6Pej1rCPtZmCI5zoPOcJ0/W2AzCYzKyfFMjqxuLcVdMv8cPB4qspiy/fJX+aKGBR/6v101y0X3l4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777397576; c=relaxed/simple;
	bh=yQAWJBywT6pwqGJLKFwuedfSMNGXnwkl9Ism4JarDpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r5sV2d+yl18rrBrnIbzjzRhflXwIxeYL2Zlpnlj//yny44zzc/zQNL2PPsaznQJa5hIaIBuxMZPxoitB7x/UtLSUhi6yCMFBfbdxh6uBHITp0/mAobarGmzXTYn33JzkZplHZVtTUDRoWUq57fYHtz6AfSXbaUYREtEtWRDJAdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RW+wzwvA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HfPeuKX7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RW+wzwvA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HfPeuKX7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SFsQTc2946242
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 17:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dEMWb3CKiGmBJqcMxJUz+Micd4CN6K2YYETwoBGc6kg=; b=RW+wzwvAfP4l9Asj
	jGdz/TNLYxPDz3POML9mOfd3NOPug7kgVb5BMCFTV0fNSwc/qhCHYN+R1SVxuSlh
	rg7HkTSucqC533H/g/aA6RRiwmUkaHIthCqGWIlNCtIzXGyQQILIbx94uv9ln8CZ
	mMTwCa2ZoPBEK2VhXkBzGk8Rb58cf93RcWlSrVMJam+gxeLJhe5VahdYZwS145Qn
	KA1dhEmacXL7RQrGFB4WQVsdk6Ng2huWA6YPcE86R0OsAWvp7BYq/JpH9v/qkJ16
	Ms1/7qV0lIPlTCEu77jlCW/hP9/j+UPB+aB+ND6Eh2rf9SRgoPMkcdhogcOiiVJH
	plIylg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhak3r6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 17:32:48 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e423a05c8so1962191cf.0
        for <linux-pm@vger.kernel.org>; Tue, 28 Apr 2026 10:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777397567; x=1778002367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dEMWb3CKiGmBJqcMxJUz+Micd4CN6K2YYETwoBGc6kg=;
        b=HfPeuKX70Vr7Cf/DYE1AeN9a687ukk00j4zHo5NRNI2sVyR0mf1ZSF47NXFP7bAK9W
         nl/WDUimen/PdXZj9T6BYJFlPKCBqhetSQI08F9xFrAIlGPPbv+AbLTYGywG7bqsJTxH
         8ESoyEw41JWXOa/1zP08cg35gScAjcHnFo+y3OcoSFcQjnlm4TuzkxDjtvlZhyrhYIyK
         bZL7LLBMwXS4I6721WXsLI6sfpRrUqxG5hWIZvGZvxVRhL5Ga6dwVhQlNGXpQVGB+DSm
         hyP90xCvHAI6yl9veL5xlVpeCj+s/a7WbTRTT7cHiykgs0t7bMjsnO6ICIva6XGcCxgW
         6Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777397567; x=1778002367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dEMWb3CKiGmBJqcMxJUz+Micd4CN6K2YYETwoBGc6kg=;
        b=CAUli9TX91gBZ3kil1bf3LG8UD2El76vixXInoBAu2s+5iRTgrBQ82ZiCFyQzBPJ/N
         2ttZQDisQD2QBd/Fqc6oCYcbqpREfuIWTX7bbiOCe9I5ui403LWwX8MtODBea9v4hmhl
         Xfv7ecnSE1ghip0VAkQHm1RzJFRFskiPLV2F4Opf4cS+K4hI/nDnMle3VyUo6kZSWeaF
         sAwFIb7/jAWV93d0VbDIY0f3FpAiXwNa/JiQBu7DioS4SfevSpgEt6/CckVXcwXso3TM
         kqYvPnUXVWaAGmbkH9CAXr076odnBjiWQwuCmvptmqvRDBBbhe6QrfcNyRxYX1uYLDCd
         y1Ag==
X-Forwarded-Encrypted: i=1; AFNElJ97kyyYhi5qaq7Vr+eL88/zurPHV1Rtu5DFxwM7mr7fxJTpTVjYJXjtqZnqYtf6Zv8D4tzeNH4BPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEAQ+8rITVWUzkTdrUbr/sP2n4bbn2QzF63kivpZY/45/MjluU
	2EOdKM/xGk9k3rvApaRKIg+HUk9DzvKyNyPmK6eBVryuRcHThLec2aF1JvlYE050zXGoal7YIAR
	H5vNOXCDB2Qj175Li7OYlFud9JvAKKBZIf55H9aUbE/HfDS6KlmofqEaSltgn+Y9lHlKs+g==
X-Gm-Gg: AeBDievD4hkMOQ69nzwTXDoiuEQiAkF+RthSa4xw0Ez9GOStwl2hlCjwsZ9cGMl0GJX
	MUV/vimBiAjmOefGTBkA0uYAIjEHXZpKhyKJbp0BddEUtKy1G4eNMwWqL5p/kvKeiwDpI9AOlu1
	tN93ut1jfuJcSeQBnNKP8SnWgKLQc8WzQ3GPwp/KSf1aTx17t7j5Ilbcey0S7NFEvTHKKKRUSzi
	jeTJh/roTz63dTuSJF7ATAycN7q1oF1J1ogIjFA4uQCZp9ikhyx/5m10KFihQy6M+RvP6nC6DXn
	QdiyZBa8iGmyVuib4MhdUMYOap3u+wyBRgS+iiEGRziQT/HX+QAXoSC8QLig5IVs7N57FYAeo0y
	8qX/uxq746VqKOxYgP5oarplLkVRTpax7jyOmRIe857e3T/QHt7KSRcA=
X-Received: by 2002:a05:622a:454:b0:50f:cba1:18c4 with SMTP id d75a77b69052e-5100da50fadmr52787501cf.26.1777397566859;
        Tue, 28 Apr 2026 10:32:46 -0700 (PDT)
X-Received: by 2002:a05:622a:454:b0:50f:cba1:18c4 with SMTP id d75a77b69052e-5100da50fadmr52786681cf.26.1777397566110;
        Tue, 28 Apr 2026 10:32:46 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a7b8ce444sm2089545e9.0.2026.04.28.10.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 10:32:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 19:32:37 +0200
Subject: [PATCH 1/3] interconnect: qcom: Fix indentation
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-interconnect-qcom-clean-arm64-v1-1-e6bc3f7832db@oss.qualcomm.com>
References: <20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com>
In-Reply-To: <20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1875;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=yQAWJBywT6pwqGJLKFwuedfSMNGXnwkl9Ism4JarDpQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBp8O83Fu3GfCGKF7sJQ/ZUFjiWtzMYyEhj5ZLnx
 s5fkhc6OpCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCafDvNwAKCRDBN2bmhouD
 1+CZD/wPHH6w2qnDNKJ3cBQTuiZ0KvF1tnVH9pGm6JRyFwmQUocpUUDXozSfHDJ16Q0UhryYLfk
 A5JafqUStvVzVHl1viKG6ZuOKZqRcOR5J1OIgeEKN4hGhlHFPeyJjubuaTJvm/mfeOSBN2OsE5I
 1B75cRhoxwF4EJGI5OiJ872G84a2NstxA6DhTEew8mECqTvRGWHruVcABQhKtHliYuTIA9rGuuo
 Gk3Y3GsmbrLf8Z6Vo343qUc1R0QGvv6VBZs0kDjmZPRYGvn9RsDpaS904TrCOU4Y+lQAI88OHeO
 4KbxDX8LeQaJtaTdwouk3dap8NdItPzjuMwBK1mcddXasD/7IP9HhRZNcdceus03uy9IoC6M6+l
 sgLoQRR5FPNzqzud/GWfx8NpwKepeA2BUiKoNPRtwXQmQA73u7hdHz1Z/M0ZuoyZ97f4eCDwLSb
 WrZmbFr1vqo8mKLZzz5h6vjuzwkEujZOZWhf0qEN3d/ZgqIopGiVK0Rvw2jpMrigGyFMFgr2Nj0
 6uAaGXcRQ6fN1dYMQ14vVDddDBRjRkcjeOemM5e7X0L5TBYbLINcVgCfwiIzyLDADFr+Rh9XkIa
 J+iq2ejazlnlwTJ448iio0Wf84ZIOPsgWhPbtSN+xoq1KjUN8+CpB6kEm1HdcLOCCVG8eXbX/Vx
 fJ2Xv0ui4TNPodA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE2OSBTYWx0ZWRfX9ByMVpled8Jm
 kcpStBm/yl0pKH3LQGLdLb8OP1fJ0RVSkuKYYbmPCxCqUS5gID3uMKZ1mcD9U0JGGR+BP1XTJih
 3KpOjtN2F07laGIziuR64XjQ0xVIf6qzMXH/kZDrTOKSfLfN/jVyyMTFBb1ZgWIlMQDx7trz413
 Zh0tn5FwFFsJ9sXiXWSxTaPdcaeAVbWfy0sNI+YHUs2+ckImSngb9M19mk7e/jIxJ6bG0/ILDaj
 bVw8yHkpdC7F7+knppaal1XkfMyuV0LM6ruNZUcq9DTLidWGVhm8ukIMOboktfPJvOa/ZXCRqVn
 LKc3sR4hIU+jk3c3+dHxz4JyBAnUaba0I48U2+ODk2rFlp+hn8G5pYeJ9H0g9I6Zy9PBba4mN2g
 WVS5uVAwlfj3FlexuJWibnN15r/kgf7oZYHGdRMYEKWs3qVzBk1kkbpgD7CkZX+SUP+L+3OEiT3
 kkWWvyQQ1YzmCMwjwFg==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f0ef40 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=gOEeR9iKwsj33Yj5oN/cWg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=UCTw9GvNnafMAvUb21oA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: QrH52Q5hzSCGkFU4QOQdHBBrSKqzHvk8
X-Proofpoint-ORIG-GUID: QrH52Q5hzSCGkFU4QOQdHBBrSKqzHvk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280169

KConfig entries should be indented starting with one tab, so replace
spaces with it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/interconnect/qcom/Kconfig | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/interconnect/qcom/Kconfig b/drivers/interconnect/qcom/Kconfig
index 786b4eda44b4..871663bfd094 100644
--- a/drivers/interconnect/qcom/Kconfig
+++ b/drivers/interconnect/qcom/Kconfig
@@ -9,22 +9,22 @@ config INTERCONNECT_QCOM_BCM_VOTER
 	tristate
 
 config INTERCONNECT_QCOM_ELIZA
-       tristate "Qualcomm Eliza interconnect driver"
-       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
-       select INTERCONNECT_QCOM_RPMH
-       select INTERCONNECT_QCOM_BCM_VOTER
-       help
-         This is a driver for the Qualcomm Network-on-Chip on Eliza-based
-         platforms.
+	tristate "Qualcomm Eliza interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on Eliza-based
+	  platforms.
 
 config INTERCONNECT_QCOM_GLYMUR
-       tristate "Qualcomm Glymur interconnect driver"
-       depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
-       select INTERCONNECT_QCOM_RPMH
-       select INTERCONNECT_QCOM_BCM_VOTER
-       help
-         This is a driver for the Qualcomm Network-on-Chip on glymur-based
-         platforms.
+	tristate "Qualcomm Glymur interconnect driver"
+	depends on INTERCONNECT_QCOM_RPMH_POSSIBLE
+	select INTERCONNECT_QCOM_RPMH
+	select INTERCONNECT_QCOM_BCM_VOTER
+	help
+	  This is a driver for the Qualcomm Network-on-Chip on glymur-based
+	  platforms.
 
 config INTERCONNECT_QCOM_KAANAPALI
 	tristate "Qualcomm Kaanapali interconnect driver"

-- 
2.51.0

