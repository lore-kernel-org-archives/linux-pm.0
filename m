Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1F53537D4
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777113479; cv=none; b=Zijw3R0FkqBvfoDZ8dJuEMTHrSq3VNCH770OufYA08seuITS65kdBOG2txWW5hHDaL2RuKVKP+jPz6TNO4hITIFwpybK6YNr98IEwJbbMGCcf1E8AdipB6UharlP3ryiyr/u7jsa9+Mne+xlwE4E3i3KM1QwBHvliXmzECz5y2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777113479; c=relaxed/simple;
	bh=hIWO3xsFueLuE07chwS/HdIA+QZtOhP45cjCo+Trttk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lgp54CC+37iOCKZXu6ZQ1q68+VxYeczgS0YI5oMuk/V1eq/BEM0WGMYxiBYWmjkBRAQvMrzpH/fGEF+rk01J8RRuXz3omN81vikA/MCGeSbol3HBK5ZhcMHLDUf0goGk2GzznbOLaMHMSNusDOAEEg/atWbFZheiwPMOppAIDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=goX/mQHt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FaPL66+o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="goX/mQHt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FaPL66+o"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63P7M0vw2056781
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 10:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wSDt1S1a3dmf5cPvvpVEpChdYIhaznxbJLwuGc74L9E=; b=goX/mQHtUdIMrdW9
	0tAfW8Iw2Mdn9h8jiJMIomfqVre8YtCc85gw1kkGHf8aNL0d/3CKn8tfEzp1z8/n
	Df7i8NVvZpKkyaD95mTTP02Frtj2bbm8LBnmHFl6oW4cUvAnFtraIsv9qZC77I2S
	J3I9Y94EC8GT4OcdCCgN09vlLJ2rV+uyTb9chDS2w0ODUmLNV99Z7O6j+vd5vuie
	vAe9FQNN0dOOXXuFJNmcqPKza6UFGiHUixsS+9Vl6qFhDAFlrEpsTnr5vfNZjG86
	J4MPodjN8J5n22unf+trNSV0sV+rqQtrXDD3xwJ0rKJDuA8X5NMXuq68y1EPkX6Z
	4fYUVg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnqt8qnb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 10:37:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e6ee9444so92266835ad.1
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777113476; x=1777718276; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wSDt1S1a3dmf5cPvvpVEpChdYIhaznxbJLwuGc74L9E=;
        b=FaPL66+oLPdfRY/d2XvT8NtnyfMQwFxWsWAgR94uj/6QTDwhHQm/wvlYjL6wMyZBef
         wh/XZEetErWYGwirR/SXL4YVmVzb38fNPMumPCLp8nLZHwzhhpRNbj/5G4wEoHUo/4V9
         d2SuEj6WWbESVofk2ijYsy7gi7+ypzzrOm0/+Ug04mgq88qIvyJeW4VEt7MmVSUUuxJg
         S73OZ8kDzvyoAtyyOGfl65UXjQLP2IeLqyXOSiDGSFWQad3oTSuiSRzn+p1b+DGbW4nN
         0wCTXWjbXL24Qv9CGd/K23nFM69mTBUhf7Q3GEDVHE/2hmFV42stSQpH5RfZw6i5N2Ho
         9l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777113476; x=1777718276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wSDt1S1a3dmf5cPvvpVEpChdYIhaznxbJLwuGc74L9E=;
        b=fw8hKSbgma/sU2mZQVmOL43vH0tCnhZLKw95s2ZrC4Ca9bHtKjc80dZany887nGqSJ
         G1Rz3XnOGgCSUCY45uRZuKci9yKxQMBU+ScKLk8OEDS//CCTHOGW09kEpTVF+DHZ1pQ8
         hGRG+jk25zveV8Ev5n+EbgtYucOdCrfiJI5ENacmZ56jqgNRU/Z6YdaUyje0Rod7KObP
         aH3yLvRMGJDVLrF5MB6o6Tlh9GWcxbxmrqj0tJne4j+eWyAkW+H9osqm7OhDjUvLnykk
         LdB4HUuMQGxPnMRFe+8dVOZmwDO29glXzQoZ1sDkl9weD/w+5xL95VgBsmH1xnCHGf2E
         QQJg==
X-Forwarded-Encrypted: i=1; AFNElJ+lGUaqQR+NFquMmb/WbthHNF2wpF+xWrzkJXP8vFDxGtGe/bpwA4wPCjQ6Hmdo/MfgC2ZTpxVWhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7IeiSbkm8uJeSGeIVf5vRBouy8Nf0UZ/F2AVOAc9/BKu0rkP3
	c5AHg41+64xyLSr7G4E/EaIVQ/NzwvUPkTiCM2hzjfclHM+kpaDX1RHRFz7B1jJaSFkI3RLnc0L
	tfQnvWA/Ofu8INqGz9TmCM02N6QmCtMTsadj6orgo8M+ykYctcVESdc5M/cS3Cg==
X-Gm-Gg: AeBDietFO0fW5WiZAlQySArhUBnUDSnVTcf2G7lvj2pMCMHpz9q0p0OfN8s0EXDn+7m
	WuiYVC6QIu3EJWuMVeDX7GL7B32ynLB6Wl1fGGQ7pnhyhKVOBBJ6sCXqeTToLIHyvyRlifQ0p85
	3IU46AQqe/pf32IRrlI9qxmunMjoFEkDvhyoi1hIPW4QrvSu1nUpHj/GPRRjlf49O+8P33SJXju
	p31+Xnaz3F1GRKVfTVWgERd/IiAvmKoMp54zyBT1zB6lGpnc2IGA7J2sRqzwtLI4fqsa2jFue3p
	2A1t1OQIVO1RTL2JZnH8DGuyjJ0hP9LM0T6rK5pEFX1D+a7DVezSOpRSUPwLifz9WIZSb0l9iW7
	GVIryU808pk+k4k19cEKIR/lRfY+OltBKE7zheCRn8DGo8FcSYlwPjfiExy0MZ42a
X-Received: by 2002:a17:902:9002:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2b5f9e7bb41mr207335415ad.14.1777113475508;
        Sat, 25 Apr 2026 03:37:55 -0700 (PDT)
X-Received: by 2002:a17:902:9002:b0:2b0:91e6:bc18 with SMTP id d9443c01a7336-2b5f9e7bb41mr207335045ad.14.1777113474836;
        Sat, 25 Apr 2026 03:37:54 -0700 (PDT)
Received: from [10.216.33.139] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff390sm246035275ad.9.2026.04.25.03.37.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2026 03:37:54 -0700 (PDT)
Message-ID: <7e619cef-ed08-4454-905c-05ab0939d60e@oss.qualcomm.com>
Date: Sat, 25 Apr 2026 16:07:41 +0530
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
Content-Language: en-US
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
In-Reply-To: <f46ef4af-1c05-4473-9226-901d3393ea89@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J42aKgnS c=1 sm=1 tr=0 ts=69ec9984 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=N3BaCdbXddXG3PYp0CMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: T8nX6i_WstOQa8IL8B-QmfXKJ6ksPXgj
X-Proofpoint-GUID: T8nX6i_WstOQa8IL8B-QmfXKJ6ksPXgj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDEwNSBTYWx0ZWRfXz4TpMBlXCoiQ
 U3k3ftsbRt9MX6swQuRqD7nvp3BHfD0YGrQYRJeZ8fA0yxO9a2BKVXK5bfV2jUmaVQp9tgVW+7h
 J97+rsvbg2o7UP2EON+/w0ARBsgO4SulwIrlkXCESW4fPBXTMsdjqa7r15d0GJ3CKz7ES5pBghw
 uMF4pjSFIKRjgj0LFW9zC3zSJp5x1SSm9y9vmK3NdtPkeZJnpuyhEIqpv5qdv2wQDPMPqw1QuF2
 9cyBri4K5KYnthgCcuGre9Q9AcSUunFTYklUx8NoQXkR2fvbAoHfd8zyPYVyc4Mb3A8mzZJArBE
 Nb/Z8uwDE5rr/G+c+NW3/JsQwrQ8fI4E2AJ4hQKinzl9lb2cjGfgkLhr6dXfuepId3lu41EY0Z/
 4lB8zIAIDinAX6ZGlz0MC4zCmVLpC7gaTO8VESwyPaRBr7m4Xm+TkYfEcQpDrpE0u420NBB3Qq1
 gNUSWf0TILQenNbzvRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250105

Hi Daniel,

On 4/17/2026 2:42 AM, Daniel Lezcano wrote:
> On 4/16/26 10:05, Jishnu Prakash wrote:
>> Hi Daniel,
>>
>> On 4/9/2026 11:42 AM, Daniel Lezcano wrote:
>>> On Fri, Jan 30, 2026 at 05:24:21PM +0530, Jishnu Prakash wrote:
>>>> Add support for ADC_TM part of PMIC5 Gen3.
>>>>
>>>> This is an auxiliary driver under the Gen3 ADC driver, which implements the
>>>> threshold setting and interrupt generating functionalities of QCOM ADC_TM
>>>> drivers, used to support thermal trip points.
>>>>
>>>> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
>>
>> ...
>>
>>>> +
>>>> +static irqreturn_t adctm5_gen3_isr(int irq, void *dev_id)
>>>> +{
>>>> +    struct adc_tm5_gen3_chip *adc_tm5 = dev_id;
>>>> +    int ret, sdam_num;
>>>> +    u8 tm_status[2];
>>>> +    u8 status, val;
>>>> +
>>>> +    sdam_num = get_sdam_from_irq(adc_tm5, irq);
>>>> +    if (sdam_num < 0) {
>>>> +        dev_err(adc_tm5->dev, "adc irq %d not associated with an sdam\n",
>>>> +            irq);
>>>> +        return IRQ_HANDLED;
>>>> +    }
>>>> +
>>>> +    ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_STATUS1,
>>>> +                 &status, sizeof(status));
>>>> +    if (ret) {
>>>> +        dev_err(adc_tm5->dev, "adc read status1 failed with %d\n", ret);
>>>> +        return IRQ_HANDLED;
>>>> +    }
>>>> +
>>>> +    if (status & ADC5_GEN3_STATUS1_CONV_FAULT) {
>>>> +        dev_err_ratelimited(adc_tm5->dev,
>>>> +                    "Unexpected conversion fault, status:%#x\n",
>>>> +                    status);
>>>> +        val = ADC5_GEN3_CONV_ERR_CLR_REQ;
>>>> +        adc5_gen3_status_clear(adc_tm5->dev_data, sdam_num,
>>>> +                       ADC5_GEN3_CONV_ERR_CLR, &val, 1);
>>>> +        return IRQ_HANDLED;
>>>> +    }
>>>> +
>>>> +    ret = adc5_gen3_read(adc_tm5->dev_data, sdam_num, ADC5_GEN3_TM_HIGH_STS,
>>>> +                 tm_status, sizeof(tm_status));
>>>> +    if (ret) {
>>>> +        dev_err(adc_tm5->dev, "adc read TM status failed with %d\n", ret);
>>>> +        return IRQ_HANDLED;
>>>> +    }
>>>> +
>>>> +    if (tm_status[0] || tm_status[1])
>>>> +        schedule_work(&adc_tm5->tm_handler_work);
>>>> +
>>>> +    dev_dbg(adc_tm5->dev, "Interrupt status:%#x, high:%#x, low:%#x\n",
>>>> +        status, tm_status[0], tm_status[1]);
>>>> +
>>>> +    return IRQ_HANDLED;
>>>
>>> This ISR routine should be revisited:
>>>
>>>   - no error message inside
>>
>> I'll drop all the error messages, but does that also include the debug print at the end?
>> In addition, the print for conversion fault is ratelimited and may be useful as it
>> indicates a possible HW issue, can I keep that?
> 
> It is not a good practice to put an error message in the ISR. If the conversion fails, then the thread blocked on the read will timeout and then show a message.
> 

OK, I'll drop all the prints in the ISR.

>>>   - use a shared interrupt to split what is handled by the ADC and the
>>>      TM drivers
>>
>> I'll make the required updates in the main ADC driver and this driver to share the first
>> SDAM's interrupt.
>>
>>>
>>>   - do not return IRQ_HANDLED in case of error (cf. irqreturn.h doc)
>>>
>>
>> I'll replace IRQ_HANDLED with IRQ_NONE at places where errors are returned.
>> But in the case of conversion fault, I think returning IRQ_HANDLED may be
>> more appropriate because we do handle it by clearing the status, to
>> allow subsequent conversion requests to be sent.
>>
>> What do you think, is this fine?
> 
> It is a good point.
> 
> Actually, if get_sdam_from_irq() or adc5_gen3_read() fail, they will return without clearing the interrupt flag, so we should potentially end up in an infinite loop.
> 

I went over this discussion and the code again and I need to explain a few things.

First, please note that individual PMIC drivers do not handle interrupt clearing by
themselves - they are under the SPMI PMIC arbiter (drivers/spmi/spmi-pmic-arb.c),
which is an interrupt controller and the arbiter driver handles IRQ clearing internally
for all the PMIC drivers under it. So we won't be clearing the interrupt explicitly here.

> So the status should be cleared at the end with IRQ_HANDLED. IRQ_NONE returned if it is for another subsystem.
> 

Maybe my explanation above wasn't sufficiently detailed - the "status" I mentioned
above is not related to the interrupt by itself, it is just the ADC's status register
reading. If it indicates an ADC conversion fault, the fault has to be cleared by
calling the function adc5_gen3_status_clear() before we can make subsequent conversion
requests (like for .set_trips) on the ADC.


There are 3 main reasons for which the Gen3 ADC interrupt may fire:

1. End of conversion for immediate conversion request (handled in main ADC driver)
2. Threshold violation for TM conversions (handled in this auxiliary driver)
3. Conversion fault (handled in both drivers)


I think it would make the most sense if I make changes so that the ISRs
(of both main and aux driver) return IRQ_HANDLED only when any of the above
3 cases are detected and they return IRQ_NONE in case of errors or when the
interrupt is confirmed to be for the other driver.

Does this sound fine?


> If you think there can be a significant number of errors in the handler may be you should add statistics but later in an additional series if it makes sense.
> 

I think conversion and register read errors are rare, so this may not be needed right now.

> [ ... ]
> 
>>>> +    adc_tm5 = prop->chip;
>>>> +
>>>> +    if (prop->last_temp_set) {
>>>> +        pr_debug("last_temp: %d\n", prop->last_temp);
>>>> +        prop->last_temp_set = false;
>>>> +        *temp = prop->last_temp;
>>>> +        return 0;
>>>> +    }
>>>
>>> Why do you need to do that?
>>>
>>> The temperature should reflect the current situation even if the
>>> reading was triggered by a thermal trip violation.
>>>
>>
>> This logic is needed to handle a corner case issue we have seen earlier.
>> In this case, the ADC_TM threshold violation interrupt gets triggered ,
>> but when get_temp() is subsequently called by the thermal framework, the
>> temperature has fluctuated and the value read now lies within the thresholds,
>> so the thresholds do not get updated by the thermal framework and the violation
>> interrupts get repeated several times, until there is a get_temp() call
>> which returns a temperature outside the threshold range.
> 
> Oh, that's clearly an issue with the thermal framework, not the driver.
> 
>> In order to avoid this issue, when the interrupt handler runs, we find the actual
>> temperature read in ADC_TM that led to threshold violation by reading the ADC_TM
>> data registers and we cache it and return it when get_temp() is called in the flow
>> of thermal_zone_device_update(). Any subsequent calls to get_temp() would
>> return the actual channel temperature at the time.
>>
>> This is only done to avoid delaying thermal mitigation due to temperature
>> fluctuations. Do you think this needs to be changed?
> 
> I think it is an interesting problem certainly impacting all thermal sensors. It should be fixed in the thermal framework itself if possible. Just drop this portion of code and let's handle that correctly in the thermal framework.
> 

Alright, I'll remove the check for last_temp_set and just get the
actual temperature at this point.

> [ ... ]
> 
>>>> +    dev_dbg(adc_tm5->dev, "channel:%s, low_temp(mdegC):%d, high_temp(mdegC):%d\n",
>>>> +        prop->common_props.label, low_temp, high_temp);
>>>> +
>>>> +    guard(adc5_gen3)(adc_tm5);
>>>> +    if (high_temp == INT_MAX && low_temp == -INT_MAX)
>>>> +        return adc_tm5_gen3_disable_channel(prop);
>>>
>>> Why disable the channel instead of returning an errno ?
>>>
>>
>> This is the convention we follow in our existing ADC_TM driver at
>> drivers/thermal/qcom/qcom-spmi-adc-tm5.c. If both upper and lower
>> thresholds are meant to be disabled, we disable the channel fully
>> in HW to save some power and it can be enabled later if this API
>> is called for it with valid thresholds.
>>
>> Is it considered invalid in the thermal framework to try to disable
>> both thresholds? Should I both disable the channel and return some
>> error from here?
> 
> Well, if the channel is disabled, then the temperature sensor of the thermal zone is disabled, consequently the thermal zone is disabled from a HW POV but enabled from the kernel POV.
> 
> Why not add the 'change_mode' ops and then disable the thermal zone (+ pm_runtime) ?
> 

I have a doubt about this part - if the thermal framework sends threshold values
of (-INT_MAX, INT_MAX) in the .set_trips callback, doesn't it mean that the
framework is already trying to disable the thermal sensor? 

Or does it just mean threshold monitoring functionality can be disabled for now,
but other functionality like temperature reading is still expected to work?

Please note that adc_tm5_gen3_disable_channel() only disables the threshold
monitoring and interrupt generation functionality - the get_temp() call to read
temperature will still work. Perhaps I should not have used the wording
"disable the channel" above, as calling adc_tm5_gen3_disable_channel() is not
exactly the same as fully disabling the thermal zone.

Please let me know if any change is needed there - should I return any error
after calling adc_tm5_gen3_disable_channel() ?


> [ ... ]
> 
>>>> +    /*
>>>> +     * Skipping first SDAM IRQ as it is requested in parent driver.
>>>> +     * If there is a TM violation on that IRQ, the parent driver calls
>>>> +     * the notifier (adctm_event_handler) exposed from this driver to handle it.
>>>> +     */
>>>> +    for (i = 1; i < adc_tm5->dev_data->num_sdams; i++) {
>>>> +        ret = devm_request_threaded_irq(dev,
>>>> +                        adc_tm5->dev_data->base[i].irq,
>>>> +                        NULL, adctm5_gen3_isr, IRQF_ONESHOT,
>>>> +                        adc_tm5->dev_data->base[i].irq_name,
>>>> +                        adc_tm5);
>>>
>>> The threaded interrupts set the isr in a thread and from the thread
>>> handling the event, there is a work queue scheduled. Why not use the
>>> top and bottom halves of the threaded interrupt ? Hopefully you should
>>> be able to remove the lock.
>>
>> Yes, I can use the top and bottom halves of the threaded interrupt as you
>> suggested. But what exactly do you mean by removing the lock?
>>
>> If you meant the mutex lock used in this driver, we cannot remove that.
>> This is because the ADC_TM driver needs to write into several registers
>> shared with the main ADC driver for setting new thresholds, so we
>> have to share a mutex between the drivers to prevent concurrency issues.
> 
> When using a workqueue tampering with registers while an interrupt handler is doing the same, the lock is needed.
> 
> But if the workqueue is replaced by threaded interrupt, the lock *may* not be needed because the design may prevent race conditions.
> 
> That may be not true in this case, I did not investigate deeper in the code to figure it out. Let's see the next version
> 

I think a lock will not be needed with the change I planned, but you
can judge it in the next version.

Thanks,
Jishnu


>> I'll address all your other comments too in the next version of this patch.
> 
> Thanks
> 
>   -- Daniel
> 
> 

