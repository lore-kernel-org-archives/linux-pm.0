From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v4 05/20] PM / devfreq: Add new passive governor
Date: Fri, 18 Dec 2015 10:27:33 +0900
Message-ID: <56736105.6060009@samsung.com>
References: <1874820122.661091450083873584.JavaMail.weblogic@epmlwas07b>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:37485 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbbLRB1q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 20:27:46 -0500
In-reply-to: <1874820122.661091450083873584.JavaMail.weblogic@epmlwas07b>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com, =?UTF-8?B?7YGs7Ims7Iuc7Yag7ZSE?= <k.kozlowski@samsung.com>, "kgene@kernel.org" <kgene@kernel.org>
Cc: =?UTF-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "tjakobi@math.uni-bielefeld.de" <tjakobi@math.uni-bielefeld.de>, "linux.amoon@gmail.com" <linux.amoon@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 2015=EB=85=84 12=EC=9B=94 14=EC=9D=BC 18:04, MyungJoo Ham wrote:
>>  =20
>>  This patch adds the new passive governor for DEVFREQ framework. The=
 following
>> governors are already present and used for DVFS (Dynamic Voltage and=
 Frequency
>> Scaling) drivers. The following governors are independently used for=
 one device
>> driver which don't give the influence to other device drviers and al=
so don't
>> receive the effect from other device drivers.
>> - ondemand / performance / powersave / userspace
>>
>> The passive governor depends on operation of parent driver with spec=
ific
>> governos extremely and is not able to decide the new frequency by on=
eself.
>> According to the decided new frequency of parent driver with governo=
r,
>> the passive governor uses it to decide the appropriate frequency for=
 own
>> device driver. The passive governor must need the following informat=
ion
>> from device tree:
>> - the source clock and OPP tables
>> - the instance of parent device
>>
>> For exameple,
>> there are one more devfreq device drivers which need to change their=
 source
>> clock according to their utilization on runtime. But, they share the=
 same
>> power line (e.g., regulator). So, specific device driver is operated=
 as parent
>> with ondemand governor and then the rest device driver with passive =
governor
>> is influenced by parent device.
>>
>> Suggested-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> [linux.amoon: Tested on Odroid U3]
>> Tested-by: Anand Moon <linux.amoon@gmail.com>
>> ---
>>  drivers/devfreq/Kconfig            |   9 ++++
>>  drivers/devfreq/Makefile           |   1 +
>>  drivers/devfreq/devfreq.c          |  47 ++++++++++++++++
>>  drivers/devfreq/governor_passive.c | 108 ++++++++++++++++++++++++++=
+++++++++++
>>  include/linux/devfreq.h            |  15 ++++++
>>  5 files changed, 180 insertions(+)
>>  create mode 100644 drivers/devfreq/governor_passive.c
>>
>> diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
>> index 55ec774f794c..d03f635a93e1 100644
>> --- a/drivers/devfreq/Kconfig
>> +++ b/drivers/devfreq/Kconfig
>> @@ -64,6 +64,15 @@ config DEVFREQ_GOV_USERSPACE
>>  	  Otherwise, the governor does not change the frequnecy
>>  	  given at the initialization.
>> =20
>> +config DEVFREQ_GOV_PASSIVE
>> +	tristate "Passive"
>> +	help
>> +	  Sets the frequency by other governors (simple_ondemand, performa=
nce,
>> +	  powersave, usersapce) of a parent devfreq device. This governor
>> +	  always has the dependency on the chosen frequency from paired
>> +	  governor. This governor does not change the frequency by oneself
>> +	  through sysfs entry.
>=20
> 	Sets the frequency based on the frequency of its parent devfreq
> 	device. This governor does not change the frequency by itself
> 	through sysfs entries.

OK. I'll modify it.

>=20
>> +
>>  comment "DEVFREQ Drivers"
>> =20
>>  config ARM_EXYNOS_BUS_DEVFREQ
>> diff --git a/drivers/devfreq/Makefile b/drivers/devfreq/Makefile
>> index 375ebbb4fcfb..f81c313b4b79 100644
>> --- a/drivers/devfreq/Makefile
>> +++ b/drivers/devfreq/Makefile
> []
>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>> index 984c5e9e7bdd..15e58779e4c0 100644
>> --- a/drivers/devfreq/devfreq.c
>> +++ b/drivers/devfreq/devfreq.c
>> @@ -190,6 +190,31 @@ static struct devfreq_governor *find_devfreq_go=
vernor(const char *name)
>> =20
>>  /* Load monitoring helper functions for governors use */
>> =20
>> +static int update_devfreq_passive(struct devfreq *devfreq, unsigned=
 long freq)
>> +{
>> +	struct devfreq *passive;
>> +	unsigned long rate;
>> +	int ret;
>> +
>> +	list_for_each_entry(passive, &devfreq->passive_dev_list, passive_n=
ode) {
>> +		if (!passive->governor)
>> +			continue;
>> +		rate =3D freq;
>> +
>> +		ret =3D passive->governor->get_target_freq(passive, &rate);
>> +		if (ret)
>> +			return ret;
>> +
>> +		ret =3D passive->profile->target(passive->dev.parent, &rate, 0);
>> +		if (ret)
>> +			return ret;
>> +
>> +		passive->previous_freq =3D rate;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  /**
>>   * update_devfreq() - Reevaluate the device and configure frequency=
=2E
>>   * @devfreq:	the devfreq instance.
>> @@ -233,10 +258,18 @@ int update_devfreq(struct devfreq *devfreq)
>>  		flags |=3D DEVFREQ_FLAG_LEAST_UPPER_BOUND; /* Use LUB */
>>  	}
>> =20
>> +	if (!list_empty(&devfreq->passive_dev_list)
>> +		&& devfreq->previous_freq > freq)
>> +		update_devfreq_passive(devfreq, freq);
>> +
>=20
> Could you please comment somewhere appropriate
> that the dependent is going to be changed
> before its parent if the frequency is going down.
> (and after if going up)
> And state why as well.

I use the DEVFREQ_TRANSITION_NOTIFIER instead of this implementation.

>=20
> And, is this viable universally?
>=20
>>  	err =3D devfreq->profile->target(devfreq->dev.parent, &freq, flags=
);
>>  	if (err)
>>  		return err;
>> =20
>> +	if (!list_empty(&devfreq->passive_dev_list)
>> +		&& devfreq->previous_freq < freq)
>> +		update_devfreq_passive(devfreq, freq);
>> +
>>  	if (devfreq->profile->freq_table)
>>  		if (devfreq_update_status(devfreq, freq))
>>  			dev_err(&devfreq->dev,
>> @@ -442,6 +475,10 @@ static void _remove_devfreq(struct devfreq *dev=
freq)
>>  		return;
>>  	}
>>  	list_del(&devfreq->node);
>> +	list_del(&devfreq->passive_node);
>> +	if (!list_empty(&devfreq->passive_dev_list))
>> +		list_del_init(&devfreq->passive_dev_list);
>> +
>>  	mutex_unlock(&devfreq_list_lock);
>> =20
>>  	if (devfreq->governor)
>> @@ -559,6 +596,16 @@ struct devfreq *devfreq_add_device(struct devic=
e *dev,
>>  		goto err_init;
>>  	}
>> =20
>> +	if (!strncmp(devfreq->governor_name, "passive", 7)) {
>> +		struct devfreq *parent_devfreq =3D
>> +			((struct devfreq_passive_data *)data)->parent;
>> +
>> +		list_add(&devfreq->passive_node,
>> +			&parent_devfreq->passive_dev_list);
>> +	} else {
>> +		INIT_LIST_HEAD(&devfreq->passive_dev_list);
>> +	}
>> +
>>  	return devfreq;
>> =20
>>  err_init:
>=20
> This code has become too much invasive to devfreq.c
> while being too special for the passive governor.

I agree. I'll implement again with notifier.

>=20
> Why don't you add notifier chain to devfreq.c, which can be used
> by anyone else as well, and use that notifier for passive governor?
> You may refer to "cpufreq_register_notifier()" with=20
> CPUFREQ_TRANSITION_NOTIFIER.

OK. I'll add the new notifier of DEVFREQ_TRANSITION_NOTIFIER
The list of supported notification:
	DEVFREQ_PRECHANGE
	DEVFREQ_POSTCHANGE

>=20
>> diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/go=
vernor_passive.c
>> new file mode 100644
>=20
> Then, utilizing notifier-block at governor_passive.c becomes possible=
=2E
>=20
> You will also be able to write any frequency deciding code
> inside governor_passive.c as well, not in devfreq.c.

OK, I'll use DEVFREQ_TRANSITION_NOTIFIER for passive governor.

>=20
>> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
>> index 6fa02a20eb63..95c54578a1b4 100644
>> --- a/include/linux/devfreq.h
>> +++ b/include/linux/devfreq.h
>> @@ -177,6 +177,9 @@ struct devfreq {
>>  	unsigned int *trans_table;
>>  	unsigned long *time_in_state;
>>  	unsigned long last_stat_updated;
>> +
>> +	struct list_head passive_dev_list;
>> +	struct list_head passive_node;
>>  };
>=20
> You will need only one notifier head here.

OK.

>=20
>> =20
>>  #if defined(CONFIG_PM_DEVFREQ)
>> @@ -241,6 +244,18 @@ struct devfreq_simple_ondemand_data {
>>  };
>>  #endif
>> =20
>> +/**
>> + * struct devfreq_passive_data - void *data fed to struct devfreq
>> + *	and devfreq_add_device
>> + * @parent:		The parent devfreq device.
>> + *
>> + * If the fed devfreq_passive_data pointer is NULL to the governor,
>> + * the governor return ERROR.
>> + */
>> +struct devfreq_passive_data {
>> +	struct devfreq *parent;
>> +};
>> +
>=20
> Please enclose the above with #if

OK.

Thanks,
Chanwoo Choi
