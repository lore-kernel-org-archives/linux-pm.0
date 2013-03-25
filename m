From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 07/15] ARM: cpuidle: add init/exit routine
Date: Mon, 25 Mar 2013 19:33:23 +0100
Message-ID: <51509873.1010408@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org> <20130325181038.GA631@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:59247 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932672Ab3CYSdY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 14:33:24 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm11so11405030wib.3
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 11:33:23 -0700 (PDT)
In-Reply-To: <20130325181038.GA631@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: rjw@sisk.pl, tglx@linutronix.de, patches@linaro.org, linaro-kernel@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux@maxim.org.za, nicolas.ferre@atmel.com, plagnioj@jcrosoft.com, lenb@kernel.org, nsekhar@ti.com, kevin.hilman@linaro.org, horms@verge.net.au, magnus.damm@gmail.com, kernel@pengutronix.de, ben-linux@fluff.org, kgene.kim@samsung.com, rob.herring@calxeda.com, jason@lakedaemon.net, linus.walleij@linaro.org, linux@arm.linux.org.uk

On 03/25/2013 07:10 PM, Andrew Lunn wrote:
> On Mon, Mar 25, 2013 at 06:55:32PM +0100, Daniel Lezcano wrote:
>> The init and exit routine for most of the drivers are the same,
>> that is register the driver and register the device.
>>
>> Provide a common function to do that in the cpuidle driver for ARM,
>> so we can get rid of a lot of code duplication in the different SOC
>> cpuidle drivers.
>=20
> Hi Daniel
>=20
> Please could you add a comment in the code about which piece is
> specific to ARM, because its not obvious to me. Its not like there is
> a reference to WFI for example. It looks like this code could go in
> drivers/cpuidle/cpuidle.c

Yes, I agree. At the first glance, the code, as it is, could go in this
file but more ARM specific code will be moved to this ARM generic code
driver like device tree description and couple idle states. The init
function would be more arch specific then.

=46or this reason, I think it is reasonable to move to
arm/kernel/cpuidle.c rather than drivers/cpuidle/cpuidle.c first.

In the future, when all the ARM cpuidle driver will be fully
consolidated, that will be easier to identify the common parts across
the different arch and then move them to the generic framework.

>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/include/asm/cpuidle.h |    4 +++
>>  arch/arm/kernel/cpuidle.c      |   57 +++++++++++++++++++++++++++++=
++++++++++-
>>  2 files changed, 60 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/include/asm/cpuidle.h b/arch/arm/include/asm/c=
puidle.h
>> index 7367787..83a38ac 100644
>> --- a/arch/arm/include/asm/cpuidle.h
>> +++ b/arch/arm/include/asm/cpuidle.h
>> @@ -4,6 +4,10 @@
>>  extern int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>>  				    struct cpuidle_driver *drv, int index);
>> =20
>> +extern int arm_cpuidle_init(struct cpuidle_driver *drv);
>> +
>> +extern void arm_cpuidle_exit(struct cpuidle_driver *drv);
>> +
>>  /* Common ARM WFI state */
>>  #define ARM_CPUIDLE_WFI_STATE_PWR(p) {\
>>  	.enter                  =3D arm_cpuidle_simple_enter,\
>> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
>> index 89545f6..13cfe3e 100644
>> --- a/arch/arm/kernel/cpuidle.c
>> +++ b/arch/arm/kernel/cpuidle.c
>> @@ -9,13 +9,68 @@
>>   * http://www.gnu.org/copyleft/gpl.html
>>   */
>> =20
>> +#include <linux/module.h>
>>  #include <linux/cpuidle.h>
>>  #include <asm/proc-fns.h>
>> =20
>> +static DEFINE_PER_CPU(struct cpuidle_device, cpuidle_device);
>> +
>>  int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>> -		struct cpuidle_driver *drv, int index)
>> +			     struct cpuidle_driver *drv, int index)
>>  {
>>  	cpu_do_idle();
>> =20
>>  	return index;
>>  }
>> +
>> +int __init arm_cpuidle_init(struct cpuidle_driver *drv)
>> +{
>> +       int ret, cpu;
>> +       struct cpuidle_device *device;
>> +
>> +       ret =3D cpuidle_register_driver(drv);
>> +       if (ret) {
>> +               printk(KERN_ERR "failed to register idle driver '%s'=
\n",
>> +                       drv->name);
>> +               return ret;
>> +       }
>> +
>> +       for_each_online_cpu(cpu) {
>> +
>> +               device =3D &per_cpu(cpuidle_device, cpu);
>> +               device->cpu =3D cpu;
>> +               ret =3D cpuidle_register_device(device);
>> +               if (ret) {
>> +                       printk(KERN_ERR "Failed to register cpuidle =
"
>> +                              "device for cpu%d\n", cpu);
>> +                       goto out_unregister;
>> +               }
>> +       }
>> +
>> +out:
>> +       return ret;
>> +
>> +out_unregister:
>> +       for_each_online_cpu(cpu) {
>> +               device =3D &per_cpu(cpuidle_device, cpu);
>> +               cpuidle_unregister_device(device);
>> +       }
>> +
>> +       cpuidle_unregister_driver(drv);
>> +       goto out;
>> +}
>> +EXPORT_SYMBOL_GPL(arm_cpuidle_init);
>> +
>> +void __exit arm_cpuidle_exit(struct cpuidle_driver *drv)
>> +{
>> +	int cpu;
>> +	struct cpuidle_device *device;
>> +
>> +	for_each_online_cpu(cpu) {
>> +		device =3D &per_cpu(cpuidle_device, cpu);
>> +		cpuidle_unregister_device(device);
>> +	}
>> +
>> +	cpuidle_unregister_driver(drv);
>> +}
>> +EXPORT_SYMBOL_GPL(arm_cpuidle_exit);
>> --=20
>> 1.7.9.5
>>


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

