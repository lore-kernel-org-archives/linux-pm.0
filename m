From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 06/19] cpuidle: make a single register function for
 all
Date: Tue, 23 Apr 2013 17:21:44 +0200
Message-ID: <5176A708.2070506@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-7-git-send-email-daniel.lezcano@linaro.org> <516FB35D.7000303@ti.com> <51769011.7030608@linaro.org> <51769316.9090309@ti.com> <5176990F.5070605@linaro.org> <5176A3C4.2020008@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:57779 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab3DWPVv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 11:21:51 -0400
Received: by mail-ea0-f171.google.com with SMTP id b15so324555eae.16
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 08:21:49 -0700 (PDT)
In-Reply-To: <5176A3C4.2020008@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/23/2013 05:07 PM, Santosh Shilimkar wrote:
> On Tuesday 23 April 2013 07:52 PM, Daniel Lezcano wrote:
>> On 04/23/2013 03:56 PM, Santosh Shilimkar wrote:
>>> On Tuesday 23 April 2013 07:13 PM, Daniel Lezcano wrote:
>>>> On 04/18/2013 10:48 AM, Santosh Shilimkar wrote:
>>>>> On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
>>>>>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>>>>>
>>>>>> 	cpuidle_register_driver(drv);
>>>>>> 	for_each_possible_cpu(cpu) {
>>>>>> 		device =3D &per_cpu(cpuidle_dev, cpu);
>>>>>> 		cpuidle_register_device(device);
>>>>>> 	}
>>>>>>
>>>>> Not exactly related to $subject patch but the driver should
>>>>> be registered after all devices has been registered to avoid
>>>>> devices start using the idle state data as soon as it is
>>>>> registered. In multi CPU system, this race can easily happen.
>>>>
>>>> Could you elaborate what problems the system will be facing if a c=
pu
>>>> starts using the idle state data as soon as it is registered ?
>>>>
>>>> Is there a bug related to this ?
>>>>
>>> Ofcouse. In multi-CPU scenario, where CPU C-states needs co-ordinat=
ion
>>> can just lead into unknown issues if all the CPUs are not already p=
art
>>> registered.
>>
>> Hmm, ok. I don't see a scenario, with the current code, where that c=
ould
>> occurs. The coupled idle state will wait for the other cpus to enter
>> idle before initiating a shutdown sequence and, so far, the other sy=
nc
>> algorithm (last man standing) are doing the same.
>>
> Its no just couple idle state usages. CPUs do share power domains, cl=
ock
> domains, clocks etc. One CPU going ahead and tampering/progarmming
> the low power states till the next one isn't registered yet
> can lead to issues.
>=20
>> There are some systems with 1024 cpus, and I did not heard problems =
like
>> this.
>>
> That is because todays CPUIDLe core code doesn't let that happen. Onc=
e
> you fix the ordering issue, there is window where the issue could hap=
pen.
>=20
>> Do you know a system where this problem occurred ? Or is it somethin=
g
>> you suspect that can happen ?
>>
> See above. Its more prone to issues true for systems with higher
> number of CPUs. Not sure if that was the reason the core code, doesn'=
t
> proceed without all the devices are registered ?
>=20
>> That would be interesting to have a system where this race occurs in
>> order to check the modifications will solve the issue.
>>
> I haven't see the issue myself but logically it could easily happen
> once the core code is fixed.
>=20
>>>>> Current CPUIDLE core layer is also written with the assumption
>>>>> that driver will be registered first and then the devices which
>>>>> is not mandatory as per typical drive/device model.
>>>>
>>>> Yes, that's true. The framework assumes cpuidle_register_driver is
>>>> called before cpuidle_register_device.
>>>>
>>>>> May be you can fix that part while you are creating this common
>>>>> wrapper.
>>>>
>>>> Personally, as that will modify the cpuidle core layer and the cha=
nges
>>>> are not obvious (because of the design of the code) I prefer to do=
 that
>>>> in a separate patchset if it is worth to do it - if there is a bug
>>>> related to it, then there is no discussion, we have to do it :)
>>>>
>>> Sure. It would have been nice if you would have clarified that befo=
re
>>> posting the next version.
>>>
>>> You still need to fix the kernel doc in your v4 though.
>>
>> Which one ? "s/accross/across" ?
>>
> s/*/** below hunk in v4
>=20
> +/*
> + * cpuidle_unregister: unregister a driver and the devices. This fun=
ction
> + * can be used only if the driver has been previously registered thr=
ough
> + * the cpuidle_register function.
> + *
> + * @drv: a valid pointer to a struct cpuidle_driver
> + */
> +void cpuidle_unregister(struct cpuidle_driver *drv)
> +{
> +	int cpu;
> +	struct cpuidle_device *device;
>=20

Ah, ok. I thought you were referring to something in 'Documentation'.

I will fix this nit.

Thanks !
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

