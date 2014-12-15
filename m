From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCHv2 1/7] devfreq: event: Add new devfreq_event class to
 provide basic data for devfreq governor
Date: Mon, 15 Dec 2014 11:30:28 +0100
Message-ID: <1418639428.7591.5.camel@AMDC1943>
References: <1418134386-14681-1-git-send-email-cw00.choi@samsung.com>
 <1418134386-14681-2-git-send-email-cw00.choi@samsung.com>
 <1418204220.16644.14.camel@AMDC1943> <5488FDCE.2060009@samsung.com>
 <548A643D.10508@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <548A643D.10508-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On pi=C4=85, 2014-12-12 at 12:42 +0900, Chanwoo Choi wrote:
> Hi Krzysztof,
>=20
> I replied again this mail because I'll use the mutex for set_event()/=
get_event()
> according to your comment. But, of_parse_phandle() seems that this fu=
nction
> don't need the of_node_put() function.
>=20
>=20
> On 12/11/2014 11:13 AM, Chanwoo Choi wrote:
> > Hi Krzysztof,
> >=20
> > First of all, thanks for your review.
> >=20
> > On 12/10/2014 06:37 PM, Krzysztof Kozlowski wrote:
> >> On wto, 2014-12-09 at 23:13 +0900, Chanwoo Choi wrote:
> >>> This patch add new devfreq_event class for devfreq_event device w=
hich provide
> >>> raw data (e.g., memory bus utilization/GPU utilization). This raw=
 data from
> >>> devfreq_event data would be used for the governor of devfreq subs=
ystem.
> >>> - devfreq_event device : Provide raw data for governor of existin=
g devfreq device
> >>> - devfreq device       : Monitor device state and change frequenc=
y/voltage of device
> >>>                          using the raw data from devfreq_event de=
vice
> >>>
> >>> The devfreq subsystem support generic DVFS(Dynamic Voltage/Freque=
ncy Scaling)
> >>> for Non-CPU Devices. The devfreq device would dertermine current =
device state
> >>> using various governor (e.g., ondemand, performance, powersave). =
After completed
> >>> determination of system state, devfreq device would change the fr=
equency/voltage
> >>> of devfreq device according to the result of governor.
> >>>
> >>> But, devfreq governor must need basic data which indicates curren=
t device state.
> >>> Existing devfreq subsystem only consider devfreq device which che=
ck current system
> >>> state and determine proper system state using basic data. There i=
s no subsystem
> >>> for device providing basic data to devfreq device.
> >>>
> >>> The devfreq subsystem must need devfreq_event device(data-provide=
r device) for
> >>> existing devfreq device. So, this patch add new devfreq_event cla=
ss for
> >>> devfreq_event device which read various basic data(e.g, memory bu=
s utilization,
> >>> GPU utilization) and provide measured data to existing devfreq de=
vice through
> >>> standard APIs of devfreq_event class.
> >>>
> >>> The following description explains the feature of two kind of dev=
freq class:
> >>> - devfreq class (existing)
> >>>  : devfreq consumer device use raw data from devfreq_event device=
 for
> >>>    determining proper current system state and change voltage/fre=
quency
> >>>    dynamically using various governors.
> >>>
> >>> - devfreq_event class (new)
> >>>  : Provide measured raw data to devfreq device for governor
> >>>
> >>> Cc: MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >>> Cc: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >>> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >>> ---
> >>>  drivers/devfreq/Kconfig         |   2 +
> >>>  drivers/devfreq/Makefile        |   5 +-
> >>>  drivers/devfreq/devfreq-event.c | 302 ++++++++++++++++++++++++++=
++++++++++++++
> >>>  drivers/devfreq/event/Makefile  |   1 +
> >>>  include/linux/devfreq.h         | 141 +++++++++++++++++++
> >>>  5 files changed, 450 insertions(+), 1 deletion(-)
> >>>  create mode 100644 drivers/devfreq/devfreq-event.c
> >>>  create mode 100644 drivers/devfreq/event/Makefile
> >>>
> >>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
> >>> index faf4e70..4d15b62 100644
> >>> --- a/drivers/devfreq/Kconfig
> >>> +++ b/drivers/devfreq/Kconfig
> >>> @@ -87,4 +87,6 @@ config ARM_EXYNOS5_BUS_DEVFREQ
> >>>  	  It reads PPMU counters of memory controllers and adjusts the
> >>>  	  operating frequencies and voltages with OPP support.
> >>> =20
> >>> +comment "DEVFREQ Event Drivers"
> >>> +
> >>>  endif # PM_DEVFREQ
> >>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
> >>> index 16138c9..a1ffabe 100644
> >>> --- a/drivers/devfreq/Makefile
> >>> +++ b/drivers/devfreq/Makefile
> >>> @@ -1,4 +1,4 @@
> >>> -obj-$(CONFIG_PM_DEVFREQ)	+=3D devfreq.o
> >>> +obj-$(CONFIG_PM_DEVFREQ)		+=3D devfreq.o devfreq-event.o
> >>>  obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+=3D governor_simpleon=
demand.o
> >>>  obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+=3D governor_performance.=
o
> >>>  obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+=3D governor_powersave.o
> >>> @@ -7,3 +7,6 @@ obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor=
_userspace.o
> >>>  # DEVFREQ Drivers
> >>>  obj-$(CONFIG_ARM_EXYNOS4_BUS_DEVFREQ)	+=3D exynos/
> >>>  obj-$(CONFIG_ARM_EXYNOS5_BUS_DEVFREQ)	+=3D exynos/
> >>> +
> >>> +# DEVFREQ Event Drivers
> >>> +obj-$(CONFIG_PM_DEVFREQ)		+=3D event/
> >>> diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/de=
vfreq-event.c
> >>> new file mode 100644
> >>> index 0000000..b47329f
> >>> --- /dev/null
> >>> +++ b/drivers/devfreq/devfreq-event.c
> >>> @@ -0,0 +1,302 @@
> >>> +/*
> >>> + * devfreq-event: Generic DEVFREQ Event class driver
> >>> + *
> >>> + * Copyright (C) 2014 Samsung Electronics
> >>> + * Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> >>> + *
> >>> + * This program is free software; you can redistribute it and/or=
 modify
> >>> + * it under the terms of the GNU General Public License version =
2 as
> >>> + * published by the Free Software Foundation.
> >>> + *
> >>> + * This driver is based on drivers/devfreq/devfreq.c
> >>> + */
> >>> +
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/sched.h>
> >>> +#include <linux/errno.h>
> >>> +#include <linux/err.h>
> >>> +#include <linux/init.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/slab.h>
> >>> +#include <linux/stat.h>
> >>> +#include <linux/pm_opp.h>
> >>> +#include <linux/devfreq.h>
> >>> +#include <linux/workqueue.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/list.h>
> >>> +#include <linux/printk.h>
> >>> +#include <linux/hrtimer.h>
> >>> +#include <linux/of.h>
> >>> +#include "governor.h"
> >>> +
> >>> +static struct class *devfreq_event_class;
> >>> +
> >>> +/* The list of all devfreq event list */
> >>> +static LIST_HEAD(devfreq_event_list);
> >>> +static DEFINE_MUTEX(devfreq_event_list_lock);
> >>> +
> >>> +#define to_devfreq_event(DEV) container_of(DEV, struct devfreq_e=
vent_dev, dev)
> >>> +
> >>> +struct devfreq_event_dev *devfreq_add_event_device(struct device=
 *dev,
> >>> +					struct devfreq_event_desc *desc)
> >>> +{
> >>> +	struct devfreq_event_dev *event_dev;
> >>> +	static atomic_t event_no =3D ATOMIC_INIT(0);
> >>> +	int ret;
> >>> +
> >>> +	if (!dev || !desc)
> >>> +		return ERR_PTR(-EINVAL);
> >>> +
> >>> +	if (!desc->name || !desc->ops)
> >>> +		return ERR_PTR(-EINVAL);
> >>> +
> >>> +	event_dev =3D kzalloc(sizeof(struct devfreq_event_dev), GFP_KER=
NEL);
> >>> +	if (!event_dev)
> >>> +		return ERR_PTR(-ENOMEM);
> >>
> >> Is this memory freed anywhere when driver is removed? I couldn't f=
ind
> >> it. I couldn't also find function like devfreq_remove_event_device=
()
> >> which would be reverting all the work done when adding.
> >=20
> > You're right. I'll use devm_kzalloc instead of kzalloc.
> >=20
> >>
> >>> +
> >>> +	mutex_lock(&devfreq_event_list_lock);
> >>> +
> >>> +	mutex_init(&event_dev->lock);
> >>> +	event_dev->desc =3D desc;
> >>> +	event_dev->dev.parent =3D dev;
> >>> +	event_dev->dev.class =3D devfreq_event_class;
> >>> +
> >>> +	dev_set_name(&event_dev->dev, "event.%d",
> >>> +		     atomic_inc_return(&event_no) - 1);
> >>> +	ret =3D device_register(&event_dev->dev);
> >>> +	if (ret !=3D 0) {
> >>> +		put_device(&event_dev->dev);
> >>> +		goto err;
> >>> +	}
> >>> +	dev_set_drvdata(&event_dev->dev, event_dev);
> >>> +
> >>> +	/* Add devfreq event device to devfreq_event_list */
> >>> +	INIT_LIST_HEAD(&event_dev->node);
> >>> +	list_add(&event_dev->node, &devfreq_event_list);
> >>> +
> >>> +	mutex_unlock(&devfreq_event_list_lock);
> >>> +
> >>> +	return event_dev;
> >>> +err:
> >>
> >> Missing 'mutex_unlock(&devfreq_event_list_lock)' here.
> >=20
> > OK. I'll fix it.
> >=20
> >>
> >>
> >>> +	kfree(event_dev);
> >>> +	return ERR_PTR(ret);
> >>> +}
> >>> +EXPORT_SYMBOL(devfreq_add_event_device);
> >>> +
> >>> +struct devfreq_event_dev *devfreq_get_event_dev(const char *even=
t_dev_name)
> >>> +{
> >>> +	struct devfreq_event_dev *event_dev;
> >>> +
> >>> +	mutex_lock(&devfreq_event_list_lock);
> >>> +	list_for_each_entry(event_dev, &devfreq_event_list, node) {
> >>> +		if (!strcmp(event_dev->desc->name, event_dev_name))
> >>> +			goto out;
> >>> +	}
> >>> +	event_dev =3D NULL;
> >>> +out:
> >>> +	mutex_unlock(&devfreq_event_list_lock);
> >>> +
> >>> +	return event_dev;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(devfreq_get_event_dev);
> >>> +
> >>> +struct devfreq_event_dev *devfreq_get_event_dev_by_phandle(struc=
t device *dev,
> >>> +						      int index)
> >>> +{
> >>> +	struct device_node *node;
> >>> +	struct devfreq_event_dev *event_dev;
> >>> +
> >>> +	if (!dev->of_node) {
> >>> +		dev_err(dev, "device does not have a device node entry\n");
> >>> +		return ERR_PTR(-EINVAL);
> >>> +	}
> >>> +
> >>> +	node =3D of_parse_phandle(dev->of_node, "devfreq-events", index=
);
> >>> +	if (!node) {
> >>> +		dev_err(dev, "failed to get phandle in %s node\n",
> >>> +			dev->of_node->full_name);
> >>> +		return ERR_PTR(-ENODEV);
> >>> +	}
> >>> +
> >>> +	event_dev =3D devfreq_get_event_dev(node->name);
> >>> +	if (!event_dev) {
> >>> +		dev_err(dev, "unable to get devfreq-event device : %s\n",
> >>> +			node->name);
> >>
> >> of_node_put() for node obtained with of_parse_phandle().
> >=20
> > OK. I'll add it.
>=20
> of_parse_phandle() seems that it don't need of_node_put().

The of_parse_phandle() increases the refcount for node it returns.
=46rom documentation:

/**
 * Returns the device_node pointer with refcount incremented.  Use
 * of_node_put() on it when done.
 */

The function returns error condition but node was found and its refcnt
was incremented. Then why do you think that of_node_put() is not
necessary here?

>=20
> >=20
> >>
> >>> +		return ERR_PTR(-ENODEV);
> >>> +	}
> >>> +
> >>> +	return event_dev;
> >>> +}
> >>> +EXPORT_SYMBOL_GPL(devfreq_get_event_dev_by_phandle);
> >>> +
> >>> +int devfreq_put_event_dev(struct devfreq_event_dev *event_dev)
> >>> +{
> >>
> >> of_node_put() here to decrement refcnt from of_parse_phandle()?
> >=20
> > It is my mistake. I think that devfreq_put_event_dev is not necesss=
ary.
> > I'll remove it.

Then how to decrease the refcnt for node obtained in
devfreq_get_event_dev_by_phandle()?

Best regards,
Krzysztof

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
