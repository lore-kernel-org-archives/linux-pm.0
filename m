Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E596357CFA;
	Fri, 11 Sep 2026 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160704; cv=none; b=WWlNKx24yqSBr2vomnDY+/MSRQ/fvoNe65lIJUEdCGTofmGxw0KmbJ4sHhnIezmXGM9BjSLeD7w1vx17nGcD4pGC7jtkV5fnznOGY9JF26VXmXyYRkmZR4lym2N5qPBfbBAU5e2wdt3RzmB1d1S+ffZ3Cwza87MBlCutx1WNMBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160704; c=relaxed/simple;
	bh=xGRrjOy0mmFjDs9E3DUlqzhSX076G9NWacDtUR3RYY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWTT9r21+PAg4hWzYf+cldgJgaznVHckPpSI5qtBVAdr9tKeldEnqcna1FnYICgoFFhZNeM1kTfS2Ker1Wjv2N5SiNSePvpSLf/hB5ZcMZcKTmkM/4oIJUpWKN4vq3cMaSgwi1nnkMBlEUpxbU4S/9x65Du0JH0SmEsyrhSjbcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=R3tZbFSb; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="R3tZbFSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789160691; x=1789765491; i=w_armin@gmx.de;
	bh=r647uEgXdU2W1rj+bkjhsQkrfrcaOHKP9kDAlAk6r6o=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=R3tZbFSbD4ui7GVxWBP3kXCKF4n62GtEsCA5Di72J/wN2G+DL+38J1l+v9xkQ2XD
	 n6QH49L//KsgI1maP34pN5/+Ftv66AvWh2fO2b4rW2knWhVvTfk2DIiohAUkx0Gbs
	 Jwi3D/A+IXtZA82XZxOLB5vuwQ1YM4KtCfDTSh19AQMOtLkVPrPIUZec2/pxtqgQA
	 6Mx55FLUdTpLxYYJM8xXK+E6vDUsFuGCJDLmbsFHXbR2qazqRyVjfaKBmJU4foYV1
	 23MqLkeNJHA+FEypxdaI3LbBSIxpPMW60c4zgLTvzmvLX0/GghhHn73U1u4I/raRR
	 b5foTcqfnKINWSfNTA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1wXzP33m3j-00c7Ag; Fri, 11
 Sep 2026 23:04:50 +0200
Message-ID: <7ef819c3-5155-48fb-828a-48d9bd72e54b@gmx.de>
Date: Fri, 11 Sep 2026 23:04:50 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/10] thermal: core: Introduce
 thermal_cooling_device_create()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <8729484.T7Z3S40VBb@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <8729484.T7Z3S40VBb@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MMlyr0h4n6o1uZBPpKsYw3N8Lj2UeFb85tkpuN6J/Vsp8H8mPst
 62S0z8zvaeJWFfryguWalkH2FRxJB10Y7CjkltfVys6NNXs4HFOh11WunrJ+5qJs9a75kuB
 sIyhLm8ce+ud2GgTTCep9hDxlGTzAVAwsOosa26SSGRES7TUtKiCML3Y1pQRaDoBsvSp1AU
 0nKLjJEbQ+LyZ/OmbE0xQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2heknBkaCBk=;6Gps50F4T4FGAeiAc0ZVncNJdiK
 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
 f/5TJjCCPrZGRKxFQUcuorGf9XQDbuKYoig==

Am 11.09.26 um 15:02 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Currently, thermal cooling devices have no parents, but it would be
> generally useful to be able to create them under specific parents in
> the device hierarchy (for instance, it may help to identify the device
> representing the actual cooling hardware).
>
> To make that possible, add thermal_cooling_device_create() that will
> work like thermal_cooling_device_register() except that it will take
> an additional parent argument (which may be NULL).
>
> Redefine thermal_cooling_device_register() as a static inline wrapper
> around thermal_cooling_device_create().

Hi,

i like your idea with the new registration function, this gives us more ti=
me
for migrating the other drivers. Should we mark the original function as
deprecated?

For the patch itself:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/thermal/thermal_core.c | 28 ++++++++++++++++------------
>   drivers/thermal/thermal_core.h |  3 ++-
>   drivers/thermal/thermal_of.c   |  2 +-
>   include/linux/thermal.h        | 19 ++++++++++++++-----
>   4 files changed, 33 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_co=
re.c
> index 82e2f0d8a26d..ac928c199829 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1005,7 +1005,8 @@ thermal_cooling_device_alloc(const char *type, con=
st struct thermal_cooling_devi
>   	return ERR_PTR(ret);
>   }
>  =20
> -int thermal_cooling_device_add(struct thermal_cooling_device *cdev, voi=
d *devdata)
> +int thermal_cooling_device_add(struct thermal_cooling_device *cdev,
> +			       struct device *parent, void *devdata)
>   {
>   	unsigned long current_state;
>   	int ret;
> @@ -1013,6 +1014,7 @@ int thermal_cooling_device_add(struct thermal_cool=
ing_device *cdev, void *devdat
>   	mutex_init(&cdev->lock);
>   	INIT_LIST_HEAD(&cdev->thermal_instances);
>   	cdev->updated =3D false;
> +	cdev->device.parent =3D parent;
>   	cdev->device.class =3D &thermal_class;
>   	cdev->device.release =3D thermal_cdev_release;
>   	device_initialize(&cdev->device);
> @@ -1062,21 +1064,23 @@ int thermal_cooling_device_add(struct thermal_co=
oling_device *cdev, void *devdat
>   }
>  =20
>   /**
> - * thermal_cooling_device_register() - register a new thermal cooling d=
evice
> + * thermal_cooling_device_create() - register a new thermal cooling dev=
ice
> + * @parent:	parent device (optional).
>    * @type:	the thermal cooling device type.
>    * @devdata:	device private data.
>    * @ops:	standard thermal cooling devices callbacks.
>    *
> - * This interface function adds a new thermal cooling device (fan/proce=
ssor/...)
> - * to /sys/class/thermal/ folder as cooling_device[0-*]. It tries to bi=
nd itself
> - * to all the thermal zone devices registered at the same time.
> + * Allocate and register a new thermal cooling device under the given p=
arent (if
> + * not NULL) and with the given type, device data, and operations.  Dur=
ing the
> + * registration, it will be matched against all of the registered therm=
al zones
> + * and it will be bound to the matching ones.
>    *
> - * Return: a pointer to the created struct thermal_cooling_device or an
> - * ERR_PTR. Caller must check return value with IS_ERR*() helpers.
> + * Return: A pointer to the created struct thermal_cooling_device or an=
 ERR_PTR.
> + * Callers must use IS_ERR*() helpers to check the return value.
>    */
> -struct thermal_cooling_device *
> -thermal_cooling_device_register(const char *type, void *devdata,
> -				const struct thermal_cooling_device_ops *ops)
> +struct thermal_cooling_device *thermal_cooling_device_create(
> +			struct device *parent, const char *type, void *devdata,
> +			const struct thermal_cooling_device_ops *ops)
>   {
>   	struct thermal_cooling_device *cdev;
>   	int ret;
> @@ -1085,13 +1089,13 @@ thermal_cooling_device_register(const char *type=
, void *devdata,
>   	if (IS_ERR(cdev))
>   		return cdev;
>  =20
> -	ret =3D thermal_cooling_device_add(cdev, devdata);
> +	ret =3D thermal_cooling_device_add(cdev, parent, devdata);
>   	if (ret)
>   		return ERR_PTR(ret);
>  =20
>   	return cdev;
>   }
> -EXPORT_SYMBOL_GPL(thermal_cooling_device_register);
> +EXPORT_SYMBOL_GPL(thermal_cooling_device_create);
>  =20
>   static void thermal_cooling_device_release(void *data)
>   {
> diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_co=
re.h
> index e98b0aa5aacc..7ef7c6cab437 100644
> --- a/drivers/thermal/thermal_core.h
> +++ b/drivers/thermal/thermal_core.h
> @@ -270,7 +270,8 @@ void thermal_governor_update_tz(struct thermal_zone_=
device *tz,
>   struct thermal_cooling_device *
>   thermal_cooling_device_alloc(const char *type, const struct thermal_co=
oling_device_ops *ops);
>  =20
> -int thermal_cooling_device_add(struct thermal_cooling_device *cdev, voi=
d *devdata);
> +int thermal_cooling_device_add(struct thermal_cooling_device *cdev,
> +			       struct device *parent, void *devdata);
>  =20
>   /* Helpers */
>   #define for_each_trip_desc(__tz, __td)	\
> diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
> index 0217a49b08ae..14dfac9359b8 100644
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -561,7 +561,7 @@ thermal_of_cooling_device_register(struct device_nod=
e *np, u32 cdev_id,
>   	cdev->np =3D np;
>   	cdev->cdev_id =3D cdev_id;
>  =20
> -	ret =3D thermal_cooling_device_add(cdev, devdata);
> +	ret =3D thermal_cooling_device_add(cdev, NULL, devdata);
>   	if (ret)
>   		return ERR_PTR(ret);
>  =20
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 083b4f533933..306ad17aed89 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -293,8 +293,9 @@ struct device *thermal_zone_device(struct thermal_zo=
ne_device *tzd);
>   void thermal_zone_device_update(struct thermal_zone_device *,
>   				enum thermal_notify_event);
>  =20
> -struct thermal_cooling_device *thermal_cooling_device_register(const ch=
ar *,
> -		void *, const struct thermal_cooling_device_ops *);
> +struct thermal_cooling_device *thermal_cooling_device_create(
> +			struct device *parent, const char *type, void *devdata,
> +			const struct thermal_cooling_device_ops *ops);
>  =20
>   struct thermal_cooling_device *
>   devm_thermal_cooling_device_register(struct device *dev, const char *t=
ype, void *devdata,
> @@ -340,9 +341,9 @@ static inline void thermal_zone_device_update(struct=
 thermal_zone_device *tz,
>   					      enum thermal_notify_event event)
>   { }
>  =20
> -static inline struct thermal_cooling_device *
> -thermal_cooling_device_register(const char *type, void *devdata,
> -	const struct thermal_cooling_device_ops *ops)
> +static inline struct thermal_cooling_device *thermal_cooling_device_cre=
ate(
> +			struct device *parent, const char *type, void *devdata,
> +			const struct thermal_cooling_device_ops *ops)
>   { return ERR_PTR(-ENODEV); }
>  =20
>   static inline struct thermal_cooling_device *
> @@ -391,4 +392,12 @@ static inline void thermal_pm_prepare(void) {}
>   static inline void thermal_pm_complete(void) {}
>   #endif /* CONFIG_THERMAL */
>  =20
> +static inline struct thermal_cooling_device *thermal_cooling_device_reg=
ister(
> +				const char *type, void *devdata,
> +				const struct thermal_cooling_device_ops *ops)
> +{
> +	return thermal_cooling_device_create(NULL, type, devdata, ops);
> +}
> +
> +
>   #endif /* __THERMAL_H__ */
