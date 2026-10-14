Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164354DEC37
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980442; cv=none; b=F7DO1j0k57dklQL4g7jyop/GRVliU/oakI7Ua7RBDmgWXTgai+sRo8Wh5bj14SjNdzqVTD0d2V0HbO20PkBiP8vlEoc1puiVP8MM4OjUGuRq39BkKyuoT0RCWZ5DCs7+2kp6BqEvVrgitJnPhzlcveIbqYYm6BLO44uaeYHBiSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980442; c=relaxed/simple;
	bh=kfe7AQUjcgxqMerSvSrm0wWjjc5znWm2MIo1Blj65NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVJd/PXZl/fSEOTKXa+N9m1oPQhXSpJiSPUh2S21yCf8kxApW5wW7i25mvmVxaD2HL5gvpJKFmUdI5Kbm1Z6sQ9YtOV0UixzcqXaZvGUI4hPsp9cybFlLpHm41oYVPxFM5R6klQN2VRjRtupdBprhaGJ5PVJbkfyU7nfY7m9ciY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B5gWFgDe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JxCJIY7T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B5gWFgDe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JxCJIY7T"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EBbMl62685304
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=44sZRo6phuC
	pNqvY/lRU//FjOtdGeGZ6toXsQ2QEZt0=; b=B5gWFgDeQ4+wLyhPz4f5osSwHdH
	hcqMerSZq15Wj3KkXcZzs3s9expSEUAvbLzQrJ+4CYtOIWH6tYQrCIMper90gfvi
	nthH68+6s0Vnpm/hmsDsY2H0zQ09p9pOb7uVRp5yRlBikNQIeGEf6TpOwLRYEC4Y
	4aosm+Tt622QiJRUan0eRTH3qOuCTCtfv+gOnwup2OTfLU8SiKzAJG+I00JKRsXA
	s5GfGP2nVWS29EeNO7M4cPWKigErpZTd9wtkJZn48ZUKv6fMttt798FXQ50cpxB3
	s2e3uzS0K6MfdbsW/GACbopJTG7Ylnv5UmsCt6RChg4mXd3X8XvLfvUiFLg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha46u1fxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:20:40 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd5fd02ee26so591763a12.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791980439; x=1792585239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44sZRo6phuCpNqvY/lRU//FjOtdGeGZ6toXsQ2QEZt0=;
        b=JxCJIY7TqDySG7yINqxYVKMdtorjzHX3A+xM6hr8oR6ApfcNy0XhPn2A27JtTJfNeR
         w6c/4yQaWsJNd5XeQra9RnnKAINlvANCnHBfFxuE+e3GBFKF5LWmqAM+bXT+xB2ihQFc
         l2jRTmuUSBD3BaR6FEBf/Yz5FRPcOp7GamUrStcmiKjBXeuIQwD8Mh9Fo7d67STa1lhG
         hQooEBvcbWscIIZE5LWUfNMBqXXkyXeUBjH5MrZf9fr4I6Z9ZWIdhT1dXImut+sdm2s6
         Qw2RC7OPz7di0vNqS4IxeCCi6IqwE8E7jEUjGZ+i6/mPyQVoAzPyUaDhdCyvSauYZr5F
         9Z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980439; x=1792585239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=44sZRo6phuCpNqvY/lRU//FjOtdGeGZ6toXsQ2QEZt0=;
        b=AoMg2tpl48IWEF0n1FQ/MtwU3ch+fRXqplIN64ayUZ+4UShIEhknAXekUxV58NLv5J
         be9UBnm99gr9Jv5DrR3kJFHql8EgYAlF6BuhpiVehs9jF9vuE2LPv/IajkAS4aNP2XIC
         rf80gBanA78PdVLlibPVcoMMRKWcPzIv47JiGTsLhaQbXeh8aKUBQJ8idEVzmUsHRiIx
         EjF4i42eRQCGa2rXY2T9CpWS1YyRJ14tbCSL4k/aPOZTxXO6nzU3XuUAMChuVYYGyYJs
         zeqUXHmf3p0MDAqFyk3Kzt6oGh4qBlQyMWY7PpSgV6/pRPaW3B97Y9cDENcnAwNHzien
         zeOA==
X-Forwarded-Encrypted: i=1; AKwUvBxhn1pCnov2QKxzG5GXIRDkArwj6kuLqpuxgl4ctbn3uNPITYlp7rE9aU1Q3TWR18iqFOzfgNsk7Q==@vger.kernel.org
X-Gm-Message-State: AFq9FYJHeW834o1KNLg0LY+XsKgEF2VBDYwSLR9LkEJqdA43wNPWNokH
	Pvm5qn0PjFi0QPXjr3y2DUbqVLuE/xsybvQFQEXTeKMBUpZcaKdCGdb6ZZ1ybA/1sGXMEddZbL0
	SMfe1psDtleEzehATEqAibEn7sCRWSjsJm+OWuTfslneubHApxIIrb84pNQPFHw==
X-Gm-Gg: AYBFou2zRhlXhzIX85jxx9FHYmyqrJFk82zpOjppfK6N/DF28lUjNLDrJ4zU98BXmDf
	wtqmqnDx81XQmVBbe+wSllLuaj/h/nVcxk4n0cyZXWA0RU867N34A1Gn2uu5g/v5lGeIVNNHJFJ
	gNbsGs4XbPzGGNEDCX+rwT14QfILhqUiezBuvWq2sPkyq8C7qK4/k8dE9tVizxXuo9Qi6xzp2N2
	Exz7qfBUyQDY7mDGjfSJq6WVOZfp4wpqxZrHWUmjHWKlUCGzlS75mmxQRWB6XK8hVWWzfiFJLQt
	tU/ncqOcQhAF5I9704xNnWMNDSBJzfCInmHKTlxQC9zGkEKZH9KiF43+L90QP3zKSfBVNSk7O7u
	HcHP6gR+L8XxXpf6ocbjTWhLPuvCC
X-Received: by 2002:a05:6a20:734c:b0:3df:15f4:756e with SMTP id adf61e73a8af0-3e16bd0ab2dmr21543820637.1.1791980439506;
        Wed, 14 Oct 2026 05:20:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:734c:b0:3df:15f4:756e with SMTP id adf61e73a8af0-3e16bd0ab2dmr21543762637.1.1791980439031;
        Wed, 14 Oct 2026 05:20:39 -0700 (PDT)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d804ec645sm1016990b3a.43.2026.10.14.05.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:20:38 -0700 (PDT)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [RFC PATCH 2/3] power: sequencing: qcom-wcn: support SW_CTRL wake IRQ
Date: Wed, 14 Oct 2026 20:19:09 +0800
Message-ID: <20261014121910.1509541-3-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfX7rqBJAtD0w/E
 Fy6PhB5eHupdJH77nxq+yTjBSUpH8IKTBuNjisydcpPQGAAfNJr5W8UyXeGbcVSO9ND9f5y7M5+
 htAEuHbbFaSj5794rGp+XYCSDPxk8FA=
X-Proofpoint-GUID: g6je3ueg3HJWuxIaHdk8x5K9q-LPsRNq
X-Authority-Analysis: v=2.4 cv=Y6ttIReN c=1 sm=1 tr=0 ts=6acf7398 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=7e_bQlA4RtQnbCSGg-kA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0OSBTYWx0ZWRfX+KS1ZgbICagZ
 heltybnp72bMihMMyJNaxKtdtP553jRcerJx/Qc5h1H/YSI0FfruNRL+FLBbQSMloK813Vs3UGt
 Qk/Jj3cDZ1PQoq4SL5K7o3yqV2DT7yIAk0uZX91yYTLBdZEm0BuK8bI0sUZFXwI3NTwAowpwP4j
 /ShhiWRVHSh9G18DvDo3D1FzAnuyVwJPXKDgq6HUaDYMJ1DQo9ssvMFfy+E3Hb7XpHf4psefig2
 2STcK9v2nzNZOOqj9l20f6Uu+re8IH5ZxZXEjO21NKLrL4++bqmkSQTO5olXxzQhj95WFTX4XQ+
 gd6pYm0S0uf+wyovdnYFXiCue04XpUs8oYUIIw5hu3xrWbMd68D2WemSSSWwboCUfb2GjjXLBgy
 MjrHa0kOVflFWwo1o0h/b9JLcfyOZ+fb/fFSw+J6hg5aeTf7ZfMno3GVD/D9S8euJRi3LfG7utk
 IRrSGu1s/KmVFmz41KA==
X-Proofpoint-ORIG-GUID: g6je3ueg3HJWuxIaHdk8x5K9q-LPsRNq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140049

Some WCN3990-family designs route SW_CTRL to an interrupt capable of
waking the application processor. Requesting the IRQ resource also enables
the Qualcomm TLMM power-save wakeup path when WAKEUP_PRESENT is advertised.

When the PMU is marked as a wakeup source, retrieve the dedicated "wakeup"
interrupt and register it as a dedicated wake IRQ. Keep it disabled during
normal operation and let the PM core arm it for system suspend.

Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 30 ++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index d41793e1fcd..e052187ffb9 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -11,6 +11,8 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/pm_wakeup.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pwrseq/provider.h>
@@ -454,11 +456,17 @@ static int pwrseq_qcom_wcn3990_match(struct pwrseq_device *pwrseq,
 	return pwrseq_qcom_wcn_match_regulator(pwrseq, dev, "vdd-1.8-xo-supply");
 }
 
+static void pwrseq_qcom_wcn_clear_wake_irq(void *data)
+{
+	dev_pm_clear_wake_irq(data);
+}
+
 static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct pwrseq_qcom_wcn_ctx *ctx;
 	struct pwrseq_config config;
+	int wake_irq;
 	int i, ret;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
@@ -496,6 +504,28 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(ctx->bt_gpio),
 				     "Failed to get the Bluetooth enable GPIO\n");
 
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		wake_irq = platform_get_irq_byname(pdev, "wakeup");
+		if (wake_irq < 0)
+			return dev_err_probe(dev, wake_irq,
+					     "Failed to get the SW_CTRL wake IRQ\n");
+
+		ret = devm_device_init_wakeup(dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to enable wakeup\n");
+
+		ret = dev_pm_set_dedicated_wake_irq(dev, wake_irq);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to set the SW_CTRL wake IRQ\n");
+
+		ret = devm_add_action_or_reset(dev,
+					       pwrseq_qcom_wcn_clear_wake_irq, dev);
+		if (ret)
+			return ret;
+	}
+
 	/*
 	 * FIXME: This should actually be GPIOD_OUT_LOW, but doing so would
 	 * cause the WLAN power to be toggled, resulting in PCIe link down.
-- 
2.43.0

