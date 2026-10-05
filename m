Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FE5480DC0
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 12:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791202912; cv=none; b=UXGJRwEnvmcgwEfXYb6iFknIVhjBQwssOvhQtaJs1hlQ6/CJvneHVfnM5Ejs2jUBxfmaTk7tX7uJQdctTmiKDlGnstGG/E18Hok2EkVY63uw6TH9KHIH5Oyg/eEABQFAi8LQesE2qyOxwrKubRnTjM45EvCg0SRJakGfdmb1Yn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791202912; c=relaxed/simple;
	bh=UbfvsxV1N2Q2BwLuWb1XgYTj+UMWr2glJ7cM9WRcoZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PPb93uP0JCQwLyrurlIctVsamY2NTXrqt9b0wM0dlGe6mtfnkycFOydut019Oz4jqKL7nj6i8mF4c27gwyzoKmb2Br86IXNpTn7dRrek8+QND7A/BVuzHVoirLc6rswZC5K/9HIHMfnNsGajPyvJ17pf8gr4+XOd9jiw8sZBdr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X1s9ueCy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NCsl8DIU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X1s9ueCy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NCsl8DIU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CFTPj1925916
	for <linux-pm@vger.kernel.org>; Mon, 5 Oct 2026 12:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	khcQaR9KeJm7qpoXnT6a9/DyCnO60USLg+886y5MCh4=; b=X1s9ueCyZhaUEX0g
	fb6dt+yMvYvSoqcIc7Xvs2Wpp3UL1HuYyMkjjRcHrBeRD4Ztfmpja8tEiY/x8iw/
	8XS2lTFV42K8w7uRO9BwdX4xV6m3wIszxruVAYmT+qnCibpwnecJoP4sFuAFpKk3
	NYBCdcTnkeX3kBnwvRcwyYR/p/o1w5p/CtVAuhzjnBKwh45txawBkaq0quX5F1+q
	kQStTo8KOcImqG25oBSiOMZWKJFMWBZ8age1yUSRXyNWBtMXIVzvru0LewHlSexy
	iMNdWro8eQtz59IZNqW6ounfJ/pYI1O/+ji79ULOm9vmr00NdqGPJ6daMFx0IG+i
	8EJM+w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h3xgyt1hf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 12:21:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93ca4a2b9c4so386239185a.0
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2026 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791202908; x=1791807708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=khcQaR9KeJm7qpoXnT6a9/DyCnO60USLg+886y5MCh4=;
        b=NCsl8DIUorVPzmgt4Q/FVjzG6nRANqscLHis47k7x/j3/Dl26A5p0MSxSYCWH1BzZ0
         9J+DZWOP/mYjmPM7s8MGkXdPuuQbyTtb7t8W7QtwOzclrue5g9E9o+rI7aec/H0whlS4
         taWCvFOG1BIH60+uml5n2eXzRnbbFq8h2uxLAZ2idpGjI9jMkd2sLE+TraxcppvMYEbs
         ebVEgnMS2Q0CnDF0dJ02+yNQotq+lLbopKhVjb7rigPg+Ii8RLyFLHaI9DhhspWoVj8E
         ofT0O+ZN+tyVpwiCmBTiR1Ime+okQsU7d86Dwl7aByp0e3IDYD7Yz/vqJNoiHZo9d7az
         gTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791202908; x=1791807708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khcQaR9KeJm7qpoXnT6a9/DyCnO60USLg+886y5MCh4=;
        b=cLDZwKL1EBt+l1cULifBKN8/MRNy+fSKXExZNBVsoG+j2OWKuh1lGOOxMQp75d01Ya
         qSL4YnmbssbSEPFk3uoDH0+NNXgSXcfnPTc1l79cfCOZ8YPyjx244xe2bTUFTOOFDcAh
         Lu6Lpk/JlhPVhgzsWL10xNqXpnZPkl5w1YNItisPFH1V0QhPTIbkP6D/d8ntaSFvsmWb
         cJ80jBvamp3JSZ2v4D+Uks2uLWyudfsnX+3GSXurM2WgwF8EcRrBhy5e43SjDLlOIL7Z
         So8JANLWKSuQMZpI3CYYuKvAsHPh6R3KZ9CBwl6uiuhbo7RmzYsVF/Z+KcB3kOhk7BQc
         mbFw==
X-Forwarded-Encrypted: i=1; AKwUvBxqZUgZErpR2KzM1KDkV0lRHXk6a2vOYM3Kz7AqF4BC5jLcd407/VgACIsPCGAjLrbUA2d1yCMyIw==@vger.kernel.org
X-Gm-Message-State: AFuF++kFSRiYdUyQ8zs5hmjioLHKTOa+4q9AfM3Scbeu9ltEXKV5rDFi
	73pTqodWMUuA6okPr9ZGPhcG0nw5rPu07anIAdQrrf1+0BoPv+w4cBDW/G5fpI5RdGkTm/udPYY
	wknlKiJQizudcQIFha5TpXtGIGJUqgo6FR9DQFSzmxDsDHGVOn5my+NivfmU7pA==
X-Gm-Gg: AYBFou2FecxFzYpLANgkhivwUv+7xUzBiT0uM4YgWPOVmlPv0aGxdRBb9dnRbGBxrgc
	hoWvAGhYB77EBy1cO3a8bsCOnGizR+Sw3vZog9VupBunUY0jw+ax9URafRS3jqrLKaNraVBbsWQ
	8d+/sclktX7viX0dv3L4bpCf2mBdaLArC2zscBxti3UV5LcghvITUiAqDusEZrROU6FqjOLov5W
	Gup0cCiJpbiqhJ7KH6tnwoiXaV459LFZiKh0RiM3GvNs1L0/MmgbpyXHVgyNXVpVPFAmb2EXwyW
	FDT4BqHsQ1sE/NuXXISewnRNKcfApxr6VNbuI+scOBz6BSHVct7F4b4Bre9YOZlg1VD9NRMXaUG
	CalxZBzetvaqIHcEClcIJU/xqYZpBbtps7cY5u5G0XE+/rmuhpvYuHAwRc/oOPj73WN0BjJnZ4y
	Q+zrPpkWDgpvq6HBIZSdIjuf15+W8ozw6ICQ3qhXcWtnrsDp1pppmcS2PETPtEbE6/uQG9QQ==
X-Received: by 2002:a05:620a:199d:b0:93b:beb3:5898 with SMTP id af79cd13be357-93e510787ccmr1202226685a.49.1791202908186;
        Mon, 05 Oct 2026 05:21:48 -0700 (PDT)
X-Received: by 2002:a05:620a:199d:b0:93b:beb3:5898 with SMTP id af79cd13be357-93e510787ccmr1202218185a.49.1791202907310;
        Mon, 05 Oct 2026 05:21:47 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (90-182-211-1.rcp.o2.cz. [90.182.211.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027698f13sm324157425e9.1.2026.10.05.05.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 05:21:46 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Mon, 05 Oct 2026 14:21:31 +0200
Subject: [PATCH v7 1/8] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-monza-wireless-v7-1-5a6de7662dcb@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 3BQAtcsTO3dVyMCP158QnuFYs5zzgSub
X-Proofpoint-ORIG-GUID: 3BQAtcsTO3dVyMCP158QnuFYs5zzgSub
X-Authority-Analysis: v=2.4 cv=A6b5rKWG c=1 sm=1 tr=0 ts=6ac3965d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=zRh97aRZNhiOMYVz81Er1w==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=14bN-6-z4zEjTU3E0XQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX9rU0owLpi/ha
 zcfjWCtCC3qLA8dyrOqpXosh4FUorrPsKNLgnzAPRqTYqJhZ7tlgc27iltVtoYFzLr3/erKOMtt
 yWc237WM7rflSdMAhplcVJXfkqsl3cvNx1G2m37p/f8pkskWMG6s22FJI3yjUVyce8W8a5PQH2l
 m5s8kaRwKcNs9xZUKXMKE18LXJfXTCgChjQYQon44lc5f8klM15CYUb7vs5KnH905yc1cWCBMVD
 218Zh7X6kG+hJBvcb5sn9idwTRYg1PTC3PYdaY9Zl9GM2VEhHKagttffRxMx2j9E+wuZQ8IzJPH
 oukZFZOiiOfgAL5/SQRKoDhZbA8hCzOvSdojVhmv11Rl1bteVqENGg7wCDSVf6YIzixneA/WpoK
 cbc43ov1UHteqJCvrbC5Y7tfsga8HUAns/CaY4FjQqWNcgXInwSz/l7W952TFhJAi8sJwiwp4M6
 Zh4vPZxqoKy6dGuXkSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0OCBTYWx0ZWRfX5SDzyS9wQbmR
 s5O0YwALQhhzwUEnybpIyOtDm39Hf2t3p1dU/MV9uxARGU+eCldh7WQncK85Kia3hIBG+SbQcP4
 5lliqiwqxDN6HLzfc8tAwhoIZFfx2AY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050048

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Power supply to the M.2 Bluetooth device attached to the host using M.2
connector is controlled using the 'uart' pwrseq device. So add support for
getting the pwrseq device if the OF graph link is present. Once obtained,
the existing pwrseq APIs can be used to control the power supplies of the
M.2 card.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Tested-by: Wei Deng <wei.deng@oss.qualcomm.com>
---
 drivers/bluetooth/hci_qca.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 7089e9b639b2aad2d5ad2d43b07f495833757805..e249fc6e44479142e25af4e37bc4e1bdba13cd98 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -25,6 +25,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -2454,6 +2455,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	case QCA_WCN6750:
 	case QCA_WCN6855:
 	case QCA_WCN7850:
+		/*
+		 * OF graph link is only present for BT devices attached through
+		 * the M.2 Key E connector.
+		 */
+		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
+			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
+								   "uart");
+			if (IS_ERR(qcadev->bt_power->pwrseq))
+				return PTR_ERR(qcadev->bt_power->pwrseq);
+			break;
+		}
+
 		if (!device_property_present(&serdev->dev, "enable-gpios")) {
 			/*
 			 * Backward compatibility with old DT sources. If the

-- 
2.34.1

