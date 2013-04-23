From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [V3 patch 06/19] cpuidle: make a single register function for
 all
Date: Tue, 23 Apr 2013 20:37:48 +0530
Message-ID: <5176A3C4.2020008@ti.com>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-7-git-send-email-daniel.lezcano@linaro.org> <516FB35D.7000303@ti.com> <51769011.7030608@linaro.org> <51769316.9090309@ti.com> <5176990F.5070605@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47195 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755948Ab3DWPIX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Apr 2013 11:08:23 -0400
In-Reply-To: <5176990F.5070605@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On Tuesday 23 April 2013 07:52 PM, Daniel Lezcano wrote:
> On 04/23/2013 03:56 PM, Santosh Shilimkar wrote:
>> On Tuesday 23 April 2013 07:13 PM, Daniel Lezcano wrote:
>>> On 04/18/2013 10:48 AM, Santosh Shilimkar wrote:
>>>> On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
>>>>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>>>>
>>>>> 	cpuidle_register_driver(drv);
>>>>> 	for_each_possible_cpu(cpu) {
>>>>> 		device = &per_cpu(cpuidle_dev, cpu);
>>>>> 		cpuidle_register_device(device);
>>>>> 	}
>>>>>
>>>> Not exactly related to $subject patch but the driver should
>>>> be registered after all devices has been registered to avoid
>>>> devices start using the idle state data as soon as it is
>>>> registered. In multi CPU system, this race can easily happen.
>>>
>>> Could you elaborate what problems the system will be facing if a cpu
>>> starts using the idle state data as soon as it is registered ?
>>>
>>> Is there a bug related to this ?
>>>
>> Ofcouse. In multi-CPU scenario, where CPU C-states needs co-ordination
>> can just lead into unknown issues if all the CPUs are not already part
>> registered.
> 
> Hmm, ok. I don't see a scenario, with the current code, where that could
> occurs. The coupled idle state will wait for the other cpus to enter
> idle before initiating a shutdown sequence and, so far, the other sync
> algorithm (last man standing) are doing the same.
> 
Its no just couple idle state usages. CPUs do share power domains, clock
domains, clocks etc. One CPU going ahead and tampering/progarmming
the low power states till the next one isn't registered yet
can lead to issues.

> There are some systems with 1024 cpus, and I did not heard problems like
> this.
> 
That is because todays CPUIDLe core code doesn't let that happen. Once
you fix the ordering issue, there is window where the issue could happen.

> Do you know a system where this problem occurred ? Or is it something
> you suspect that can happen ?
> 
See above. Its more prone to issues true for systems with higher
number of CPUs. Not sure if that was the reason the core code, doesn't
proceed without all the devices are registered ?

> That would be interesting to have a system where this race occurs in
> order to check the modifications will solve the issue.
> 
I haven't see the issue myself but logically it could easily happen
once the core code is fixed.

>>>> Current CPUIDLE core layer is also written with the assumption
>>>> that driver will be registered first and then the devices which
>>>> is not mandatory as per typical drive/device model.
>>>
>>> Yes, that's true. The framework assumes cpuidle_register_driver is
>>> called before cpuidle_register_device.
>>>
>>>> May be you can fix that part while you are creating this common
>>>> wrapper.
>>>
>>> Personally, as that will modify the cpuidle core layer and the changes
>>> are not obvious (because of the design of the code) I prefer to do that
>>> in a separate patchset if it is worth to do it - if there is a bug
>>> related to it, then there is no discussion, we have to do it :)
>>>
>> Sure. It would have been nice if you would have clarified that before
>> posting the next version.
>>
>> You still need to fix the kernel doc in your v4 though.
> 
> Which one ? "s/accross/across" ?
> 
s/*/** below hunk in v4

+/*
+ * cpuidle_unregister: unregister a driver and the devices. This function
+ * can be used only if the driver has been previously registered through
+ * the cpuidle_register function.
+ *
+ * @drv: a valid pointer to a struct cpuidle_driver
+ */
+void cpuidle_unregister(struct cpuidle_driver *drv)
+{
+	int cpu;
+	struct cpuidle_device *device;

