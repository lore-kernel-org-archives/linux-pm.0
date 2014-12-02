From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v13 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 02 Dec 2014 16:47:05 +0100
Message-ID: <547DDEF9.8020105@linaro.org>
References: <1417065854-37745-1-git-send-email-lina.iyer@linaro.org> <1417065854-37745-4-git-send-email-lina.iyer@linaro.org> <5476E653.4040007@linaro.org> <20141201185023.GB499@linaro.org> <547D8C1A.1010204@linaro.org> <20141202153548.GE499@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46378 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbaLBPrL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Dec 2014 10:47:11 -0500
Received: by mail-wi0-f174.google.com with SMTP id h11so28538547wiw.1
        for <linux-pm@vger.kernel.org>; Tue, 02 Dec 2014 07:47:09 -0800 (PST)
In-Reply-To: <20141202153548.GE499@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org

On 12/02/2014 04:35 PM, Lina Iyer wrote:
> On Tue, Dec 02 2014 at 02:53 -0700, Daniel Lezcano wrote:
>> On 12/01/2014 07:50 PM, Lina Iyer wrote:
>>> On Thu, Nov 27 2014 at 01:52 -0700, Daniel Lezcano wrote:
>>>> On 11/27/2014 06:24 AM, Lina Iyer wrote:
>>>
>>>> +    static bool cpuidle_drv_init;
>>>>
>>>>       ^^^^^^^^^
>>>>
>>>> As already said in a previous comment, please find a way to remove
>>>> that.
>>>>
>>> I will look into it. Stephen and I wanted the cpuidle driver to be
>>> probed only after any of the SPMs are ready. And possibly, only for=
 that
>>> cpu, for which the SPM has been probed.
>>>
>>> To achieve the SPM -> CPUIDLE Device relation, I havent found a goo=
d way
>>> to do that. Without using CPUIDLE_MULTIPLE_DRIVERS, initializing ea=
ch
>>> cpuidle device, separate from the cpuidle driver, requires that I u=
pdate
>>> the cpuidle_driver->cpumask after probing each SPM device, to allow=
 for
>>> only one driver and cpuidle devices only for the probed cpus. Using=
 the
>>> cpuidle_register_driver(), resets the drv->refcnt in
>>> __cpuidle_driver_init.
>>>
>>> I may need something like this in the else clause of
>>> CPUIDLE_MULTIPLE_DRIVERS -
>>>
>>> static inline struct cpuidle_driver *__cpuidle_get_cpu_driver(int c=
pu)
>>> {
>>>        struct cpuidle_driver *drv =3D cpuidle_curr_driver;
>>>
>>>        if (drv && !cpumask_test_cpu(cpu, drv->cpumask))
>>>                 drv =3D NULL;
>>>
>>>        return drv;
>>> }
>>
>> You don't have to deal with the drv->cpumask and
>> CPUIDLE_MULTIPLE_DRIVERS. This field gives the list of the cpus the
>> driver will have to potentially handle.
>>
>> Just register the driver at the first place with the platform device
>> by using cpuidle_register_driver(drv), I suggest somewhere else than
>> the spm code.
>>
>> The underlying code will do:
>>
>>        if (!drv->cpumask)
>>                drv->cpumask =3D (struct cpumask *)cpu_possible_mask;
>>
>> Until the cpuidle device is not initialized for a specific cpu, the
>> cpuidle code will have no effect for this cpu. If you register the
>> driver but without registering the cpuidle devices that will result =
in
>> nothing more than a structure initialized but inoperative.
>>
>> For each SPM being probed:
>>
>> struct cpuidle_device *dev =3D &per_cpu(cpuidle_dev, cpu);
>> dev->cpu =3D cpu;
>> cpuidle_register_device(dev);
>>
>> Note cpuidle_dev is exported via cpuidle.h, so you don't have to
>> redeclare a per cpu cpuidle device by your own.
>>
>> So rephrasing all that:
>>
>> (1) in cpuidle-qcom register the driver
>> (2) in the spm code register the device for each spm probe
>>
>> (1) being called before (2).
>>
>> If after that in the code you still have a "static bool
>> cpuidle_drv_init", then I guess we have a problem in the init sequen=
ce
>> somewhere else.
>>
> Okay, Thanks. Last night I was able to get a patch working with one
> cpuidle_register_driver and multiple cpuidle_register_device. The iss=
ue
> using an module_init() was -
>
> 1. Register a device to probe the cpuidle driver.
> 2. Register cpuidle devices for every SPM probed.

That's it.

> What used to happen is that the cpuidle driver probe always happens
> after the cpuidle devices were created.
>
> I have a solution where I register for the cpuidle device to probe a
> driver, at postcore_initcall() at which point, the cpuidle framework
> would also be available.
>
> I am not sure how elegant it looks, but thats the latest initcall I
> could get a consistent driver initialization before the SPM probe
> (therefore the device registration).

I don't have the code in front of me but we can probably find a nice=20
place to probe the cpuidle driver. Is there any pm.c file with an init=20
function that can be useful ? In any case, regarding the unusual init=20
sequence for the cpuidle driver, I think the probe would deserve a comm=
ent.

> I will send the patch this morning.

Ok, cool.

[ ... ]

>>>> There is something wrong with the init sequence. Don't you find we=
ird
>>>> you have to backward search for the cpu belonging to the pdev each
>>>> time the probe function is called ?
>>>>
>>>>
>>> Well, it was that or the SPM device node pointing to the CPU that i=
t
>>> references. It seems more common to have an iterator than the doubl=
y
>>> linked device nodes. I dont have a strong preference either way, ju=
st
>>> chose the way that made device nodes easier.
>>>
> This one, I havent addressed. How strongly do you feel about this? I
> still have to iterate through all the cpus to find the cpu node that
> matches the handle specified in the SAW node.

IMO, we can live with that if there is no longer any static variable=20
around telling us we initialized something.

Thanks !

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

