From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/3] firmware: scpi: add device power domain support using
 genpd
Date: Wed, 15 Jun 2016 14:44:06 +0100
Message-ID: <57615BA6.5010406@arm.com>
References: <1465228439-13457-1-git-send-email-sudeep.holla@arm.com>
 <1465228439-13457-4-git-send-email-sudeep.holla@arm.com>
 <CAPDyKFp5GacJNq_hqhrdupN9gYNHYmE_-Z7ZV-c6BP59AaurZw@mail.gmail.com>
 <576156D6.4010606@arm.com>
 <CAPDyKFrerQU61iN6qjLLbw_=xmodmkGCZMEx29kC6arOzMfHiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrerQU61iN6qjLLbw_=xmodmkGCZMEx29kC6arOzMfHiw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jon Medhurst <tixy@linaro.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, Suzuki K Poulose <suzuki.poulose@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On 15/06/16 14:29, Ulf Hansson wrote:
> [...]
>
>>
>>>> +static const struct of_device_id scpi_power_domain_ids[] = {
>>>> +       { .compatible = "arm,scpi-power-domains", },
>>>> +       { /* sentinel */ }
>>>> +};
>>>
>>>
>>> Actually I think you shouldn't implement this a standalone driver and
>>> thus you can remove this compatible.
>>>
>>
>> While I tend to agree, I did this to keep it aligned with other SCPI
>> users(clocks, sensors,.. for example).
>>
>> I assume remove compatible just from driver ? IMO, it doesn't make sense
>> to add power domain provider without a compatible.
>>
>>> Instead, I think it's better if you let the arm_scpi driver to also
>>> initialize the PM domain.
>>>
>>
>> OK, I can do that.
>>
>>> If you still want the PM domain code to be maintained in a separate
>>> file, just provide a header file which declares an
>>> "scpi_pm_domain_init()" function (and a stub when not supported),
>>> which the arm_scpi driver should call during ->probe().
>>>
>>
>> I am fine with that, just that it deviates from the approach taken in
>> other subsystems as I mentioned above.
>
> If DT maintainers are happy with you adding a compatible for this,
> don't let me stop you from implementing this as standalone driver.
>

I assume compatibles are always preferred even if they are not used to
make it future proof and may be that's why the binding was accepted. We
need to have a node to specify phandle in the consumers anyways, it's
always better to have separate node for each of the SCPI users/provider
(like clock, sensors, power domains) instead of pointing all to the one
SCPI node. Again that's just my view.

> I have no strong opinions about it, so perhaps it's then better to not
> deviate from other cases!?
>

OK, thanks. I will respin with Kconfig changes and retain the file in
drivers/firmware for now.

-- 
Regards,
Sudeep
