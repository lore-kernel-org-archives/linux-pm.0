Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254B0599A33;
	Fri, 11 Sep 2026 21:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161377; cv=none; b=ZtflM3AvsN9aMcIM68dJ2BZjRsG+/n9lJDwXIGT8g4dYVdU1WcumHD7R8cjmVUcGwR2jG4SBxgaNJCxc9MtpeImW76Hs57Oh+Kmf6q7qNQLE/VFMImo1XEErxzQYYSXYL3bTqdFbKt1zUEiCxKgAYMtzoTVRrHilnl3DYoNL0hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161377; c=relaxed/simple;
	bh=dgzJVskIA/AR/IOvl0vIDVrcmzNEPwsF8UiNIoH00HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr5Mj9FNQtiUXoW1Q36nvobCCgzXDaWCHk6h4nNooHQdCxNTYEora2KFDGvRR2h29KYjqGTcK2T5D0aUBGzp5qK0Wj75yh3DBMSiqG2BDrk89upSE+fOlEzJMkgVfDyzYsMIcsfTpSF8KOHlPt1jt+gT8ib4FHbGmmkY0HmfVM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=kRop72S7; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="kRop72S7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789161366; x=1789766166; i=w_armin@gmx.de;
	bh=1JcENN9NQgC4y/bR6i+2Ozig7iK8apg7GYGcFSBNisY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=kRop72S7B7eS/q2X5h3C0jPa5uO6yZDaWYkReibsXpIRF7duJFFb0O/W2p3Z6Uyw
	 EfP7tVUdBi+KwdO/0ytxN1SzGk1I7ro+AxVwWemscRs9fCO/g9bTOpqOxTIxYBixr
	 E2ZoIJHgJOD8XtrRCp0ajz4s/8MoqT32/50iIVXdhaEuYeLwt84x60Rc4mdzD74lk
	 ZLe9JJPVXF8vKSbotd7C7rELyv8I4O0LtmcglzkeXaqF3n0YSh5zwYFb7UGspmiFR
	 wZoAn7aRr8HPXfC8Uv3n1K4aKkX2w7rgdCLhNwLLLzSSdaR5N9BOGuocPJPdRODJO
	 Q27qq0aZYPP6/jE+Pw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MZCb5-1xIWcp1i7N-00XJTs; Fri, 11
 Sep 2026 23:16:06 +0200
Message-ID: <346b9665-c034-49d4-a6fe-7c27b05e84e8@gmx.de>
Date: Fri, 11 Sep 2026 23:16:05 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/10] ACPI: video: Use thermal_cooling_device_create()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <23237491.EfDdHjke4D@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <23237491.EfDdHjke4D@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5igmyc5OTi+SXxwQbJpts8us9/4EJjLGdVf7eSwbZw2hlSB0P+u
 pU53/pQ3C22SZ23GYhCZcpIi8A4SFDz8DQkzB7kKE8viuYLy5wCGaLMkqZ17fsT+LB2J301
 J2Zpsegbz4mdrs4X0+GmStaJqA7KJCqVlEcbd2q2F1tV8nSbLR9ap7RZig2riE4Ke+oDpdX
 C/7MbE7q/yZql5yQJ6bag==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U4Chvw50M14=;8HwELzGzpu9JcVvj+3/vwM04Wle
 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
 po3Va1uIbIHx3YWDvjuSA9adJ+G9FbBQ4FA==

Am 11.09.26 um 15:03 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Instead of using thermal_cooling_device_register() for registering a
> backlight cooling device in the ACPI video bus driver, make it use
> thermal_cooling_device_create() and pass a pointer to the LCD device
> to that function as the cooling class device's parent.  That will
> cause the cooling device's sysfs directory to be created under
> the parent's sysfs directory (among other things).
>
> Since creating a class device under a parent causes a "device" symbolic
> link from the sysfs directory of the class device to the sysfs directory
> of the parent to appear automatically, remove the code creating the
> "device" symbolic link from the sysfs directory of the cooling device
> in question to the sysfs directory of the parent's ACPI companion
> device.  That companion device is reachable through the "firmware_node"
> symbolic link in the parent's sysfs directory regardless.
>
> Moreover, since the cooling class device is now located in sysfs under
> its parent and it can be easily identified as a cooling device, there is
> no need to create a "thermal_cooling" symbolic link from its parent's
> ACPI companion to it.  Accordingly, also remove the code creating that
> symbolic link.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/acpi_video.c | 35 ++++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 6cfe390411c1..2a2822516665 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1700,9 +1700,9 @@ static int acpi_video_resume(struct notifier_block=
 *nb,
>  =20
>   static void acpi_video_dev_register_backlight(struct acpi_video_device=
 *device)
>   {
> +	struct device *phys_dev, *parent =3D NULL;
>   	struct backlight_properties props;
>   	struct pci_dev *pdev;
> -	struct device *parent =3D NULL;
>   	int result;
>   	static int count;
>   	char *name;
> @@ -1729,11 +1729,10 @@ static void acpi_video_dev_register_backlight(st=
ruct acpi_video_device *device)
>   						      device,
>   						      &acpi_backlight_ops,
>   						      &props);
> -	put_device(parent);
>   	kfree(name);
>   	if (IS_ERR(device->backlight)) {
>   		device->backlight =3D NULL;
> -		return;
> +		goto put_parent;
>   	}
>  =20
>   	/*
> @@ -1743,8 +1742,12 @@ static void acpi_video_dev_register_backlight(str=
uct acpi_video_device *device)
>   	device->backlight->props.brightness =3D
>   			acpi_video_get_brightness(device->backlight);
>  =20
> -	device->cooling_dev =3D thermal_cooling_device_register("LCD", device,
> -							      &video_cooling_ops);
> +	phys_dev =3D acpi_bus_get_primary_device(device->dev);
> +	if (!phys_dev)
> +		phys_dev =3D get_device(parent);
> +
> +	device->cooling_dev =3D thermal_cooling_device_create(phys_dev, "LCD",=
 device,
> +							    &video_cooling_ops);
>   	if (IS_ERR(device->cooling_dev)) {
>   		/*
>   		 * Set cooling_dev to NULL so we don't crash trying to free it.
> @@ -1753,21 +1756,17 @@ static void acpi_video_dev_register_backlight(st=
ruct acpi_video_device *device)
>   		 * -- dtor
>   		 */
>   		device->cooling_dev =3D NULL;
> -		return;
> +		goto put_phys_dev;
>   	}
>  =20
> -	dev_info(&device->dev->dev, "registered as cooling_device%d\n",
> -		 device->cooling_dev->id);
> -	result =3D sysfs_create_link(&device->dev->dev.kobj,
> -			&device->cooling_dev->device.kobj,
> -			"thermal_cooling");
> -	if (result)
> -		pr_info("sysfs link creation failed\n");
> +	dev_info(&device->cooling_dev->device, "Using ACPI device %s\n",
> +		acpi_dev_name(device->dev));
>  =20
> -	result =3D sysfs_create_link(&device->cooling_dev->device.kobj,
> -			&device->dev->dev.kobj, "device");
> -	if (result)
> -		pr_info("Reverse sysfs link creation failed\n");
> +put_phys_dev:
> +	put_device(phys_dev);
> +
> +put_parent:
> +	put_device(parent);
>   }
>  =20
>   static void acpi_video_run_bcl_for_osi(struct acpi_video_bus *video)
> @@ -1826,8 +1825,6 @@ static int acpi_video_bus_register_backlight(struc=
t acpi_video_bus *video)
>   static void acpi_video_dev_unregister_backlight(struct acpi_video_devi=
ce *device)
>   {
>   	if (device->cooling_dev) {
> -		sysfs_remove_link(&device->dev->dev.kobj, "thermal_cooling");
> -		sysfs_remove_link(&device->cooling_dev->device.kobj, "device");
>   		thermal_cooling_device_unregister(device->cooling_dev);
>   		device->cooling_dev =3D NULL;
>   	}
