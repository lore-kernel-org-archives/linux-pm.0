Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626841A547
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784616327; cv=none; b=bcxP76QKfa2hHolAr1eXNq4j2dXw06f8Fymmby4vf9leVwVz7TvLZxHTseha9KTfd7jeKoQsyzT21TQrTESEm+eQYMOO/HfCqj3uyRzljvnniWkNpPrmj4erhzBpXxl7OYzL8tO9NGU58Hv1MUiZbN/fMO2PomuPV0cIJV4DGBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784616327; c=relaxed/simple;
	bh=yVCm8pu2qst+Q8cj8iPalYZM3k9L2JEslpvUbzVZ7Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NtV+VD4TfbJt2nsLNrtMNH/VK4zsaSUALF9TIIsKywZWHeYOMR0ExgTDc/OJr9WbQpbnmhHnFFI67Vwka3/3NyXgAyhTWI+B4iAAfRiGL/7VwKnHuoci22SyM9Zd13aeCElSjiHqpViYsGD1d6mc8T+zgZ1eS4S/CSEj0gq7GCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CfJXZldl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ad0pq6PJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CfJXZldl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ad0pq6PJ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66L6T9LB4151354
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:45:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0A/ouygtLvij5YrVEYKZa7V+tOCteR1RlhOKH0lQmNc=; b=CfJXZldlHxC8XOkl
	FfoaFECJ1SxD0J/qMMfPrF6q9M6XlcVRQOQcs2B41whbVXpuRShQ7AMABywhl61Z
	krvTt0x7Rdj5P+a0waGS3xcPD2NmwrVtvUF89CpL3jHutzKMd9uQ6EXG/hOTsKK8
	ECGs8KGaLeREmB1OSqAQokKszU1HLsb4dlEpqr6zHsoI9i+qg8nwldygnurRH2ly
	ATB9VuTtg7XDL3j9C9xDPDxLNGYWoFyPDSwD8j0HHf4nSqJohOnC1V7kOwvFpEmv
	g7QdSSk56LX48xkEZI1xoXobFkKh1cHI/tNuLBXBqcxAp4HS3YpeoJ1pjT925MD0
	3KWaUg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqff2y08-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 06:45:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38ce7fabf76so15829572a91.2
        for <linux-pm@vger.kernel.org>; Mon, 20 Jul 2026 23:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784616324; x=1785221124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0A/ouygtLvij5YrVEYKZa7V+tOCteR1RlhOKH0lQmNc=;
        b=Ad0pq6PJLtNgeK67L4Es5JqNv9UucQkg4V0wC1GDY8cMfbTQgCpddV+auWw8nv1gw3
         DUVfmerQpqKl3HVbsqSf9y8JHVBZjVefV/Saw/3e+bYq8i2YCO8+6s8iDIqEqFJEh6Od
         qlBjGa28c7E8mrv7cFj93yFlLgF1JSj4shTs9Eaejr5Db+XWSTYx9kPt4GuevTeCyvz6
         jF4+OaSNzUZa5kMi00WB6a4hXkfXWSXukCn+9FFIM4nWS4UAacHIjnpWbm5x9kazF7+s
         nsklBinb827cdiF6wLxH6GCCUTvtUiBeED3CgbTwpSWdSROzQAsVDIBvSRAkjNZqarJV
         8UIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784616324; x=1785221124;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0A/ouygtLvij5YrVEYKZa7V+tOCteR1RlhOKH0lQmNc=;
        b=PRMbRKtUdFa48bu7JurjRalngoZIDExBtF5zrXpo1GP1QXvY6ArlIeW7gm8JxYxD5E
         iCzbml/70ZSV4d+wSl1upBhRfy1Hoir0wYSaAptpjxT7boWatgDdqYBrbvZxUWGFdhWz
         ZoDG0jOCcnDB+BYVYO1dBymS0AVO2vJ+NHrbBqaBt9yWTriik19hrEbTn/xrbezbLpb9
         3ngicVjD8Jmw+sdMa0Il8F2RPy6ZZEgqQim0yHWPAaqd0sAAIMtysNNGqh3qLBM2llJx
         x2ncGeaCnrCj8C+MOO0YeW7rphDErdViNPZM0QBM0LVJE2hawqkpKQfR7UKLU8MXn3wO
         4b2w==
X-Forwarded-Encrypted: i=1; AHgh+RpwTerqXkHtyVISKsd7uBCGQNk388VNDwSCEiNgnNoxvm0fcaqqkSiXiQKEOqfyytlmKvgBUrTOKA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyeQnx8bHLeCZRVgS+829CnxWYCXQZcxAqA7PFB1/1jOP0uklzh
	afZcq4G4yrT45wFFPdnMENv6/k65VwHsXMynuTxwgU/pCZJsrpHdvRzu6BQxWi9gBW/gJj/Fpgn
	ZKzhp+CdVkocmGvX00iBkTKeDgCmzpDC/mXn04a8CWTUba7mPadhebEPdkCFw/Q==
X-Gm-Gg: AR+sD12wXdW9p7INxDy2v13Pc4GCAdiUKm8dtsHXyLs70MoyoFEYcwPeC53oeKqP+xL
	JXM4ZYv8pmDbYDSo896br6CorLsFQ59XjvSi2tMd8pfnp5473n4c2I16XnA+3Gq4zKn5CBqfCfs
	hnv/KsZWnC2CGw3TMng0G6GNSnx+gO9qtzBe9JSaaV/OyVgp8ZU8LGjEoUbCeSXP0k/qqRt/Hvv
	MtmIbIdQzCOD8SZcQ1d/fx4Wcybph2OyCASFM2I8Ij5RvRk2QJi+eut19RyvHTco8KK6O2T2h8E
	T9iFcZuXFAZCXvDvk7cAUsirPI66pRAfZWPAvnsTfCuiZAicCQE233Oz5gPXRqJweJyFman5RDS
	QXwbI4We0Bk04KIm7rcfE4dh+rwGpF/X2
X-Received: by 2002:a17:90a:e7c5:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-38e4b244fdfmr16462448a91.0.1784616324200;
        Mon, 20 Jul 2026 23:45:24 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c5:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-38e4b244fdfmr16462422a91.0.1784616323664;
        Mon, 20 Jul 2026 23:45:23 -0700 (PDT)
Received: from [10.218.35.45] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e9218a25esm942198a91.15.2026.07.20.23.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2026 23:45:23 -0700 (PDT)
Message-ID: <3eb742e3-6381-47d9-9f16-c08915963748@oss.qualcomm.com>
Date: Tue, 21 Jul 2026 12:15:17 +0530
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
 <76288f31-57ea-4a42-ad50-8504d8eccfa0@oss.qualcomm.com>
 <2xz7madb3jkifwjwziozuudx3s57g25my3j6ucwjzbguacpgyn@btyrkbzqzh4a>
Content-Language: en-US
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
In-Reply-To: <2xz7madb3jkifwjwziozuudx3s57g25my3j6ucwjzbguacpgyn@btyrkbzqzh4a>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDA2OCBTYWx0ZWRfX+ipGKlkawU7G
 G+ezofTzyxYkiwIo9y5ghReM3z5DgRAPNHNoiWJIIHvIoD8CXo+EPC2LI3Tp9ev07mpmUT27UWD
 LefUn1q9vHao+rkusRF7g1b4a/NxTAU=
X-Proofpoint-GUID: pGp_u6q1bBqRe7zTs3dev0oH3ev-GGCn
X-Authority-Analysis: v=2.4 cv=FJErAeos c=1 sm=1 tr=0 ts=6a5f1585 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=RVf7_9FWgS9vKL4VWr8A:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDA2OCBTYWx0ZWRfX3G2mVPYoOjdw
 1TszQC5D8utg9WG8c2oQRhgkKYTgNIbXHEeYa4ClJ4K+e2nUXLhgPYwO9wAvATYBSOVmluE+umk
 Q9Oq92SDWHMqyAFwRs+Ktajv68I+AnKkAaJyWy5nzpWnpjbLdodslECXQreFc94cU1+UBnDIFEy
 MkFm0enFUkslJeOqVvbCqvlop++1GbEdq6Q38+ryIkgELo8EJ34qyPKoXIi8KLTzg3XOsUCh8dv
 u0Jlx95KXq8AdkvEBZeq2x1d1PfVagzGWj0ez0tLPXuhw7bBqvEsSmfDQWNHbEZ5kV5qBppMDgo
 OJ9VcILFynPXPPAzTG9jX4bTxZfRK3+4sqEeI6O7/JwqWQbG9fG6WsPnHBGof8QwTJeFLTLHa7v
 zQCWtXlDsssa6RZxcUQmg185nrJ59yekO5WkmlDaczYwjJlRHuGibl3h9Zh3uVIVD7OogCKVuXl
 HrkoZhU7pCpD3d1nmhA==
X-Proofpoint-ORIG-GUID: pGp_u6q1bBqRe7zTs3dev0oH3ev-GGCn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210068



On 7/21/2026 11:52 AM, Manivannan Sadhasivam wrote:
> On Tue, Jul 21, 2026 at 10:56:20AM +0530, Krishna Chaitanya Chundru wrote:
>>
>> On 7/9/2026 6:37 PM, Manivannan Sadhasivam wrote:
>>> On Wed, Jul 08, 2026 at 11:47:17AM +0530, Krishna Chaitanya Chundru wrote:
>>>> The Eliza EVK board connects PCIe1 (8GT/s x2) to a Toshiba TC9563
>>>> PCIe switch. Enable PCIe1 and its QMP PHY nodes.
>>>>
>>>> TC9563 uses I2C (at address 0x77 on I2C4) for its management interface.
>>>>
>>>> Override the base iommu-map with the expanded set covering all the
>>>> switch's downstream ports (0x1400-0x1408 SID range).
>>>>
>>>> The TC9563 RESX# and PERST# are OR-ed internally to assert reset on the
>>>> switch. Use TC9563 RESX# pin via a TLMM GPIO and skip wiring PERST#
>>>> from the PCIe controller.
>>>>
>>>> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/eliza-evk.dtsi | 112 ++++++++++++++++++++++++++++++++
>>>>  arch/arm64/boot/dts/qcom/eliza.dtsi     |   1 +
>>>>  2 files changed, 113 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>>> index 6d76715ccffb..e099b7c8c371 100644
>>>> --- a/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/eliza-evk.dtsi
>>>> @@ -12,6 +12,26 @@ chosen {
>>>>  		stdout-path = "serial0:115200n8";
>>>>  	};
>>>>  
>>>> +	vreg_0p9: regulator-0v9 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "VREG_0P9";
>>>> +
>>>> +		regulator-min-microvolt = <900000>;
>>>> +		regulator-max-microvolt = <900000>;
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +	};
>>>> +
>>>> +	vreg_1p8: regulator-1v8 {
>>>> +		compatible = "regulator-fixed";
>>>> +		regulator-name = "VREG_1P8";
>>>> +
>>>> +		regulator-min-microvolt = <1800000>;
>>>> +		regulator-max-microvolt = <1800000>;
>>>> +		regulator-always-on;
>>>> +		regulator-boot-on;
>>>> +	};
>>>> +
>>>>  	vreg_pcie_m_3p3: regulator-3p3 {
>>>>  		compatible = "regulator-fixed";
>>>>  
>>>> @@ -99,6 +119,98 @@ pcieport0_ep: endpoint {
>>>>  	};
>>>>  };
>>>>  
>>>> +&pcie1 {
>>>> +	iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
>>>> +		    <0x100 &apps_smmu 0x1401 0x1>,
>>>> +		    <0x208 &apps_smmu 0x1402 0x1>,
>>>> +		    <0x210 &apps_smmu 0x1403 0x1>,
>>>> +		    <0x218 &apps_smmu 0x1404 0x1>,
>>>> +		    <0x300 &apps_smmu 0x1405 0x1>,
>>>> +		    <0x400 &apps_smmu 0x1406 0x1>,
>>>> +		    <0x500 &apps_smmu 0x1407 0x1>,
>>>> +		    <0x501 &apps_smmu 0x1408 0x1>;
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&pcie1_phy {
>>>> +	vdda-phy-supply = <&vreg_l1k>;
>>>> +	vdda-pll-supply = <&vreg_l3k>;
>>>> +
>>>> +	status = "okay";
>>>> +};
>>>> +
>>>> +&pcie1port0 {
>>>> +	wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
>>> No reset-gpios?
>> RESX & PERST are ORed in this platform, as we can declare at only
>> one place we declared it in the tc9563 node as resx-gpios
>>
> So this means, if both are defined, the assert/deassert sequence causes issue?
> If so, this should be mentioned in the comment here.
we can't claim the same gpio in two different drivers. the probe of the driver
probing
2nd will fail as the gpio is already requested by the first driver.

I will update the commit text while re-spining.

- Krishna Chaitanya.
>
> - Mani
>

