Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881CC379993;
	Fri, 11 Sep 2026 21:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161126; cv=none; b=H/AtaV9NeAjvPDiHywQjyDjoZO+1Ty/ONLzkp1/2HJixQgaljHS3ha7Vtrc5lsLj2KIAiuqB2NUkg6iyMannwkMe1BkmjRedNx2xtGpTMjRZ9t1HxSw1tio+BThr4BDPn2qb+wHx2Zf2Nnz1N94/HpUJRI+nt9jZg4/ftgU68PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161126; c=relaxed/simple;
	bh=ZJJf2wXIPlu00Atn2bOxCGjNo78z0uT//Hd9mlcAkpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PELHV/H3RFIakn9TVKOGEpoU1gp7WIhdzIQSBGV7JqKNXgu8UVZrQkIqTdNkT7zprMrkQUzl/2UpxAna7czMWwPJfnLSv5jlsf5sEFEODxpZdOwmxvYUs5DsRuqFZFH2tcCM+LKzWL7jVoI3lu1CWUmTCpHpJdexKQLDHfipFfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=CLE30z9e; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="CLE30z9e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789161113; x=1789765913; i=w_armin@gmx.de;
	bh=A3+TNzQFcwv6Dior/hg75omZe/y9T66iQklwCl00ncE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=CLE30z9eoZJdYfkLtDMkf+AOXV/Ru+/7FnH4oFtapyGsMmKyK+7aBPu6EVtCmDLL
	 tYbWjBVKGUHFzzFgMeGzUxocv9J71rXNrEoJzx8O3/4gY84RkmMyId5a9ej9+ZZeg
	 F/3ZKCW1BU+JV4YjXy4UkEQgYM5NX5MSQx5iLfyRZyXe6tkwu9X3CswbIH31DMeqL
	 ZEcd5qqcVpb+QXKJEiKL+SZPSYnlERZv9tLh81KYWl3Y06QJTl5YCtEhJlgRpsB7T
	 bShwfAv3H81skwnfbsNlS+nGhKJiaY5bcnzQPNWIfr4IKfeD/eMUHsKLocF+aCz8t
	 bCmWncLX7UNb0wWpTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnakR-1wMPjY1drx-00lpb8; Fri, 11
 Sep 2026 23:11:53 +0200
Message-ID: <af8eb0a4-cb4e-4728-9824-6233c3357360@gmx.de>
Date: Fri, 11 Sep 2026 23:11:51 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/10] ACPI: processor: thermal: Use
 thermal_cooling_device_create()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <2362345.iZASKD2KPV@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2362345.iZASKD2KPV@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3EiwnBivrYte3m26nYFDaQy7lPykd55P4tmmh3vQkBUuqZtVyzk
 f2JolUO7GwtyLqS4R5n7OIjGnaL2nnKa9+CVTPkoeX72kCM3aR9lXlzIo+OUTqAhbVCuZsx
 PZTqwii94+sRDqlgKQa0lwDbWBrETWfEZt/DS6U5pTCUGALqWzNr4tckaA+K+5tFVqDaget
 bDPYyUOhnd5TgisIGQHMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:969S9GNF/5Y=;DYdeUJmErysd3Nu29X7F7zQN19s
 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
 2LlZG7rHwFJTP

Am 11.09.26 um 15:02 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Instead of using thermal_cooling_device_register() for registering
> a cooling device in the ACPI processor driver, make it use
> thermal_cooling_device_create() and pass a pointer to the processor
> device representing the given CPU to that function as the cooling
> device's parent.  That will cause the cooling device's sysfs directory
> to be created under the parent's sysfs directory (among other things).
>
> Since creating a class device under a parent causes a "device" symbolic
> link from the sysfs directory of the class device to the sysfs directory
> of the parent to appear automatically, remove the code creating the
> "device" symbolic link from the sysfs directory of the cooling device
> in question to the sysfs directory of the parent's companion ACPI
> device.  That ACPI device is reachable through the "firmware_node"
> symbolic link in the parent's sysfs directory regardless.
>
> Moreover, since the cooling device is now located in sysfs under its
> parent and it can be easily identified as a cooling device, there is
> no need to create a "thermal_cooling" symbolic link from its parent's
> ACPI companion to it.  Accordingly, also remove the code creating that
> symbolic link.
>
> While at it, check for error pointer values in addition to checking
> for NULL in acpi_processor_thermal_exit() to avoid dereferncing them
> mistakenly.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/processor_driver.c  |  4 +--
>   drivers/acpi/processor_thermal.c | 47 +++++---------------------------
>   include/acpi/processor.h         |  3 +-
>   3 files changed, 10 insertions(+), 44 deletions(-)
>
> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processor_dr=
iver.c
> index cdc2ae1632b2..90c14480393d 100644
> --- a/drivers/acpi/processor_driver.c
> +++ b/drivers/acpi/processor_driver.c
> @@ -179,7 +179,7 @@ static int __acpi_processor_start(struct acpi_device=
 *device)
>   	return 0;
>  =20
>   err_thermal_exit:
> -	acpi_processor_thermal_exit(pr, device);
> +	acpi_processor_thermal_exit(pr);
>   err_power_exit:
>   	acpi_processor_power_exit(pr);
>   	return result;
> @@ -203,7 +203,7 @@ static int acpi_processor_stop(struct device *dev)
>  =20
>   	acpi_cppc_processor_exit(pr);
>  =20
> -	acpi_processor_thermal_exit(pr, device);
> +	acpi_processor_thermal_exit(pr);
>  =20
>   	return 0;
>   }
> diff --git a/drivers/acpi/processor_thermal.c b/drivers/acpi/processor_t=
hermal.c
> index c7b1dc5687ec..6cd47551844a 100644
> --- a/drivers/acpi/processor_thermal.c
> +++ b/drivers/acpi/processor_thermal.c
> @@ -311,52 +311,19 @@ const struct thermal_cooling_device_ops processor_=
cooling_ops =3D {
>   int acpi_processor_thermal_init(struct acpi_processor *pr,
>   				struct acpi_device *device)
>   {
> -	int result =3D 0;
> -
> -	pr->cdev =3D thermal_cooling_device_register("Processor", device,
> -						   &processor_cooling_ops);
> -	if (IS_ERR(pr->cdev)) {
> -		result =3D PTR_ERR(pr->cdev);
> -		return result;
> -	}
> -
> -	dev_dbg(&device->dev, "registered as cooling_device%d\n",
> -		pr->cdev->id);
> -
> -	result =3D sysfs_create_link(&device->dev.kobj,
> -				   &pr->cdev->device.kobj,
> -				   "thermal_cooling");
> -	if (result) {
> -		dev_err(&device->dev,
> -			"Failed to create sysfs link 'thermal_cooling'\n");
> -		goto err_thermal_unregister;
> -	}
> +	pr->cdev =3D thermal_cooling_device_create(pr->dev, "Processor", devic=
e,
> +						 &processor_cooling_ops);
> +	if (IS_ERR(pr->cdev))
> +		return PTR_ERR(pr->cdev);
>  =20
> -	result =3D sysfs_create_link(&pr->cdev->device.kobj,
> -				   &device->dev.kobj,
> -				   "device");
> -	if (result) {
> -		dev_err(&pr->cdev->device,
> -			"Failed to create sysfs link 'device'\n");
> -		goto err_remove_sysfs_thermal;
> -	}
> +	dev_dbg(pr->dev, "registered as cooling_device%d\n", pr->cdev->id);
>  =20
>   	return 0;
> -
> -err_remove_sysfs_thermal:
> -	sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> -err_thermal_unregister:
> -	thermal_cooling_device_unregister(pr->cdev);
> -
> -	return result;
>   }
>  =20
> -void acpi_processor_thermal_exit(struct acpi_processor *pr,
> -				 struct acpi_device *device)
> +void acpi_processor_thermal_exit(struct acpi_processor *pr)
>   {
> -	if (pr->cdev) {
> -		sysfs_remove_link(&device->dev.kobj, "thermal_cooling");
> -		sysfs_remove_link(&pr->cdev->device.kobj, "device");
> +	if (!IS_ERR_OR_NULL(pr->cdev)) {
>   		thermal_cooling_device_unregister(pr->cdev);
>   		pr->cdev =3D NULL;
>   	}
> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> index 554be224ce76..656aaf74fb18 100644
> --- a/include/acpi/processor.h
> +++ b/include/acpi/processor.h
> @@ -429,8 +429,7 @@ int acpi_processor_ffh_lpi_enter(struct acpi_lpi_sta=
te *lpi);
>   /* in processor_thermal.c */
>   int acpi_processor_thermal_init(struct acpi_processor *pr,
>   				struct acpi_device *device);
> -void acpi_processor_thermal_exit(struct acpi_processor *pr,
> -				 struct acpi_device *device);
> +void acpi_processor_thermal_exit(struct acpi_processor *pr);
>   extern const struct thermal_cooling_device_ops processor_cooling_ops;
>   #ifdef CONFIG_CPU_FREQ
>   void acpi_thermal_cpufreq_init(struct cpufreq_policy *policy);
