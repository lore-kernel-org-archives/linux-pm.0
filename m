Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6823C374175
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 23:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183791; cv=none; b=lcO9ZsmyRcRsjv2PC0GpcHhgT5y353EGuKNjdJBYncYGrs2mWRsZ1GBXPRewHG7goUM+cj7ysp/7sD97dQkljUy5RsZoVsEehi6N202ClnCdY3KhB+HAuNkN+2bGqtWOIpOh7vmkDrjInNMT6e0tw+ozcx7Eqa3+PmrEj4H//Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183791; c=relaxed/simple;
	bh=NCr7CWtfAODxD26EjaDhYPub6MJelC/d4IOGonNL63Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bMd+nrF4jl0vVfe2EO/Wnt7DAn45RAZY7oAV7c8HiUt4y4fNbNYp1BzcPSYQKhHo8NarIWZJOUIH1t6/Bot7TqKnse2JYPIjJ3IocVBk30scOWE8lzijMNdREl6VGM/0Ez/1CMwELjYL7B6w4HfKP+JloexmoWEBfppXPO7t0R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e3k9xC2t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W8YhtFCx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e3k9xC2t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W8YhtFCx"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AHD1nG1573154
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 23:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	11UQng+3pfL2wZggMDKPKaPFC6vPCY5zu9oF2jTjjxA=; b=e3k9xC2tPkfrMkBT
	SUM1ORpLnMa5V02VqCYi+ZX9j5MID3z3LDX9VRHLOD1j2fh0eGxjX0QgYv0tyhLW
	ErvS42rI7z485cXDk3PvwwP6hxvVLWkME2cQh00lC7VuH+LkO1eaRJSQa329sKkp
	cw8s/F+9vSjnhimePc+S9AplkofhC4ZbcRSSy5NmBJMcgcYVjlqn4UeqsudUn+Ra
	+8pYxNEvcEd150/l4fcSk9zoex69zJN2yvHjlM+MbRbee2dRfZxXB3kp4tca0QLh
	ehX0rvAYEinRDnPncpDNpDhlq7/SdduvMGvS5dJAD97O3f56K3bzTAVFhvjXL4I+
	xqEXSg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqgk94fc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 23:03:07 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5ffa63f874aso42346975137.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 16:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773183787; x=1773788587; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11UQng+3pfL2wZggMDKPKaPFC6vPCY5zu9oF2jTjjxA=;
        b=W8YhtFCx3I9XXN9ZhDAPOmcLAgOnFtAkJBcy2PzJbR/PSruXOKyJUNPSs38iBScZHw
         bWsPctuyc8jEO3E3QGQAIZFcuKeNhdSYNf93B7KM5RZiJOdU1U3RgggHH45Y6+dee8Qd
         45GYvOF/OtwW+TV8eqmsro1hNLHZMsC4ZBqihFYefayaZN4cs/qzCpQJyrIwYMNr4HJM
         qcnLoT8HfGK6UpO2p5Dh7/AH/P2B7xbXaN6eutrjXnWCO7EXTyf1VoyHV90ymJ7I7lNf
         qtsqVrGkMbvELn2BD8w3J4n7x8d6z8zCJQU0/X15NrIXDS9RVmNHuapRA6KhmP0jMUvp
         CxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773183787; x=1773788587;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=11UQng+3pfL2wZggMDKPKaPFC6vPCY5zu9oF2jTjjxA=;
        b=mA1zAYxlMH7kzCfGGJzdWzhQwtER88HO1gY/l0uTSSuuPfNAK8GHOg5niScdGDVwsk
         9SLPngbStV4qUzIifK7SCYOa0WWXF0JGSykefx6y/rD+99ojpI+t4powgHG0MaAagqyx
         2iWQODCfZzVrue02MlJvwn/DNvaYcUldjE3f7w6Ct/Wwq7BbNnOY047l1Yeh9REz9wpl
         vMf599dX19oirLertbIc9CNRVqsyQH/Z+SkBYJa9RxlChm0ewVoGHbe15ve6+B8vJVZC
         qmmE0F6JBLq65Bn0VFG3iGA3N17lPmFysrCpPRGOP9bg7oYQmhWdtP/pyMYE7DThJwh7
         GHHw==
X-Forwarded-Encrypted: i=1; AJvYcCUgkx6gJDIEq5WBxIhiQnv07JMtRS4beMMhM1nThET6JyqmLN/rD73nMx6o4cBfTPiw/dYni58KDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy22WLr5nOyazyH+bTCMckumO/+OaDT8iu4cEoYTnOnxKlPund
	CX6nbOJwLhh2iJYouyJ4nuK1hGF/SP28xOiGJgLj7jXQpvr2tCDeyLHOWChH6MVcnuXM43cjRay
	1H0NVhpoGOlZ9By2uMampSJm2lg8y8yQu4blj1ndNHwS1CTOQod8ynCtndiYFWQ==
X-Gm-Gg: ATEYQzxUrs0CjktztHRjCMdkWz6YysdgzyyDile10Eg1xI+mp3DNGkpIRxrzFfhxI7D
	zpu8Ytq3AnwvXhuzNjaiNydfxL9pAjiogd2kpdm0zZDe4zFSz+Qo83OA9xg2lwuIgn7pAPoz/jp
	40xVmiGQFra2oMkRsBEQ4B1GFoYJH3hPKhD8GZmIGU5knPQWVOJBZXiNrND1EFOw+1DiO9+ZzUG
	cIoFrJUJoDbb7+fdVJ32HDK+PXSx/j59Tm4LB3ARk6tqQxyrC8OD/NOc7L+iPS5zJDhth4B9KnQ
	nvG+EKuCHdu2FDlFiJn1wWZ7fv8adP0+ukQAg0NnsEmmSdnnmP1NRVQsfVSA5sgNEdoXBkbReVg
	0ez1kQs1NwDc4zTkHdVJ9OnwmTJj1o3o+JInZzXTSw6yLC0DWcbYQKzDBFisLx87XPYaDUzLiJR
	p5UY+OLUZ4YIdUl/sP7JGWVEnZjTuz5gah2jc=
X-Received: by 2002:a05:6102:26cb:b0:5ff:b8d8:b40d with SMTP id ada2fe7eead31-601def30d0dmr216630137.21.1773183786719;
        Tue, 10 Mar 2026 16:03:06 -0700 (PDT)
X-Received: by 2002:a05:6102:26cb:b0:5ff:b8d8:b40d with SMTP id ada2fe7eead31-601def30d0dmr216611137.21.1773183786338;
        Tue, 10 Mar 2026 16:03:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366a74sm80743e87.75.2026.03.10.16.03.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:03:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:02:58 +0200
Subject: [PATCH v4 2/2] Bluetooth: qca: enable pwrseq support for WCN39xx
 devices
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-wcn3990-pwrctl-v4-2-70e571a18e40@oss.qualcomm.com>
References: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
In-Reply-To: <20260311-wcn3990-pwrctl-v4-0-70e571a18e40@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Harish Bandi <c-hbandi@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2065;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NCr7CWtfAODxD26EjaDhYPub6MJelC/d4IOGonNL63Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpsKMjTeIHDIuYj4EJzWHo0r9XJi2oSJhP2xur5
 ikqas8iuDKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabCjIwAKCRCLPIo+Aiko
 1WayB/9BC25wqOSbwMnpowA25Lvof1XPsWrH0PhtoZwzgc9ikZVapmH2m6k/MeSwVKnTlw/IXXs
 i5iXH03VkT0KQi2c7uu7yBWMmfIN1BYbAgsA21hONjqQHGZYolwoAfUPciWv3DbDH/05JMLs8te
 JOI1KHOX021NHbZ0zdtHqasKVStyr5Cu/kU5prF5uVy4P6F1ZW3cr4L+KQIlVT2l+pPQ0YUqpB+
 6c/sLth+Pln44q2x5QyUHWMYGFsMdFNWT6tg1bLgbifH6srluGefFjDjcxFtw9zqexxelqDOouP
 4r87Bb1tA0zi1Xq1yn/v3TCC2XH59UYFu+Lje+3f5IdkBBAl
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: qLPXS8oVrwdpsZNrkwI9LsBe3x8jWyGM
X-Proofpoint-ORIG-GUID: qLPXS8oVrwdpsZNrkwI9LsBe3x8jWyGM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE5NyBTYWx0ZWRfXz4azUU9QfCFX
 GfK8QBHhWAF4m+prkQbe9o+hV9K0JefDj50jlKylJiODUlQCkGqYTbwNMarGtCXFeGETGmCd0jJ
 o7b98/48W/mGUNgBtgVmfqswD2WuLC9M/rx/88yn1KAE6GyVP/j6pc3gz75Wedy+4/Tmlrvb1Vf
 T+cLzn7jBHYOoAcQKntsEpcfQlBzxfG3Oi5BqqzM72dWhhGuXhc4IJNzUmJWtv0v8WqoBJXW4ZH
 sOp1HG9vS33dulMlcxBOeTEqHrOIj1/lrAPVebRXGHmpBtdRUamZhQeahtbfpf0GM4pIkPf7pYn
 HJ1INgVAZlUrMVXMMAg3WOeoQN/zVxRaD0YPSFUXwsf57fGtnTvMl/zX3a48ag6chhFpXJwqFNk
 Gd3F3k5PlCSkqRxLTTUuvA3jpVL9xdnMY+eFZ476HW249kO1ek6yxuHZQA471cxYfK1bmExJBvp
 +0L5zNU5I60ycuEmQAA==
X-Authority-Analysis: v=2.4 cv=M4JA6iws c=1 sm=1 tr=0 ts=69b0a32b cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=rVzinPZZyXf-EJmd2kAA:9 a=QEXdDO2ut3YA:10 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100197

The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
voltages over internal rails. Implement support for using powersequencer
for this family of QCA devices in addition to using regulators.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d6e78201a675..c17a462aef55 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2241,6 +2241,18 @@ static void qca_power_off(struct hci_uart *hu)
 	qcadev = serdev_device_get_drvdata(hu->serdev);
 	power = qcadev->bt_power;
 
+	switch (soc_type) {
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
+		host_set_baudrate(hu, 2400);
+		qca_send_power_pulse(hu, false);
+		break;
+	default:
+		break;
+	}
+
 	if (power && power->pwrseq) {
 		pwrseq_power_off(power->pwrseq);
 		set_bit(QCA_BT_OFF, &qca->flags);
@@ -2252,8 +2264,6 @@ static void qca_power_off(struct hci_uart *hu)
 	case QCA_WCN3990:
 	case QCA_WCN3991:
 	case QCA_WCN3998:
-		host_set_baudrate(hu, 2400);
-		qca_send_power_pulse(hu, false);
 		qca_regulator_disable(qcadev);
 		break;
 
@@ -2425,6 +2435,11 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	}
 
 	switch (qcadev->btsoc_type) {
+	case QCA_WCN3950:
+	case QCA_WCN3988:
+	case QCA_WCN3990:
+	case QCA_WCN3991:
+	case QCA_WCN3998:
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
@@ -2449,12 +2464,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			else
 				break;
 		}
-		fallthrough;
-	case QCA_WCN3950:
-	case QCA_WCN3988:
-	case QCA_WCN3990:
-	case QCA_WCN3991:
-	case QCA_WCN3998:
+
 		qcadev->bt_power->dev = &serdev->dev;
 		err = qca_init_regulators(qcadev->bt_power, data->vregs,
 					  data->num_vregs);

-- 
2.47.3

