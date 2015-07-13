From: Javi Merino <javi.merino@arm.com>
Subject: Re: [[PATCH v2]] thermal: add available policies sysfs attribute
Date: Mon, 13 Jul 2015 13:11:21 +0100
Message-ID: <20150713121121.GA4289@e104805>
References: <1431053231-3390-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:47191 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751866AbbGMML3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 13 Jul 2015 08:11:29 -0400
Content-Disposition: inline
In-Reply-To: <1431053231-3390-1-git-send-email-wni@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Ni <wni@nvidia.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, May 08, 2015 at 03:47:11AM +0100, Wei Ni wrote:
> The Linux thermal framework support to change thermal governor
> policy in userspace, but it can't show what available policies
> supported.
>=20
> This patch adds available_policies attribute to the thermal
> framework, it can list the thermal governors which can be
> used for a particular zone. This attribute is read only.
>=20
> Signed-off-by: Wei Ni <wni@nvidia.com>

It's an old thread, but I see myself coming back to this patch from
time to time.  It would be good to have this merged and be part of the
thermal framework.  Other subsystems with governors (like devfreq) have
a similar entry and it's useful.

One minor comment below.

> ---
> v2: This change had been submitted and discussed in
> http://marc.info/?l=3Dlinux-tegra&m=3D138961183931457&w=3D2
> https://www.marc.info/?l=3Dlinux-pm&m=3D138986468007449&w=3D1
> cherry-picked it,and updated to this v2 version.
>=20
>  Documentation/thermal/sysfs-api.txt |  6 ++++++
>  drivers/thermal/thermal_core.c      | 28 +++++++++++++++++++++++++++=
+
>  2 files changed, 34 insertions(+)
>=20
> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/ther=
mal/sysfs-api.txt
> index 7d44d7f1a71b..e7d03cfafc63 100644
> --- a/Documentation/thermal/sysfs-api.txt
> +++ b/Documentation/thermal/sysfs-api.txt
> @@ -180,6 +180,7 @@ Thermal zone device sys I/F, created once it's re=
gistered:
>      |---temp:			Current temperature
>      |---mode:			Working mode of the thermal zone
>      |---policy:			Thermal governor used for this zone
> +    |---available_policies:	Available thermal governors for this zon=
e
>      |---trip_point_[0-*]_temp:	Trip point temperature
>      |---trip_point_[0-*]_type:	Trip point type
>      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
> @@ -254,6 +255,10 @@ policy
>  	One of the various thermal governors used for a particular zone.
>  	RW, Required
> =20
> +available_policies
> +	Available thermal governors which can be used for a particular zone=
=2E
> +	RO, Required
> +
>  trip_point_[0-*]_temp
>  	The temperature above which trip point will be fired.
>  	Unit: millidegree Celsius
> @@ -401,6 +406,7 @@ method, the sys I/F structure will be built like =
this:
>      |---temp:			37000
>      |---mode:			enabled
>      |---policy:			step_wise
> +    |---available_policies:	step_wise fair_share
>      |---trip_point_0_temp:	100000
>      |---trip_point_0_type:	critical
>      |---trip_point_1_temp:	80000
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal=
_core.c
> index 962de1847cc0..68a603a3d4ed 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -847,6 +847,27 @@ policy_show(struct device *dev, struct device_at=
tribute *devattr, char *buf)
>  	return sprintf(buf, "%s\n", tz->governor->name);
>  }
> =20
> +static ssize_t
> +available_policies_show(struct device *dev, struct device_attribute =
*devattr,
> +			char *buf)
> +{
> +	struct thermal_governor *pos;
> +	ssize_t count =3D 0;
> +	ssize_t size;

Initialize size to avoid this compiler warning:

drivers/thermal/thermal_core.c: In function =E2=80=98available_policies=
_show=E2=80=99:
drivers/thermal/thermal_core.c:864:11: warning: =E2=80=98size=E2=80=99 =
may be used
uninitialized in this function [-Wmaybe-uninitialized]
  count +=3D scnprintf(buf + count, size, "\n");

If I understand it correctly, it should be initialized to PAGE_SIZE.

Other than this, you can add my

Reviewed-by: Javi Merino <javi.merino@arm.com>

> +
> +	mutex_lock(&thermal_governor_lock);
> +
> +	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
> +		size =3D PAGE_SIZE - count;
> +		count +=3D scnprintf(buf + count, size, "%s ", pos->name);
> +	}
> +	count +=3D scnprintf(buf + count, size, "\n");
> +
> +	mutex_unlock(&thermal_governor_lock);
> +
> +	return count;
> +}
> +
>  #ifdef CONFIG_THERMAL_EMULATION
>  static ssize_t
>  emul_temp_store(struct device *dev, struct device_attribute *attr,
> @@ -1028,6 +1049,7 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL)=
;
>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passive=
_store);
>  static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_st=
ore);
> +static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_s=
how, NULL);
> =20
>  /* sys I/F for cooling device */
>  #define to_cooling_device(_dev)	\
> @@ -1813,6 +1835,11 @@ struct thermal_zone_device *thermal_zone_devic=
e_register(const char *type,
>  	if (result)
>  		goto unregister;
> =20
> +	/* Create available_policies attribute */
> +	result =3D device_create_file(&tz->device, &dev_attr_available_poli=
cies);
> +	if (result)
> +		goto unregister;
> +
>  	/* Update 'this' zone's governor information */
>  	mutex_lock(&thermal_governor_lock);
> =20
> @@ -1913,6 +1940,7 @@ void thermal_zone_device_unregister(struct ther=
mal_zone_device *tz)
>  	if (tz->ops->get_mode)
>  		device_remove_file(&tz->device, &dev_attr_mode);
>  	device_remove_file(&tz->device, &dev_attr_policy);
> +	device_remove_file(&tz->device, &dev_attr_available_policies);
>  	remove_trip_attrs(tz);
>  	thermal_set_governor(tz, NULL);
> =20
