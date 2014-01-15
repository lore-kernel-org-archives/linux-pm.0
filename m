From: Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 0/2] Support to tune governor in run time
Date: Wed, 15 Jan 2014 19:35:50 +0800
Message-ID: <52D67296.7050107@nvidia.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com>
 <52D4095C.205@ti.com> <52D43810.6030801@nvidia.com>
 <52D45BB7.1090002@ti.com> <52D4BA76.4040003@nvidia.com>
 <52D57762.8070609@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52D57762.8070609-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: Matthew Longnecker <MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 01/15/2014 01:44 AM, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
> 
> Hello Wei,
> 
> On 14-01-2014 00:17, Wei Ni wrote:
>> On 01/14/2014 05:33 AM, Eduardo Valentin wrote:
>>>> Old Signed by an unknown key
>>>
>>> On 13-01-2014 15:01, Matthew Longnecker wrote:
>>>> On 1/13/2014 7:42 AM, Eduardo Valentin wrote:
>>>>>> This serie can support to turn governor for thermal zone in
>>>>>> run time.
>>>>>
>>>>> Can you please explain why this is needed? Are you facing troubles with
>>>>> current way to switch governors? If yes, can you please report them?
>>>
>>> Looks like there is a need to switch governors from within kernel code,
>>> but not explanation of use cases is provided.
>>
>> In fact, with the of-thermal framework, the driver can't initialize to
>> any governor, even default governor, it may be a bug. As we discussed in
> 
> I see. Using default governor is not a bug. The thermal zone shall not
> be defined in way that it is specific to a policy. We must remember that
> DT is not used for specifying policies, but only describing hardware.
> 
>> other mail list, we should not set governor in DT, and I think the
>> platform driver should be able to set to any governors which it want, so
> 
> OK. But still, because you believe the platform driver has to set the
> governor, this is not a bug. Defining which policy is used to control a
> zone can be a later decision in the boot process. Specially because the
> critical requirements are not dealt by the governors anyway.
> 
>> I this patch, the driver can call the thermal_update_governor() to
>> switch to new governor in kernel space.
> 
> I see.
> 
>> For example, there have two thermal driver, using of-thermal to register
>> thermal zone device. One want to set to step_wise governor, another want
>> fair_share, how can we do? I think after they calling the
>> thermal_zone_of_sensor_register(), they can call the
>> thermal_update_governor() to set the governor which they want.
> 
> OK. Now I get a better view of what you are trying to achieve with this
> series. However, why can't you hand this decision off to userland,
> during, say very early boot sequence?

I think the thermal_zone_device_register() provide a way to set governor
when register a thermal zone, and this function is exposed to all
driver, so I supposed the thermal framework can support to handle the
governor in kernel.

Anyway, let's consider to switch the governor in user space.

> 
> 
>>
>>>
>>>>>
>>>>
>>>> ....
>>>>
>>>>>> Adds thermal_update_governor() function, so the thermal platform
>>>>>> driver can use it to update governor.
>>>>>
>>>>> Here I cannot see why the platform driver would need to update a
>>>>> governor, instead of a zone. Platform drivers are not supposed to be
>>>>> aware of governors. For updating a zone we already have an API for that,
>>>>> please check documentation.
>>>>>
>>>>
>>>> I think we have a miscommunication. The purpose of
>>>> thermal_update_governor is to *switch* governors at runtime (from within
>>>> the kernel).
>>>>
>>>> Wei has used the term "update" in the sense of switch rather than
>>>> "update" in the sense used by thermal_zone_device_update.
>>>
>>> Fine, but why do you need it?
>>
>> Yes, I have consider to use "switch", but As my commit in the patch, in
>> the future, the governor may be more complex, it may need governor
>> parameter/configuration, and need to be tuned in run-time or in
>> initialization.
>> In fact we develop a new governor, based on PID logic. It will need some
>> parameters, such as proportional, integral and derivative. these value
>> will be initialized in different values for different thermal zone, so
>> we want to use the thermal_zone_device_update() to switch governor or
>> update the governor's parameters for different thermal zone.
>>
>>>
>>>>
>>>> Eduardo, what is your recommended technique for setting the governor of
>>>> a thermal zone device created via device tree?
>>>
>>> So far the recommended (and existing) way is by user(land) decision.
>>>
>>>>
>>>> thanks,
>>>> Matt
>>>>
>>>> -- 
>>>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>>>
>>>
>>
>>
>>
> 
> 
