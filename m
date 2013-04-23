From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [V4 patch 03/15] cpuidle: make a single register function for
 all
Date: Tue, 23 Apr 2013 14:51:41 +0200
Message-ID: <517683DD.6060805@linaro.org>
References: <1366707285-12179-1-git-send-email-daniel.lezcano@linaro.org> <1366707285-12179-4-git-send-email-daniel.lezcano@linaro.org> <51767F57.7060809@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ee0-f54.google.com ([74.125.83.54]:33997 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463Ab3DWMvr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Apr 2013 08:51:47 -0400
Received: by mail-ee0-f54.google.com with SMTP id e51so249528eek.13
        for <linux-pm@vger.kernel.org>; Tue, 23 Apr 2013 05:51:45 -0700 (PDT)
In-Reply-To: <51767F57.7060809@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: rjw@sisk.pl, andrew@lunn.ch, kgene.kim@samsung.com, jason@lakedaemon.net, horms@verge.net.au, patches@linaro.org, khilman@deeprootsystems.com, magnus.damm@gmail.com, linux-pm@vger.kernel.org, swarren@wwwdotorg.org, nsekhar@ti.com, rob.herring@calxeda.com, deepthi@linux.vnet.ibm.com, tony@atomide.com, lethal@linux-sh.org, linaro-kernel@lists.linaro.org, kernel@pengutronix.de, josephl@nvidia.com, jkosina@suse.cz, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org

On 04/23/2013 02:32 PM, Santosh Shilimkar wrote:
> On Tuesday 23 April 2013 02:24 PM, Daniel Lezcano wrote:
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
>> Please note, some drivers are doing dev->state_count =3D drv->state_=
count. This is
>> not necessary because it is done by the cpuidle_enable_device functi=
on in the
>> cpuidle framework. This is true, until you have the same states for =
all your
>> devices. Otherwise, the 'low level' API should be used instead with =
the specific
>> initialization for the driver.
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
> I don't see you have addressed the comment on V3 [1] i gave for the s=
ubject patch
> Any reason ?

Yes, sorry for not answering.

This modification should be handled in the __cpuidle_register_device
function.

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index 49e8d30..936d862 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -372,7 +372,7 @@ static int __cpuidle_register_device(struct
cpuidle_device *dev)
        int ret;
        struct cpuidle_driver *drv =3D cpuidle_get_cpu_driver(dev);

-       if (!try_module_get(drv->owner))
+       if (!drv || !try_module_get(drv->owner))
                return -EINVAL;

        per_cpu(cpuidle_devices, dev->cpu) =3D dev;

Thus, the cpuidle_register function is not impacted by this as it will
always do cpuidle_register_driver, followed by cpuidle_register_device.

  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

