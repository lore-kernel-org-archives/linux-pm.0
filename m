Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429546;
	b=fVLVxblqkCP1Pgnw/Hi2VxvcPSrLT0W1nk1ZzUGFTjSaAYBUUuo/DB0kBCOEkOaS4KsF
	 pGCtQJAbSiiifBAT8ZJwbI8cJtnCxZ9NBKSanVTsiHBQdL/PlUhd4/WE+M4ycIZ93H8qT
	 Mp4SNha0UfwfA3RmuhFQNioFkCYO6QXv/HzDV1l8A8P/ly5vFWawJEZQ93E7+O/xTm4Mz
	 cbpvoOwlILz6sTsH+D3BBxuQF2nd8HAD0CScP5M7ATkleRENxpXFIvIbS3YrAIttCFckC
	 62vvtt7tFUpF3SLrGAV/TeUxWoEb2n2+HLEu8EDqePuX5G+JVjqF4FOG/8q4kE0+jig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429546;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=RyL2h8rRzpp+gpzd2jMK24Y7kpQu0aCp0E5ZMxcZ8dM=;
	b=l1u0UvaZSZqiIf7Raa+eD2nqe19ghg9ZecIFzDwwNaocC8Y2FdIeNNYNnCGms+nnPFEk
	 I9iFfXBSadofgvL7Z/UuUycR9aCfrFuFLhXzFCVjOn1jTWWwtgzqe6vXm3UUINr+lkT8N
	 8ilnHvlX04P3kMvpMi9RWtWTrSEIuhhfMUcdGYG+WohEMofV9NxOLHOwVTYQTZ8YlBQb9
	 +Fxx/xSwXfaaNNcV1j7DRhKWpDEATxmCL3JG4cv9CGxasoQRbAsCT+SmEHL56oMyUuwPw
	 RYla14Z2E7iv+vdXLKESM4/X221v/KkWA5FGpy14DSW7qykjh7HSZO437npicQ/Lw5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YQMJUnok;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SdCCE2Ia;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB9606A681
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAFB9606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YQMJUnok;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SdCCE2Ia
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9GDKl1900214
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RyL2h8rRzpp+gpzd2jMK24Y7kpQu0aCp0E5ZMxcZ8dM=; b=YQMJUnokdQqqXjQQ
	QmNUh1wJ1gG3fVspCItRgIloefTGB1mnctBdSGZ4q+6QotxjRyY8ofIcB249WSAI
	8mm1EDiYN5YDDxkImKVwssrXBW4jMklrxIJo/IuHoYR973KZ2RDTlwmL9NPwxE+B
	W8bmxqm7EpCeOLQrlq0rAYz1uudJtT8DBkNXR4gFEtzPznyptMTImFxrfPqFT4qL
	PICxDBfXZRxxG0IGMc35U2XpH9w8G6AM/Viopd+ziIqBzCz32Vty9EuCArHxRCzG
	A9L6cupAw33u8vYlHTrvqGpC8zpvmusOO1F/cC+4oMW5hJv+IhvgnZWvCCXAo5by
	wFzHuQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k0xk7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-9495af07676so490115485a.2
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429544; x=1796034344; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RyL2h8rRzpp+gpzd2jMK24Y7kpQu0aCp0E5ZMxcZ8dM=;
        b=SdCCE2Ia9lMS24lOVRB6IPL1wQGjR+31eptDmf0xKdvpRE4yTk96meZYlOGf9yyS4i
         fKw9VvFHFmG5rELWJkLVb7kcwM6DeztQfRxUAwdspX6IyFwhqGi7gASuZzQEIHtBG+Qt
         0Wk7shylj4U4t6L1Q/5aQvXSSYRfs0U2LZy2MVM3u4TK+TuZX6/8xA14k3NR1Fk1hh7R
         73saZAT9heW3kui9oHUvEzgmxW+fjPROsmPSMzBA84HgPJm4Zly0oYS80ZlKBSZjLZ70
         rQG82JMe6zBvLvxfv+i6oMcSpPMFnmOiw67gPm38VPh1ulT+BaZAEcPuPy/ttKM8lL7l
         gajg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429544; x=1796034344;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RyL2h8rRzpp+gpzd2jMK24Y7kpQu0aCp0E5ZMxcZ8dM=;
        b=SN/dw5Kkh/LKSiF5Gm4rrznnEvYIqS/U26EfFcysLqhRwgvmj5fcsLEPBawLBM+41+
         mQ8Owb37Qmwvt/s89FGneK+PsskVxzpE/x6kBykwMgxvj9Mgp4SosywKDR2q3T3pjZZF
         JodinScbA34D2lYDkngb9EezRUY/BNeZ7NBrLrsyZgA6L/U9IMm6sY6lvxPRzugtP7ek
         HcfGL85IlHhhkOD4ayF116UL2KBtovzy3RAPSNfudLGELZAkakU434pt1gc8m/ZmDmZf
         vsyf+Tqk8r5GHfp73W2DVbnrb7SEsSPjwNJhtr+3Sc3fzWJVXKpEZ/DO35NIE0UirMWw
         aquA==
X-Forwarded-Encrypted: i=1; AL+hErHQ9N4eMTbB36HA8DAtYcB+vkSYxHesdoPaq+E57KCisuQCOJD+FZuhQFgoWpDrhsQfGH4zina8Xw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8Jp+37V2QTlJf+V9Z1bzbBgSlCKb1LgmQWp+vbaHoy6gLaLj4T
	JKkM1L7YM73+HfWomYP/8+uIJ7rnC8020UXAQD2ky9jo3s1DFndEB8Z6GZH/hj3KfLM4GHOGZpC
	cE0HxmdqSkIfJHocx+XX8fE+A6ULQp5V/Nc5LFAT7oTFTgduf3n1hFJ6l7IMo1g==
X-Gm-Gg: AZFdTZcq5HVlId2HDeRekyswfQ7DbvJe/KGLdjw4CWRHMtZPkFmm9mYBoWiJpNJmClW
	SgfxyNZ8uX4TalbpIZehxPbRK6VirjVmbMiroYESKhLFTceA8/K4Oel9/+742WBr0YrCf1aXXPZ
	E0+nVO+YZ8U1prWg9BTWDi/+hGQj6opqy9JqE4TRZhzw+pmUg7uYeIBGjC7AVvbky3ibohFmtJ2
	ZzdU1BrJp8rcGEanNnOrvSivX5kteqqu3es+ugloFqbJQPUdL1IgMsgF75LPYK7XvHJ7kI7Nt8d
	UXEXkq+dzYpfEjNcQdNMfbXx3VsOH6fCADqe95ZEii3l7MvCF+kmMNGcsSSQXs1F6y8zCeRud/8
	5K05B62k/Keshb+F0j1dA5KjNMu9XKifS/X0e7WyecCUi01w95NbGa3OZ22J/5Dku6QpNGKFooJ
	rkkNOXH1PtYObyNKrgD/7qfnvX7VFN5xWU6TVGRDi4Aji285uFz4kgRb54VfgEPcAz5h0mrMyS0
	PKZBEwLMiAV3s57aJo0G+DjeRF9
X-Received: by 2002:a05:620a:a403:20b0:949:c967:eb68 with SMTP id af79cd13be357-949c967ee7fmr965736385a.1.1795429544334;
        Mon, 23 Nov 2026 02:25:44 -0800 (PST)
X-Received: by 2002:a05:620a:a403:20b0:949:c967:eb68 with SMTP id af79cd13be357-949c967ee7fmr965734785a.1.1795429543925;
        Mon, 23 Nov 2026 02:25:43 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:43 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:36 +0100
Subject: [PATCH v8 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
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
Message-Id: <20261123-monza-wireless-v8-5-a8b38604be6c@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX0TGe2cbASPNV
 vcIV9epWt3cYkfzJG3bfeAPFJFKQgR2VOhx2awioYc1NhE7YNeDRkSxrgrvq5jlklWp+Zl7jzIz
 oiCF0IrJhCmP/TODkKRPscWHId6GLxg=
X-Proofpoint-GUID: LnmtxlVYydOk8L7lOfbIQcNtcFjSzK3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfXyC2wC9s3NxX8
 RXICkbWiWGxkcbM5ZK9KZKmRLlkuoGAsqESet7KU52AUXTZwYMOnI2aodSvWzvWIEXtzx1w7ZPy
 P1Sh67ezcLPWzkH3N1XWZheZYZmD21mrPI9fr9HhCwRP0Sb865/PwsWzDy49JudItqha+/sIUVQ
 TVJLNb+mKDHcbwaPUnyh+tGkh4HFYBoE5Wjps6RVIQVlmTGMp9IayGXto83sodMJcnRkrL2YLZ9
 lfE1hQ+AVRlB4sMv4FUH/VRmp0dycFXejqKRR5FpC7PgaFk4gu5hiP3M1Gsmd0nXguCGjXIOLXG
 6R88I13OxaWHw4ofu0DpGWQyhoMzAKTWBb36f3jlQvc0sYO6+Y1Wi7L0IdP8BXZnqRANUs7qf+j
 R3oaDw99UwHUZqJi7iti27NYnEKV/y+31bCaDP+l0fA3kU2taNrtDOjttesEe3Ol6uRrDotxtQ6
 iYvFPnOXaImOLXbPcdQ==
X-Proofpoint-ORIG-GUID: LnmtxlVYydOk8L7lOfbIQcNtcFjSzK3w
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b0414a8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=CW3gqymaXyTMcD2nhgsA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230041

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
 drivers/bluetooth/hci_qca.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 08efce663eea4344db8dfee2a92eda686d7c97e3..f8b572a5c3d2d373993c49bbdb7f7ae7c9fb9b84 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1907,6 +1907,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power.pwrseq)
+			ret = pwrseq_enable(qcadev->bt_power.pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2456,6 +2459,9 @@ static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
 	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
 	struct pwrseq_desc *pwrseq;
 
+	if (!qca_serdev_is_m2(serdev))
+		return 0;
+
 	/* The pwrseq is looked up on the serdev controller (which holds the
 	 * OF graph to the M.2 connector), but its lifetime must follow this
 	 * serdev consumer device, not the controller. So acquire it with the
@@ -2501,6 +2507,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	else
 		qcadev->btsoc_type = QCA_ROME;
 
+	err = qca_serdev_get_m2_pwrseq(qcadev);
+	if (err)
+		return err;
+
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
 	case QCA_WCN3988:
@@ -2511,13 +2521,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_QCA2066:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
-		if (qca_serdev_is_m2(serdev)) {
-			err = qca_serdev_get_m2_pwrseq(qcadev);
-			if (err)
-				return err;
-
+		/* M.2 connector modules are powered by the pwrseq acquired above. */
+		if (qcadev->bt_power.pwrseq)
 			break;
-		}
 
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*

-- 
2.34.1

