Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF9639B963
	for <linux-pm@vger.kernel.org>; Mon,  4 May 2026 15:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777908297; cv=none; b=uxpf3l3lJ5Z2YMdb9izXzB90LTgyYollchGTJnbG3uVB0xnWvJ3PxXl0KsKNylZTH5caKQXyOBCyXBo1nS8rHT9PkzQpsnP5Wu9m0KZSJbNmsWMmtsRp2eh1CHP0joacn0Rc+Twu4v1PbjVlYYHKwCIalctYus7wIN7Z7NBW9Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777908297; c=relaxed/simple;
	bh=24HMZQ9Ms/gngLZDovaC0SQfcgVkxbPvUEiAJQvC/nw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvAC/kkdX0RkDgAevqQRh0HCaiS0aLRSmy54x3wqi3mbTHjWyvZmSOGgwg77+53DNyQ2trYNjRC6X1mHiShWo8+HDSk8321UFCByDph+rZ4YidtgpeEFMlmvZhMUPVFKoc0UkM/ISkCxJ/xd5GPcEHykCXf4zx7pfxkG2RY4Cr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lcb9BiGo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=g++7TpOb; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lcb9BiGo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g++7TpOb"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644FOt951346410
	for <linux-pm@vger.kernel.org>; Mon, 4 May 2026 15:24:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hf6N3xo6cjBW+8Z3N+x8sxSpWyuJxm0UgHE+MChhex4=; b=lcb9BiGo++zVI34r
	d6uFn6mGXX62p9s8ZK77g7KT+CVdcqmgMtM1IyiTqkSo+uZdY+Nlkuj7DA6D+ZSZ
	pbVPgJmZPKK2DefzmLaSkWxwlYpvcTN3PpF/321pUZ7NqnqoD1NcnviUMqTsxiZt
	spoE/9Yyp/QmyZMwM5aec/+FR5X7WYJ9kdfugRR7x8tgGEdw6SC/3rS6+LRbcrCl
	xDu7zEfTFZERb6feWZ4dzEfgHCiIR1QRsqjVm5uCNzogWOTkltctr5QCNI5JxYpj
	Uyw1lqexFxlfECTeNmwJpo7G6hgUggXyV6NeUdu6Z0uWXYODBSiOX0tHXVGO7zyK
	1XWwuA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx2x800q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 15:24:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2a90510a6d1so30379225ad.0
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 08:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777908295; x=1778513095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hf6N3xo6cjBW+8Z3N+x8sxSpWyuJxm0UgHE+MChhex4=;
        b=g++7TpObeSjaMXOJT+7mA4/LFlwkJHAKmZdlTrrZQRTR98YJQ99CEHm/1NJm8/5U8g
         hVzK7tRo0SFjpmAF24S78sB74KCP4Y8QLSfg1gv6B6wW89yVpPj/eJEAo/njpjWJyp+I
         EdX/q6lmvJW3I6MH5WWK412/RRvwdeBT3I/QI7hF+NsDJLPssGFan8QRk6gpmlbtkFU7
         QA2kz1QUvvSXHDxtXtwbuuuOhIIWgnm4KxTeJEnwbDfoUZmcW6zubVta1inF34iGgbJ9
         kdQaEDd6QvlC81nBvE7ghbKzvDFmab5BRIVkWmVmSn5slEkUOMKG/TuEWPdBg1E6twAj
         +BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777908295; x=1778513095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf6N3xo6cjBW+8Z3N+x8sxSpWyuJxm0UgHE+MChhex4=;
        b=RxKiDiranqvXsZcCUAY7Z4EJcxsZs+l6LMHzaiD+lALKsgVzXC2tjIIz0slFrVynlC
         NOUvexc9w6Ui7B28rN4SfFZwyMfX+7I/VetKKVVwcs11vujddf5hzsXiRlDlyO3u9IrH
         jUBgqjF1O6Rj2WwtbETjYF79ZGffgVA2uFVN+y01Uu/8dWueW6US2FlB3y7K2VGbfvj5
         JGTYsa5Hq2EEpJS8dAcde9S8QfmErHC+0bFwnI33TsZver9Ch8vJqrjB/rZHgrfOXZcs
         1a6KaZSB6D2WUvy8vJZpmOlp5ztimhwn7bftVYo1SbRpUbXFaVzZ+wwt/PRTjnLNTdV3
         mC6A==
X-Forwarded-Encrypted: i=1; AFNElJ9gNyrtvDxB3tLP2591EXJmNcmw/+6r4lrApJ4rW+6tZNiSOOBIWa5r9ZC3DtwwmQDZ+zeOmOwEww==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxFxJwyqpcHKqJ+HQPm/taEclTokzXUcvkY2N1e36SkhZYa66
	flz4+qEhdETQ706ohF/SiQnTBDr+OSDZXj//ZE7rLUoEZijRUKtvBT8e0ym2JN545LVVf7TcD42
	KxsmjbQqVHiOc73g3EsKpEb+RTXx1eq4XQUKGHeA3/2cALR1gC1aNOf2Q6YOFYQ==
X-Gm-Gg: AeBDieuQWSuKPNVSEYNZ05fhR90/4V0+IXGXFRPCPgoJ9Z6H66LFjDZOgAgVJ8rTS1L
	pxlOf5lT4gLsi3RtoT3+nBQapyy4VQrMkM8wWCkuv+8r0kCqt1X1Syduegsdex9NBDw6Q+P1mpi
	aJca5WdBUDSmb8rcBhu87hhhc+/z80+rQQeCwtmV2AT5imPgJXl7tWcyQO7mzz+rn1e4yUhl7e+
	75MPh4a1an0qTRhfuINo221FAOs/0CN1Z4JdVRJsbjeofz/9BBeaZUyh7jG3eeKX11DKA24mhN8
	oRwTQFtlP5hmxbkN0HGv0ZZo+zCf1obsCCT0AJudcr5CvJxJvTbh//HI2qKK5OzP3LFisqHbJRy
	JRvh85z7iZLlMC46yQ7H2ur8lfwrh7fs3tUv8XCQ22b6HYfz1A+NxVhEUOM28KyNfir9giHRNwW
	HAJzr3VYy2iLbQbxxGnsMQzCtJlhQ=
X-Received: by 2002:a17:902:f788:b0:2ba:21c2:d6cb with SMTP id d9443c01a7336-2ba21c2d8e1mr36393885ad.16.1777908294681;
        Mon, 04 May 2026 08:24:54 -0700 (PDT)
X-Received: by 2002:a17:902:f788:b0:2ba:21c2:d6cb with SMTP id d9443c01a7336-2ba21c2d8e1mr36393345ad.16.1777908294018;
        Mon, 04 May 2026 08:24:54 -0700 (PDT)
Received: from ?IPV6:2409:4070:2111:4f3e:25a4:b9da:3138:5b7c? ([2409:4070:2111:4f3e:25a4:b9da:3138:5b7c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9caa7ee38sm104462535ad.16.2026.05.04.08.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 08:24:53 -0700 (PDT)
Message-ID: <a0b4db09-2656-429f-8ebf-b8cc10c054a3@oss.qualcomm.com>
Date: Mon, 4 May 2026 20:54:41 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 4/4] thermal: qcom: add support for PMIC5 Gen3 ADC
 thermal monitoring
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
 <20260130115421.2197892-5-jishnu.prakash@oss.qualcomm.com>
 <addDTiI8MB2b_AzJ@mai.linaro.org>
 <12d683aa-44c2-4e2d-8459-78ba9f2ab61e@oss.qualcomm.com>
 <f46ef4af-1c05-4473-9226-901d3393ea89@oss.qualcomm.com>
 <7e619cef-ed08-4454-905c-05ab0939d60e@oss.qualcomm.com>
 <e1845fc5-254e-4481-b783-5e631d4e506b@oss.qualcomm.com>
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <e1845fc5-254e-4481-b783-5e631d4e506b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=U9eiy+ru c=1 sm=1 tr=0 ts=69f8ba47 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=uLTcNiWXy3B0Tm635-QA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: szdUF81FDnDBPFy1buaYsjFWdUZ2Q_MU
X-Proofpoint-GUID: szdUF81FDnDBPFy1buaYsjFWdUZ2Q_MU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE1NCBTYWx0ZWRfX7al69+TTdnSi
 K5sZuau6Y8NccM+UImd0vdAnjFZN2EEY0UVBVP/2stjz5bBILRHN7+P3HkkcCeLIw05VbNRI7K3
 uQ0LoHH2ml5lUaNs1F0JEoVE5UUam/r9YgPYaxrwZt+D6xT/zYx06dS9fRkVOt8A7JTBgfrQKWZ
 uQzc4peaIjiLgw8IhhgM2TMEj8rOQpx6BQ9LUfnL0oqEVTs71yitpd8tTexZP7qG7irjCggZd+A
 OGpO+nYHah69389ctsNmRLnS/f2gT1gvFa+rUiAVICAWo0Ld8u3ixPBdsOe3ZFTMo4HfSlVhbBa
 fRg1syQGn174kQcELCFguj9cI8NmT5jhQTsXS44tQilEeq9qgWlkfj3RosLMF0UdHKlLgBvtXql
 qnwH92bhZR4wabB0IEyFPwn0lGSvAQ+D/VjV2JyWAx+H1yDfZ01P54waVpBIgAmtqWOZr9ogwUg
 B1xxegtnu5uP1N0YPKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040154

Hi Daniel,

On 4/27/2026 1:48 PM, Daniel Lezcano wrote:
> 
> Hi Jishnu,
> 
> On 4/25/26 12:37, Jishnu Prakash wrote:
>> Hi Daniel,
> 
> [ ... ]
> 
> 

...

> 
> [ ... ]
> 
>>> [ ... ]
>>>
>>>>>> +    dev_dbg(adc_tm5->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
>>>>>> +        prop->common_props.label, low_temp, high_temp);
>>>>>> +
>>>>>> +    guard(adc5_gen3)(adc_tm5);
>>>>>> +    if (high_temp == INT_MAX && low_temp == -INT_MAX)
>>>>>> +        return adc_tm5_gen3_disable_channel(prop);
>>>>>
>>>>> Why disable the channel instead of returning an errno ?
>>>>>
>>>>
>>>> This is the convention we follow in our existing ADC_TM driver at
>>>> drivers/thermal/qcom/qcom-spmi-adc-tm5.c. If both upper and lower
>>>> thresholds are meant to be disabled, we disable the channel fully
>>>> in HW to save some power and it can be enabled later if this API
>>>> is called for it with valid thresholds.
>>>>
>>>> Is it considered invalid in the thermal framework to try to disable
>>>> both thresholds? Should I both disable the channel and return some
>>>> error from here?
>>>
>>> Well, if the channel is disabled, then the temperature sensor of the thermal zone is disabled, consequently the thermal zone is disabled from a HW POV but enabled from the kernel POV.
>>>
>>> Why not add the 'change_mode' ops and then disable the thermal zone (+ pm_runtime) ?
>>>
>>
>> I have a doubt about this part - if the thermal framework sends threshold values
>> of (-INT_MAX, INT_MAX) in the .set_trips callback, doesn't it mean that the
>> framework is already trying to disable the thermal sensor?
> 
> No, let me clarify this:
> 
>  * the thermal thresholds are set by the userspace to get notification when a temperature is crossing the way up or/and down a specified limit. Thresholds can be deleted, added, flushed, etc ...
> 
>  * the thermal trips are specified by the firmware and should not be changed even if I agree there are the writable trip points which IMO we can consider for debug purpose
> 
> If you specify a trip/threshold point with min=-INT_MAX and max=INT_MAX, semantically speaking it is correct but in practice these temperatures won't be reached so it is like the trip point is disabled but it is a side effect.
> 
> A trip point is a property of a thermal zone.
> 
> A thermal sensor is represented by a thermal zone.
> 
> A thermal zone can be enabled without trip points or thresholds. The userspace is still able to read a temperature through netlink or sysfs.
> 

Thanks for your explanation, I understand the convention now.

>> Or does it just mean threshold monitoring functionality can be disabled for now,
>> but other functionality like temperature reading is still expected to work?
>>
>> Please note that adc_tm5_gen3_disable_channel() only disables the threshold
>> monitoring and interrupt generation functionality - the get_temp() call to read
>> temperature will still work.
> 
> Above you stated we receive a notification when the conversion is finished. So how do you read the temperature if there is no interrupt telling to read the converted value ?
> 

I think you are talking about the immediate conversion here, which is called in get_temp() -
let me try explaining with an example, to avoid missing anything again.

On an ADC SDAM, we have 8 channels which can be used for either immediate read or
ADC_TM functionality. So by convention, we reserve the first channel of the first
SDAM for *all* immediate reads and use all the remaining channels for ADC_TM.

So if we have SDAM 0 and SDAM 1 used for ADC, channel 0 of SDAM 0 is used for all
immediate conversions and channels 1-7 of SDAM 0 and channels 0-7 of SDAM 1 can
all be used for ADC_TM functionality.

Now if channel 5 of SDAM 0 is used to monitor the xo-therm ADC thermistor and we call
adc_tm5_gen3_disable_channel() on it, threshold monitoring and interrupt generation
from channel 5 alone would be stopped, but it would not change for other channels.

So if we wanted to read the xo-therm thermistor's temperature through the get_temp()
callback, it would still work, as calling get_temp() results in an immediate
conversion request done through channel 0 of SDAM 0 to read this thermistor's temperature.


>> Perhaps I should not have used the wording
>> "disable the channel" above, as calling adc_tm5_gen3_disable_channel() is not
>> exactly the same as fully disabling the thermal zone.
>>
>> Please let me know if any change is needed there - should I return any error
>> after calling adc_tm5_gen3_disable_channel() ?
> 
> I understand, your point. Perhaps just put it apart and address it later as an optimization when the driver is merged and everything is clarified.
> 

OK, I'll do as you suggest. For now, I'll just drop this special case check:

        if (high_temp == INT_MAX && low_temp == -INT_MAX)

and try adding it in a separate change later.

Thanks,
Jishnu


>>> [ ... ]
>>>
>>>>>> +    /*
>>>>>> +     * Skipping first SDAM IRQ as it is requested in parent driver.
>>>>>> +     * If there is a TM violation on that IRQ, the parent driver calls
>>>>>> +     * the notifier (adctm_event_handler) exposed from this driver to handle it.
>>>>>> +     */
>>>>>> +    for (i = 1; i < adc_tm5->dev_data->num_sdams; i++) {
>>>>>> +        ret = devm_request_threaded_irq(dev,
>>>>>> +                        adc_tm5->dev_data->base[i].irq,
>>>>>> +                        NULL, adctm5_gen3_isr, IRQF_ONESHOT,
>>>>>> +                        adc_tm5->dev_data->base[i].irq_name,
>>>>>> +                        adc_tm5);
>>>>>
>>>>> The threaded interrupts set the isr in a thread and from the thread
>>>>> handling the event, there is a work queue scheduled. Why not use the
>>>>> top and bottom halves of the threaded interrupt ? Hopefully you should
>>>>> be able to remove the lock.
>>>>
>>>> Yes, I can use the top and bottom halves of the threaded interrupt as you
>>>> suggested. But what exactly do you mean by removing the lock?
>>>>
>>>> If you meant the mutex lock used in this driver, we cannot remove that.
>>>> This is because the ADC_TM driver needs to write into several registers
>>>> shared with the main ADC driver for setting new thresholds, so we
>>>> have to share a mutex between the drivers to prevent concurrency issues.
>>>
>>> When using a workqueue tampering with registers while an interrupt handler is doing the same, the lock is needed.
>>>
>>> But if the workqueue is replaced by threaded interrupt, the lock *may* not be needed because the design may prevent race conditions.
>>>
>>> That may be not true in this case, I did not investigate deeper in the code to figure it out. Let's see the next version
>>>
>>
>> I think a lock will not be needed with the change I planned, but you
>> can judge it in the next version.
> 
> Sure, thanks
> 
>   -- Daniel

