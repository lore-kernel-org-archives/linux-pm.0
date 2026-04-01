Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5237736C582
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027283; cv=none; b=jP2QrNRpdxsGfsbHsphq5sqUUh3LTLKof+lkRkv9c+eakrnV9AZ9vtE699TFnEE9VTvfTzk+zRIvtdy555ET5ZlcOf16l5eWUf5buzKAyL/rFttmwzQqLx5FMdDrbpgwomW2B7YOgzeABwcccYlzJh5/w/MwMrxrFgLQjBJRLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027283; c=relaxed/simple;
	bh=A4Fd2p2oaC0i/0aWJ0+24PUGDksjG/LlVj8xldlFxco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kku4SYqvoOiT0FHdanrclVNV627bivpraF/cbXN6piOVxk+i2jXd/3lrHlngRWKW2x7wcUB7cQMBmHn7eNfFDnP6qP97tR4UaiX5gjFdsYK0Ku9rvjFmgXXnR8WmVrcS1tKQqhHqrpRT9HN2QvRdBR8FH6gPvie5oAMK4hBRwRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n6PjEbyq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jbFJP9CY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n6PjEbyq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jbFJP9CY"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6314H5LU1579948
	for <linux-pm@vger.kernel.org>; Wed, 1 Apr 2026 07:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q4pa+MYOLwL
	+Bi1Cvs+VaLt6dnCZxkjrvO8p8dS1PfM=; b=n6PjEbyq5Cyef+TBt3tPvEIlnnK
	+427v3NTuwh2F7xKSowCGnPyg4tgxMgReq8ha3fjxUYZa1J8XTbP9zcSyNY4yccz
	ltiEJmitb+tjuHAIeHzjvzWx6jyUeGvmI4OemV0UH3NFhzlGehPu2fu4vdzRHq4I
	5scBGqH1RVGkzfQ0ZQmF6fz8HWFnwHv2B6WPh8Le5Uv96Lfr88Vllj3Q0Y+lEZPA
	4Ku7o7YSqp0k16787gGFVz6/ACdbWE7994vgqcdPJVmieTFSTU73ZVyGLOKHypjw
	NnYqEebhK++qRyDdf0u5O8VkvaAg7/dycAm2IGkYptz7LGN7iN1INHYbwUw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8mr2t949-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 07:07:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso10771634a91.2
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 00:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775027279; x=1775632079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q4pa+MYOLwL+Bi1Cvs+VaLt6dnCZxkjrvO8p8dS1PfM=;
        b=jbFJP9CYJU+TpnStcgJCI6bp0sRjKX+Y7wIHNHvXINgoJgefcx6/RTMRqAHPYAdFqM
         DiaiSU6xLWQIEuq47HOZAnhr52N4Xd9se/KjmfDyTSKXTl6zDYdprDNgm8mDfeAUm9ta
         enj8SPADBMQ9EcsEqxbKa7BPYi3wDt755JLaf7H5RtXgMKmdV9iO5DDykJh6tirr2gPI
         +xVIEoJL03CPNDs2N4TXQxZO1PykDKottWCrcfccsPag8CA7XppA8wcayCI2wndv/tX8
         llclxjhLruv4RCECUe54yX+5biYZOKlT8DoZxySaDPfCk5T94HZpe6GpptwJ7wY22Ug8
         nk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027279; x=1775632079;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q4pa+MYOLwL+Bi1Cvs+VaLt6dnCZxkjrvO8p8dS1PfM=;
        b=UgCuRdWcrO1oiYI9XzFfwqO1oYpdXFio8D4LwkmgDLLsxx6yFZiTPc7nmSBEbdoj0g
         XIvVrJgsAZk4Vql/sT4kLfSO+iZ0UsrLb57pevst9pYcUqzurZ6gYxmREWmpsZiChMnI
         5L3U8SFhrqGYAPvW3EzcuZ20UDhHiYDG4rK9EHbQ9njAgbWP6wpyvK0HKGGfP4h4lMjo
         yRGrd0eqlf5yB9R1/J9G97WTJmxGDZheVSVz4B2Jv0ZiOn2+f6loqA1hPJPh2lGl6ueD
         /6Nfwglxakm6UOrtzcWufB2LyTHY5H8meFqfZZC0Z21dsDU5ccV5eq900s0DUlFnz3U1
         xfKA==
X-Forwarded-Encrypted: i=1; AJvYcCU7GiMYz7gcjGPPoCRePhPaDbCm4dMEgO9Vc3I3LFwUZNeDpCkpOBOWsxhD+fP2VzPlwds3G7USew==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWm77jiBX6sBzwr0g96zFnY8oK0RnKkg25yWh3dWOekOPn3jr5
	YTXax209x5/1CkUPDPLIz7DMKNwwZ8HmC7pe9iJ6cEl2pWRcWE5SgO5RAgASO3alCx5LXsakPNZ
	M/sskaZKFdbN9AXqTU3AI0hyzRPo+1SP5mPn3vbLeI9jRBuRKzSCeChSgdljcIIY1948LNA==
X-Gm-Gg: ATEYQzx3vjpDA2xXsnqXUzGEUY1tDkRTUd9u7jK0M2onJGgKnwXrOXwwRurgmYA0k78
	sz4SKkEhzsKDchWTxXFAsuMMLWLmufeMFK00lmo1OEGnVZ3lPByTj2sAG7LBd7KtZzzHh0mxed4
	kJwxVd67mVNk5vcqSZhX8wjxN1nbQDdtjbhtKHHh687pmGwCtulPvIzUq++Lj/qyRWUzTZdkGkg
	wByY6IJEpGFD1FbPDrTNaxitsBPbDPOwu4X7JZM/qjp0QrjqHcywePhR6j948Ulc1GNuJdwByUg
	zWcPeGw9b6W1kvpDWKZW3g9ZU1C4CspMD6PnOFbD/b4a5w6tkbVHmtGzRAfTlCn18io+PyqcD3g
	F/mBYkeTTcXf2EXoo05s0DoqvoXQVZFVtLUNY
X-Received: by 2002:a17:90b:384e:b0:35b:9b77:d7c with SMTP id 98e67ed59e1d1-35dc6f61432mr2270938a91.14.1775027278600;
        Wed, 01 Apr 2026 00:07:58 -0700 (PDT)
X-Received: by 2002:a17:90b:384e:b0:35b:9b77:d7c with SMTP id 98e67ed59e1d1-35dc6f61432mr2270901a91.14.1775027278100;
        Wed, 01 Apr 2026 00:07:58 -0700 (PDT)
Received: from work ([120.60.63.102])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe6e2fc9sm3956464a91.15.2026.04.01.00.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:07:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: brgl@kernel.org, robh@kernel.org
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] power: sequencing: pcie-m2: Guard the helper functions making use of PCI bus notifier
Date: Wed,  1 Apr 2026 12:37:35 +0530
Message-ID: <20260401070735.107162-4-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260401070735.107162-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=B+O0EetM c=1 sm=1 tr=0 ts=69ccc44f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=zTATW481NYPnotdwU90osA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=7-A4b6ptinYaPxXeEqIA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 2a6Gi-8xK6sCoAhjAmOP74SK1J9dB721
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2MSBTYWx0ZWRfX8eGIBR7Et0rZ
 mzaR0Knlc7+AG+vUZrWmhB2hOF46JzT2CBAaWO0TyhgyS2YeyXJCJqGrhR9HPxD2QHf8i/THAIY
 NVeCxmRWDTbTztC7sAa2VnYCdjkpcKyUe+waQFAfuxYidogb98DMEMPmw4Cc1Z3TYtErEZP/wM3
 acH7raH+szn8KKAtDDPRtL4GYHdXiSjRjOkOg/v+IoP0BaIDVexwag8SjiPn9CqE3EDeO+3HYF1
 c/HZi9PJkv/e2OGLxPd8cpCK3FkiVJIyyRWND/7obELXLO/IibXW9mV/9CC8xDFC7R3ZxaaKG2y
 A4J+rq1GWKsgX5OoW5ngZHCpsFklV07i5QFinbQlFWzyN6K6HjMP8Mdg0yJLOVWo4YVk3IRMxhv
 E0cbFhZANUWWra3P1fZhcwes7ivCvgrCzAoDFAAoxFuD8TIQL0Ntyo7ZkL982BySn7bIVU5ZabS
 6nesl2lvTHgZjjXThxg==
X-Proofpoint-GUID: 2a6Gi-8xK6sCoAhjAmOP74SK1J9dB721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010061

The PCI bus notifier is only visible if CONFIG_PCI symbol is selected in
Kconfig. But this driver can be built without CONFIG_PCI due to
CONFIG_COMPILE_TEST, leading to below build error:

   drivers/power/sequencing/pwrseq-pcie-m2.c: In function 'pwrseq_pcie_m2_free_resources':
>> drivers/power/sequencing/pwrseq-pcie-m2.c:185:34: error: 'pci_bus_type' undeclared (first use in this function); did you mean 'pci_pcie_type'?
     185 |         bus_unregister_notifier(&pci_bus_type, &ctx->nb);
         |                                  ^~~~~~~~~~~~
         |                                  pci_pcie_type
   drivers/power/sequencing/pwrseq-pcie-m2.c:185:34: note: each undeclared identifier is reported only once for each function it appears in
   drivers/power/sequencing/pwrseq-pcie-m2.c: In function 'pwrseq_pcie_m2_register_notifier':
   drivers/power/sequencing/pwrseq-pcie-m2.c:340:54: error: 'pci_bus_type' undeclared (first use in this function); did you mean 'pci_pcie_type'?
     340 |                         ret = bus_register_notifier(&pci_bus_type, &ctx->nb);
         |                                                      ^~~~~~~~~~~~
         |                                                      pci_pcie_type

So add guards to make sure that all these helper functions making use of
the PCI bus notifier are only compiled if CONFIG_PCI is selected.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603180609.ucspJefN-lkp@intel.com
Fixes: 3f736aecbdc8 ("power: sequencing: pcie-m2: Create serdev device for WCN7850 bluetooth")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index a75ca4fda2eb..d3102fea8d93 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -177,6 +177,7 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	return PWRSEQ_NO_MATCH;
 }
 
+#if IS_ENABLED(CONFIG_PCI)
 static int pwrseq_m2_pcie_create_bt_node(struct pwrseq_pcie_m2_ctx *ctx,
 					struct device_node *parent)
 {
@@ -374,6 +375,12 @@ static int pwrseq_pcie_m2_register_notifier(struct pwrseq_pcie_m2_ctx *ctx, stru
 
 	return 0;
 }
+#else
+static int pwrseq_pcie_m2_register_notifier(struct pwrseq_pcie_m2_ctx *ctx, struct device *dev)
+{
+	return 0;
+}
+#endif /* CONFIG_PCI */
 
 static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
 {
@@ -452,8 +459,10 @@ static void pwrseq_pcie_m2_remove(struct platform_device *pdev)
 {
 	struct pwrseq_pcie_m2_ctx *ctx = platform_get_drvdata(pdev);
 
+#if IS_ENABLED(CONFIG_PCI)
 	bus_unregister_notifier(&pci_bus_type, &ctx->nb);
 	pwrseq_pcie_m2_remove_serdev(ctx);
+#endif
 
 	regulator_bulk_free(ctx->num_vregs, ctx->regs);
 }
-- 
2.51.0

