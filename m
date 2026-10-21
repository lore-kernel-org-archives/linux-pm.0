Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561108;
	b=N26ayPVJ1l1hhyZEDa0bYAcEnrtl1kbo/IMPSraeZZ41DYZLrw6CjTxbvpsX7FqwNnbC
	 ZlOHxH0Tk7S/IxqmFKcXUZsN9uwzZwS5dBPO1iGafuiAvAgJiGEWFrPGxF8H4KmKEUDPz
	 nIRm8Pf5kPQB9TC2gMc3pcXGMMWYjELCvl4aKXquFk3rY1mY2CtNQBK+jhdV6Lyx8ISgA
	 7cWtuly3O+yjMM9tnYK2W1BxcbLG2nPxBOsTazHhTnr80F6ehw5qqTX8WzCjBL2ScUKwM
	 zwjOO7ayoZd5hYiBKV7Wdg341nKHO6OW9wZh3St9mtfJs8ID5RybBR7nsDfG7sO1JQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561108;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=EnEZFbptyf7UjxQ2XRHIENyNVr3NaUlUd7vT/Jo1tl8=;
	b=1YmFTJeYEK7NP2i7Kk+tzM8xI6rQqgYULlkKCg1hnnyal95FSA56xCVSgRu66gjcpobA
	 utNB/o4BFn0aJIIRrfn7sLJWq5QwB3MzFn36oNcJuARzM4HukHPSBDKh4r0sifbS00Sv9
	 RKFy6gSr3MzLwxJDtZTIs3UPxyIcUFq/mnvb+f0EcNuuVR0/XwSf353WIMgPZm1j2Ldnd
	 avUfVL0/L6bJjvJ+p9zUfN5jFLs2u2wAZL+xP8owB38uywMPti3Razkf83U/bcphSYByE
	 lO2b4sGvNmsQ+F/vREx2sVKEiY2UT5l3L6QkE4yG8bN1TwE+wo/aLd8BiimoLostEsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QHzDQCAg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wn+4ELnx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CF2606A326
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 05:38:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9CF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QHzDQCAg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wn+4ELnx
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2F3jM3256703
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 05:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EnEZFbptyf7UjxQ2XRHIENyN
	Vr3NaUlUd7vT/Jo1tl8=; b=QHzDQCAgXqWT7ejg19CeX0Lc176N0Dz5qMy5ut1s
	Q1Z504jw7O8loCumWMAY9PGsgOdHUcBlvjOo0ALJEaBjb1xcLzGwbD2oAFZ+txTA
	CS42PRvAZDAym0/A/QIY4evjSqT2gS3tdjmBvbM9bHhduwmRtoQMjP2EdsZ3sSBj
	rqeH34XOTDCU9X5kdCB5TT2Q+OcBXJeYV30w1RN3MqQT9lugQKACmxnzWOIpaKox
	tvSOxwq3SJiVrSsHZ7GdVeDI5Ap/799JGWX1Khmf9bDRV0VG0gTR88gvrA5+1nzl
	TlVGSkb8uOmlLEzmJ7c8cc6ySDivdFyx24At65Xh0p0wgg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9v26cp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 05:38:26 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-1663fb7e005so568787c88.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 22:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792561106; x=1793165906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EnEZFbptyf7UjxQ2XRHIENyNVr3NaUlUd7vT/Jo1tl8=;
        b=Wn+4ELnxzrUG/ZupapidTG9yfMWdPcgDeTyAYOa/10+y5/ZGqlujd8Fgt3RiROE+Pn
         shPq3E+7qHKBARNwc678MVJqV9GUcIXlpa3x6kM2hykW2YVe+Y4/Ms65m7JIKVVI0a1n
         G/n5k3votHxekRI025qdNhivxzR5YFVi1B6gNBo4SE7npegjBdTeAXaQA1F04ohpUU4O
         IAk8EWBG4Xk9zqkTYxuj+Ffo6UZEABsmMgcNHjo7bWhcwcN3xg9m0/pbyqcMKWS9If8p
         LgTOxs1dklkShUBCDJcBe8rgYi8zdRQM/DrZ3Munpb5z7FmeN6B2LzTZog1uAP6pRp94
         DZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792561106; x=1793165906;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EnEZFbptyf7UjxQ2XRHIENyNVr3NaUlUd7vT/Jo1tl8=;
        b=mSFi5WfdZwTn9y/SsMopjMJ9WIElVF5CPjEfvytyw9JFkTWfLFbsaiThcs0FBk2CP9
         GQkqts28YJ4SVDLIWGPgfO8ZRFINst8NB+abg8o24f1kkZ263HO8c42ZnO+0+FxQh0Up
         9cg2SWHuwjQ/QV42p/6yft5FVc7bTy/tkwCRR0TtywI4DITwDAhd6H3wFd9EZiZ4XCu9
         czxZ8W3Pfq+G77AZfiz4wV6v9/YRHBPKiM6wH9EqHFoDzjKVykKaOP9Zceurg8vRrhwj
         SdcsCXl+N99DtWehcae1fCht4jsOqUQspt3CXbLpVmvbXmFKaXKasfMyheLggX38k2sh
         nHyg==
X-Forwarded-Encrypted: i=1; AKwUvBxnH73vS8YNyi1FT1LJEWBXFKqYySmrUR5RoJNeEVslFKf1f3VHcf09RotNOdvBz3LNib/lwuWRxw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKoF/ZeulnQjOB+ZRHpW+IwvlAyc73GbotKdoyswFn91Z7LNoyK
	rNB4EYJzDV56DxRszoVE2kEbB/JCpSWMNsVcBQT5tQJkzh2AZqPIKfRPfH8nVQUbjsn2iZSurR7
	VRHzE8Xn9VdacEu5lpIHcWBZt66jBmyyTY+mCkF3OKHb4BbDhxuBE4WF7KVh21A==
X-Gm-Gg: AYBFou2EwJfImRFy7NBjqZMcutwB0VjoMrKf6xsybKCKIL2qaJJVJiNVJKAe+A6ktr8
	u3anzxeV8NfKRALZ07SGmVfrpMVdZTb5suD+8YKy82f9LPM8O7h3kJExybMy4ikmSSaX5VP9zL1
	TON+vQ1FsKXruIIqLNPwyjg+qxW4JGUcLIOBj+Z3cdHqqcWC1n5Ai5C/S1dwrlsx2i68Ze0FBBM
	vA6Se7WeIMkBb1S4x0aeZcpcaPsIkY/DCznWBuv0lbc9ggN6ZXBGTJBRHipaROzYgpr08sNp64F
	uEMjZSDc9XJ20hd7IQKqQcw1gnWUx+pxd2JfVp3yIYC2VPX9gsQGtHjXbSYO0+VkftptzxwVXxT
	uzxylcbMhp6jyF5EkN7v81fS78Qpyi7bgIRzg7AaHzgCC5KHeBzon/weOlziBFLFT8w/ZHLi8q5
	dMHzQg4eZ0DEhpqlL+VQ8C9yovwv9OnQ==
X-Received: by 2002:a05:7022:6ba6:b0:16a:1fa:58cb with SMTP id a92af1059eb24-190a051e33emr1828699c88.1.1792561105394;
        Tue, 20 Oct 2026 22:38:25 -0700 (PDT)
X-Received: by 2002:a05:7022:6ba6:b0:16a:1fa:58cb with SMTP id a92af1059eb24-190a051e33emr1828623c88.1.1792561104341;
        Tue, 20 Oct 2026 22:38:24 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903ca044d4sm3449053c88.17.2026.10.20.22.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:38:23 -0700 (PDT)
Date: Wed, 21 Oct 2026 11:08:16 +0530
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ilia Lin <ilia.lin@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: cpufreq: qcom-nvmem: Allow generic OPP
 tables
Message-ID: <athPyI5nvYG4vmfl@hu-varada-blr.qualcomm.com>
References: <20261015-opp-v1-1-f18fb6f9bae1@oss.qualcomm.com>
 <20261017-calm-tangerine-marmot-2e8bfc@quoll>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0e04jeNFWWxIqaY/"
Content-Disposition: inline
In-Reply-To: <20261017-calm-tangerine-marmot-2e8bfc@quoll>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAyMSBTYWx0ZWRfX1Eu7y4QKZauh
 c4MUefwxmv6kdx2jVCbLyeZck31oeoM9ZoWN05YmTt9Vk0s3P6BkwrURGXop1fCW4sPrPBcPifN
 mApF710Hcqo08xRTYXqCG7SN7mnG2Hc=
X-Proofpoint-ORIG-GUID: _5kmVp280qccCVpebyxMFqwjTTo0D_w4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAyMSBTYWx0ZWRfXyx7RUjt0wDBZ
 Ry+53VEtrByQCXi/ZxRZwqsd7kAwJ97JDoY/ddiQbzprHMLCNCKxfa6qodjmHLnhv/G4gUWOTyu
 8yFa2UKlD9oyohGx+EmfCwPKqTRmSTY4fsgyJLN7Xv+ADJKQFQ5PfEhhUw4eJNQ68BwcHtqiYVU
 td+k1q6yitgKuPHi/m8TpLKF8JCm/6tB3CUBzSW+p0jrsZNhhXEXC8753cQbRHc43Px1J8sc4KK
 49EvoGn8mQ2oxRo7BZpShYYMNWg/X+ierzQd1cuKg+bmrEyMdIYvwGPiNZ+BVnMmzbXmCOSi1RV
 pUibE//Gy+yd2Voxm/sTzNLqdatovsNg/GxK0K33QwjSg8aMJ4sG3SbIJJvUvkXI0HipTn8Ava4
 hZ0akqW05oHBKDk+uscHyomBW7xzE1Rs1ZevvlhEccHEBLJjr1XPUhmxnlp/Ll7lrzhadKI1PuI
 naKgxtVUIGER4miOU2A==
X-Authority-Analysis: v=2.4 cv=I6zw19gg c=1 sm=1 tr=0 ts=6ad84fd2 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=gEfo2CItAAAA:8
 a=01MFGdCsChwvBfu0fykA:9 a=CjuIK1q_8ugA:10 a=GVWKzDYot3hTMZ8E5o4A:9
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: _5kmVp280qccCVpebyxMFqwjTTo0D_w4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210021


--0e04jeNFWWxIqaY/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 17, 2026 at 06:45:53PM +0200, Krzysztof Kozlowski wrote:
> On Thu, Oct 15, 2026 at 04:25:28PM +0530, Varadarajan Narayanan wrote:
> > The OPP table node-name pattern also matches peripheral OPP tables on
> > supported SoCs. However, it only handles Qualcomm CPU and level OPP
> > compatibles, causing unevaluatedProperties errors for generic
> > operating-points-v2 tables.
>
> But the select should not select them. How can I reproduce the issue?

Sorry for the delay, it was a long weekend here.

With the attached patch, I get the following error.

$ make LLVM=-18 ARCH=arm64 CHECK_DTBS=1 qcom/ipq5210-rdp504.dtb
[...]
  DTC [C] arch/arm64/boot/dts/qcom/ipq5210-rdp504.dtb
arch/arm64/boot/dts/qcom/ipq5210-rdp504.dtb: / (qcom,ipq5210-rdp504): opp-table-qup32mhz: Unevaluated properties are not allowed ('compatible', 'opp-32000000' were unexpected)
        from schema $id: http://devicetree.org/schemas/cpufreq/qcom-cpufreq-nvmem.yaml

Thanks
Varada

--0e04jeNFWWxIqaY/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-arm64-dts-qcom-ipq5210-Add-I2C-nodes.patch"

From d207f72fc23fb328aa2c3cbe1f98780667f7bf10 Mon Sep 17 00:00:00 2001
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 14:24:54 +0530
Subject: [PATCH] arm64: dts: qcom: ipq5210: Add I2C nodes

Add the QUPv3 I2C controller nodes for IPQ5210 and enable I2C0 with
the required pin configuration on RDP504.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 .../boot/dts/qcom/ipq5210-rdp504-common.dtsi  | 16 +++++++
 arch/arm64/boot/dts/qcom/ipq5210.dtsi         | 47 +++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5210-rdp504-common.dtsi b/arch/arm64/boot/dts/qcom/ipq5210-rdp504-common.dtsi
index b32daa7c1559..8068dd0d2119 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210-rdp504-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210-rdp504-common.dtsi
@@ -59,6 +59,13 @@ vreg_misc_0p925: regulator-usb-0p925 {
 	};
 };
 
+&i2c0 {
+	pinctrl-0 = <&qup_i2c0_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &pcie0 {
 	pinctrl-0 = <&pcie0_default_state>;
 	pinctrl-names = "default";
@@ -191,6 +198,15 @@ clock-pins {
 		};
 	};
 
+	qup_i2c0_default: qup-i2c0-default-state {
+		qup-i2c0-pins {
+			pins = "gpio20", "gpio21";
+			function = "qup_se2";
+			drive-strength = <6>;
+			bias-pull-up;
+		};
+	};
+
 	qup_uart1_default_state: qup-uart1-default-state {
 		pins = "gpio38", "gpio39";
 		function = "qup_se1";
diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 6842ac21e05f..80050845f965 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -160,6 +160,14 @@ opp-300000000 {
 		};
 	};
 
+	i2c_opp_table_32mhz: opp-table-qup32mhz {
+		compatible = "operating-points-v2";
+
+		opp-32000000 {
+			opp-hz = /bits/ 64 <32000000>;
+		};
+	};
+
 	pmu {
 		compatible = "arm,cortex-a53-pmu";
 		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
@@ -435,6 +443,45 @@ uart1: serial@1a84000 {
 
 				status = "disabled";
 			};
+
+			i2c0: i2c@1a88000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x01a88000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&gcc GCC_QUPV3_WRAP_SE2_CLK>;
+				clock-names = "se";
+				clock-frequency = <400000>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+				operating-points-v2 = <&i2c_opp_table_32mhz>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@1a8c000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x01a8c000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&gcc GCC_QUPV3_WRAP_SE3_CLK>;
+				clock-names = "se";
+				clock-frequency = <400000>;
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+				operating-points-v2 = <&i2c_opp_table_32mhz>;
+				status = "disabled";
+			};
+
+			i2c2: i2c@1a94000 {
+				compatible = "qcom,geni-i2c";
+				reg = <0x0 0x01a94000 0x0 0x4000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&gcc GCC_QUPV3_WRAP_SE5_CLK>;
+				clock-names = "se";
+				clock-frequency = <400000>;
+				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+				operating-points-v2 = <&i2c_opp_table_32mhz>;
+				status = "disabled";
+			};
 		};
 
 		sdhc: mmc@7804000 {
-- 
2.34.1


--0e04jeNFWWxIqaY/--
