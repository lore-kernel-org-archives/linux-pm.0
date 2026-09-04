Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86DDB4FB9C0
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536553; cv=none; b=UXGIprlu01WE+aAzrAIpi5smAI8+NQAYIEGk8uRtqHaeYU/lXu90Zfnm3bol4HkCq3zh9bzKP1fxfhMl1DeWdc1w6eZ4N0KmtXMcm1HDC1SHOgQ1uhEec/vqFYsJsuwxRmFuizjScYCLtkDetg4pDXywPa6FO2tpsUuwTvIRacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536553; c=relaxed/simple;
	bh=OAyBvAGn77FVJ1TEIXYkJmoJP05YhYEzxSuqREVqRmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DGVeRq+mBwEsG0/UJSubwTmSMMaYJUL1pWTenLTMj6RKiy6juytu+t1RG6vNAWBC513pruYzMiolBgYCUNI0UVBbPXHcMmY7geHl0rKLhzXTjlUx60GFGlF2LB93FRineWTZXaE9mhKvcg9LU6kIODfhaZF7YvB/jErh4W/49Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iGBeXoFA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HbXmA/A9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGBeXoFA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HbXmA/A9"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiK8Q2669647
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VylTNBJr2gT81asOG9g7+O/m6VUb/i0HgKb0Gfyh7go=; b=iGBeXoFAs1uNGu2s
	+Pc6BIlzA8meYia0mNjGynetdm2Cg/bNmAvjt1IWU4SLOw/6ifb65VazWT3UPRNT
	eUo9SOuuAsvxCXaVJMnFGFT7DaajvVSk26ezHGFQVJa0uqjH2jT6ZyVQ1KLNAgvu
	b/EOZdr2jC1OFSGDQdTHHliLXv/29B+MgJrYbKnnQcKIEjrbCCqzHEzFpo4e3J5e
	pDfGiVZqNuGFMf5tXcjeyHBGHB7lnTeLGHcSUS+i0V241D1MEHff038ovdOKk4FN
	5kZOtk9Qu9ti1nkZiYrrUPxy//waHoPfT2B8tts2TbgUtdvFawNgk4xYQxwg2UB/
	wEUTSw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00yr8g0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:26 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-73883529f72so957449137.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536546; x=1789141346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VylTNBJr2gT81asOG9g7+O/m6VUb/i0HgKb0Gfyh7go=;
        b=HbXmA/A94JMGOnXZtSX6ewN4PIAHXn2jOQ2vI9+uGOPZVi7moTYYO4oabYQQMh7ORE
         8sYw+cmq0SPBxtE7RIoj4EVZonDZViJAh9fT4b6TkQusaXYbcfBErSLikWKyHKz3yU8N
         ciYcSZNOZPVSO3QCkNJH1nbNM+xkJr4B646va9objZqpJ2kytPv4V3cE6fPoEY1PM7Nl
         im6No+pFPhyv507e0sSiszEAl0gmTpHMsh/DzWTn4+wjdKuHA4GwhfVXKaGG9zbDvf/B
         oUGjYzNmHU08CqMj5cDKZYPFlfCrgiMqhDSbIZDzHCiPJy+mK5pKYI3axi9LJboVmdPO
         T5Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536546; x=1789141346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VylTNBJr2gT81asOG9g7+O/m6VUb/i0HgKb0Gfyh7go=;
        b=TZk/OjWFqMAUMUgyXJU9wPdO+TEEZ2UN+18GAw/ppBEBwNXyAsuHAq2NAiggUvqTTY
         dlIkOVnxfPzbjjUxlqcndBD7T4CAa9v8RhC0DliZW8t5LBhM543FVEpBPyEvDipZ/Rnb
         e3t1bn3gD8WagZgOhGiNAiT9IROj6SjnPnTRZr75lZ0C7pY7Ksmp6a5E9QbhQMCnAFeK
         lUIa//GvB0LhjsTlrENuQxyi80ORuC3gmO0qxkGuO1xFCf4qyZGDS8641YfZxC6CjtQB
         oLL3OJKaq8sou7sxa1CYIGPG+G//UAgvRgyI20YjgB5crEU6saTh570CnMr8Y3rp1Mfi
         v1SA==
X-Forwarded-Encrypted: i=1; AKwUvBxobpMrpuPzUh89IB7k3I/8xhgXdxwNjElvITM8Y05KaKD5UPb6PY1VxK8FCEmFAAd2BFcoj12Wcw==@vger.kernel.org
X-Gm-Message-State: AFuF++lqqGFjHXqP9+G0GjZTV1QQvgHIPlY0EyAsUZQNDb1nlzjV+p6u
	b+uP1MUmFuURMAh4esnLwePRAPQFkw1dKXY4vXnplUu24+tRQL7TcnpEUclbr4kuEFeT5G9IvPo
	zVjg8f52KTZtn5Bkz93N1lSjFD53vOEuPqyygMCnJ//wgRBfDms+DtUoTvWUkLg==
X-Gm-Gg: AYBFou2HssQog/ORBatKc7BBIHKZITbANMct0qHH9tYuLVQBte3JsMrn8W1ToMTSg3g
	BTeD2mMjWEwjaiR2jJdHfkb1B0c4rBZ/gF9KnLvsNsG7+6wosK46reApsiQ/hxn9Omgnloob/eb
	3L4H2BuBfjRFEomSPP+WaIbqC9qGYRyhI1FH+LOEchvJVCsUNEbZqCg+IHNAzjN0YUTEsT5ev5B
	zvC3jfdb3RrpKM4wcV80hyEimuqKBTFhHqiMBALG7qZZESm1VAniYcyyAywp+CvZZJpLY3x3paf
	czNreLm2r6SKOfL9QN+5XyIXuLDnyzE8PBc5nMhcNKrIAJ4LluQ6MwUbAU5LUyO4sIAeGMrMjzw
	g4thQ+jIO7DMNflyZnk2YiS1K0NB9T6F0odpF0W8yyCFfWuLHZ6C7wy1Zv65Zuf2SfqXquoL8Lq
	LH5bNHNkhqgtshGDzvKwVYwwJkWNZWjVlHItLEn5I0geYyZVBqF/U=
X-Received: by 2002:a05:6102:e0d:b0:778:636c:71cb with SMTP id ada2fe7eead31-78a4a9c40c1mr2809147137.10.1788536545657;
        Fri, 04 Sep 2026 08:42:25 -0700 (PDT)
X-Received: by 2002:a05:6102:e0d:b0:778:636c:71cb with SMTP id ada2fe7eead31-78a4a9c40c1mr2809050137.10.1788536543607;
        Fri, 04 Sep 2026 08:42:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:22 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:17 +0200
Subject: [PATCH v6 02/11] Bluetooth: hci_qca: Rename 'power_ctrl_enabled'
 to 'bt_en_available'
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-2-d8c5042b3efd@oss.qualcomm.com>
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
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX/Rz0yBhlPsXw
 yVd8IJgdOWJ+QiyRPE93Ue89YtXKFuswrQs0z1+rPZNQGX8E8s6+4uI/IQzMfsZae7HP02hyiaq
 Lzeum1XrrGrJgmFsAxO5IE/PbyEk0Y8=
X-Authority-Analysis: v=2.4 cv=TP11jVla c=1 sm=1 tr=0 ts=6a9ae6e2 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=wYtw_XDhO1ghKZOGarAA:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-ORIG-GUID: mSsQPf-AwHPA0PfBkbv2iaVp5kwn9KZq
X-Proofpoint-GUID: mSsQPf-AwHPA0PfBkbv2iaVp5kwn9KZq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX7pYtanDwW3PL
 /CE5RCVu4Qxm3Zic8Tipp8BEVw1UVsK2bOu2BfrGb4lXrI6TP+7tg1azJqapVCcMEwwT9Rzz4bn
 ZzO+Qkoq4ztbZ8fuRfGFuu22PzHwTLrusr8gH7drcM5BERMYl/RFicW18oEiiXGzRGWHt1xmQvt
 g1VQWkMwbvlQlfZUzDrh+/UapSizGYTK6Iv61jeuE+tmlrBMgPT580R6zNJTIQBmm3dsm+gAW0y
 Kf4Hjb55Xt/rpTIaUyjRFvugwwOKTeR/lYwasoiq2bM+MlSlE6qdWAaV0XnpLROqp12Zev3F+qU
 GENyIey58ZABKukGDv0aVxTy5VXDHvv//gK5KMH3kHnVPXEHSPvLybyN9KOfiJzWHml1gHPRrEb
 Jtb/sI6bwLlFc5piNgBUCH8EHzLFKKvrVDS/ehhRCxo5rLYSMB7c3p/n6jVOh73SbnMRpTQ9VBG
 1+M8l6oyOhPiudLDrbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040143

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

'power_ctrl_enabled' flag is used to indicate the availability of the BT_EN
GPIO in devicetree. But the naming causes confusion with the new pwrctrl
framework.

So rename it to 'bt_en_available' to make it clear and explicit.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c8ea5507bdc2c83f214e3154b5ad6d05f418a1d4..f7a20138cb742e8f6ea51d565aa8da8751f21f37 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2396,7 +2396,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_device_data *data;
 	int err;
-	bool power_ctrl_enabled = true;
+	bool bt_en_available = true;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
@@ -2504,7 +2504,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		    (data->soc_type == QCA_WCN6750 ||
 		     data->soc_type == QCA_WCN6855 ||
 		     data->soc_type == QCA_WCN7850))
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
 					       GPIOD_IN);
@@ -2542,7 +2542,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		}
 
 		if (!qcadev->bt_en)
-			power_ctrl_enabled = false;
+			bt_en_available = false;
 
 		qcadev->susclk = devm_clk_get_optional_enabled_with_rate(
 					&serdev->dev, NULL, SUSCLK_RATE_32KHZ);
@@ -2560,7 +2560,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 	hdev = qcadev->serdev_hu.hdev;
 
-	if (power_ctrl_enabled) {
+	if (bt_en_available) {
 		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
 		hdev->shutdown = qca_hci_shutdown;
 	}

-- 
2.34.1

