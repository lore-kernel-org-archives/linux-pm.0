Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36FC3E4513
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544688; cv=none; b=aJZyAFSUWeQCL3/7Kdlxk4102eQRyuC4f2tm+b10bOPyCe99kvrd5Tyjt9F1JR1erFdh1eQ72oY9k7lInWRW8Zu/fAdkRgEK26lhq7Ae9/WRESHc8wSfhnSBa7MkYVsZzRquttpvrGbK1usP17uNJte/WJSeKMG/9hS3NUhX+LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544688; c=relaxed/simple;
	bh=8/FpCKjXpnBa78fkZAMzVCGiZKnCnFSw8zBEtlMuGnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m7hhAblPxMgCIFrFS8K7mAnEzAlyR+vV0fcVgyC+vrq0M2xBMTONr6JrNRKOtKdz0Dp7ZuWc1iqgRAmN0aTJqVEO0o6G0m+LoJHqMl1nS+2TCfduLWAz/q6xeVJG6UlKho7arqZsALxni5PN11Voqoi2IO6vt+tgFmrkfceJ6Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=okyr16O7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UyLo/dFU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="okyr16O7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UyLo/dFU"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66K9vrGc2189018
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kYUmd6iz4TOryxUGtheeJBgCKVWvj2LRSWBQTL1u2gY=; b=okyr16O7Hyz4/bPO
	+sTZdjDZaod1lWDxs6kORAUUAq2Q/oKRttxmlQoMPLPKQk9yWu/HyckjITFId4M4
	6V4khkHqc+Bxww4tMauZi5R5weqtl0XdBsLEWtYQXNgqB8tiNqn89HSiBBu22RKK
	UE2YYn6ASahfpgRK/2fjC1/OEBEghf1KYLzoqPveRdK0OLBmw/Rahl5qxs6vAolx
	ZkP2DnE7KqQTScq74SStABkL7F/U++nXEhfdvW1Iy1SA1CLoehddv+N8Vp+eB/by
	BYzikcq3ILNjwXVsFNRnsqZavnlLMGD5jYBWb+exRs/WsdJ+Tjr9XitDu/XMO5eh
	obLhNw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04vtm5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 10:51:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8482fd61e83so20022803b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 03:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784544665; x=1785149465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kYUmd6iz4TOryxUGtheeJBgCKVWvj2LRSWBQTL1u2gY=;
        b=UyLo/dFU2VEbhkw/nJXRHx6mf/TYZqcDa3NCWQN00Ofznez4D7yl+fuH/xSHG834hF
         GaxDPtxfV33IhtrDz3da0CQl2X2hqdh/5lcRHW0se0uc6yLtWB+rjawRa46rLLgjmOjE
         gdmIjB49hW8kFXWMylm5xkd/NDe9kXDRNI+w2tGXIggndHXGdDQo8ebFITYxr0Cv7MiY
         0X22hxMIGxxDlI2aKbcNF/z6Fy/EMvV8LLVQIME9BKKKIq7IGm5KO4g8ZGcCEmcSdDq+
         h8JrSSUrkFV8NYWG9gOVIwmVe1rBZSY0qwYI+NExD+Y/69nvcwU7H/UeiOAT6uIUHapG
         GkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784544665; x=1785149465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kYUmd6iz4TOryxUGtheeJBgCKVWvj2LRSWBQTL1u2gY=;
        b=EaJ2Hwg9CK1+VpgGdrcJiKYYyI9ai8PbiiPRT21e64knb0z7OkK1k9F+GN2odKLUOM
         Qd+qfJjjwkavVO6NuZggcSxsGqDz9E3gd/EaF3PZFXm4LYIu1c+9Tr+Fvx6Qc1J/5KWQ
         Ia7PjpZIQmXyc9qcTC5hB4GD9VqTn+u68JpwqPv9jBW84//e7nyRWwXdk1duhSPayMfO
         SYq8v/2J0DrVQg+poCr/2sLieyVvEhG4PJ3vZU33RQzswLWJIJajwGQe/zNJoTvbrL0Y
         IGmOmaaya2xZGLbEKg8uyQeijhco5nEOZ4w3q4Su7RJxSL3yu7lkQJhglqbJXPgAOap1
         lMLQ==
X-Forwarded-Encrypted: i=1; AHgh+RobDm5YsnpVzi3xs8PzlGGKRIiRSq5QlIYxJEY+uhoMUZSbNQ9WdEfZZmOP2/NCxrJS0TDk8fX/Ww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxmX77c8+1owdP67eS9y43F+p2xekD9COIGgynDbBR0jrVtc5p
	A99GbsHJdQ3xdB66hv3RZF+L/I/GwQiheQeN24CMkmKbfiaM698sag5I6vQLVHiQv3b6Wv5o1XR
	ig5eoOtsLFpA/IJsH5e0uZnHzDgSsCRuGXjuB9120CIRncP24QSscuZOKFXWswA==
X-Gm-Gg: AfdE7cnZnOkEuQgQDF4na9JwOAyA0j7/QC9yP2eLxleEtALrXGZ2pKqOlLloF40Fl7b
	I6IiB8ZeyMH9uCEo9k25+5XByDsXApTqmhua2PUWTF+zZVGeyueSh3yykqlXfiRWs4d99soWiCl
	PnOJZqHeL6FV+apx9Q8ESXKKva70eRdoZ+ddwku2pM5E0u4X+x9qmIx1ugf6i72vzC92B/o3ZCI
	giXWmWuLhvt2RFPn2eCnrqVHRIbcakJw54/Glp+ZBOaWTwFhRE4GF+l/aJI4+Wr8hby+pzKRwAv
	//9dfdYc3XDLeBOetqmSNCTJ8VFtwgcxrsAV2/fpTjYmYXGoH/0SFXcF/IXRms65Ix85Xc8KbNF
	dyOesBTV4915XJJE=
X-Received: by 2002:a05:6a00:ac03:b0:842:708f:39be with SMTP id d2e1a72fcca58-84c292cf660mr13294403b3a.5.1784544664841;
        Mon, 20 Jul 2026 03:51:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:ac03:b0:842:708f:39be with SMTP id d2e1a72fcca58-84c292cf660mr13294369b3a.5.1784544664408;
        Mon, 20 Jul 2026 03:51:04 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb5159b11a5sm4343368a12.0.2026.07.20.03.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:51:03 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 16:19:24 +0530
Subject: [PATCH v7 08/10] arm64: dts: qcom: shikra: add WiFi node support
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-shikra-dt-m1-v7-8-7dc99100c6dd@oss.qualcomm.com>
References: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
In-Reply-To: <20260720-shikra-dt-m1-v7-0-7dc99100c6dd@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Komal Bajaj <komal.bajaj@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784544606; l=1908;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=8/FpCKjXpnBa78fkZAMzVCGiZKnCnFSw8zBEtlMuGnI=;
 b=u6HWq0hutlW4qBTUE1IxFWoP+iiEQms5ZH06WNsfgg0KS8C6aI4eKMiFkCneCg/qGslYORhO9
 uQ/n6XwT8YICRS03o5aekJYImY3m+L4de0PXxPCAAdr6OEsB/8j8sa/
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5dfd99 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=QXJAvSDBUSNnL2LUfNIA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfX455It6kUnya2
 dLp+KVTpxHMeqe4tH3FWz1IBdKOuIeQuFZst0i0JZ1drPr7exMBDNjbljht8K9p9ggcEXkMa/lr
 XvBThCGNFMgUAUill6BI7AB3TOOyRLqHK504Fa2Izke31SBEFVidWrTUDc+nr3gL3HOi/UHARHH
 KX+nFIxS2qr+iSK6vAue7fpVQ4+uc0LVesp+XH6x2bBTB9sZkMyYZLyNQCtncXQuqfnvozI6kID
 pLdnJ+PvFsQsr6KGhCmK+H53mTvgA14ZRKfxg8iQmREzBDmkqbFuXz08+/LZETWBALj2VnuiTh3
 6z589fqSRsqWd2UmIv7Z96D/bUEA4a2zJM8R83WmikOY/kvQIodnPtxnw3rE9DDvvl7MqAN47pe
 XqHlvkOH/HTmdi5j/lDY6GPbRpof5X94v5Hh8quIU7aoZHpUM8800e3pw1sNoRRQSfRLsr77T6y
 DD5o7FR7tzPD+IMJxSg==
X-Proofpoint-ORIG-GUID: 01yhDOhwAfMNmWsBwebNCAYK9RMZW_Jp
X-Proofpoint-GUID: 01yhDOhwAfMNmWsBwebNCAYK9RMZW_Jp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDEyMCBTYWx0ZWRfX03eyqevwRgBq
 DDvRdLcaGOtj4k8MWUgzdxS8id7KF58HRB3RDfNQ3geuUFaEJkC2Xn9JSb4e/VnVz6nipsTKof/
 IqXLrzpt6YRpzS66/n74ahIWFuuTm6k=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200120

Introduce the WiFi hardware description in shikra.dtsi, including
register space, interrupts, IOMMU configuration and reserved memory.
The node is kept disabled by default and is intended to be enabled
by board-specific device trees.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 3abd0a686d0e..205814c4b349 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -2079,6 +2079,29 @@ apps_smmu: iommu@c600000 {
 				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
 		};
 
+		wifi: wifi@c800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0x0 0x0c800000 0x0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_mem>;
+			interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
+			iommus = <&apps_smmu 0x1a0 0x1>;
+			qcom,msa-fixed-perm;
+
+			status = "disabled";
+		};
+
 		intc: interrupt-controller@f200000 {
 			compatible = "arm,gic-v3";
 			reg = <0x0 0xf200000 0x0 0x10000>,

-- 
2.34.1

