Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783F12135B8
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774228663; cv=none; b=cCnBthbX8EEQ8nrxL6n55rWFihClsr2drteCl1UqlGgeWLX/zT1r6d/09s1dnS7ibaDxYcJZlItYTvOfskqKhpCdLnAnOXkkdDli0sDEpCL7Em2+DtwsTGA3di/oMSfdQ1uwti3E1yeQooocIMG0BUfjGOm1yWztMkAWRl+5bbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774228663; c=relaxed/simple;
	bh=Ya/NJt7pKVR6io1jC1dQy2DY1Rkbk/XPlKWL7mD+Jmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hW61mCJNmkTJpLVYwhKrefkPDppUsFk5n12N17jWWtyWhTW8+wv527S6AMNp2cMQ5gMXyG0sWGS/BPAt8xCGbKZ502aJiNla0TqKOm+FdM2zgRSMvUR+8mQti6Y0AH81qurbdSm3ZjafwxpGLl+CDGQ7EgH9jKuIgOKLpa9jln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cXk0p3mh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KXMNUYlR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cXk0p3mh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KXMNUYlR"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62MJFSPu687241
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wTOuT2RJ0koUSSURaKhqCLIXf071rLm5jfDuWF+MJ1Q=; b=cXk0p3mh9bZFmsB1
	DFxBheHjhCI8KZKQWoagU5+TxwtUFBkzg9tDHefVwD0K90HjMv/1YLDiwOcJR/K7
	s7JzwSeg5SyKctpppNsZm96XN7Ek/DJxQx17vsNjLmVs9lhXMFhPx2ADu9cf8tVD
	t0R7qYbPpD9HPglZIewp5TAU+3aqAak/T4Q4FTcJRF94pR+T8FlT8gCxo7XcZ+8S
	D8mzRFXYVok5TUGu5ZIu1Ows5gd6RJzvRnjX/vuFrWvB9VD4hRW1v+gKncTT+YoT
	HUsy3qmd4Di/ZGF6AA+WTKMlDg4FRTxLiXWS6jhPnErGySYGY8u9+7oIv+HGzQo2
	ZsmXsg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1j9rb9ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 01:17:41 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5094ba09affso307646521cf.2
        for <linux-pm@vger.kernel.org>; Sun, 22 Mar 2026 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774228660; x=1774833460; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTOuT2RJ0koUSSURaKhqCLIXf071rLm5jfDuWF+MJ1Q=;
        b=KXMNUYlRq6klgzjcJSDlL9fjnoPCIIneQBP86zBQT/y8heuTjLTzXBv/ZyBNEfUKYT
         628WByvZ5aGi+DrCkPwC8Dg+cUd7CCf6lyxowvdkhGk+Smodo9wy2uR7KwGDFfxTWpLO
         fzhvY5VlW/00flOnRYoUiOY4w0mq4De465WkOqx5ikPg8CNB5zdFIH1SS4Yf/KzV8yLn
         5jx4YEYvLBR+8lK2eyAdE/WOJCOoTGeKxD1nC4WH5vLtDRg9Bpx6WaRaqAphA/E/8t7q
         +r/NMzjVOHDe54rWosZXDkkLSOAdmWAJ6atI9m2AZascMb3K8+3lL274Sob44cz7yYS1
         DCrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774228660; x=1774833460;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTOuT2RJ0koUSSURaKhqCLIXf071rLm5jfDuWF+MJ1Q=;
        b=E75qWUilqbU0ECVaeU+QpJsirNHmOXPXNNq8S9fbzIMTwuEFWlzKrxiO+O9o9dNVtN
         Jqlqvg+rm8MbhLPaum//ZJW1VUk/+2jIH3Py4EtNsSrjQjpNRNtOA2xk/tODi6xWX9Qk
         FFJhPDV1JJWFT8qbPBZCDVV7M3gmY/u0aWFPeDuri90o2HEDs5snohJvZHS9Q8nsPrT6
         n9O+Ps1FE6k64+NOlsExescSyA0NhGFCcZZOvcPWm+/B6JgS0W+eaiJxkRerj6tFUUBu
         WsXz614PXdUhC1lURdfcstmQkN5v4i1eBkHzh+zjHDfIMedy2Tex0tB00erYKN3sp2oN
         2GnA==
X-Forwarded-Encrypted: i=1; AJvYcCVZM2YXoye8tE3oILad07LEMSvRrEHclTr2BWiKCyJPL64sc86YxD2/CZyujRtRCq8H9deNicBgFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycVoMADnZolZC25mg7gy3UJfW2pFvK6znaS9iIsm1bWlTH2RyQ
	/R4ht5I3Bw4DXFRB9YEqo9wSeWgrqAPz9NSzAoRnN81NaqqCrOAoHoOxMkZp2lbSZJ+yTdS1iEU
	WNKtY7TIVzeGOPhdBP3GWXD/5LsNB8PKqV/n9oDUpXT4B/W03utyuZyN9XKu+hQ==
X-Gm-Gg: ATEYQzxXjxAKtx5UOSVXRb/cyrXdx3ZRa1StCEHrj9b8sUCJ4+TTdPbPDpccJzgoakk
	k6LBn1Rnu1YwYssltd44ICDwccsbIMotMkrHkMSVQj9JUEAK4VZTyRXIULc2S5BRCyHYYY5eRxv
	Xg+pzzrCZQzROJJKWHI5UFUtFDIp1eURD2y6s2hRQQ2L1DcIJ9kPCaoFeqYpj00sxGEc1qusdkk
	cRKeu7tMESXSV5pJLh5g1XSBBjaXIxwR4BmrLZUb7I5CUoNbfwSdVW9ypFR9U2F167g2jrEGFVz
	fVWfjOVeJ01AZOzm9MZSTkbkUxZBAX4stQ3vkYMrAFR/XiKcNTLlXUxnNqw+i1f806LOvT9S9zi
	tL3I6jOXmrW523QgpVaCy4LqnQzBqu/3XszGzFTbWu9COSdHKuGQ7KPgusy8J5U7JdVNfJ2f6g/
	j7w9k3+GEkhOXWL+FS01psFu7y/hFS0htc/oA=
X-Received: by 2002:a05:622a:590f:b0:50b:4984:148b with SMTP id d75a77b69052e-50b49841855mr91549511cf.64.1774228660427;
        Sun, 22 Mar 2026 18:17:40 -0700 (PDT)
X-Received: by 2002:a05:622a:590f:b0:50b:4984:148b with SMTP id d75a77b69052e-50b49841855mr91549291cf.64.1774228660031;
        Sun, 22 Mar 2026 18:17:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2853050e7sm2216150e87.61.2026.03.22.18.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 18:17:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 03:17:21 +0200
Subject: [PATCH 5/9] interconnect: qcom: define OCMEM bus resource
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-msm8974-icc-v1-5-7892b8d5f2ea@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ya/NJt7pKVR6io1jC1dQy2DY1Rkbk/XPlKWL7mD+Jmo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwJSeX1baotwnLbuBujDe1jnKIQvBvRRnSisNQ
 9ELGzx6MR2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacCUngAKCRCLPIo+Aiko
 1Vo3B/9REU/bTIRSQrxK7GSNxOljj7iZ5OrMDOzjAIf8El8TOMsTuQoNyeL3P4jFS22yNMWE30Q
 j7I8wQM926EiRQlR7c/JKS/h0qxOlZ+cWApf/rvzULqRw2oV37SFjXBqxYHsZBd66VSZEf0RJuc
 dAScHpjwQwgveOWBWd6bLsegZD41BcOL5UvA5LSjfYpKUKL4JGsHp4l7abGStklZX8TXHIPACCG
 HmLSw7/dk6I1P9ZV0h8xwQQO7iQuNxBsOv+4n8Ts8vKe14ECwXd0yCGp78KIuJOuZZCeiiqbKoB
 +596xD3xubsn7dlsYHL4C1ih9y4MY50SvjMuTV6EehoWm2jt
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: noWGOxlGDKt2ruuWeETPbf2u9RIpMDSw
X-Authority-Analysis: v=2.4 cv=ZPDaWH7b c=1 sm=1 tr=0 ts=69c094b5 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=zOyvSeg7rOUdy7vhyckA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAwOCBTYWx0ZWRfX7eeOAOAzs9Oh
 HuwSWqf0j5nepSxa/OeflP4bFzPcoJcMxwxdfioPkyqDHgi0IeR+PpeDYe+B0q6adnzRfGuTx6H
 A1yD3jZgXalnJFW40fLWjJJtwpgFXTNRrzPHCWu+/G9b7ZaOpOHLl4pSfmpLv2U0X3sfNry1dT9
 mQRusBuosKLDhVQq7HeyndlDl3xy0ifxKirYGRxAJKIZ1uZEr/4n/mvxD7CAAAa0js/cyd1vEsv
 insfTSMCX8yFJL+25OTFz1TsxwOYmYS8ukrFMeivTzthGy2nHfP9TVpO1LH9YXFK+GlE6vHbqcW
 tJwLHCBYfUrj/GbvSgP2n1eMaQHfycMqSs89yc1tbWYuzuIs6uCwM+fWrhIoyRuIvuqclL5bh/k
 ytOWwLuPszzX9xB2rQ5N4ZqKcbgXjFT94tJr2Y4pkAwYNFJWLMLpQDqxNfMoSAFc/j/GufGJQEc
 ZjPMkzcf2ZFSRwE+Sng==
X-Proofpoint-GUID: noWGOxlGDKt2ruuWeETPbf2u9RIpMDSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-22_07,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230008

Some of the platforms (MSM8974, MSM8x26) require voting on the OCMEM
clock. Add new resource for that clock.

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

