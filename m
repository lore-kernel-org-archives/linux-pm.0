From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v6 06/21] PM / devfreq: Add new passive governor
Date: Mon, 28 Mar 2016 15:54:23 +0900
Message-ID: <56F8D51F.1030306@samsung.com>
References: <1314094711.28841459134703593.JavaMail.weblogic@epmlwas02a>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1314094711.28841459134703593.JavaMail.weblogic@epmlwas02a>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, =?UTF-8?B?7YGs7Ims7Iuc7Yag7ZSE?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "m.reichl@fivetechno.de" <m.reichl@fivetechno.de>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, =?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2016=EB=85=84 03=EC=9B=94 28=EC=9D=BC 12:11, MyungJoo Ham wrote:
> []
>> Suggested-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> [tjakobi: Reported RCU locking issue and cw00.choi fix it.]
>> Reported-by: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
>> [m.reichl and linux.amoon: Tested it on exynos4412-odroidu3 board]
>> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  drivers/devfreq/Kconfig            |   7 ++
>>  drivers/devfreq/Makefile           |   1 +
>>  drivers/devfreq/devfreq.c          |  17 ++++
>>  drivers/devfreq/governor.h         |  15 +++
>>  drivers/devfreq/governor_passive.c | 192 ++++++++++++++++++++++++++=
+++++++++++
>>  include/linux/devfreq.h            |   3 +
>>  6 files changed, 235 insertions(+)
>>  create mode 100644 drivers/devfreq/governor_passive.c
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>=20
> []
>=20
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>> index 8af8aaf922a8..2633087d5c63 100644
>> --- a/drivers/devfreq/Makefile
>> +++ b/drivers/devfreq/Makefile
>> @@ -4,6 +4,7 @@ obj-$(CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND)	+=3D gover=
nor_simpleondemand.o
>>  obj-$(CONFIG_DEVFREQ_GOV_PERFORMANCE)	+=3D governor_performance.o
>>  obj-$(CONFIG_DEVFREQ_GOV_POWERSAVE)	+=3D governor_powersave.o
>>  obj-$(CONFIG_DEVFREQ_GOV_USERSPACE)	+=3D governor_userspace.o
>> +obj-$(CONFIG_DEVFREQ_GOV_PASSIVE)	+=3D governor_passive.o
>> =20
>>  # DEVFREQ Drivers
>>  obj-$(CONFIG_ARM_EXYNOS_BUS_DEVFREQ)	+=3D exynos-bus.o
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 1d6c803804d5..9f84bbc2994c 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -478,7 +478,13 @@ static void _remove_devfreq(struct devfreq *dev=
freq)
>>  		dev_warn(&devfreq->dev, "releasing devfreq which doesn't exist\n"=
);
>>  		return;
>>  	}
>> +
>> +	if (devfreq->governor->type =3D=3D DEVFREQ_GOV_PASSIVE)
>> +		devfreq_passive_unregister_notifier(devfreq);
>> +
>>  	list_del(&devfreq->node);
>> +	list_del_init(&devfreq->passive_node);
>> +
>=20
> Let's do this inside governor_passive.c, you already have
> the DEVFREQ_GOV_STOP signal. This may be called more frequently
> because the START-STOP pair has wider usage than add-remove pair.
> However, still, it's ok to be detached during the "STOP"ed but not
> removed state.

I agree the code about passive governor to drivers/devfreq/governor_pas=
sive.c.
It makes the code clear.

>=20
>>  	mutex_unlock(&devfreq_list_lock);
>> =20
>>  	if (devfreq->governor)
>> @@ -598,6 +604,17 @@ struct devfreq *devfreq_add_device(struct devic=
e *dev,
>>  		goto err_init;
>>  	}
>> =20
>> +	if (devfreq->governor->type =3D=3D DEVFREQ_GOV_PASSIVE) {
>> +		struct devfreq *parent_devfreq =3D (struct devfreq *)data;
>> +		list_add(&devfreq->passive_node, &parent_devfreq->passive_node);
>> +
>> +		err =3D devfreq_passive_register_notifier(devfreq);
>> +		if (err <0)
>> +			goto err_init;
>> +	} else {
>> +		INIT_LIST_HEAD(&devfreq->passive_node);
>> +	}
>> +
>=20
> Same as above. We can reuse DEVFREQ_GOV_START for this.
> With DEVFREQ_GOV_START/STOP, we can entirely remove any modifications
> in the devfreq.c, governor.h, devfreq.h.

I agree. I'll modify it.

>=20
> Besides, such an approach removed the need for the patch 05/21.
> We no longer (or yet) need "governor type".
>=20
>>  	return devfreq;
>> =20
>>  err_init:
>> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
>> index cf19b923c362..64d1dffcdb43 100644
>> --- a/drivers/devfreq/governor.h
>> +++ b/drivers/devfreq/governor.h
>=20
> as mentioned above, we don't need to modify this file.

OK.

>=20
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/go=
vernor_passive.c
>> new file mode 100644
>> index 000000000000..521e93b68c11
>> --- /dev/null
>> +++ b/drivers/devfreq/governor_passive.c
>> @@ -0,0 +1,192 @@
>> +/*
>> + * linux/drivers/devfreq/governor_passive.c
>> + *
>> + * Copyright (C) 2016 Samsung Electronics
>> + * Author: Chanwoo Choi <cw00.choi@samsung.com>
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License version 2 a=
s
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <linux/devfreq.h>
>> +#include <linux/module.h>
>> +#include <linux/device.h>
>> +#include <linux/devfreq.h>
>=20
> Doubly included

I'll fix it.

>=20
>> +#include "governor.h"
>> +
>=20
> []
>=20
>> +static int devfreq_passive_event_handler(struct devfreq *devfreq,
>> +				unsigned int event, void *data)
>> +{
>> +	return 0;
>=20
> Let's handle DEVFREQ_GOV_START/STOP event here.

OK. I'll register/unregister the DEVFREQ_TRANSITION_NOTIFIER by using
DEVFREQ_GOV_START/STOP event.

>=20
>> +}
>> +
>> +static struct devfreq_governor devfreq_passive =3D {
>> +	.name =3D "passive",
>> +	.type =3D DEVFREQ_GOV_PASSIVE,
>=20
> Let's not use .type enum, yet. We don't this this. At least for now.

OK. I'll remove it.

>=20
>> +	.get_target_freq =3D devfreq_passive_get_target_freq,
>> +	.event_handler =3D devfreq_passive_event_handler,
>> +};
>> +
>=20
> []
>=20
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h


When the devfreq device using passive governor registers the notifier
to DEVFREQ_TRANSITION_NOTIFIER, the devfreq device need the one notifie=
r block field
as following:

struct devfreq {
	...
	...
	struct notifier_block passive_nb;
}

static int devfreq_passive_event_handler(struct devfreq *devfreq,
                               unsigned int event, void *data)
{
       struct device *dev =3D devfreq->dev.parent;
       struct devfreq *parent =3D (struct devfreq *)devfreq->data;
       struct notifier_block *nb =3D &devfreq->passive_nb;
       int ret =3D 0;

       if (!parent)
               return -EPROBE_DEFER;

       switch (event) {
       case DEVFREQ_GOV_START:
               nb->notifier_call =3D devfreq_passive_notifier_call;
               ret =3D devm_devfreq_register_notifier(dev, parent, nb,
                                       DEVFREQ_TRANSITION_NOTIFIER);
               break;
       case DEVFREQ_GOV_STOP:
               devm_devfreq_unregister_notifier(dev, parent, nb,
                                       DEVFREQ_TRANSITION_NOTIFIER);
               break;
       default:
               break;
       }

       return ret;
}

Best Regards,
Chanwoo Choi
