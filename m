Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6303CC7FA
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784534665; cv=none; b=cEWGkRElcczkldbQJvjQkBNCP3WL1+KxL64fEsnXitVyf6Slfeb3nuuy7BdfMw28F8dYyhl+XKHthOyLTtOc+J90dwFSXS3uIXcttUybvIziPEncm1p2/aC7Ff7fuxIAuTVFfZ4jNDjWt86dbdR6DxqoUTg7a9PovPDwuEOwKpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784534665; c=relaxed/simple;
	bh=sBKai7E3Yd6U51Yiq12cr94RwHoduXZSxDW+t2dOViM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fd5dmoAUnkugvpl0VNX7dyJB/ennMNulYsxtY2UAEQZVXyTmX9/bN3IAk0vtrorcBSxsLLi8lC1BhCN25Z+/gTUJVIuNoHOazkRg69c3XK1aubZEXB9W4LgLyU7cLLMh3Wn3q7BhPtyKZl8PVVOjt0x+Ojz6bDsg/SVfqYWslhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SAdJsA0f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XqoVZd71; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SAdJsA0f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XqoVZd71"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K7rkZ02980062
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jCx7Bmpo4CVRX0C6gLLQG32H6cEbTnOZZEeiJrqNI3I=; b=SAdJsA0fXMRisTX8
	gVuhsMg2w0YDyNaqQFdxPmzW1jq66viAnkO93uoPrM0Y8UTQ09WR9bub79dYGoLh
	XLitIgyuQcKQQIgpWiYZGJ9b1g8uXShmvNu0wE9YWD7eDRExrLqhY8YoVoM3UP7b
	xgZbzWJE4vuvOEJ9OkbPPrk2WqJXfMVBU4cRFCID2DgIdSr/MtHQ3XdyqztecKCh
	9JIr1nW/2IceKShX8NAMj5JAZ7C+5yUiRTcWK41qSs0M1g0xK77ErlbNOOd/+pPs
	Vh/yNKINmNUkituC0alpfbvkP8ikq9KnwIyOgtOXhGdHy9wNz9u1EF/zHst6nLtt
	lXQUDQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhfpg016a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 08:04:20 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c21c01cf3so143591321cf.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 01:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784534659; x=1785139459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jCx7Bmpo4CVRX0C6gLLQG32H6cEbTnOZZEeiJrqNI3I=;
        b=XqoVZd71deCAMJlT4cnAVgd2FabGJv/Yx3oo7cDqR82VavkfqkUjRnghXTiu5n1eHx
         F9UePf5kDwgzAKViZRn9Q4nt1SJD3nojwLwC+iD3tWla7RsSRhPewMli2RJp7EAqBsIw
         hW5AhtRnBl9C1+kdKPG3PG6hZwOUhKpsS6jAJFU6AeG0BOSWxk2txQt7ixxOdORF2FXC
         BLTgT4SeLakWdIrWQYXHlNG7r4CCPm1ReXZFhXkXzZ4XqSl950Cxtuex+Oaphmycq7y6
         vEDf5eVcMeo2iM60IM28WCQN6gHt8GLRLVa86tmLIGqlPfdnokenyh5TmIdOMpdFJ9Ip
         9TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784534659; x=1785139459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jCx7Bmpo4CVRX0C6gLLQG32H6cEbTnOZZEeiJrqNI3I=;
        b=mRA2JlIXEI5ikoaI+rp0Ytl76T3byhUHn5Wz0+FcUnpvfFjCtqCG8DmgmQOSt7UXcb
         QkWqx4FvuyUO6VeL0/IjqkT0ufK7S+QcHgbU79ADJTzyXh4GNYoKoGtW4weYrRfKaXxU
         3EZ8HH1jPQuxXtyuWhwYiJx2tVnnzXKMBNMVwKe0hFsmFfSq1Hrqw6wlzgIoiBzTlJSs
         QGANvUulmT92hCIOaHfaK8WgGWyXKKSGvFkcEAsZqh+p3hgsXo1igSRZNhhj2loGPtY7
         lW3aqMifJMu1FavMXIXkQtw46Het+lypbcDINIkRg/UMH2j9j2HGCArsr2iwSGrEnsX6
         5jEQ==
X-Forwarded-Encrypted: i=1; AHgh+RqNkfxb4eoy/zJepHAZhk6Ei2ewjCCcktzT3tSzDWRyS7GKFA0u1sgbQkK60a7qi3vtmvQybiwvPg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkWdpWLohVHnOPM73y1xswWWWDXKRgA2441FZvJnRUt92YsDSQ
	3qpviyKy/XxOm0rDVAYvyZ+hvMoG1AZlW4GLYF44LdXT9pSUzXtNANKNATHtYqgCAgLDPb1T6P7
	Sj2Ba/JZTcaeriVpFAYOAGTpx81av4BgQeO26h6Ssup/Ju14/WIJ0CqxodFfhWA==
X-Gm-Gg: AfdE7clMFC+CRnp/aXWWd6Kbl3Nrma2eZr2J2uhinJGzjx6Ww/GQL5MmgVYXSQf/w6p
	qUwWmFbE3bwfiqw/Z+59lot3hLQSljMXZ4IbuzuVFAFlvILH4jOQ34H8ftFGMmtVl9xN5f3KdKT
	jyXhrfub8ds+ssVuMFsaJVFLIFD3IrljAtZ4iDDfEtyAN2eRSJ4FawmQ0YYz07d0FUOJpF2HOpN
	+3J+3llVMd2z3tnlrysGLtJ7dnkKNmdgTYklXaQQdanfcgCPchm59yqsjFmFgeXqEboYYoGRVfN
	9+nOfQHg+m3LxXV/q4pyin0NWelGuuxWgyUu3DFvW1YRqaN7r+660vyKrCb73y1/4HoaZ4PQTjx
	f4aNilr+FQmuHxaLelNF2HseSV4e7bRNQdc/+1rGjoxXpCDwMk8CVH+sJFZG4+jMX94dVp322ps
	TlEydOc3RlMnVOC003szYTJ99F7kkC4hAS4UoXXxjEntFHyhAylqs=
X-Received: by 2002:a05:622a:302:b0:51c:7b12:120b with SMTP id d75a77b69052e-5213ff50014mr113828011cf.73.1784534659404;
        Mon, 20 Jul 2026 01:04:19 -0700 (PDT)
X-Received: by 2002:a05:622a:302:b0:51c:7b12:120b with SMTP id d75a77b69052e-5213ff50014mr113827921cf.73.1784534658991;
        Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69e7000c3e2sm4256542a12.30.2026.07.20.01.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:04:18 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:04:08 +0200
Subject: [PATCH v5 06/11] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-monza-wireless-v5-6-69ec6743543c@oss.qualcomm.com>
References: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
In-Reply-To: <20260720-monza-wireless-v5-0-69ec6743543c@oss.qualcomm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfX3WBohhTfAVgk
 GRS0RoE+MaPIcnueQZFBuHz/nrze24Haulo0qv3Iiv9mExYtJNw8QDv+4uF+wmgzIBvh+DOsEky
 0q4M6sF2o8Qdgr0MiEeZRL118RmW8rE=
X-Proofpoint-GUID: j824bsEMA3u8P4Ye3lsvVra8Ua35tj0W
X-Proofpoint-ORIG-GUID: j824bsEMA3u8P4Ye3lsvVra8Ua35tj0W
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a5dd684 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=kStU6zbECEpzgAoP-VAA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA4OCBTYWx0ZWRfXw84qyEbgsDko
 3yvApJZickOiiLEVguT3q0OGo4iFIQUvDQn1DL95lyz/TJ4B0HZosvvis8qbyIJwDOGsLj80gvF
 C8elPlVqCJT86ufHkssE5OMkX+JdBlzABkKuYtZ5q0xga7q/sjrvPDF02Pg4Gh+BYo1PhKv0cuJ
 pixUY6/N4oBSwetnhioHmhPZN4LSiAIkqcBnmRK6BTU/A2nrs4KIEfN9Llym5A8RHYWve1HnV9U
 Ye0hOk16FnaS3tRvZ86aThUItvc4TL68mT/uouYBL/Z/0wtQdVCAHs5RNc+UJvSHmO1sn8tTHvw
 dvNnWyhprPNS4LwmxAyfBSp26dBNoi+1MD+/YnK7m4v2sOxhoR7I8pYPig/npxm5kI46mRIQ5b5
 muplJOZX5+5yFsi+P6vPYTwv8ae+SzvjZ5pfXpw1fbcUuC2CNjZ9inMYKupTD5/e0hbaro1jPkK
 eaAvC0DGg435w5PMPfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200088

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

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 17f436484e1e74d1dd690ada22134315abb767c4..81fa41915363ce577ad7c6f25fe1b0a69536d462 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2548,7 +2548,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

