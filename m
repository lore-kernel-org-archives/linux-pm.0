Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B33D4FDE7B
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536561; cv=none; b=czN/FhoxOM4qtjJ149+V5dpWXSjPc1+wRstmW43ew9pMW/zd9CzCIaGLlBUutWQT4n8AjSt0lgOxrbiFUM2Q7hopmgPpNEeVO6p8UQeoGhE3cLNk8UN1uNgB5caA96MWV/xjOAaQrKWl/HGzEHYyOj+rS8lQ8ykTdDl1nmS7keg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536561; c=relaxed/simple;
	bh=19QULZ5mc7UMmZUZ7tuvsXXvDMzyVLM7eK1cvidnb+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tle18FQ4KHq1OOlcIEXEML4sdL1dCwQp38yrmUKZz12FEBH8t6Sv2WHL8o+r6DdkUn2KkIVQ/3G7xrNsN1IHzhxgapGsJGhDvd0uY4AUrE75EuFm4NhqUlG/nQHuXfnvveVcpEgKXsrULgPILX+l/GmaP+7xrMP+fCelUMusIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y6JoBLVM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ceNn+G4d; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y6JoBLVM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ceNn+G4d"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiObk3874233
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wu4aU4+aLtX2c9UIKmkxVl2o/Ry3P2/k4p1oqgR901A=; b=Y6JoBLVMuh8timkm
	lujZVPaIYy2/KFW3tvZ1/aNQYBdB14v09wVVReNg58HyMcu7DOI8hnxdIvv1gU/c
	i7tkrFG9XvtohBsTMv/TfzZ/TV+h2NYeYa3pEovn2/HZJNiaSqQz9JQFYEpKfJIC
	aCKfEJPNDMoo//jECWQQbzkCi7adPwP9ukydwwpbLuNhHs0ikfT/wjAQZ6utwR06
	iz6NzM+dF3yhUWqhGeVeDCTRLEj9bGN4tSIFRjea3OTY1cOXeRhP9G1SCAv3oSC8
	F0GOI5H1Nzoat/82tfV7z+9IHZo5gt+PbZTqLSX4f1YXecTkwyeHIxyDczM+gnCJ
	aQBo2Q==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00yg99d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:33 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9808f4a12d5so103450241.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536553; x=1789141353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wu4aU4+aLtX2c9UIKmkxVl2o/Ry3P2/k4p1oqgR901A=;
        b=ceNn+G4diw6LKsjbtzrtswsFJnzqXZtS/LU454JaA+m1V9iJAMeXttVorowpPMuegB
         XkfM4jPeQN4V8cEfDIuwM7rsjmScHaC/Qe+vMkHwL0k7cCueaNS4XLP02kVPj5jBchwI
         rCfcdzFYcUbyqoswPcBSm6UQfCSq0EosJ8GPgAzyEvvUJhVtyjAtXMfmxcLN9TJZmXaR
         Aws0Q+SKmUbsCydj2N6euqj4tBIcPHaoUeo3Z/UeYcX6Vz3vJdsTqV0l2CbzXJsFaqaD
         KhP4/0iF5NxOvpsydrBiCNIIqBQXra5m56nxaByc1pNIicVe9wYY/DUeSGYJDvH0/7S7
         ewWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536553; x=1789141353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wu4aU4+aLtX2c9UIKmkxVl2o/Ry3P2/k4p1oqgR901A=;
        b=DPRqTh7FfbCS73bTZwjP1noZX8HQfjF7RTTqkzo0wawfk/IdoZ+dNtQQOcH28fUDWq
         o66uuASfYt5yaVug5trXayHNA1WShpgZ7xscuG9czvcm6HjJtU1LEI6bbjBjm0FCYg/O
         UtREAFGZS7vJJbNVkerBaOZkXeeT9cS1PRb3C0O2kkBmQIRLCsEUTXDE+esgTIOo9V8e
         UYi/F6VmpBuE8vsGvE+Q5zqpbhyzunoE0AVWEWeWw2GGB4o+u9PV3PI0Jj9adYDVHJnv
         feK1d61sd/5cIhY1HlLI9iCcFLXkvoLJBT7t9XlnOYpw/KOeCIuJPd8lbt6UEhCG1BdK
         zhTw==
X-Forwarded-Encrypted: i=1; AKwUvBzQXZ0wFwwaIdwoaFyaCTj/oItjVM7RXCWPVkl8jjtZMzqWKnuPia9GpYDhea61I0TrRtVpyb4pYg==@vger.kernel.org
X-Gm-Message-State: AFuF++kWfYzooNiHVuCegYWhyJuTOTWnW/edrWY/r6v8Sdzg39HbIcE4
	iwsH/2Jy04Ahtfc3+ZbJ+F0MJjI9GKHTIVQyJAq07bgWfJWc2mds7DR/4PrsIZ4e3aBpd5FEMwV
	VUKMlPdUfBbUokpsHkGnMqWxBTExeaQtCBz8y5/OYwpLimrCh7uu5tSfztg6RSQ==
X-Gm-Gg: AYBFou0tvgWIaLKUwV0B13V6BVZTc5+cozD/wHvBireiyzdg5hQ6vzai9TVyLoqv+OF
	smdAEMDwb3G3RCEuZGbRoiYgvVwFK1acPLpShmciPMGE8ryriI4urSzodzP0VBfCtuOHw3xKw4k
	OtuOfjFTMmcl7mXhrgLpXnXG7/ZAlccrpz5Gf9j7DUwLoM3+UN3YgPJ9izWMTN6EfdD8QdvXhxC
	POist1htrDrZb+s29Oimu92+SDDAOrCe5620+Z56m4NelwYTS4xFAKjBeDqhc9ge7sTE3YZXxI2
	0bMTi29e3Nz8wy1Z1ppAT8TmVAdwOKSYv7/BCoGgznBAcMWb3X8r7edKxNw2wr6D8ksREdTv3IK
	/sB+PXZGKv4kg6HvKuz8UvdO3BQ8jXxbVd+UBeosF2XJP1/8Mf7B9oLyJEo5he7u5I2UNOx4/M/
	2FCnPi0UHRJMpRNzcyrQPuwpkrfLrKm6Hs7W1cTVIhcOzaq29bpxc=
X-Received: by 2002:a05:6102:1606:b0:778:9e3c:5760 with SMTP id ada2fe7eead31-78a4a9621d7mr2056920137.11.1788536552865;
        Fri, 04 Sep 2026 08:42:32 -0700 (PDT)
X-Received: by 2002:a05:6102:1606:b0:778:9e3c:5760 with SMTP id ada2fe7eead31-78a4a9621d7mr2056895137.11.1788536552421;
        Fri, 04 Sep 2026 08:42:32 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:21 +0200
Subject: [PATCH v6 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-6-d8c5042b3efd@oss.qualcomm.com>
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
X-Proofpoint-GUID: jeB56XNCcAB-IWyaSgCVpJWibLZ5rxYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX8sP5AUG1Y0YN
 9hX+5t8nYcvtvdsD8MWrTysE44aZgBHIz8/EhvvIVBMFojvhRzZF4SAqsejIj47+hVaERMUXBYA
 mHCpAAZdG0SUWPL2+8Vw/bS9vuO9ZG7Y7E7nfHkGAfozVdJuSUJ+fNbuphVx35+eO6ut6kQtWAR
 6yjfQsu5JPh210BngFHT0hohJC2oNcVOnNEkU0G47FuZGAPxFg7qxsBii0psRd6CqPrYmT9+atA
 7sLuDePOb8R2QAS4YAaqsdHGWPRh4qNqtSv479AkJfKX3LOxtrB0hRlj8ZxY3T5ZcBlw8ZkvgKL
 +Fye/c92RmKBNQUrkJZPYWd1OEwGYttyzZdFEzUnaaR34SS7BXDU9XA/uJA7HFnE9HtHjkLkRP/
 PdTI6IMOsLCX0XIpKWl1anRSgqs1ItN4l7EB2yVI9VpLWhcrRczvYryUxPDxlNdKE6dpddJZQYA
 qHvuHDI75M8hLlyiTNA==
X-Proofpoint-ORIG-GUID: jeB56XNCcAB-IWyaSgCVpJWibLZ5rxYR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX5uu2ZxSxvdZt
 GOTXRmO+7v03DwkCfXq1oE+L4H74ZdpHSmZzApDqkVIt108M3c18v15HhxiqeMMpwVByiVlSdVv
 E9innEfy3ZgaoTxKJm4OsX5ixDI8i6k=
X-Authority-Analysis: v=2.4 cv=eZcNubEH c=1 sm=1 tr=0 ts=6a9ae6e9 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=8YyhkPy0JF_pzLATneMA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

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
 drivers/bluetooth/hci_qca.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index f7a20138cb742e8f6ea51d565aa8da8751f21f37..9d27cd851b4a685ce42201b0d40ca6ecbeec9cb1 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2551,7 +2551,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return PTR_ERR(qcadev->susclk);
 		}
 	}
-	
+
+	if (qcadev->bt_power->pwrseq) {
+		bt_en_available = pwrseq_is_controllable(qcadev->bt_power->pwrseq);
+		if (!bt_en_available) {
+			/* The host cannot gate the BT power individually.
+			 * Treat it as always-on and drop the pwrseq handle.
+			 * The descriptor itself is still released by devres,
+			 * so dropping the handle here is not a leak.
+			 */
+			pwrseq_power_on(qcadev->bt_power->pwrseq);
+			qcadev->bt_power->pwrseq = NULL;
+		}
+	}
+
 	err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 	if (err) {
 		BT_ERR("serdev registration failed");

-- 
2.34.1

