Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130A237F728
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218726; cv=none; b=Z46wscFsL0oNdOj6PhvfqkanXa0OmU9D9WvrQAHsJxM2lqDWr8ItBiNXTXHImIc2rbB0A6Mh7otyueBV4Wu6ecFAq9aaL52GVFykVdB+ix17lWHWNawsjCgDpC7gN3w1l4Aw+27Q8OUmC0JjqM/7zGna/A9OwigUJvfQu6N+rhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218726; c=relaxed/simple;
	bh=xM69rdwj/4s4KU6DoN0jDrVsnH2NCoFH3DVoSAMRnTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W/2W/GiJcmbXSVV23WpkHNm3ALRiW9hxUHqT1umOqtRk5HLtZ35c4Zlxo932rdOtYm7Due/PYEVlVvI0FuG6F2HDtthWKSvk5agmcEIK0acU93Hv2idu7l1aTomz9psGUBPunf0QjRZ2Z6t8cWCPg4Q8/EJMnJNHUhraE4DhMXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UxjjV5cA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=E0+fa3h8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UxjjV5cA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E0+fa3h8"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDKKBC2857722
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iA2Yiw9uzbXh2h9O8pkl6U4Hyg4t6O2C/nSL7Zx+AZM=; b=UxjjV5cAYc4dm11p
	NTuTvZnrsFOqxPZILMOsJaFgQDrpoZYqim40h89ov7KLgMxLtsmx84PtEqDHsS4p
	yPkK2R00/3fnKa8bpxFqjLnYKESFx4ZsWq4LNefkhOYMm+IzYtUjTtn/N4qCA36I
	4zaBEq6R5wCGQ9llAKuZwcRRsNBvvI4Wa2iTAL47aEihx2W6oV2PuGVOOeN7Nb04
	kOsGcgArOHBz8nQXJ70cTp119vMJ08++1Fy8rv6gwnjDQXpMnW+/eXwG8pZotkOM
	Wo/HCysdfzirKxO6uvYQ+tcXFhw6AE/9jKb4hoENi7bmWn0erKneee1sIXz7JsaG
	NO3kjg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex25yb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:37 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92d1cae5939so943608785a.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218717; x=1784823517; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iA2Yiw9uzbXh2h9O8pkl6U4Hyg4t6O2C/nSL7Zx+AZM=;
        b=E0+fa3h8gJW+XiHdCPbBsnWK8Z5NR83kIOCRdvRRg3Ne4y1/hC9bhd8kSrGcJE7GoE
         mFf4vVjiCEc4BlD+xy677TvhMGE2jbK390RKwyGbQwI3n6xVBo+HJQJIuBr/qsiCmeWd
         a3auqgW/HeZIcbExhBhuDkD/TsgHO5IfBDHjPPIkdeMquBQVD4HSZdCi9coxwRDpWeJE
         CfzhoUfjauhGeCd+k/ifWpQJaWvAwdZ4b/rUYFwXlEmGVufuRqLhrtkn3VJZAJGkeuYH
         tzJL3xhmlgaTeFq1OWqBBYNhl+zsnz4X0YO9rRPp4KG/U6epvFiat4Jz8U1wcghlJKmF
         I9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218717; x=1784823517;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iA2Yiw9uzbXh2h9O8pkl6U4Hyg4t6O2C/nSL7Zx+AZM=;
        b=ZqWOoEF9gMaLtAu9q70aSba6pXtsxT4sGwXjw3xCBNv/OH31TYA8QjE5gCImFjyVOT
         nXWyqQUFXtMvLVi7/SWZlA5lYmAUxb4wyAvIcVIPbeg00iea6gBZYiPX2nWpiHXKyOEt
         MscqpdOLYkwvVpAoIHbMFUJ4fM2r7xx9I5N1CfU1fwIhTp4czGnXqgI+771LL38QbMgS
         z+Sjds50xu7sYN/D5GQ1beRRHYe+fd6sAjj9AHlZAhIfkLj4qo0iklLH7ZLwITiQCXQW
         9Gv5h6oTUoZcFoxHPI8CwlJBwwqzHJdLfCuOdUhkONc4zEnJ6rXnrHEygQcBSWrRU1CY
         IhNA==
X-Forwarded-Encrypted: i=1; AHgh+RpJODggWQ2eIQ1pVu6HtrABoqbWgLSalicC/6Qyt28ZANeRMD9J6pPv1wrFy7u++lGk8SAqhkQvJA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxflSEpr19UpU+VuFNb34zpdgtXiAj4jghQdLcFp6SQwMQHL/fy
	G7g3gopDumM3H17u6Gx/Xnw/F8Sf6LbXzWCX2dnytnZzvuUoQw/VKcGcAzjgCHyRP6bOuglx9lS
	htZZsxGBTbaUegBXUJd6NQQfvElfdf2x7NzURoUPVwsccwrpQqmWQQNAo6QKDNg==
X-Gm-Gg: AfdE7cltZJKNS71uXqtFaOmHoRNhwzHU2/b3t1uV1GFaQSTTB6SE6BCNFRGcHzs53ta
	xYZaX0oMLegMZLCywNbc8gkDPJR48kZC6ntY121W/bMoJOp5T5nT8rDFA3j8K8VdR4szKB6IuEJ
	fxRuXcuJz4mInwMo+hbcTBkF6JGpI+IQuGLS0Jtoz2OtkIu/cudhx98g9Yve/IGtxNPUteo6FJb
	Grsf60KgiZ3FKqwNKOHq4wFkznl5BLvIQjDJstUf46kNxsZj2/XV3acGKfaUswTEWcg/qDGW3ds
	k16xsjwbwJQSyylYW7WF1138jyKoUTPdSfblpU23mumKlN+yVC4ll9J3Sz7FvSN2WYfz67NYGpZ
	uaOFKyfTZz1AzO+FxsfXvaSwtw5ZyPG6j1QK8eYo25oXFcHkeMxrLu6+EPnFkfV4S8zDuzA/J3y
	O0k0hsvI7IdKDVPwtpQtbOaaEK4+V+c99r34zUA4iXJB3rlRLl21w=
X-Received: by 2002:a05:622a:4c0a:b0:51b:efe9:27c0 with SMTP id d75a77b69052e-51e42497dbcmr119476301cf.71.1784218716883;
        Thu, 16 Jul 2026 09:18:36 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0a:b0:51b:efe9:27c0 with SMTP id d75a77b69052e-51e42497dbcmr119475821cf.71.1784218716229;
        Thu, 16 Jul 2026 09:18:36 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:35 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:24 +0200
Subject: [PATCH v4 07/11] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-7-9b02e6f549d7@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a59045d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=Z5-lucBUan0SmjtTDS4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: Nw9h5qf4KvbvANk0Frq3ncDLqLvbQJG4
X-Proofpoint-GUID: Nw9h5qf4KvbvANk0Frq3ncDLqLvbQJG4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfXypl1b5qo8KR4
 JZq/FNHy7q7bhyVGX6PE9T4+8aJ/ido2p42aHapI/EOQ5KmTB0J4ZnacsrtQ6ab2Bq/nHN3wRsV
 oe2VAZdNY2xQ9KR2vHedOfCZr7Zb4nI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX14OyyVYI0+F+
 v8fZruchNFePsViEnGtd9uoXtzOtMXrSboUFof4ffDr4ipG2Qj4d0f3taelgH/JnffXye5OYsAl
 YU35gysorJCVx+k7ZHQa/8Nl2S6+AxXCnvT5jgvaj/bE4G2rfGuEkGZRxiJzFqq676hUfY9G1Vq
 lkBwtyvtIFRqiQJddKiHVR6SdYfGwaG/oKA2pZfF03iz7fR98FJOTTGv3z/faYWBu0mNPoQ14ab
 lSo9aPxNZ1rZbdJBlWexGITxGSZWa5Ju1OX/ArjF9g2B+xBDKPJzHJu4NqyXutjQNbrup/Buk32
 S4Nm/aKDeampv1eg4tKmoowUFNcR8SxevOBrgsxii0Fh3jQ814oz089sVAZYzhKBl7Au42P/dpA
 v/WAbrMxhy2ov963sWHBHfbtEm/IJLKEFE6+ibY3y3yG6h2AkiYBC2QNPr0zbKAGMUv9vdoy2/a
 HXUhyAr9RTFKag+CKlg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160166

'bt_power' is allocated dynamically only for a subset of SOC types, using a
switch on the SOC type that mirrors the one that follows it. This is about
to become pointless as the power sequencer path (used by M.2 modules) is
independent of the SOC type and needs 'bt_power' populated for any type.

Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
allocating it separately. This drops the extra allocation and its dedicated
SOC-type switch, and removes the need for NULL checks on the pointer.

No functional change intended.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 72 ++++++++++++++++-----------------------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 41e8c302abc2a820022d1783f1fad76b358ae67c..25c4387136245fca25e375951f960d7240116781 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -226,7 +226,7 @@ struct qca_serdev {
 	struct gpio_desc *sw_ctrl;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
-	struct qca_power *bt_power;
+	struct qca_power bt_power;
 	u32 init_speed;
 	u32 oper_speed;
 	bool bdaddr_property_broken;
@@ -1776,7 +1776,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power->vregs_on) {
+	if (!qcadev->bt_power.vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -2242,7 +2242,7 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2256,7 +2256,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power && power->pwrseq) {
+	if (power->pwrseq) {
 		pwrseq_power_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
@@ -2313,7 +2313,7 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
 	if (power->pwrseq)
@@ -2345,7 +2345,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
 	if (!qcadev)
 		return;
 
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	/* Already disabled? */
 	if (!power->vregs_on)
@@ -2417,26 +2417,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
@@ -2451,10 +2431,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
 
@@ -2465,8 +2445,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
 
 			/*
 			 * Some modules have BT_EN enabled via a hardware pull-up,
@@ -2474,21 +2454,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
@@ -2522,10 +2502,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
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
@@ -2549,14 +2529,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
-	if (qcadev->bt_power->pwrseq) {
-		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+	if (qcadev->bt_power.pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 */
-			pwrseq_power_on(qcadev->bt_power->pwrseq);
-			qcadev->bt_power->pwrseq = NULL;
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
+			qcadev->bt_power.pwrseq = NULL;
 		}
 	}
 
@@ -2594,7 +2574,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:

-- 
2.34.1

