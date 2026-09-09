Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500AF3A5E70
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788935543; cv=none; b=lvlm8neAV8BLw2jr/TuN7zDkpB/2I9DT2mYDQqCyDCortGGEiIMVwb94pJsl1UK3MQus40jkbQKXOUWMZw9M3T2CMx1YsKteutveKDVP+eEpsHnhTtRiow+j0ZzRzao5ff8VOnDzkIez0dP35C4tGzBCOuVJkpqn1QlKDa8AEQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788935543; c=relaxed/simple;
	bh=lnG791FSODWeZaNNFnoQtuUXHRoTA5gkZ7w6c1f3HKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMPQJX1H6lma1JUynwPjlFpLgRq3cvGNtybmEdRG8MrQVoyGHlIFveckDacpuOqlEx14KjtFS9SsRUd/y5plpnzcFAg1PKMlHNh2sllq+plbtnybflQUibhETps8shNZWQcn/FD2Es6et6NHrhGPi3tc8v6i+IrmCO7mR4Z9/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DSGDtOXz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VNN8UO5+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DSGDtOXz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VNN8UO5+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6896Gdcs131921
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 06:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ajphOkjbnMWFf+zls/5ssNbY32CcGa+IxG2/SOuj78=; b=DSGDtOXzrj61WcEY
	BV4edgvHYUcWAxz8Af3Sto1O+XH7khrgyCvwrRat8e1TBI/LnI7ii5fgk1TKzCa8
	FROaf9DGOTNDsM1k0YqUmxD7EOQZTDi4B0fU5IqoMHgi4zKQiPxO2EQjS1NAP890
	fJmQKz5LKnkAwvp3i5sEo5aeUQUY0MVp94ubKo9KNinGBiGPmA6HrhZeqL1+lV0C
	bADLE9z/JZMG2NWS8Qlwtun/fQ/wpzge5jwkzMhAUfJ8wgdM6S/hJtFvEKr16o6G
	Z4UMNYmdTrWgcq5whHxIN2kHOkz3nJsuxxD7itjlw9n+FesbquWKydcRlHxhp/5C
	A4Rcow==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjntpk35c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 06:32:20 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38f283baf1fso6573925a91.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2026 23:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788935539; x=1789540339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ajphOkjbnMWFf+zls/5ssNbY32CcGa+IxG2/SOuj78=;
        b=VNN8UO5+z44YGiBHwM5i37maOW1bVz4OBJIV+A6gcPkYOphRJ1uztlhbdE54Q/wVup
         JS/Ly7ivRKl6TyEnCiZvNzUcOzW2C0iS4eGB8aI6dNRVsxSNH7KYFdvGRqHOyP71i+4l
         nI73y5DZP885ODevrKbhtudQSSazucsAqjE++2OWJNNZccQpU9d5gMOwQne1wr7C2Whg
         fc2DtdpeXhAm6V8yt6lZjzW4LhBJgKYj7YfpzWl7qyjxFlY+6efLuRgnsnqSHQa7ev4X
         vVQHDHFciRYYhNbn6fJCORqEnwPEx4q1mdNgIwga0zilpomMRb1xcyrIuHK1hAx8ghYa
         N5VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788935539; x=1789540339;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ajphOkjbnMWFf+zls/5ssNbY32CcGa+IxG2/SOuj78=;
        b=VQCujqRrGIF3JX+7GJUqSzCef3BWPEZbm9U3gKbE0Mb/Q/cCdFda5dowA3GedmHUIb
         F058tBNFG4tqxAu2vbIUdo2SkLPpnAWuU6Q1s2w9kcHOKMQxco5l/+LYX25b+W7A/9m0
         2839g4H+X8w4xzs6VaavEzk7s3frTWWfpLmHtT7UhJlRDKz69FB9nNZUDSqx1Pdvt8zi
         GSdCKF/ByUEuyk0yrw/ji2mCg+QYiMo4DG3jgnwiq0lJTAZOr+u8RhM61ViZdeNWJcW/
         cXupBJHKVdsU9QWtshAAjtpROySawUNXxZSGZp0MtzLOncGgj8dH5iWHbntVXdxN/Tav
         6ASw==
X-Forwarded-Encrypted: i=1; AKwUvBxU5y8EeDRBBvAFKSpcTWL1e7WLuOiSiUmx5mTueyVskTBrxmr6fl/LVPp4RyT1vKfXJyKUqjNzsA==@vger.kernel.org
X-Gm-Message-State: AFuF++ni1uX/kybs8BTyjcKTjR3d2GiIj2mPIHd6hWN3R0g3ijUedICF
	kY6HCc8QyiAoUQa32HK5K014mAPde8KqhrNw2ASFtVTCInlQyHbFywQDgvr8CHEqL7Y5OkqKC76
	h1o6MGCZqUmLffcg0aSAYXRxsvAHPnItQLCZ5NV7maB9UddX2fGA31fWMKknqYA==
X-Gm-Gg: AYBFou3GiKnSXO/QYCf9BArUcpvf6mD8aCscPeXUjqzLtZBMY3zrCYcpyjZVXL7R3S2
	aNspzXGNLEvhnlg/zYythc4Vx+2UPG8sXPhqokCDcH7ko02Ite1v27KyXkcmcxnaYGjGAXx2E1J
	NazLIlPu0M06BoesIwCyxAUeMT0owoFJ9HUPBgTgZ0xeubphZjxC0iBYGqoN0cosm+V8dDBBL87
	jGWO4zibLjDlRxcBgLpBd0dpVvyyNgwZRFvcS5TfATAQwdK47Zanf1UUInHqwvOYznLQnE23UXl
	17IOjjSxvZttVLyCCl7k7jcecP+7pVwmwc11Hu/aqim9MNiSivNtPVa/k8bp/nqma92sJw98gkl
	3+hyVOxUR6bIS7mFtgHqlSB+W3pdYR4g=
X-Received: by 2002:a17:90a:d003:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39b26273a40mr51435538a91.21.1788935538948;
        Tue, 08 Sep 2026 23:32:18 -0700 (PDT)
X-Received: by 2002:a17:90a:d003:b0:398:ba9e:75ff with SMTP id 98e67ed59e1d1-39b26273a40mr51435476a91.21.1788935538373;
        Tue, 08 Sep 2026 23:32:18 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33450e140d3sm35490264eec.4.2026.09.08.23.32.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Sep 2026 23:32:18 -0700 (PDT)
Message-ID: <4e7dd5bf-28e2-4c81-8e8b-7629f298b92b@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 12:02:09 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] soc: qcom: geni: Derive SE clock configuration
 from OPP table on SA8255P
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <CAPx+jO9fcvBsxe9yx9oK=0EXmpNwub5ba0a-TGk1WRFaRGsqpA@mail.gmail.com>
 <177884a8-902f-49be-8fcb-b2bec3ec7d6c@oss.qualcomm.com>
 <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <CAPx+jO8bXn2F3cWz87Ozjrh00E+a_UWBrHeUViTEkTL87JHW9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDA3MiBTYWx0ZWRfXypTSU74SDf8c
 s1AQbHGcsR3K19GmgRrciXgslevv1J8mzolYzzkBPhe+8Vxy42tdJnAv3igdJO9sxy8pw0dQDW5
 +Wx+ixflXgpyLhzeJMaLSBrhCgDuR342WsSRYQXzjCXfYYxOSuijUION/yQmOMY46brgJ7twFqk
 7HVIM+h5yoJCVJrmvY5LFK3Mbu+Ue7tkqQdkJf592kswuJIdYxlzL5nGfF7rO/OvAlW+7mCVCv3
 A9ajKWB6MMafBYPDQLZ0E8rKhttchZOFuT2jcx/tZ62ntA4K3Cuc4f4ngJBCE1ZvYN/Flt1RNx/
 SgyOzKKu1mY9eCpdy+7f5Mnmdup1Le/R9Wor4DSsmqIt+w7vKZcveheoC4oFXNWHi8xzu4smRDe
 gYUnPXhykIDY7YAdRwmoiZtPJMFOppF5kRbCu0dTVubTTcruCsUKN6ntzqAHfTfh2Shz/SbJui+
 fgYHiNddZ7z9AsjE4Hw==
X-Authority-Analysis: v=2.4 cv=N+AZ0W9B c=1 sm=1 tr=0 ts=6aa0fd74 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rpn9IkJt2xtg3tKW1hYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: ujMvkK2D3j8iT01jMl1qcYW8rcoqJ0fB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDA3MiBTYWx0ZWRfX2oNrXIw/5qxZ
 EJqimvGQCcyZCRiWTGGfu1+lfW7Bt0EmXq+eUBC7wdjWD+r1pOb6xNgZgfx+XSFDASFL/c3QddL
 AUXQdDLHpVvOX2RCiOev/FVc9Rt1rfw=
X-Proofpoint-GUID: ujMvkK2D3j8iT01jMl1qcYW8rcoqJ0fB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090072

Hi Ulf,

Thank you for review.

On 04-09-2026 13:26, Ulf Hansson wrote:
> On Tue, Sep 1, 2026 at 6:48 PM Praveen Talari
> <praveen.talari@oss.qualcomm.com> wrote:
>> Hi Ulf,
>>
>> On 01-09-2026 20:22, Ulf Hansson wrote:
>>> On Thu, Aug 27, 2026 at 7:59 PM Praveen Talari
>>> <praveen.talari@oss.qualcomm.com> wrote:
>>>> On firmware-managed platforms such as SA8255P, there is no Linux clock
>>>> handler available to determine the appropriate SE source clock, source
>>>> clock index, and divider values for a requested protocol frequency.
>>>> However, these parameters are required when programming GSI TREs, where
>>>> the hardware expects an explicit clock source selection and divider
>>>> configuration for the serial engine.
>>>>
>>>> In contrast, platforms using Linux-managed clocks derive these
>>>> parameters through geni_se_clk_freq_match() using the source clock
>>>> information stored in clk_perf_tbl. Since the firmware-managed path
>>>> lacks equivalent clock information, protocol drivers cannot reuse the
>>>> existing frequency matching logic and instead rely on a direct mapping
>>>> between protocol-requested frequencies and performance levels. This
>>>> creates a separate clock configuration flow and prevents
>>>> firmware-managed platforms from deriving the actual SE clock parameters
>>>> required for GSI TRE programming.
>>> Hmm, this sounds like moving backwards when it comes to keeping
>>> drivers as portable as possible.
>>>
>>> I understand geni_se_clk_freq_match() has been around for a while, but
>>> fortunately its use seems limited to only a few qcom specific drivers.
>>>
>>> Rather than continue down this path, would it not be possible to find
>>> a more generic solution for "geni_se_clk_freq_match()"? Can we replace
>>> it with a common clock/OPP API? In this way, we would not need to
>>> sprinkle drivers with calls to platform specific  code.
>> I agree that protocol drivers should not need to know whether GENI resources
>> are managed through the clock framework or a firmware-provided
>> performance domain.
>>
>> The intent of this series is actually to move in that direction rather than
>> introduce a separate flow. Today firmware-managed platforms cannot use
>> geni_se_clk_freq_match() because clk_perf_tbl is only populated when a
>> Linux clock
>> is present. This series derives the same clock-performance
>> information(clk_perf_tbl) from the OPP
>> table and populates clk_perf_tbl during geni_se_domain_attach(),
>> allowing both
>> resource-management models to reuse the existing
>> geni_se_clk_freq_match() infrastructure.
> Right, the goal makes sense, but I am not sure the proposed solution
> is the way to get there.
>
> We really want to avoid having generic drivers like (spi, uart, i2c,
> etc) calling platform specific functions. This isn't just me, it's the
> general way for how we do things for drivers. Of course, we have
> exceptions, but I think you get my point.
>
> In this case, why isn't it possible to use the clock and OPP
> framework? Is there anything missing to make this work?
I agree that protocol drivers should ideally rely on generic frameworks and
avoid platform-specific resource management logic.

The challenge here is that the OPP framework currently provides a mechanism
to select and apply an operating point, but it does not expose the 
GENI-specific
information required for GSI TRE programming. In addition to selecting 
an operating
point, the GSI path needs to derive the corresponding SE source clock 
frequency,
clock index and divider values, as these fields must be programmed 
explicitly into the
TRE descriptors consumed by the hardware.

Today geni_se_clk_freq_match() serves two purposes:
1. Match a requested protocol frequency against the set of supported SE 
source
     clock frequencies.
2. Derive the GENI-specific parameters (source clock, clock index and 
divider) associated
     with the selected frequency.

While OPP can manage clock and performance state selection, it does not 
currently provide
an interface to obtain these GENI-specific clock-configuration 
parameters. This is why the
existing GENI helper is still required.

The intent of this series is not to introduce another platform-specific
clock-selection path. Rather, it allows firmware-managed platforms to 
use the same
clock-matching infrastructure already used on clock-managed platforms by 
deriving the

clock-performance table from the OPP data.

I have removed platform specific set_rate callback in patches for SPI 
[1] and Serial [2]

[1]https://lore.kernel.org/all/20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-6-091697dbeb02@oss.qualcomm.com/

[2]https://lore.kernel.org/all/20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com/

>
>> Likewise, geni_se_set_rate() hides whether the underlying implementation
>> uses
>> dev_pm_opp_set_rate() on a perf-domain device or a regular clock-backed
>> device,
>> so protocol drivers no longer need platform-specific callbacks. The goal
>> is to
>> converge both paths behind common GENI helpers rather than maintain separate
>> clock-selection mechanisms.
> The OPP layer already has some capabilities for managing clocks. Can't
> we use devm_pm_opp_set_config() to prepare an OPP table with the
> relevant clk data for the devices, as a way to abstract things?

devm_pm_opp_set_config() with a .clk_name lets dev_pm_opp_set_rate()
internally call clk_set_rate() on a named clk — but that requires an actual
clk provider backing the device. On SA8255P there is no Linux clk object 
for the
SE source clock at all: firmware only exposes a set of supported 
frequencies as OPP
levels on the performance-domain device, not as a rate-settable clock. 
So there's
nothing for devm_pm_opp_set_config()'s clk-integration to attach to — 
the OPP table
here isn't describing a DVFS operating point of an existing clock, it's 
standing in
for the clock itself.
>
>>>> To address this limitation, the performance-domain OPP table is treated
>>>> as the representation of SE-supported source clock frequencies. During
>>>> geni_se_domain_attach(), the OPP entries are used to populate
>>>> clk_perf_tbl and related clock performance data, allowing
>>>> firmware-managed platforms to leverage the same clock frequency matching
>>>> infrastructure used by Linux-managed platforms.
>>>>
>>>> With this change, protocol drivers can use geni_se_clk_freq_match() to
>>>> select the closest supported source clock frequency for a requested
>>>> protocol rate, derive the corresponding source clock index and divider
>>>> values required for GSI TRE programming, and apply the matched clock
>>>> through the OPP framework. This removes the dependency on direct
>>>> protocol-frequency-to-performance-level mappings and provides a common
>>>> clock selection and configuration mechanism across both firmware-managed
>>>> and Linux-managed GENI deployments.
>>> Rather than adding yet another platform specific method, would it be
>>> possible to extend the generic OPP library with the pieces that are
>>> missing to make this work in a generic way?
>> I agree with the goal of using generic infrastructure. However,
>> geni_se_clk_freq_match()
>> derives GENI-specific parameters such as the source clock, clock index,
>> and divider values
>> required for GSI TRE programming, which are not represented by the
>> generic OPP interface today.
>>
>> This series does not introduce a new clock selection path; it reuses the
>> existing
>> geni_se_clk_freq_match() flow on firmware-managed platforms by populating
>> clk_perf_tbl from OPP data.
> So geni_se_clk_freq_match() is used by two consumer drivers today,
> drivers/spi/spi-geni-qcom.c and drivers/tty/serial/qcom_geni_serial.c.
>
> Beyond the $subject series, there will be even more consumer drivers
> that call these platform specific functions. As I said above, I don't
> think this is moving things in the right direction.
>
> If this can't be solved with generic frameworks (clocks and OPP),
> please clarify why so we can figure out a better way forward.

I believe above response can answered your query.


Thanks,
Praveen Talari

>
> [...]
>
> Kind regards
> Uffe
