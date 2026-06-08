Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3EF24BBFD
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780923646; cv=none; b=Iyg2kxbRYiFLYnZidlDa6kFpH/ya1X0ZThmh7VQkHHvlsXTr3Mjf85Fh614dRzoDZVH7ouWcuF8rtHHciCearLqnPKr8I89cS/wvzaodseRTL5OgrE4oVn+WgNxql9Tnzdp41BzS/qjVvGdKrw+qaokv2Nfzo0UrgF0k48RN90A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780923646; c=relaxed/simple;
	bh=5CPeWiybnuarQX89JSsnELL5gZi36koS7oxDYutM69w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iOn8cj86sExiOGy2kW450H1EIE5yhFQKysNKpS1MalVCGHW9aMo25qWGt3RhXICtFHFrVhpZDAkwMdnIJMXEbBJ+ZishL97KnyCdOTNUB9drobaTo3E+hdEdhXLjqNT2HmsRxoHjGV+EMWCg+jGxwkbBkP2ULkUaYHYj86lKOhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=THJYMksA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Pl0dBQTs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="THJYMksA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pl0dBQTs"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658B9SDN3029591
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 13:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sz10LbxlxIzFGKgPz2INDQUt6FN8Eaw4+BxLG+zT1cU=; b=THJYMksAV9Qad3zc
	bfkabOoTb0K9nC2fiQ6yyMBL2F7Vq9KzW7u1MJDstSDyJYIKEMjWL97r42OmntNN
	zWs950gwiJLot0/mTyjIMAzDgGSU3wTb4RF21GIi/FC4Zew0iLxw4MF/7GptVzrf
	6NNdvKfyI77KVEbCRqgmP+31slhuN+xh3ODSBBh1y7VqaVASfyv7I1bh8XLaDkRV
	UP88jfBBBH38g911SSZ5oBLNp3NTZvp54HjDQDYGKxSsXqw2BlDQk3+3F2TEqRYG
	vKc17PYpCWqQkLNxh60gp862shrLf+ufT6Uf8XH5KYDGeZODF3WvPlpAT14Cujho
	KA8OVg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun40pxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 13:00:43 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2bf004bf8beso52496305ad.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 06:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780923643; x=1781528443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sz10LbxlxIzFGKgPz2INDQUt6FN8Eaw4+BxLG+zT1cU=;
        b=Pl0dBQTsILC9YNrn2AbFsoG+krL4n5+JKnwwjwlVTJ2QLs0r4jfaRjZ5z7LbDZqvYS
         hPQoLlSw2EvV1E7EFD0XvkQ0XffuU5O8YrIBQcc4Hex92KicYRM6KFHL4U+D1pUsOFUq
         IG9U3Neal5EL8/d874qfQwmCMqQHzzBBy1tgYlWpftdkrwdnCfuN21YoLQ8FL7XNs2PM
         XzaFE/hCYrzMPViSLiCT653wwLNdHaWjMFEY0f8cbeR4LvQfRTQIBIgZ6GkfL/yu4TBq
         MXUCJGUA6ZAIFsDjb20qwZFdwoVttAKr25V+l8rGWYI6nAElNJIP9lC7bq8qwcSIJooM
         NrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780923643; x=1781528443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sz10LbxlxIzFGKgPz2INDQUt6FN8Eaw4+BxLG+zT1cU=;
        b=lgK0Uxx1CdJopLoZrHXY8By5LoMYCKPEsr24Ufy0HW14FC5swY2Enk9oHfeJbNFlHE
         1pVDzRnhR6O+J3v0yOXjdBvTMHjziiopHlFw7BMWZcqetbBAqhJNmtzb8/zTA7v7F0A1
         H1xRM36AhD5qYOWJCOYCBZ8tvGR2qZtE0Z+b7tYJRxWvIrngyWMPmiP08RU2CtyrMzjx
         zzlgo9AuK7Ja1BJesatH5KeqwdNZqBrl/yt4fuZJVgNKz9vC2Dg9D6vpGSNwv9xb0+rC
         qECQ+/pzGh5QARVu8GR31oWnUJSXxJvm13eq5hkgWhnw1/zNXwBHT/x+eZZBRFj25jrV
         0tCw==
X-Forwarded-Encrypted: i=1; AFNElJ+BHgat0q61Hm6wM2AuS6HHODKKfMP7o4Km1YJAk2Qxzlpv+PqnXDMYKvj3sxvtxkgXQ9gSMIf6Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu8Bp89S6OSbfTh734na9JubLknAjJJcMSZ/Z8DYw4tmr6qi9s
	JBqepsmW7bxhxEn9QFLrL+cm2IikuACT517BBpqGy+pOrPQxHgmtTk+0O3FWTb9lvqUrlitgdWj
	3kRxuoTSbA02MWa+SkP9Gj4NKKUaE8/Yh5YZ2rYahf3P++6WMPLtvaWPXiLVdsg==
X-Gm-Gg: Acq92OHB2xVLncaX0deSQ8UnXtUvkzzJZ/IoDKEcYENBckdkCgSlBawfCHQWiQQ2Xf4
	cMBtHYmKmWRrk+EdKt2w49E1wMLYO4irpa+hGm7siNfh6+m5hKoYmQmbWeLruj34x/Mhyo8qEJV
	o3D09HqgFDZYqow4j0MJZ1rJx1H08HTNWBoT/D+QXQOqXQYADeBf6BRTMz6z876bdplzrDlDkOR
	hDuJafc2RFHCmXoPi5Huztrz6VvZLisY0xlvTVe1gd779iE7N9a39XxKtLoYooAcEFPVJYYxunX
	Im8ZRf0Y31FfkEiNKnKhNwo+RuZrSkasidRToka2xwzLLsKlEjKFjVMruliq32fJi27JJXHywR1
	fsA0Gvizmwl651a0GYysWTgWA8GxcUjlJeFAz3UVPqvX8eMWHWRGz+fkFC7YX
X-Received: by 2002:a17:903:248:b0:2c1:564b:4f49 with SMTP id d9443c01a7336-2c1e7b35a10mr172173855ad.6.1780923643026;
        Mon, 08 Jun 2026 06:00:43 -0700 (PDT)
X-Received: by 2002:a17:903:248:b0:2c1:564b:4f49 with SMTP id d9443c01a7336-2c1e7b35a10mr172173015ad.6.1780923642286;
        Mon, 08 Jun 2026 06:00:42 -0700 (PDT)
Received: from [10.219.56.230] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6cea3sm177993205ad.7.2026.06.08.06.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 06:00:41 -0700 (PDT)
Message-ID: <19df2647-309c-4345-896d-b4cebec07e97@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 18:30:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] arm64: dts: qcom: shikra: Enable Bluetooth and
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
References: <20260601-shikra-dt-m1-v3-0-0fe3f8d9ec48@oss.qualcomm.com>
 <20260601-shikra-dt-m1-v3-10-0fe3f8d9ec48@oss.qualcomm.com>
 <j2l7ijr56b33uru53wiyhjkd66pxusxopr4c7xmztlqfnztha3@xp6ciwnngcv2>
Content-Language: en-US
From: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
In-Reply-To: <j2l7ijr56b33uru53wiyhjkd66pxusxopr4c7xmztlqfnztha3@xp6ciwnngcv2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEyMyBTYWx0ZWRfX4U53aPtqrttm
 m48PsGOQGzP+cYYAVYMJaNDFmVCxCmOuFwf5m+PUr0nE1yZZvt2+d4sI+bGZ9OCvMyXamjYv5dn
 stjOkWVDqOtJgvN2M3sN/TozjPddzQkdgZV1Tgoi0apyh2dMyR+V+Z6ZWrMVV+hlFSC+kEmYUyb
 Fcbd+mAVzdDW8/paK1f06j8xNCMVr6BbbHa/2wBdCSxcVasNAq9g58yB8qPvqkCcYXQSMd7OhlI
 tLjkIkqfsXRmPIGEdbLqFOny21DOXohfCG9gz2scliZYfpSoS42TTE8csk4P91oz4QUSH4cKmF6
 Es0fpWhrPyT35ZPtj38Q57BVBgLpH38p2315ISvZCZg2LYaBdwOfD8dSEHjdL7IDyhk4UdAnsU3
 HQzTFQ3IjBlbvWvd/JoyKCnHUTygP5GX37LTxXYbr5bt5BkHpuvMGMsyy1hpHsaShGE0XVOBM8D
 vkZumRNDik0DD+RKfzQ==
X-Proofpoint-ORIG-GUID: WrOihuFVOlKjLY6xZl5U-FZAd8vPxEKU
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a26bcfb cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=DXfNKwVoJAfSTobcJs4A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: WrOihuFVOlKjLY6xZl5U-FZAd8vPxEKU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080123


On 6/6/2026 6:15 PM, Dmitry Baryshkov wrote:
> On Mon, Jun 01, 2026 at 06:25:12PM +0530, Komal Bajaj wrote:
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
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +	qcom,calibration-variant = "Shikra_EVK";
>> +	firmware-name = "cq2390";
> firmware-name = "shikra";

ACK. I will update the name in next revision.

>
>> +
>> +	status = "okay";
>> +};
>> +
> [...]
>
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
>> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +	qcom,calibration-variant = "Shikra_EVK";
> I hope this means that calibration files are common across the boards.

Yes, it is.

Thanks
Komal

>
>> +	firmware-name = "cq2390";
> firmware-name = "shikra";
>
>> +
>> +	status = "okay";
>> +};
>
> [...]
>
>> +
>> +&wifi {
>> +	vdd-0.8-cx-mx-supply = <&pm8150_s4>;
>> +	vdd-1.8-xo-supply = <&vreg_pmu_xo>;
>> +	vdd-1.3-rfa-supply = <&vreg_pmu_rf>;
>> +	vdd-3.3-ch0-supply = <&vreg_pmu_ch0>;
>> +	qcom,calibration-variant = "Shikra_EVK";
>> +	firmware-name = "cq2390";
> firmware-name = "shikra";
>> +
>> +	status = "okay";
>> +};

