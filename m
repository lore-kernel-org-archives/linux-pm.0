Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B53503BC2
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536573; cv=none; b=Ct1NL+X55hChAMNYJWissvAi04ZXTqFzifdh1SsUMJlF7hPAYKHb3enJhamRdds/eTwpPvTfzsYsXk52jiYSAIQFeUnX96C5xLti+swOM8AVpxA1WyjjYEdt6usXgVzJgvqiTjQxyJ96ZCDi/oHig+LjIxJTrxw2wWHv7sosGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536573; c=relaxed/simple;
	bh=YCIWSFqXvG0Htk2WgfzGGPg3a2awjtggrtVO72ie120=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kX+c8H0x4fWI3AdqWfKqWYjBp2OfMHpldk9ayEYLFlLnw4mubOb4YuqktM01dqoPg1pHd7XNeuvHwrioMDPQWqKctDnndhyFMLfdPf/ZHxH76jOJSLWDxarSTJYmXZR4EFcIZk0IxhHENUPv+TFZjEQBExBxaVwMEhGuWlyvelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f42znUV4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LEtMSiMz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f42znUV4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LEtMSiMz"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiNuB4157739
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FJHtkuDgx65JWiN/Fuqm1kYGp2m2CoyBUOoby5Sv6h0=; b=f42znUV4QQA0d5k8
	WuG+u4rU01UvJtnGEsJSnUCuMUS5aDPdoatKRX+CENaSzTbqsMMphFis293gZtTt
	fJNpi30bOLt8t+PHwky7Mm+nca4FKVAVQr80cRX7+McxLdjKEMCrccCV8o6CDFFL
	CO7jsP0n+fqfsYJS86CIr6+5hlP+W1KNVCud5w6m4mJoKROmvGZfRET1yg7s5HH6
	qdMvy9MCSYV9qVJY0hMm1kkHSFiIKYfOmSv+VgrfSax51EC5tA2qb2SRtGi1O04k
	vmV7Nm06LwXtFei3o5etQf8+piRWox76Q3LfWzmtpfuUoqSeN2w9TqUHUpdBLVG8
	9XEPLw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg011gh33-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:39 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7800607543dso977419137.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536559; x=1789141359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FJHtkuDgx65JWiN/Fuqm1kYGp2m2CoyBUOoby5Sv6h0=;
        b=LEtMSiMzZWDnwribHA3nbZXWVrDeHEJxl2qbMWzHm1Oqu33L08+sCkzynI4gCHejrB
         o51BOxAFcxIhQ/4Pmn2g/z3YHGeRqY8Lic4Pe3fmRyY8XUW1GWwM5QcRW9Uj5XXdazF7
         OAeGQApjyYU+U+crOmc3k+P26huDv2nnqP20TJ+fhPh+1ZWtl4lH140LlVCPRkMIAohq
         LP52vsRmCOm83PqXltOQ47XBYLAjjo7RUf8TGxn1dPsoMhcGsMiVxBnLH8b2EPw0+Xcb
         lkP53tXRmdwbd9y9aSWEs0S0hokRunw8VH0RoL+YId3f5TYRvLutq+nCirbL5tf27yBx
         iuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536559; x=1789141359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJHtkuDgx65JWiN/Fuqm1kYGp2m2CoyBUOoby5Sv6h0=;
        b=WepSAxrOnZWPH3fR9kt/6kj+j8GPZyoq7LA1H26/XBCPAuP/XkUP/wBPaLz/AVRaQ5
         VZefnFBH/cbKZXCX5rx4U65dVUsoqVfFcxzLDuSoe1K7HbWSI/33/RJAHZOZJTgQJWdd
         Xzt46FpHgx9C16zkT3vPRcoTey2nvfzcD6e1oCtUmXs2FxkjPHEIgyUXBWnF3ohtg0dq
         uNA3H/d3ClB22RRK0ac+jQRoga8YrvQ6tu9GnPmO0mGfTYA9zoF0FByioRgvJjN3uZQr
         kE4c6IAKvYk+RD4cB9MtzJyebozMn/Dw9emuaEc9mpPt3kudqYN0WcoA5d1/vQmykqyQ
         iAFg==
X-Forwarded-Encrypted: i=1; AKwUvBzQao4gpXPJ9fu7YGHfGSzRZ8WBqikNl0pmhmybLbVbvPiuPgPMEwEgbZIKKk69R6ZUUlNQIviN3A==@vger.kernel.org
X-Gm-Message-State: AFuF++nKz4r/8wz4SRr1WVFjINvh0/grQYmxR+bttd+xcOJHZVQVkXUd
	tJxVaD/+lWE87zGpS0hIQbmagFWGjOLcvBCEPBHtT/ulGSswdWgauS6DVbSlZvb6bCIBsYpS8qm
	wTovGzF/ZqwyVl2zKri6oFMGNN6n4UKt7i99unZeWO3oAhrgFcjmpjU/TmzqqVw==
X-Gm-Gg: AYBFou1pstB+Bfx1ckfo/P2bMzKAgk+9y2f7oD43TYofUF+4jZfW01SpaYhy7FUNVgw
	ubQ4jU/6Q5UAWAbWGwqaySZHrN6G97dcYAvSj0zxcS4SJCApzDrNqPH8zs8GoaKQVF8vnD2W0Mg
	C11ByNFb9sU7f0drfW/gp3TvGcJ6QeXabRIuCOmZsMiNxch+hSWinPsfSMnbepcB+I5DItMczhI
	EmYln5/4K6MTt9bjVbSa2F0891B/WRmTWKevHLg01ni/1kCjhrx6mjwKdFXYxUFUY6cbNjpD6Ps
	ggcc6QjEF1eCekCu8yjpGSvSL/vsI/tf2dHedsEZ9CX2pspNoAofQ08fC7tjvcT1cl35b2dte0x
	x1qZ4QAbpceBs6hHMRd44zOdEcbvPNMH4/jnB2ou6aHnVfBsDZeiW7uMaBx+YTSfAf6ODGnx5E1
	dfcqTVASBoFAY9lin33hZm86poKQGOfj8E0hkiDFH5MD5T7GC/a/4=
X-Received: by 2002:a05:6102:91a:b0:784:ed9:1a1c with SMTP id ada2fe7eead31-78a4ab66791mr2919626137.12.1788536558839;
        Fri, 04 Sep 2026 08:42:38 -0700 (PDT)
X-Received: by 2002:a05:6102:91a:b0:784:ed9:1a1c with SMTP id ada2fe7eead31-78a4ab66791mr2919586137.12.1788536558377;
        Fri, 04 Sep 2026 08:42:38 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:37 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:24 +0200
Subject: [PATCH v6 09/11] Bluetooth: hci_qca: Flatten struct qca_power into
 struct qca_serdev
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-9-d8c5042b3efd@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX+Mt4YBiDkM5F
 zjrjOSesfwDIhbBV5uJh2NnRMjSidf2A8EpJOQPMRbEc0P+TlvO655q838mGYfEMiukKorDY0kd
 iquRb9g3V65ezxETNTZcr5CHp2V+HrjeD7N3gL9mrpXMZH22mDMvzaP9Jw5HWTbd9hgSwYcAqCI
 ZhiT2s+ECdF6JUyS83SmxMsC75i6o1gGUI/GpX//CM1mLY8HiOC2mpQu7YN07KHNSOwfTT0gz98
 ihpqyRf5GuEix8xNunrsTypw/gbr8i9jCUv4xmaV75+/tP6znuolKpng1qTrPMaXduuFc7UZmtD
 FeNp/0Tch2arTuw6sfsSHWqc7SHQb8qkz8tDXRcATLgDJKrRxasYgjRtECq3iQc2XIvDKSMMb2m
 ibQP46/JDMCh6PKP/a2k9WZhSlBce6JCRBbW2COYeioQ9gf1xcf/9lgnktZFLDIV7oXMq924PEW
 T80HUkSf0AD7za1Rw1Q==
X-Proofpoint-GUID: 2fCsu7Fz6_tCqr315lK3BEuUEBOQx9BO
X-Proofpoint-ORIG-GUID: 2fCsu7Fz6_tCqr315lK3BEuUEBOQx9BO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfXwxtVaitQT/te
 YaQ7FlR2iRB3bvGkTIu5/V7Fgj1d6OCw8VTr7urie9zrNo0o2rCgTCSm4kspwGOoKSwaAW1HHgs
 AfU8s0N7X4FuvEfPgBsKiJTn6Glf0Tw=
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a9ae6ef cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=IDBDRlgmZ80N7xYWSSYA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

struct qca_power currently only groups a handful of fields
(vreg_bulk, num_vregs, vregs_on, pwrseq) that are exclusively used
from struct qca_serdev, via its embedded bt_power member. The extra
indirection level does not provide any isolation or reuse benefit,
and just adds qcadev->bt_power.<field> noise throughout the driver.

Drop struct qca_power and move its fields directly into
struct qca_serdev, updating qca_init_regulators() to take a
struct qca_serdev pointer instead. No functional change intended.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 91 +++++++++++++++++++--------------------------
 1 file changed, 39 insertions(+), 52 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index db0a968dfb00fa6f1abb86a3f6d1be89dfe80c6a..cfefa8b72e2527639299811d1b4f2fac697ee704 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -211,21 +211,16 @@ struct qca_device_data {
 /*
  * Platform data for the QCA Bluetooth power driver.
  */
-struct qca_power {
-	struct device *dev;
-	struct regulator_bulk_data *vreg_bulk;
-	int num_vregs;
-	bool vregs_on;
-	struct pwrseq_desc *pwrseq;
-};
-
 struct qca_serdev {
 	struct hci_uart	 serdev_hu;
 	struct gpio_desc *bt_en;
 	struct gpio_desc *sw_ctrl;
 	struct clk	 *susclk;
 	enum qca_btsoc_type btsoc_type;
-	struct qca_power bt_power;
+	struct regulator_bulk_data *vreg_bulk;
+	int num_vregs;
+	bool vregs_on;
+	struct pwrseq_desc *pwrseq;
 	u32 init_speed;
 	u32 oper_speed;
 	bool bdaddr_property_broken;
@@ -1779,7 +1774,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power.vregs_on) {
+	if (!qcadev->vregs_on) {
 		serdev_device_close(hu->serdev);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -1876,8 +1871,8 @@ static int qca_power_on(struct hci_dev *hdev)
 			msleep(150);
 		}
 
-		if (qcadev->bt_power.pwrseq)
-			pwrseq_power_on(qcadev->bt_power.pwrseq);
+		if (qcadev->pwrseq)
+			pwrseq_enable(qcadev->pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2230,7 +2225,6 @@ static void qca_power_off(struct hci_uart *hu)
 	unsigned long flags;
 	enum qca_btsoc_type soc_type = qca_soc_type(hu);
 	bool sw_ctrl_state;
-	struct qca_power *power;
 
 	/* From this point we go into power off state. But serial port is
 	 * still open, stop queueing the IBS data and flush all the buffered
@@ -2248,7 +2242,6 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2262,8 +2255,8 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power->pwrseq) {
-		pwrseq_disable(power->pwrseq);
+	if (qcadev->pwrseq) {
+		pwrseq_disable(qcadev->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
         }
@@ -2319,23 +2312,22 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
-	if (power->pwrseq)
-		return pwrseq_enable(power->pwrseq);
+	if (qcadev->pwrseq)
+		return pwrseq_enable(qcadev->pwrseq);
 
 	/* Already enabled */
-	if (power->vregs_on)
+	if (qcadev->vregs_on)
 		return 0;
 
-	BT_DBG("enabling %d regulators)", power->num_vregs);
+	BT_DBG("enabling %d regulators)", qcadev->num_vregs);
 
-	ret = regulator_bulk_enable(power->num_vregs, power->vreg_bulk);
+	ret = regulator_bulk_enable(qcadev->num_vregs, qcadev->vreg_bulk);
 	if (ret)
 		return ret;
 
-	power->vregs_on = true;
+	qcadev->vregs_on = true;
 
 	ret = clk_prepare_enable(qcadev->susclk);
 	if (ret)
@@ -2346,38 +2338,35 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
 
 static void qca_regulator_disable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power;
-
 	if (!qcadev)
 		return;
 
-	power = &qcadev->bt_power;
-
 	/* Already disabled? */
-	if (!power->vregs_on)
+	if (!qcadev->vregs_on)
 		return;
 
-	regulator_bulk_disable(power->num_vregs, power->vreg_bulk);
-	power->vregs_on = false;
+	regulator_bulk_disable(qcadev->num_vregs, qcadev->vreg_bulk);
+	qcadev->vregs_on = false;
 
 	clk_disable_unprepare(qcadev->susclk);
 }
 
-static int qca_init_regulators(struct qca_power *qca,
+static int qca_init_regulators(struct qca_serdev *qcadev,
 				const struct qca_vreg *vregs, size_t num_vregs)
 {
+	struct device *dev = &qcadev->serdev_hu.serdev->dev;
 	struct regulator_bulk_data *bulk;
 	int ret;
 	int i;
 
-	bulk = devm_kcalloc(qca->dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
+	bulk = devm_kcalloc(dev, num_vregs, sizeof(*bulk), GFP_KERNEL);
 	if (!bulk)
 		return -ENOMEM;
 
 	for (i = 0; i < num_vregs; i++)
 		bulk[i].supply = vregs[i].name;
 
-	ret = devm_regulator_bulk_get(qca->dev, num_vregs, bulk);
+	ret = devm_regulator_bulk_get(dev, num_vregs, bulk);
 	if (ret < 0)
 		return ret;
 
@@ -2387,8 +2376,8 @@ static int qca_init_regulators(struct qca_power *qca,
 			return ret;
 	}
 
-	qca->vreg_bulk = bulk;
-	qca->num_vregs = num_vregs;
+	qcadev->vreg_bulk = bulk;
+	qcadev->num_vregs = num_vregs;
 
 	return 0;
 }
@@ -2416,7 +2405,7 @@ static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
 	if (IS_ERR(pwrseq))
 		return PTR_ERR(pwrseq);
 
-	qcadev->bt_power.pwrseq = pwrseq;
+	qcadev->pwrseq = pwrseq;
 
 	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
 }
@@ -2465,7 +2454,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6855:
 	case QCA_WCN7850:
 		/* M.2 connector modules are powered by the pwrseq acquired above. */
-		if (qcadev->bt_power.pwrseq)
+		if (qcadev->pwrseq)
 			break;
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
@@ -2475,7 +2464,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+			qcadev->pwrseq = devm_pwrseq_get(&serdev->dev,
 								  "bluetooth");
 
 			/*
@@ -2484,21 +2473,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * through the power sequence. In such cases, fall through
 			 * to follow the legacy flow.
 			 */
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				qcadev->bt_power.pwrseq = NULL;
+			if (IS_ERR(qcadev->pwrseq))
+				qcadev->pwrseq = NULL;
 			else
 				break;
 		}
 
-		qcadev->bt_power.dev = &serdev->dev;
-		err = qca_init_regulators(&qcadev->bt_power, data->vregs,
+		err = qca_init_regulators(qcadev, data->vregs,
 					  data->num_vregs);
 		if (err) {
 			BT_ERR("Failed to init regulators:%d", err);
 			return err;
 		}
 
-		qcadev->bt_power.vregs_on = false;
+		qcadev->vregs_on = false;
 
 		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
@@ -2532,10 +2520,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	case QCA_QCA6390:
 		if (dev_of_node(&serdev->dev)) {
-			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+			qcadev->pwrseq = devm_pwrseq_get(&serdev->dev,
 								  "bluetooth");
-			if (IS_ERR(qcadev->bt_power.pwrseq))
-				return PTR_ERR(qcadev->bt_power.pwrseq);
+			if (IS_ERR(qcadev->pwrseq))
+				return PTR_ERR(qcadev->pwrseq);
 			break;
 		}
 		fallthrough;
@@ -2559,16 +2547,16 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
-	if (qcadev->bt_power.pwrseq) {
-		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
+	if (qcadev->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 * The descriptor itself is still released by devres,
 			 * so dropping the handle here is not a leak.
 			 */
-			pwrseq_enable(qcadev->bt_power.pwrseq);
-			qcadev->bt_power.pwrseq = NULL;
+			pwrseq_enable(qcadev->pwrseq);
+			qcadev->pwrseq = NULL;
 		}
 	}
 
@@ -2606,7 +2594,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:
@@ -2616,7 +2603,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		if (power->vregs_on)
+		if (qcadev->vregs_on)
 			qca_power_off(&qcadev->serdev_hu);
 		break;
 	default:

-- 
2.34.1

