Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429544;
	b=bMZ8bWXKtR6XOYDNLqBfxzQmLthnXSPEDH6j/MQFEzCLcYn1820/S1NqeSZS5oZdUaKH
	 Vpsthg4CR3p9TFcYXSb8kC32yuaHwYRkfb2tSZr+B9YkTVi/rKkmwTMcz5UeAuqPTx5c/
	 nLaFDpq0AnZyZMiJQxng1Ips2RxE5hBia7nuTrpgotiKQVgoX12U32R6dhT04DKh3Wu2n
	 6InniITm36/2xjQ6suxVNIfF/7ZFxBASiT9OF6G2o4L/xroW8OpeYCbjPrEUZdXgebrNb
	 Up/RCYpfPO372sEaErzSaYXjaSGuSGvJeeAlHanIvJQRUCuxXNeQFvk/qL3T6bQUoFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429544;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=zuHpqQkWP8DCxuWOtgyzddlRMbuSJfJbAsNyifLrpAY=;
	b=FGAewCs0UN70YMmUvW8eD4i5hh4VZJGKePFGeh4nrDoO2zx6fIYjDsJ/Kyqf2ehPMCWX
	 wsWEDQFB7UFDw5XwFi0jFwwPDCCz2VSvIQrp7QMftzznJ8md67A4HPiEh50SCVRJfjf5M
	 WdkQtOpRExeRJvHYrsA2HhPvUA73ST1FZPefnV43DJFOAo/thmYG2bmbUYBFmmWjzfREZ
	 RuTojGHeJnoCH93XsA+XeHfE0FJBRpVl8Gu2vmHmKjzZwO9er/55AoOk/fvXyiU43wAgX
	 +fDsWTRUKvZSvKuEDvf/wbV3O30SX6oZuR6XLiqZrAu474vAjVffypnAX1or2wS5Sfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pzMhzkT3;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BIpxouXS;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF042606A6AD
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF042606A6AD
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pzMhzkT3;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BIpxouXS
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AN9G4gm2528501
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zuHpqQkWP8DCxuWOtgyzddlRMbuSJfJbAsNyifLrpAY=; b=pzMhzkT3QRT3OAzR
	CB/AD6PqcTEBNKUx0VU4nn0GAIJvP8xn35LrjLiZrtDog62ek/bciB47YEzx6fLY
	oK6yaUnqAq5O7nEzREivPypxTMeHcHCFRb8yLKQP0N04+x783La4SvNZvA1bv8aD
	cr8GCIvFc/TTvgsb+y6pHfroWg1etk3gRaXGwxp0lhNEHXJPW/c60R2hOtFJAYaf
	94it+0Vb73SV5pf8en9IkpZ/atBav2rhtVwOoy+iNV0D6ocFeVqMFNLDQ0rUWdWP
	7AvgLTY6Rhni7l8EQlI32F+7x2p7pPS1rLtYjDEnm26VC6IwkhWWfIScdkxCmjif
	DJANwg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7rhuy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:25:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93f5844cb60so575993285a.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795429541; x=1796034341; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zuHpqQkWP8DCxuWOtgyzddlRMbuSJfJbAsNyifLrpAY=;
        b=BIpxouXSSc/54BaODqdngfTIsb32KsP120FAsUwlUFAdMc76dbcxIPthYftn7cjNbC
         JDEJSPNim24fLSfbrVLWcIC2GVNX9tQsVB0AU61T95k9130Bk2LyLZayosCL9kRTNU6J
         2UobXj6T75Up2FdpXpGWQChLDdDjCJIUYPf8D+pCYO3P5h5Ks5Ai+se74s2/iUYgWe2p
         2gRB0z5ZwdUX9V3p3N8v86r8CF+PJjsTSviZn06sYU39O7z/LfzP1WDt3OGEExfSJoxQ
         PS//zqZhA6GRuykuA2VhomBwTZXt3C1pcHfCF+sxq2X4TBDlU6umwQ7i68SA8hlUuwK6
         Tc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795429541; x=1796034341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zuHpqQkWP8DCxuWOtgyzddlRMbuSJfJbAsNyifLrpAY=;
        b=UoV2tTw0rgFOdpxlF3Juece11dEfX63X756jvnhaQmlJiEdWOo2L/yGbWaqFdNLxfl
         taUa7vgx17HNth+Y9xTuR/wjzg/8VQrr7RY54FuhojRGQ6SJCLkxsEJSq2kQj7gt4pJM
         EiVEhLA8VRXYc6u8etJR+PR6rdnkEaT2yNWOBS0O/BQCclKJK+vLb78jfVdLI4nfLPw8
         E1kvy4iz2RjyCv7wRtQ8T2gAde0wCVpCBZEhHChwLKLrFf0gdjarZo0Cwo+pXfknaYS1
         5S91eyQAk8+LjXwOmztMEMGtVNQNaBvZeNW03euU6Su1ydzEq95cHtRG8sbIT+GvQxzW
         uHQg==
X-Forwarded-Encrypted: i=1; AL+hErFOR8QR6DuX6IDTDt/3tRrL1HuG/VqDtAn5dZ7VIHMwy2dP1viWD8u+Tw3xS1g2ne3hcEObwvcyPg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/r8ZvkzaAZHsZjJNsxtvO1V9sTQFXGSnKguzrb9835FKGScnjQ
	jSTVs0PrKTqIpv8CXnsP40wSHDPz0k6WvXs0EDGkffdtVa14S6JoKQySZb5cndvpQODffh7gFOe
	ddlOBe/Mg4Ea9ilKA4sE1CE8VTQ0fo1W2bUHqNGceRMC+4wZ9D/Ypp5YWacoMDA==
X-Gm-Gg: AZFdTZfyaYbnJTYAOal0pqvXmZ9u5WjH3iQk6u6Wf0vlh6nuTFHsrY2z+NVBjI/BGP3
	riA9V+b8rTcW7krSqbnWyFA/LxiacMZSkuQtzKm55le6KYClPw9tl4Wysdke9Jo/5Ialt4cLlKY
	LJ2iQcIi3Pz7p010FARcHuoQdGtkwKeZi9PDBn9DWqY9RP8DAR+wpYCy+v7CnfuJVNY+vjKs7sw
	z6LxWHdf0+TNvvXjbMyUD6edrrdDxMvmJaxpZLxXLKUxkVBMEV4oH8/17tMqniEZqPRhyzJW4VQ
	mtmKbsNLdHwhtK1KaYvXV0hf+USLPTJKlnXWvPDxXTy0F6WTcPK6/YP1i0rGoeVRd4Tcrc6Jir2
	KYZTs8kglA83goLtnL9R6ZiB43Ily91x9QRgqw3eUe0fG1omcNDYFvdTKdsZ6DLhVydUWVnrFcg
	aowjNCYsmgwsiqRTRu/ijCNf3jg/HvaGuknafvs4FhSC/7+KsZhZ4Gid/p/DHg2qFQuus+WL+CH
	RKiOtWzGZXuOfepNMJzyec09+mk
X-Received: by 2002:a05:620a:2243:10b0:949:c64a:82c8 with SMTP id af79cd13be357-949c64a8922mr965994885a.39.1795429541201;
        Mon, 23 Nov 2026 02:25:41 -0800 (PST)
X-Received: by 2002:a05:620a:2243:10b0:949:c64a:82c8 with SMTP id af79cd13be357-949c64a8922mr965992585a.39.1795429540713;
        Mon, 23 Nov 2026 02:25:40 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:58b4:dc38:81d5:3c3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b09bsm634166845e9.4.2026.11.23.02.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:25:39 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 11:25:34 +0100
Subject: [PATCH v8 3/8] Bluetooth: hci_qca: Set 'bt_en_available' from
 pwrseq controllability
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
Message-Id: <20261123-monza-wireless-v8-3-a8b38604be6c@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b0414a5 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8YyhkPy0JF_pzLATneMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX9CbDm/Nlzx6B
 CMRe/Fjzjs/MKdybUHbbGtCZTzp+qLv9LvYNJQyToJpRn43j91vBP6maqxSL8zkZld5JAEFxy7s
 C07R9wtz4f5usvOzs2C1eRiLh/SAbtJHG9Q3ebulTwBr8ivbL0kglD8kPwTeQzT/JfD3b4+lubH
 55Q+PcWWeOZ3rFAA9LwYzA6rIg2YjHQzrlUuFtS5WR/+ffQWBwo1wDmil90qlBAka6WCY/hmZ5L
 Bo7es4FYSen90T4fKX+1T3ZBjtjDy0yd7UWIqK32/axF2usp+O0O6I3O26Zq4KnPt3rdTkfrtxj
 omacYns0/5hdR0/3S7Zg2XvKUJiNOCdWik/cKOMpPlEBlR4Kr9RpznyZ4EdLV6NgoiYnY9MgOYn
 b4NPzgfdOPhz6W1OJDkmrGjzPphhoo7gJWfss+8TGXJxZtGostV8Dcz8CY5bEChkcq82q+U83A+
 61t49IQvXdW5lRRO8iA==
X-Proofpoint-GUID: LAgBLqaqeGwLvHxGDJ0O2bjauyEBEWX0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA0MSBTYWx0ZWRfX2WD8qOtk2Y7u
 qmItQBWI3GwJdGiVqcy9rUxxGZpugAt7ZW7lp09UiixdG55bBzbuhdSuPvytiQZIHtgo40i3nM0
 PeK7MjPM1JfMDB6VVpnY3aLoWRFr958=
X-Proofpoint-ORIG-GUID: LAgBLqaqeGwLvHxGDJ0O2bjauyEBEWX0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_02,2026-11-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230041

A Bluetooth device only needs the non-persistent setup if the host can
gate its power, so that it is actually reset on the next power-on. When the
power is controlled by a power sequencer, whether the host can gate it
depends on the hardware wiring, e.g. the presence of the BT_EN or
W_DISABLE2# line.

Query the generic pwrseq_is_controllable() helper whenever the BT power
comes from a sequencer, regardless of which provider it is (M2, WCN, ...).
If the power is not controllable, clear 'bt_en_available' so that
HCI_QUIRK_NON_PERSISTENT_SETUP is not set.

This is based on Manivannan's original patch that keyed the decision off
the W_DISABLE2# device tree property, it now uses the generic pwrseq helper
and handles the always-on case.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 3b2792a3639cfbd9ee7a781b6e4c26c660495391..1b7b011cd6adf682677a01bd8d501a92ce896ec7 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2631,7 +2631,24 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
+	if (qcadev->bt_power && qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+		if (!bt_en_available) {
+			/* The host cannot gate the BT power individually.
+			 * Treat it as always-on and drop the pwrseq handle.
+			 * The descriptor itself is still released by devres,
+			 * so dropping the handle here is not a leak.
+			 */
+			err = pwrseq_enable(qcadev->bt_power->pwrseq);
+			if (err)
+				return dev_err_probe(&serdev->dev, err,
+						     "failed to power on BT device\n");
+
+			qcadev->bt_power->pwrseq = NULL;
+		}
+	}
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");

-- 
2.34.1

