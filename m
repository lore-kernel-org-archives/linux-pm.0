Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7593793CE
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784218713; cv=none; b=WVRnnXnsxLb//i9T0JcBOxxinZXhaqyUWdoH2I+7HAUu7xgzm1yP0jNcJuorjpJKzmX1ToMF4hQ+IxKFCbSYl0uAc4Gk+DQM1z0fO/L5t6NRle6ykzT3Lbsrf4eME1K/dP9xseVD3DD5Xqjl4L5ARYSQr9x5qLKZFLTl+4zgLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784218713; c=relaxed/simple;
	bh=KEpaGYLJg/HFUQ4VCnAAAa4/K+FU5Ww1paHM4mUD9UU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T3uj3QH47p74FaPCzsKKn0yqC6pUjD/Er0/XP8mZdHK3raU/p78OAEVlbANXDmxtHitCc2n9Dm5rMxu6Qaqv0W4upfs47+1UEm2OG6K/XZzilfKBk8P+HL+wQQzOviz2+dCYqarmjeHPHjDbpHpO/kGawxFeY82EO2QL6lcPFCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jOXqOVLZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gAzxOuzu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jOXqOVLZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gAzxOuzu"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GG1VpS3207739
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=; b=jOXqOVLZC6BBHj+3
	XLMie+g+71G9u/wYEPDYrJ3KKe4zYFaauBBV8N/SmJsnKitT5CT2VUecq1mcCWHd
	um/6RrZ6wvAw4iTGGChmed0ie0RpdXigKmiabE+7Lkp3RnzRArloONiBnbL/JLcl
	GBHQ+mtFO5m81hFdr8wH1JH88pDI+0FWeVHV/3A5AUvynHR6ULBhxjLxBwMhz5/H
	gScdlUkHFPFMBUToCkgWmH9i/dt8bwP311Qm4zuS2mGfMRxTPhOHAbYVJW5CSQXM
	VxCwHmYkPLvmDoPrVJ1v8iRkIE59KJJzcQ3eFWtBhNI3osy2GrpBfn0t8vrH/kyO
	zjl0gg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ff2f2r35j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 16:18:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51bec738909so58676521cf.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784218706; x=1784823506; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=gAzxOuzuXgVrE2WxsjQyQGxnU6sKbjC6yCuSrsXogOxf68BZwF+psvgBI4jMpa3tkk
         bvuIGIeGvOG2puIc7eJMjuSENfWZPmwaXwrufCDPEw7DWARmGw5nul7IFeVqUZ95VzaI
         dly4Uv3PiLOqlnMYaSBy02WwNRd5ab3CpCQiyCC9XCCn9AfvDe9CuBfkVhMv4TMVGOlq
         pk3n5EPID2ipOoAya3E0249bJhFVEG1ky0mAwDDKQgv5LI8hfCmi5750UdMlYmKG0qAP
         EAdGvRMGsIxzNCrEXJ8vXYOSLoopVScZPoSAOrRyGZADrtiK9uLMz2/U5f76OVrurn6C
         GkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784218706; x=1784823506;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9xHOUNHGElRK8fUN+Vx3VXwXih6zrlUor3vLrF9tWE0=;
        b=IMy03xy7kjzXDtsxUxYroRgOz63I0AYRaDCJRcJDK4l5gqXjdfI8ibgpbXETMu4uTj
         +2D37xuc0kuwENP5aLMgSEHDBUDeKUeudYbXLk7SdSJLzTbVSqtqy/i9WrjWwWBMsBx+
         yKQsnjk7RKgLiUYkTBaKDpFLznZdBE0pwDueHcbXq0cWHVlzDFOszZdU5tK3VkoECQ+g
         MXUhfvsGhXa5Dy8X4ATv3HhSCzosfjTkLlTuI8ypX166QErUJDpIsoyA4r0LRigegMAv
         HmHcq7X3TXYAEi4x81cgcv1LVlkG28xalzDaDMrUilVz6cRo78aXnQh275P2ef7jciz2
         wkVA==
X-Forwarded-Encrypted: i=1; AHgh+RrH8c5o2ezzyMJBYB9ITNXyN/G9OLsuwQq8FDflaZpElzJlMrjXIfEjfBrJSgH1qOUc26bSKMPjUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr1cS9z1bVBYJwApRtdyQQsfD6rhxQl+hL3VfasOHJGybcf2b2
	046PqySMHCQkaKOtM69zJhg1TNiHjEhDZ6pggSsUCF9zBNB3ThuREWBSn0+aZqRcvXWzydN3uq3
	EjCggZxwciOSAZffYDeLsojB4r8ejRGD5n4IaNQ9oy9W+L6z8TrihTV+sPm+yQg==
X-Gm-Gg: AfdE7cl5SxaMeyHUbwwm65gTEmWaIqzPEBjG6Zo3Zcm+ILGP0O6RHHM3/Q476Tvv+Dy
	94tjgTmJBHMXJdVXkFtmdEuGv/7K5i48fIJaBz7oBS8bIf+hvaKrxlfi9SIDY/forwKE+jk5Whn
	WrOMN3TZa3Qx4ToZ9Ct1fQXALUV1tU4EQ0AP+scQ5vQkyhQIh4cKlvDZTmz94mPSVFPy3RVqrB/
	Ft4EZ3gfdPyNgmkplwzNdy7mzYdGMx3GmRwwZ+Afmp78q8b81QJ709BNg03Bd/UMmRnQv1sYs17
	36s4qvTpJjnGimTUmx8V/fifbMwSZDX3AikEMRy3sGPFpB1c0s3NCwZzVn/FZuzOM23WO006/ki
	lYgk3vNgYB2h4JFXOMUFqPUeB4qAXSCvgZFNOxo+kucDsUkby6PjopQj8mkFWIhn8KzS56Rdn+w
	gxEhyiHS/ugymPrvNBD6a2XjF5wzwH+2zVk63o0SlxcycOF9rBEyQ=
X-Received: by 2002:a05:622a:a888:b0:51c:43d8:8604 with SMTP id d75a77b69052e-51e42453df2mr108397981cf.51.1784218705366;
        Thu, 16 Jul 2026 09:18:25 -0700 (PDT)
X-Received: by 2002:a05:622a:a888:b0:51c:43d8:8604 with SMTP id d75a77b69052e-51e42453df2mr108397371cf.51.1784218704675;
        Thu, 16 Jul 2026 09:18:24 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:751c:d61c:c91:60dd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c168744bdddsm257262866b.48.2026.07.16.09.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 09:18:23 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 18:18:18 +0200
Subject: [PATCH v4 01/11] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-monza-wireless-v4-1-9b02e6f549d7@oss.qualcomm.com>
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
In-Reply-To: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: SynU93WN34V7KVA42yQYZx1VmEn5MlKn
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX5DCaM2OD+p7r
 KhRoURr+g9v1pOVOPD7HUWg98WpzFGr3pXBgd1Hwgliyv42Rr1g9ah76ApgK00ZlBKbqkN4px2J
 dIX6ZxAxMMdNhSdJg7kLVgCD/UoBpdc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NiBTYWx0ZWRfX+Ki6mYd3w8Bc
 VOwe0QJxDjqZsUcpxm2iq9+Ik/3CpjcPn4CYBgO1ssp8wGAPw4i5bN6sG+rdJJEHjFjV0Ab+NAu
 PC1EB+cG3xRCqu5++9DxIMO8iF159gt5PuAqcXlgzf0mEi/5a+pJheSoPwPX3nv+NffbS9yfkcN
 8gYk7v8fsHPN5XF+/ej5Q6hgPOoWdPJaVQpP7Owm7yRcrx6IKEpmQY4E4FUBzFwToaH12PUFSQE
 Rz//S4eFF6qXywBbjzXnKzKCGsbrrbLcJ6hF8Wsf2h4aJfHssFBxh0zIcGXyL7gfLXiyR14YWbK
 gsPEEp7VNUGEuxHviq2lbi2wwmzy0qcev0ieQq5irw8AvwIv3caocLDFFSbrfSUS1W1Y6YPNIxm
 owNMJ9mDLot2pT/L1zkGw+BjXbKIQ9qExyd3I448Mr/00WidcxLNNunrX8klkl8BHh8kyFjW+ze
 JvH2NUippAhu8mkG/bA==
X-Authority-Analysis: v=2.4 cv=NcTWEWD4 c=1 sm=1 tr=0 ts=6a590453 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=14bN-6-z4zEjTU3E0XQA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: SynU93WN34V7KVA42yQYZx1VmEn5MlKn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160166

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

