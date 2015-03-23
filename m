From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH V3 7/8] ARM: cpuidle: Register per cpuidle device
Date: Mon, 23 Mar 2015 16:25:14 +0000
Message-ID: <20150323162514.GE18904@red-moon>
References: <1426851841-2072-1-git-send-email-daniel.lezcano@linaro.org>
 <1426851841-2072-8-git-send-email-daniel.lezcano@linaro.org>
 <20150321203546.GE22354@red-moon>
 <5510340E.7000802@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5510340E.7000802@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 23, 2015 at 03:41:02PM +0000, Daniel Lezcano wrote:
> On 03/21/2015 09:35 PM, Lorenzo Pieralisi wrote:
> > On Fri, Mar 20, 2015 at 11:44:00AM +0000, Daniel Lezcano wrote:
> >> Some architectures have some cpus which does not support idle stat=
es.
> >>
> >> Let the underlying low level code to return -ENXIO when it is not
> >> possible to set an idle state.
> >
> > Well, this is getting interesting. We are parsing possible CPUs to
> > detect if they have common idle states in DT. If a CPU does not sup=
port
> > idle states, the cpu node for that CPU should not define any idle
> > state.
> >
> > The approach above will work with my heterogenous system patch, sin=
ce
> > the respective CPUidle driver mask will be created by parsing the D=
T
> > idle states.
> >
> > http://www.spinics.net/lists/arm-kernel/msg403190.html
> >
> > In current approach if a "possible " CPU does not have idle states,=
 we do
> > not init CPUidle at all.
> >
> > So, to cut a long story short, what does "a cpu does not support id=
le
> > states" mean ?
> >
> > Does it mean that firmware defines idle states for that CPU in DT b=
ut
> > initializing them fail ?
> >
> > I am fine with this patch, but we need to define -ENXIO return prop=
erly.
>=20
> Ok, so after discussing with Lina, it appears my change log is not co=
rrect.
>=20
> In Qcom's platform, each core has a SPM. The device associated with t=
his=20
> SPM is initialized before the cpuidle framework. If there is an error=
 in=20
> the initialization (eg. error in the DT), the system continues to boo=
t=20
> but in degraded mode as some SPM may not be correctly initialized. In=
=20
> this case, the EXNIO tells the cpuidle driver to not initialize the=20
> cpuidle device as the associated SPM is not operational. That prevent=
s=20
> the system to crash and allows to handle the error gracefully.

This makes more sense. I think that the whole cpu init idle code should
be moved to arch code along with the DT idle states parsing, now we
parse DT idle states in two code paths and that's prone to error, but
I think that can be done later.

Lorenzo

> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>   drivers/cpuidle/cpuidle-arm.c | 42 +++++++++++++++++++++++++++++=
+++++++++++--
> >>   1 file changed, 40 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuid=
le-arm.c
> >> index 1c94b88..e4a6eba 100644
> >> --- a/drivers/cpuidle/cpuidle-arm.c
> >> +++ b/drivers/cpuidle/cpuidle-arm.c
> >> @@ -17,6 +17,7 @@
> >>   #include <linux/kernel.h>
> >>   #include <linux/module.h>
> >>   #include <linux/of.h>
> >> +#include <linux/slab.h>
> >>
> >>   #include <asm/cpuidle.h>
> >>
> >> @@ -94,6 +95,7 @@ static int __init arm_idle_init(void)
> >>   {
> >>   	int cpu, ret;
> >>   	struct cpuidle_driver *drv =3D &arm_idle_driver;
> >> +	struct cpuidle_device *dev;
> >>
> >>   	/*
> >>   	 * Initialize idle states data, starting at index 1.
> >> @@ -105,18 +107,54 @@ static int __init arm_idle_init(void)
> >>   	if (ret <=3D 0)
> >>   		return ret ? : -ENODEV;
> >>
> >> +	ret =3D cpuidle_register_driver(drv);
> >> +	if (ret) {
> >> +		pr_err("Failed to register cpuidle driver\n");
> >> +		return ret;
> >> +	}
> >> +
> >>   	/*
> >>   	 * Call arch CPU operations in order to initialize
> >>   	 * idle states suspend back-end specific data
> >>   	 */
> >>   	for_each_possible_cpu(cpu) {
> >>   		ret =3D arm_cpuidle_init(cpu);
> >> +
> >> +		/* This cpu does not support any idle states */
> >
> > We need to define what this means. If it means a cpu with no idle
> > states in its cpu node the parsing would not even get here since
> > to init the driver all possible cpus have to have the *same* idle s=
tates to
> > function at present.
> >
> > Lorenzo
> >
> >> +		if (ret =3D=3D -ENXIO)
> >> +			continue;
> >> +
> >>   		if (ret) {
> >>   			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
> >> -			return ret;
> >> +			goto out_fail;
> >> +		}
> >> +
> >> +		dev =3D kzalloc(sizeof(*dev), GFP_KERNEL);
> >> +		if (!dev) {
> >> +			pr_err("Failed to allocate cpuidle device\n");
> >> +			goto out_fail;
> >> +		}
> >> +		dev->cpu =3D cpu;
> >> +
> >> +		ret =3D cpuidle_register_device(dev);
> >> +		if (ret) {
> >> +			pr_err("Failed to register cpuidle device for CPU %d\n",
> >> +			       cpu);
> >> +			kfree(dev);
> >> +			goto out_fail;
> >>   		}
> >>   	}
> >>
> >> -	return cpuidle_register(drv, NULL);
> >> +	return 0;
> >> +out_fail:
> >> +	while (--cpu >=3D 0) {
> >> +		dev =3D per_cpu(cpuidle_devices, cpu);
> >> +		cpuidle_unregister_device(dev);
> >> +		kfree(dev);
> >> +	}
> >> +
> >> +	cpuidle_unregister_driver(drv);
> >> +
> >> +	return ret;
> >>   }
> >>   device_initcall(arm_idle_init);
> >> --
> >> 1.9.1
> >>
> >>
>=20
>=20
> --=20
>   <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software =
for ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>=20
>=20
