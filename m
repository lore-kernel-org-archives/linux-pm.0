Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429542;
	b=TEVDtPAVLEdzeahGl9qy2XxS+zgqaBy7Pp59wvkmU8ORNu3ZUXOlAk8TiqDitDLkJxKw
	 8cvsHykRyEKTptwLxHJQBIImeOoJ5CdkupLEBiM3l8Faox02zSbRV8RoS2IAi4XWTdNb5
	 dryYBv6ZCQPHzGyu87ORJaGSFVxe8x1tzogbhyztEa7RFwhv94aul6phEiYkbGFbpP279
	 y2bhibIOYDpkGbXIlEy+4PyQoDJKt3/48xPYHGChpaj3Wz/GSvXHO7k18jZeB7Gs6hWK6
	 EW83A3Ch965YwSDM2D0DB29o6zwoZtguKI4rkDLu3jKkTzuz799r1Nk2b0520M79s1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429542;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=;
	b=FrzinWiKaAZPDihsQUKFaLfBNrtrq2bVmRW/AHExXEAnSvAJDF1ogpbW0iL5FQLuWd3j
	 DOnsU6OM067ZwKxNhA0oBYez/avCWuhCsyTf9KOP9cawlipW+QCBFScRlp+5VeoYUprDQ
	 IQrxZmEDlxt78Fptg7w08YMFcj1vxpagYAuCVzRebnrspwTKI2QUCvytLJzea80l9byjJ
	 VgtEAeA0iSmkbUj2rwKuGEsGwYQATyThNaxrMBhPMlTWqMbVLfRNaI6aO5e8hYW3Y69td
	 4dBnfdTEdTvGXOfmawvkgFQ81pVJ+BCzHM8s9GoTrCllIyVtf0o/aH8VY16Rg7TCzPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="K/ne0YAD";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A9+YkpNs;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8B6606A693
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8B6606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=K/ne0YAD;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A9+YkpNs
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G9Gx4095756
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=; b=K/ne0YADjHipBOMZ
	09MFX+mU3kfu5RkHbTmdid8Lg6K4HetP/hxZXxzAuPi4W0dRY3DLa7rsZmLR2ERE
	a8uF5xkNBbxMMK/Jwy1c6ckjbi8rs4UjrAo4KCmaE/DiPcnL9wSPn257fTWot4SI
	5/H1Q3xOG3EroJMiTnHkXLmk3iZlrB/3z4OhdCtcWHGgR2Nvd8gOu7mAP7U+CDzk
	xqgJyUYBreB3Mdz9zxBhPSmyVPVEGcDQMJYRSrLC7o/xNVNwljkro9ybdVOlBaPu
	agB08qKosIZITVjww1BLG5pwGeyDbSyX30JfbARFcH7OjRdlXSK7YPrKSJRWJ7a5
	dA2wWQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g740x1c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e92aad34aso569159885a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429539; x=1796034339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=;
        b=A9+YkpNsoC5tGy5F4RyLdncegq3f6j8Wtu/1c9fIjO0jpd/WQEUTshjWo24WaVlUsv
         e8lhj7aBBQOaazwWMPAF5tFkahC33fcETXdP74KIRgw0mk8u8KQ98JV/Lyr9z5CB7nPX
         yTQdp2xAb1LNLhxmZ7jrGlt9rIXfhWriFJVgUS+6Fo7i5tM/Ut1NkzEDp+XxC7DS6Arq
         JxKMCg67XfBifxRDI2ieq4dMwBTQ4WSOXoRh8kMeS+l5UPPCp8CBZUNx/T29xeFkBXJz
         jDQt+EOpEJqmwOYHIIfShibbLr6cjAFjLDx9nd2ooopIglcHB/ujKYr5PBj/po8NKovV
         T+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429539; x=1796034339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2e8ps4JJNpepcw0ywOkVKQ7w3/5wYw/tpOQprpCQl0=;
        b=vRTw22gGmueN86MFF8160UxjfpafyJtJa9J1akkq3LKtjwPO6Ge8OmIXtakT+IEIXT
         WzwK2GFZRxk6emY72VebwY4gaX6ubawlJNd3bGVSKKT9eHj1DpB4nGVM9NC6M9EeBFmh
         poMFQqB59PILFmEILNJv5YwvaUlEV0xSOZqOY5SaIuiVXZ5xTktIJePN5AqtwXJ/LSdv
         wZELNZCbEFYHIOR/7HpBgBgqcjhQKLV/lvGtdfOHeZgdnEujBWSDzEH+SYfLd1s2CgZN
         H6/FsSm5XdE3xTjt/qdQ+MmkjEVNZPn0fT9kbm1/x+BidarQqXkEeOCdcoqS6/WYVVUP
         wO4g==
X-Forwarded-Encrypted: i=1; AL+hErEBsqw7lVcPzmPNwY0ppT//Y6h2bQZ4a1Bb66XFog4d5mo7OEbp3NB/Sj7iqdfo/NrlVPjXxEwWcg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+M2B9VLeRgncSGE0yVsq+j64BUBJOnRBqbiWQcOX+4iYPCRIxN
	/4prksmawzdszvjPxBt39Dc95rnBo+s86t3SF0dQfUXN0ToJwLQWIKSSlVr5TyQNN+WlGZl6ZIC
	mAvHkWORsvDItomEvyAAfWQjMOXpuhJ6vW/GM0Q+ZAolvOw/VJtxJbfVDs6+OQHvii4leMqq6
X-Gm-Gg: AZFdTZd9UOHzw2B2m7GjVFAVbVB5TEdQlZrKf8MMeXjgP9PHRzpD6E/6APS3Ko+mdPU
	wN03NEVNqCF5p9SWoaOM6STV2ZBEdXAWQEoT3glxVuFyX/ittszVKxxTzGDmf6x97wd0M+q0HnZ
	XUs4DAgONariZkoDObosFflmKC2Oq2bcZUVW5WuI9Fym08oVs+l/tksuX2eWE4Twjpibgf8CSYs
	wVuWQwp2tUr2GuOWg3v+49MRqVjrSL0Poxz7CxsF9k+AclXBO8KTJ8mh46U9NnHqbhSdmAaDQIK
	67foIg2p9AFNLt8M/PmZU3SVVUAwkfpEaeHsNeVirQuWHxH+bhfZM6ip6kuH8Ep6lDeVh3P4BT2
	pkOaaBBk9voWi8P9WYisjOrBEEAXCwP/wJd1VYDuP0/5h26XQ9MmolC2Kr94VFAx5c5tCsWUuPL
	3jWpcQnxfT68d7F4MfVNhwrln634Oqt4vm0OKNa7sQUnlWasEb5yNLcjh68FP7l2V7TdDxP45Oe
	AKqWR2bA63Zlt2Gl4yJejts0+Wv
X-Received: by 2002:a05:620a:2856:b0:949:873d:3dbf with SMTP id af79cd13be357-949bab58cebmr1771946785a.59.1795429539490;
        Mon, 23 Nov 2026 02:25:39 -0800 (PST)
X-Received: by 2002:a05:620a:2856:b0:949:873d:3dbf with SMTP id af79cd13be357-949bab58cebmr1771945485a.59.1795429539029;
        Mon, 23 Nov 2026 02:25:39 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:38 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:33 +0100
Subject: [PATCH v8 2/8] Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to
 'bt_en_available'
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
Message-Id: <20261123-monza-wireless-v8-2-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
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
X-Proofpoint-GUID: VWxYirxjCCpYuwSVO6BogJUks9F_wEyp
X-Proofpoint-ORIG-GUID: VWxYirxjCCpYuwSVO6BogJUks9F_wEyp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX67As5rtm4uL5
 Q1U3yVycDqJtxrJcLBBE+lCLpKFqK+JJRpaQ1kKoKExGugEjIZLLBs23axxxD8YnJe71rmSsIL8
 3OsghZzKefTEwaE/r5xe8/xPLqL1fWo=
X-Authority-Analysis: v=2.4 cv=T/cZ3PKQ c=1 sm=1 tr=0 ts=6b0414a4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX+l0cDlsP6amo
 NuJ4YuNhhurlMG52/h2P7DfzKQtpAGz9s3oNxCvq4J+gHYRRpuAVYEANT+N3Jqn2L/sClUV+WcA
 Mdr2wh68YNPjEtzZGYRCK8Dqmn0VhrHx2Ae5IexeTR1DeoagfExNFqoz+nq4VkwGhLu4LD+NOli
 TOaKev7VzGojkweElzsVxmFDHkZSMC9yarBd8tcGt6P8XUGTpFSDvoTCRjiNgCecZ2fuqGkvphu
 UW6bcf7/Mw8is+IbC0GZNVNb3Q343NkAjavU0N/t3zARCrfixyLzZEimK+AyvhzkFUUdhugSd61
 i1awFbTD48MsXJH7KzIBbPqcEdQifUy23zcxNBN2+6P/MVieyTNiyjY3OBzwr/fnlMGusqVQMpQ
 czhjoYx9qEywGPA7eWCDj5+R53OM1cplwwIHvxs6cOqBk7O/+EdLdzXQSYM0/14Zm1Zul4BrbjU
 /jY7rEfl6dotR/FE3dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

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
index 998796ea618822298d7f956a00c6c50f14332363..3b2792a3639cfbd9ee7a781b6e4c26c660495391 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2477,7 +2477,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc_obj(&serdev->dev, *qcadev);
 	if (!qcadev)
@@ -2583,7 +2583,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		     data->soc_type == QCA_QCA2066 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2622,7 +2622,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2640,7 +2640,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

