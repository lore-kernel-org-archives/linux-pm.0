Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572133;
	b=spUJrjOLM5rVQzNynJamDqsaV8zb2V5b7f/TLvLQFkmSU5etyUbU/lwsRl0OLrMqXLut
	 dilXIiUccb+8hEUvEHPhLJ1WLV3HBhguhKjhaiT5F5V0pPdZflPIPJAcfaQuGh0i5STQR
	 A8yygluanhMYxDuOQsvU6HISuVqHE3v+YhR7Y83wzjViXHcwPovRZ0NTizr7udkwK054I
	 u2IN0OPL/PVFBiSqNzVlZLZ4fWKmBdbLc4qS5RjHg2L49lpNzuiKfAUmyZ8YhQzN5e/4K
	 CqzszdRZJ091+4yUogGirX/yd3pXQw8hDajVHX1yPIhI0e+/mBTEPPWNWV6as/gHjQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572133;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=mv2od5MjHAL8LNelVHd79epuUkTOnyvBtuiacsNkzD8=;
	b=DMYYdWiUZiMsW10WdZoDKTjA/fjmc+5zEkZm/6Tfwo42s1HLa51BxXmZZsxdPBJnn+99
	 AFSDKgmC0zEN3dnq5b7d5pNap6j7xPVt8L9ZmJ3K8ZoLIMwBXVvvB6e08Bxv42mQe+3C6
	 5fja+SFeDZ3oxksn0I/QrCM89Y/iqPd+QBJbLR2d6CZw11FNVJ3u4Wqlo82vyqCDnKyQW
	 SZvrGohT8ZKbQQjnr7iQF7oqMbDWm7GpLrKSjWZ45JftawoR0IW7yKnj00AoDEk+UkeDm
	 C4i17L8JNDcc+yo4CkW3INcVv1ChFEyC9vOTAJHzfY72kESjlZsGTXm86aPL3hDQKIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VXtMf2jr;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DHbgUOH5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65B2606A319
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65B2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VXtMf2jr;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DHbgUOH5
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5j7v0793404
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mv2od5MjHAL8LNelVHd79epu
	UkTOnyvBtuiacsNkzD8=; b=VXtMf2jr2lNmkBvB01dbA/xWgr0PBaYLUowsDOeb
	Q/lFAmE8K1vIRjDhf1/SvLmhd/BsRHcI7tL2XN53Lns1LZGXGDzL1EUIsu4JKuOQ
	uz2ziCVagkC4T2c3t11g5g1v4l0wzvuq2GM28Ilnk7E4knz55jiXWgAIYRV/VxEM
	9acRZuOGMT6R3/L5Ob0wbHp0KL3F17nzsWIUK7lcYy+7wgVAZeLKC3ETRQdlanJa
	r/iHmW/cw3KzvK8OtMyJPS78Ez/03wN6tTkDkANtq1htk1dRoMEykZLMVpQM3kpj
	bBKNPs9YCI3IQduR0JVSUHM77XgEGgmuL7R1lfdl3gmf1A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabk0nw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 08:42:11 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3552883bd19so1870320eec.1
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 01:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792572131; x=1793176931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mv2od5MjHAL8LNelVHd79epuUkTOnyvBtuiacsNkzD8=;
        b=DHbgUOH5XktJ+998HO2U/xmww1QKtblOm6mE08o2JNSVaBEr3VWQ2xFWIQWtqpK53o
         ddYBAX/GhzkQ70OeKrckJJZMFsCI8WKFE2N78PkAF0enXvPv/2/fB/t7tg18j0HWfaGK
         H/I0n88tZ9dxHkgmfWxeK5nXCVPl2vF9Aux+j2OAeQxTd0p2WFuL8PvAXm4iA7EfbwoC
         7KB0S8ezqtjbs46fXqvIvTuo5ldHBo6FVCKxVYnjbQx7C+Q+WOir+4Aa+IY4b9ci0fgJ
         S3qo+YC6C6hFJ5auKrWErYFB39keRH+T2BRmQ/Rv0yfYc/GHSvX6ZPBoQap5Y7RX6883
         0XNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792572131; x=1793176931;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mv2od5MjHAL8LNelVHd79epuUkTOnyvBtuiacsNkzD8=;
        b=p2F7JDPxpgd/Bu9CH/+eq/L0FAA2gN3hRrL0G3EGt2VzDfFRgq7z9/ElgiTuKyuEnt
         W3wweeqWmBQcPKeRHndg/TVNkX7IZwqVu77uefFZNKPZv+XUYbKy3vABMqzLuKC1SSS+
         MyLyPtBf2OL/lrknUsGio2X+0VrWe7P0bDULY20dAD/JCPTtt5F9seOmPkYFyrXXhn62
         1DgzbjquroB1FzJ7SvAw1W2UWRVWupaQvyVxCkPUV/hq93Le/wr+G3EtTSNyxyGAltpd
         t4wylBJlAIqYc9ZtbgUhYtY/Z7s6zSbf4LTNh8wc1EvgdYV3gnar42lFUHRsDLTdS18L
         1IKA==
X-Forwarded-Encrypted: i=1; AKwUvBzHyiF7PPyR6BG+lmcEMxa/sPyX99x3pnpbn0QiNDgSsEDqYEJdG8ecpvgU0b03RIXlKgG8qE+0kg==@vger.kernel.org
X-Gm-Message-State: AFq9FYKo8kwpSqHxdPQS3VDUeM5s6u8ml3QxXy6sOinNYdR2qBgeSfZh
	VGlTUENwH64/IeFJJa8gz05Vv0wt80p7qH3+7T3iBUGzEXguI9GuCKz5sQm59NbCK8/LbgqxR+q
	tCh82MB6ALF2lkZeqTw0a46cfAHDPVLkx1RxnFPYUOWD5xB7hzMrtNcSPVmBgqg==
X-Gm-Gg: AYBFou1rYNR8PIl8FmP1oIw00YYFEx1Tc45zLtNUPRkL49IEQf3dO85brl+K2z3zCo1
	bbtQYMweLf/wlsm7rZSgBPxbCIZBJ7M+3XoQKisVvQlqZP2k+ltjkxnW9GHgoasqLuY73z5TPNP
	w2+9EWca/EMfPYB3sBTd4onEx+8z2+RPKb/trEsfH2KLAIGXuvmD7k43LVbmgq72mtrznD4ijEh
	PkRrfOxtzVi6XXZEsHY9TRHiVZEqCiXu7JsCxDo6SLRGr/IfP235FWbX54RIEghsErcBF6oocWw
	VxChQ3cKSvmU5lueQbUDkA6d0ga5tnoAIMwpwE/n4v1TdTxKF+EmLqytUSX3709tBK4ZbUnJDbv
	sAlmNLzT/bIFzJ0viPWJbJ7z2NLpwsTRNfFJg0OgC2yWtTEYqOeqHRt2fVdzrVtxfXNtehgZ8wX
	DiFkFQzhjL0QaBOFxs7CFtk/P4Hf2R
X-Received: by 2002:a05:7301:4208:b0:366:bcf9:1807 with SMTP id 5a478bee46e88-3674ef298b4mr2399489eec.36.1792572130988;
        Wed, 21 Oct 2026 01:42:10 -0700 (PDT)
X-Received: by 2002:a05:7301:4208:b0:366:bcf9:1807 with SMTP id 5a478bee46e88-3674ef298b4mr2399438eec.36.1792572130222;
        Wed, 21 Oct 2026 01:42:10 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ed2absm6104926eec.5.2026.10.21.01.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 01:42:09 -0700 (PDT)
Date: Wed, 21 Oct 2026 14:12:02 +0530
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
Message-ID: <ath62msmyvy9Wu+Z@hu-varada-blr.qualcomm.com>
References: <20261015-opp-v1-1-f18fb6f9bae1@oss.qualcomm.com>
 <20261017-calm-tangerine-marmot-2e8bfc@quoll>
 <athPyI5nvYG4vmfl@hu-varada-blr.qualcomm.com>
 <ecc66886-1989-4e61-86e7-fba6555c870a@kernel.org>
 <ath6Yrtq4HSGU5R6@hu-varada-blr.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8FUA3P5543VdLmYC"
Content-Disposition: inline
In-Reply-To: <ath6Yrtq4HSGU5R6@hu-varada-blr.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX0cpLv+1uZPN0
 ofol8YmFveGr2D4dCRsRR/6m40XG/gIwVXmF27Z7TjCdtnlXrSMN5yABN7rGySUd4uBV48y4qHP
 rqsSndlimAoN2LCYrnMpiwdQgIOMQ+A=
X-Proofpoint-ORIG-GUID: 7gVkV43giCoqvgt8O1Q_wLfowc4zkYKA
X-Proofpoint-GUID: 7gVkV43giCoqvgt8O1Q_wLfowc4zkYKA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX5z/hpQOYGXH0
 D94h5aQ8gqI7oWEzkL/fLSsiwBsmSXV1+OKvVLxClUSbgjACDEWFVSIXQH347AXSLvLhHMsiBXw
 0EMQWqMS6LcfZjswbjuFCdw68p9CAmfTNVvUkyPFTxPt0uBj2UlwIPhKdDHh6OicQxZ2xKrkGkE
 qML3W06/6461JP4HwN+C6dkjY7/pSbIvmm3J6sQRYt8VSD4SrOj2md7kkkW75CI/g3Jm3hMVZAB
 Yti3DbvwMVb91wt2eDQOwtk+ugj5OXyH7SZyVK5ib4rGjKS8JnDfpi9A43hWpQ+N48voIxEcGE7
 8tSjT7j0cV1m/LyNQ4aS6/kRy3vbuXG8lnPHzeaSjd/cGcru/JSl88kX5isoIITDQ97yMGr8dVS
 d9mZ/AGxgRzq0zRRUqw42pdjdttwqremFEnquv5n0JiRSiym0tyf28t48ef7zMKifXxCT+GIU0J
 5y66oFJE+xMjocoUOEg==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad87ae4 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=iiRzA6RgfTgo7wHqi70A:9 a=CjuIK1q_8ugA:10
 a=PvBjEiDu0qDqifS8eEoA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210034


--8FUA3P5543VdLmYC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 21, 2026 at 02:10:10PM +0530, Varadarajan Narayanan wrote:
> On Wed, Oct 21, 2026 at 08:17:36AM +0200, Krzysztof Kozlowski wrote:
> > On 21/10/2026 07:38, Varadarajan Narayanan wrote:
> > > On Sat, Oct 17, 2026 at 06:45:53PM +0200, Krzysztof Kozlowski wrote:
> > >> On Thu, Oct 15, 2026 at 04:25:28PM +0530, Varadarajan Narayanan wrote:
> > >>> The OPP table node-name pattern also matches peripheral OPP tables on
> > >>> supported SoCs. However, it only handles Qualcomm CPU and level OPP
> > >>> compatibles, causing unevaluatedProperties errors for generic
> > >>> operating-points-v2 tables.
> > >>
> > >> But the select should not select them. How can I reproduce the issue?
> > >
> > > Sorry for the delay, it was a long weekend here.
> > >
> > > With the attached patch, I get the following error.
> > >
> > Does not apply,
>
> Sorry. Have rebased to next-20261020 and attached, please see.
>
> > but exactly that sort of opp-table is already all over the tree. Just
> > check yourself.
>
> From what I see, SoCs that don't use operating-points-v2-kryo-cpu for the
> CPU's opp table don't face an issue. Since ipq5210's CPU opp table's
> compatible is operating-points-v2-kryo-cpu, it is facing this unevaluated
> properties error.
>
> The qcom-cpufreq-nvmem.yaml change is approved in [1]. And the change to
> ipq5210.dtsi is to address the feedback in [2].
>
> Thanks
> Varada
>
> 1 - https://lore.kernel.org/linux-arm-msm/20260703-lively-intelligent-raptor-5edfbf@quoll/
> 2 - https://lore.kernel.org/linux-arm-msm/06e6868a-c106-40b1-85fb-5ebbc01eff16@oss.qualcomm.com/


Forgot the attachment... Added now.

--8FUA3P5543VdLmYC
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="krzysztof-unevaluated-properties.patch"

diff --git a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
index 547265b8b118..2f5dbb59034c 100644
--- a/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
@@ -27,6 +27,7 @@ select:
         enum:
           - qcom,apq8064
           - qcom,apq8096
+          - qcom,ipq5210
           - qcom,ipq5332
           - qcom,ipq6018
           - qcom,ipq8064
diff --git a/arch/arm64/boot/dts/qcom/ipq5210.dtsi b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
index 2cdc10529c48..b8172f6f1030 100644
--- a/arch/arm64/boot/dts/qcom/ipq5210.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5210.dtsi
@@ -84,6 +84,14 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x0 0x0>;
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
@@ -179,6 +187,45 @@ uart1: serial@1a84000 {
 
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

--8FUA3P5543VdLmYC--
