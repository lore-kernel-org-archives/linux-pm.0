Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E0B47FAE5
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202919; cv=none; b=iB6x/+CSjhZz+X+KKiLHeiFzcpTS4f4jIj3pDvulkRu967g3qRnxbCipLvfS3Mvinn55ecm2x0YGAi8PsZv0PKb4wRf3u6SWZGbzwhSf+KsCcV5MroC/KBhv8Pr9xoKrdKhwgVp2fvNV6MjbEeJkjB3e4ZatB4RsrKwpojh3Ifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202919; c=relaxed/simple;
	bh=BJBq8/An6MuV0GoyQYKZqS+8da/E9kOGbL2xz49VQbg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYPF4gZibyv1F3PBVRKefV9tLKmpAYrzif+AUnnNtdxwyD4JUjD7PnzfQfRutk4gNphmifhTkAFZVQ1ZGJ7UABHrs0VBHwm5OOuC/hAvflvQMZC6HHih5y+XDk4nqmbs0uoW46Wqye1XoOgVt3fX89f8m16/pZYeceIdyxoqvSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I8mGxj12; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dh8YrAWE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I8mGxj12";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dh8YrAWE"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFepx1893273
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 12:21:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ERPpaSnYHInL9kiFzQxRZVBFrQy2Ir/qyF0qmgZZ+MU=; b=I8mGxj12a4/u3ewl
	owcIiOIoUdMaLggVLASD+NUQhh/z5fw/Jz0DoMOIOhPln6po3vcmYDM1v0WMuPyN
	SAu35F2zqxlmNHxjD4Lq3ydSE93MaYGAU30YwrEr3cpxj27iUwDaINTQus8ScsjF
	gaYb7rhUw+7A4oYEd/ush0dSPY6dNA6Z3OCpTraHWulFpKY57WEj0uzGF3KbJh03
	UhcTbbiozS0w2nO1sI5MRY4egO5nhK3OKPWzxH0OVEnvysCyQvR2GL1+BeIoQz/s
	2gugV6kcjsFO6yeWqD/5f9Ye1cbKLj5+KmmVxkCvWJICYl+dL6AQTEtua3cNcMtv
	uQkhCg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2ssudsw2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 12:21:54 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-9179a556c43so44688746d6.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 05:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202914; x=1791807714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ERPpaSnYHInL9kiFzQxRZVBFrQy2Ir/qyF0qmgZZ+MU=;
        b=dh8YrAWE9bYPd4ZAlO7poubgTx1L5DLmaQZZb4gndyA2E4IpifdRX/uOduIAkE1Xlk
         +l6RSu/zDZET8winO6ldQ2xSgI+jdWmeDhGfB+2j2pz47mr41S10B3gTRRQCw8nRKcQb
         s4JGtF4Hf8jo4qLLX6ipLdoTSmuFo3HY05SA8J6XAPqUSz1ovmDbsB1++zVFsiU86ffQ
         rctyAj+y29ijGyApn2UlTBLZKa1bpRf9vBAbmDwhISJDTr2tiI+8r5TbAtw3XO7kMX1W
         iW7i2UTi8yrV8HcyXhrc33BEvLFLvvl/FG0rNThGIn3kHFY0sKGHjmcGdpNLkxKLDc6s
         qwhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202914; x=1791807714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ERPpaSnYHInL9kiFzQxRZVBFrQy2Ir/qyF0qmgZZ+MU=;
        b=Bk6fRWSIVVqSelwomj0wvCzeLs6xPDvLdZumZJhTaMMqWv9H/k/zasjYP+METOzqaH
         xd3QhizPPJhFGlSTuXym/CRj2dMk6HuatdVUK80FwwYSsXHatEjIWjxkePM+fvqdJ7sI
         yDY8U7DdJ3Mr++rQgWJJGvlngiS84dRJ+DEctos4JEoSbXkvIC3/OXZuP9C5YTYedGpH
         jfIQjBo+mP7W5fdEpWOwctcY2O1PNm+jPO3yiK6/JVW8sdXeRKPOJHAcxxSOFPANlLAC
         z+jeQmQtla44rlrf0KnT3qO6SPBp+lZjOYetl+kAg7iwPTjytxjdlHAyp9H5R9fo0pOw
         0+ZA==
X-Forwarded-Encrypted: i=1; AKwUvBwif5l9+OoI6Mr3es6Ow0fYWKPG+9rcYENWZ1PXb5Ut9tDQLg2fSsObyG2rkgdP70Sdf4a+9Mr5Ng==@vger.kernel.org
X-Gm-Message-State: AFuF++mjPbeW1j+W942iWPTEbGMUt+AdEO8/nxq6QhVAmVtrT6iquQk3
	YT9o9MojU9gZA+xBzwvuYk/qEquOb7wBjp55BMUYi1CdrjBtv60dghzd0gSXPfA1z2BzVuiC9J4
	Coz2Cky+eCxTqZiMinufJqlSgOrzyV1aRKtneKLLdKbESLynonPMPANsf+wsM/A==
X-Gm-Gg: AYBFou0MpTRmUGa4IZGd7BTQ8kjJ+eN2IyW45Yb9t0CtefLJQdgHZ6PzeDaCTmq1AnZ
	8qD7Yd7IBsZd/hgukly/5fifpTtwqf7gsHy+WGKwwm4v+rfrUFQD2Q5FzptjUyHq+TNKXS5vytw
	igBhFMfraZSSgwpqMrmKhh+mMnqEicEwXZKnKEEfPc61CW+phMhFo4EEYD3fdNY0K6Fv3hOk0/k
	rdNGmMLUazXp2GSFlrUulYl84Ms6v1j+tVkZLkTl5gDFnt5XZ76dMnUvWtKMhgSSsugVgZSiekM
	be05ChQrzjYQtBVK2yAnMcT8v2pPv+/vJn0GzB5y5WmKRPvcDaHQR4hMTkr6NADV3as3KLQ1Em2
	+5HfzedNuqicopn2Z2jggaoLifBC2ZXtF/ABFpbM+s0T2K+KwhyMbTa9AZJQZFJk5Z2BDKGows0
	4AMkW2hKwDWPN/Hx1Qg8+0fLuVndnL10nwPt/xqbKwkmDGJNN65Ya2/Fnq2JBHD5wPPLGQnw==
X-Received: by 2002:a05:620a:7119:b0:939:a9d4:7022 with SMTP id af79cd13be357-93ce7a9de83mr1837636585a.8.1791202914208;
        Mon, 05 Oct 2026 05:21:54 -0700 (PDT)
X-Received: by 2002:a05:620a:7119:b0:939:a9d4:7022 with SMTP id af79cd13be357-93ce7a9de83mr1837631485a.8.1791202913547;
        Mon, 05 Oct 2026 05:21:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:52 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:35 +0200
Subject: [PATCH v7 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-5-5a6de7662dcb@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX12KSkO/JnZQn
 bE1JRf0g8hMAxzD2sVZzaVN/mZbz/aIfU97qc/wGGy19a2F/rFAbEV5/hbvBiE/z4Jqil8LeJi6
 dPhdCXRhnYkGfbuvTEWBboqKyvT/igA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfXyE4Z3nT3urPY
 J2tf5AkFodqfFjFFFI6vQdHjnF/6mQuiVqXrJR8sPrD986XdqamckWh8SFlrJbSMeBd9POPO5kU
 UhxazWqAoqGbIjzC417OSR7jOB1cGEp4aUOSf7neu6QCBbb+MRfmWMe7LoyGHDLlwaYYzRZse7+
 Oa7pyF6CPf4VqdVzjI3Ww4te18QQ73E3G76UojY5zePVB0WKa77JgU6JzX66Telchp7OuixpRS6
 nsLhPGmeh2nQNq3V0/ofucZzncwBWCuyGEowzIPJWYVMb+8xbK3gMwt9P2jGMQBlhl7ea7lvCgD
 OcwO2W12wOn3YL8NqVbEvo+78Pfa2ftBV1FjM5cVqaM6TSHL14MFq+Es7FsPR09TamnabPl46w+
 TGYQQB3DPlZMPnZfgTjVBm+JeRharSltsbkEFeAlEtVhIxtM92BJBqear3LwvNXjNgOrdlNvfGU
 LNx8mdpGarvUCdQCKNw==
X-Proofpoint-GUID: 8SFAJU0UhNscsoWBrDnwbie_phBf7C7m
X-Proofpoint-ORIG-GUID: 8SFAJU0UhNscsoWBrDnwbie_phBf7C7m
X-Authority-Analysis: v=2.4 cv=FryQbGrq c=1 sm=1 tr=0 ts=6ac39662 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=reVw4oyKNVL6WbIJD7YA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected to
an M.2 connector), acquire the 'uart' pwrseq target from the connector's
power sequencer and use it to control BT power instead of the bt-enable
GPIO. This is factored out into qca_serdev_get_m2_pwrseq().

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 47 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1d27ff98034ba99d0783e48db5c605f3b31117ea..b6ec1a57248e2cf4bd138898ffc5cad45b1b4a8b 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1875,6 +1875,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power.pwrseq)
+			pwrseq_power_on(qcadev->bt_power.pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2396,6 +2399,34 @@ static int qca_init_regulators(struct qca_power *qca,
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
@@ -2426,6 +2457,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2435,17 +2470,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

