Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1F481AA1
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 12:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202917; cv=none; b=EttVVPt8cscV4K8L75+Ma3WYkmSWP5meDZkYrWHculzxYTMVOh/yRegRjaRjWY/2LF1i08+nQb27eK9ZcF0TM6YU7U1DtWDoCAigXimH3krebJ9OibTDpcRbO54j1D2JLyCrQ+En7l4b794/T4a7UQ4w+FL9QiJ0PZLViCmceQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202917; c=relaxed/simple;
	bh=ENUkgfTLoGSU62yU+ODXLM++GYZz3DSTZhKUOe4vKLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E1hTx85z0kAqLzY3N1C19vRoHn+M2ZChLjLM/urFoVSfMBH2a1afuJQqcTwrVnDh5NEpuCQxs+7mpT2XBEBg/fhuQncc8u1LfDSTyYZMKx1291xN5a9Qhr+Azn7keIC6wPLqmXP0xMgP20uzXbhGQKu+VK4IfjUrVTKA2EPLS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BVKtV+iL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OD9Atj5n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BVKtV+iL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OD9Atj5n"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFSMc1294976
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 12:21:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j1J11ckuq5L3HohBW9mX7gxzlO47Pb4MpwXhFW82VGg=; b=BVKtV+iL1cIP0eQ+
	AgJnSG8XDKV2nH6OOYJc5jPhETEL8hLynze5+v6DFil4aO/fsyxBOBWwLp8eJw0E
	d9lumsnpxQJaGiL6mQ7/in2TyEiLI+xOi3BV14xwXtn1QOvGDJWKZydTo0PaM4gK
	UGCMBnFbNaXR6/Vy1fVm8lkWSD1ymaWK46R3jIfMtXwCAZK70/z5yrRhvOTQjbfx
	AqCrrl387NTzFJOoPuDYOTBGNPXWkZafmQ8XuDEjJ+lCjSzRza0jsZ5D9BoBJT3M
	142ZBcFRBfc0eoHYFMCC2hbi6zwtf0Yb5Ia4tpWJRSxABrj8hlXp6NHy6V5WzNnT
	Fa7QHQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h41gn9qpq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 12:21:53 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-98331b577e4so1091609241.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202913; x=1791807713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1J11ckuq5L3HohBW9mX7gxzlO47Pb4MpwXhFW82VGg=;
        b=OD9Atj5nriEn9MGrQLyH6ZGkgAaItdOJnQGNYxMbePePESzkMhEZBrBGkH857mUTvG
         vtYYxLhyFDdyTCOCLM/6ZJnNCBoVGPYwi6EG6Qa8EnucDbNy/JNmNe5o169qJgQyv95G
         uEudF0BUHCvJCSckV0K+nD9+sD/oPyfLfCeKEeRj+Da82wEcKDYmw5Dgsl9inxPlBLAP
         WhFkTEf9MN3NrhsuLczyvNIaCXeZx6atCIWyiQZildDUGYQeUsEDiverJRuzl+Yd5cxI
         JvknjjDRPG59zF1vTyax+oKv+hXO0TGK4Tpt29O/Y5xM6awn0k29vH7oL/eMarIDckcU
         IVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202913; x=1791807713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1J11ckuq5L3HohBW9mX7gxzlO47Pb4MpwXhFW82VGg=;
        b=EUxBAyzrRSwC/vfP7bOh0cbjAO4Rm+YWc/fH6kv9q+ugYHwkoJrcGrW03Jp5IXvAij
         NtQCWP0IB0qixI8H0RPOZO2IZe/0tJtSVgdhF1W2kZwhlmG27vYrGCaENKYQ2JiakuBO
         sejgUTwMuxkPPi/3KRF0e+dKiNLkXnf3sAV8Oh25pG45qbMtmTQgDX108JJufsjP9HB9
         LFk87XVAeT4hoOwBwJFk+773Af7m1Ic+HwoPrS8tUJBdMChvMmycHbCFa/ljQu+VwPqJ
         ODCQZ6KzMrdp/p5ZfE1nS2c3VvYXXbiqDngydKr4Sqh+Fkbbojfw0xhcXk/dM5YYWolV
         O+NQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdEMSx0Q66cvo83xTEU4iWJlhr/N7Tu6ucyVR+5A4Qtm8p/JiTJCJZjus7OpDxD59ipu0YaBHPIA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLTd0wpIAH5UWhu7RdXmcW6CCNOhlRo1Vj/QS6JKP92WWAVYDUQ
	lE4PqQEWuIH6JBCmumNId5CTBIh6lKV9H27eGaOSVk5siiOJ1Zi7uneVsXk7oJUOw63bLhSRND+
	6yVWkCiAjNC+5+xIBRlxrjjhAFn/GSSOfvu5vhnCScIwAqcOzmW3sKxknN3fmbg==
X-Gm-Gg: AYBFou364rT83yGThTolLjz2RVRULLHbY86r8GmaSqxqQG4D00k5z/jp6rTWqcISwXQ
	4CLQqtQwZtAIWz/xcECJm4BXXzR0UdHQILUiXE2cgOuRge6IlZNnX7Emix2uQhQo4ILf/zc17Q8
	eLHeNp4bV82bUxpibxbN9vPuqsveUEptOotD7ksDI5f8euwluxF+a6DRhPEZkLATGTwrsBccrU+
	7ufh/1M/vzpoC2aGrhkDwDjEP2xVmlmdvh/hxkELa9sHpQB32EVZ96zicXy34p/pZeBAqGJhUaL
	4W4uxH0wVPkQMAl5PcElSdxMtqbA0KeSixmyIs/E9dpJz/2VBTCzHf2Le8APakUrDHc5U49KPEn
	PHxgVlXAcR6fzzzxchIpf9FnQZcR0HfC6vPjyGwpfM+FRiicZgw7xGIQlJQ2Mg8awjkqx+uVp40
	sm9OA99Pg+M1E0kjm5E0DMUjQDtvrwWhiu4vdej4dmNOMPptHHSPRjQRvRg3v4opdht67PSQ==
X-Received: by 2002:a05:6102:d89:b0:7a6:b18e:6d24 with SMTP id ada2fe7eead31-7c0f4b9b65dmr2855201137.23.1791202912498;
        Mon, 05 Oct 2026 05:21:52 -0700 (PDT)
X-Received: by 2002:a05:6102:d89:b0:7a6:b18e:6d24 with SMTP id ada2fe7eead31-7c0f4b9b65dmr2855183137.23.1791202911964;
        Mon, 05 Oct 2026 05:21:51 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:51 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:34 +0200
Subject: [PATCH v7 4/8] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-4-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
In-Reply-To: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: MQTx0VFSU_I356pZsSdrn-aDDujxRBuE
X-Proofpoint-GUID: MQTx0VFSU_I356pZsSdrn-aDDujxRBuE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfXzkfGXIjdvfKR
 OS/DagybinovKo5GwA9I68LZ4hPLBNdEOfWljTz7lO228BjhKQ95Ubwhp5GjnCujRwYlZZ1fgAU
 S3TaNkmx22LNb5lHCoB7adwu+esJ42V7RVH7pw4n8TWy3bLDMznq010sNZfx9wb5WDNeZmFR8Ww
 mO1jNnYuOX7GZ/gBcH+ubQRKvpg46dr+w8W9tRlWyK+llQqyLUnp3gg04krByLWy5/FKR+5iFdn
 mtacSxOGQwckV6wcwHqF2P6SvJHLQWIC7bi7YTdFgNk3RBWyGgEqIh4cbKZqeNKlng3ptWU+/dn
 z6+vVsUWt6/OcoLgaONtZip5u5vUwkD1yonECDDgeHJOOJ/f+M9hklyZwWorynLwVDN7UTG8qs+
 qQIzQEPsAZGxiP3U9nG6OSPftYwrQ8n6df2xCYRf7VvHnWDpfl0OnHnj8eeTSf7EFFkFUaFEwOh
 9fyRr2MyQph05ajPdVA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX16cj+yOqAzQI
 76Se6MUMId8OqcL55Lh0pkj4Cj0mzxaxVoXrndViEciFSxAfxWokpscyBxcjLio2sO6lgXxq8RP
 54q5BmZZSFCsIznJNmkCvKrbAJNheQs=
X-Authority-Analysis: v=2.4 cv=P9WvFSAu c=1 sm=1 tr=0 ts=6ac39661 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=9HiflFjrvY0K7w4qUiwA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

'bt_power' is allocated dynamically only for a subset of SOC types, using a
switch on the SOC type that mirrors the one that follows it. This is about
to become pointless as the power sequencer path (used by M.2 modules) is
independent of the SOC type and needs 'bt_power' populated for any type.

Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
allocating it separately. This drops the extra allocation and its dedicated
SOC-type switch, and removes the need for NULL checks on the pointer.

No functional change intended.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 20d8c5e890a8903a07c3e7e37d037c44d383e8df..1d27ff98034ba99d0783e48db5c605f3b31117ea 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -225,7 +225,7 @@ struct qca_serdev {
 	struct gpio_desc *sw_ctrl;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
-	struct qca_power *bt_power;
+	struct qca_power bt_power;
 	u32 init_speed;
 	u32 oper_speed;
 	bool bdaddr_property_broken;
@@ -1779,7 +1779,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power->vregs_on) {
+	if (!qcadev->bt_power.vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -2245,7 +2245,7 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2265,7 +2265,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power && power->pwrseq) {
+	if (power->pwrseq) {
 		pwrseq_disable(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
@@ -2322,7 +2322,7 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
 	if (power->pwrseq)
@@ -2354,7 +2354,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
 	if (!qcadev)
 		return;
 
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	/* Already disabled? */
 	if (!power->vregs_on)
@@ -2426,26 +2426,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
-	switch (qcadev->btsoc_type) {
-	case QCA_QCA6390:
-	case QCA_WCN3950:
-	case QCA_WCN3988:
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
-	case QCA_WCN6750:
-	case QCA_WCN6855:
-	case QCA_WCN7850:
-		qcadev->bt_power = devm_kzalloc(&serdev->dev,
-						sizeof(struct qca_power),
-						GFP_KERNEL);
-		if (!qcadev->bt_power)
-			return -ENOMEM;
-		break;
-	default:
-		break;
-	}
-
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2460,10 +2440,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		 * the M.2 Key E connector.
 		 */
 		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
-								   "uart");
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				return PTR_ERR(qcadev->bt_power->pwrseq);
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
+								  "uart");
+			if (IS_ERR(qcadev->bt_power.pwrseq))
+				return PTR_ERR(qcadev->bt_power.pwrseq);
 			break;
 		}
 
@@ -2474,8 +2454,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
 
 			/*
 			 * Some modules have BT_EN enabled via a hardware pull-up,
@@ -2483,21 +2463,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * through the power sequence. In such cases, fall through
 			 * to follow the legacy flow.
 			 */
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				qcadev->bt_power->pwrseq = NULL;
+			if (IS_ERR(qcadev->bt_power.pwrseq))
+				qcadev->bt_power.pwrseq = NULL;
 			else
 				break;
 		}
 
-		qcadev->bt_power->dev = &serdev->dev;
-		err = qca_init_regulators(qcadev->bt_power, data->vregs,
+		qcadev->bt_power.dev = &serdev->dev;
+		err = qca_init_regulators(&qcadev->bt_power, data->vregs,
 					  data->num_vregs);
 		if (err) {
 			BT_ERR("Failed to init regulators:%d", err);
 			return err;
 		}
 
-		qcadev->bt_power->vregs_on = false;
+		qcadev->bt_power.vregs_on = false;
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
@@ -2531,10 +2511,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	case QCA_QCA6390:
 		if (dev_of_node(&serdev->dev)) {
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
-			if (IS_ERR(qcadev->bt_power->pwrseq))
-				return PTR_ERR(qcadev->bt_power->pwrseq);
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
+			if (IS_ERR(qcadev->bt_power.pwrseq))
+				return PTR_ERR(qcadev->bt_power.pwrseq);
 			break;
 		}
 		fallthrough;
@@ -2558,16 +2538,16 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
-	if (qcadev->bt_power->pwrseq) {
-		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+	if (qcadev->bt_power.pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 * The descriptor itself is still released by devres,
 			 * so dropping the handle here is not a leak.
 			 */
-			pwrseq_power_on(qcadev->bt_power->pwrseq);
-			qcadev->bt_power->pwrseq = NULL;
+			pwrseq_enable(qcadev->bt_power.pwrseq);
+			qcadev->bt_power.pwrseq = NULL;
 		}
 	}
 
@@ -2605,7 +2585,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:

-- 
2.34.1

