Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3E5371048
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773183789; cv=none; b=f/qCId1kWYKwys4FA961qYucJPBgF4IWONn/FbcUWz8ZOeK0t2dXFls63KQYw6vlQRgDCUEzHM1G9UyiF4pB3zg12X+JhQJsYRIKI3lh1LB8ia82qPqXZ7Amb1gPC08tU9bXJ37CwQBWv1fcjKEoN71oMcLfdTE6gc2v9pUxVEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773183789; c=relaxed/simple;
	bh=pu7bkfU0sTJw0PsVFgK898M90i1JnWUjS/nDJwQDnEQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p49B2t/5+EL0YtBKx8kARa1on/akrQPqLFvAWJXIlMYbptLXFwdAbHGrcFNry51J/PPcbzchUVmAf5yvIZ7awozad38IUMI2ZhpN2fhvvJv5ShQM6c2yG1/wQhNBgagQsHvep8eyajLMCgYGcrLExVRETo1ax7fJpLsllhbvVco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BINbA6O2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EtGm4vyC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BINbA6O2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EtGm4vyC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AKJrjC1863458
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 23:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wTtVziy0BmhY8iETUxB30NLkUuDxGGFEQ8sdwaw/rtk=; b=BINbA6O2RKFVHWfJ
	+RA7eFapoXl03B2dwzpKVNARmWkMj/fHX90r/qGlSuYGKVlMFo/46RAgfTXggfUv
	ubtJFK9LWqu4Fh4SmjQecEU6WKkNO5+ZHPXNPUERUYJyQ4RvzV+PpEvhrpEFm4UW
	ntMOY31yR4vAsLFuNZggipdfCuEAWmJ8OlQ+NfvzJPBtx7zp0Gsuob3xHWmXPNH3
	fhwj+jg4jqRWQoHkI7GS3C214kO9jksZTb4peVSZ90KZIarP24PC98zY8ZDEkwPM
	3P3VmvJsx2pYdJKTO0iEmisyR50B0nLRNz+vuEV1nxLTSgKuvZoIjreHzVmVsM1S
	34dzDA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctmw81xgb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 23:03:06 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94e4b6c8cd5so12023279241.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 16:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773183785; x=1773788585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTtVziy0BmhY8iETUxB30NLkUuDxGGFEQ8sdwaw/rtk=;
        b=EtGm4vyC4TlcnKyivZNC3i8s3rXCXEVmG9nxWe03j0tlzjZigE8zLzyMkqiIQRsXdY
         f7CjermUN8uCWG+TqtZJOoC1WTPLwxLRq5szhM75GHIMUPatarvzPd/Gygwfwl/PCHe/
         NBndiSdgCobOzu0JT9YQQ96O3WiV1XJwO8ob+zvJvDyJBIxGeiFnMm5i0jXia9dAorQ8
         t8bemjyoegRxIdRaexjtGZ53dDog5XdqklvRuAUpopYXvS72VGLSYWL0yAYiTGSLelxA
         JctQAGGvfKZrnwjpQnILNlTvO7AKlibr7DkO1YuuJDnHiRTeXCpbUx8wkdzwfnDuuH6g
         85Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773183785; x=1773788585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wTtVziy0BmhY8iETUxB30NLkUuDxGGFEQ8sdwaw/rtk=;
        b=RBfO3XIagAlwA1f8BVxz/STw+wbqotF4i4iuPyFoZARxhYQFg1p7TqLfDGiR0SN6/3
         zd9rXu9EGkR/CMpaaZb9cyO0Nc6MfDiRpEoudK+cSUrAtBi2U7L6bGpjibFRqXwuUjAL
         hBnKFwiKECXqNAfdA6PxjfukU5YIgYXx4L1ILRi6c0+SvZHZon5cc+aEr0eXFuYBO78E
         Zvle4EytBYhy2zYw2gj6wk+B5ClgJDM4DDyQAZMuJzWU70YfGnK0g8SxyDmw6Ef9UjZ3
         C9Cr9jEWYXlJVU6Mmu6uNxYBhT2zy1pOCI5R4zNDyi8BxmTLgN5OGx9M/RMLRS9l32Cr
         /P4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVOP4ofTzpNdMiRmNYtust3J0kLXmcjNlPMoNuRBpHyB299RiWkAQeoFtGUTD4pQOE02pz1m40czA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTpl8WESM74mRI+2uHQScM6EYkVHMaqhvFLLet9tuFFYxUEv3+
	G4zbVO6C85Xvt7KK2UrpdzRwGYC98p1BoRD/YtOo45r5TyD2QoK1s1mDQ/Yz+PTGtMBPaZ9aUVG
	sHeLwTfMs/jYgKZRz62Ts3MFQL4BmR9Wfxgp2cQp9GbQJAhac8tNiz5sM7CZYpWTgiXqEGQ==
X-Gm-Gg: ATEYQzyswO6D+rj360bj/Q/2EG1U8nj7SQxE75CvjVtYT7eAOe/ix4ckq1IWnydnwwD
	jUQQtM3U1/hSI8XrB8GJxSm8LO3THEtMzyyvPXGxBe5Vfbnxm+LYkuyexNjNBzlKhtW72RvrsVu
	TmL3rpEe8Z8gCjdFx+0GexkA2WjKiVgbptD7qkKOdjooRdZELowVQx9NOobWuBu9gfbkfDvpnrF
	KtUCpgLK65Hb1tTVGG92Bo6+g3s7ras+ifdWfcy6HyFIJu/vskaWj9bPOlbcTZ15CiEExS0q3ZR
	KNpebxavn2lEKm++G0cyKaweGfqa2zFHqoGKqy9vqzmU0sXO7pswZTZpS+33x7TEvxxPvA1bU/e
	e7uJyW59nGHUkXku5g281xGkfVlQbs4Hn9KOuLc6IIpZsyt5gszMJvWccMlGVuwXfIxhPSFLsQT
	YhGWtBNtKhuc8C8uLuZ0TsaNUxxZFjOeAnUpA=
X-Received: by 2002:a05:6102:c0d:b0:5ff:f84d:eedd with SMTP id ada2fe7eead31-601def892d2mr184608137.32.1773183785205;
        Tue, 10 Mar 2026 16:03:05 -0700 (PDT)
X-Received: by 2002:a05:6102:c0d:b0:5ff:f84d:eedd with SMTP id ada2fe7eead31-601def892d2mr184592137.32.1773183784724;
        Tue, 10 Mar 2026 16:03:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a156366a74sm80743e87.75.2026.03.10.16.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 16:03:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 11 Mar 2026 01:02:57 +0200
Subject: [PATCH v4 1/2] Bluetooth: qca: fix ROM version reading on WCN3998
 chips
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-wcn3990-pwrctl-v4-1-70e571a18e40@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1484;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pu7bkfU0sTJw0PsVFgK898M90i1JnWUjS/nDJwQDnEQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpsKMjkalcIOg8DTrI+DqMKYEzOUUE1rjn2vhYg
 A64j7wts7SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabCjIwAKCRCLPIo+Aiko
 1W+CB/4zY+8UcBQpLwaFzqkP46mU2l1Pbpd2+NId95nedB1Sf0k+iuUty4txEaWnI5czWIfCX3V
 4yRT3/1IC4cJuaSvCbJt4ZjTZVf95IFu/y7m5vWJQPnHS74xzAJO5tDiYUV7GvULkHzduqKan9Y
 riaYYV2bmCnKP1SkbX+1D9i1MtEWeEYAWQ/admntR6ctNd2Ley1fSsSVTmu01NXeUEWfTSPSohT
 lBvVeUwdttK1C2ta4a0OhipfVxra+cCCS9ffMhIKYn23DN85nRoKgxrRtinVFMbbCatfpQIuI4o
 vVYyaMywUOk6X2SxlCA+IJP61QpSew3OfyANwvSBJ/A7MTHX
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: OFWxGNV-xcy1hvoyLfx_MS6IoTKr8Bb0
X-Proofpoint-GUID: OFWxGNV-xcy1hvoyLfx_MS6IoTKr8Bb0
X-Authority-Analysis: v=2.4 cv=PJECOPqC c=1 sm=1 tr=0 ts=69b0a32b cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=TaVSYX7Pq2PjI-6xwy8A:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDE5NyBTYWx0ZWRfX3Y3W88yx79Np
 qimaMAk/lIHP9/ygfUwLFe4ek2+jH1lq1Zi5BT3LA85hyIyuQD6zq1rgr0ALR1iSROUx3WVkox5
 vNtrwfYqk9/iNvi4D7Vd7u+wnKGwrCT0lAwRiFuRv3Nov7jhhzFaGpdHnE00j2ZbTbk2wO8/Guu
 KJ9cXIIxltCU0WTh57HayRtQmrOEaQvMGTnqrvDfKI8OnvPIHZFXQz9fdn7K8/ZVk3klnPQsiLE
 gJxBJAvMcDNvIrHuRVJ3ICVMmkApVUvk2jFs+ehXKkSUzhR5ILxQ0XKnjxII6/zvrv8+IIpiooh
 EHDU4oeqZ04BQlTJ1FFQ8qqLzEvh2HDM/hm5vLfdLaewGbos6eY4JBE3couLEQGjoVlKkEXuEDc
 IbZiCAmnoYXIZLSERalbaunhJuK4h81c0aQXKQ+s+GsrwWb7NVqXEtEfvFgq8qLqJEzbPwjnfRc
 VwaDL8JqEKold/luEQQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_04,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100197

WCN3998 uses a bit different format for rom version:

[    5.479978] Bluetooth: hci0: setting up wcn399x
[    5.633763] Bluetooth: hci0: QCA Product ID   :0x0000000a
[    5.645350] Bluetooth: hci0: QCA SOC Version  :0x40010224
[    5.650906] Bluetooth: hci0: QCA ROM Version  :0x00001001
[    5.665173] Bluetooth: hci0: QCA Patch Version:0x00006699
[    5.679356] Bluetooth: hci0: QCA controller version 0x02241001
[    5.691109] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
[    6.680102] Bluetooth: hci0: QCA Downloading qca/crnv21.bin
[    6.842948] Bluetooth: hci0: QCA setup on UART is completed

Fixes: 523760b7ff88 ("Bluetooth: hci_qca: Added support for WCN3998")
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/bluetooth/btqca.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 9f7e13fcb20e..dda76365726f 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -787,6 +787,8 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 	 */
 	if (soc_type == QCA_WCN3988)
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x05) | (soc_ver & 0x0000000f);
+	else if (soc_type == QCA_WCN3998)
+		rom_ver = ((soc_ver & 0x0000f000) >> 0x07) | (soc_ver & 0x0000000f);
 	else
 		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) | (soc_ver & 0x0000000f);
 

-- 
2.47.3

