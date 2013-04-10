From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 05/18] cpuidle: make a single register function for all
Date: Wed, 10 Apr 2013 17:05:21 +0200
Message-ID: <51657FB1.6030209@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org> <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org> <51657E61.9010701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f42.google.com ([74.125.83.42]:49257 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935620Ab3DJPFZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2013 11:05:25 -0400
Received: by mail-ee0-f42.google.com with SMTP id d4so295865eek.29
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2013 08:05:24 -0700 (PDT)
In-Reply-To: <51657E61.9010701@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: rjw@sisk.pl, andrew@lunn.ch, khilman@deeprootsystems.com, nsekhar@ti.com, josephl@nvidia.com, kgene.kim@samsung.com, patches@linaro.org, magnus.damm@gmail.com, tony@atomide.com, plagnioj@jcrosoft.com, linaro-kernel@lists.linaro.org, jason@lakedaemon.net, swarren@wwwdotorg.org, rob.herring@calxeda.com, horms@verge.net.au, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, jkosina@suse.cz, linux-pm@vger.kernel.org, lethal@linux-sh.org, kernel@pengutronix.de

On 04/10/2013 04:59 PM, Rob Herring wrote:
> On 04/10/2013 09:22 AM, Daniel Lezcano wrote:
>> The usual scheme to initialize a cpuidle driver on a SMP is:
>>
>> 	cpuidle_register_driver(drv);
>> 	for_each_possible_cpu(cpu) {
>> 		device =3D &per_cpu(cpuidle_dev, cpu);
>> 		cpuidle_register_device(device);
>> 	}
>>
>> This code is duplicated in each cpuidle driver.
>>
>> On UP systems, it is done this way:
>>
>> 	cpuidle_register_driver(drv);
>> 	device =3D &per_cpu(cpuidle_dev, cpu);
>> 	cpuidle_register_device(device);
>>
>> On UP, the macro 'for_each_cpu' does one iteration:
>>
>> #define for_each_cpu(cpu, mask)                 \
>>         for ((cpu) =3D 0; (cpu) < 1; (cpu)++, (void)mask)
>>
>> Hence, the initialization loop is the same for UP than SMP.
>>
>> Beside, we saw different bugs / mis-initialization / return code unc=
hecked in
>> the different drivers, the code is duplicated including bugs. After =
fixing all
>> these ones, it appears the initialization pattern is the same for ev=
eryone.
>>
>> Let's add a wrapper function doing this initialization with a cpumas=
k parameter
>> for the coupled idle states and use it for all the drivers.
>>
>> That will save a lot of LOC, consolidate the code, and the modificat=
ions in the
>> future could be done in a single place. Another benefit is the conso=
lidation of
>> the cpuidle_device variable which is now in the cpuidle framework an=
d no longer
>> spread accross the different arch specific drivers.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>=20
> Perhaps my ack was too quick...
>=20
>> +int cpuidle_register(struct cpuidle_driver *drv,
>> +		     const struct cpumask *const coupled_cpus)
>> +{
>> +	int ret, cpu;
>> +	struct cpuidle_device *device;
>> +
>> +	ret =3D cpuidle_register_driver(drv);
>> +	if (ret) {
>> +		printk(KERN_ERR "failed to register cpuidle driver\n");
>> +		return ret;
>> +	}
>> +
>> +	for_each_possible_cpu(cpu) {
>> +		device =3D &per_cpu(cpuidle_dev, cpu);
>> +		device->cpu =3D cpu;
>> +#ifdef CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED
>> +		device->coupled_cpus =3D *coupled_cpus;
>=20
> This needs a NULL check. CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED is most
> likely going to be enabled with multi-platform kernels and this will =
crash.

Good point, I will fix it.

> Also, I think typically struct copies have a note that it is copy.
>=20
> Rob
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

