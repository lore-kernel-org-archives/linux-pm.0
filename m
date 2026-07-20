Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991D72F549F
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534668; cv=none; b=e8xhy+YbojvEOCDSmU9rWXRxvOJJd2CC/olXDIm8QDxhGn0Nn83siZ2JEliNEUtjZqBv8qAaGHpJ4U/tLyoaLuQ2t4l5KHtywSB6Sd9JOu4HjLqu/jtMyjA/o0N+QR5zk3pbnXTXdoVAFsUw+VHlzTYOp3u72U80JoNNHr+XOYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534668; c=relaxed/simple;
	bh=U8KvuwhbRpvu6yox7283/96nA65nj+Pg5RSb19E+fVU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AIwbuA3M7ybfK5Kw1orEeWR2bNVSVMOWG1spCv+nqraPMrs8bdCeVCFr2oXw58wCPl3cQER+A7mxnj+Emak/cibPCcCoG653ymAvVwRzhPYz6IP3yPmhU+QJ+GMrmByb2VfWTDsQG1UXhx3Fg1H6fdc3YLeM6Xh2ukieh3Gp0mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SEW7l6PN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RaVBE1eJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SEW7l6PN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RaVBE1eJ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K6RgRR1774812
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NlR6oxj2RqcNvssqISSxd1MdkBoRpFWAjkKBrBG/ulw=; b=SEW7l6PNW4mzQ8Fz
	LMfkWiQQX+926LWkPHT9O40TIIhZ0FaQ+GMiOJTrA1/r7s3wAkURYbmKBT9QtcWX
	Dhl686U6TSQcNEHw7apYtL86ChI41II2DboJI0QujoN6fy517Y8j5HPrgPJ+SF7c
	6YxnZ9bIQ7gMKeoDIVLRXm5QB+Ujk5rCugEfIObx1c+N8AsMK+n5BhSxKS3LTYyE
	h5+Ihivtt/h/Uvl/pIRi9PFQNXMMCSZPziM7aTtDr6ALKBgEVo2EHnzJ7OBbmGeC
	QMkzSSE/W0QNkBd2aOSGcpbq9Hratd2dIczYQ0TEidO3K820YERZABSvm6hEp9Gn
	53UO8A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2af536k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:25 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1852a86fso138717161cf.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534664; x=1785139464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NlR6oxj2RqcNvssqISSxd1MdkBoRpFWAjkKBrBG/ulw=;
        b=RaVBE1eJ1H0C7QjxoUIUpZx3FvkGbedSucrBCIQFoORflrFLm2MB8UTmrCu1AqxLLI
         MsBtiuzPDxwevfKwKGeg+n2/WT392J5fd7Eq7dcpWm9F1/huNMcvFKY2cEiv8BzOwPBd
         TKzQ+v71oxukMVvlAJO/5oDIxTcl7bHPcI13EueqmbeKapn/JsybdhlvmerPYXrDZJKm
         5QLvKIqBZmMKHxG56BBLztnMCWdPD8zosEHAh4aFZDQupDrcRUN8BpyeJjR3wtM/AXNQ
         yguUYDI2V0r7RE8Loy0XA41JIeKB1eChmlxmSiiiQQxerwQskItCrrf4GLYmzvbgpBHT
         Zmow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534664; x=1785139464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NlR6oxj2RqcNvssqISSxd1MdkBoRpFWAjkKBrBG/ulw=;
        b=s3XgPgNwsvR2YwFkQBM8wz2SosXv1Sg4G9rWJXqiJSddzD9CBSzWhXNXDsg8K59+W4
         Bxa3enaOaPF/Umbi2yyeoCs1fOiUo3tCyh1Dk6ON5+kmNQb5bhB54j2WntH9wn639DVX
         ox3fxvNeQ0+tas+KeLW7Uh+g0h665LgXyuuLAG514wwfq2v6yUFNpNW9tGOTxYf+s4ft
         sTScQ0XoZY+Ue7nmJzcrMNyFQkKf5wUcoJEN6tbgSu/fHLci3MRuOXYbV53NkwxJNp5B
         50zZqySlg4+mA3pp9cLPbuBOUOibbQkDBE07hcKe38FmTKGU29ZuDYfvh/eqL005XUDG
         pRtg==
X-Forwarded-Encrypted: i=1; AHgh+RrSBEuCQByev0pmzOZ6lPjnAgnLu9R0/ImRZ2nXji8i2uJE8sgW3m8+H/Pu2X49N4EdDt4AEzXM8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzviXCrW2bwnYQkNyMGmduxKAlilxKQ9CqXuBQVjcouc9E9KHqp
	TwUq9/E4IDHucLcKtQyUkbPO4NS2T9fcVLJUEuAe3Jd9GiVYTGOGbuA25RKxiwXQ+Y1+IDzfk/i
	GFVPjMWdYGeZ3KH3x02gUo7zLBr/0DOh2si6ZXnvEUeyXTfGvutO/tB21QDBAuQ==
X-Gm-Gg: AfdE7cmNh6ZyIffnQ0u5JoWo17Vd3l7WRZu+LXS1AYgASp1S4RyRJy3lES5DloDF+FJ
	hZdU+AGqab389DFis4lCnKYO4FGYevl0JUtXVY5Swox4zocGXlTV1BueBuVqO+avD+7adXSWZiE
	DdNXKy6B7Pl0fK0t8MLcFQtJ7kXEjtJsOrYYWP81u2BrrN3A/QiAjjLN2VSQ0s3/4tq/RJDkJj6
	px5IqXGAF8ZIVwr79sCvmtlQR1kHmkPg/jmtIUgQAofvkCKr6150Y5/qg0t8tKba6LLhJNMhcfB
	yK0H8yvy93qE/wda+X6NOghEDVE34uFmzbZqgtBMdrlPAy9+bqqwdjl+VD9kOfQomMzHyFa3sy5
	guYA0hkEoBT7A7eQCGfqXnlW8enqhSkR28U+6wdZ49sAiy7PXTG4e/vUImJadq8JpwcJgcjKBII
	qKrlyTBqs+9Nv8zI8mMV4dn1v16heaPpUMxVaeExlRIOv4XkoABi4=
X-Received: by 2002:ac8:7d0c:0:b0:51c:7b12:5fdd with SMTP id d75a77b69052e-5213ed77366mr122378931cf.73.1784534664226;
        Mon, 20 Jul 2026 01:04:24 -0700 (PDT)
X-Received: by 2002:ac8:7d0c:0:b0:51c:7b12:5fdd with SMTP id d75a77b69052e-5213ed77366mr122378671cf.73.1784534663794;
        Mon, 20 Jul 2026 01:04:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:22 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:10 +0200
Subject: [PATCH v5 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-8-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX+4JVpxly88Xb
 vm3uD+jzGxi1qYPBrhzghXoOZ4riPimjvsH1PMwCdabFaf9bQnF8gwupxoe1FVaCuosTQnL+i+y
 kIdtgAPgJ0RfNW/HnXlfcYbkjazkimM=
X-Proofpoint-GUID: BY1HWeZzj7ARjJ8yAQ3FhPLQ47I16_pF
X-Proofpoint-ORIG-GUID: BY1HWeZzj7ARjJ8yAQ3FhPLQ47I16_pF
X-Authority-Analysis: v=2.4 cv=a+sAM0SF c=1 sm=1 tr=0 ts=6a5dd689 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=reVw4oyKNVL6WbIJD7YA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXxanP4CLHLPm5
 Wt8Am4u7GBwvN8gMkEWypEmDi6F+bdTng1RAjHDJQzvMsAyG/zvwTU2PffdPiPy299MG1+WF3J7
 PvHkTCifvncXGEO/yr55dkRwdStH427DaNB01Grzk20tmBYEXch4sh1eujOCEcblZtXw5pihWg+
 3TIWqWsImXQwOv8g06/oxu0LeoXHNfuEqJrAWwR+OF5Uc9749UfV/dhZ5MIPeEqfvI2TDXRZC4P
 gSx4BWiE8P1qEYLFBR8NacfRufGMHQpstR6CZvfIWLo0BrV9xf8NDCjTzbbJjRJ8p8CASOyTIYz
 iZOH+5JsaPnpUHwX74xPXGnOJfWKEnQMpqi69B/k1teP8J05J49p4V1rGy2mG8bFrbTN5QbjnA0
 6+uvXt1/BXLKGi0Y4cSsWp/0EJbeE7Bhm6lUWbGOp20oacyniTEX4lJiXpubKAmps42U4BzjYCu
 3fIADPSzpbYdZFOfS+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected to
an M.2 connector), acquire the 'uart' pwrseq target from the connector's
power sequencer and use it to control BT power instead of the bt-enable
GPIO. This is factored out into qca_serdev_get_m2_pwrseq().

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 47 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7e4cb03d3db0722e5f9fa2e7a5a9a0894bf4f18c..8496bd428602c48d093bc76f9810abb9b1c43cfa 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power.pwrseq)
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2387,6 +2390,34 @@ static int qca_init_regulators(struct qca_power *qca,
 	return 0;
 }
 
+static void qca_serdev_put_pwrseq(void *data)
+{
+	pwrseq_put(data);
+}
+
+static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
+{
+	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
+	struct pwrseq_desc *pwrseq;
+
+	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
+		return 0;
+
+	/* The pwrseq is looked up on the serdev controller (which holds the
+	 * OF graph to the M.2 connector), but its lifetime must follow this
+	 * serdev consumer device, not the controller. So acquire it with the
+	 * non-devres pwrseq_get() and release it via a devres action bound to
+	 * &serdev->dev instead of using devm_pwrseq_get(&serdev->ctrl->dev).
+	 */
+	pwrseq = pwrseq_get(&serdev->ctrl->dev, "uart");
+	if (IS_ERR(pwrseq))
+		return PTR_ERR(pwrseq);
+
+	qcadev->bt_power.pwrseq = pwrseq;
+
+	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
+}
+
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
@@ -2417,6 +2448,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2426,17 +2461,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		/*
-		 * OF graph link is only present for BT devices attached through
-		 * the M.2 Key E connector.
-		 */
-		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
-								  "uart");
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				return PTR_ERR(qcadev->bt_power.pwrseq);
+		/* M.2 connector modules are powered by the pwrseq acquired above. */
+		if (qcadev->bt_power.pwrseq)
 			break;
-		}
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*

-- 
2.34.1

