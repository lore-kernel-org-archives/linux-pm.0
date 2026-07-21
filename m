Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDD53B2FC7
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 05:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784611590; cv=none; b=R8aSHAL1qVSR+j8VxobXlEzSyAiTDdj8G4lm8pF9AxlyC5+V4POeSROBC1K6CDiBWDavfdYSDHGCP4k3ZRisU2ev5wPeKgUuYtBPnz+2Pi2yyasUI5R207KsLd8fsLRMIImAvydN3/0Afh5gwGxVDDb7DegpNPTbeZI9XKV8bJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784611590; c=relaxed/simple;
	bh=LANuCJkB6nXzMBBjiSyLvoxsquUOuL54/jiE6FqHLOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gwFdim2YU2lrzV74g9xfYaLnSB4TAG1Fc2uAWojFyXW0DsV38GEMUJBou5hENUDswQwhDrc8+Rnb3ySn3bA+AxfjbiUPsdK2s3ax71A/p5y1Uk82LwoAy51ICQlcgJH798KfxAg52sMTTAzNgopcSkxzC/LReXFTSBfUXzH9hgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XexN0C7L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PlWAvdtE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XexN0C7L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlWAvdtE"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L460LK037544
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 05:26:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Uto5B3n0eGCHOA43nYgEYRfaslRQmvbRDMXREj3vbCE=; b=XexN0C7Lrij6xWQV
	MbbvwH6jE8ckCVIjfwyVPt/k3+AetSZ3YOWR7N9K9W6M/3x1GfVdZIoaVpRv8aoP
	qUc0RqD1X8SFypXFqJyAHrm66PNvvIMZU3I3ZAEzNYi5e7ELiZEEDtANq705JSjT
	GnuUrL/WwXccJmP92qwwstypoG6SujTnv2wL/FKe3a5ghvLlUxpSP6ydaGyt8DMP
	BfK5xp1hBE2hmnmzwbbhOExWBaOBMeshlWbUc9OKgyTcHmkgzKbmFG8Lh13SjIQH
	Nqm6/bVnURd+onH3b+BSl3E9rJ0jwF3smL/tJvgjm9H4ku0kU9j1dasxR04e8ELx
	Wa+qBw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj1es08v6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 05:26:27 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8484ba00601so8930541b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 22:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784611587; x=1785216387; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uto5B3n0eGCHOA43nYgEYRfaslRQmvbRDMXREj3vbCE=;
        b=PlWAvdtEZayOS2Uz3cQQQw/pYmCFHl1OmMkrxX87w1vHGQlWDvDf99rMOjZqoeFree
         H9e9H8pIn7CH2y/yOtngnCjnVryVplmzLPxjvaCzJBhNz0PvhPIEoNjAm8txwFyoNRIA
         3GuEQf1DPdmXAI4au6ek8TsM7ITzog+mgAhiK5j9dwu724O1KbXFY/Z5ihia76Q965Zs
         vk4vlUUISaoP3dCV8DB0E2StV96neaBmFcTvVBtI9PaR2o4EzY1drPBFLT5WcBWxgZy3
         Y5eGAARkXAu6zz4jghQcg55Xso4663cccdBMWH9k8pRR3Tj8KAPbISovU887llMDMfMY
         AP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784611587; x=1785216387;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uto5B3n0eGCHOA43nYgEYRfaslRQmvbRDMXREj3vbCE=;
        b=q92/GKr72Qq0nc3OCjx0SIFIFE8vcblprWOhtbzCAxLlq//DJcSB647FznN4xqOV6c
         t6v9iht8FiZ/K0Cz/PIQnA9zylqmfE360I96KR36lTTzaWDnNesHUTHxmC8qM9AGQD8n
         Oo+CM90mnMY7rVANd3wIRw8wWmQxkG3wv3dPDYdUVZAfrAJR5gJCbM9lBKje7RphdnUd
         SMowkfA9t5wayaI8vLS0ee8TsdO3i8gnNIF0bLYG6qPP5zJXOBWRhoP6eJHECkH8P9l6
         H+UacUcn1wllwzk3WrZb58Jl2zYJUpYEUR7o13XgezvOEYsC/5pAMb7IdSvrXadQcsLc
         vyvw==
X-Forwarded-Encrypted: i=1; AHgh+RrMhu5wO9vq3UTOt6HJQUth1hjJFpxQpP45bY+o73K4cDYcZESNdFHJVChXpUmUkHGNSrMj1oT9qg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxheB4ZdV2pf0ErEiaj4rqEFoXbVQtIwamcNTr9P41tBUtJRlHw
	7b9bX138a/VDVJyQpaB68N4LMP+p2qS2QyIe4hZ1/GNVkf/Q5NtXGaLZssSt3+fxfB4bD6Bnd5Q
	qe+IMUKmvOu15J4IX49npkeePIiH3XSUZ4RRbFFZGqLncv+DehEZpkpprtzJ1dA==
X-Gm-Gg: AR+sD11bvsph4pUbnHETg4gvBsnzptTlnS2E3ieHjRGGksSca6pnRMj2yds3+XEjBDN
	Tf01o5V9IPAB03uAnbGVASQun/5QsZc0T31obMV6M6e8BVPfUkjpiIjY5+YByFQKFEqoCrRDxY4
	dFc7ugz5Z9hkEEK5WtGTc+MrBRc0FKF9oZviSgqGebB9JZ5ZVvy+zQ+r8xr0SNpFL/GXsJ7pRbx
	/z8FI9GR3Ubr0UdqB8z9W20F0JLACPtNW68OizcDwUM9FIcIfe78tovVGuVauwrNV93aXe8QR1v
	+tJbi4AzsHYAVJUKcVDtCJxli6tiG/l1J4TYsasbTGmlXsPiLfiB0ydyY7NjcS5bQ23VcG8tzxA
	0cBCcByNO9T1VWDuZ4asNmJkpt7vS7P1M
X-Received: by 2002:a05:6a00:3e26:b0:848:2f74:d8da with SMTP id d2e1a72fcca58-84c294c870bmr15377107b3a.75.1784611586688;
        Mon, 20 Jul 2026 22:26:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:3e26:b0:848:2f74:d8da with SMTP id d2e1a72fcca58-84c294c870bmr15377086b3a.75.1784611586174;
        Mon, 20 Jul 2026 22:26:26 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e401sm6649207b3a.48.2026.07.20.22.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 22:26:25 -0700 (PDT)
Message-ID: <76288f31-57ea-4a42-ad50-8504d8eccfa0@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 10:56:20 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: eliza-evk: Add PCIe1 with TC9563
 PCIe switch
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260708-eliza_evk-v2-0-c599246ceba1@oss.qualcomm.com>
 <20260708-eliza_evk-v2-2-c599246ceba1@oss.qualcomm.com>
 <n4s25nftmn3ginddls4u3tpzabkgiotwzh4kws5s4jfppup36s@ccbfrrrqxihq>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <n4s25nftmn3ginddls4u3tpzabkgiotwzh4kws5s4jfppup36s@ccbfrrrqxihq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=SPZykuvH c=1 sm=1 tr=0 ts=6a5f0303 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=WptVsyCosi7Mub_EgEwA:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: VUbAg_XgxmNabw1I4Z1o8bQiZsiGVKAj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA1NCBTYWx0ZWRfX/Frb6h+HFbqW
 SEx7kwgFLV5DcC/9RqFMQOZM7dg3+43Qfm4fbjlXQbgZL5+5J83/sW0vS5kqqepcOSnlvRsj4iF
 l6Lq70p2WN4foOYWTXZENw5K+qgaE/GTALuocMxXDVCGkE4VGFdqIvRGO5SkDNp91qjwj9Ffllu
 FJIBeip9ID8QDV7r4JvkdLHs0LvNUkkLM1dtnouVpJ9seGMUi9lTIzcWMpgHUwvWY1yMeRIuaBZ
 32aS8fgMRrTzoanXWTU4ObztLVYJfZpam3Ttukdc/Mdnp4JQVuRaBnhQwSS+aqW7a5cHmcnI5CT
 y091ZO5tWdh1wrZOiRcOoYWuPCzi70XNgZHKkHlSD6SN4a3laC/4BBHLpJq+JfOxAR1hZ7B5MuM
 jg3XorNSwQiRt4Q9pbwueyr9Kll1IpDlSs89CnKbmTtTfeTS5X0HzdfwFisHsQn260oVq+EJcbq
 0oixvN/pjRNpP4y9+CQ==
X-Proofpoint-ORIG-GUID: VUbAg_XgxmNabw1I4Z1o8bQiZsiGVKAj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA1NCBTYWx0ZWRfXzwNx7YDPrR1O
 TSZQtxVZkivnY3rDsS9fofx19VcF2s8vhpuClaGhHETKL0KHbUzQAhgwGeR7K6UYbRY61rulca/
 EQ22X53kf42uh/3EB2QVZIy2XaenHNo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210054



On 7/9/2026 6:37 PM, Manivannan Sadhasivam wrote:
> On Wed, Jul 08, 2026 at 11:47:17AM +0530, Krishna Chaitanya Chundru wrote:
>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>
>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
>>
>> Override the base iommu-map with the expanded set covering all the
>> switch's downstream ports (0x1400-0x1408 SID range).
>>
>> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
>> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
>> from the PCIe controller.
>>
>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 112 ++++++++++++++++++++++++++++++++
>>  arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
>>  2 files changed, 113 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>> index 6d76715ccffb..e099b7c8c371 100644
>> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>> @@ -12,6 +12,26 @@ chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>>  
>> +	vreg_0p9: regulator-0v9 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VREG_0P9";
>> +
>> +		regulator-min-microvolt = <900000>;
>> +		regulator-max-microvolt = <900000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>> +	vreg_1p8: regulator-1v8 {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "VREG_1P8";
>> +
>> +		regulator-min-microvolt = <1800000>;
>> +		regulator-max-microvolt = <1800000>;
>> +		regulator-always-on;
>> +		regulator-boot-on;
>> +	};
>> +
>>  	vreg_pcie_m_3p3: regulator-3p3 {
>>  		compatible = "regulator-fixed";
>>  
>> @@ -99,6 +119,98 @@ pcieport0_ep: endpoint {
>>  	};
>>  };
>>  
>> +&pcie1 {
>> +	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
>> +		    <0x100 &apps_smmu 0x1401 0x1>,
>> +		    <0x208 &apps_smmu 0x1402 0x1>,
>> +		    <0x210 &apps_smmu 0x1403 0x1>,
>> +		    <0x218 &apps_smmu 0x1404 0x1>,
>> +		    <0x300 &apps_smmu 0x1405 0x1>,
>> +		    <0x400 &apps_smmu 0x1406 0x1>,
>> +		    <0x500 &apps_smmu 0x1407 0x1>,
>> +		    <0x501 &apps_smmu 0x1408 0x1>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1_phy {
>> +	vdda-phy-supply = <&vreg_l1k>;
>> +	vdda-pll-supply = <&vreg_l3k>;
>> +
>> +	status = "okay";
>> +};
>> +
>> +&pcie1port0 {
>> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
> No reset-gpios?
RESX & PERST are ORed in this platform, as we can declare at only
one place we declared it in the tc9563 node as resx-gpios

- Krishna Chaitanya.
> - Mani
>
>> +
>> +	tc9563: pcie@0,0 {
>> +		compatible = "pci1179,0623";
>> +		reg = <0x10000 0x0 0x0 0x0 0x0>;
>> +		#address-cells = <3>;
>> +		#size-cells = <2>;
>> +
>> +		device_type = "pci";
>> +		ranges;
>> +		bus-range = <0x2 0xff>;
>> +
>> +		vddc-supply = <&vreg_0p9>;
>> +		vdd18-supply = <&vreg_1p8>;
>> +		vdd09-supply = <&vreg_0p9>;
>> +		vddio1-supply = <&vreg_1p8>;
>> +		vddio2-supply = <&vreg_1p8>;
>> +		vddio18-supply = <&vreg_1p8>;
>> +
>> +		i2c-parent = <&i2c4 0x77>;
>> +
>> +		resx-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
>> +
>> +		pcie@1,0 {
>> +			reg = <0x20800 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x3 0xff>;
>> +		};
>> +
>> +		pcie@2,0 {
>> +			reg = <0x21000 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x4 0xff>;
>> +		};
>> +
>> +		pcie@3,0 {
>> +			reg = <0x21800 0x0 0x0 0x0 0x0>;
>> +			#address-cells = <3>;
>> +			#size-cells = <2>;
>> +			device_type = "pci";
>> +			ranges;
>> +			bus-range = <0x5 0xff>;
>> +
>> +			pci@0,0 {
>> +				reg = <0x50000 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				device_type = "pci";
>> +				ranges;
>> +			};
>> +
>> +			pci@0,1 {
>> +				reg = <0x50100 0x0 0x0 0x0 0x0>;
>> +				#address-cells = <3>;
>> +				#size-cells = <2>;
>> +				device_type = "pci";
>> +				ranges;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>  &uart13 {
>>  	compatible = "qcom,geni-debug-uart";
>>  
>> diff --git a/arch/arm64/boot/dts/qcom/eliza.dtsi b/arch/arm64/boot/dts/qcom/eliza.dtsi
>> index cce65e18f979..363cabc5f55c 100644
>> --- a/arch/arm64/boot/dts/qcom/eliza.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/eliza.dtsi
>> @@ -2102,6 +2102,7 @@ opp-16000000-3 {
>>  
>>  			};
>>  			pcie1port0: pcie@0 {
>> +				compatible = "pciclass,0604";
>>  				device_type = "pci";
>>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>>  				bus-range = <0x01 0xff>;
>>
>> -- 
>> 2.34.1
>>

