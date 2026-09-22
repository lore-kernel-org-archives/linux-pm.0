Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D500337DEBF;
	Tue, 22 Sep 2026 19:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106455; cv=none; b=V5+tq14kferEhiKcRFwfOAp6F2DEAR5l74iKqTJpWqqn6FjsLX4K+szvQluuz/ji8fWFWItQhswzB10AjzFXlDh8zL13twckT7n2WNHYwRHJWQZQKnfKvSuEjG0NAqB+M4wQhsA2KQUcYjbWJ0+Vk+Mp4WbCEKTDNUVv9KxB8lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106455; c=relaxed/simple;
	bh=Cu/b7zYXwkRqkT8An5yjhmWghNWweq8zx46GB9DslOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IFQ/c1rO66m+92W67//fee8TOmvk2sA/Wu3G5zMZqapMnspL3nVyZqphSxRwuIKql+q8yEnHBDmTH9YnZBRsHRTINA1AHY/NMp4KvRRq7zlo7yhTUe0i3EvyukuqCkKweXUtD6T9VYHxGrJwgJNlpB/LKh1YQlEvdK4gGf8fA7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=VG9dB1b8; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="VG9dB1b8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790106443; x=1790711243; i=w_armin@gmx.de;
	bh=3LMdM/DqOCOAi/wrMN0qVAmfGfkIM2YtiHkQRCXTUaI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VG9dB1b8ZHLxkfVoaFo77Ji6L+QwFxArxwZYOfSLGC33NbhVBG8gJegfiM8JH2Iq
	 eI8eoz/jtls8uZCsTjaRv3a1SBLeJU52czfVbq1CrTy2jx7eESWcgQjLsLEDcn1zh
	 Iwidj93+4N3pzs2YgDCHQWL4bQBB+wFTgiogUF3FHl4EsznwjKpgpVTNsoHFCikT/
	 E3J8W9A2h/wAv+z5k0seupd7a8hQW40vPzqG/ZTfWIDHjv223i06QKoLHT8i+WKT0
	 +xC71fgI4IxD6mlo5lIbfqK5/4XtwEPWmVR7iGgfgR02R1OEW9u/+pNlkjn3C+NbM
	 ftBCSHz7KKdR8j41Tw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCK6-1xNJvj1gyi-00MLZg; Tue, 22
 Sep 2026 21:47:23 +0200
Message-ID: <7a80b4e3-1f87-43d4-ad4a-21bf1a897395@gmx.de>
Date: Tue, 22 Sep 2026 21:47:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1][linux-next] ACPI: fan: Use __free() to simplify AML
 error handling
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
References: <6029013.DvuYhMxLoT@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <6029013.DvuYhMxLoT@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MmwjrgKYgbQsskSRZgENQpJs8OKxjj+rnMc5tXMK7GT+IPL7twF
 9rmrpCfTsb9aDHzlJL2D/O/Gm2aAU9IKSQak5AiHMS+GxyGJl1lPrnhZooGKpzRPHuBNpj1
 QB5g+jywbtsIZ9SnoUeGiwt+QbL9Pk47gZTa9w7BmkUPT4BVQlI8U+T8YLl5RBYleyc0n/D
 ueUZOfjBuwmBGIjbO+NvA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gQz8jRyNHrk=;SruD2W+XQY5Vqqzg55UEAo97wcg
 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
 HvS70v51xpND3Luaw==

Am 16.09.26 um 21:42 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Introduce acpi_object_free for freeing union acpi_object objects
> allocated by AML and use it for simplifying AML error handling in
> the ACPI fan driver.
>
> While at it, update the driver to use consistent error values across
> all function using the union acpi_object data type.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>
> Applies on top of
>
> https://lore.kernel.org/linux-acpi/1965933.tdWV9SEqCh@rafael.j.wysocki/
>
> which is in linux-next now.
>
> ---
>   drivers/acpi/fan_core.c |   80 ++++++++++++++++++---------------------=
=2D--------
>   include/linux/acpi.h    |    2 +
>   2 files changed, 32 insertions(+), 50 deletions(-)
>
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -71,37 +71,29 @@ static int fan_get_max_state(struct ther
>   int acpi_fan_get_fst(acpi_handle handle, struct acpi_fan_fst *fst)
>   {
>   	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	union acpi_object *obj;
>   	acpi_status status;
> -	int ret =3D 0;
>  =20
>   	status =3D acpi_evaluate_object(handle, "_FST", NULL, &buffer);
>   	if (ACPI_FAILURE(status))
> -		return -EIO;
> +		return -ENXIO;
>  =20
> -	obj =3D buffer.pointer;
> +	union acpi_object *obj __free(acpi_object_free) =3D buffer.pointer;
>   	if (!obj)
>   		return -ENODATA;
>  =20
> -	if (obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count !=3D 3) {
> -		ret =3D -EPROTO;
> -		goto err;
> -	}
> +	if (obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count !=3D 3)
> +		return -EPROTO;
>  =20
>   	if (obj->package.elements[0].type !=3D ACPI_TYPE_INTEGER ||
>   	    obj->package.elements[1].type !=3D ACPI_TYPE_INTEGER ||
> -	    obj->package.elements[2].type !=3D ACPI_TYPE_INTEGER) {
> -		ret =3D -EPROTO;
> -		goto err;
> -	}
> +	    obj->package.elements[2].type !=3D ACPI_TYPE_INTEGER)
> +		return -EPROTO;
>  =20
>   	fst->revision =3D obj->package.elements[0].integer.value;
>   	fst->control =3D obj->package.elements[1].integer.value;
>   	fst->speed =3D obj->package.elements[2].integer.value;
>  =20
> -err:
> -	kfree(obj);
> -	return ret;
> +	return 0;
>   }
>  =20
>   static int fan_get_state_acpi4(struct acpi_fan *fan, unsigned long *st=
ate)
> @@ -237,25 +229,22 @@ static int acpi_fan_get_fif(struct acpi_
>   	struct acpi_buffer format =3D { sizeof("NNNN"), "NNNN" };
>   	u64 fields[4];
>   	struct acpi_buffer fif =3D { sizeof(fields), fields };
> -	union acpi_object *obj;
>   	acpi_status status;
>  =20
>   	status =3D acpi_evaluate_object(device->handle, "_FIF", NULL, &buffer=
);
>   	if (ACPI_FAILURE(status))
> -		return status;
> +		return -ENXIO;
>  =20
> -	obj =3D buffer.pointer;
> +	union acpi_object *obj __free(acpi_object_free) =3D buffer.pointer;
>   	if (!obj || obj->type !=3D ACPI_TYPE_PACKAGE) {
>   		dev_err(&device->dev, "Invalid _FIF data\n");
> -		status =3D -EINVAL;
> -		goto err;
> +		return -ENODATA;
>   	}
>  =20
>   	status =3D acpi_extract_package(obj, &format, &fif);
>   	if (ACPI_FAILURE(status)) {
>   		dev_err(&device->dev, "Invalid _FIF element\n");
> -		status =3D -EINVAL;
> -		goto err;
> +		return -ENODATA;
>   	}
>  =20
>   	fan->fif.revision =3D fields[0];
> @@ -269,9 +258,8 @@ static int acpi_fan_get_fif(struct acpi_
>   	/* If step size > 9, change to 9 (by spec valid values 1-9) */
>   	else if (fan->fif.step_size > 9)
>   		fan->fif.step_size =3D 9;
> -err:
> -	kfree(obj);
> -	return status;
> +
> +	return 0;
>   }
>  =20
>   static int acpi_fan_speed_cmp(const void *a, const void *b)
> @@ -285,27 +273,24 @@ static int acpi_fan_get_fps(struct devic
>   {
>   	struct acpi_fan *fan =3D acpi_driver_data(device);
>   	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> -	union acpi_object *obj;
>   	acpi_status status;
>   	int i;
>  =20
>   	status =3D acpi_evaluate_object(device->handle, "_FPS", NULL, &buffer=
);
>   	if (ACPI_FAILURE(status))
> -		return status;
> +		return -ENXIO;
>  =20
> -	obj =3D buffer.pointer;
> +	union acpi_object *obj __free(acpi_object_free) =3D buffer.pointer;
>   	if (!obj || obj->type !=3D ACPI_TYPE_PACKAGE || obj->package.count < =
2) {
>   		dev_err(&device->dev, "Invalid _FPS data\n");
> -		status =3D -EINVAL;
> -		goto err;
> +		return -ENODATA;
>   	}
>  =20
>   	fan->fps_count =3D obj->package.count - 1; /* minus revision field */
>   	fan->fps =3D devm_kcalloc(dev, fan->fps_count, sizeof(*fan->fps), GFP=
_KERNEL);
> -	if (!fan->fps) {
> -		status =3D -ENOMEM;
> -		goto err;
> -	}
> +	if (!fan->fps)
> +		return -ENOMEM;
> +
>   	for (i =3D 0; i < fan->fps_count; i++) {
>   		struct acpi_buffer format =3D { sizeof("NNNNN"), "NNNNN" };
>   		struct acpi_buffer fps =3D { offsetof(struct acpi_fan_fps, name),
> @@ -314,7 +299,7 @@ static int acpi_fan_get_fps(struct devic
>   					      &format, &fps);
>   		if (ACPI_FAILURE(status)) {
>   			dev_err(&device->dev, "Invalid _FPS element\n");
> -			goto err;
> +			return -ENODATA;
>   		}
>   	}
>  =20
> @@ -322,9 +307,7 @@ static int acpi_fan_get_fps(struct devic
>   	sort(fan->fps, fan->fps_count, sizeof(*fan->fps),
>   	     acpi_fan_speed_cmp, NULL);
>  =20
> -err:
> -	kfree(obj);
> -	return status;
> +	return 0;
>   }
>  =20
>   static int acpi_fan_dsm_init(struct device *dev)
> @@ -338,8 +321,6 @@ static int acpi_fan_dsm_init(struct devi
>   	};
>   	struct acpi_fan *fan =3D dev_get_drvdata(dev);
>   	acpi_handle fan_handle =3D fan->adev->handle;
> -	union acpi_object *obj;
> -	int ret =3D 0;
>  =20
>   	if (!acpi_check_dsm(fan_handle, &acpi_fan_microsoft_guid, 0,
>   			    BIT(ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY) |
> @@ -348,20 +329,19 @@ static int acpi_fan_dsm_init(struct devi
>  =20
>   	dev_info(dev, "Using Microsoft fan extensions\n");
>  =20
> -	obj =3D acpi_evaluate_dsm_typed(fan_handle, &acpi_fan_microsoft_guid, =
0,
> -				      ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY, &dummy,
> -				      ACPI_TYPE_INTEGER);
> +	union acpi_object *obj __free(acpi_object_free) =3D
> +		acpi_evaluate_dsm_typed(fan_handle, &acpi_fan_microsoft_guid, 0,
> +					ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY,
> +					&dummy, ACPI_TYPE_INTEGER);
>   	if (!obj)
> -		return -EIO;
> +		return -ENXIO;
>  =20
>   	if (obj->integer.value > U32_MAX)
> -		ret =3D -EOVERFLOW;
> -	else
> -		fan->fan_trip_granularity =3D obj->integer.value;
> +		return -EOVERFLOW;
>  =20
> -	kfree(obj);
> +	fan->fan_trip_granularity =3D obj->integer.value;
>  =20
> -	return ret;
> +	return 0;
>   }
>  =20
>   static int acpi_fan_dsm_set_trip_points(struct device *dev, u64 upper,=
 u64 lower)
> @@ -392,7 +372,7 @@ static int acpi_fan_dsm_set_trip_points(
>  =20
>   	obj =3D acpi_evaluate_dsm(fan->adev->handle, &acpi_fan_microsoft_guid=
,
>   				0, ACPI_FAN_DSM_SET_TRIP_POINTS, &in);
> -	kfree(obj);
> +	ACPI_FREE(obj);
>  =20
>   	return 0;
>   }
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -27,6 +27,8 @@ struct irq_domain_ops;
>   #include <acpi/acpi.h>
>   #include <acpi/acpi_numa.h>
>  =20
> +DEFINE_FREE(acpi_object_free, union acpi_object *, if (_T) ACPI_FREE(_T=
));
> +
>   #ifdef	CONFIG_ACPI
>  =20
>   #include <linux/list.h>
>
>
>
