Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD035677E
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783971461; cv=none; b=OK4gIz07p2tXlxymP/4Q7bFBNhdnktMLRb2WPBEKY8i7tKusdyxlxwfGVbm9kRhUXXbR848cOdi361HC0lBelcf+qPu0xFHAyFAoeWHfROT4r19QpB5BLFA2xHSYlOy9wdlBtpEUFy8FYnv974Z30efIy9w5xxGivFb0GX1Lkwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783971461; c=relaxed/simple;
	bh=do0tzTludNgpGS/opTf3SCuV5bhJp5iWnrGtxTlST74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7Qa+ITM18sz8W3QWeke9R6xXYP66VFSymc2yQkhO245jVP613GXDZA9xPg7o/0rnx6r7mNysul4vIHVfhkBp57FIIBx8d2yFxQ/rueHJrnXahLr4UcOF8VacQb4Ujp6WEFY7vrL5c3Hc1j+Q7ofCEy8NQ+FBBI4da2Q1wMMjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKQKw3Vw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M5nbHANc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKQKw3Vw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M5nbHANc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DJ97fM2275365
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CJNfEpph7JMPeJCP0Eo5JXk7HW2DFwVqyvqs385kgkM=; b=oKQKw3VwQqBvMGBU
	CihsrWCq8Mb1BckigcRWToTIWDoi6wUYjouCU7KhEJN2zQUxaNhs6axXJHgtf1Sx
	ui2/Q1PgvNcwNnapT/RbwSBpK57xvjuXz80yiRJ/7boV8KAO/Nh1K0GybVXVk9Vj
	aBRJxQ0kON+p3SDCpjCTHOJcLBtNsRN0BiMyOfNsc2/vIFgEApY2UxvdJC5UFZ6b
	geckV5BEoSR6GiPz27kKqYjiJkH1ykUfVoupsP39zB36t3D1ILRRu6t6PKCWIIY1
	w9RwZKnO7iVkIW2mWoqK6qACvptX/j1OUM4XoEta0KgktwRSu4Rb6o30pzZIXRxl
	fxeugg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p0hnc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 19:37:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so4578395a91.2
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 12:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783971458; x=1784576258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJNfEpph7JMPeJCP0Eo5JXk7HW2DFwVqyvqs385kgkM=;
        b=M5nbHANcdFE2GiXKw3ktRltgCwBomIa4Fj/P2C+QZXLPBIhF2ynL88hF+hlCbwiS/9
         JF7PNWQIVOGU+7q4veaSg414igeVhpV3s2/SjQtzj2bbyT7VPxdI0pnGIxnwzXGqWDy6
         AZADThWEAeD+eBOIhILXJ8/ZHAlkS/SwF9moOD1K3Gjm+NW5+WYXe8jxbe8lszEUmwhC
         Pw58YjWbELvvh1JZZ1mvczg+QnQPjcJnjhnzDIF/FDvhIKNpwyLdjzn2zX/VTDuTY2Yf
         wBuCFmqXWCXs91Y/213TWWH83ktGtE3IXwyqqiB+TQnOskEexrOP+eX+NjRXs6htEaPa
         xiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783971458; x=1784576258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJNfEpph7JMPeJCP0Eo5JXk7HW2DFwVqyvqs385kgkM=;
        b=WxroGeBN7Tyg2rWvVHcO+xKGhVPp/X+WzQUKHuKJZ77iESv+CAkmYVgbdGngquqP43
         lvkpWo7VBnJMfRvS2jFFYVOKGPMwGJ+1MF82Zvhht24j9wn593D5veyBqH2JTw3ODfdh
         Kfvsm1GZd1Gz1NRDhoZCoS8GAQvS6ZcVLw9k9mA3Rg75qt1srr9YuzGA6db6m0HqECwW
         u6WwKaHxk0uEoC9/XOboHEnFYYL7raNe3iZxUSGu6dV7w48xOn5DHSBWOxAhyGF/vB11
         lQ/+bNoEOIBX4nWMhJrLim5xCB/ieqtbtwIMGU0OuSOjFaDF73kHLi7EnXh78LxOUfgf
         gqDw==
X-Forwarded-Encrypted: i=1; AHgh+RqD34Bz8lppSorNgZLbPq4qO7WgGAMCWJ9K7lVHjoeB1hCNVDhtinpyL+w6SLtDZSX8FetY/B8XdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyivFo+n/tlMaqWJuyd3eKwszTt8DutvTAGhLgyR0tldnCYlw5A
	AeV4x8mgYtgQ8kxDkpaq9O8IqEe94YIi/JjAZddjWWeutvgyuN8irnls4BmxGTUIt2bh8ofcEZe
	jP9P55bFHei0COAYkGOw6zYqlW2ajpnPNpHPBUqFcltmmsvv7BlEdbNeopB/qctCIFPM2TQ==
X-Gm-Gg: AfdE7cnEm254L6EPIM1FPZu54LTxgv+CzZErsNY4yEdcx1HqlrruDcHXeJnxFINnlkU
	iV4PtrkVCrE0dPnR6z7DNHBJB8lGczwBRZ7NPe4CMje3t2GAi45F5dENy7d3rU6w7rd1AN23GwJ
	3R4Pp+xpv5UhzhEu0Zf9PUT6bKruq25ukslDdlgTwn0CtUj1FUWJmvakxBzt1QyQywkBYUSP2o5
	wY8kYeWxD9wqtlcoTpEacMUr03hdvZLAZrjGS+zZErwyzK5B3y7Ff+vDZftTEuZ8aHr1veraktG
	SEKf836gex6tjltaw5Ih1ukusZisGmuiCsTGb7w/3rYf4POdiIuGL10rQrkKAvP86VShk0hBywE
	YZHoZYx/sGXmN9EQpOzHcnjmNgA==
X-Received: by 2002:a17:90b:1d45:b0:38d:e28e:a625 with SMTP id 98e67ed59e1d1-38de28ec08emr5880905a91.16.1783971458577;
        Mon, 13 Jul 2026 12:37:38 -0700 (PDT)
X-Received: by 2002:a17:90b:1d45:b0:38d:e28e:a625 with SMTP id 98e67ed59e1d1-38de28ec08emr5880872a91.16.1783971458109;
        Mon, 13 Jul 2026 12:37:38 -0700 (PDT)
Received: from [10.213.101.118] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313f3ea883asm207540eec.29.2026.07.13.12.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 12:37:37 -0700 (PDT)
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 01:06:54 +0530
Subject: [PATCH v6 05/11] arm64: dts: qcom: shikra: Add SMP2P nodes
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260714-shikra-dt-m1-v6-5-bee265d3499b@oss.qualcomm.com>
References: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
In-Reply-To: <20260714-shikra-dt-m1-v6-0-bee265d3499b@oss.qualcomm.com>
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
        Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783971418; l=2339;
 i=komal.bajaj@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=x9fBogSqQcJioAYXHmlLdEWBKjDZV1eFUot6gF6WwrY=;
 b=lI7UXLVv/TSry+HZZng1Czwu8BQjTDMxBdjJZJlE5346b/LBsksE51Wsyp52OFL6dulU73dig
 fi6pIIxh/m7AK+xt6ynT3pVN4MnbAu/U6AJSbnD7chGdTw2tVtQsls4
X-Developer-Key: i=komal.bajaj@oss.qualcomm.com; a=ed25519;
 pk=wKh8mgDh+ePUZ4IIvpBhQOqf16/KvuQHvSvHK20LXNU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX3e5kKQw2GRcS
 CpzjaamI8kC+R7N25LkxI25N/r4PDrc/spzBsiScWt0jebEXPSfc2v0aE39cUKTfYLHO39BVqHA
 /Ys1UN7aPsmY9J7hl3SOLviWOCeUhUI=
X-Proofpoint-GUID: R3YZ9TcaWDTXYnc96A7yb0gY17X2b-ke
X-Proofpoint-ORIG-GUID: R3YZ9TcaWDTXYnc96A7yb0gY17X2b-ke
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a553e83 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EkeGX7dVun7IgMBPpHMA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwMiBTYWx0ZWRfX7w8nX1CU3TeY
 Y2yLimKVZ2wWOhbCksvNc5vNBULwveoSdNf0oDIwRX3IfazYNTOfQR+lJ4JpR/mYPrIXqJrckfI
 H8IaNmog624qYcch2VT4euCKO1IvY+5v/GbA1brelF9ukWYuHilhciKlVpFsrRLd8YO40i+LmjI
 KVPSaduNlwIC1fQeHhHCMfEFyyAv5al7VJBUax1iuDDqwIsXAWvP8qmwpdAKrbCBqpo4j/PlEXQ
 oot19TnDpgp7ORMyT/dZE9ywBFn9wIyzCUSMxC4k13F0uJJjP630dIEozpuiP1HQPth+dXmFjjB
 kFrmyEH7QB1UXnGCS9UE67zBanxryu4YynOOjdaHghp4BmT/MFbRSF2TDh19hLtEtXFW5C8zHb8
 dSCcMZzCvDtTTxsCqqsf+ld9jynylt47lXkt23yrFmrTzkqP50xmCq7q1vu2rSnFFNJ8DcHd2e+
 oVckMMjcTHf7W0Uq9pA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130202

From: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

Add SMP2P nodes for the cdsp, modem and lmcu subsystems to enable
inter-processor signalling for remoteproc state management.

Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 26ae21d4c7e3..53dddf35963e 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -428,6 +428,75 @@ lmcu_dtb_mem: lmcu-dtb@b4702000 {
 		};
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+
+		interrupts = <GIC_SPI 263 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 6>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		cdsp_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		cdsp_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-lmcu {
+		compatible = "qcom,smp2p";
+		qcom,smem = <617>, <616>;
+
+		interrupts = <GIC_SPI 287 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 10>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <26>;
+
+		lmcu_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		lmcu_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-mpss {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+
+		interrupts = <GIC_SPI 70 IRQ_TYPE_EDGE_RISING 0>;
+
+		mboxes = <&apcs_glb 14>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		modem_smp2p_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		modem_smp2p_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 

-- 
2.34.1

