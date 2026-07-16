Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B070F37BE7E
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218717; cv=none; b=RxBS7rq8/IuYmbPTz+5BunZCpRgTqO8xLHLxyz27s+LG7KOK6FFSC6pK7/Noj9SahJxRejRJtkHIId5p7N+jGYxK8N7PvR8gmRK6ZsOxmUea0mxRhYslIwfwTitzK3LPp9rxjCdU05PB4d5rtt0KNZq9AEPtT+ElinKr/7i5b/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218717; c=relaxed/simple;
	bh=SDP/HXgz4amfEH/BI3vkK16jvRVsmUt0sdawVFBJlw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGLFylqB60ht5NrHTfyaaQOyGrkRFo1X+KJ7EdgaiwGSRqiGRy95aY/bnU7AHu3WVcQ2NDCUWGbeyAHxOfrTpHFLmYXPwnNdwwPqlaAaTZoD1MHjkR+uPg5v7rBip8i3VtfIe3Sm1/dpId4Zs1pl5jK3WD0K1JkCPCZ4+YLGKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AEdaw8EP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XSJmXU+1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AEdaw8EP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XSJmXU+1"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDKKBB2857722
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=; b=AEdaw8EPUB0um5rn
	QvxNivBNe7znLZRvXMtDnqg4K7M/EeM7+28mptmwZ52lT68O4tU3NvYuFaD8TU0t
	cdk/W9RXG/4wbGVYUkPEetDFYJAdXBmPZd2dmkgdhyJQ/FzyuS96LvrErh3nrjAd
	89TVSLvm1TzuueCvM1fpvkzmEzfM+txsnLJfJHx5NN6jDU5KEUbo4U5kW0cGcRbi
	7IuIgQa/6a2/BAoELavwshaDfmXkU/yzFLxCoOFZ5QwlRqF9U+PTRyRYY+RzInoV
	3IqMsl80hi/DrQd6+HnhPJzJxeFlq5dBa29+d7Z2imRpaEQRJSaH5T29AaRfAF/g
	wqRG7A==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex25xk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:30 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8f1e4e0eac1so89774246d6.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218710; x=1784823510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=XSJmXU+1+XC6q9AGKaabnqsxIJGuvAaeUD+kJ6ovWEnVwexcyAeAJrVXMzy36PtzKf
         jbDoFdg734Dv2bgUJ03pEilM2tEGxLRPWpMMchk3pziXxMmmpR4qlqCvJ0f3H+tXxqUE
         AYabgBbtUeVQ8V2RPsEolzPKkF7zUxlDevJqicUkDgv+5PRz6yUqzhbRLsi0bBPAGWyk
         m0ST+zY82w8cndCfLJIFKrlpgDCuB4IqRimsk5+9ewnMWlcWXKptFgxb0q5zrLdnq/ui
         KztbUJESqZ28w/nKQl6z2wo3lJeDPIZlU/vZW2IduqiI1IwGGxaHNm+dJdsOCj523x53
         WRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218710; x=1784823510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPJCmDf+q7ppTTlm3G73k4uw7uFCawMqMX2beUHHwpo=;
        b=AgTgf2vadKgEhXNMKAksEPqKbwUhxEBWP344QWtvgAwILzuLoAW6DJBOc7/Ga9Rfr4
         Q/KsYrFl1MMvCVzgpRTWhgCl68bw3e9i75bKw9jssEj6QFZF5S1St6b0Qi4szyTdl/Of
         SX3IxcFQ2IHDzj9OH56/KlpA9TfbpQ+GdzGybnXWg2gc+qIvh12dBFqcml+pt1uckdV4
         aVOTsbdxcur9vZRhCWuQwW5iM26GZYyCHxfYTQRzLY82DQtA2ltihO/znhpgzTHdmwTQ
         Zegw6uNe7ZtgFfVTmV4wccQGDA24skjw7stJkG4ykwZU9t68ebrwRiFlIOT21aQgZW6B
         b2ew==
X-Forwarded-Encrypted: i=1; AHgh+Rp4DCdP3TucYI/7zsO7aRfLt4f9+H93UqdA2WqbeS1JT/dWKuW3MnG7UZ6qfCEgs8LDgKZ6fH9I5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/JN/7ORwAvQi/ECA2aJLTprfOpj63i/m8mNyklH5QUEueEtuJ
	hFjJlv8jPMg6XV7bFxDgrrXFKLXAHIDFSgXuhWGx4CgXs9iUghDKPhZgI5f2pjaHCEmvQmyM2Qi
	e6pDwiFXFdKqg9p3ZkT7Yj01/VkaS2UhluxIoh24ro/sejGMDqn1UdvRLDoPsug==
X-Gm-Gg: AfdE7cnN+uffmWMhE/PIxaaAd9sXZStn3aXV+poHgimYXdMflC18fh/5uuwTte1IgjP
	46OeuoMj2+5oJfIoFZUSMJYPVvFQtYuAS+P42Kyw8bIRSQoGMOMxzxtUp6Zckmd8IdYNZpt/kTK
	yMbCB5NeMltCzFA8eEA2zSORvhhz/qdhtasCzUEkPVI8KE1SlifGePrveCytMBEcOOTJY+LCuV8
	9Xr59BiE6Uh+bxWrrkHbKJCrTArmRucjn3OCSlP3EbVxt+/jxJUh8asuk5hg3hgNlTJMo2wJeyj
	cZFMbDB5uDe8htj6CrHK2t0KOtz7/EIw4nZ6R9il5VjSW5yl4B4241vXN+91L1BZahBYRT6Svpc
	+E+kiOuxzwDeLl9//Dl1vyBU1JLD29I/kkq72d0GLCEmsQ91JU2u/gyVwuwVsQO81GLbUa8TFAo
	aWAGd0C91rfgEhkhny7LLsfe0lFUm+5UuNEQQOIxwxqgocgNS18Fw=
X-Received: by 2002:a05:622a:2c8:b0:50d:e471:2d1e with SMTP id d75a77b69052e-51e4239fd84mr117366411cf.35.1784218708867;
        Thu, 16 Jul 2026 09:18:28 -0700 (PDT)
X-Received: by 2002:a05:622a:2c8:b0:50d:e471:2d1e with SMTP id d75a77b69052e-51e4239fd84mr117364701cf.35.1784218706689;
        Thu, 16 Jul 2026 09:18:26 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:25 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:19 +0200
Subject: [PATCH v4 02/11] Bluetooth: hci_qca: Rename 'power_ctrl_enabled'
 to 'bt_en_available'
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-2-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a590456 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: n8E5TpFdKo4Q_1kGTCq3eeERmgExrlr6
X-Proofpoint-GUID: n8E5TpFdKo4Q_1kGTCq3eeERmgExrlr6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX3txqkg4JTtlJ
 z5SwaUZ3EZQlkd6LvKnFr41v0FGEswzzq9Xk5OztdyK70c6OGrnGgPpdmFD6HjtgmaJQxIOcGNC
 hYy4sat+CpyLFgXSi+OGRaxb4H4HjOg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX5IJ7jUcwckLY
 fXifv+0IiqWwNYeagACx+nvdcUz6RUGAUzL4i+jRYZLBeLsYwZNwEuNfVqUtrENDVeFEvcTYNUw
 GWW38JpbEq3vZzGltTzryRdLLC68hMtXY1+hxw9WbIqq8EWXW0wihGHgtGhvtlZ5aABEv6yy958
 ySVpnuMBY+b/T5VVPZDvkel4P9Q9EqAd6IEdF5UprE72uhjSlm5OASV4TR2YUh2Y+OHHs1Fnt18
 gk+BGOIkUXYYsG89XDY55PqS5StYMosWrKSO8JMp8SFCxpXT4CGbNPgYyLK1PPfpBTJ/xIXeMPN
 t1ot0yetLDpwGbQYDzdLaI4rUMmRAN/N2nnOcr35Y42CuYXGHs8ckJ4+7Ar5vqRuFNyVcKas0zN
 8vM37y/2Lj/HDJ21lbuIwt1Eq90mFvoL9AV0cnHIASc3VxlrWJ3orc+t30Orwhrn/oJcahk73O8
 8lNXVzyeFMjgIuSfpnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
GPIO in devicetree. But the naming causes confusion with the new pwrctrl
framework.

So rename it to 'bt_en_available' to make it clear and explicit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 135c79e696aefe2b37ee7a7a668715360a1e2d75..17f436484e1e74d1dd690ada22134315abb767c4 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2393,7 +2393,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
@@ -2501,7 +2501,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2539,7 +2539,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2557,7 +2557,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

