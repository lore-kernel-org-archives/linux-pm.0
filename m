Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785DA48424B
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 15:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843796; cv=none; b=EEsNnifTwMxkoi6MpcAeSsmSCjPs2Z8MSn1ssM3qN5yzY+BXjYn6IlUme8uJRf11Do/EWOiM0HmUwTn8KxcbRG2LZWi4OkxmZlLT1J65hj5ppF46oD4pmlccGW369dqNJweE8zVPFFPfeyEAgVM4XFCknIrDwvR+TZSgm6pe+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843796; c=relaxed/simple;
	bh=PpCc/vlf9b07SxvzQVU62p72CK12ySdmO+yXnpobbbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVlNyQmerjATRHCLBXCCGfdya0pafgERdwI09kQrItH5Z+Y1y1qHFocSUAXw0y5paKvuzdf/JBrhhIeNUzxX2iNrY0vnuyW7iU2LWoFj2J+hxDRgEgFgSGc4KaOi0+w5yHmkipSivk9GI6U58XCxSQXvvoCxEoSabKD25y7cgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j+XThCSr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M6AS3E/u; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j+XThCSr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M6AS3E/u"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RF28E8278260
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 15:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gtDukmFMoEJfDZ7a3V4nn+CIGOUTzNyajLc2q8Q3TpM=; b=j+XThCSrYVsBV38y
	WGJiNA26F8jrtVFxmIgWyPv3i+PDPn/SvJPYpxIcYCEDXAfJn+h3yDEUP34/gJP0
	rX4w9mYYrB2kQhYkiD5a0baBmYqun1OPHFtBJ3uW+Ffmu0LkxWZljavjjRftTUWM
	bjNCN72zNK+Wujo/sV+mUQsZpJWKXkYK/llurxcihkx8YOfJYMElShamuUWLXLFn
	VynY5VWlNSqns7f6gwu7XvBa9jNoq0KZ9b5ZTX/P+Ihs419FLlducY5Nm7gPrfZf
	4QtEDB/FBR5mX3BqjIEHCow4wCs2LSra/TMrxgIgebAYqOzcgalJQbA8u9Eob2Ff
	Jp9TYA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ganr68h0c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 15:16:33 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84e375d9736so44748b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 08:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787843792; x=1788448592; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gtDukmFMoEJfDZ7a3V4nn+CIGOUTzNyajLc2q8Q3TpM=;
        b=M6AS3E/uH7r5I6GWjkw17hN2wJRKwC/8bWVeMpV4ZLnTkgwZEwhH3OLb35zIfo5R71
         VdvzYOWAg9faf35z2t1wS01eAunk3OjF4+Nagza4Y9Rhf65asdtBoyQcxSAEc+ICJRdh
         VcfhaqOseGS6+0A5EApjdp9tXev0UPShZmkoLuDbswQ30vzUTQScjFrGcBnXeizXPuEf
         i/4eV9go/HNvsnWW0kC4jLs6PYlL+mJv5BOwt6OlDKDUnJB2jPyqiBU/1NGC/7d7kmHc
         Pz0M6+gDjhyt4aGUgQsdvc25Gtj/rXnTAxM9InhxvLPB6h4syWVY20fgAUVNfqH7bzU9
         TA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787843792; x=1788448592;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gtDukmFMoEJfDZ7a3V4nn+CIGOUTzNyajLc2q8Q3TpM=;
        b=Gwwi83SJDVOnGWWUGvlJk/uDBDjqwmbk/DRlMxDWavCTjQrlNEFZj9NGyYufaKtnIZ
         753OVefYeXmqlCai+dctycATaT7PE0/xcSDeQmpFGJRXis9odwEv9nymX66t5TUnqjsB
         5WhUVHF/rsFnIjyqY06pJ5xMlC45chURU2Gizxx0sYqu9Bt3rL7wY3bQR1WGZ3Xdywan
         PxlJhTzsTPriNbZO+Cc6wzfNxZRf5+nKy/hAITp/ATjwnDgr703FjHbVEzI7QvSaXJ2p
         QyTdp0zZXHzcs2FwlJk3CRhL9nSc2PpT/RhSTvUiCHy+08v8PW0x/v9+MdsBPp3TdHzd
         ujEw==
X-Forwarded-Encrypted: i=1; AHgh+Rqqu5wUBGKiztaUtWDUsXwLes9jlBdxWmPZGgkm/pgBnfOPCkWe2ry7V+pCyAdxJ4W89XHQ9Uu0Nw==@vger.kernel.org
X-Gm-Message-State: AFuF++nIyeOMtSWaQ+xb61ifvSKF2VrWqxZRBXxzdJxD4zixefH/H+Me
	jgjniQ3/KvDg4o4XUE+FYco9Bt3SkIWKyVcOuoe4/PBWfe1nlWX88r9vZiQcW+dVSLZHIijqbhl
	OCyEum9Is/ReaNRQex/hr4uIY7iYz6Lqe/P/f7PpL0aNOItCnOTOCwHTRSmF12A==
X-Gm-Gg: AR+sD10Q9OlFBEx2zzBeX/o3c5/wgqnWmlwr8N367UtGmFBVM5c8R6cH22iqzZL+YJm
	SuDbQwaE4aAZbPtAXzkjKd3RDhQjVk0sA2yIuIkMymamOM8YIUm8ki0jMfn7KVQFRylbFCTH5yY
	vFWL/SFz0PJIShzAvplGRhIkCq+iU6OG241JsTgUABgxXlcVbSNukLSCT4x7l1z0tnQw7hXl3GF
	vnfVsWVxtEQV3WZUNg6CIE90CKR9pKen6ibPd5OU4ZWdc0QgYoy3afj02hiq8n+SyTCijzBDlQT
	yhEivNWKpLwrDtAg3zXB6I32lBN7CF1krP6D+mFJaHOXc4Q1AYT1ylwntUbaxDPByliVwK9Kppl
	+bzAFX6JYjPkeYCZQLsD32ChOrdQLY/xD
X-Received: by 2002:a05:6a00:c96:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-85372ea6666mr29735307b3a.1.1787843792082;
        Thu, 27 Aug 2026 08:16:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:c96:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-85372ea6666mr29735131b3a.1.1787843791473;
        Thu, 27 Aug 2026 08:16:31 -0700 (PDT)
Received: from [192.168.1.100] ([157.35.77.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8535ced205csm2204956b3a.45.2026.08.27.08.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2026 08:16:29 -0700 (PDT)
Message-ID: <863bb5e4-5dfa-4e0d-9824-87ad2b461128@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 20:46:19 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] iio: adc: qcom-spmi-adc5-gen3: Add support for QCOM
 PMIC5 Gen4 ADC
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Amit Kucheria <amitk@kernel.org>,
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
 <20260803011400.1fb6c93a@jic23-huawei>
 <a98d90bd-aa9d-4af3-aa54-3a34300070d4@oss.qualcomm.com>
 <20260807001822.31f7c137@jic23-huawei>
 <f2b2f590-de3e-4f10-b883-92845f59412d@oss.qualcomm.com>
 <20260815030830.24fc732f@jic23-huawei>
 <04990044-45b3-45ca-9e39-925d5bbe62e2@oss.qualcomm.com>
 <20260822003008.0d13144d@jic23-huawei>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <20260822003008.0d13144d@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDEyOCBTYWx0ZWRfX+MSadFFjx7gf
 hQRkfnw2byqPx+GWL6WMqsE3MuMbGlq6Cm9nk4eSpv0f7GSkJZLIXNYkOTpkML8ul6KOqjt0fRA
 GlusaERDlTdzovL09Jg6xuiR/IOmuG51p00QltotWIWDkeyYE4YSTRKERYXTY8BIC74R1hH8WH7
 MfYnHHtrAx+H4Gj7TpjpkbSwTIlCBPZRB9FI6W44Wzc7MxQHTDlKmfMUxITEP9ycWrpZAmScPaw
 JuLKFF1F7B9GwiJxJvIIIbBZ/6hNk+NeYwQJEgVnztwkGUpk7Ysw7WF7qDh6w38u61QmIMR+WhA
 RAutcZY/+mKIzO2V6/CNEIP6gx1W5yIPa+UtZ0CFEd5GGleK4hKCTF25hqiOEspErdwQh47VMnd
 m9SZl22iDfw9Da9VnCxJ+5BVM9UVMXUGFDOxQCZtH9VHVTF4+h5T38wUjd5CFmWTFgHtQdhHKDz
 pashR7iwh61KjzKj+RQ==
X-Authority-Analysis: v=2.4 cv=d5DFDxjE c=1 sm=1 tr=0 ts=6a9054d1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=9si47aXRbTlBVgoeFCxZeg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=p9GNROPkpVv0wmWxth4A:9
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: 2ZtzEeG4jDStcJ3HZlcYTd8tvlgBhvCc
X-Proofpoint-ORIG-GUID: 2ZtzEeG4jDStcJ3HZlcYTd8tvlgBhvCc
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDEyOCBTYWx0ZWRfX6G0PsGQANfM9
 gO0GPANhJ7VHrKc5e+kRo9VV43HZPSxakBGIhjaWF6vGniJX6+BJVq5wcmHfaCV9tPBLDzK9paJ
 /OYx34RpSaCovAd2WTl/12ErYUh6hF4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_06,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270128

Hi Jonathan,

On 8/22/2026 5:00 AM, Jonathan Cameron wrote:
> On Fri, 21 Aug 2026 10:24:39 +0530
> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
> 
>> Hi Jonathan,
>>
>> On 8/15/2026 7:38 AM, Jonathan Cameron wrote:
>>> On Fri, 7 Aug 2026 13:37:02 +0530
>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>   
>>>> Hi Jonathan,
>>>>
>>>> On 8/7/2026 4:48 AM, Jonathan Cameron wrote:  
>>>>> On Thu, 6 Aug 2026 16:22:16 +0530
>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>     
>>>>>> Hi Jonathan,
>>>>>>
>>>>>> On 8/3/2026 5:44 AM, Jonathan Cameron wrote:    
>>>>>>> On Fri, 31 Jul 2026 23:36:15 +0530
>>>>>>> Jishnu Prakash <jishnu.prakash@oss.qualcomm.com> wrote:
>>>>>>>       
>>>>>>>> PMIC5 Gen4 ADC is similar to PMIC5 Gen3 ADC, with several changes made
>>>>>>>> for improved performance, mostly at the hardware level.
>>>>>>>>
>>>>>>>> One significant software change is that ratiometric conversion resolution
>>>>>>>> has been increased from 14 bits to 16 bits, so the maximum value of
>>>>>>>> these measurements needs to be updated for Gen4. Add a new scaling
>>>>>>>> function for thermistor channels which use this type of conversion.
>>>>>>>>
>>>>>>>> In the latest PMIC arbiter version (v8), there can be up to 4 buses
>>>>>>>> under the PMIC arbiter and 32 PMICs under each bus. In order to
>>>>>>>> support communication between ADC on the master PMIC and ADCs on any
>>>>>>>> of the other PMICs, a field of width 2 bits is added for bus index
>>>>>>>> and the bits for SID are extended from 4 to 5 bits, in the SID
>>>>>>>> register. Add support for this.
>>>>>>>>
>>>>>>>> In addition, it is possible that the master PMIC has ADC of one generation
>>>>>>>> and it needs to communicate with another PMIC with ADC of a different
>>>>>>>> generation.      
>>>>>>>
>>>>>>> "Possible" sounds a bit hypothetical.  Can we state this actually happens
>>>>>>> on some devices?      
>>>>>>
>>>>>> Considering existing upstream platforms, this is applicable for SM8750. I'll
>>>>>> mention this in the next version of the series.    
>>>>>
>>>>> What happens on that platform today?  Wrong values?  Should this be treated
>>>>> as a fix rather than a feature?     
>>>>
>>>> There is no issue on that platform right now as ADC channels needing this
>>>> support are not added yet. SM8750 board files only include pmk8550.dtsi, which
>>>> has the top-level Gen3 ADC peripheral and some ADC channels on the same PMIC.
>>>> Gen4 support would be needed only when PMIH0108 ADC channels are added.  
>>>
>>> I guess chances of anyone running an older kernel that the device tree on
>>> that device is low as other critical stuff won't be supported?
>>>
>>> If there is something easy to point to for that, add a note to the patch
>>> description as it justifies this not being a fix.
>>>   
>>
>> Sorry, I did not fully understand your concern here. Are you asking if
>> SM8750 runs on any older kernels and the lack of Gen4 ADC support may be an
>> issue there?
>> This would not happen - let me try explaining with some more details.
>>
>> DT support for SM8750 has been present since kernel version 6.14. At that
>> time, it included pmk8550.dtsi, but this file did not have an ADC peripheral
>> at the time.
>>
>> The Gen3 ADC peripheral was added in pmk8550.dtsi very recently in this series
>> from Neil Armstrong: https://lore.kernel.org/all/20260721-topic-sm8x50-adc5-gen3-v6-0-a507f4a1e537@linaro.org/,
>> and I see this series is present only in linux-next right now.
>>
>> With this change applied, the ADC peripheral with 3 channels of
>> PMK8550 alone (which is Gen3) would appear for SM8750. This
>> would work as its functionality is fully supported by the existing
>> Gen3 driver.
>>
>> Gen4 support is needed only when we add full ADC support for SM8750,
>> meaning when we add channels under all its other PMICs (PMIH0108
>> specifically as it's Gen4.).
>>
>> Would it work if I mention in the commit message that SM8750, added from
>> kernel 6.14 without ADC support initially, would need this mixed-generation
>> support, but only once we add the full ADC support (for all its PMICs)?
> 
> In the ideal world we would assume no coupling between device tree seen
> on a board and the kernel with which a device tree was pushed out.  For
> many devices the delivery path is independent.
> 
> As such we might well see a dt with the new property and a kernel that
> predates it's introduction.  If there is another reason such a kernel
> will simply not boot on that board, then that would be a valid argument
> why we can skip striving for the ideal.  Similarly if the driver
> would not bind for some other reason.  If either of those is the case then
> add a comment to the patch to say so.
> 
> Otherwise, I'd like to see the extra property dt patch (arguably a fix
> but not critical to mark it as such) + a patch for the driver support
> for the new property (also arguably a fix).
> 
> That would cover the older driver and decision on whether to backport
> that could then be made (or left to downstream users).
> 
> On top of that then build the new compatible support.
> 
> Superficially this looks to me like a bit of minor patch reorg so
> I think it is worth doing even if we don't expect to ever run into the
> theoretical problems form a miss match!
> 

Thanks for your clarification, I understand the issue now.

From what I see, SM8750 has been supported since v6.14 and the ADC5 Gen3 driver
since v7.1, so the exceptions you mentioned may not always apply. Someone using
a kernel version >= v7.1 with Gen4 ADC DT support might get incorrect readings for
Gen4 channels, as they are treated like Gen3 channels.

I'll split the series as you suggested, to first add binding and driver support
for the case of Gen4 channels under Gen3 master, and then to add the remaining
binding and driver support for Gen4.

Thanks,
Jishnu

> Thanks
> 
> Jonathan
> 
>>
>> Thanks,
>> Jishnu
>>
>>
>>> Thanks,
>>>
>>> Jonathan  
>>
> 

