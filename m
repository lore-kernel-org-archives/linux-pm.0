From: Wei Ni <wni@nvidia.com>
Subject: Re: [[PATCH v2]] thermal: add available policies sysfs attribute
Date: Tue, 14 Jul 2015 15:19:46 +0800
Message-ID: <55A4B812.4060308@nvidia.com>
References: <1431053231-3390-1-git-send-email-wni@nvidia.com> <20150713121121.GA4289@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:6335 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbbGNHT4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2015 03:19:56 -0400
In-Reply-To: <20150713121121.GA4289@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>



=E5=9C=A8 2015=E5=B9=B407=E6=9C=8813=E6=97=A5 20:11, Javi Merino =E5=86=
=99=E9=81=93:
> On Fri, May 08, 2015 at 03:47:11AM +0100, Wei Ni wrote:
>> The Linux thermal framework support to change thermal governor
>> policy in userspace, but it can't show what available policies
>> supported.
>>
>> This patch adds available_policies attribute to the thermal
>> framework, it can list the thermal governors which can be
>> used for a particular zone. This attribute is read only.
>>
>> Signed-off-by: Wei Ni <wni@nvidia.com>
>=20
> It's an old thread, but I see myself coming back to this patch from
> time to time.  It would be good to have this merged and be part of th=
e
> thermal framework.  Other subsystems with governors (like devfreq) ha=
ve
> a similar entry and it's useful.
>=20
> One minor comment below.
>=20
>> ---
>> v2: This change had been submitted and discussed in
>> http://marc.info/?l=3Dlinux-tegra&m=3D138961183931457&w=3D2
>> https://www.marc.info/?l=3Dlinux-pm&m=3D138986468007449&w=3D1
>> cherry-picked it,and updated to this v2 version.
>>
>>  Documentation/thermal/sysfs-api.txt |  6 ++++++
>>  drivers/thermal/thermal_core.c      | 28 ++++++++++++++++++++++++++=
++
>>  2 files changed, 34 insertions(+)
>>
>> diff --git a/Documentation/thermal/sysfs-api.txt b/Documentation/the=
rmal/sysfs-api.txt
>> index 7d44d7f1a71b..e7d03cfafc63 100644
>> --- a/Documentation/thermal/sysfs-api.txt
>> +++ b/Documentation/thermal/sysfs-api.txt
>> @@ -180,6 +180,7 @@ Thermal zone device sys I/F, created once it's r=
egistered:
>>      |---temp:			Current temperature
>>      |---mode:			Working mode of the thermal zone
>>      |---policy:			Thermal governor used for this zone
>> +    |---available_policies:	Available thermal governors for this zo=
ne
>>      |---trip_point_[0-*]_temp:	Trip point temperature
>>      |---trip_point_[0-*]_type:	Trip point type
>>      |---trip_point_[0-*]_hyst:	Hysteresis value for this trip point
>> @@ -254,6 +255,10 @@ policy
>>  	One of the various thermal governors used for a particular zone.
>>  	RW, Required
>> =20
>> +available_policies
>> +	Available thermal governors which can be used for a particular zon=
e.
>> +	RO, Required
>> +
>>  trip_point_[0-*]_temp
>>  	The temperature above which trip point will be fired.
>>  	Unit: millidegree Celsius
>> @@ -401,6 +406,7 @@ method, the sys I/F structure will be built like=
 this:
>>      |---temp:			37000
>>      |---mode:			enabled
>>      |---policy:			step_wise
>> +    |---available_policies:	step_wise fair_share
>>      |---trip_point_0_temp:	100000
>>      |---trip_point_0_type:	critical
>>      |---trip_point_1_temp:	80000
>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/therma=
l_core.c
>> index 962de1847cc0..68a603a3d4ed 100644
>> --- a/drivers/thermal/thermal_core.c
>> +++ b/drivers/thermal/thermal_core.c
>> @@ -847,6 +847,27 @@ policy_show(struct device *dev, struct device_a=
ttribute *devattr, char *buf)
>>  	return sprintf(buf, "%s\n", tz->governor->name);
>>  }
>> =20
>> +static ssize_t
>> +available_policies_show(struct device *dev, struct device_attribute=
 *devattr,
>> +			char *buf)
>> +{
>> +	struct thermal_governor *pos;
>> +	ssize_t count =3D 0;
>> +	ssize_t size;
>=20
> Initialize size to avoid this compiler warning:
>=20
> drivers/thermal/thermal_core.c: In function =E2=80=98available_polici=
es_show=E2=80=99:
> drivers/thermal/thermal_core.c:864:11: warning: =E2=80=98size=E2=80=99=
 may be used
> uninitialized in this function [-Wmaybe-uninitialized]
>   count +=3D scnprintf(buf + count, size, "\n");
>=20
> If I understand it correctly, it should be initialized to PAGE_SIZE.

Will initialize it in next patch.
>=20
> Other than this, you can add my
>=20
> Reviewed-by: Javi Merino <javi.merino@arm.com>

Thanks for your review, will add it :)

>=20
>> +
>> +	mutex_lock(&thermal_governor_lock);
>> +
>> +	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
>> +		size =3D PAGE_SIZE - count;
>> +		count +=3D scnprintf(buf + count, size, "%s ", pos->name);
>> +	}
>> +	count +=3D scnprintf(buf + count, size, "\n");
>> +
>> +	mutex_unlock(&thermal_governor_lock);
>> +
>> +	return count;
>> +}
>> +
>>  #ifdef CONFIG_THERMAL_EMULATION
>>  static ssize_t
>>  emul_temp_store(struct device *dev, struct device_attribute *attr,
>> @@ -1028,6 +1049,7 @@ static DEVICE_ATTR(temp, 0444, temp_show, NULL=
);
>>  static DEVICE_ATTR(mode, 0644, mode_show, mode_store);
>>  static DEVICE_ATTR(passive, S_IRUGO | S_IWUSR, passive_show, passiv=
e_store);
>>  static DEVICE_ATTR(policy, S_IRUGO | S_IWUSR, policy_show, policy_s=
tore);
>> +static DEVICE_ATTR(available_policies, S_IRUGO, available_policies_=
show, NULL);
>> =20
>>  /* sys I/F for cooling device */
>>  #define to_cooling_device(_dev)	\
>> @@ -1813,6 +1835,11 @@ struct thermal_zone_device *thermal_zone_devi=
ce_register(const char *type,
>>  	if (result)
>>  		goto unregister;
>> =20
>> +	/* Create available_policies attribute */
>> +	result =3D device_create_file(&tz->device, &dev_attr_available_pol=
icies);
>> +	if (result)
>> +		goto unregister;
>> +
>>  	/* Update 'this' zone's governor information */
>>  	mutex_lock(&thermal_governor_lock);
>> =20
>> @@ -1913,6 +1940,7 @@ void thermal_zone_device_unregister(struct the=
rmal_zone_device *tz)
>>  	if (tz->ops->get_mode)
>>  		device_remove_file(&tz->device, &dev_attr_mode);
>>  	device_remove_file(&tz->device, &dev_attr_policy);
>> +	device_remove_file(&tz->device, &dev_attr_available_policies);
>>  	remove_trip_attrs(tz);
>>  	thermal_set_governor(tz, NULL);
>> =20
-----------------------------------------------------------------------=
------------
This email message is for the sole use of the intended recipient(s) and=
 may contain
confidential information.  Any unauthorized review, use, disclosure or =
distribution
is prohibited.  If you are not the intended recipient, please contact t=
he sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------=
------------
