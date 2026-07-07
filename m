Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B841737A
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 13:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431833; cv=none; b=IChSxWJsiQfHaC5YtNcAYcg7D7UUyxKSmCtim+sED3bKCE2luCtg6zUVzho+BKEwwSYo9v6zUzqIPKZB9H/4vY66/FaLSI1fpsIcX8IyKFcAuh3FRYiRpuSDNUbGwxPbBOyF3Fqg5R2Iv6JlQT1cfuxtUXlc3ozhT/EiwGDPpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431833; c=relaxed/simple;
	bh=ohClIIl9VS++4F9zDo7Gf4dQCPR5WJwNWE8dI8K11BI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLkfpMZlLW5xpFMxgK7GcNxvkIl/6rAmckYvKnS/IbzP0HmW59E2rYlXSNi+HbzlhqJldFtr8njisdE+3kegVdYGbWcRcD909MC/Imu7+BEHDkzTw7uIAEqVp6/os5T4uYyZcwE15WvqUIIyt5jhs/RG7b2N1xoMMx43LGP/lbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AzIN4Bpq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dpEGI2cK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AzIN4Bpq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dpEGI2cK"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 667C8xOs3719161
	for <linux-pm@vger.kernel.org>; Tue, 7 Jul 2026 13:43:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HKulkMLDTrRpC8myoqrXcMTbvHZ0aB99k0psGH/8hpc=; b=AzIN4BpqXJYD0OO+
	ChYs4OOtOmzmeawMdGATZz+5jqfiozRMXqWZdqM0G/BQHWqG3BVnkbnNTB/+OpXh
	0RqkmfihqI66tKc2AKagsHi4yby14/wh6NRtP10rCeqxTV0kQMlHezy2U+CPHzU4
	Iw83HyP/UkU3vNU2pkLi7w3DKi/lpfi3VhI52tWAx/dmdLi9izGIBNLznnuMZWn4
	QsukiYNp4NF2OJ8nIgVE3wz7+KtGr+Nf6MI9IYB2RXtYnckmEDerJQ+SsCMNtpSB
	qbvb1K8SdOlUA9yUa/qk53Zaq+CX9yXkQ0SlbU6akdZl8XB+2u8J4pHEn9M/fXwz
	1Oil1A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8v3t9rh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 13:43:50 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc73f47bdcso57668865ad.3
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783431830; x=1784036630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HKulkMLDTrRpC8myoqrXcMTbvHZ0aB99k0psGH/8hpc=;
        b=dpEGI2cKzBDHHWXChRbmJSIpu4N6VEvND2mIBVvBnpKG6qKe8aCnAtHeYbipydx4Vd
         ASbVhHr+8Fcf6M8nmgLc6FccKUl1DfqmMZqr1FP63wFrQB3I0aLZfHknK2tJzUZAa0R4
         FMvzz+8ubcEqOxKcmBSfKUVY7Sy68eW05AW+tTD+jeBgGF8xOhbMzjhpJvyDfp75wO7+
         sskyAmgD8w1/kjKMm2CcLO6O8nFTuqMjPz7iVA/A2ywad9RbDTTmowVBnsOYMU2WKuXQ
         QVlxNhodrNsKsWbTR9GlgVyNsHIUqGAXD+pBHbWPE5Ji2/Be7xCFoO7PWgwb4Y7smFMo
         1Vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783431830; x=1784036630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HKulkMLDTrRpC8myoqrXcMTbvHZ0aB99k0psGH/8hpc=;
        b=SopLEefjs87XfClmzhI8RorfRepjuW5/53+KX1Rpg9wUJn0f1yNRqGMsnKEs96qFuk
         4jaKoAX8VEwsqDDGKIfHPH7Lqqr1SKDEauiy3FfIJnEQuq9veKmXTOWJ8VlES6jiktWu
         CJt2z4Ufo9CT+rcgDHsJrCSMYYjsorn9AWXNEd7c9uooAzqC+z4hKi3cCNyqZks54Aj2
         d+ZsydiQjDw4YMYHvZtukcJ1m2Qy3oFmRimQXo7o3ondInqaO7YDw2gulY4sAwrI/eQk
         RG5MvTh9AlPlu7NfgX1ods+STI5Vu9KZMH7Mb6Us+tKOPCoI7KvHbov58Nv/5c5gguBc
         KEVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpxAclBiGSxxE47cGJY8oV85PbESUwIJgRN9V6Bd/3ewxhp4yxC531Hf4cz2ANmEZE7YHHKbZwPag==@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcYpR64pGnK+4z2MVqjUPI6YArRVONvDMboZdYJTC/uYqdkxf
	3X3Hdctp+dGorIfDmZwQ7KlPsshsSaVFpl9+WmLTalBRvq+GuumDBUDr9tWAdeeaT0yEw/VyleO
	jmuoA10r20ZdFqiC6VTovhAs4tegsuL/ib/2Ezw311RI+1efXY5lYJm5nx4DWdg==
X-Gm-Gg: AfdE7clM+VkOD2Ugwa/7n615d2b74shBu9hTlvPuFOyuWN3Dk/hazALEfgmo1eQvK//
	RvPwN3x4lFhrOeZNmzn7eguiDVstlx3ucp2a/xIXJErpIoMvtdRncrsTB9EcXhtKXTdubd4VMqN
	9VdSqPqxMt1o1zwcRS4gixlVYH7sdTmqXVR9bL9ZpaJCVQV3EvPbSR4EnSHgu4OL2VnWSQqdjhy
	wRdqfaoWQ+5B39thnTJjsxMZYCIDAicDE2QVbOwLZrbEp1kmRBsuCzz8CToqmMzb3cZnoPgAqlv
	QBpilpwQDabnMi7VU2XB1q+gv+sDh3NN6RT87fYMu64heZox5mM8LnPkTjCkIcjULrBwg2oH8xh
	OVAea3ELmPB3k/DzcolRA/kaND+dLF9VHyEbngLM=
X-Received: by 2002:a17:902:f645:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2ccbe3fcc82mr53604275ad.5.1783431829941;
        Tue, 07 Jul 2026 06:43:49 -0700 (PDT)
X-Received: by 2002:a17:902:f645:b0:2ca:9d5a:8b6c with SMTP id d9443c01a7336-2ccbe3fcc82mr53603855ad.5.1783431829373;
        Tue, 07 Jul 2026 06:43:49 -0700 (PDT)
Received: from [10.219.57.117] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb75fsm12457695ad.8.2026.07.07.06.43.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 06:43:48 -0700 (PDT)
Message-ID: <1bbe5560-3a65-41d0-8aec-4d07bc8d05bd@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 19:13:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/11] arm64: dts: qcom: shikra: Enable Bluetooth and
 WiFi on EVK boards
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
        Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
References: <20260702-shikra-dt-m1-v5-0-f911ac92720c@oss.qualcomm.com>
 <20260702-shikra-dt-m1-v5-10-f911ac92720c@oss.qualcomm.com>
 <zjvb6i3rahc2kwojxrg4cwaqtddcho2nj3sfcr63xkkrm7tdd2@2yl6rxb7rtcb>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <zjvb6i3rahc2kwojxrg4cwaqtddcho2nj3sfcr63xkkrm7tdd2@2yl6rxb7rtcb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wgd5al_gPoB7-8NQ9wXfh9Gu_EnXMTL6
X-Proofpoint-ORIG-GUID: wgd5al_gPoB7-8NQ9wXfh9Gu_EnXMTL6
X-Authority-Analysis: v=2.4 cv=HqVG3UTS c=1 sm=1 tr=0 ts=6a4d0296 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=iGamDvFj7nsy-0Hi-dkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEzMyBTYWx0ZWRfX/tQti8b8DfYO
 aD0W1UGm9VnooryahCgX0t/qf23alVtErBwNRzTdNEfolt1RR4WX0J0/plgESqiA5JUOm4TGs8O
 FpNW0wrWa5Yh/vprglGPMKj1XDLK51l9dCBdfwufgtbaIJ64ttere1JCqfHKYtXphXg///7Zmeq
 tcHibJ0uAehJVFGeuvIbF1Vh6A2B+E25yCRkhDrgX/suH0afgpQgH+wWs4Ws0mSejF8NIBGrl7J
 1Tuyvz7/zBYomi4x/5Eyl+5kCRaAcrwVr1z9sXL/v9xs/DlOwZTAjCtDuBWcC41zhc83jHM/qoB
 ShYmTq65s88i8H67tGFzZpgO5LO1/WO/KtWwSlYMN92Qp/mLyAef+/PT1FjxSxhwKR3QqpWTr6b
 u7T+FsBH9h0Ia+z+6EJIvL8RcCBFbbR52wlbZe0LvxfB+OgcT6eSHmhGj+Erj8F7P0hIix9Wr2y
 B0C9AvswSGehKRkQwUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEzMyBTYWx0ZWRfX+5yI0BfOwQHQ
 rGPBQ5ZNA/6MeF1nBOoPBMnZMUnW8If4UQbNH6iN1b8K9mXK6mh/bzbooriYvGXJ2VKkAMyqhQA
 LIDmJVfBupibrvLBPZUgNJBE0MSQqvI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070133

On 7/2/2026 5:26 PM, Dmitry Baryshkov wrote:
> On Thu, Jul 02, 2026 at 03:20:52PM +0530, Komal Bajaj wrote:
>> Enable Bluetooth and WiFi connectivity on Shikra CQM, CQS and IQS
>> EVK boards using the WCN3988 combo chip.
>>
>> For Bluetooth, enable uart8 and add WCN3988 Bluetooth node with
>> board-specific regulator supplies across CQM, CQS and IQS Shikra
>> EVK boards.
>>
>> For WiFi, enable per-board with the appropriate PMIC supply
>> connections and calibration variant selection.
> This is obvious from the patch itself. Don't repeat patch contents, say
> something useful.

ACK, will update commit message.

>
>> Co-developed-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Signed-off-by: Yepuri Siddu <yepuri.siddu@oss.qualcomm.com>
>> Co-developed-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
>> ---
>>   arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts | 18 +++++++++
>>   arch/arm64/boot/dts/qcom/shikra-cqs-evk.dts | 18 +++++++++
>>   arch/arm64/boot/dts/qcom/shikra-evk.dtsi    | 61 +++++++++++++++++++++++++++++
>>   arch/arm64/boot/dts/qcom/shikra-iqs-evk.dts | 26 ++++++++++++
>>   4 files changed, 123 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> index b112b21b1d79..c9409ab0a3f1 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> +++ b/arch/arm64/boot/dts/qcom/shikra-cqm-evk.dts
>> @@ -16,11 +16,19 @@ / {
>>   	aliases {
>>   		mmc0 = &sdhc_1;
>>   		serial0 = &uart0;
>> +		serial1 = &uart8;
>>   	};
>>   
>>   	chosen {
>>   		stdout-path = "serial0:115200n8";
>>   	};
>> +
>> +	wcn3988-pmu {
>> +		vddio-supply = <&pm4125_l7>;
>> +		vddxo-supply = <&pm4125_l13>;
>> +		vddrf-supply = <&pm4125_l10>;
>> +		vddch0-supply = <&pm4125_l22>;
>> +	};
> Is the WiFI/BT chip a part of common schematics or not? Why do you
> define power supplies here, while the chip itself is defined in a common
> file?

You're right. WCN3988 is integrated on SoM, and its regulator 
dependencies are provided by SoM PMIC.
I'll move the supply definitions to SoM DTSI.

>
>>   };
>>   
>>   &remoteproc_cdsp {
>> @@ -57,3 +65,13 @@ &sdhc_1 {
>>   
>>   	status = "okay";
>>   };
>> +
>> +&uart8 {
>> +	status = "okay";
>> +};
> Same question.

I'll move to SoM DTSI.

Thanks
Komal

>
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +
>> +	status = "okay";
>> +};
>> diff --git a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> index d0c48bad704c..4b7be09eb5a5 100644
>> --- a/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/shikra-evk.dtsi
>> @@ -3,13 +3,74 @@
>>    * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
>>    */
>>   
>> +/ {
>> +	wcn3988-pmu {
>> +		compatible = "qcom,wcn3988-pmu";
>> +
>> +		pinctrl-0 = <&sw_ctrl_default>;
>> +		pinctrl-names = "default";
>> +
>> +		swctrl-gpios = <&tlmm 88 GPIO_ACTIVE_HIGH>;
>> +
>> +		regulators {
>> +			vreg_pmu_io: ldo0 {
>> +				regulator-name = "vreg_pmu_io";
>> +			};
>> +
>> +			vreg_pmu_xo: ldo1 {
>> +				regulator-name = "vreg_pmu_xo";
>> +			};
>> +
>> +			vreg_pmu_rf: ldo2 {
>> +				regulator-name = "vreg_pmu_rf";
>> +			};
>> +
>> +			vreg_pmu_ch0: ldo3 {
>> +				regulator-name = "vreg_pmu_ch0";
>> +			};
>> +
>> +			vreg_pmu_ch1: ldo4 {
>> +				regulator-name = "vreg_pmu_ch1";
>> +			};
>> +		};
>> +	};
>> +};
>> +
>>   &qupv3_0 {
>>   	firmware-name = "qcom/shikra/qupv3fw.elf";
>>   
>>   	status = "okay";
>>   };
>>   
>> +&tlmm {
>> +	sw_ctrl_default: sw-ctrl-default-state {
>> +		pins = "gpio88";
>> +		function = "gpio";
>> +		bias-pull-down;
>> +	};
>> +};
>> +
>>   &uart0 {
>>   	status = "okay";
>>   };
>>   
>> +&uart8 {
>> +	bluetooth {
>> +		compatible = "qcom,wcn3988-bt";
>> +		max-speed = <3200000>;
>> +
>> +		vddio-supply = <&vreg_pmu_io>;
>> +		vddxo-supply = <&vreg_pmu_xo>;
>> +		vddrf-supply = <&vreg_pmu_rf>;
>> +		vddch0-supply = <&vreg_pmu_ch0>;
>> +	};
>> +};
>> +
>> +&wifi {
>> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +
>> +	qcom,calibration-variant = "Shikra_EVK";
>> +	firmware-name = "shikra";
>> +};

