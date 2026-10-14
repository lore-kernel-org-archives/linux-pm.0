Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C1E4BB26D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980368; cv=none; b=aABNNgCO1gvvyJSkxkgjsThf1jqNxeWQRztkPZQ5Q92+G66e9TLjmIceODu+kZNt88W+vz8HBHKCaV9+yemB90E5JrdU7HVItPdFL+SYWkt5PCapmDpy1btwl0wKPb4iEZzBMo77hi1vlvS68WgQa8uJxhskQB/0PbBAtPBojoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980368; c=relaxed/simple;
	bh=vxISHWhf3lC7RqWBmyHcM7+lpZr8kxBvdS+ajIbu4cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eavb6muaB6YSbsIlQuPHWGZO7S3mZSZcO7JHfdTltgFdxWcsdsYx3ql1YN2Cx4TFfdYGo3kkXKSRhG7ANLSfQsHqtOjVD2Hd15TIABllLduEZctgl803iSUZwqN/RP7HR8eZA8ikd32Mrz190Plad0/0XOJbHshYNqzsA+RNeH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LYbEeOMt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KTHp0vJK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LYbEeOMt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KTHp0vJK"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69E8iArR3000934
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JtaRSJMaDhK
	wiQIShk4VNx7L8EcrBIFVbnV4hq+7dHk=; b=LYbEeOMtgf1UjWOkHk0Zk6LFqro
	crjUpPJyQzRv1ahsJALrF01MpsnXS9ABK44TX47VioovHwrkl874UopLMRLKkRa5
	l1MSjoMV9JLYG8r4cfaGDuUkWT6LpS0fPEGbOcEoLxrmPK/8WS5k/rDv4u/e5AID
	XYc0bMsp8FD1jZeyns3PtYcTGtRUmJperYileat8+Bi85XEEk+IQIKhdqScMAFPx
	+eroKmBHU5NcbrJ4l6NE5d7EgevNr8Qi3+D2U0BlbEMDZT8WlAdV1UcbZJCF4lMc
	FBAvYDjI3xR+5/UKW4uSL2Ob1G8xBh3fsHAmTTC4oYCOKJ6PaEM4yer5fog==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9sbeuv5q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 12:19:26 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-86f102230eeso281665b3a.3
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791980366; x=1792585166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JtaRSJMaDhKwiQIShk4VNx7L8EcrBIFVbnV4hq+7dHk=;
        b=KTHp0vJKb6+E06KYOw+txJgnQzG4LG9VA8Ee2ja98ZFTkBhgo1MwlterpAZMv8TT13
         eAVYaasIKlTDqOaQRhqIDOGi/H90vYFwoixI09g5q2kHrcbtqKLxk957CyaDF04/Wc4a
         HrIV8u9aOVS/EPjeu1/wwTJU78cgW/AjM8QEDN0lOlvXQBIWuV6zIK2QKuaPUZ993B93
         k2EMH8hQil3RIxnZqT3RCMI1v9w7pK6FYTClgQvd5evewS7RgTaV3Pgdf4L3nO83Q28G
         9e31Msp4J3fU9d715bY0gylgRYUrDUMye0K7twCjb2ub4NiIGci/KeyfLQmK3z/VN8i8
         O60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980366; x=1792585166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JtaRSJMaDhKwiQIShk4VNx7L8EcrBIFVbnV4hq+7dHk=;
        b=DC9gW9VsBTx0ZQfZGfg+fw0f1Ts8gCZrVZO1nsEINwfYUndo+F0cD+42qf5AuVbC/n
         rf5Y0dibYzOh0vUilUKd/8OXM6RcUcZ0jN7CvwS698rwOqiy8bgIt2wj2WSDQIQ1Jag9
         b0ylsjB8Ksg7Zvj7as1/y0gDGgbYvR/QLZJ/L3rVjKasEn2K/tbwYBXZPG2IBmwm6pBu
         x6d2Qo56Tr6VB1QNEE41ID6qsAYX2nsWmwYs8Ur5Q68pO6kA7BpGM/AjiMomB9Wyx3bA
         hy3syt0HA9INdJwY+OpZL8TYWGjgjvDIaGEmI95bOU9TcrZBYfZvwsBJPe5xyV4w6CTY
         1AeA==
X-Forwarded-Encrypted: i=1; AKwUvBzz4nwzWSkrVELw7ET9tRO+9LdaOtW5j3yNPj1/E+iEOx6uTw1S+pryICkDl9vxiNw4aEL485xyqQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJnwKnXOqAe1burUFhGUJf2mL8KIRYj/KJty16zpGaMD2JucPcC
	+Ie93Emf9gcbql9e+l5cZLo6wJ1qyyux2RSvaxcMZYjrjP2nDPEGg0lbad5VwJOVIbMHfIx3dUZ
	ul1LHpAu9E7WhOh32+dNTMTtf6DPBvXIDiGNB/LMPJTMTdo6Z5XaPMg3WW6RAcQ==
X-Gm-Gg: AYBFou3Qwi/BPKu3E8AoKF3Am4VDMWEh/t/eQC4bcktDZuhX+Inyjb2v6im2tzxZjhe
	VeYe44A6iIW9eTsu4h7ABKd+7/PDKS2DGlAVCzY3LgcjQlj6R0/ehA5w8RPYLsk9mDVkik1XlSB
	WoLrzifDk75FYVyPCmcN6Wa5Y9Tsihn64yDx8gjzKvYYueVWdXG05BxjXYZA40GwlHLDSSrypi/
	o2c5S7xmziii/HJE1h/tbiCtRioNOubHCutZ3AjSVuAQL7QmM9wc+sdVFhtp3URlGUj02w4xY5C
	XI1liq328rOi3B3pNIA3nUHdPov6OumCZo80nQFlYfvnu9YBY/5Qy9Fw0oGDr1B4zbbTC6+jhyk
	iNUcT8aeC79rt3df/ueaJZpc/I9ZY
X-Received: by 2002:a05:6a20:430e:b0:3de:7dd4:e32a with SMTP id adf61e73a8af0-3e16bdae01emr19744722637.2.1791980365611;
        Wed, 14 Oct 2026 05:19:25 -0700 (PDT)
X-Received: by 2002:a05:6a20:430e:b0:3de:7dd4:e32a with SMTP id adf61e73a8af0-3e16bdae01emr19744686637.2.1791980365148;
        Wed, 14 Oct 2026 05:19:25 -0700 (PDT)
Received: from sdciot-sh07-lnx.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d804ec645sm1016990b3a.43.2026.10.14.05.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 05:19:24 -0700 (PDT)
From: Linghui Wu <linghui.wu@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Hangtian Zhu <hangtian.zhu@oss.qualcomm.com>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linghui Wu <linghui.wu@oss.qualcomm.com>
Subject: [RFC PATCH 1/3] dt-bindings: power: sequencing: qcom-wcn: document wakeup-source
Date: Wed, 14 Oct 2026 20:19:08 +0800
Message-ID: <20261014121910.1509541-2-linghui.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
References: <20261014121910.1509541-1-linghui.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: DcyHuJ293G5Cud5Ld_TQW1n0gB6Fe3dC
X-Proofpoint-GUID: DcyHuJ293G5Cud5Ld_TQW1n0gB6Fe3dC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA0OCBTYWx0ZWRfX2mhuDUkZA3c8
 9BVBY9xWlY3YOWaCj4vwM/sFK9wIJqgXWfp9zAvD3/A6L7nMXxsrenwUJitY/AqCpWqusa2kwsu
 RQjutpmDE8OwpwAJXMDRbH+DLygb8/MqhkrW6+aJfgr7BkEno9Ptl+WFfbglW+anCBisooCmHW5
 5iXo2p+r7QKq1TwcSvgUH1ea7ycAoSi8rg5SlP3GYLziCUwA4OH0vUZza4pUnSZVSGlPg7qjo/s
 L+E9UbPqKjUmDc4xo8wSDIwnciDH0fJzlSRQ6NUjD2IQSscqGoefzynzm8gEjANTOCZTrAXiWyO
 /B9EnjSgZQZlhm0Upxa9KIIHGLfokUWYigQwndQxxCdfvYUm22pBFIJg/T/vC02/scqbNmPHXSZ
 CqI1IRkQSzZS8C2zpfwBSzVkWD5QK1yJjeM93v5SCK9AkUQcbLvlojaaox5uPRc6BtSTt4ypVbv
 pQTrpfrf0Zt1vOAxPxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA0OCBTYWx0ZWRfXymng5sZqFgKS
 NfV6N5538ZrZsVdYn7E56ujZhHZuw5NZVxMqfEyLTz2GOES+J+N71zQh/G8IAYjr0sABn1MCk3X
 /c2HFWPI6edo2759Trcc3yKbCsvmEZQ=
X-Authority-Analysis: v=2.4 cv=U7AHnuru c=1 sm=1 tr=0 ts=6acf734e cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=QRbdyHOjkzuQUDITQNoA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140048

Some WCN3990-family designs connect SW_CTRL to an interrupt capable of
waking the application processor.

Document the dedicated "wakeup" interrupt and wakeup-source property for
the WCN PMU node.

Signed-off-by: Linghui Wu <linghui.wu@oss.qualcomm.com>
---
 .../bindings/regulator/qcom,wcn3990-pmu.yaml  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
index 9a7abc878b8..00cd8b6c27d 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,wcn3990-pmu.yaml
@@ -42,6 +42,20 @@ properties:
     maxItems: 1
     description: GPIO line indicating the state of the clock supply to the BT module
 
+  interrupts:
+    maxItems: 1
+    description: SW_CTRL wake interrupt, asserted when the WCN chip is active
+
+  interrupt-names:
+    const: wakeup
+
+  wakeup-source:
+    type: boolean
+    description:
+      Mark the PMU as a wakeup source. Requires the "wakeup" interrupt to be
+      present. When set, the SW_CTRL IRQ is used to wake the application
+      processor from system suspend.
+
   clocks:
     maxItems: 1
     description: Reference clock handle
@@ -67,6 +81,14 @@ required:
   - vddrf-supply
   - vddch0-supply
 
+dependencies:
+  wakeup-source:
+    required:
+      - interrupt-names
+    anyOf:
+      - required: [interrupts]
+      - required: [interrupts-extended]
+
 additionalProperties: false
 
 examples:
-- 
2.43.0

