Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F97347F79B
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 12:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202916; cv=none; b=XX5d7pFRNXPrcmxpNInUpka/E8RBhODipdA56aBq4Ia9xtjLisVjscaB3dZ/yB0qq1Wy37eEWYaW9yGA7IksBzQnAfAcpDLPk0upISWTbXelfPf3IhEGhSdhsL/2txCNzGawvta0kR06XMjOCp2P0szDfj4k1zyLJ8sjQ7c0o7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202916; c=relaxed/simple;
	bh=eDxLstZ3YgSwfZ0PeFuQrJ+uoiKZuKQRYECamWj3BTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=erYLfui+ki6xTxTVXQ+zw7FVvvQKXgopFf96ix7LKPc17dPk8tyQv/q9xvm2O8G2kXpiv284m6eGWZQZlM3Qh2C5xtSP1P6Gx2ZT6jkk07jj71OMgYPwReY0WTmeZKb1Id9Loy0UYEjjCgiciecmb6KGxWw2S7AOYFncgRxmurI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dLZzHG1q; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bE2+0KfX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dLZzHG1q";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bE2+0KfX"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFIcQ2897502
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 12:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3rpgZ8Wulh6l2hs5o0xl4E6pGMgHsW9mZuSvFezpNgY=; b=dLZzHG1quqkM18Cp
	Y0SJ1SO13p7c+TaJjFR3d4zZnO6mtGsrmTx3cTsSNnO//WK1GvXjJvI0RQ7KUYW/
	mg6pJ+StKT/cJZVUQk4VbVPxmdIWHT+rLgZdEioCg4kkXjksdcFFT6Mlv7F/68j6
	tJG126ouUHo3yjoLtyjsTxe4uGCwnuhMCpHbIDBwINNcOH52eXJ8BxJ7wblVaFks
	Nxk9IB1PAxoaumJlHGGs4Hso6m3yNZcBiEkSeevF+YqLbgO4boXBf18erVasRD8s
	CXU0fARtLEYL7nev0e9K/J2hgqDPDOqSn5lhwfjM6azNS8r39AfiltPw3SIDn3JA
	/aia4g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2sssnr9x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 12:21:52 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93e46b4b700so299639585a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202911; x=1791807711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3rpgZ8Wulh6l2hs5o0xl4E6pGMgHsW9mZuSvFezpNgY=;
        b=bE2+0KfXlquQXVjWM2E0rMWCqUm7q2gDK4taw+Z1qugPPJQRtNj527gRyDjlA6kMrL
         7JNZ/KLgY2/3WxGyfj5eagaUl+2KXbAe4fqiXNoWneyUK5V865nJhCPxbizQTuIYOjCq
         e2mgf9rlOxjtQMnmHDxdiiFOA5RZrQBjMrVaViQ61Kn06anNPjb76UZNlQZH84n5SZTe
         nem6Z/9hq3LYut8Tf2LpT4q9XKAptm41Nu+KH/rOH9hUmTIiO8XP78+UdFcxSmcR7ccb
         uQxVna2vNW9AOO+32wTY28RLfLPEUO2lJkwlQ1lMsOjHpAoMEFgmSRe+hfhMyf9FV5vE
         vYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202911; x=1791807711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3rpgZ8Wulh6l2hs5o0xl4E6pGMgHsW9mZuSvFezpNgY=;
        b=dfNJc+CiQHQNNNCMz8dR+dImVBjJkogkWIXtmzvTRhDjsJYAHixSZ5DtXxFDx3fPJL
         7V96k5/CfEBdADhfEtb24mEHK9RnVLybb24RfFxtPCIX4WbgXnL8CjX9bul73qilSus9
         DVdPGLzzeubsYCwW+q84x8eHO4JuPZa0PTLfZfSo+gUQtr7o92MF13N0eyhWxy4S3oYU
         K6ADwaZvOqScbBrmdkwkW07zJVN4wh2npdd/8Pfc4CSBWMbkE1CbnQ4LnLSqZ5RPFqCT
         041wfzzqaxUk5vcBtMhPpmnERfEO+9LnxpSq6udayMKfCc9zKC8dXeVBj5A4lBYOEgQd
         Px4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwfd8vUWAB/lm765hOL9OJk/TTlRCTX8uT3ud1B0SLIkSvUyPnmtmTuyIltScAoaDFBS/tGgQJn9g==@vger.kernel.org
X-Gm-Message-State: AFuF++l/eaoEoxbCFHxusdz8x7xV26ggfJ1LAycFDv/Mok5QKdcsD9qO
	83QztI6CQpeypyFvbbzxVZDOboE2FQc996iLuwfEbxJKx7QvTI6hPktS7WjiL/czlg0rxsIxZdh
	suQRSUyWCBXeBV/JPOZfAguF5+ZL5zzAQEtWWLPGhYNoTpY0Z3sjim5qt593pSg==
X-Gm-Gg: AYBFou1AtfC4QmK1M7jeNq8EVD5IVFCOw77a46Jlg6+QWEn8OKnKZBV9Jahd5SScf/N
	Z3sL2KSwL+1QFp4p++yBFTe2UwdPm44gQY8JlVyzU/ZZ/Tpo5ma5qZl6DlLw5p+lYYmsD445OCJ
	x++DLfcrjDy/x2pc/BZG0HStYOi+pKL0g8Eqmyjo86jGJCnA3e+Y5diDj/6w0hHt6iXHMBae5bE
	YLe5g1Jtrp4ynDVy5NKef9yFf6gy024oJkHmspUfc/dkJ9VDgoTXrbJdy5+Yo5BghNEFil46YdA
	s69cgJJlfjvyUi7z3pOMLybeMePCfpowFbI3Vyi2uIvUofcUv0/XLhihXX73P2EBBa4cz2f7uGW
	r8/8LeFDF1CnYAGQCEOYwIMqByCZAfDCe828BkS/arrIEfbtz2DMx9JdMGO5MU5X4rqoUetOPuZ
	IPuQEBHSyKXG1RqC+R/4ZyxrB4DMvP6aFhplCSnzZ5FkztgN9HxMCyPEajh8Oj/q91112nvA==
X-Received: by 2002:a05:620a:17a6:b0:939:fce5:f6d2 with SMTP id af79cd13be357-93e50fe9ae6mr1314321985a.27.1791202911120;
        Mon, 05 Oct 2026 05:21:51 -0700 (PDT)
X-Received: by 2002:a05:620a:17a6:b0:939:fce5:f6d2 with SMTP id af79cd13be357-93e50fe9ae6mr1314317685a.27.1791202910624;
        Mon, 05 Oct 2026 05:21:50 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:49 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:33 +0200
Subject: [PATCH v7 3/8] Bluetooth: hci_qca: Set 'bt_en_available' based on
 pwrseq power controllability
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-3-5a6de7662dcb@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX31hHTNMEQjs+
 fHcODuvUCkOTo4YYuKGC4OzUtEUnkuilLGvNNYILirF8MGl0yGgNnLcDuHezexAFE7EC0eRfASe
 5I/HzK8bM3Ad/xZ6iikm8KVVU16fh3k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX3AIA1vMQEf5C
 X5pqdwLL/sxc9xqA2wyz3gZo5PwMNFc2hjeol7w1CwEk05A0e2b8ko5vLDxqqDkMuHWo8MYBQwy
 efZYIwzF0963mpII/iEoBTWttOav8W4W7+YACWpilFcIyel5Bk0rq4DobCrJrX3ngUeyNefkHgz
 wkqchgtAkIbIwQSsnv9wmUC9Kdo9UJKv8j9fk/xmawgDi5k9wuqejnczWs6dP7pFCpnODmr/6DL
 sVDTDnOwWzZ3QR7cxcgqaI6JvzeZmXNkYYZUzxMwXs8rbqxX/m5QjppZMq5g7J+dNyusvbleoF8
 LReNVIxhPxC3+eqnkBkfoAH3AWMyQYscfhM0Dj5a+opGq17iI1bsCYPzWnLyMkWGHPiUD3vP9Z8
 BUbsqZ8OEjLq7hMQAtyZQQIaD1/nKCyBPEIDfhR9S/+DubEbt3EFd3IsgwCy9oHkd9mDEv2IGsc
 x6JcdATecSXkqaopvEg==
X-Proofpoint-GUID: LVpG6N5sT6W9MZAj9uVeCWPVPH9xxZVh
X-Authority-Analysis: v=2.4 cv=HqjjiETS c=1 sm=1 tr=0 ts=6ac39660 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=8YyhkPy0JF_pzLATneMA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: LVpG6N5sT6W9MZAj9uVeCWPVPH9xxZVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

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
index f53f95601693dcd8356b4b825776317061050f1b..20d8c5e890a8903a07c3e7e37d037c44d383e8df 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2557,7 +2557,20 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

