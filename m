Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB23FBED8
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677456; cv=none; b=eG3bvzKZh32sGkNxUOFQryZCaIAk0k1jqHMuF9hluEhOeZlGflZ9M2bBplMYI8KVUhMk5nWuKeniETZb+hsE/ESTRlSIdsIuI4XccTtR6scSJfeKbUyKkU9xp3SxlVm6YmARFfihuYP9A6geX2sEtH/qElENY4hF16/roA/VWg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677456; c=relaxed/simple;
	bh=KEpaGYLJg/HFUQ4VCnAAAa4/K+FU5Ww1paHM4mUD9UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YCHyrmut4O/SDcYI/ZViJPC68KoLA/qvcD/NFhDN/d/nZBEt5BSvnkhFRQGC7MgG7FBXZN/p1+jhGYLHY9oHQ657LFFffEMHaO/Q7yoRdBInO7JaaZMsnS9KKancnbYW+LvD/1yg69QBtw7EOYWLRe+iRHNVJ2hxg/b+bSW44GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imSWQRTa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PyUzAL8E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imSWQRTa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PyUzAL8E"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dWPG235450
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=; b=imSWQRTawQRpzQNc
	mwknADJeEsLPlR3YFJePXgE+g2CgMtH6PhCsxzYu6wd7US5Nx69vYJpoMoZIt7uZ
	ydQPQQXaH/36mm5o6bTGsw8RUMelB+QtP0+646R8Ysv/anT/JPfsEa0737vDafR/
	syB4JF2ODhttzmyxQ3Di+cAOryTXkiWl9jzHpF5QjWvMjYq8d18bipucQBiO4QXq
	0/z8fwx0WM/zO2yfbM64iDJba7CvX7wwnV1nt2CO7N6/4YaKABMuRBFTcfCWv6GR
	3v2NzycAq7TJgQrJlyycdYS46QCtw9/euhWSr4U6z2bMuYovgX8AoTDMyNXYr6LY
	lNmHiw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3kwqw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 09:57:34 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8fc6b670b4bso10061326d6.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783677454; x=1784282254; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=PyUzAL8EIpQpen8yYLJsDoF02JJal50kHQNDPB2OcRPVu05MZE7R9bztwGQBeONOxc
         csbL2jAtLCSZInY1AxxdxfPDBd3SOQxp+qFtG2SU9oz5xPK7Yv+aehkvGTdbdbF919ka
         FEjRcHkNe6tnLvxP2XGKf7x0bz8+haiHUyTOsjJ/UsW46ByTS5OMf69J6SeRric8AziM
         rO0MO1Yspkxgdx7M6qEIUKyJJxcoKGA+7ifO8HSWmdNxE1H6ZhPmHL3NlNLUIqo1koxD
         6KNqEE/wdiRhGE9QD7yI0UzLiCQiQlmrYN0bTKO2p9xkkGgSop81JWwbMSqTzfFjrexC
         dp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783677454; x=1784282254;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=FRX/JMPuA2JVnMIDhHv89qu8tHzboOH1sKLkm+wA9AKfiffAMnUWni3zRkhMumJWOG
         PtsrZeNoCXCP5byiygMrjxEt7Ca2HNBiVW9nMjnguUepGK8XxPMpINtK/ymLFjmSwh+p
         GIn5H4O5e72Idn9OCG6J0HRSwmBNiIU8orJ7Nqb34oxpf5IJ6OhEsqjkc9Kuayg0v7m/
         a0TjN4sKLJgSHtohgQ+TjYsUHmj2wLLNh1u7aIEdy8ZwTDeeYAZ2iE96oOcmAbj3sobI
         LjNMVvVlzIosCW3FRc53gqr6EHval9DPSNO0Ref/jGM6jvkzKVZh7Ttt5fxSZASd17Q1
         /49Q==
X-Forwarded-Encrypted: i=1; AHgh+RoG/hHtVvlozdeZNSOe90Wgv+NocDzlfmMI9LWjKWcH3TiNeU/x1d3JtyIOZjrKJFwY9hGOEsNmEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGWlIuClsn7ZPhr7g604Lb/6w0Yc1aRFJkZXOR21HsgtA2pFil
	vycWjYP2d3weSmBndOL+cx5WjtQONl+b7+Ug7WGLUQXJStnw2XzOaxlZhafF/BuGk2QSyL3G/ca
	s5odUIxPl0ut71nep/Mjuyd9IHlZD4BC7QiojZEPUFOg0LTvbH58j97BYNPSHEA==
X-Gm-Gg: AfdE7ckUmK+l4xZOM9+OPn0QwaOtW2tFK2uzsIJAlPHWmahoJpISc66+K2OyZdrq88C
	2W63pjJwMjE20vYAyhzlPoLMhYq1f7v07F7+15wSdCPLsMIIDvrT5QiWC2bbwE28g+cLydU8s25
	u3KQ9lSVwOeDOjTEodhYjV5/VRDnegOriohjJbWZooCdlK+WC+mQUYtHUg5ucsSKKqnRlI4b8ys
	L7PKRSNgfkjFqPHXFCMKDGbvmEtrMFZq7XYGDCM3xhbHfkZ4DxcGobu9w16luBtSZX/N20rwKDo
	TvC7hlct+AxGnp9W8M7EXcXXfAiIW6KnHK6tOyqAjxZpXcmEL1x7hutTKoQl+YiiyhwtLU3ZESz
	l3J3lSa5Z2WVZJTeL8F1wCB8NheG73wVF9cnJ6y6z+P69uXkg3Jk7k8unbKoDLZOOp0MA1gk08+
	r1GHSHmnwZMYg5EtUnwWbkfVQJj+FWQ871yS6UQocvgTygFp8ThtZPlucrKqRkw89lCoRcEbHJE
	fgZsPvmUmVXN/DZp2Yl
X-Received: by 2002:a05:622a:114e:b0:517:6435:c4ce with SMTP id d75a77b69052e-51c8b3e2e3dmr114665231cf.49.1783677453746;
        Fri, 10 Jul 2026 02:57:33 -0700 (PDT)
X-Received: by 2002:a05:622a:114e:b0:517:6435:c4ce with SMTP id d75a77b69052e-51c8b3e2e3dmr114664921cf.49.1783677453240;
        Fri, 10 Jul 2026 02:57:33 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com (82-64-236-198.subs.proxad.net. [82.64.236.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm265357966b.36.2026.07.10.02.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:57:32 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:57:27 +0200
Subject: [PATCH v3 01/11] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-monza-wireless-v3-1-46253587af64@oss.qualcomm.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
In-Reply-To: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX0cS8WVgpg7Ll
 QEyKAg11/XEpuw1EH61FOb5/KuvNNHXDNFpEeUmdq1Kd+trDi5eGpAbfW5+F+4Uf5SnbR+TLY1n
 BVorwrB1T9HHvn1sVSidbvVFDdcs94Xrt7YlfwPwfoqQGfCYlOuAdjJybtBMQYfPQd+8Iv9yqGz
 C8TihVSKq8w4JIaGAD9hN3u6MCUyro5Po+RgVYeeJGvGfTtyHOs7tQr8bbIZYG9Xt4jncgeVsUY
 W5uqUPl/GXNwQaDT1Noispg4cBDogaKwdC2SpLADgwnjUsi+OlUZKmcNaw/uUIN41mH20ms72j/
 coOCUTaXP/HKL1mja6vcfSa6FPYYH9kSQ/sae1z+edodfSV3A5ASjcnTIAkpCQ3PKCSFhHTpt3Q
 GJuDX+ETDwnmSUC6ifdg9G2njMF8oNvWyoHg6ccQvO5Ku23k3B2v0TsydptS+PjyP1BgnlxLRlm
 39U/ROdHtby9SlWzPsw==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a50c20e cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=MDeckJw97qnk8wCBExTehA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=14bN-6-z4zEjTU3E0XQA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NyBTYWx0ZWRfX8uR5eBqan0ZM
 FoHf1RaLGUZPBF7+SU1EAAcDdwofsIgKlKytkUe1kBta0GyGy9zpKhq5EdR3sU3y9g3GshiGtX8
 1kTr9UQkyv9nrkJLHSH7SwqSJEpghdw=
X-Proofpoint-GUID: 03Kxj5XeHrP_kjUF7YsX4m7DLuMXMGz4
X-Proofpoint-ORIG-GUID: 03Kxj5XeHrP_kjUF7YsX4m7DLuMXMGz4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100097

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
index 2444471956197bae62a1c4c3a776c5591780ec02..135c79e696aefe2b37ee7a7a668715360a1e2d75 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -26,6 +26,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/acpi.h>
 #include <linux/platform_device.h>
 #include <linux/pwrseq/consumer.h>
@@ -2445,6 +2446,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

