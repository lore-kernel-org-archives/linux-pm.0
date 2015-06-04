From: "Grygorii.Strashko@linaro.org" <grygorii.strashko@linaro.org>
Subject: Re: [PATCH 00/21] On-demand device registration
Date: Thu, 04 Jun 2015 19:51:28 +0300
Message-ID: <55708210.7070007@linaro.org>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com> <CAL_Jsq+EWLEJhRudTGAwYsOg4tX2-pGhygeQGHae9RL8rBpMiA@mail.gmail.com> <556F5C24.1030101@linaro.org> <CAAObsKAFQrm-maqzadCELi2JVt5jd+yoqCbDpu5OP7gkSk8gcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAAObsKAFQrm-maqzadCELi2JVt5jd+yoqCbDpu5OP7gkSk8gcA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Linux USB List <linux-usb@vger.kernel.org>, Linux PWM List <linux-pwm@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Alexander Holler <holler@ahsoftware.de>, linux-clk@vger.kernel.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kern>
List-Id: linux-pm@vger.kernel.org

On 06/04/2015 11:39 AM, Tomeu Vizoso wrote:
> On 3 June 2015 at 21:57, Grygorii.Strashko@linaro.org
> <grygorii.strashko@linaro.org> wrote:
>> On 05/28/2015 07:33 AM, Rob Herring wrote:
>>> On Mon, May 25, 2015 at 9:53 AM, Tomeu Vizoso <tomeu.vizoso@collabo=
ra.com> wrote:
>>>> I have a problem with the panel on my Tegra Chromebook taking long=
er than
>>>> expected to be ready during boot (St=C3=A9phane Marchesin reported=
 what is
>>>> basically the same issue in [0]), and have looked into ordered pro=
bing as a
>>>> better way of solving this than moving nodes around in the DT or p=
laying with
>>>> initcall levels.
>>>>
>>>> While reading the thread [1] that Alexander Holler started with hi=
s series to
>>>> make probing order deterministic, it occurred to me that it should=
 be possible
>>>> to achieve the same by registering devices as they are referenced =
by other
>>>> devices.
>>>
>>> I like the concept and novel approach.
>>>
>>>> This basically reuses the information that is already implicit in =
the probe()
>>>> implementations, saving us from refactoring existing drivers or ad=
ding
>>>> information to DTBs.
>>>>
>>>> Something I'm not completely happy with is that I have had to move=
 the call to
>>>> of_platform_populate after all platform drivers have been register=
ed.
>>>> Otherwise I don't see how I could register drivers on demand as we=
 don't have
>>>> yet each driver's compatible strings.
>>>
>>> Yeah, this is the opposite of what we'd really like. Ideally, we wo=
uld
>>> have a solution that works for modules too. However, we're no worse
>>> off. We pretty much build-in dependencies to avoid module ordering
>>> problems.
>>>
>>> Perhaps we need to make the probing on-demand rather than simply on
>>> device<->driver match occurring.
>>>
>>>> For machs that don't move of_platform_populate() to a later point,=
 these
>>>> patches shouldn't cause any problems but it's not guaranteed that =
we'll avoid
>>>> all the deferred probes as some drivers may not be registered yet.
>>>
>>> Ideally, of_platform_populate is not explicitly called by each
>>> platform. So I think we need to make this work for the default case=
=2E
>>>
>>>> I have tested this on boards with Tegra, iMX.6 and Exynos SoCs, an=
d these
>>>> patches were enough to eliminate all the deferred probes.
>>>>
>>>> With this series I get the kernel to output to the panel in 0.5s, =
instead of 2.8s.
>>>
>>> That's certainly compelling.
>>
>> I've found your idea about moving device registration later during S=
ystem boot
>> very interesting so I've decided to try it on dra7-evem (TI) :).
>> It's good to know time during Kernel boot when we can assume that al=
l drivers are
>> ready for probing, so there are more ways to control probing order.
>=20
> Thanks, though right now I'm following Rob's suggestion and only dela=
y
> probing, not registration. The patch is really simple (applies on
> linux-next, with async probing):
>=20
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 8da8e07..7e6b1e1 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -407,6 +407,11 @@ int driver_probe_device(struct device_driver
> *drv, struct device *dev)
>          if (!device_is_registered(dev))
>                  return -ENODEV;
>=20
> +       if (!driver_deferred_probe_enable) {
> +               driver_deferred_probe_add(dev);
> +               return 0;
> +       }
> +
>          pr_debug("bus: '%s': %s: matched device %s with driver %s\n"=
,
>                   drv->bus->name, __func__, dev_name(dev), drv->name)=
;
>=20
> @@ -585,7 +590,7 @@ EXPORT_SYMBOL_GPL(device_attach);
>=20
>   void device_initial_probe(struct device *dev)
>   {
> -       __device_attach(dev, true);
> +       __device_attach(dev, driver_deferred_probe_enable);
>   }
>=20
>   static int __driver_attach(struct device *dev, void *data)

Can't boot my 3.14 kernel with this change :( Most probably,
the problem is related to platform_driver_probe() usage :(
Have no time to play with it now :(, but recommend you to check also
earlyprintk, last log message I can see:
[    1.435522] bootconsole [earlycon0] disabled

But, nice try ;) Seems -EPROBE_DEFER is reality of life which
has to be accepted as is.

>=20
>> Pls, Note here that TI OMAP2+ mach is not pure DT mach - it's combin=
ation of
>> DT and not DT devices/drivers.
>>
>> Ok. So What was done...
>>
>> LKML Linux 4.1-rc3 (a simple case)
>> 1) use your patches 3/4 as reference (only these two patches :)
>> 2) move of_platform_populate later at device_initcall_sync time
>> Boot time reduction ~0.4 sec
>=20
> I'm a bit surprised at such a big improvement. May I ask how you are
> measuring it?

Ah. My measurements are not precise. I've just tracking time of message
"[    4.110756] Freeing unused kernel memory: 344K (c0994000 - c09ea000=
)"

>=20
>> TI Android Kernel 3.14 (NOT a simple case)
>> 1) use your patches 3/4 as reference (only these two patches :)
>> 2) move of_platform_populate later at device_initcall_sync time
>> 3) make it to boot (not sure I've fixed all issues, but those which
>>     break the System boot):
>>   - split non-DT and DT devices registration in platform code;
>>   - keep non-DT devices registration from .init_machine() [arch_init=
call]
>>   - move DT-devices registration at device_initcall_sync time
>>   - fix drivers which use platform_driver_probe().
>>     Note. Now there are at about ~190 occurrences of this macro in K=
ernel.
>>   - re-order few devices in DT (4 devices)
>>   - fix one driver which uses of_find_device_by_node() wrongly
>>     Note. This API is used some times with assumption that
>>     requested dev has been probed already.
>> Boot time reduction ~0.3 sec. Probing of some devices are still defe=
rred.
>=20
> I got no deferred probes on a pandaboard with just these changes:
>=20
> https://git.collabora.com/cgit/user/tomeu/linux.git/commit/?id=3D1586=
c6f50b3d3c65dc219a3cdc3327d798cabca6

As I've mentioned I tried TI Android Kernel 3.14 where all DRA7 SoC fea=
tures are enabled.
It is very close to production SW. LKML, by default, enables
mostly nothing and not all features are supported.=20
In my prev exercise I was able to boot till Android GUI and it has work=
ed :)

Also, cool statistic - really_probe() was called 136 times for me
(successful execution of dev->bus->probe() and drv->probe()).

>=20
>> TI Android Kernel 3.14 + of_platform_device_ensure
>> 1) backport of_platform_device_ensure() (also need patches
>>     "of: Introduce device tree node flag helpers" and
>>     "of: Keep track of populated platform devices")
>> 2) back-port all your patches which uses of_platform_device_ensure()
>> 3) make it to boot:
>>     - drop patch dma: of: Probe DMA controllers on demand
>>     - fix deadlock in regulator core:
>>     regulator_dev_lookup() called from regulator_register() in K3.14
>> 4) get rid of deferred probes - add of_platform_device_ensure() call=
s in:
>>     - drivers/video/fbdev/omap2/dss/output.c
>>     - drivers/extcon/extcon-class.c
>>
>>   Boot time reduction: NONE !?
>>
>> So few comments from above:
>> - registering devices later during the System boot may improve boot =
time.
>>    But resolving of all deferred probes may NOT improve boot time ;)
>>    Have you seen smth like this?
>=20
> Yeah, I don't really expect for on-demand probing to improve boot tim=
e
> much in the general case, as drivers tend to first acquire resources
> (and defer probe if needed) and only then access hardware and wait fo=
r
> stuff to happen.
>=20
> The main advantage of ordered/ondemand probing is that it is much
> easier to see the order in which devices will be bound. In my case
> this is useful because one could get one device (eg. the drm panel) t=
o
> probe very early by just moving that node to the beginning of the DT.
> With deferred probe, one would have to figure out all the dependencie=
s
> and shuffle them around in the DT.
>=20
> Another advantage (but not the one why I'm doing this work) is that i=
n
> general a driver's probe will be called only once per device, and if
> it fails then we can be almost certain that something is wrong. This
> should aid in debugging as right now one has to take into account the
> several reasons why a device might defer its probe.
>=20
> Depending on what work your drivers do in your platform, enabling
> async probing for all of them may have a noticeable impact though.
>=20
>> - usage of of_platform_device_ensure() will require continuous fixin=
g of Kernel :(
>=20
> You mean adding those calls to more subsystems?

Exactly. Each time new framework will be introduced or reworked (or eve=
n for some drivers),
because each of them implement its own of_get_xxx() API.=20

>=20
>> - late_initcall is not (as for me not safe) a good time to register =
devices. A lot
>>    of platforms/subsystems/frameworks perform their final initializa=
tion or clean-up
>>    steps, with assumption that System mostly ready to work. For exam=
ple, CPUIdle/CPUFreq
>>    are allowed and other PM staff. CPUIdle and driver's probing are =
not friends.
>=20
> Yeah, I was expecting to find more problems due to this, but the
> platforms I tested on didn't show any. Do you have pointers to
> concrete issues?

No. This observation comes from my working experience with OMAP4 device=
s where
lowest possible CPUIdle state was mostly equal to Device-OFF state.=20
=46ast search has allowed me to find possible source of issues in code =
- I'm pretty sure
smth. similar can be found in other ARM maches:
- arch/arm/mach-omap2/omap_device.c -> omap_device_late_init().

>=20
>> What would be nice to have for now in my opinion:
>> - some useful place to move device population code.
>>    May be machine_desc->init_device_sync() callback.
>=20
> I'm looking at leave device registration where it currently is and
> just add devices to the deferred list until we get to late_initcall,
> where we would start to actually probe them. Seems promising for now.
>=20
>> - some optional feature in DTC which will allow to re-arrange DT nod=
es for levels 0(root)
>>    and 1(simple-bus) using standard or widely used bindings (gpio, r=
egulators, clocks, dma,
>>    pinctrl, irqs).
>=20
> Could you extend on this, please?

This is actually mostly the same idea as was mentioned by Rob Clark=20
http://www.spinics.net/lists/arm-kernel/msg423485.html


=46or example, mmc1 probe will be deferred always for below DT,
but if we put evm_3v3_sw before ocp and exchange mmc1 and i2c1
- mmc1 will be probed without deferring.
Potentially, It can be done in DTC where we do not have so strict limit=
s
as for Kernel code.=20

Soc file:
/ { /* root - level 0 */
	ocp { /* simple-bus - level 1 */
		compatible =3D  "simple-bus";

		mmc1: mmc@4809c000 {
			compatible =3D "mmc";
		...
		}

		i2c1: i2c@48070000 {
			compatible =3D "i2c";
		}
	}
}

board file:
#include "SoC.dtsi"

/ {
	evm_3v3_sw: fixedregulator-evm_3v3_sw {
		compatible =3D "regulator-fixed";
		regulator-name =3D "evm_3v3_sw";
		regulator-min-microvolt =3D <3300000>;
		regulator-max-microvolt =3D <3300000>;
	};
};

&i2c1 {
	pcf_gpio_21: gpio@21 {
		compatible =3D "ti,pcf8575";
		reg =3D <0x21>;
		lines-initial-states =3D <0x1408>;
		gpio-controller;
		#gpio-cells =3D <2>;
	};
}

&mmc1 {
	status =3D "okay";
	vmmc-supply =3D <&evm_3v3_sw>;
	bus-width =3D <4>;
	cd-gpios =3D <&pcf_gpio_21 5 0>;
};
=09


--=20
regards,
-grygorii
