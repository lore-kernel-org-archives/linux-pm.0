Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BC4BA1F2;
	Fri, 11 Sep 2026 21:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161930; cv=none; b=G2If/BA5v7UtIqVjMDWlEeTVjrs6SEtGTKUOyWKpHBGL9gCo4VvygnHkYx4XNTFyOBKq0usOb05Klw7X6FBaLsbeeatvIudBmRc1KMKJ28Sp5RZTlG/avgfrbriN2rctnmzTCJWh4f2Lo88mgyOYH09fO9DoLMTsykUO+m0HRRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161930; c=relaxed/simple;
	bh=SQ7q1859v7Wka9yb8SMeFetnEt2uiadQN4C1GTPRZxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lyKGSJkNwKMJGS+o2glLTFmTdyxwn9qKpYUDA8pVQRZB9DK2xJXrdvYjEV8fbyDPm4+tuToLrQtuD/HrWfdH09HAGW6+4BBvoFdBvoZ3Bw6cl9pVk+JCgtgXXLhuJ4GYDmvfBRR2O5rmkXMlpiJ1ArhMbPdA5amVYp/NbPLC760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iFVdPE0z; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iFVdPE0z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789161925; x=1789766725; i=w_armin@gmx.de;
	bh=okFzOzM+xxqJNYFq3IMILXAdG7PiXIeBWDYY1xua8qs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iFVdPE0zhZvTtyGCzAnTZ+IVwoNuKsK6Jt7hVRTOhid3EAWy6cOqEUi2nfOTgHOj
	 wWHHsTREpPInSWXlZLmbLO4McH1CSdARG1uS1u/crKAGhgyHJyOIn8//kaMZ8/Wgv
	 hj7dzbjapOUGxsvdf8N8J2uTDqrp79GOWaRz5OFsZuw+5mXM7+Y0BmRPZWb5FcqtI
	 Om6NYPJN9LMzi9X3XA9z8vxoif3SYX6u7l/peGpquK5Uku79T26PDo9QjKSsy3CUR
	 IcxK3/uxiy/kcgDR3bA0d5Ut+V57oX5ZW/AKf/iHfPNCr/sZSRcFBeyW/tjB6rwuf
	 vd6+Q01c4cpQASWVuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJmGZ-1xP9VU2GbZ-00HuJ8; Fri, 11
 Sep 2026 23:25:25 +0200
Message-ID: <ee841908-a9c7-40b6-a1ab-06177521bd5c@gmx.de>
Date: Fri, 11 Sep 2026 23:25:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 09/10] ACPI: fan: Store ACPI device pointer in struct
 acpi_fan
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <8772267.NyiUUSuA9g@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <8772267.NyiUUSuA9g@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:zFflXWITAWDVnAag43FrarZOBcaRYMXBOkTXuIgiBXTaaKrC7bK
 pAAanjU5q4WdiZCnWkluHArAs5ILz6lKFBBeJFlHABGgSFQww44PU8Rkcmils/yutuWNAaY
 0uKK7/UeE8VC1v1y/rYRubhRVRBrXa8X1kVpKwWar3FhRqPq+p6ltHeRlThTd1uTQZdeBKd
 bIN9IWrZopbm49alsA9fA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5nj5ttWvOdk=;+rxQ1y9apfCFiYSxPuGteP688Ez
 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
 xi4I8rONNeRVKLNyWTz5ZX

Am 11.09.26 um 15:06 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> In preparation for subsequent changes, instead of storing a fan ACPI
> handle in struct acpi_fan, store a pointer to the corresponding struct
> acpi_device in it.
>
> No intentional functional impact.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/fan.h       |  2 +-
>   drivers/acpi/fan_core.c  | 11 ++++++-----
>   drivers/acpi/fan_hwmon.c |  2 +-
>   3 files changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/fan.h b/drivers/acpi/fan.h
> index e20d6ad9df80..3faa247af514 100644
> --- a/drivers/acpi/fan.h
> +++ b/drivers/acpi/fan.h
> @@ -52,7 +52,7 @@ struct acpi_fan_fst {
>   };
>  =20
>   struct acpi_fan {
> -	acpi_handle handle;
> +	struct acpi_device *adev;
>   	bool acpi4;
>   	bool has_fst;
>   	struct acpi_fan_fif fif;
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 29ca97503deb..8b20b8a55c13 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -340,17 +340,18 @@ static int acpi_fan_dsm_init(struct device *dev)
>   		},
>   	};
>   	struct acpi_fan *fan =3D dev_get_drvdata(dev);
> +	acpi_handle fan_handle =3D fan->adev->handle;
>   	union acpi_object *obj;
>   	int ret =3D 0;
>  =20
> -	if (!acpi_check_dsm(fan->handle, &acpi_fan_microsoft_guid, 0,
> +	if (!acpi_check_dsm(fan_handle, &acpi_fan_microsoft_guid, 0,
>   			    BIT(ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY) |
>   			    BIT(ACPI_FAN_DSM_SET_TRIP_POINTS)))
>   		return 0;
>  =20
>   	dev_info(dev, "Using Microsoft fan extensions\n");
>  =20
> -	obj =3D acpi_evaluate_dsm_typed(fan->handle, &acpi_fan_microsoft_guid,=
 0,
> +	obj =3D acpi_evaluate_dsm_typed(fan_handle, &acpi_fan_microsoft_guid, =
0,
>   				      ACPI_FAN_DSM_GET_TRIP_POINT_GRANULARITY, &dummy,
>   				      ACPI_TYPE_INTEGER);
>   	if (!obj)
> @@ -392,8 +393,8 @@ static int acpi_fan_dsm_set_trip_points(struct devic=
e *dev, u64 upper, u64 lower
>   	};
>   	union acpi_object *obj;
>  =20
> -	obj =3D acpi_evaluate_dsm(fan->handle, &acpi_fan_microsoft_guid, 0,
> -				ACPI_FAN_DSM_SET_TRIP_POINTS, &in);
> +	obj =3D acpi_evaluate_dsm(fan->adev->handle, &acpi_fan_microsoft_guid,
> +				0, ACPI_FAN_DSM_SET_TRIP_POINTS, &in);
>   	kfree(obj);
>  =20
>   	return 0;
> @@ -503,7 +504,7 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   		return -ENOMEM;
>   	}
>  =20
> -	fan->handle =3D device->handle;
> +	fan->adev =3D device;
>   	device->driver_data =3D fan;
>   	platform_set_drvdata(pdev, fan);
>  =20
> diff --git a/drivers/acpi/fan_hwmon.c b/drivers/acpi/fan_hwmon.c
> index d3374f8f524b..c5d8419f41c5 100644
> --- a/drivers/acpi/fan_hwmon.c
> +++ b/drivers/acpi/fan_hwmon.c
> @@ -94,7 +94,7 @@ static int acpi_fan_hwmon_read(struct device *dev, enu=
m hwmon_sensor_types type,
>   	struct acpi_fan_fst fst;
>   	int ret;
>  =20
> -	ret =3D acpi_fan_get_fst(fan->handle, &fst);
> +	ret =3D acpi_fan_get_fst(fan->adev->handle, &fst);
>   	if (ret < 0)
>   		return ret;
>  =20
