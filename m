Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBF24BA1DE;
	Fri, 11 Sep 2026 21:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161781; cv=none; b=jhTIpAVI7RtGcWJ7qVuMbcBAhMGPzkewGVWoxu1l9QYqfDa5k5UJ24ENh8baTKCmWTgT1F6ac2s3uczWtlSQHf+u2ytX6Nl/+TFD+xZVkHGdD5ueplRFU2XOVB1Ki5atWUaX8zlEVACewy0uW6FqrWc9J0sCmRCr5kFjmFoOaRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161781; c=relaxed/simple;
	bh=QNI0iS8iHmF1CI3g6w11bzJuQrQeBfN+QBHognhLFS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnoozN9wgDb8z1KsMqfq7UYF0Kh7Lv2n2rZkQ8zDxYrgWo63nWpcpx3c/mq66Yj4d+mhR+wV9WD/nULGVdwWUHo0jWusrnjWNT2fu2XM0JcPV14fAv4fN0w+hPCaqXbYDdYWGQmz727GlusScvqBg7hAwsd4fl7A9KZn2p9ZIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Ie/RQdaS; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Ie/RQdaS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789161773; x=1789766573; i=w_armin@gmx.de;
	bh=jrqJYaG3sUhuS4rLEuVeiebPKaFwL4rNxm979QRZcKE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Ie/RQdaSZiPBydlaoFeR6C8PIcEIZHqxmmGp0VWpNsVug4+XHB0sdY7hVKvbzsJe
	 m/x5gn4KF8rAIQwJF/QUbMpQUDmAK+L5CzQVr1Efx2JenouT/U75w9CtZsTa0NnOG
	 lV3ouTiw6ggFZ0DyZ6N3n7yLeO1wA4baLsKM7jfMFGkiPqiPzr7EAi+mT2Bw72Xbb
	 6fjBHPiaHMs8BgzzgtDa6Qxs0vUSNTJ+tWr+QkVKRFdwxoJm7Lv8tXl8YlvVroMlP
	 FDhWtZKHnEfMX73PV5MDdrDhSarkqGMbpWwgoZbtW0GXCdjSD2YIKBK6e7EPIrVIa
	 9GZE7aLt5daydEH+xg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVHe-1xOsVx1juC-00HcLy; Fri, 11
 Sep 2026 23:22:53 +0200
Message-ID: <8aa4904c-dc44-4b75-86b8-061fff3cd1bc@gmx.de>
Date: Fri, 11 Sep 2026 23:22:52 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/10] ACPI: processor: thermal: Use more suitable
 cooling device data
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <6192780.MhkbZ0Pkbq@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <6192780.MhkbZ0Pkbq@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CICXbEBAjMeVf8I4xY2F0D35nB78gilvxstojqchxGuiuJPeTBh
 e+JhB8zyXhR/85ahHbaJVi72tdelUTAtJEo/MytczYjlLef1mUQ5E7JV7ieQGPrVPc0i9QH
 TpxIak5hDh03EB3CO/MeThQq/H2etyQbnd1vySPaLLBKwtCEsRDMCV2fdb03N2E1iepYQo5
 Eb7i6OtRjGR6tljwbojLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:nSvHQo2ToAQ=;xWdG7NWZPFqu9n1S8YpYYWTERCb
 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
 RaU0wrRacbc3vloROmxOLxNG+r9dBJ2sASw==

Am 11.09.26 um 15:05 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Instead of passing an ACPI device object pointer as devdata to
> thermal_cooling_device_create(), make acpi_processor_thermal_init()
> pass a pointer to the struct acpi_processor representing the given CPU
> to it, which allows the callback functions in processor_cooling_ops to
> be simplified and the second argument of acpi_processor_thermal_init()
> and acpi_processor_thermal_exit() to be dropped.
>
> No intentional functional impact.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/processor_driver.c  |  2 +-
>   drivers/acpi/processor_thermal.c | 35 +++++---------------------------
>   include/acpi/processor.h         |  3 +--
>   3 files changed, 7 insertions(+), 33 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dr=
iver.c
> index 90c14480393d..bdd1529d79f0 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -164,7 +164,7 @@ static int __acpi_processor_start(struct acpi_device=
 *device)
>  =20
>   	acpi_pss_perf_init(pr);
>  =20
> -	result =3D acpi_processor_thermal_init(pr, device);
> +	result =3D acpi_processor_thermal_init(pr);
>   	if (result)
>   		goto err_power_exit;
>  =20
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_t=
hermal.c
> index 6cd47551844a..11036f0d2b94 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -235,15 +235,7 @@ static int
>   processor_get_max_state(struct thermal_cooling_device *cdev,
>   			unsigned long *state)
>   {
> -	struct acpi_device *device =3D cdev->devdata;
> -	struct acpi_processor *pr;
> -
> -	if (!device)
> -		return -EINVAL;
> -
> -	pr =3D acpi_driver_data(device);
> -	if (!pr)
> -		return -EINVAL;
> +	struct acpi_processor *pr =3D cdev->devdata;
>  =20
>   	*state =3D acpi_processor_max_state(pr);
>   	return 0;
> @@ -253,15 +245,7 @@ static int
>   processor_get_cur_state(struct thermal_cooling_device *cdev,
>   			unsigned long *cur_state)
>   {
> -	struct acpi_device *device =3D cdev->devdata;
> -	struct acpi_processor *pr;
> -
> -	if (!device)
> -		return -EINVAL;
> -
> -	pr =3D acpi_driver_data(device);
> -	if (!pr)
> -		return -EINVAL;
> +	struct acpi_processor *pr =3D cdev->devdata;
>  =20
>   	*cur_state =3D cpufreq_get_cur_state(pr->id);
>   	if (pr->flags.throttling)
> @@ -273,18 +257,10 @@ static int
>   processor_set_cur_state(struct thermal_cooling_device *cdev,
>   			unsigned long state)
>   {
> -	struct acpi_device *device =3D cdev->devdata;
> -	struct acpi_processor *pr;
> +	struct acpi_processor *pr =3D cdev->devdata;
>   	int result =3D 0;
>   	int max_pstate;
>  =20
> -	if (!device)
> -		return -EINVAL;
> -
> -	pr =3D acpi_driver_data(device);
> -	if (!pr)
> -		return -EINVAL;
> -
>   	max_pstate =3D cpufreq_get_max_state(pr->id);
>  =20
>   	if (state > acpi_processor_max_state(pr))
> @@ -308,10 +284,9 @@ const struct thermal_cooling_device_ops processor_c=
ooling_ops =3D {
>   	.set_cur_state =3D processor_set_cur_state,
>   };
>  =20
> -int acpi_processor_thermal_init(struct acpi_processor *pr,
> -				struct acpi_device *device)
> +int acpi_processor_thermal_init(struct acpi_processor *pr)
>   {
> -	pr->cdev =3D thermal_cooling_device_create(pr->dev, "Processor", devic=
e,
> +	pr->cdev =3D thermal_cooling_device_create(pr->dev, "Processor", pr,
>   						 &processor_cooling_ops);
>   	if (IS_ERR(pr->cdev))
>   		return PTR_ERR(pr->cdev);
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 656aaf74fb18..b5447af4d40b 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -427,8 +427,7 @@ int acpi_processor_ffh_lpi_enter(struct acpi_lpi_sta=
te *lpi);
>   #endif /* CONFIG_ACPI_PROCESSOR_IDLE */
>  =20
>   /* in processor_thermal.c */
> -int acpi_processor_thermal_init(struct acpi_processor *pr,
> -				struct acpi_device *device);
> +int acpi_processor_thermal_init(struct acpi_processor *pr);
>   void acpi_processor_thermal_exit(struct acpi_processor *pr);
>   extern const struct thermal_cooling_device_ops processor_cooling_ops;
>   #ifdef CONFIG_CPU_FREQ
