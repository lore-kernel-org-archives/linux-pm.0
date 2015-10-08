From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH v2 2/9] thermal: qcom: tsens-8916: Add support for 8916 family of SoCs
Date: Thu, 08 Oct 2015 15:32:13 +0100
Message-ID: <9hhk2qxfn2q.fsf@e105922-lin.cambridge.arm.com>
References: <1442384603-26053-1-git-send-email-rnayak@codeaurora.org>
	<1442384603-26053-3-git-send-email-rnayak@codeaurora.org>
	<9hh4miutr21.fsf@e105922-lin.cambridge.arm.com>
	<55FF8761.9010808@codeaurora.org> <5615F99C.5000004@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:59977 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756191AbbJHOcs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Oct 2015 10:32:48 -0400
In-Reply-To: <5615F99C.5000004@codeaurora.org> (Rajendra Nayak's message of
	"Thu, 08 Oct 2015 10:35:32 +0530")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com, sboyd@codeaurora.org, srinivas.kandagatla@linaro.org, nrajan@codeaurora.org, lina.iyer@linaro.org

Rajendra Nayak <rnayak@codeaurora.org> writes:

> On 09/21/2015 09:58 AM, Rajendra Nayak wrote:
>> []..
>> 
>>>> +static inline int code_to_degc(u32 adc_code, const struct tsens_sensor *s)
>>>> +{
>>>> +    int degc, num, den;
>>>> +
>>>> +    num = (adc_code * SLOPE_FACTOR) - s->offset;
>>>> +    den = s->slope;
>>>> +
>>>> +    if (num > 0)
>>>> +        degc = num + (den / 2);
>>>> +    else if (num < 0)
>>>> +        degc = num - (den / 2);
>>>> +    else
>>>> +        degc = num;
>>>> +
>>>> +    degc /= den;
>>>> +
>>>> +    return degc;
>>>> +}
>>>> +
>>>> +int get_temp_common(struct tsens_device *tmdev, int id, int *temp)
>>>> +{
>>>> +    struct tsens_sensor *s = &tmdev->sensor[id];
>>>> +    u32 code;
>>>> +    unsigned int sensor_addr;
>>>> +    int last_temp = 0, ret;
>>>> +
>>>> +    sensor_addr = S0_ST_ADDR + s->hw_id * SN_ADDR_OFFSET;
>>>> +    ret = regmap_read(tmdev->map, sensor_addr, &code);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +    last_temp = code & SN_ST_TEMP_MASK;
>>>> +
>>>> +    *temp = code_to_degc(last_temp, s) * 1000;
>>>> +
>>>> +    return 0;
>>>> +}
>>>
>>> The way this function is coded the temperature will only ever change by
>>> 1C (i.e., 1000mC). Is there a chance that you're losing precision in the
>>> code_to_degc conversion that could be preserved perhaps?
>>>
>>> This is useful in scenarios where you use the power allocator governor
>>> and the greater precision allows better power budget estimation.
>> 
>> I'll take a look to see if we can get better precision. Thanks.
>
> I checked, and it does not look like these devices can support better precision
> than degC.

Ah well. Thanks for checking!
