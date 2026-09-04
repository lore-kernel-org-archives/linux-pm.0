Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91543501F33
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536570; cv=none; b=FXkcG5Di5yDlWQwNShjJO+z5r6HiMAlGywRoajgIaD59w8p199DzZFPXam4zq2jRM424jC/A//kETSeVS6VYuBEvIdRFBwUw4vZ49Ev85Z3BUnG58DR8RRSJ6zOHx3Ddpk4N2TTw3K3ltMjlixJw42BWwMluqypDAi/y+6YHk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536570; c=relaxed/simple;
	bh=b1TR2pqK8UJ/JlXul7C47szMhQ5AcfN48BdqST6LpvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RarQGTd1rzovC1IHlhTPaw9CGQ7iLoWsHhaS4Q+H1nUafLrlG9puSBavmbRzleEsETYqg+qqIwcg2UGrbdKQtyQEOd9BwvKiJZHAyf+hVtbZ3SWnsjITtnDMvoojXNbaP/6U3tAEox4FUAIN00kJFv1nEdAxPNOOUdDoMTcjBpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bc8alp2R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=O4xOwVgZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bc8alp2R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O4xOwVgZ"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Eiawa3190607
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YwfxVIyuLh7//i+KBksOTM7bUklANqq0Gb6i7boEe8A=; b=bc8alp2R6YmdF8iF
	ZF4BIBhMqoABQH7YNXRoat2VDZxoCj999D/qbMhnTPhlkt+j9+PRRtpJCoOdgB1h
	9y49iyiyxyinnekmGEa3+kIWy5PtoaylxeyxeF1BQqzRnL3PtRgEvC3ur+BQPUUE
	9HgdSbKTZ5ugfLs8D1Jtik6yPts9Eka6i8WvIehn2d3kDRpmiVjFJJKrRzUEeh1o
	+wVvM7MAL0fV3vhN1Tn1Wj0tn9s7W9Nk7PDhzcC2PGu/4f9rNYSSYS9sQVA1Dqfu
	0mR3fl0aor6e4odoAhXdr3IHN0fmRiDoowvHPN14D37q4v/ztKJd6MforPkuJSn1
	zob4Uw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg010g8sp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:36 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-785827e6073so238561137.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536555; x=1789141355; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YwfxVIyuLh7//i+KBksOTM7bUklANqq0Gb6i7boEe8A=;
        b=O4xOwVgZC03JUjFAzBhwo1CJ6174LiGSI9Tw7U0cVYmNs2O6BgkKoZ/hds6znkdLWP
         JPGS3RBtwPEYI3byk5/sbv4UfQboIdEeZP1Sv7SnyY+tDbikMcnwvi8neO4gq9pp36Fe
         bthDLHllbioUc+Bb+a/6FvFMk0pY98vobNyjTY013JfoRqsn84MXbJaOevz7hE9N7Lel
         ossm5LmxUSVKNhpNY5Y4AgBXHORYVLdAGO5VaeouvVyADazyodx7HkYHcEHqEBc0GHIF
         cizAM4oYX/5P7eiA8eVg9MSuyI8ZVANgY9/TpIioLdsG7KGtErv15SgFSnD/nf+lhAxs
         4rsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536555; x=1789141355;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YwfxVIyuLh7//i+KBksOTM7bUklANqq0Gb6i7boEe8A=;
        b=X/lP1F4EzXc0FiD7R3SYzdHeNNwVH8iUY2C87VYyYkzxXnQ59BEpxT29ZIdIBdM5rV
         evIQlY1PMTodab9s0iLaWpGNNg+D41SGujR1pUGmCDjFJUWqf2HWCf1ugoesKClBdqAf
         LOlGmcvG07NFeQS9iaFEo2flXYw8+zP/eaQ3gFpPPNRu4edm8VhTpzSDR6b1zm1S3X+i
         ryXcHEfvew8JpzJrAC1YPNW6pEKXdSS9Pzu4W7B7ogmxT+WQbOxo9CY2cCR+66U7F0zp
         l00E/yrYjmMjWJNnCVpXzU6vUSUjSZPE0HhD7M7/NQq4RPGiD5LfDGC7Kg3euYdSTn+u
         rNAg==
X-Forwarded-Encrypted: i=1; AKwUvBz6gIDJbrxnkq8LPNZuotT3TMDiP/cRUGPLQXxZef3T30haCYQw/mnV2ewbz52Mx9laEDjFzyR4uA==@vger.kernel.org
X-Gm-Message-State: AFuF++mGIUk/RB+B8GiPP7h57XJ1DDJn3+Lh5Tt4RA7QZO2huvZJRPGQ
	05ZaLCw89WTQhFrfFPOYmVKTACnmxbpFVtaz28HtfRxEoCDiJZBFM2JzXYODh1lU2ZltPWgyLrT
	Mmr8QHelavYLZkPfromyhVo76B+7zMJ/g5g7HHnta0pgY+fwEfWug+vWqdc68Mg==
X-Gm-Gg: AYBFou1EIeveAzhPkLXrZgecYz58klOt+rf+xGHvj6Mwj7z8om0uq8Vn33qrTbgwdzm
	lyJcUqsBsiep/VPOHQc5gZfRZwqiiBEAcKF3olJKHRJEhxaD0A8kl9/yfy20VYyHWec9hicakuz
	PaJogbePWSq08QV/JK8DTk2h6l7+VtAfkD210QAJKwTvtMxqve859EqHcNYAU+PvoAH+3X1MGzb
	tcig8GTyY4RUfkdm7kbPiGyPBhnTMSjmf/EBsoU5WG2qdJffp/WgolK8LCjEop0fgFnjVJYjEjY
	cAG+8QJkyHi2NPmUwolGQPz+eZTlECglNnPUrTGIX3mwt12qn/OsDLN1Bg4JP1oxuC1rBfiWm7z
	O0ux8FFi/JI7sE/sEIWz/i7VMhTkjbuDHoNtHqSqrgc53+VLtmGLpc4QB1JOZFpkto8E6h8Ascg
	pVhp214XxEMABcJY5OqtzkQi2qF+ezlWHa+urRPNxcBGhTt0Qph0M=
X-Received: by 2002:a05:6102:a1d8:10b0:785:e069:6c5 with SMTP id ada2fe7eead31-78a5675c4eemr812155137.8.1788536555476;
        Fri, 04 Sep 2026 08:42:35 -0700 (PDT)
X-Received: by 2002:a05:6102:a1d8:10b0:785:e069:6c5 with SMTP id ada2fe7eead31-78a5675c4eemr812120137.8.1788536554895;
        Fri, 04 Sep 2026 08:42:34 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:33 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:22 +0200
Subject: [PATCH v6 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-7-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
In-Reply-To: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX3Vkmq1z4kbkM
 jdot35m3iR7tEyaTaBEDMoo37TTUDGgh7Z8vQ5Zq4vVpPoeRi66/z5YZsApVVBXPfb3VxETv8Hf
 upZiD5TA87rD7CXRnvmryI8lhoh8g4e9BBs80yFG3jlUiJ0dr+6LJ3lT49I+GldHMQN6xfoZAFT
 89K3LTiy6fne7Xs16hk0FqEjlECUDbYP9oxwjDS4sjPqPqOCwwQaKUv2SjMi55M7aXZcRtU2j/x
 AicEG3Xdsn0VTA6IGIhAe4wNEZUCmd+O49gQkeBlJ0s6Mv7hD3yw3b25H7wrZKuVolCx/8nlk41
 WHHg0RQGjBWwuYhPWwdb9Kli/Au4Iv0tRoU79Nj0OdDQumdMUcMQdiUPhNoU1U5Sgq+PirmXU6g
 MfCukHEzpk6bFyqiP1le0kVSqtRZ0hgypQbefAb49sSigrc+7DW/eLZd7GT5FmlyavtFn0ervLe
 HfFrZtb7VsY4gKXM0FQ==
X-Authority-Analysis: v=2.4 cv=YNavDxGx c=1 sm=1 tr=0 ts=6a9ae6ec cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=-AHguRIk9tBBA_P1FkcA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: yAUYzExiB4ppn96GIx6yaGeQF1GpRvZ5
X-Proofpoint-GUID: yAUYzExiB4ppn96GIx6yaGeQF1GpRvZ5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX+R/8b5k1QACf
 BJjq4acCgQKbqTUuFuclKsWSRSoUIjxMy4I0BOqkxM4NEaAAj9jYq2tXHSDOZEguIZubZmBHmky
 BNfi8jZX1QXkRXzfIwo1Y12LywF5vqY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

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
index 9d27cd851b4a685ce42201b0d40ca6ecbeec9cb1..30586120c4a73a50a29af235b511c3ae97960e27 100644
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
@@ -2259,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power && power->pwrseq) {
+	if (power->pwrseq) {
 		pwrseq_disable(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
@@ -2316,7 +2316,7 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
 	if (power->pwrseq)
@@ -2348,7 +2348,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
 	if (!qcadev)
 		return;
 
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	/* Already disabled? */
 	if (!power->vregs_on)
@@ -2420,26 +2420,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
@@ -2454,10 +2434,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
 
@@ -2468,8 +2448,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
 
 			/*
 			 * Some modules have BT_EN enabled via a hardware pull-up,
@@ -2477,21 +2457,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
@@ -2525,10 +2505,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
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
@@ -2552,16 +2532,16 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
 
@@ -2599,7 +2579,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:

-- 
2.34.1

