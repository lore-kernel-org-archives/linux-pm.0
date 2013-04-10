From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 05/18] cpuidle: make a single register function for all
Date: Thu, 11 Apr 2013 00:07:33 +0200
Message-ID: <5165E2A5.4040401@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org> <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org> <20130410165509.GK13524@lunn.ch> <5165A9A6.70905@linaro.org> <20130410181817.GM13524@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36131 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675Ab3DJWHh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 18:07:37 -0400
Received: by mail-wi0-f179.google.com with SMTP id hn17so968832wib.6
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 15:07:36 -0700 (PDT)
In-Reply-To: <20130410181817.GM13524@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: rjw@sisk.pl, linus.walleij@linaro.org, jason@lakedaemon.net, kernel@pengutronix.de, swarren@wwwdotorg.org, santosh.shilimkar@ti.com, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, linux@maxim.org.za, rob.herring@calxeda.com, nsekhar@ti.com, horms@verge.net.au, magnus.damm@gmail.com, deepthi@linux.vnet.ibm.com, lethal@linux-sh.org, jkosina@suse.cz, kgene.kim@samsung.com, khilman@deeprootsystems.com, tony@atomide.com, linux-pm@vger.kernel.org, patches@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, josephl@nvidia.com

On 04/10/2013 08:18 PM, Andrew Lunn wrote:
> On Wed, Apr 10, 2013 at 08:04:22PM +0200, Daniel Lezcano wrote:
>> On 04/10/2013 06:55 PM, Andrew Lunn wrote:
>>>> +/**
>>>> + * cpuidle_register: registers the driver and the cpu devices wit=
h the
>>>> + * coupled_cpus passed as parameter. This function is used for al=
l common
>>>> + * initialization pattern there are in the arch specific drivers.=
 The
>>>> + * devices is globally defined in this file.
>>>> + *
>>>> + * @drv         : a valid pointer to a struct cpuidle_driver
>>>> + * @coupled_cpus: a cpumask for the coupled states
>>>> + *
>>>> + * Returns 0 on success, < 0 otherwise
>>>> + */
>>>> +int cpuidle_register(struct cpuidle_driver *drv,
>>>> +		     const struct cpumask *const coupled_cpus)
>>>> +{
>>>> +	int ret, cpu;
>>>> +	struct cpuidle_device *device;
>>>> +
>>>> +	ret =3D cpuidle_register_driver(drv);
>>>> +	if (ret) {
>>>> +		printk(KERN_ERR "failed to register cpuidle driver\n");
>>>
>>> pr_err()
>>
>> Ok.
>>
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	for_each_possible_cpu(cpu) {
>>>> +		device =3D &per_cpu(cpuidle_dev, cpu);
>>>> +		device->cpu =3D cpu;
>>>> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>>>> +		device->coupled_cpus =3D *coupled_cpus;
>>>> +#endif
>>>> +		ret =3D cpuidle_register_device(device);
>>>> +		if (!ret)
>>>> +			continue;
>>>> +
>>>> +		printk(KERN_ERR "Failed to register cpuidle "
>>>> +		       "device for cpu%d\n", cpu);
>>>
>>> pr_err() and don't split the message over two lines, it makes it
>>> harder for somebody to find with
>>>
>>> grep -r "Failed to register cpuidle device for cpu" *
>>
>> Ok if the line length is under 80 chars.
>=20
> Take a closer look at the CodingStyle documents. This is one except t=
o
> the rule. Such lines can be longer than 80 characters.

Oh, right !

"However, never break user-visible strings such as printk messages,
because that breaks the ability to grep for them."

Will fix it, thanks.

  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

