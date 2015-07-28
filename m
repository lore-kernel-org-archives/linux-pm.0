From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v6 1/8] PM / QoS: Make it possible to expose device
 latency tolerance to userspace
Date: Tue, 28 Jul 2015 08:47:18 +0100
Message-ID: <20150728074718.GO21114@x1>
References: <1438009443-55317-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1438009443-55317-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438009443-55317-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vinod Koul <vinod.koul@intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, mturquette@baylibre.com, sboyd@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Mon, 27 Jul 2015, Andy Shevchenko wrote:

> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>=20
> Typically when a device is created the bus core it belongs to (for ex=
ample
> PCI) does not know if the device supports things like latency toleran=
ce.
> This is left to the driver that binds to the device in question. Howe=
ver,
> at that time the device has already been created and there is no way =
to set
> its dev->power.set_latency_tolerance anymore.
>=20
> So follow what has been done for other PM QoS attributes as well and =
allow
> drivers to expose and hide latency tolerance from userspace, if the d=
evice
> supports it.
>=20
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/power/power.h |  2 ++
>  drivers/base/power/qos.c   | 37 ++++++++++++++++++++++++++++++++++++=
+
>  drivers/base/power/sysfs.c | 11 +++++++++++
>  include/linux/pm_qos.h     |  5 +++++
>  4 files changed, 55 insertions(+)

Applied, thanks.  Pull request to follow.

> diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
> index f1a5d95..998fa6b 100644
> --- a/drivers/base/power/power.h
> +++ b/drivers/base/power/power.h
> @@ -73,6 +73,8 @@ extern int pm_qos_sysfs_add_resume_latency(struct d=
evice *dev);
>  extern void pm_qos_sysfs_remove_resume_latency(struct device *dev);
>  extern int pm_qos_sysfs_add_flags(struct device *dev);
>  extern void pm_qos_sysfs_remove_flags(struct device *dev);
> +extern int pm_qos_sysfs_add_latency_tolerance(struct device *dev);
> +extern void pm_qos_sysfs_remove_latency_tolerance(struct device *dev=
);
> =20
>  #else /* CONFIG_PM */
> =20
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index e56d538..7f3646e 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -883,3 +883,40 @@ int dev_pm_qos_update_user_latency_tolerance(str=
uct device *dev, s32 val)
>  	mutex_unlock(&dev_pm_qos_mtx);
>  	return ret;
>  }
> +
> +/**
> + * dev_pm_qos_expose_latency_tolerance - Expose latency tolerance to=
 userspace
> + * @dev: Device whose latency tolerance to expose
> + */
> +int dev_pm_qos_expose_latency_tolerance(struct device *dev)
> +{
> +	int ret;
> +
> +	if (!dev->power.set_latency_tolerance)
> +		return -EINVAL;
> +
> +	mutex_lock(&dev_pm_qos_sysfs_mtx);
> +	ret =3D pm_qos_sysfs_add_latency_tolerance(dev);
> +	mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_expose_latency_tolerance);
> +
> +/**
> + * dev_pm_qos_hide_latency_tolerance - Hide latency tolerance from u=
serspace
> + * @dev: Device whose latency tolerance to hide
> + */
> +void dev_pm_qos_hide_latency_tolerance(struct device *dev)
> +{
> +	mutex_lock(&dev_pm_qos_sysfs_mtx);
> +	pm_qos_sysfs_remove_latency_tolerance(dev);
> +	mutex_unlock(&dev_pm_qos_sysfs_mtx);
> +
> +	/* Remove the request from user space now */
> +	pm_runtime_get_sync(dev);
> +	dev_pm_qos_update_user_latency_tolerance(dev,
> +		PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT);
> +	pm_runtime_put(dev);
> +}
> +EXPORT_SYMBOL_GPL(dev_pm_qos_hide_latency_tolerance);
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index d2be3f9..a7b4679 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -738,6 +738,17 @@ void pm_qos_sysfs_remove_flags(struct device *de=
v)
>  	sysfs_unmerge_group(&dev->kobj, &pm_qos_flags_attr_group);
>  }
> =20
> +int pm_qos_sysfs_add_latency_tolerance(struct device *dev)
> +{
> +	return sysfs_merge_group(&dev->kobj,
> +				 &pm_qos_latency_tolerance_attr_group);
> +}
> +
> +void pm_qos_sysfs_remove_latency_tolerance(struct device *dev)
> +{
> +	sysfs_unmerge_group(&dev->kobj, &pm_qos_latency_tolerance_attr_grou=
p);
> +}
> +
>  void rpm_sysfs_remove(struct device *dev)
>  {
>  	sysfs_unmerge_group(&dev->kobj, &pm_runtime_attr_group);
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 7b3ae0c..0f65d36 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -161,6 +161,8 @@ void dev_pm_qos_hide_flags(struct device *dev);
>  int dev_pm_qos_update_flags(struct device *dev, s32 mask, bool set);
>  s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev);
>  int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32=
 val);
> +int dev_pm_qos_expose_latency_tolerance(struct device *dev);
> +void dev_pm_qos_hide_latency_tolerance(struct device *dev);
> =20
>  static inline s32 dev_pm_qos_requested_resume_latency(struct device =
*dev)
>  {
> @@ -229,6 +231,9 @@ static inline s32 dev_pm_qos_get_user_latency_tol=
erance(struct device *dev)
>  			{ return PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT; }
>  static inline int dev_pm_qos_update_user_latency_tolerance(struct de=
vice *dev, s32 val)
>  			{ return 0; }
> +static inline int dev_pm_qos_expose_latency_tolerance(struct device =
*dev)
> +			{ return 0; }
> +static inline void dev_pm_qos_hide_latency_tolerance(struct device *=
dev) {}
> =20
>  static inline s32 dev_pm_qos_requested_resume_latency(struct device =
*dev) { return 0; }
>  static inline s32 dev_pm_qos_requested_flags(struct device *dev) { r=
eturn 0; }

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
