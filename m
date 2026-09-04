Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D04FDE59
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536547; cv=none; b=jKqFVQ7fr0QuolPDBHVhFr/MkvSGFhUY6jlJRCy2QrOQXllSnWYme3myzzz0DjkJTmWbh9TkfmqM9t6ZFWRKcZHKVgkHYEx6LFiXbRMH7+JEpvBfBDnpv2AEr10nr/X41OO3snrdmx82fQ8BeOJgkD0+8VNn73OCQAYq+6LQWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536547; c=relaxed/simple;
	bh=eabw6YropvwFfJY2b+1eTw6YCvYiFIzBiSUIvBH6EIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDMVlKS1koLeO9Ly7HivTRM7gy+pFe5isYSdRv96BeKFJJGSAmyJCuWB25qpayfJapYxK9LilYZkSKJ1mi15zRs8Hhtv1ypXj4HcTdLATfqeGuLsnkvnbJKoDSYq21yupWHph8lMaJsuYFrviJrZ2OnsrFylQzXyflJT8jTjgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WOD0sO8G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BnnJ5S8V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WOD0sO8G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BnnJ5S8V"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684EiK1u3329476
	for <linux-pm@vger.kernel.org>; Fri, 4 Sep 2026 15:42:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T9j9KM2LX+O0X8B9cuB6dNL2MqmnXu7obuRd+dtnPH8=; b=WOD0sO8Gfg4z0nx7
	ses2bEkjW9xSgpstGlM/6aKKiyU5vO/8ImecVZGBw9oPsQaOs+Cw3qbZiQBWcXlE
	cIppwgsVgKQgiazaownlpayyzo42c6whucfZFbEq7uWiKs/YO5HMBEgDrNjrw6fI
	/ns+5bqUwUkKnDhgxtOvYU/DQTPUU2CSjMZ8P4F7otVt51ca2WEgj7w686v9Jwka
	jG1dNQXBmEyzotB5LkBFDGokBaBAz8EUlbP/XNTJ4itaIBBtB2i4Luyh2KD6b0FG
	I2I8K5kMKfq0d9TivCMUIuX99S7k7w/fuEiQkvQaUzUV9S20k891yCAnHFl91n20
	zeTj0A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00y88rp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 15:42:23 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-930b571432fso185662385a.0
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788536542; x=1789141342; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T9j9KM2LX+O0X8B9cuB6dNL2MqmnXu7obuRd+dtnPH8=;
        b=BnnJ5S8VLYv0Nnr+GekGp22SvHN4AK73eAx5kBCFTz4yReFL04vujTGKdTJ8XJcfcE
         G2CXPVoYxa6KAozHCSlyobwM3k6s3G77VtCytxQcz9TF+UDaeu3C+5csnWeIKRXRaKxY
         dIC+eQiASY/WhHZu2znhCkQ0QHL0rBGPmcUM2VexKgTVeX0BXt4dL7nxAGB/wnOu3TEU
         5sMJ9gdXZ5n/7fscIMiGFTb2bgfwIRq/zjIQH9j8alJt18oY1vkBeT7B1YudZRC3jFJc
         Ucz1hgozmEo5z0JlHovf283jpI/SgDxOtByFQdKZSRDuf5Rc2nHfUBwxizGBB2cVJmfE
         48Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536542; x=1789141342;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T9j9KM2LX+O0X8B9cuB6dNL2MqmnXu7obuRd+dtnPH8=;
        b=Oc7rBg7JnzTQgCDnfp+D0jsVvb7CzzCPtkH1GGK+3NJXY0QAWnfmjysLNJryZcgkCB
         4VzJMxmRtqHARnfZ6pyciClChBcmQExI02iJ0TLcitgYW6/rQDkxdTobJV3TShGtPpkf
         hcVdSxShL0DA3Lu263ZXqjwGV69O3H/PqQ8U7Esk8cbpddiFMSAj8ZkDoQaMTZZHyM+F
         +HuDUsj4nBDEz5051XSlpGdKB5hDATliRoECqCB09ThHhSFa88GyI2p50jCuELNDoo8r
         1tiVBAwdwEjVid0W/QFwRLxUCDFKdwbpfDp7clNAoiHR6Xw7gim+xsM1e+u0UX+5xbux
         jHhg==
X-Forwarded-Encrypted: i=1; AKwUvBzmjEP8Kv7+Ec3MntdYmZ2RD9u1qHFu2ALFt0cMsHvJF+OzmZIjXnMyPeQj4k/5iav2ny6UjCoIjA==@vger.kernel.org
X-Gm-Message-State: AFuF++lvEIM2Wv2OL+lnSfxRJkRsLHtLxzq73cs0egomgZJ+SQlegnEw
	qrO3+uBlpQqysXecsROs0VOb/295tPCQVrPY2r7EzYvosf0DRjSdnfWHduROKwcsJ3uu5niWeus
	VF6cK2zY8zUoj55Yfpob29FdY6CW6cur6FNP3d++1Drz1v6kKTlpVPDwfznEong==
X-Gm-Gg: AYBFou3ssZs4uX65c8UOjjAPbMbCAmyGKHetE7/DHJQVt4DI8QwjR9jp+g+HX9kfnSL
	Zde8KtTw2xcePSCvUXluF/pCeFzJEBkI0uDs10rtPSIdVtyEtZP8LIFtMOs127bJES4ubL3lMpb
	VqnazW8/EAZ4mhcBr/Mn9wI0crHZWM5IqRUHevP7IheqXfBDJuhQDbwgSJ/q9I4TG7ewsmHyAzo
	LycoCmjw9+/9FBYbV8gqo2Hdd+IaEfGWZZBllrfQXScBAeTQAHNO4Zulkg6490e4dHdUUOBQvZg
	l/xU/9vfvmfnIMSGN9zRm2UQ9mzjicbHw4N7Bg1K/T0bb9t7U2Rmofxx8OUerO1EgXu3Nwg52um
	WKfiW4kQLDDk0+H3VPu63/KDqvZqb67mO0yUKakpXxIi7Acd1G4P9vgnr5l1UCjuGlRO3rE0lce
	10Z3tHXrz4nEo1m0ajNe2pEAFDvLJvomqRidch44XioiPfxN4BZv4=
X-Received: by 2002:a05:620a:6494:b0:939:957:ed2a with SMTP id af79cd13be357-9396e00b139mr1257453785a.15.1788536542121;
        Fri, 04 Sep 2026 08:42:22 -0700 (PDT)
X-Received: by 2002:a05:620a:6494:b0:939:957:ed2a with SMTP id af79cd13be357-9396e00b139mr1257449785a.15.1788536541696;
        Fri, 04 Sep 2026 08:42:21 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:e90a:787f:72ea:b218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5533ffbsm160668505e9.3.2026.09.04.08.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:42:20 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 04 Sep 2026 17:42:16 +0200
Subject: [PATCH v6 01/11] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-monza-wireless-v6-1-d8c5042b3efd@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Wei Deng <wei.deng@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: kCncmN051qDLb77tkiXRK7pFElA1mJ4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX400PF8KqR0FQ
 sMJ3OrZ6HzsfwLdq/FCRrsH1n2VOQ806AVuE01Q5178vPePZt8WrmBp/aGwZNtfS47VpxqUbFhn
 MrvI5n1msaBxP1ueOQiTCZvu1Jj0cPylJZoCpepGqO2mNqQpdkZhUeHGFyJOQ0m5+/xZevGIqu5
 LANB/lQwe7Wf4mggjJ/cXPl0CeLLqck4qSIJOlEBV9Z9jk1UdBRuVGMiO0qSCXmaymBiytvnmE9
 HNw6bQmVuc+npRST+rEOYPhsORaUF/xGzc0BEkR7w67o5PY5mWdtcy7LpCrmP6/ZXBZMNYXYV+V
 W3qCBNZK9SenJqApboongjoHlL97hXiDjlVmjtl4gCjviX3eCbZSs3PS1o2LabC1A++znxi8hgv
 8pm24n59LvC5LhBsDK0g6ij1C6cheX4Iv72mdsAFyUjDnxNmQycamvtwzdZJUhk3++rJbE8fJ5k
 FuZn3YnJJyXA5xPo37w==
X-Authority-Analysis: v=2.4 cv=TsPWQjXh c=1 sm=1 tr=0 ts=6a9ae6df cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=14bN-6-z4zEjTU3E0XQA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE0MyBTYWx0ZWRfX8byIcgDgVsyE
 5RvyEj23t3VDg59kDYlDwAdIHtOaQSm/GPnqxhUMpeaHU+I3wAwfZXJGwr2p9XlRlrMcFVG1nLh
 pgqqtE76qwmhHaJjnDElPlbuh6XnuLc=
X-Proofpoint-GUID: kCncmN051qDLb77tkiXRK7pFElA1mJ4B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040143

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
index faa964735adb17a05f2a8fac16f553b37b96020b..c8ea5507bdc2c83f214e3154b5ad6d05f418a1d4 100644
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
@@ -2448,6 +2449,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
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

