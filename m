Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAB2E1EFC;
	Wed, 14 Oct 2026 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792013515; cv=none; b=Hqfz4SLGHC4l4RfZkSd3Q/Ogs8+GDT434sVEjxHANnZWRF5mj2aKLwH+bg/03V3xmV7RYDPzr98xa4SStUMjqdS/M24BmVqnkoOjsDMYpna3h5nU5Pzlvir4cAPgNPDNPtdv4p0SOJ5CqmRRf4lQUsGbL1HrB99nmL+xNHRnT0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792013515; c=relaxed/simple;
	bh=aR5+VfiyeDilrEGKV1lJ2GI043AhmakRZD4ovEu0WN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ASZwhSyC1UlnMXZpVFj2dqOTs5MzQpFtjQvWe/5X1fdEr5/ptckQhjLlex+L5WmrzIk5FNOm2SD/GaI8V4mMTp2b1JGOyX47yqxMqYT1lQY0ymBF/LbqWd8qbvFCkqlsmXmP7mcT0kSlUezqXzcn0T9QgaYQhc7mcQiXjBc3pf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=bF20Zd8Z; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="bF20Zd8Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792013498; x=1792618298; i=w_armin@gmx.de;
	bh=aM2UhJ9H34f9pw+d3edmgLiVGPa0mDIo59IoLpF8DuE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bF20Zd8Zx7P3NT9XNQjlEwh7am+ZTELtyKTQWNNCTX7//PdsVZm70ioR2NQ0h2pC
	 TEhEJl9kJVWNTjge0BVbP10kb2bvd9y0B0bpDCgap+HyMJbj6TjxpaKC1ognV9DCP
	 EN26LmGZm57L2jWxSDQNuUPYLo3wWc8vRkkjIgYEpRl5yeoXnBzE16Ck1PzRSX3fL
	 KoiUb67WkiqAARMAnW8ksIYng3U0IxQZJwFeijTdLUKYEE/o0tu+S8tzq1iywA6XC
	 x7qU0UXmL5p3bS+v7zb0+KKlvarFZWwut5gv+4FQXcHhv1x2bOGgX6LP53BEgLo0Z
	 WsbLRxXxgyNGd+qEHQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhlV-1xNwac30sh-0025PU; Wed, 14
 Oct 2026 23:31:37 +0200
Message-ID: <c751e18d-57e9-4ce6-95dc-1bf53a7a4808@gmx.de>
Date: Wed, 14 Oct 2026 23:31:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] platform profile: Add firmware-neutral aggregate
 sysfs interface
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>, rafael@kernel.org
Cc: Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Jai Luthra <jai.luthra@ideasonboard.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jack Wu <jackbb_wu@compal.com>, "Mario Limonciello (AMD)"
 <superm1@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
 <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KvIyXOZv8Of9ngI43DUZZJblO1ZTX05en203T5afDZVS0h5qR4i
 QEjCHC+4shtlOWr6hyRFGvJSlKJ0FrccQ7k16jvZeNOJWoBuVnKUv+UH+e3h3Tlef8RnKwb
 23o7pPACOG9DWNursFtNcvvlPgubLzkUJLp1BZkH6kpDX65ZheUUIGl/xI4c1qkEklRp0+L
 HOLHKPWqrrNYXF0CH+YcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:S4KYuole48k=;6NiKUx/3NVdTHJ3BhetuHoEIeSz
 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

Am 14.10.26 um 15:24 schrieb Daniel Lezcano:

> The per-provider class interface is firmware-independent, but system-
> wide profile selection is only exposed under /sys/firmware/acpi.
>
> Add /sys/kernel/platform_profile/{choices,profile}, sharing the existing
> aggregate callbacks and semantics with the legacy interface. Keep
> attributes hidden until a provider is registered and remove them after
> the last provider.
>
> Notify both aggregate frontends on profile changes. Also notify the
> provider class device on a direct profile write, matching its documented
> POLLPRI ABI. Restore aggregate visibility after a failed registration.

IMHO the aggregate sysfs interface only exists for backwards-compatibility=
,
so i would be very happy if you could just make the associated code option=
al
and instead teach platform-profiles-daemon to use the individual class dev=
ices
instead.

Thanks,
Armin Wolf

> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> ---
>   drivers/platform/profile/core.c | 60 +++++++++++++++++++++++++++++----
>   1 file changed, 53 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/platform/profile/core.c b/drivers/platform/profile/=
core.c
> index f18fd96b942c..507b96bdfdb1 100644
> --- a/drivers/platform/profile/core.c
> +++ b/drivers/platform/profile/core.c
> @@ -26,9 +26,11 @@ static DEFINE_MUTEX(profile_lock);
>   static DEFINE_MUTEX(profile_registration_lock);
>   static LIST_HEAD(profile_handlers);
>   static struct kobject *compat_kobj;
> +static struct kobject *profile_kobj;
>  =20
>   static void profile_notify(void)
>   {
> +	sysfs_notify(profile_kobj, NULL, "profile");
>   	if (compat_kobj)
>   		sysfs_notify(compat_kobj, NULL, "platform_profile");
>   }
> @@ -250,6 +252,7 @@ static ssize_t profile_store(struct device *dev,
>   		ret =3D _store_class_profile(dev, &index);
>   		if (ret)
>   			return ret;
> +		_notify_class_profile(dev, NULL);
>   	}
>  =20
>   	profile_notify();
> @@ -324,7 +327,7 @@ static int _remove_hidden_choices(struct device *dev=
, void *arg)
>   }
>  =20
>   /**
> - * platform_profile_choices_show - Show the available profile choices f=
or legacy sysfs interface
> + * platform_profile_choices_show - Show the aggregate profile choices
>    * @kobj: The kobject
>    * @attr: The attribute
>    * @buf: The buffer to write to
> @@ -360,7 +363,7 @@ static ssize_t platform_profile_choices_show(struct =
kobject *kobj,
>   }
>  =20
>   /**
> - * _aggregate_profiles - Aggregate the profiles for legacy sysfs interf=
ace
> + * _aggregate_profiles - Aggregate the profiles across providers
>    * @dev: The device
>    * @data: The profile to return
>    *
> @@ -385,7 +388,7 @@ static int _aggregate_profiles(struct device *dev, v=
oid *data)
>   }
>  =20
>   /**
> - * _store_and_notify - Store and notify a class from legacy sysfs inter=
face
> + * _store_and_notify - Store and notify a provider from an aggregate wr=
ite
>    * @dev: The device
>    * @data: The profile to return
>    *
> @@ -403,7 +406,7 @@ static int _store_and_notify(struct device *dev, voi=
d *data)
>   }
>  =20
>   /**
> - * platform_profile_show - Show the current profile for legacy sysfs in=
terface
> + * platform_profile_show - Show the current aggregate profile
>    * @kobj: The kobject
>    * @attr: The attribute
>    * @buf: The buffer to write to
> @@ -431,7 +434,7 @@ static ssize_t platform_profile_show(struct kobject =
*kobj,
>   }
>  =20
>   /**
> - * platform_profile_store - Set the profile for legacy sysfs interface
> + * platform_profile_store - Set the profile across all providers
>    * @kobj: The kobject
>    * @attr: The attribute
>    * @buf: The buffer to read from
> @@ -493,8 +496,30 @@ static const struct attribute_group platform_profil=
e_group =3D {
>   	.is_visible =3D profile_class_is_visible,
>   };
>  =20
> +static struct kobj_attribute aggregate_choices =3D
> +	__ATTR(choices, 0444, platform_profile_choices_show, NULL);
> +static struct kobj_attribute aggregate_profile =3D
> +	__ATTR(profile, 0644, platform_profile_show, platform_profile_store);
> +
> +static struct attribute *aggregate_attrs[] =3D {
> +	&aggregate_choices.attr,
> +	&aggregate_profile.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group aggregate_group =3D {
> +	.attrs =3D aggregate_attrs,
> +	.is_visible =3D profile_class_is_visible,
> +};
> +
>   static int profile_update(void)
>   {
> +	int err;
> +
> +	err =3D sysfs_update_group(profile_kobj, &aggregate_group);
> +	if (err)
> +		return err;
> +
>   	if (compat_kobj)
>   		return sysfs_update_group(compat_kobj, &platform_profile_group);
>  =20
> @@ -502,7 +527,7 @@ static int profile_update(void)
>   }
>  =20
>   /**
> - * platform_profile_notify - Notify class device and legacy sysfs inter=
face
> + * platform_profile_notify - Notify the provider and aggregate sysfs in=
terfaces
>    * @dev: The class device
>    */
>   void platform_profile_notify(struct device *dev)
> @@ -643,6 +668,7 @@ struct device *platform_profile_register(struct devi=
ce *dev, const char *name,
>   cleanup_cur:
>   	scoped_guard(mutex, &profile_lock)
>   		list_del(&to_pprof_handler(ppdev)->node);
> +	profile_update();
>   	device_unregister(ppdev);
>  =20
>   cleanup_ida:
> @@ -726,15 +752,33 @@ static int __init platform_profile_init(void)
>   	if (err)
>   		return err;
>  =20
> +	profile_kobj =3D kobject_create_and_add("platform_profile", kernel_kob=
j);
> +	if (!profile_kobj) {
> +		err =3D -ENOMEM;
> +		goto unregister_class;
> +	}
> +
> +	err =3D sysfs_create_group(profile_kobj, &aggregate_group);
> +	if (err)
> +		goto put_kobj;
> +
>   	compat_kobj =3D platform_profile_compat_kobj();
>   	if (compat_kobj) {
>   		err =3D sysfs_create_group(compat_kobj, &platform_profile_group);
>   		if (err) {
>   			kobject_put(compat_kobj);
> -			class_unregister(&platform_profile_class);
> +			goto remove_group;
>   		}
>   	}
>  =20
> +	return 0;
> +
> +remove_group:
> +	sysfs_remove_group(profile_kobj, &aggregate_group);
> +put_kobj:
> +	kobject_put(profile_kobj);
> +unregister_class:
> +	class_unregister(&platform_profile_class);
>   	return err;
>   }
>  =20
> @@ -744,6 +788,8 @@ static void __exit platform_profile_exit(void)
>   		sysfs_remove_group(compat_kobj, &platform_profile_group);
>   		kobject_put(compat_kobj);
>   	}
> +	sysfs_remove_group(profile_kobj, &aggregate_group);
> +	kobject_put(profile_kobj);
>   	class_unregister(&platform_profile_class);
>   }
>   subsys_initcall_sync(platform_profile_init);
