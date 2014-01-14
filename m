From: Wei Ni <wni@nvidia.com>
Subject: Re: [PATCH v2 0/2] Support to tune governor in run time
Date: Tue, 14 Jan 2014 12:17:58 +0800
Message-ID: <52D4BA76.4040003@nvidia.com>
References: <1389611863-7812-1-git-send-email-wni@nvidia.com>
 <52D4095C.205@ti.com> <52D43810.6030801@nvidia.com> <52D45BB7.1090002@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17062 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038AbaANERb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jan 2014 23:17:31 -0500
In-Reply-To: <52D45BB7.1090002@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <eduardo.valentin@ti.com>, Matthew Longnecker <MLongnecker@nvidia.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 01/14/2014 05:33 AM, Eduardo Valentin wrote:
> * PGP Signed by an unknown key
> 
> On 13-01-2014 15:01, Matthew Longnecker wrote:
>> On 1/13/2014 7:42 AM, Eduardo Valentin wrote:
>>>> This serie can support to turn governor for thermal zone in
>>>> run time.
>>>
>>> Can you please explain why this is needed? Are you facing troubles with
>>> current way to switch governors? If yes, can you please report them?
> 
> Looks like there is a need to switch governors from within kernel code,
> but not explanation of use cases is provided.

In fact, with the of-thermal framework, the driver can't initialize to
any governor, even default governor, it may be a bug. As we discussed in
other mail list, we should not set governor in DT, and I think the
platform driver should be able to set to any governors which it want, so
I this patch, the driver can call the thermal_update_governor() to
switch to new governor in kernel space.
For example, there have two thermal driver, using of-thermal to register
thermal zone device. One want to set to step_wise governor, another want
fair_share, how can we do? I think after they calling the
thermal_zone_of_sensor_register(), they can call the
thermal_update_governor() to set the governor which they want.

> 
>>>
>>
>> ....
>>
>>>> Adds thermal_update_governor() function, so the thermal platform
>>>> driver can use it to update governor.
>>>
>>> Here I cannot see why the platform driver would need to update a
>>> governor, instead of a zone. Platform drivers are not supposed to be
>>> aware of governors. For updating a zone we already have an API for that,
>>> please check documentation.
>>>
>>
>> I think we have a miscommunication. The purpose of
>> thermal_update_governor is to *switch* governors at runtime (from within
>> the kernel).
>>
>> Wei has used the term "update" in the sense of switch rather than
>> "update" in the sense used by thermal_zone_device_update.
> 
> Fine, but why do you need it?

Yes, I have consider to use "switch", but As my commit in the patch, in
the future, the governor may be more complex, it may need governor
parameter/configuration, and need to be tuned in run-time or in
initialization.
In fact we develop a new governor, based on PID logic. It will need some
parameters, such as proportional, integral and derivative. these value
will be initialized in different values for different thermal zone, so
we want to use the thermal_zone_device_update() to switch governor or
update the governor's parameters for different thermal zone.

> 
>>
>> Eduardo, what is your recommended technique for setting the governor of
>> a thermal zone device created via device tree?
> 
> So far the recommended (and existing) way is by user(land) decision.
> 
>>
>> thanks,
>> Matt
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> 

