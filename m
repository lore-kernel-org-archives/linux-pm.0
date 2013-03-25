From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 07/15] ARM: cpuidle: add init/exit routine
Date: Mon, 25 Mar 2013 23:09:21 +0100
Message-ID: <5150CB11.6090105@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org> <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org> <20130325190908.GC631@lunn.ch> <5150A378.60608@linaro.org> <20130325214203.GD631@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:59301 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933538Ab3CYWJV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 18:09:21 -0400
Received: by mail-wi0-f179.google.com with SMTP id hn17so4624308wib.12
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 15:09:20 -0700 (PDT)
In-Reply-To: <20130325214203.GD631@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, linus.walleij@linaro.org, linux@arm.linux.org.uk

On 03/25/2013 10:42 PM, Andrew Lunn wrote:
>> If the DT binding was allowed, I *may* not be ARM specific but will
>> certainly used only by the ARM drivers as the x86 platform uses ACPI=
 or
>> static tables.
>=20
> And powerpc? Its powerpc that created DT, as far as i understand.
>=20
> arch/powerpc/platforms/pseries/processor_idle.c
>=20
> static int pseries_idle_devices_init(void)
> {
>         int i;
>         struct cpuidle_driver *drv =3D &pseries_idle_driver;
>         struct cpuidle_device *dev;
>=20
>         pseries_cpuidle_devices =3D alloc_percpu(struct cpuidle_devic=
e);
>         if (pseries_cpuidle_devices =3D=3D NULL)
>                 return -ENOMEM;
>=20
>         for_each_possible_cpu(i) {
>                 dev =3D per_cpu_ptr(pseries_cpuidle_devices, i);
>                 dev->state_count =3D drv->state_count;
>                 dev->cpu =3D i;
>                 if (cpuidle_register_device(dev)) {
>                         printk(KERN_DEBUG \
>                                 "cpuidle_register_device %d failed!\n=
", i);
>                         return -EIO;
>                 }
>         }
>=20
>         return 0;
> }
>=20
>=20
> This looks pretty similar to the code you are consolidating. Can your
> 'ARM' code be made to work on powerpc?

Yes, it is very similar. I am aware of this code and the cpuidle code o=
f
all others archs but for now there are *18* cpuidle drivers for ARM I
would like to consolidate in priority into a single one. When all of
them will be factored out, I will recheck with the other arch. That wil=
l
be easier to consolidate four archs: x86, arm, sh and powerpc.

May be in the meantime, someone will cleanup the non-ARM drivers and
make my life easier :)

In any case, I keep in mind there are other arch using cpuidle.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

