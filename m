From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v6 4/4] PM / DEVFREQ: add sysfs interface
Date: Thu, 18 Aug 2011 20:15:27 -0700
Message-ID: <CAJOA=zO6oCH1pO8mj_HmjgvHOALxSs6M4sXMuQpombmdLaKqiw@mail.gmail.com>
References: <1313663262-15308-1-git-send-email-myungjoo.ham@samsung.com>
	<1313663262-15308-5-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313663262-15308-5-git-send-email-myungjoo.ham@samsung.com>
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

On Thu, Aug 18, 2011 at 3:27 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wr=
ote:
> Device specific sysfs interface /sys/devices/.../power/devfreq_*
> - governor =A0 =A0 =A0R: name of governor
> - cur_freq =A0 =A0 =A0R: current frequency
> - max_freq =A0 =A0 =A0R: maximum operable frequency
> - min_freq =A0 =A0 =A0R: minimum operable frequency
> - set_freq =A0 =A0 =A0R: read user specified frequency (0 if not specifie=
d yet)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0W: set user specified frequency
> - polling_interval =A0 =A0 =A0R: polling interval in ms given with devfre=
q profile

This code still does not export up_threshold/down_threshold entries
for simple-ondemand which I requested in V5.  However there is a much
bigger issue here brought out in patch 3.  Those values shouldn't be
global, since devices might want different thresholds.

The solution is not to put those tunables in struct devfreq.
up_threshold and down_threshold must be parameters of the governor,
and there must be a per-device instance of the governor.

Regards,
Mike

>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> --
> Changed from v5
> - updated devferq_update usage.
>
> Changed from v4
> - removed system-wide sysfs interface
> - removed tickling sysfs interface
> - added set_freq for userspace governor (and any other governors that
> =A0require user input)
>
> Changed from v3
> - corrected sysfs API usage
> - corrected error messages
> - moved sysfs entry location
> - added sysfs entries
>
> Changed from v2
> - add ABI entries for devfreq sysfs interface
> ---
> =A0Documentation/ABI/testing/sysfs-devices-power | =A0 45 +++++++
> =A0drivers/devfreq/devfreq.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0152 +++++++++++++++++++++++++
> =A02 files changed, 197 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-devices-power b/Documentatio=
n/ABI/testing/sysfs-devices-power
> index 8ffbc25..6e77604 100644
> --- a/Documentation/ABI/testing/sysfs-devices-power
> +++ b/Documentation/ABI/testing/sysfs-devices-power
> @@ -165,3 +165,48 @@ Description:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Not all drivers support this attribute. =
=A0If it isn't supported,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0attempts to read or write it will yield I/=
O errors.
> +
> +What: =A0 =A0 =A0 =A0 =A0/sys/devices/.../power/devfreq_governor
> +Date: =A0 =A0 =A0 =A0 =A0July 2011
> +Contact: =A0 =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> +Description:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 The /sys/devices/.../power/devfreq_governor=
 shows the name
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 of the governor used by the corresponding d=
evice.
> +
> +What: =A0 =A0 =A0 =A0 =A0/sys/devices/.../power/devfreq_cur_freq
> +Date: =A0 =A0 =A0 =A0 =A0July 2011
> +Contact: =A0 =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> +Description:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 The /sys/devices/.../power/devfreq_cur_freq=
 shows the current
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 frequency of the corresponding device.
> +
> +What: =A0 =A0 =A0 =A0 =A0/sys/devices/.../power/devfreq_max_freq
> +Date: =A0 =A0 =A0 =A0 =A0July 2011
> +Contact: =A0 =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> +Description:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 The /sys/devices/.../power/devfreq_cur_freq=
 shows the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 maximum operable frequency of the correspon=
ding device.
> +
> +What: =A0 =A0 =A0 =A0 =A0/sys/devices/.../power/devfreq_min_freq
> +Date: =A0 =A0 =A0 =A0 =A0July 2011
> +Contact: =A0 =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> +Description:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 The /sys/devices/.../power/devfreq_cur_freq=
 shows the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 minimum operable frequency of the correspon=
ding device.
> +
> +What: =A0 =A0 =A0 =A0 =A0/sys/devices/.../power/devfreq_set_freq
> +Date: =A0 =A0 =A0 =A0 =A0August 2011
> +Contact: =A0 =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> +Description:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 The /sys/devices/.../power/devfreq_set_freq=
 sets and shows
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 the user specified desired frequency of the=
 device. The
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 governor may and may not use the value. Wit=
h the basic
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 governors given with devfreq.c, userspace g=
overnor is
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 using the value.
> +
> +What: =A0 =A0 =A0 =A0 =A0/sys/devices/.../power/devfreq_polling_interval
> +Date: =A0 =A0 =A0 =A0 =A0July 2011
> +Contact: =A0 =A0 =A0 MyungJoo Ham <myungjoo.ham@samsung.com>
> +Description:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 The /sys/devices/.../power/devfreq_polling_=
interval shows the
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 requested polling interval of the correspon=
ding device.
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 2036f2c..13b422f 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -37,6 +37,8 @@ static struct delayed_work devfreq_work;
> =A0static LIST_HEAD(devfreq_list);
> =A0static DEFINE_MUTEX(devfreq_list_lock);
>
> +static struct attribute_group dev_attr_group;
> +
> =A0/**
> =A0* find_device_devfreq() - find devfreq struct using device pointer
> =A0* @dev: =A0 =A0 =A0 device pointer used to lookup device devfreq.
> @@ -154,6 +156,8 @@ static void devfreq_monitor(struct work_struct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(de=
vfreq->dev, "Due to devfreq_do error(%d), devfreq(%s) is removed from the d=
evice\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0error, devfreq->governor->name);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sysfs_unmer=
ge_group(&devfreq->dev->kobj,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &dev_attr_group);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_del(&=
devfreq->node);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(devf=
req);
>
> @@ -244,6 +248,8 @@ int devfreq_add_device(struct device *dev, struct dev=
freq_dev_profile *profile,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue_delayed_work(devfreq_wq, &devfreq_wo=
rk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfr=
eq->next_polling);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 sysfs_merge_group(&dev->kobj, &dev_attr_group);
> =A0out:
> =A0 =A0 =A0 =A0mutex_unlock(&devfreq_list_lock);
>
> @@ -276,6 +282,8 @@ int devfreq_remove_device(struct device *dev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 sysfs_unmerge_group(&dev->kobj, &dev_attr_group);
> +
> =A0 =A0 =A0 =A0list_del(&devfreq->node);
> =A0 =A0 =A0 =A0srcu_notifier_chain_unregister(nh, &devfreq->nb);
> =A0 =A0 =A0 =A0kfree(devfreq);
> @@ -284,6 +292,150 @@ out:
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +static ssize_t show_governor(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_at=
tribute *attr, char *buf)
> +{
> + =A0 =A0 =A0 struct devfreq *df =3D find_device_devfreq(dev);
> +
> + =A0 =A0 =A0 if (IS_ERR(df))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(df);
> + =A0 =A0 =A0 if (!df->governor)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%s\n", df->governor->name);
> +}
> +
> +static ssize_t show_freq(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute =
*attr, char *buf)
> +{
> + =A0 =A0 =A0 struct devfreq *df =3D find_device_devfreq(dev);
> +
> + =A0 =A0 =A0 if (IS_ERR(df))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(df);
> +
> + =A0 =A0 =A0 return sprintf(buf, "%lu\n", df->previous_freq);
> +}
> +
> +static ssize_t show_max_freq(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_at=
tribute *attr, char *buf)
> +{
> + =A0 =A0 =A0 struct devfreq *df =3D find_device_devfreq(dev);
> + =A0 =A0 =A0 unsigned long freq =3D ULONG_MAX;
> + =A0 =A0 =A0 struct opp *opp;
> +
> + =A0 =A0 =A0 if (IS_ERR(df))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(df);
> + =A0 =A0 =A0 if (!df->dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 opp =3D opp_find_freq_floor(df->dev, &freq);
> + =A0 =A0 =A0 if (IS_ERR(opp))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(opp);
> +
> + =A0 =A0 =A0 return sprintf(buf, "%lu\n", freq);
> +}
> +
> +static ssize_t show_min_freq(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_at=
tribute *attr, char *buf)
> +{
> + =A0 =A0 =A0 struct devfreq *df =3D find_device_devfreq(dev);
> + =A0 =A0 =A0 unsigned long freq =3D 0;
> + =A0 =A0 =A0 struct opp *opp;
> +
> + =A0 =A0 =A0 if (IS_ERR(df))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(df);
> + =A0 =A0 =A0 if (!df->dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 opp =3D opp_find_freq_ceil(df->dev, &freq);
> + =A0 =A0 =A0 if (IS_ERR(opp))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(opp);
> +
> + =A0 =A0 =A0 return sprintf(buf, "%lu\n", freq);
> +}
> +
> +static ssize_t show_polling_interval(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct device_attribute *attr, char *buf)
> +{
> + =A0 =A0 =A0 struct devfreq *df =3D find_device_devfreq(dev);
> +
> + =A0 =A0 =A0 if (IS_ERR(df))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(df);
> + =A0 =A0 =A0 if (!df->profile)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 return sprintf(buf, "%d\n", df->profile->polling_ms);
> +}
> +
> +static ssize_t set_user_frequency(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
device_attribute *attr,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const c=
har *buf, size_t count)
> +{
> + =A0 =A0 =A0 struct devfreq *devfreq;
> + =A0 =A0 =A0 unsigned long wanted;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 sscanf(buf, "%lu", &wanted);
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> + =A0 =A0 =A0 devfreq =3D find_device_devfreq(dev);
> +
> + =A0 =A0 =A0 if (IS_ERR(devfreq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(devfreq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 devfreq->user_set_freq =3D wanted;
> + =A0 =A0 =A0 err =3D count;
> +out:
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> + =A0 =A0 =A0 if (err >=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq_update(&devfreq->nb, 0, NULL);
> + =A0 =A0 =A0 return err;
> +}
> +
> +static ssize_t show_user_frequency(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct device_attribute *attr, char *buf)
> +{
> + =A0 =A0 =A0 struct devfreq *devfreq;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> + =A0 =A0 =A0 devfreq =3D find_device_devfreq(dev);
> +
> + =A0 =A0 =A0 if (IS_ERR(devfreq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(devfreq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 err =3D sprintf(buf, "%lu\n", devfreq->user_set_freq);
> +out:
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> + =A0 =A0 =A0 return err;
> +
> +}
> +
> +static DEVICE_ATTR(devfreq_governor, 0444, show_governor, NULL);
> +static DEVICE_ATTR(devfreq_cur_freq, 0444, show_freq, NULL);
> +static DEVICE_ATTR(devfreq_max_freq, 0444, show_max_freq, NULL);
> +static DEVICE_ATTR(devfreq_min_freq, 0444, show_min_freq, NULL);
> +static DEVICE_ATTR(devfreq_polling_interval, 0444, show_polling_interval=
, NULL);
> +static DEVICE_ATTR(devfreq_set_freq, 0644, show_user_frequency,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_user_frequency);
> +static struct attribute *dev_entries[] =3D {
> + =A0 =A0 =A0 &dev_attr_devfreq_governor.attr,
> + =A0 =A0 =A0 &dev_attr_devfreq_cur_freq.attr,
> + =A0 =A0 =A0 &dev_attr_devfreq_max_freq.attr,
> + =A0 =A0 =A0 &dev_attr_devfreq_min_freq.attr,
> + =A0 =A0 =A0 &dev_attr_devfreq_polling_interval.attr,
> + =A0 =A0 =A0 &dev_attr_devfreq_set_freq.attr,
> + =A0 =A0 =A0 NULL,
> +};
> +static struct attribute_group dev_attr_group =3D {
> + =A0 =A0 =A0 .name =A0 =3D power_group_name,
> + =A0 =A0 =A0 .attrs =A0=3D dev_entries,
> +};
> +
> =A0/**
> =A0* devfreq_init() - Initialize data structure for devfreq framework and
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 start polling registered devfreq devices.
> --
> 1.7.4.1
>
>
