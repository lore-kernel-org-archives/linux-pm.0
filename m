Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC7F312834
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 02:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780885609; cv=none; b=DIIqYibcXo+NoLAEl8/+85jjRMQO1CUO3CFBIqwo/QWcxAjMDRKm78uNbnn0VwfG27LtuNH3DbUPyUT5zg+JjGhCk0BrFUnA4A021sUFzBWAPSXmE5CdY1rYMeI1zFZkT2KeAB+58xAqFnoqsvXiGvkkc855+rsgW1Idca/iDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780885609; c=relaxed/simple;
	bh=Jsb64BppIKhCh2w+6BlXRchgQjTK59vwgMt6kvspQOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M5R+/EA0Ko/kBp5o/7yLzBZZmEAz804WYSnTKjTm/s584rQzjIKlghYoGOfo8d5krLZrl40I6UVX649SZBt/sLagurCI3esWiAbL0/MgeP7ukdl2jNDykroP3RK2UpY1lkKDG/Sgzuvq21tqJk5dNvNOPEqCFa4q0HePbn9MUvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DHsfaltA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3Dm3fa2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DHsfaltA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3Dm3fa2"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580GCf62027012
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 02:26:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	U1GpJgF86OVuWBXMLcIgc/odzzvOYtSH1/MYLOkxrdc=; b=DHsfaltA2c8kxmJz
	LUaphdhyZePFH4GE6hR7qIpO/yD7kxuPVzSZppS+rrBb4y8J/bHPvmbMd1+nFZyZ
	8RUQrqVgl1qe/JT9sJZmCZeDcGxHBTLNLuhxwgvcvnYSshQy/vIiumvN0zTs79Wt
	hi9r5jt/HE/SGzbn0LdjTwBuDmWu3qHDDHBXV5nIa993uFlcn/2ZFI6vs/omB8FC
	U7erNzSk9ltzLkSVifOyoyLJQn8dVmPFzZRqYsDhXcBFmHswLlwIsav/pzHYMem2
	DBEtbZ+6iUCmXeZkoDhCodF18E4KbLTVqfyudOjK6snGMHcIpdbnAhJ0S/C1HD4X
	owDgIQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4wq7g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 02:26:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-36d992fa39eso4736364a91.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780885604; x=1781490404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U1GpJgF86OVuWBXMLcIgc/odzzvOYtSH1/MYLOkxrdc=;
        b=C3Dm3fa2YPrdoULFxxIHH1/HsnoSBayjNjvrscojd00JIE2asND7z2RNkqL/5txbPG
         u8aaoUwfBbrtVR9tfMvcXu3J7An9Dla8PG7NqaYOi+5MDgBaiZO7ET4wmeFNCFDBKC/i
         Np7Vbj/USyI6/79VvCjKE3adNmhuhmilgd4phxSHdUQFnA7exHXYDCr7+EkyxulcJlcW
         y+yqU0PvCBXDhnnH9I8OjaMR0oYAIsg0hwRADau0qK+vzNVCUmlInA7bAjRtMs6pte6A
         oERpinNSC4ti7ROuo73cMe5ACtUX+afMavgf103VYjLJDs+fI6c83UkhQMbj6g/OQ1Iv
         69gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780885604; x=1781490404;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U1GpJgF86OVuWBXMLcIgc/odzzvOYtSH1/MYLOkxrdc=;
        b=TDknGTJan+bqWyRxpaIhfI7hOhD2ZA8+iSAkL1JciBL2EVx3k1hOViYV8jC0r0BF5Y
         LfXGqaGTP6d3qlZbtv4lY9JpoB9CHwZaIub4oH+kfZDv0L64+mSLtq7kw18vX6a7jmlv
         YY47M7XhBddsJ1sPHb1ump6Fa5H4ynQ/UEk7nV2BHwPXTwsuJlRC/2jEuLt5GW119bc2
         GA8px8Y3gmYheKgvGUOUwuzN2pmuq8ZyrFw13MPP8wWq04Xoy+EX5scthHWsFxn8DTOH
         Rebq6mKz4Ho7MjQtTUdWDQNZwKbBcXDbfosJpQg0OsP9siHH94PbO/R+OlqU8/qAhbGg
         rCAQ==
X-Forwarded-Encrypted: i=1; AFNElJ81r8Cn/Es48H9SV4CmA/Kn2t63d4OvXmr22EhTfVjxY7tCe+gEIjfi3nQL7wcd/tJN8S1RwvvgQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzGdbr4NFezb23zmVzZy/TyDSsVBOWDMeRXYUY+/AbnM9FQ0cC6
	Vmzs9gDmCgXCINgUAVSO6ABHDJADdykpql8e3IFSVwfMVM9Cqu1sZv/TNagZ8WuqFXechlwPPUt
	XPJwUoRL9+xEiO5+q5WXfplQWrOGjp009iR4CTFGSOlsU68LUIjMyKm5n4He9lw==
X-Gm-Gg: Acq92OG58cxl/zucWKDd9ryG+pna7EwQuE0nHBYdIFKEtIrJ7g0fY90HCngD85eBHD8
	s78qNuTz+nJMoaKIzgp3Lnn1uNJVA1etdTgBWz3CUoeat00MeXI0teHgVidmHnuvNgedp3zFjxQ
	4wV4elYMhtTvnIGyNA6BzC+7U63aV9W4r0VLbEYGpq0nvDjFntXl8et7amT4MNzKNnOVMn/4F7L
	k0yBJTbhd1T7i76dsZzVVntcW8UAa4PjEZm3DeQyBgTqQ/mI3/oGkzb5E3+DD9l0l0+Dl5dhKB/
	i2APYQ7/gy70Wm5vTH0AiRo7HNJHMABKBIADm9R7BEShsBYNc+vBuMIEvfgnaC9QFCbeeyWvIMO
	c4o61I53NeHpPRrKMECedxeJM/KzqY6CBtXXsGdaDitKwNyIndiE+zgGCMmNzcJSJjNyNKvBlBP
	nSVHE7Fe+VKNp7nFkHEB9FVhkfD5b4
X-Received: by 2002:a17:90b:3852:b0:369:73a:326a with SMTP id 98e67ed59e1d1-370f096a635mr14237001a91.13.1780885604470;
        Sun, 07 Jun 2026 19:26:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3852:b0:369:73a:326a with SMTP id 98e67ed59e1d1-370f096a635mr14236974a91.13.1780885603863;
        Sun, 07 Jun 2026 19:26:43 -0700 (PDT)
Received: from [10.133.33.135] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6d013c9dsm14548354a91.8.2026.06.07.19.26.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 19:26:43 -0700 (PDT)
Message-ID: <2f963239-e1f3-4966-b442-7d44f372ea3d@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 10:26:37 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
 <CAFEp6-2rT5fXkWaa-Fd--h8zuJ7kQqPyjedGNXrGvco79yMJCg@mail.gmail.com>
Content-Language: en-US
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <CAFEp6-2rT5fXkWaa-Fd--h8zuJ7kQqPyjedGNXrGvco79yMJCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XiPI9NNBStfpg76sBKxu2lAq_-294Z-V
X-Proofpoint-GUID: XiPI9NNBStfpg76sBKxu2lAq_-294Z-V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDAxOSBTYWx0ZWRfX8d+mMdvSR6G8
 +36LO/dhMyq4FBGhwKcNLV0TxHUaxQxPCqfM+yqgcNyzqR4tmRYjit76ktfSmdbW0N2JOEJ31r+
 Dx7UQxuGNGGGvbZJX0eBNqNDquxRlppSDOsdICV4BDXJZVA80O+o19C92oxGQUD4SAHY5G+lH/7
 8+WET6hD1Sjy78dv3MFzIQvgaxZuTn4fcAymbO9Vq6w4sCyLH3O7a3lBxB65UVgeab1TKTylSm3
 UmpEvZFm47JCC8IxWWb4OE+NNwvN7k4Y1UVtErk7QCCUHZNm4HMOz06/Faa36M0HImebq/3Zfpv
 UtR5bU2eyvqSMZpdD7G6H32RyiNhN5hydkKhVrVxNl3m9K5LmB8+2pN9LyTPLskRKFObFcNFWKh
 J/z99aAo2zjDDTeCtuOBtC+d6JOXstEltXsnH0bp4Sm/95ro9M/A9GFFUcjQfWZbOY/DL7G9q1T
 IIuPF0rZp9E3Z2CWKhg==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a262865 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=zxmW70ayUQ2lO-hVVeIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080019



On 6/6/2026 8:57 PM, Loic Poulain wrote:
> On Mon, Jun 1, 2026 at 2:57 PM Komal Bajaj <komal.bajaj@oss.qualcomm.com> wrote:
>> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
>> EVK boards using the WCN3988 combo chip.
>>
>> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
>> board-specific regulator supplies across CQM, CQS and IQS Shikra
>> EVK boards.
>>
>> For WiFi, introduce the wcn3990-wifi hardware node in shikra.dtsi
>> with register space, interrupts, IOMMU configuration and reserved
>> memory. The node is kept disabled by default and enabled per-board
>> with the appropriate PMIC supply connections and calibration variant
>> selection.
>>
>> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 59 +++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 15 +++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 67 +++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra.dtsi        | 23 ++++++++++
>>   5 files changed, 223 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> index b112b21b1d79..c2ed0396533a 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -16,11 +16,48 @@ / {
>>          aliases {
>>                  mmc0 = &sdhc_1;
>>                  serial0 = &uart0;
>> +               serial1 = &uart8;
>>          };
>>
>>          chosen {
>>                  stdout-path = "serial0:115200n8";
>>          };
>> +
>> +       wcn3988-pmu {
>> +               compatible = "qcom,wcn3988-pmu";
>> +
>> +               pinctrl-0 = <&sw_ctrl_default>;
>> +               pinctrl-names = "default";
>> +
>> +               vddio-supply = <&pm4125_l7>;
>> +               vddxo-supply = <&pm4125_l13>;
>> +               vddrf-supply = <&pm4125_l10>;
>> +               vddch0-supply = <&pm4125_l22>;
>> +
>> +               swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +
>> +               regulators {
>> +                       vreg_pmu_io: ldo0 {
>> +                               regulator-name = "vreg_pmu_io";
>> +                       };
>> +
>> +                       vreg_pmu_xo: ldo1 {
>> +                               regulator-name = "vreg_pmu_xo";
>> +                       };
>> +
>> +                       vreg_pmu_rf: ldo2 {
>> +                               regulator-name = "vreg_pmu_rf";
>> +                       };
>> +
>> +                       vreg_pmu_ch0: ldo3 {
>> +                               regulator-name = "vreg_pmu_ch0";
>> +                       };
>> +
>> +                       vreg_pmu_ch1: ldo4 {
>> +                               regulator-name = "vreg_pmu_ch1";
>> +                       };
>> +               };
>> +       };
>>   };
>>
>>   &remoteproc_cdsp {
>> @@ -57,3 +94,25 @@ &sdhc_1 {
>>
>>          status = "okay";
>>   };
>> +
>> +&uart8 {
>> +       status = "okay";
>> +
>> +       bluetooth {
>> +               vddio-supply = <&vreg_pmu_io>;
>> +               vddxo-supply = <&vreg_pmu_xo>;
>> +               vddrf-supply = <&vreg_pmu_rf>;
>> +               vddch0-supply = <&vreg_pmu_ch0>;
>> +       };
>> +};
>> +
>> +&wifi {
>> +       vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +       vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +       vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +       vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +       qcom,calibration-variant = "Shikra_EVK";
>> +       firmware-name = "cq2390";
>> +
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> index e62ba5aef71f..3bfd0050064f 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts
>> @@ -16,11 +16,48 @@ / {
>>          aliases {
>>                  mmc0 = &sdhc_1;
>>                  serial0 = &uart0;
>> +               serial1 = &uart8;
>>          };
>>
>>          chosen {
>>                  stdout-path = "serial0:115200n8";
>>          };
>> +
>> +       wcn3988-pmu {
>> +               compatible = "qcom,wcn3988-pmu";
>> +
>> +               pinctrl-0 = <&sw_ctrl_default>;
>> +               pinctrl-names = "default";
>> +
>> +               vddio-supply = <&pm4125_l7>;
>> +               vddxo-supply = <&pm4125_l13>;
>> +               vddrf-supply = <&pm4125_l10>;
>> +               vddch0-supply = <&pm4125_l22>;
>> +
>> +               swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +
>> +               regulators {
>> +                       vreg_pmu_io: ldo0 {
>> +                               regulator-name = "vreg_pmu_io";
>> +                       };
>> +
>> +                       vreg_pmu_xo: ldo1 {
>> +                               regulator-name = "vreg_pmu_xo";
>> +                       };
>> +
>> +                       vreg_pmu_rf: ldo2 {
>> +                               regulator-name = "vreg_pmu_rf";
>> +                       };
>> +
>> +                       vreg_pmu_ch0: ldo3 {
>> +                               regulator-name = "vreg_pmu_ch0";
>> +                       };
>> +
>> +                       vreg_pmu_ch1: ldo4 {
>> +                               regulator-name = "vreg_pmu_ch1";
>> +                       };
>> +               };
>> +       };
>>   };
>>
>>   &remoteproc_cdsp {
>> @@ -57,3 +94,25 @@ &sdhc_1 {
>>
>>          status = "okay";
>>   };
>> +
>> +&uart8 {
>> +       status = "okay";
>> +
>> +       bluetooth {
>> +               vddio-supply = <&vreg_pmu_io>;
>> +               vddxo-supply = <&vreg_pmu_xo>;
>> +               vddrf-supply = <&vreg_pmu_rf>;
>> +               vddch0-supply = <&vreg_pmu_ch0>;
>> +       };
>> +};
>> +
>> +&wifi {
>> +       vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +       vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +       vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +       vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +       qcom,calibration-variant = "Shikra_EVK";
>> +       firmware-name = "cq2390";
>> +
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> index 8b03d4eafa6d..a79f44aff968 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> @@ -8,7 +8,22 @@ &qupv3_0 {
>>          status = "okay";
>>   };
>>
>> +&tlmm {
>> +       sw_ctrl_default: sw-ctrl-default-state {
>> +               pins = "gpio88";
>> +               function = "gpio";
>> +               bias-pull-down;
>> +       };
>> +};
>> +
>>   &uart0 {
>>          status = "okay";
>>   };
>>
>> +&uart8 {
>> +       bluetooth {
>> +               compatible = "qcom,wcn3988-bt";
>> +               max-speed = <3200000>;
>> +       };
>> +};
>> +
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> index 727809430fd1..95bd797d009d 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts
>> @@ -16,11 +16,56 @@ / {
>>          aliases {
>>                  mmc0 = &sdhc_1;
>>                  serial0 = &uart0;
>> +               serial1 = &uart8;
>>          };
>>
>>          chosen {
>>                  stdout-path = "serial0:115200n8";
>>          };
>> +
>> +       vreg_wcn_3p3: regulator-wcn-3p3 {
>> +               compatible = "regulator-fixed";
>> +               regulator-name = "wcn_3p3";
>> +               regulator-min-microvolt = <3300000>;
>> +               regulator-max-microvolt = <3300000>;
>> +               regulator-always-on;
>> +       };
>> +
>> +       wcn3988-pmu {
>> +               compatible = "qcom,wcn3988-pmu";
>> +
>> +               pinctrl-0 = <&sw_ctrl_default>;
>> +               pinctrl-names = "default";
>> +
>> +               vddio-supply = <&pm8150_s4>;
>> +               vddxo-supply = <&pm8150_l12>;
>> +               vddrf-supply = <&pm8150_l8>;
>> +               vddch0-supply = <&vreg_wcn_3p3>;
>> +
>> +               swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +
>> +               regulators {
>> +                       vreg_pmu_io: ldo0 {
>> +                               regulator-name = "vreg_pmu_io";
>> +                       };
>> +
>> +                       vreg_pmu_xo: ldo1 {
>> +                               regulator-name = "vreg_pmu_xo";
>> +                       };
>> +
>> +                       vreg_pmu_rf: ldo2 {
>> +                               regulator-name = "vreg_pmu_rf";
>> +                       };
>> +
>> +                       vreg_pmu_ch0: ldo3 {
>> +                               regulator-name = "vreg_pmu_ch0";
>> +                       };
>> +
>> +                       vreg_pmu_ch1: ldo4 {
>> +                               regulator-name = "vreg_pmu_ch1";
>> +                       };
>> +               };
>> +       };
>>   };
>>
>>   &remoteproc_cdsp {
>> @@ -57,3 +102,25 @@ &sdhc_1 {
>>
>>          status = "okay";
>>   };
>> +
>> +&uart8 {
>> +       status = "okay";
>> +
>> +       bluetooth {
>> +               vddio-supply = <&vreg_pmu_io>;
>> +               vddxo-supply = <&vreg_pmu_xo>;
>> +               vddrf-supply = <&vreg_pmu_rf>;
>> +               vddch0-supply = <&vreg_pmu_ch0>;
>> +       };
>> +};
>> +
>> +&wifi {
>> +       vdd-0.8-cx-mx-supply = <&pm8150_s4>;
>> +       vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +       vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +       vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +       qcom,calibration-variant = "Shikra_EVK";
>> +       firmware-name = "cq2390";
> Does the firmware differ from the one used on Agatti (QCM2290)?
Yes, WCN3950 vs WCN3980.

>
>
>> +
>> +       status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> index c1f25ce89bb1..6bac6ebac8da 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
>> @@ -2064,6 +2064,29 @@ apps_smmu: iommu@c600000 {
>>                                       <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH 0>;
>>                  };
>>
>> +               wifi: wifi@c800000 {
>> +                       compatible = "qcom,wcn3990-wifi";
>> +                       reg = <0x0 0x0c800000 0x0 0x800000>;
>> +                       reg-names = "membase";
>> +                       memory-region = <&wlan_mem>;
>> +                       interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 362 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 363 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 364 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 365 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 366 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 367 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 368 IRQ_TYPE_LEVEL_HIGH 0>,
>> +                                    <GIC_SPI 369 IRQ_TYPE_LEVEL_HIGH 0>;
>> +                       iommus = <&apps_smmu 0x1a0 0x1>;
>> +                       qcom,msa-fixed-perm;
>> +
>> +                       status = "disabled";
>> +               };
>> +
>>                  intc: interrupt-controller@f200000 {
>>                          compatible = "arm,gic-v3";
>>                          reg = <0x0 0xf200000 0x0 0x10000>,
>>
>> --
>> 2.34.1
>>
>>

