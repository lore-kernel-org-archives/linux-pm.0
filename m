From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v3] arm: zynq: Add cpuidle support
Date: Mon, 03 Jun 2013 18:19:24 +0200
Message-ID: <51ACC20C.7000005@linaro.org>
References: <2ba502c172f5374ed2e424292fb50345c9dd007a.1370266815.git.michal.simek@xilinx.com> <51ACA237.8070004@linaro.org> <51ACB06A.2050206@monstr.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ea0-f178.google.com ([209.85.215.178]:50411 "EHLO
	mail-ea0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759284Ab3FCQT1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jun 2013 12:19:27 -0400
Received: by mail-ea0-f178.google.com with SMTP id q15so3675040ead.37
        for <linux-pm@vger.kernel.org>; Mon, 03 Jun 2013 09:19:26 -0700 (PDT)
In-Reply-To: <51ACB06A.2050206@monstr.eu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: monstr@monstr.eu
Cc: Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Josh Cartwright <josh.cartwright@ni.com>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Rob Herring <robherring2@gmail.com>, Peter Crosthwaite <peter.crosthwaite@xilinx.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@vger.kernel.org

On 06/03/2013 05:04 PM, Michal Simek wrote:
> On 06/03/2013 04:03 PM, Daniel Lezcano wrote:
>> On 06/03/2013 03:40 PM, Michal Simek wrote:
>>> Add support for cpuidle.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>> Changes in v3:
>>> - Move driver to drivers/cpuidle/
>>> - Check zynq compatible string suggested by Arnd
>>> - Use zynq_ function prefix because of multiplatform kernel
>>> - Incorporate comments from Daniel Lezcano
>>> - Rebase on the top of git://git.kernel.org/pub/scm/linux/kernel/gi=
t/rafael/linux-pm.git linux-next
>>>
>>> Changes in v2:
>>> - Fix file header
>>>
>>> Changes in v1:
>>> - It was the part of Zynq core changes
>>>   https://patchwork.kernel.org/patch/2342511/
>>>
>>>  drivers/cpuidle/Kconfig        |   6 +++
>>>  drivers/cpuidle/Makefile       |   1 +
>>>  drivers/cpuidle/cpuidle-zynq.c | 100 +++++++++++++++++++++++++++++=
++++++++++++
>>>  3 files changed, 107 insertions(+)
>>>  create mode 100644 drivers/cpuidle/cpuidle-zynq.c
>>>
>>> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
>>> index c4cc27e..8272a08 100644
>>> --- a/drivers/cpuidle/Kconfig
>>> +++ b/drivers/cpuidle/Kconfig
>>> @@ -39,4 +39,10 @@ config CPU_IDLE_CALXEDA
>>>  	help
>>>  	  Select this to enable cpuidle on Calxeda processors.
>>>
>>> +config CPU_IDLE_ZYNQ
>>> +	bool "CPU Idle Driver for Xilinx Zynq processors"
>>> +	depends on ARCH_ZYNQ
>>> +	help
>>> +	  Select this to enable cpuidle on Xilinx Zynq processors.
>>> +
>>>  endif
>>> diff --git a/drivers/cpuidle/Makefile b/drivers/cpuidle/Makefile
>>> index 0d8bd55..8767a7b 100644
>>> --- a/drivers/cpuidle/Makefile
>>> +++ b/drivers/cpuidle/Makefile
>>> @@ -7,3 +7,4 @@ obj-$(CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED) +=3D coup=
led.o
>>>
>>>  obj-$(CONFIG_CPU_IDLE_CALXEDA) +=3D cpuidle-calxeda.o
>>>  obj-$(CONFIG_ARCH_KIRKWOOD) +=3D cpuidle-kirkwood.o
>>> +obj-$(CONFIG_CPU_IDLE_ZYNQ) +=3D cpuidle-zynq.o
>>> diff --git a/drivers/cpuidle/cpuidle-zynq.c b/drivers/cpuidle/cpuid=
le-zynq.c
>>> new file mode 100644
>>> index 0000000..afe6af3
>>> --- /dev/null
>>> +++ b/drivers/cpuidle/cpuidle-zynq.c
>>> @@ -0,0 +1,100 @@
>>> +/*
>>> + * Copyright (C) 2012-2013 Xilinx
>>> + *
>>> + * CPU idle support for Xilinx Zynq
>>> + *
>>> + * based on arch/arm/mach-at91/cpuidle.c
>>> + *
>>> + * This file is licensed under the terms of the GNU General Public
>>> + * License version 2.  This program is licensed "as is" without an=
y
>>> + * warranty of any kind, whether express or implied.
>>> + *
>>> + * The cpu idle uses wait-for-interrupt and RAM self refresh in or=
der
>>> + * to implement two idle states -
>>> + * #1 wait-for-interrupt
>>> + * #2 wait-for-interrupt and RAM self refresh
>>> + */
>>
>> Please check you headers, it seems you are including unused headers.
>>
>>> +#include <linux/kernel.h>
>>> +#include <linux/init.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/cpuidle.h>
>>> +#include <linux/io.h>
>>
>> ^^^^^
>>
>>> +#include <linux/export.h>
>>
>> ^^^^^
>>
>>> +#include <linux/clockchips.h>
>>
>> ^^^^^
>>
>>> +#include <linux/cpu_pm.h>
>>> +#include <linux/clk.h>
>>
>> ^^^^
>>
>>> +#include <linux/err.h>
>>> +#include <linux/of.h>
>>> +#include <asm/proc-fns.h>
>>> +#include <asm/cpuidle.h>
>>> +
>>> +#define ZYNQ_MAX_STATES		2
>>> +
>>> +static DEFINE_PER_CPU(struct cpuidle_device, zynq_cpuidle_device);
>>
>> see below.
>>
>>> +
>>> +/* Actual code that puts the SoC in different idle states */
>>> +static int zynq_enter_idle(struct cpuidle_device *dev,
>>> +		struct cpuidle_driver *drv, int index)
>>
>> Indentation.
>>
>>> +{
>>> +	/* Devices must be stopped here */
>>> +	cpu_pm_enter();
>>> +
>>> +	/* Add code for DDR self refresh start */
>>> +	cpu_do_idle();
>>> +
>>> +	/* Add code for DDR self refresh stop */
>>> +	cpu_pm_exit();
>>> +
>>> +	return index;
>>> +}
>>> +
>>> +static struct cpuidle_driver zynq_idle_driver =3D {
>>> +	.name =3D "zynq_idle",
>>> +	.owner =3D THIS_MODULE,
>>> +	.states =3D {
>>> +		ARM_CPUIDLE_WFI_STATE,
>>> +		{
>>> +			.enter            =3D zynq_enter_idle,
>>> +			.exit_latency     =3D 10,
>>> +			.target_residency =3D 10000,
>>> +			.flags            =3D CPUIDLE_FLAG_TIME_VALID,
>>> +					    CPUIDLE_FLAG_TIMER_STOP,
>>> +			.name             =3D "RAM_SR",
>>> +			.desc             =3D "WFI and RAM Self Refresh",
>>> +		},
>>> +	},
>>> +	.safe_state_index =3D 0,
>>> +	.state_count =3D ZYNQ_MAX_STATES,
>>> +};
>>> +
>>> +/* Initialize CPU idle by registering the idle states */
>>> +static int zynq_init_cpuidle(void)
>>> +{
>>> +	unsigned int cpu;
>>> +	struct cpuidle_device *device;
>>> +	int ret;
>>> +
>>> +	if (!of_machine_is_compatible("xlnx,zynq-7000"))
>>> +		return -ENODEV;
>>> +
>>> +	ret =3D cpuidle_register_driver(&zynq_idle_driver);
>>> +	if (ret) {
>>> +		pr_err("%s: Driver registration failed\n", __func__);
>>> +		return ret;
>>> +	}
>>> +
>>> +	for_each_possible_cpu(cpu) {
>>> +		device =3D &per_cpu(zynq_cpuidle_device, cpu);
>>> +		device->cpu =3D cpu;
>>> +		ret =3D cpuidle_register_device(device);
>>> +		if (ret) {
>>> +			pr_err("%s: Device registration failed\n", __func__);
>>> +			return ret;
>>> +		}
>>> +	}
>>> +
>>> +	pr_info("Xilinx Zynq CpuIdle Driver started\n");
>>
>> Hi Michal,
>>
>> actually you can replace this code by
>>
>> cpuidle_register(&zynq_idle_driver, NULL);
>>
>> and remove the zynq_cpuidle_device.
>>
>> The framework will take care of registering the driver and the devic=
es.
>=20
> Will change.
>=20
>=20
>>> +	return 0;
>>> +}
>>> +module_init(zynq_init_cpuidle);
>>
>> Do you really want it as module ?
>=20
> kirkwood is a module
> but in Makefile depends directly on ARCH
> obj-$(CONFIG_ARCH_KIRKWOOD) +=3D cpuidle-kirkwood.o
>=20
> Calxeda uses module_init() which is in this configuration device_init=
call.
>=20
> Any advantage to write it as module?
> Maybe for testing purpose will be helpful to have it as module too.
> What do you think?

I don't see any reasons it couldn't be written as a module. It is up to
you, if you think there could be any benefit on that, feel free to writ=
e
it as a module. Otherwise it could be enabled in the kernel.

If it is only for testing purpose, that means a very specific use case
where the module is loaded from NFS and a server doing cross compiling.
Not sure it is worth to do finally.

In the future, I hope we can do a single entry for an ARM driver based
on the device tree choosing the right back end driver in the case of th=
e
single kernel image. In this case, it won't be consistent to have some
of the drivers being modules and others not. But the future does not
exist (yet) ... :)

I am a bit worried about the moment the driver is initialized because i=
f
we try to make all the drivers to converge to a single one, that means
it will be initialized at a moment compatible with all the drivers.

Just to summarize:

cpuidle framework: core_initcall

calxeda:     module_platform_driver =3D> module_init
kirkwood:    module_init
davinci      device_initcall
omap3/omap4: device_initcall
at91:        device_initcall
shmobile:    init_late
imx5/6:      init_late
s3c64:       device_initcall
ux500:       device_initcall
tegra1/2/3:  device_initcall


> BTW: I will also add entry to MAINTAINERS file and list myself in thi=
s header.

Yes, please do. That will help to ensure your acked-by.

Thanks
  -- Daniel

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

