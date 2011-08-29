From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v8 4/5] PM / DEVFREQ: add internal interfaces
	for governors
Date: Mon, 29 Aug 2011 12:21:10 -0700
Message-ID: <CAJOA=zNZekKJR_fOCAG4b+29QmEAKaBOb_QWBQ4Sb6GYrnYj8w@mail.gmail.com>
References: <1314086044-24659-1-git-send-email-myungjoo.ham@samsung.com>
	<1314174131-14194-1-git-send-email-myungjoo.ham@samsung.com>
	<1314174131-14194-5-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314174131-14194-5-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 24, 2011 at 1:22 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wr=
ote:
> - get_devfreq(): governors may convert struct dev -> struct devfreq
> - update_devfreq(): governors may notify DEVFREQ core to reevaluate
> frequencies.
> - Governors may have .init and .exit callbacks
>
> In order to use the internal interface, get_devfreq() and
> update_devfreq(), governor should include "governor.h"
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Please see patch 3 and 5 for my thoughts on locking in struct devfreq.
 Also, this patch doesn't need to be separate, but can be rolled into
patch 3.

Regards,
Mike

> ---
> =A0drivers/devfreq/devfreq.c =A0| =A0 32 ++++++++++++++++++++++++--------
> =A0drivers/devfreq/governor.h | =A0 20 ++++++++++++++++++++
> =A0include/linux/devfreq.h =A0 =A0| =A0 =A02 ++
> =A03 files changed, 46 insertions(+), 8 deletions(-)
> =A0create mode 100644 drivers/devfreq/governor.h
>
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 5bbece6..8de3b21 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -65,10 +65,10 @@ static struct devfreq *find_device_devfreq(struct dev=
ice *dev)
>
> =A0/**
> =A0* get_devfreq() - find devfreq struct. a wrapped find_device_devfreq()
> - * =A0 =A0 =A0 =A0 =A0 =A0 with mutex protection.
> + * =A0 =A0 =A0 =A0 =A0 =A0 with mutex protection. exported for governors
> =A0* @dev: =A0 =A0 =A0 device pointer used to lookup device devfreq.
> =A0*/
> -static struct devfreq *get_devfreq(struct device *dev)
> +struct devfreq *get_devfreq(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct devfreq *ret;
>
> @@ -113,17 +113,15 @@ static int devfreq_do(struct devfreq *devfreq)
> =A0}
>
> =A0/**
> - * devfreq_update() - Notify that the device OPP has been changed.
> - * @dev: =A0 =A0 =A0 the device whose OPP has been changed.
> + * update_devfreq() - Notify that the device OPP or frequency requirement
> + * =A0 =A0 =A0 =A0 =A0 =A0 has been changed. This function is exported f=
or governors.
> + * @devfreq: =A0 the devfreq instance.
> =A0*/
> -static int devfreq_update(struct notifier_block *nb, unsigned long type,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *devp)
> +int update_devfreq(struct devfreq *devfreq)
> =A0{
> - =A0 =A0 =A0 struct devfreq *devfreq;
> =A0 =A0 =A0 =A0int err =3D 0;
>
> =A0 =A0 =A0 =A0mutex_lock(&devfreq_list_lock);
> - =A0 =A0 =A0 devfreq =3D container_of(nb, struct devfreq, nb);
> =A0 =A0 =A0 =A0/* Reevaluate the proper frequency */
> =A0 =A0 =A0 =A0err =3D devfreq_do(devfreq);
> =A0 =A0 =A0 =A0mutex_unlock(&devfreq_list_lock);
> @@ -131,6 +129,18 @@ static int devfreq_update(struct notifier_block *nb,=
 unsigned long type,
> =A0}
>
> =A0/**
> + * devfreq_update() - Notify that the device OPP has been changed.
> + * @dev: =A0 =A0 =A0 the device whose OPP has been changed.
> + */
> +static int devfreq_update(struct notifier_block *nb, unsigned long type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *devp)
> +{
> + =A0 =A0 =A0 struct devfreq *devfreq =3D container_of(nb, struct devfreq=
, nb);
> +
> + =A0 =A0 =A0 return update_devfreq(devfreq);
> +}
> +
> +/**
> =A0* devfreq_monitor() - Periodically run devfreq_do()
> =A0* @work: the work struct used to run devfreq_monitor periodically.
> =A0*
> @@ -254,6 +264,9 @@ int devfreq_add_device(struct device *dev, struct dev=
freq_dev_profile *profile,
>
> =A0 =A0 =A0 =A0list_add(&devfreq->node, &devfreq_list);
>
> + =A0 =A0 =A0 if (governor->init)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 governor->init(devfreq);
> +
> =A0 =A0 =A0 =A0if (devfreq_wq && devfreq->next_polling && !polling) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0polling =3D true;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue_delayed_work(devfreq_wq, &devfreq_wo=
rk,
> @@ -295,6 +308,9 @@ int devfreq_remove_device(struct device *dev)
>
> =A0 =A0 =A0 =A0sysfs_unmerge_group(&dev->kobj, &dev_attr_group);
>
> + =A0 =A0 =A0 if (devfreq->governor->exit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->governor->exit(devfreq);
> +
> =A0 =A0 =A0 =A0list_del(&devfreq->node);
> =A0 =A0 =A0 =A0srcu_notifier_chain_unregister(nh, &devfreq->nb);
> =A0 =A0 =A0 =A0kfree(devfreq);
> diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
> new file mode 100644
> index 0000000..bb5d964
> --- /dev/null
> +++ b/drivers/devfreq/governor.h
> @@ -0,0 +1,20 @@
> +/*
> + * governor.h - internal header for governors.
> + *
> + * Copyright (C) 2011 Samsung Electronics
> + * =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This header is for devfreq governors in drivers/devfreq/
> + */
> +
> +#ifndef _GOVERNOR_H
> +#define _GOVERNOR_H
> +
> +extern struct devfreq *get_devfreq(struct device *dev);
> +extern int update_devfreq(struct devfreq *devfreq);
> +
> +#endif /* _GOVERNOR_H */
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 8252238..fdc6916 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -46,6 +46,8 @@ struct devfreq_dev_profile {
> =A0struct devfreq_governor {
> =A0 =A0 =A0 =A0char name[DEVFREQ_NAME_LEN];
> =A0 =A0 =A0 =A0int (*get_target_freq)(struct devfreq *this, unsigned long=
 *freq);
> + =A0 =A0 =A0 int (*init)(struct devfreq *this);
> + =A0 =A0 =A0 void (*exit)(struct devfreq *this);
> =A0};
>
> =A0/**
> --
> 1.7.4.1
>
>
