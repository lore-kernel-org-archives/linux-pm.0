Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3F54052A1
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526521; cv=none; b=U959mbOAaW8rKezvcGiX8zfUyrXzXJG05Y64XC4aaheRHnucRnWo1qBG8S0vIfh60h1bIs28ScCnRL3aXEwt9fa9dE024aeag52NwcnUtV6Ly3NmPLA4K5UfIax9ThcsMyomnPXELpV0pEikaxvxIETnoDM0xs9WS2YYEom7d7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526521; c=relaxed/simple;
	bh=jvzPuBmH1jjZIV65CBV2Lt6mKqMcCPkwxjV/Li/4fcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6VS26Hg3itR9Nc4uRaD14fdyzEczgLQvjlHz11z6RdyScCzZEZC3dmyuAbpn2WzVqYFoMsx3lMx2MHOvbQJ+KZup5b0P2FoBYPHbxLscK9rA3oj8NZ7+ZHowgH+mErvUNm8/yN++jAlv2ZDKSUMARt/O2qWMvpVq0ms1Q3nXMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TM4Sfrhf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NXPmA4hM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TM4Sfrhf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NXPmA4hM"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C8YIl13331933
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:21:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HfXtH3ktPoM1ChNA/H/V/L0UKO0QHDZrtEJ/UsptBis=; b=TM4Sfrhf/bdcAEV8
	70gF4pSn5/DnzWS7Bf+mXfDZ/hieLttGQMI0vfYcz9bjC/i65sst4RBlGGDlqEaZ
	7zeo+tceh7S6deNDbajraA8xWAXeOjCNQsCkgfZtnMxLJyiKDuT/fnxoFoQp6cnT
	ww47xaLdfvmHohna59gR4c81E4r8N9fMhH7zVSwaqAgvO4iE0Aq3dvgQRw84RaAH
	HNTYECtDRi6TALEWdLs6Bok6cQjvyPWAzH9dZQxTlh0sZQBS1dsX4gUrv2neWwKo
	TlcvKQNo/IwWblxOj903jGyvbxeBGRqIEM4J35gW2roStDGyBYoSHRQFMukXamt/
	E5nfAQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rgfys-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 09:21:59 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1045693a12.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 02:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786526519; x=1787131319; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfXtH3ktPoM1ChNA/H/V/L0UKO0QHDZrtEJ/UsptBis=;
        b=NXPmA4hMIZWBRFrQfVhsNnDHBfoZYyzG5x4MdU9OTMuwl56RSnBiPZjTSDj3hQH/5Y
         x+t0EucOcUj3lZ+68hySBnFrUCSmSg62ghnlaH8MGupj4DBDLMzRt3eReNIMldPINhjv
         UlPcG31fLAU3vbfioG5m0D2tFMSOkOECO/ZiIvTv/P99WBI7xoiatoS0BZB8qqMfmdcD
         esP8fntWhkd/T3p65DsNra/0KtZHHnuI1t6idgwji7c9XO2wjbOLk9JAcfUryMjX2EiF
         goLFKSV9Qq10dn8KfPg5cTAc6YAO2Al9c/XrhqDQLQB/mOQFlmf/YaLWB7OYFqNTd61H
         oHhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526519; x=1787131319;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HfXtH3ktPoM1ChNA/H/V/L0UKO0QHDZrtEJ/UsptBis=;
        b=llFya4sNMCSIi4twXkBK9MqQN3H+w4U19oFDUFWGYBjRuPwPqAfszisC8pKm0dl2jD
         8vqK9wAp4OTv33zIqb8rTzHfmQj1INkWgncoGHqMITFUyy1drUM+42sd+2J8chl6h7YP
         JkHbkC6M98UEQ1GKtUlJJWjZEmFdI2NQ3q0sPmPrb9qJapWCfdoqYme+1wy2QH7Oy+OG
         a2uDvpfokuX2kNhmMcx8rtfdWrmGVAFeqbo+alZaxBqjpv94+aHXDQHmo7r6NGbscu6W
         Mjmp5HPs4zw1WiV8aHXdztrZr+QOd/pbpHHqF7JtVZoyygj0cyIG6iirAw4fz45K421V
         9f6w==
X-Forwarded-Encrypted: i=1; AHgh+Rpf6gJoqBZ5aWiWzX/uJu9IGO62TMeExEQ2EJ+YcGMNxeTy6dLU5Yede62KGb+G8pi0mQ1Au9ZeCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzudwUihugclwFn6WLwgZ4U0SqBmN5DrHIBKYIHk4lmLadw8NyB
	dnqlbWHL9r/rkEW+2HVBEaBOGn1J5HuSQySFj4FdUJ7AzULr6HE/0j0wZRQv0PG6tY21WBWykwO
	VKxYY/geLhv1cuqvuaCOzxg/FaRnDbpTH/YOdP/O9Zwk14eSVoUJCrHcne1LkbWbJUV8Z8A==
X-Gm-Gg: AR+sD11PMCzPTeZLRSXRArlol/BtCwWCNpDvF37t6GI91FbScmj5f87kKrXtIA86OP6
	fgJiOcZJf1oJeK57Yvqt55qmFLMbwyk3iLDQW2FheqTEWSkJgDh99wS72naT3BPoToY4aVtnflc
	Qn/Ua9SUH29wbXZqr+5izsAyBIdhesAbR6GF82hlfiCCDm+r1699zB5euv44yes627HmV5EajMo
	Ts/QRUhhG54w0QJCSikJzSO3XshNMME3u3t26lcuk0VDoEeP9TI+iMZ/1bgo9mvXkLflrVyS1X7
	iGurregb8IlUy8mCvzJmKeq2hui2J9bEZcUM4byRCFn3KwsMaLrWnv1idZlXfkPOBBmFliPGuh6
	wY/LMxCMEySbenI5EZmVJ0xPOau2SChfG
X-Received: by 2002:a05:6a20:d709:b0:3bf:e761:6285 with SMTP id adf61e73a8af0-3cc3f7433ecmr4293928637.29.1786526518799;
        Wed, 12 Aug 2026 02:21:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:d709:b0:3bf:e761:6285 with SMTP id adf61e73a8af0-3cc3f7433ecmr4293871637.29.1786526518355;
        Wed, 12 Aug 2026 02:21:58 -0700 (PDT)
Received: from [10.217.217.28] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbee7d52d4dsm387903a12.31.2026.08.12.02.21.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:21:58 -0700 (PDT)
Message-ID: <88e4737a-a791-46d4-af33-d9de57e6d835@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 14:51:48 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        Priyansh Jain <priyansh.jain@oss.qualcomm.com>
References: <20260731-pmic5_gen4_adc-v1-0-9c49b2eea6f9@oss.qualcomm.com>
 <20260731-pmic5_gen4_adc-v1-2-9c49b2eea6f9@oss.qualcomm.com>
 <aneaaJ_gmyyLh8mY@ashevche-desk.local>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <aneaaJ_gmyyLh8mY@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3NCBTYWx0ZWRfX7axtnzmchSqV
 dSaBnpg+UjHaKXcChTjtCLefW66cuZD+cMBh4wHm7WRXKjCv9mh9Y1nPm6tdYAq36dWGqxmSsOF
 0cKIOmmy4pbgRaf5pA0AYspiRc/ARnfMoAs+sh3bt9bDpX8c4jaQlmf9QaDYJTX4KQ9kbNBkmkq
 pV41tR3BPdt3rLl185gf/Fc+VIwKFpqlDX5jFVHwTeH6MHQrUJGqG8y9av9aNv5LHcYVd3AcmVq
 um3WiACUzHoenOaZ0ckB6CcHg4Ud7V4530dWS0VkKmzKFTfBa3Ba/guWWd9Vmy3Kju8p4LiaWLI
 aw3xOPMoo35U6C4PAGfev3z6iyZK5M7y5z1G2+29TrW8rEvbYARWDXwj30vdwv6s2yZhQF2qV/+
 ELeo+pZVwx78ZNumvW2wAwdQul6Ei4zdSKtitV/5ll50BLAVaUKM+bbfrXGy8ezVuqEc6TpF6cf
 Gdg+Dfj6xFuIxhcBBVw==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c3b37 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=TjZioY23ztXOLIvkaGkA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 21GOXLqDZqlh3kDZkeUanwvgHge7R-5O
X-Proofpoint-ORIG-GUID: 21GOXLqDZqlh3kDZkeUanwvgHge7R-5O
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3NCBTYWx0ZWRfX/f3iZ2sbSdFm
 /9jIHS4c8yrDP2VaFwPNddwL7XAcQXtiZcLhZDFKmvMyS6LyL5AaVkiqMjbgTivsJW6hOnnLxk+
 3wDWqPXS9y4WLyDBNzHCylue0bSMwjY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120074

Hi Andy,

On 8/9/2026 2:36 AM, Andy Shevchenko wrote:
> On Fri, Jul 31, 2026 at 11:36:15PM +0530, Jishnu Prakash wrote:
>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
>> for improved performance, mostly at the hardware level.
>>
>> One significant software change is that ratiometric conversion resolution
>> has been increased from 14 bits to 16 bits, so the maximum value of
>> these measurements needs to be updated for Gen4. Add a new scaling
>> function for thermistor channels which use this type of conversion.
>>
>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
>> under the PMIC arbiter and 32 PMICs under each bus. In order to
>> support communication between ADC on the master PMIC and ADCs on any
>> of the other PMICs, a field of width 2 bits is added for bus index
>> and the bits for SID are extended from 4 to 5 bits, in the SID
>> register. Add support for this.
>>
>> In addition, it is possible that the master PMIC has ADC of one generation
>> and it needs to communicate with another PMIC with ADC of a different
>> generation. Add new DT properties "qcom,adc5-gen3" and "qcom,adc5-gen4",
>> to distinguish Gen3 channels under a Gen4 master and Gen4 channels
>> under a Gen3 master respectively, to ensure that their conversions are handled
>> correctly.
> 
> ...
> 
>> +static const struct adc5_channels adc5_gen4_chans_pmic[ADC5_MAX_CHANNEL] = {
>> +	[ADC5_GEN4_OFFSET_REF]		= ADC5_CHAN_VOLT(0,
>> +						SCALE_HW_CALIB_DEFAULT)
> 
> Always nice to see a macro with the embedded comma...
> 
>> +	[ADC5_GEN4_1P25VREF]		= ADC5_CHAN_VOLT(0,
>> +						SCALE_HW_CALIB_DEFAULT)
>> +	[ADC5_GEN4_VPH_PWR]		= ADC5_CHAN_VOLT(1,
>> +						SCALE_HW_CALIB_DEFAULT)
>> +	[ADC5_GEN4_VBAT_SNS_QBG]	= ADC5_CHAN_VOLT(1,
>> +						SCALE_HW_CALIB_DEFAULT)
>> +	[ADC5_GEN4_DIE_TEMP]		= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_PMIC_THERM_PM7)
>> +	[ADC5_GEN4_AMUX1_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX2_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX3_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX4_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX5_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX6_THM_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX1_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX2_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX3_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX4_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +	[ADC5_GEN4_AMUX5_GPIO_100K_PU]	= ADC5_CHAN_TEMP(0,
>> +						SCALE_HW_CALIB_THERM_100K_PU_GEN4)
>> +};
> 
> ...
> 
>>  enum adc5_cal_method {
>>  	ADC5_NO_CAL = 0,
> 
> (here as well, see below)
> 
>>  	ADC5_RATIOMETRIC_CAL,
> 
>>  };
>>  
>> +enum adc_generation {
>> +	ADC5_GEN3 = 0,
> 
> Why is this assignment? What's wrong with the C standard?
> 
>> +	ADC5_GEN4,
> 
> If these are related to HW communication protocol or bit fields, all of them
> must be explicitly assigned (to make code robust against changes in the middle
> of enum).

I see that ADC5_RATIOMETRIC_CAL is used for bit fields, but ADC5_GEN3/ADC5_GEN4
are not used in HW. I'll add a fix patch to explicitly assign all the enum
values directly used in HW and drop the assignment for ADC5_GEN3 from this patch.

Thanks,
Jishnu

> 
>> +};
> 

