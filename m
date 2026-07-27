Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45D73BED01
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167257; cv=none; b=jLabwrxXSiuLHG0/CyAz+hkDBxhgbQPRBtHwjtWpqOw6da1PfPXRpNpoTxeIDpZdNgdDa+75Fg5BFVOl90tFlDzeKYbLsvOfJYi71JAFzflOgipM/zw0DtC4ZXNl5YfKT29iQHMzLewoOHniyKWrNmpBAuwndgBIvBx1MKC/OOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167257; c=relaxed/simple;
	bh=yMqnOQaDEEyw4WufS9r/vXZ36AgWvKFPth4a+uQU8BM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HaRtMcC21c7zafBl3dsbrnHhd2ZvhFaLy654S8Mvzy6J3KLhYGgRe2WjRrwDUxucjEDa0j2E07N2TCL663b/FI6xmjPfOz6FfAOt2acPEFX/DxIch9XXGonEUYH0Ze1tTlGjo8ULdOuWp1SeHrCDWUYPeNZfnrHXac3WnfosCFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J9ryUIsz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e8cYvecc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J9ryUIsz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e8cYvecc"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDll674035362
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DJP0NMWNGjYscw1h5aBWGeorJPmZjcfRElvC614KmrI=; b=J9ryUIsz+9lBziPT
	gMQxIPU0LWpFNuKmdmY48fh6G7nkavc4cPDli1knc7SAqnDFSX3DirXNlI9SF6os
	avDLUrSgInuHSCuwxDGf9InPVHygDtLlic4T9oBm8Gf6PPGtMz98hqq8DMAN3Vrj
	vlLrXs41Twmr3K+7OUgT6dsEz45zrpzb0yOFk4jwZSCnCAJ0QyKLIZ9ggbCeKJyD
	+W+QWaL95MMjPvzbmhwWW8UnMf+xDr5jITGSoyUfLrJgJU+DHK/8E5vr5WBTm2Xl
	QDeql2pxNcjGueyhlQzwb9kTnsYJ4A6fagqHMbTDnP++fHfBP/kIHWNzGh1Te17A
	JTjQUg==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp30g22kj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 15:47:34 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81eddfe28b4so74564497b3.3
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 08:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785167254; x=1785772054; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DJP0NMWNGjYscw1h5aBWGeorJPmZjcfRElvC614KmrI=;
        b=e8cYveccByvfV2aDWv92DJIbmuIBlujAEvam3dhZ/+kovDHTP7EPO7dicIipqrn3Jh
         QaKsVfY2B4wOmUiG/r4bNkc/MV83DpvlZARARvttgq9o14x2sXqOjJtxIfVUDQLdhSqG
         5NxJjkMpw/8kUVaT2dXDZ+AeLXmmSZC2xjQtU0eU3c07NA9r9+Cx1RxsYSA5inpzFQ1s
         ppfBvtN4gwG2AW3ydzUlxkakcFYAu20XT6//r4vI/+Z7rH+iC9WN6YlRB2O5b2bMUnoe
         qdSFfD2fAzRBh3ORw5+HumDVZ2cbOwoEiTCoIh0XBjWcxroEOQSXh3wPvD5FWsuVx/EL
         yBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785167254; x=1785772054;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DJP0NMWNGjYscw1h5aBWGeorJPmZjcfRElvC614KmrI=;
        b=JeycWYaep9iF0f0XBIxIVJWYqPj+5x4O4Xj2TIKq8kqItui6cDcF8AdxmC7ftFD1hq
         PE7qeCMb+TUPAvF/p/3Ec7WIo+vD5VPHF5L2jZETKlOudRIRt+8nn3qc12W8whC1l9fQ
         /w+GlY1VKM8Sf71fe1MJCidlcPZHfMDRsmpu0106T6ZOWdLaFtTJrn/jcwzUhxnjhLdx
         nLj+F27ivE0f2F7l3ufn9xamqtIJJXimEJoIEL+88O/MWucRGygopbZVWqZhoK26ysiS
         +9TnjcJTHuKfssK+Z7rhTUO1jEAgi0Hg+RlIdGNAMun6sPBkE9R4+rHH1XW9pFrOENF1
         4yVw==
X-Forwarded-Encrypted: i=1; AHgh+RoYr7LFPyT4PzrLKSI/MS/Ze6LzbypEChjLQeg6u5MQa0F7VBuYEehh0kg11yE3x62AS1rB9+hYCA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1OknW+I62Nin0jGhSazo4MTmhq+1cgSDznI5wPqp4P/0eBjje
	sbdELrgHc5djwN4m2S0fQu6naRrx6HZPrYSBukR5ttAjztNHSS9WHyJn5fXLE3e4eNX/bFVFWWw
	MwOWclolDYFBy1UKsM53OgCctYYiaNMLPRmLfsGrE6VhNRQNYL1tYqKqec3K3uQ==
X-Gm-Gg: AR+sD12OKnK0CpOisOUDeVi8PHgB1UG9q4liudZoqLeDG81DHUvy9c7NkCoN8qE1jKv
	CVzR5ZkIvOB8djCQ9MlLUIAUFGvEGPDaZcdmFe+UTuKNIu4yeiRQ6xj7lIf5+Lo9rLbEfcB9kLj
	2w4lx7iWm4kbgaGMq4jMYaUA7pQNAPHMyxUQ75vo05obAjpaXIViiPA3ykSoFyPD+8mkKjzTYv6
	zvzs6TdiOA/lYZDIyUC3CW47LykzF0iSp3SyDQqeDzSlkY5hD0nZzJHJU7FsYQRvOkNbPn9v+OW
	p+ePjuLZepSY/r3BJpQVx9YGLL/KWst31vRK0/yzWDTcHFiABCRyA49FJQUEiU9kbcu4YQzuMDj
	JAELyViI69Q8hflGj4sVTUK/WclyaXA==
X-Received: by 2002:a05:690c:b9c:b0:81e:cc9f:3dfe with SMTP id 00721157ae682-81f93935c11mr489847b3.1.1785167254255;
        Mon, 27 Jul 2026 08:47:34 -0700 (PDT)
X-Received: by 2002:a05:690c:b9c:b0:81e:cc9f:3dfe with SMTP id 00721157ae682-81f93935c11mr489677b3.1.1785167253763;
        Mon, 27 Jul 2026 08:47:33 -0700 (PDT)
Received: from hu-samana-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f657c727asm33307617b3.19.2026.07.27.08.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 08:47:33 -0700 (PDT)
From: Rahul Samana <rahul.samana@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 21:15:04 +0530
Subject: [PATCH v2 4/6] arm64: dts: qcom: qcs6490-rb3gen2: label BT PMU and
 M.2 PCI node
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-rb3-industrial-bt-uart-v2-4-2d100f30e202@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a677d96 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=5vclj9FtNX7zLWCMXg0A:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX0FQQbyeGtAIQ
 Bl+ZB7ze3C/OLewku0Gw0GnhT4MM0WzMWOmr4KAVkdj0nNrq82su1ffcexXReRpxDzV4ZxInRzd
 edilbHM27ViOYRBHUeeGFzjZSeL079Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0OCBTYWx0ZWRfX7/6QCJDqRMZp
 pxvk6mfmJjpFxGnoltujohka1bhvQRB3xbD+Clxpr39zFPW0HTXar6z4x0M2Vtb1AbrI79oCWlx
 M0JbiqpvBOwaMKznVz6L+VU2H/BsMM4fShgO1iQd0pcTGY//a6PXDKnVLL0Xg5TmDu/i5Yb1/47
 Fs5/E1XgfGBqOJfR1U4I3a0TsNM8tcrkw04EUgcz+sWNe2EUVWVkobEdSWEThoe1P8mq4clDNZW
 ikfB0z5d7Ncbj5zuj0goZ+UyCALdWWuD81/q4bI/JdnSantlTPCJD++p2HMz19QC3Iwdx18Op1i
 wTlXTEE36KkV9kwM5Cj24AGrxjlBihIuBmF59a7HNu2GrCql0tevYlp0mQjvMfojmDZUcAqkpnI
 RrhFmvH8OBRBdOlmnBCbHZT3S95pxJ228q+BOitWzKh4yEFwRjksrgPAy3Fls4vGp0aL1vG8Ket
 4/f9QhBzGuwbvly8NIw==
X-Proofpoint-GUID: fatF1szRy2q49PXKNHAE95EIfCit1V13
X-Proofpoint-ORIG-GUID: fatF1szRy2q49PXKNHAE95EIfCit1V13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270148

The reworked RB3 Gen 2 Industrial BT UART overlay needs to disable the
on-board WCN6750 PMU and add a graph endpoint to the M.2 PCI node.

Label the exact WCN6750 PMU node and PCI child node connected to the M.2
E-key slot so the overlay can patch them directly instead of using a full
path or reconstructing the nested PCI hierarchy.

Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 37a3b51323ce..b2b6fd29880f 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -325,7 +325,7 @@ vdd_ntn_1p8: regulator-vdd-ntn-1p8 {
 		regulator-enable-ramp-delay = <10000>;
 	};
 
-	wcn6750-pmu {
+	wcn6750_pmu: wcn6750-pmu {
 		compatible = "qcom,wcn6750-pmu";
 		pinctrl-0 = <&bt_en>;
 		pinctrl-names = "default";
@@ -901,7 +901,7 @@ pcie1_switch0_dsp1: pcie@1,0 {
 			bus-range = <0x3 0xff>;
 		};
 
-		pcie@2,0 {
+		pcie0_m2_e: pcie@2,0 {
 			reg = <0x21000 0x0 0x0 0x0 0x0>;
 			#address-cells = <3>;
 			#size-cells = <2>;

-- 
2.34.1

