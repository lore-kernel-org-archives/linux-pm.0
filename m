Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795442183;
	b=iwiez2GzMxE6rlMF38RXod5ziSpgcspckRXUXMRKFSgxTlo35L0g6kqK3uxpzn2UQpXN
	 OvG7jRc5/Jrcr8Cj2VaKt4+CM4Xib5ru6iGPVkkEWxBlx9Fs+U4168E3cI1Ss/94j5d/S
	 o5ePA90vtyiD+o6FkIJ9Le05alRswfn1OwwKazDeN2EvSoGTNGwHYT6ZowBhS9g3VVOcM
	 SfWz032fzjqU0/hP/oj7PlihqxVjxbJNz+pJr5JhR3cnyDXBWwpPzw1rs22UjcqT9NRDm
	 5DBIcQFjgU719HLkPEH93GeH+mRGS75vG4N9PTKy+CW3wy0935JEplU7THMNST1mt2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795442183;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=N1oFBv4W0/OF6fkBqaRCQiDB1eU3UHqeJgGqt8r/kaI=;
	b=D6xNeAqCjg83kLewuDvCGWknNhRkO6sE1pVK6SWNcARmDqMpo4yCYFnqkqOoBiJQpQJE
	 i5SY4hAswWEEdO5ha4mBr1MnQdYaM1oGYhnJTECcOXDwR/Pptl47rESRNHWMoM0k07+sD
	 dCLpkkYRoNSoyWbOW4KEgb8qxr6YaBYpl0a9D76N5+AI5O8ztuQGoowZwJJnFqr+SI4A6
	 W6YQfT0Zl4Ovo5gMfgjEtcXqk0HqHWD4IvxkpxUwl8jVK9XzltKrfEMdF/zkGFaX1okw5
	 U8po1d/oJYb/oGDP/IFTPfn0+yB8iklp6jTVryzqTs6dWLBHymL348Nt7I9ChLWXz0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fdOmMSWh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="fy3gp/b7";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18855606A6BB
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18855606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fdOmMSWh;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fy3gp/b7
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ANDLHXX4030540
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	N1oFBv4W0/OF6fkBqaRCQiDB1eU3UHqeJgGqt8r/kaI=; b=fdOmMSWhHzLbu7tC
	X5W9iq3K2KxlFtdWjgHKHcJBCZCctDGQBmA7iF8/YZmvuRAVS5IEVcZvR3Ml+o/N
	7kUuSQIdfr76oZBoXCz1KF7UOVr9mLqp5YoXL3Bi3mEaA5RH/skYCZIH+Senbz2x
	234ImgVJ84yPQQxYZac8VgDneRzTw1b1maQgh2I5C8IWN+duXNdy/dJB4iC06DO8
	ADiOtEw6j7PRR23qMT5hHmo/f7VnmIEmyQNLLcMT2hs+iK0N1yEslY0/KuT3NIYt
	+BhSbaxADA3G9KCxEfMm2oDhCvQVaA/gGvjwhH1KT+PnYZA5qbgBvn9fXYp0ENfg
	gzVIDA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4evshv7w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 13:56:21 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f3969a2a7so507599285a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795442180; x=1796046980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N1oFBv4W0/OF6fkBqaRCQiDB1eU3UHqeJgGqt8r/kaI=;
        b=fy3gp/b7z5M3BJSoO9/UV0yauBWn0ViFGIO18w8EzK50itgoebMnEUI055HRNvx5kP
         4ZsdBbUfpIa3DFjWVeFkMEJl+7Ty55ewfHfbyM/DIHgGJcGPe1dYS1ja8odqkYc9MnsX
         gay77aDgiKchBbjaAj2y8mTGb3tvR+jggAJqtusFPFrVKdhN7wHzWWX+coucvik16MB5
         ldyVkITKfaQT2iuSwm3bCiBHrhpYuyHYiJWrFJ4BT/2u/56XE0/u7/wgFh87nh9xkEA9
         ahprfghlkpxmk+J8DnDBdJEfb+TYETF6+7EOz0DAwDj6BhOJCtOH9l+KhJnQWKSQDEJi
         5eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795442180; x=1796046980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1oFBv4W0/OF6fkBqaRCQiDB1eU3UHqeJgGqt8r/kaI=;
        b=aCwqEx8CVr616msO5ikSQG8r4XN85bPjADXi2Erx705kZFNuaq80MewIhCgPB4AZeQ
         roSd2iSCb61N9tmRxeAAqGlNH55x+Ij063QDbC8Agg1yoCMsnw7tD20/eDRWBAhanDoR
         eB8a3FwZGkXXytZms1EMJ/m7QBvhjITq6bTHQDnFIq1puJuE7Ent61Ly1MjuRFQDFUFi
         IWFPh8XV6YCoql4B4fBj26g+w6Rc2/MEs8wz5wmBlw3cXyBy4hx7+CoC1tTFEC0qrj8T
         zC+knHkYCGzx9g5agS0jUiM/1XTm2eHqjxGtO8jvVY2pJdggDDEjlf5qYjWZhESse/62
         9qmA==
X-Forwarded-Encrypted: i=1; AL+hErFN7gDc/k/vEsyz0KQIqh/2sRlM65OTPTrWIVc3NPueL9IpPLuxXYQLSTGW6YAjdijy3Gjsc/BZUw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+pWVw5IxibmSutCepuQH7K8lsRypvBOCqxbu7d+hWsvKU2xnhc
	L18TTgFMIDwucnqkiyMhTPpeZPMcJE5BrJ6qx/MBoMh+IPbYAgqWwdmD+NejBJSX6NLnPE+NP3E
	yDoOXOnpK6scGU6nSro5WH5lEGnblUX1f68MJf8+dX2kE5N2/Wa77BCBOzmnx+A==
X-Gm-Gg: AZFdTZf/b8E79k/blLHYnUOE5jyHI9xk9XM6QlR3kcYLXfkYq0+PdxeOeugsk7emgpk
	YQ/9ZKqvgGSl+wksrkbIQvZ/yCAdp3vLAu3RP0eEYn7r7HfDMNm/lOgqGAbpg/rtUVLo/UVcP3B
	HZef56lqEvckegabwfkDhAZlUhlAbvsaO9OXY1YhMeQFrPnrEHZXeqGgcYG0oXWS6K5v3t73wms
	xQNfidSUYYbYTVenP4g2N8kwdhSUjEF6rdkxhpsljprPemzJPU0oVRCAstrFjTBl2DlhitskEXw
	35KZZGPl3BpB5Tu3nCiDmrH4ZcjbIMRxJP35tkwpXlZ1KNoV6CcyXIang4nlsOAg/eRyK3LnE9V
	deeP7cBoj9SIZA/CCtHtiJJFty60Em9Vg3u81A3WJj9d4JlIdfvobFbnmMzD5nl2QrjmaRBOxU0
	1JykewW/iBA66O/qYFAijFU/qH27zxRTJZ109HNWuHXj7E4V6LrDLstYVGNZGPR7S3g2uB7mslS
	sonhn2gDDnUxAsOpCw3ZnzXFsCt
X-Received: by 2002:a05:620a:2843:b0:949:a139:2f26 with SMTP id af79cd13be357-949ba823976mr1874149385a.7.1795442180172;
        Mon, 23 Nov 2026 05:56:20 -0800 (PST)
X-Received: by 2002:a05:620a:2843:b0:949:a139:2f26 with SMTP id af79cd13be357-949ba823976mr1874143485a.7.1795442179575;
        Mon, 23 Nov 2026 05:56:19 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:6c6b:1e5a:79dd:a527])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6c4353d6sm21724625f8f.56.2026.11.23.05.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:56:18 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 14:56:11 +0100
Subject: [PATCH v9 4/8] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
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
Message-Id: <20261123-monza-wireless-v9-4-450d7d764aea@oss.qualcomm.com>
References: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
In-Reply-To: <20261123-monza-wireless-v9-0-450d7d764aea@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=AL9GXjHq c=1 sm=1 tr=0 ts=6b044605 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=_i6oeMK_y0MRuiu9OnYA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: CNpHv0PX6en6brhKnwMy3PMBZIy4sCcB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX7iAMfr5wAEJv
 SsvcyszFgQg+heUlXgUsXLwvC2G0/YgYOH41rggVxhXpEuIBnMWWERpGyDkSfJ0FQRYE+YaTjvU
 DVW5kIqztGUlqG8Binjry6CIoHRupvQFK8R+ZPQ/KeTklQAM5xBNlgHNPLqkrapAInvboRPFVlj
 KxTBeNkj5p8a7pJcEXdgxvKju0TMcuWY3wAYDFc2t+xo2h1Mw4YFgTvE1vu6h9XidViROo1abNw
 VGbDUdezjRNp1gFoTf21+CLtB3Vt6d17EAe+rqaulKv3D5/qIcHKBgvSBpoNFTYH6o6jdzDvBvQ
 ZWNFN5+AWM4aFIr6xLIesjG0OCX+l8eLCsAgqX7oQpLYlSYMFYrf1uKp7d7JUm6gFHh+NnwNj8K
 2dXVDp+0eK0vXFBln1AmDsNtiHcIkvqA7zvPdlH9ty716K4ujkyjIZMuJDvuUBRfhgugBM5VAVT
 tMXPQ6RIHyfgQyMwM7g==
X-Proofpoint-GUID: CNpHv0PX6en6brhKnwMy3PMBZIy4sCcB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA1NSBTYWx0ZWRfX85FeohrHEYFF
 M6bUIrBaKua0oLxyfI6Xg92lWd32+T69ihjjqMMQqPe+0jalhL0ZCyLGWVGMRYs6rkap6+T/WLs
 msLj+g2DRIdcMZyiZRnU5pKcJ0TzwY4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 phishscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230055

'bt_power' is allocated dynamically only for a subset of SOC types, using a
switch on the SOC type that mirrors the one that follows it. This is about
to become pointless as the power sequencer path (used by M.2 modules) is
independent of the SOC type and needs 'bt_power' populated for any type.

Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
allocating it separately. This drops the extra allocation and its dedicated
SOC-type switch, and removes the need for NULL checks on the pointer.

No functional change intended.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 67 ++++++++++++++++-----------------------------
 1 file changed, 23 insertions(+), 44 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 3c0239e837fed7ff8d8261b0c61e5163945d157b..9246abd3492870a6867d12656056d2a5e6490e10 100644
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
@@ -1810,7 +1810,7 @@ static int qca_regulator_init(struct hci_uart *hu)
 	 */
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 
-	if (!qcadev->bt_power->vregs_on) {
+	if (!qcadev->bt_power.vregs_on) {
 		qca_port_close(hu);
 		ret = qca_regulator_enable(qcadev);
 		if (ret)
@@ -2279,7 +2279,7 @@ static void qca_power_off(struct hci_uart *hu)
 		return;
 
 	qcadev = serdev_device_get_drvdata(hu->serdev);
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	switch (soc_type) {
 	case QCA_WCN3988:
@@ -2299,7 +2299,7 @@ static void qca_power_off(struct hci_uart *hu)
 		break;
 	}
 
-	if (power && power->pwrseq) {
+	if (power->pwrseq) {
 		pwrseq_disable(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
 		return;
@@ -2357,7 +2357,7 @@ static int qca_hci_shutdown(struct hci_dev *hdev)
 
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 	int ret;
 
 	if (power->pwrseq)
@@ -2389,7 +2389,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
 	if (!qcadev)
 		return;
 
-	power = qcadev->bt_power;
+	power = &qcadev->bt_power;
 
 	/* Already disabled? */
 	if (!power->vregs_on)
@@ -2466,7 +2466,7 @@ static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
 	if (IS_ERR(pwrseq))
 		return PTR_ERR(pwrseq);
 
-	qcadev->bt_power->pwrseq = pwrseq;
+	qcadev->bt_power.pwrseq = pwrseq;
 
 	return devm_add_action_or_reset(&serdev->dev, qca_serdev_put_pwrseq, pwrseq);
 }
@@ -2501,27 +2501,6 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
-	case QCA_QCA2066:
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
@@ -2547,8 +2526,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			 * let's use the power sequencer. Otherwise, let's
 			 * drive everything ourselves.
 			 */
-			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
-								   "bluetooth");
+			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->dev,
+								  "bluetooth");
 
 			/*
 			 * Some modules have BT_EN enabled via a hardware pull-up,
@@ -2556,21 +2535,21 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
@@ -2606,10 +2585,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
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
@@ -2633,20 +2612,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 	}
 
-	if (qcadev->bt_power && qcadev->bt_power->pwrseq) {
-		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+	if (qcadev->bt_power.pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power.pwrseq);
 		if (!bt_en_available) {
 			/* The host cannot gate the BT power individually.
 			 * Treat it as always-on and drop the pwrseq handle.
 			 * The descriptor itself is still released by devres,
 			 * so dropping the handle here is not a leak.
 			 */
-			err = pwrseq_enable(qcadev->bt_power->pwrseq);
+			err = pwrseq_enable(qcadev->bt_power.pwrseq);
 			if (err)
 				return dev_err_probe(&serdev->dev, err,
 						     "failed to power on BT device\n");
 
-			qcadev->bt_power->pwrseq = NULL;
+			qcadev->bt_power.pwrseq = NULL;
 		}
 	}
 
@@ -2684,7 +2663,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 static void qca_serdev_remove(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
-	struct qca_power *power = qcadev->bt_power;
+	struct qca_power *power = &qcadev->bt_power;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3988:

-- 
2.34.1

