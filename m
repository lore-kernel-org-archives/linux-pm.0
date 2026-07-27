Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CBD3DB312
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167236; cv=none; b=SyGBtnASyk+r0Hsby81kVoZJEPS/0TLkXuGVHkPtS7UCqE368WoOfkBnxmbTjgtbXLvaAkfmWPYrDzhOIRaOY4h9vYtNyBFt/Sw4ebOHXwAs2F+To6SxJjZjEQU+KZxtUksSwKw/wM+nxD6mF5r7Sbw07Zxt3ZDFDCRK3CTOgR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167236; c=relaxed/simple;
	bh=43kb05RaUpjRitjlYRocMlxAa/dQVEJYd5sjO46qM7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BN2zdsUP+jqP3x7oAPUcBl6X6AHHz9DfsEefVcPmAvW2h+bPitYqF2feg1cLN8EXeensVOTDqfn3aw/W2bXI2y/3fJQdZrCcHE4RII08Hs1uBgm3abucmhvT7cu3Jy7GYtSz9AZN2xmn/zMxSNJL3zBbLT73/83OvNX58X9UMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kOytrHkc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WmVi1o4M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kOytrHkc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WmVi1o4M"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDmBVt3823735
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	S7mjFbopEGBUByQAtuhbKuVftRTpKsVvgzJfo+Z7UEY=; b=kOytrHkceeeRRyIP
	M6KMNuNHbpM/yEMt5GtmzW17+NOWCFCQg95Q9ruyJXG+QD0dyv4VURmelXqILu5Y
	DfO6sy1jfckW7sNY24bkyYYhDwMN2O/OB99dKWlIudTOPnytw3Y/zP6lcmWyq5eT
	VwXntfwk47wZeJ52V5FN7KCf8A/SlXMOt4P+juxUdVN0y4qrd8AwTOd222baYEEK
	phJauopWD+hn1mnM9Xr4geY4v1pJ5oAd8R7zsPsj+V2yqjZoCcSuGz1rKyV/S+yu
	JJCKKdFawp6AU2AbC7YPKITgKJy5K5p4txnjI50bd8nWBRlL1S2uhNVQn6IUVjPZ
	I4LemQ==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4nbsk64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:09 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-80ee3cb097eso71785017b3.1
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 08:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167228; x=1785772028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S7mjFbopEGBUByQAtuhbKuVftRTpKsVvgzJfo+Z7UEY=;
        b=WmVi1o4M6150gOd+GgfixhZE7r4h6NchELVxEXUTReX16PtfyzjFHNOK1GNZK3EFgV
         crBzib8+7TTbvCL3Rg/j4v21fEkCHDjoyBbe8of7IZkvodEqG/SOIZ3julIJcmvksc+s
         8qG4rHS1YhfeZxQHZ+0348YkomvEBdem7DLzxkX3NKM0rV0J2fW3SpONU4iLV6rp679C
         +LpbAUZrsTVmVP/k9Hh8wP1GoY+3j1qXvMVJCaY+aJlCuf3Ia7fbeBNNWQktNQLIjqdR
         7Vd32mGW+dpvIHdoLxV4whi3diZvXrkwzGNqc5SUYAukBgBAopl127naiIp6Wuh+I46B
         CJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167228; x=1785772028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S7mjFbopEGBUByQAtuhbKuVftRTpKsVvgzJfo+Z7UEY=;
        b=DO0pgvVr6LGqIBn+ejqC3XyZY0fmNgse/4Ck+C7oR9eqCmdFY+C4RCkAucsqCLgx7T
         A/IzdNOMrr2iFDOvyl00VL//e0eDxa0yqdedR6hDAoVA0m9a10dq+WuiL4ajJkDEeSx7
         YeaNDjR7STHzF3JIifEGlg+xs/JpJfDJukr6PyHF1WN+e4vz2pRaiks3cGPe5cyvc7wS
         BQAwc0qeuoeiuP2o2Fpt1Qx5tqf/MvBZRRfPqnG7PNy8iCqtQPLe7s0uwfC4GCcc742R
         eFVrClteR1O48J37XcvuswFN+e/451GUU0QeFWFeZDrB/4kgGoQubi5HFDRnMxx/dtQ6
         +dcw==
X-Forwarded-Encrypted: i=1; AHgh+Rp0ztvQKK5bPegR6dqmLhc1RdsnFgChp084t9iIetU/Kc+9UbWK+fDd3UNW0l3VYVZTR7g+iOIVhg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Gi8f1gmzf+Mvx2JLMmc5N3X46uNpY35Ns16ymw969gA50a3K
	QCJ+oWkm/94oUc8dtliwFYsxTfSROFvDtYmv1g+CD/9Iz476MGZ08A5qtOKl0my+ly2UNm/IBus
	DvN2s3iJzWQbSex0JNvFu1UtgZNH1TsP3dkNFBoYknjvViYP6nX1+Igj6xNtjYA==
X-Gm-Gg: AR+sD13sdq62kK5WSHGTSBompDJkz5Qj70iluGiyWTgfth8CCB50DqbiZYqnbwLcvjx
	75hYXJAri3e2hBl30VfEbbUHDNwSE4D2bwowt7ckSQK55l6FmUYYwH48bagOYl33NPVWvhz9gdO
	0AQXuKCsw/LZlDrcJQhmpf6hv/TcEqkmGQcGeBaslnlOgYjD4sy5DX018x3YNVlQoD7K2yAp8cl
	CeO+2z3TJ+FFJkCIUjMTOBmJ3Wpz+5v/unMMhHRnR1REFzQOFtWF5Kbr7A4QkpI2DrRKBPYqacz
	GxvNeGAFPkQWkLoVfQnkLUlZULB5234Ka0cd8ghbNDAR+ICD7amZRsk6z7c+2b4fZEAnRrM7cA9
	CPWIZtf0hMEQ6hmuGyUTgdg6sNZsxBQ==
X-Received: by 2002:a05:690c:600e:b0:81f:3dab:372f with SMTP id 00721157ae682-81f9391cc77mr412807b3.12.1785167228505;
        Mon, 27 Jul 2026 08:47:08 -0700 (PDT)
X-Received: by 2002:a05:690c:600e:b0:81f:3dab:372f with SMTP id 00721157ae682-81f9391cc77mr412547b3.12.1785167227905;
        Mon, 27 Jul 2026 08:47:07 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:07 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:01 +0530
Subject: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
In-Reply-To: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
X-Mailer: b4 0.15.2
X-Proofpoint-ORIG-GUID: un53l2k5sruwFoPswrwBVKyC6-YUd2Ze
X-Authority-Analysis: v=2.4 cv=cJjQdFeN c=1 sm=1 tr=0 ts=6a677d7d cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=o7QFpL2tXW9ehrA7-Q0A:9
 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX3WSQe7aGlCvY
 l1Or5hudAb6EXrkIkdk7NuAqWPi/bb3/GB6/+5tPAijKvm9CGgG2fmMkXnfh2VuH68H7MOvRp7y
 LbzmSiDPozF+aeLhuJOw8yu3WJI9Bd8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX8SmehNam2F5D
 NGWQ7BlMHQF+qHlmBlybuE7+7+/vn3SoKKtg3bwcArWmQK3BB5xR/yx0Ik8+U9aJ3rJ5g6iov39
 5dTi66Gn0cgLG1Exw7MJjLo4dcgtTdqsAyp5Ly10ulh4JfjEM8FGb5A4N0z2BVjRm7RUBbcEPA/
 5xKkaf3Dv4l8BfFVPkxi+wfifZlRTDLnWLydIT4nTCu9i2M0ewm2IC/mhjd9XAWjqsdJmRMrGGC
 ZtuGZx5jklUeb736pHCZuadIHBGUVjpTXTtSvIHK7sRhcYaM9LgUcFvvcto6lgz8+Hwm4T/sz48
 sTnJjtwQz/Zu4c8Y1RpaqJ09n2JTiZJqnBONPUQV9XmxUOsyFeh81TAFoU+8jVKajBbyr84SJDX
 a7X8tlbrXsnOz+GQAG3Ta5Xqx/RRAR70IDHf5nOmX+C5LT9VBpOpqVziw0a7YKORuEGvTF8wrN3
 uePTNCSUQ2Kx0vqWcJw==
X-Proofpoint-GUID: un53l2k5sruwFoPswrwBVKyC6-YUd2Ze
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270148

QCC2072 can be used on M.2 E-key cards where the card power resources are
described by the pcie-m2-e-connector node. In that setup, the M.2 power
sequencing provider creates the Bluetooth serdev child after matching the
QCC2072 PCI function.

Integrated non-M.2 designs need board-specific power resources. Document
only the compatible for now and leave those properties to be added with
matching driver support.

Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
controllers connected over UART.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 .../bindings/net/bluetooth/qcom,qcc2072-bt.yaml    | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
new file mode 100644
index 000000000000..e4b281ef261f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/bluetooth/qcom,qcc2072-bt.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/bluetooth/qcom,qcc2072-bt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCC2072 Bluetooth
+
+maintainers:
+  - Bartosz Golaszewski <brgl@bgdev.pl>
+  - Balakrishna Godavarthi <quic_bgodavar@quicinc.com>
+  - Rocky Liao <quic_rjliao@quicinc.com>
+
+description:
+  Qualcomm QCC2072 Bluetooth controller connected over UART.
+
+  QCC2072 can be populated on an M.2 E-key card, where the card power
+  supplies and sideband signals are modeled by the pcie-m2-e-connector node.
+  The M.2 power sequencing provider creates the Bluetooth serdev device and
+  uses this compatible after matching the QCC2072 PCI function.
+
+  Integrated non-M.2 designs require board-specific power resources. Those
+  properties, together with a static devicetree example, should be added when
+  integrated non-M.2 support is added.
+
+properties:
+  compatible:
+    enum:
+      - qcom,qcc2072-bt
+
+required:
+  - compatible
+
+allOf:
+  - $ref: bluetooth-controller.yaml#
+  - $ref: qcom,bluetooth-common.yaml
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+unevaluatedProperties: false

-- 
2.34.1

