Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB6F35E1AD;
	Fri, 11 Sep 2026 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161636; cv=none; b=JxM1rUDTWFP7uE0l3+1S/eecAF0YrCCdwfO0775cMcqlGtGBMiqNd5x65uZCuYkmX5nL8tDn4RwRQ9oOazcVS8qAyn1FU3HRqpQ8s8L1Vdjm/5YC7DM+UtvJB3mcV0/j/HvEAYQJz+ajxQ8ZOESaiADidsjVw39VF6gNbck6dMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161636; c=relaxed/simple;
	bh=V0Z88YSfzYSMcy7eUKYhytVzmXtEiSIXfwb01u9io04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtUZpk+TWr8emH52EG/1PIJPV8nXkw+LxUs1Mx9W4S6TE/9c3/oVPp2W5gayJIzVE5sDCeW2fDFCprXDUtaZz2Qn0ZAjw1IARQxkT9ohaT9hc0zQAVx3aXjrr1pFhXz2p2TAoYJf5Y967wqZxwhzmvE4EJ6WgiLG2hTZu6mKsKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=DpZt5TIE; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="DpZt5TIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789161632; x=1789766432; i=w_armin@gmx.de;
	bh=bIcGi+VBoQ4R9Bioj015rwhWRiIiXUWQ+2kQn0dya1Y=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=DpZt5TIEXEE9q0CqpNUWQ4sf3ANu+IttkCqYK+T11ZDCpIYgvdRZoZOZTVR7l6Z6
	 kdL/9+zyYBpkEXYjHkncWhhU9sMCvPYEL+AzA+ZXUS8NjAoxmbvv/9zC3LtQ9ucMC
	 j4GH41/lOvsJMvC93eCpKtZuSr4zDv73C+g6LVVRo4MyPedW050at8Q/It9fB7Ukd
	 WjuI0xAkiNMyj5FTO7Q3ccTDhajdTeXRMucVVs1gOWua/0t5ZTuOiN2Hh8OK2epK/
	 xr7TYZqM4NVpBwK1KOif2tVp3ogM1f/YCra6pLsyLrYDdMSZIQ2Dms8uwA49NwL7L
	 T3QlyzdqfDSYStzunQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1wtvqx0z7v-00xGXj; Fri, 11
 Sep 2026 23:20:32 +0200
Message-ID: <8b0aaee6-9ea7-4c0a-a592-573b4efe1a69@gmx.de>
Date: Fri, 11 Sep 2026 23:20:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 07/10] ACPI: thermal: Use cooling device parent for
 thermal zone binding
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <9672996.CDJkKcVGEf@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <9672996.CDJkKcVGEf@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YOrYxHuvj1ZQfJFPCa+u+LdfX8E0UHFibdcER0Tn/oA7vLq+y+3
 8pRXNnOeSdIc9DPW7bU15tWtnj1+EK5V1rWJUf4sPr2PkgnovsoEZO3xks/pvHO9P4bgZl/
 BHWq58YtU38J0+0AvM4ZWyNes0NK+3GGRQgt+w3GeeSdtUcr450HOyp3PVi095FtjsO0bWj
 k5d7vYV11Wz96PoSUACyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EcDz/g6ZC2g=;oyg4U3Z6JMjCFGmDChsSrtGbTi6
 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
 BVHNOpzx9NOx1zvHhUJRflIx7QxAXPEEjVg==

Am 11.09.26 um 15:05 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> The ACPI thermal zone .should_bind() callback function,
> acpi_thermal_should_bind_cdev(), expects the given cooling device's
> devdata to point to an ACPI device object whose ACPI handle should be
> compared with ACPI handles in a list associated with the given trip
> point.  That is not particularly straightforward and it effectively
> requires the drivers of ACPI cooling devices to populate the devdata
> with addresses of the ACPI companions of the devices they bind to.
> Consequently, the devdata cannot be used by the driver for its own
> needs which is its intended purpose.
>
> That can be overcome with the help of the observation that the
> ACPI device objects to be matched against the lists of ACPI handles
> associated with trip points are in fact the ACPI companions of the
> parents of cooling devices.  Thus instead of using the given cooling
> device's devdata, it is sufficient to obtain the ACPI handle of its
> parent and compare that ACPI handle with the ones in the list
> associated with the given trip point.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/thermal.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index dd7666c176a0..dea28d674407 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -564,17 +564,18 @@ static bool acpi_thermal_should_bind_cdev(struct t=
hermal_zone_device *thermal,
>   					  struct cooling_spec *c)
>   {
>   	struct acpi_thermal_trip *acpi_trip =3D trip->priv;
> -	struct acpi_device *cdev_adev =3D cdev->devdata;
> +	struct device *parent =3D cdev->device.parent;
> +	acpi_handle parent_handle;
>   	int i;
>  =20
> -	/* Skip critical and hot trips. */
> -	if (!acpi_trip)
> +	/* Skip critical and hot trips and parentless cooling devices. */
> +	if (!acpi_trip || !parent)
>   		return false;
>  =20
> -	for (i =3D 0; i < acpi_trip->devices.count; i++) {
> -		acpi_handle handle =3D acpi_trip->devices.handles[i];
> +	parent_handle =3D ACPI_HANDLE(parent);
>  =20

Please check parent_handle for NULL here so we can return early. With this=
 being fixed:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> -		if (acpi_fetch_acpi_dev(handle) =3D=3D cdev_adev)
> +	for (i =3D 0; i < acpi_trip->devices.count; i++) {
> +		if (acpi_trip->devices.handles[i] =3D=3D parent_handle)
>   			return true;
>   	}
>  =20
