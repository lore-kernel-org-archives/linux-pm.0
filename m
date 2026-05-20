Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA313DA7F1
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779274917; cv=none; b=iIIFaWPb3EXrpnSotbAS+RKCg7VMG7C6KRoAEJaWiUD8bLNMwsN9e6u42QkJvHKTNLpnkVpO9/j7QqCNbWlVGO9v9CAAn2QYVsPnFQjsq8ZNRIofJmdOf6YHuT+iGI/p4UNYRG4l1b8pAygh1pGYO1qi+/snNZvPLt0WK2fdZaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779274917; c=relaxed/simple;
	bh=IwOf3bKBO2x+9q5gt71IHZnJfjB3imuDUZjTiln6iJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TLWanT+7Zond6rptYKgXMbGBeD7GjlKHnA8396XCgQrMALxGIDDE2EK2xjlUxTWK71NCvkBWcWdKXs35oSuM8hPZHCCkp+oSvgrUh4xes6jlyMCmmQ3GoYMsfB3n6SU5nFCseRj5J+DNhANrkuB0jAJ3FB+04hPHFxXV/i/rj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IZCEqkdp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OMOh5Fkt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IZCEqkdp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OMOh5Fkt"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7bbi0341440
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GI2hbxpBYvrJsq1N33WhlyERapASJ5myJdAz+CdIXHg=; b=IZCEqkdpOmuOTAfo
	FFowHjttUxAGEL6dabmLFG5uG6JmVQGx+XH/JDks/TMnGdpG5sjS9jPt135PwXvh
	kM5fFIOafts3NfhPGblJstja8QPnvh+kV5dLlYv1ptiGnNrb4+a/JMdGJY0dCbeu
	QUhV50m0qOAgJPty5vTS9P0oL5xiCdoiEW9eA55XCXBBsMEsGcY1kVZEQBITBS5N
	25PCZ2uPQBMNUpMgaGZMbh0yy7uEhwpfEAJii60KgznRKtjH6CLVZd3E1xwvhyKQ
	bCUP7Gngp6u63mFxaXTSFzu4kq9FN8//0qECmODT7ITvORD1Bh+1wcQcjMlJh5tB
	hxBTGw==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8t3vccg5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 11:01:55 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-439b8d149bfso4419918fac.1
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 04:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779274914; x=1779879714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GI2hbxpBYvrJsq1N33WhlyERapASJ5myJdAz+CdIXHg=;
        b=OMOh5Fkt3jOFs0GGVa5+j+6D25HQSqP/WEokwMhyHCRrrrCnQoY5S2mC4CGTOPwU1b
         Cz8zWmZuEYoj837m3TLk5n3IwE7ogclSl5G+o7WxpnZw9+ToIchFnh9Evn1r+Nplp0cG
         TTtlCqHKTY9ovhMHoIFbARxVswAmfgs94Agr3H9o/7KrtMe5zRev9F7M+CBb2jz5bSeE
         WFsWng9FnTaV/liEmnZsNIKnOGJ2PhwHoZJbnrWz4ZbJRBdC1y0rrtK2TJxnS2/z6cCo
         NL18G2SLHdks/H09+e+z236XJYDvZShgvCJn8SA0tGr7HTUWmgr1PsC95IJa/xvtLddx
         O2hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779274914; x=1779879714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GI2hbxpBYvrJsq1N33WhlyERapASJ5myJdAz+CdIXHg=;
        b=dJL5UxLr0aRZxAWhFzELIg75mJltWDvQ7B6x+cqI29D0UWEAZfHxZKvAX6u8Qx16ai
         I3glvmo95fsygj7qSKu3s9ZZALi7dHzDwO2TMmvVND5qT4yOpnyFoE2jmqOcjOn+2MBU
         /IVg+rcHSEDk6XDkZ9ERtPtRxBdXQ3dj3gq+jeNKCS3RCrPPOdbLRJ31AU3/NJAR0hE9
         h7oJWf6np/1AxPnsEGaUAWFSReV2Lx1d503K+nurAzlEvIR+lUo9ZGE/ev/fCudxe7bv
         yeATLRaAEygoPTVMgQhYLmIZ3gOL9AWCwKT3yFjhGgpds20RqoznY+77xvS4lulyKCJ+
         i0Tg==
X-Forwarded-Encrypted: i=1; AFNElJ8AAy6gcd6138ZHNdgxvroK25rKPzKnEqY4wwaW7u1+WWkNFvuNJDC9WjqswwantX0MOwPOlAfCtg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOiRq82Hi69ixgvFl8Tzn9on4cltHvgcSrJ34Jcq+S4GcBM8Jv
	jnO30aijjEXMzHTZB1S+QnkZ+M9iyBymfr+0NTye2yoKIzVwh7tCdFb8DtYf3mhmUSObAxeHOnk
	GbKvAxcPPtzHJ5Uc93WEXv35yK7zBko/rYcYIUAQ6RBJsE4ZNSx2UAT1dVVX8qQ==
X-Gm-Gg: Acq92OGrRfEJKsr9ZzmSYRvqS8x734GDg92VsRg7h3a4cLvrztLmHKFNYnffQV/X/BJ
	VTCqvTtk5uySO5CDQptE+WHOXoNmVZWfZSV49Nv6D9sIN6jRQ4iawSfrrs6TAu0gqOx4WCIFmVV
	hu7K0Q285FLUGcpl45JVh6/fx5qz8Yz2yRdj9oeUhsxgAitMDBpKo2tMhu/LqfMAVD7qOVJCUuS
	5L9EnJVwLm42+WXsyNYcmfzeFAZjuI7KYHdt9fmUiIc+Wgc79j9MnFaK3atygu89IDFdJDJXkBR
	yPcXR12u72hAugnCoWP3VIfOgRkUXVhih9aZevbzexD1VffH/UNYg2+lGFZpwIdzbgbQapQ/bch
	Iz+czEGXBLvF69RxIdA8Eams030g6IpAs+Vw3feYwXs4NzAon9Cv03KX9tPuLi1QGzI03o3C9KV
	HyhIzjqU6crZszCA9q
X-Received: by 2002:a05:6820:858f:10b0:69d:50a5:5c48 with SMTP id 006d021491bc7-69d50a56172mr2610038eaf.21.1779274914422;
        Wed, 20 May 2026 04:01:54 -0700 (PDT)
X-Received: by 2002:a05:6820:858f:10b0:69d:50a5:5c48 with SMTP id 006d021491bc7-69d50a56172mr2609995eaf.21.1779274913931;
        Wed, 20 May 2026 04:01:53 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:9d48:e1ec:d837:6344])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4eb6320sm840310266b.59.2026.05.20.04.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 04:01:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 20 May 2026 13:01:43 +0200
Subject: [PATCH 2/3] Bluetooth: hci_qca: Support QCA2066 on M.2 connector
 via pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-monza-wireless-v1-2-9f6942310653@oss.qualcomm.com>
References: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
In-Reply-To: <20260520-monza-wireless-v1-0-9f6942310653@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Tw4SPgFtEetMhwNeijI-9Y8AJItq3pOu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDEwNSBTYWx0ZWRfXyHE3Pf9OjQy+
 VQar8SqGsRgwee69OHEogXKrAoEbMmPVwTtmevzXRudKjhHBjHzBGf/XdVlrdlBQIb7K+9loqd6
 D6nvrJdTKdHX0vcCYlH4zG1+ltPRw2R5e/NMDapS4uaQvGwnmIYaGtVXpQzJwpqh5bjxHhWFKcS
 D6MuuKbm69MdizxQTnFl/JTOs6FDUgtN+wnRphUePw0cOvsOpMmdDJCWm8B7ayqQh+ynmkLI1S8
 d6Vt7rqu+xGp0pfd2pv6KcMMBS2WNfigp1tjndVPN3fBLyDpCS08e+A938s0nq4joUfucFsw6rH
 jI81OJTXIqS9N8R4zd0X1eDuh9T/k/h+Mf4Ly3+i18zq9AlT2mgtUFjl6Zpy5SuMHIUgbCqFZfD
 nNaavtFKSiwKuVrJkiWB75RI6Vg95cQMgXmvByp/KH80fimzD+ZzXuyVSCysdeHJHl8w3iy61vf
 nanUlhdvUKXbVY3TNIA==
X-Authority-Analysis: v=2.4 cv=JuPBas4C c=1 sm=1 tr=0 ts=6a0d94a3 cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=CW3gqymaXyTMcD2nhgsA:9 a=QEXdDO2ut3YA:10 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-ORIG-GUID: Tw4SPgFtEetMhwNeijI-9Y8AJItq3pOu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200105

For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
sequencer rather than a dedicated BT enable GPIO.

When the serdev controller has an OF graph (indicating it is connected
to an M.2 connector), acquire the 'uart' pwrseq target from the
connector's power sequencer and use it to control BT power instead of
the bt-enable GPIO.

Also allocate bt_power unconditionally for all SOC types since the
pwrseq path is independent of the SOC type switch.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b5439b9956cfb0497e6ba6ccd9ed61224d23a9dd..de5cba7b7f44e280a48dad5d670fa2758d3268d0 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1873,6 +1873,9 @@ static int qca_power_on(struct hci_dev *hdev)
 			/* Controller needs time to bootup. */
 			msleep(150);
 		}
+
+		if (qcadev->bt_power && qcadev->bt_power->pwrseq)
+			pwrseq_power_on(qcadev->bt_power->pwrseq);
 	}
 
 	clear_bit(QCA_BT_OFF, &qca->flags);
@@ -2415,25 +2418,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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
+	qcadev->bt_power = devm_kzalloc(&serdev->dev, sizeof(struct qca_power), GFP_KERNEL);
+	if (!qcadev->bt_power)
+		return -ENOMEM;
 
 	switch (qcadev->btsoc_type) {
 	case QCA_WCN3950:
@@ -2543,7 +2530,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->bt_en);
 		}
 
-		if (!qcadev->bt_en)
+		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+		}
+
+		if (!qcadev->bt_en && !qcadev->bt_power->pwrseq)
 			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(

-- 
2.34.1

