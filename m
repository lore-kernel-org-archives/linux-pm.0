From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 05/18] cpuidle: make a single register function for all
Date: Wed, 10 Apr 2013 21:59:51 +0200
Message-ID: <5165C4B7.30601@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org> <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org> <20130410170457.GL13524@lunn.ch> <5165A937.70705@linaro.org> <20130410182359.GN13524@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f182.google.com ([74.125.82.182]:42739 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934822Ab3DJT7z (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 15:59:55 -0400
Received: by mail-we0-f182.google.com with SMTP id k14so681226wer.27
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 12:59:54 -0700 (PDT)
In-Reply-To: <20130410182359.GN13524@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/10/2013 08:23 PM, Andrew Lunn wrote:
> On Wed, Apr 10, 2013 at 08:02:31PM +0200, Daniel Lezcano wrote:
>> On 04/10/2013 07:04 PM, Andrew Lunn wrote:
>>>> +int cpuidle_register(struct cpuidle_driver *drv,
>>>> +		     const struct cpumask *const coupled_cpus)
>>>> +{
>>>> +	int ret, cpu;
>>>> +	struct cpuidle_device *device;
>>>> +
>>>> +	ret =3D cpuidle_register_driver(drv);
>>>> +	if (ret) {
>>>> +		printk(KERN_ERR "failed to register cpuidle driver\n");
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		device =3D &per_cpu(cpuidle_dev, cpu);
>>>> +		device->cpu =3D cpu;
>>>> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>>>> +		device->coupled_cpus =3D *coupled_cpus;
>>>> +#endif
>>>
>>> At least the kirkwood and the calxeda driver set=20
>>>
>>>    device->state_count
>>>
>>> which you don't appear to do. cpuidle_add_state_sysfs() and
>>> cpuidle_remove_state_sysfs() use this. Is it now being set somewher=
e
>>> else?
>>
>> Yes, in cpuidle_enable_device called from cpuidle_register_device:
>=20
> O.K. It would be nice to add a comment in the change log message abou=
t
> this.
>=20
> Ah, also, it would be good to update Documentation/cpuidle/drivers.tx=
t
> with these new functions and update the text.

Ok, I will take care of that.

Thanks.
  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

