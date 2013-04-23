From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V3 patch 06/19] cpuidle: make a single register function for
 all
Date: Tue, 23 Apr 2013 16:22:07 +0200
Message-ID: <5176990F.5070605@linaro.org>
References: <1365770165-27096-1-git-send-email-daniel.lezcano@linaro.org> <1365770165-27096-7-git-send-email-daniel.lezcano@linaro.org> <516FB35D.7000303@ti.com> <51769011.7030608@linaro.org> <51769316.9090309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:51523 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156Ab3DWOWM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 10:22:12 -0400
Received: by mail-ee0-f47.google.com with SMTP id b57so287102eek.6
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 07:22:11 -0700 (PDT)
In-Reply-To: <51769316.9090309@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, andrew@lunn.ch, kernel@pengutronix.de, swarren@wwwdotorg.org, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/23/2013 03:56 PM, Santosh Shilimkar wrote:
> On Tuesday 23 April 2013 07:13 PM, Daniel Lezcano wrote:
>> On 04/18/2013 10:48 AM, Santosh Shilimkar wrote:
>>> On Friday 12 April 2013 06:05 PM, Daniel Lezcano wrote:
>>>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>>>
>>>> 	cpuidle_register_driver(drv);
>>>> 	for_each_possible_cpu(cpu) {
>>>> 		device =3D &per_cpu(cpuidle_dev, cpu);
>>>> 		cpuidle_register_device(device);
>>>> 	}
>>>>
>>> Not exactly related to $subject patch but the driver should
>>> be registered after all devices has been registered to avoid
>>> devices start using the idle state data as soon as it is
>>> registered. In multi CPU system, this race can easily happen.
>>
>> Could you elaborate what problems the system will be facing if a cpu
>> starts using the idle state data as soon as it is registered ?
>>
>> Is there a bug related to this ?
>>
> Ofcouse. In multi-CPU scenario, where CPU C-states needs co-ordinatio=
n
> can just lead into unknown issues if all the CPUs are not already par=
t
> registered.

Hmm, ok. I don't see a scenario, with the current code, where that coul=
d
occurs. The coupled idle state will wait for the other cpus to enter
idle before initiating a shutdown sequence and, so far, the other sync
algorithm (last man standing) are doing the same.

There are some systems with 1024 cpus, and I did not heard problems lik=
e
this.

Do you know a system where this problem occurred ? Or is it something
you suspect that can happen ?

That would be interesting to have a system where this race occurs in
order to check the modifications will solve the issue.

>>> Current CPUIDLE core layer is also written with the assumption
>>> that driver will be registered first and then the devices which
>>> is not mandatory as per typical drive/device model.
>>
>> Yes, that's true. The framework assumes cpuidle_register_driver is
>> called before cpuidle_register_device.
>>
>>> May be you can fix that part while you are creating this common
>>> wrapper.
>>
>> Personally, as that will modify the cpuidle core layer and the chang=
es
>> are not obvious (because of the design of the code) I prefer to do t=
hat
>> in a separate patchset if it is worth to do it - if there is a bug
>> related to it, then there is no discussion, we have to do it :)
>>
> Sure. It would have been nice if you would have clarified that before
> posting the next version.
>=20
> You still need to fix the kernel doc in your v4 though.

Which one ? "s/accross/across" ?

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

