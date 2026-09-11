Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25550EC11;
	Fri, 11 Sep 2026 21:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161495; cv=none; b=qyRhOUrRXpnL0m0Bq7Z1qo/OE/cFEGjmXHkxAbvXcHWj4hObUKqDXo0E/cFxwgGmBncvrHhvNsOHOyi7G/IKCFl1Le7+Lp4yBBbGab3di0Ku12xmOjGiFUnqpVzfwHmehd9fxwRUrXkE/k7wuA6AxDri5Z0VVi/Ixn68cyudGRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161495; c=relaxed/simple;
	bh=arpKIqLw79SdcTxtCztDx85AUOwYoJBiyb3EXYWj5bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TzIMsQWnpd4eyHmOcU8UXajZyyv3E2tc9+GcxmsZ0BsfjtzdegBXa+Gz197UICAt7LlmQm5tPBSclG25F37U1Xn7mRtfZAou2fFLO5+a5r615X/iV1mgKNFcWsVs7uwJambk/Zi/4VBpEwuJvYrdgkLA7VAN68zhtumsZuqOuJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SIv2sWi1; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SIv2sWi1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789161481; x=1789766281; i=w_armin@gmx.de;
	bh=192wtoXPDRrcW3PybPkbCPPuh2xymTZIvuslXbhgdhQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SIv2sWi1iZxZHBL2Mdz+Y5+sUzCDZjhBSDJYuTdIXUQI38Q5iZvV+FhyUQF0LxGc
	 0nOqCSpTDmpa8DGVNMKJUhggyMtpIjBtwYa0O3LkHdodd0orP2x+sl/qFyJr1zr3l
	 BUhkmfcEFsykhi+PQDj6vIB7rzA6VM227pnHJICcXRb0av7k4KX1x5cqeJzqzllqA
	 3c1ITn6W6PDoAYG4pUiMj8smXl3eUDO1aIAPAVcOu9bZMtBckGHHylQ73oQnDknjP
	 vc5Jmj3w54DZqdZBE0bNAX4jDMz29F6LJallpuRXfFs3J8uKifsMOmYpA04rV/7FQ
	 5900pgojGb+B1RTMaQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKUv-1xObrD3Nvz-00JY5d; Fri, 11
 Sep 2026 23:18:00 +0200
Message-ID: <a0c2f8bd-0d60-4533-aa02-f542a0ac05d4@gmx.de>
Date: Fri, 11 Sep 2026 23:17:59 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/10] ACPI: fan: Use thermal_cooling_device_create()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <3969045.kQq0lBPeGt@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3969045.kQq0lBPeGt@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jVw9K2xHlH+FSCxYTiM5aDZH6+5ZMEVfWyyUDcmFSmktHBw4ZAR
 0Wfzzbi05tl0sFazuVuRHZG3S0CJ6LY57cVbLDjl2rqMZVwwEiiFpPAXnPjBAG9I8xlvrGv
 vXPqKUHBMn4JyfdcvY2IXFydr7kquLzlCmW2++U3LhpcwgjfM+I9yzkaoP3gcM/x52h9yiz
 5tLdPxG9MCzCEOvX2+B/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:/j6VnIiTwmM=;UKI1NN3LWDaU492lWHIvOxDAFRZ
 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

Am 11.09.26 um 15:04 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Instead of using thermal_cooling_device_register() for
> registering a cooling device in the ACPI fan driver, make it use
> thermal_cooling_device_create() and pass a pointer to the platform
> device representing the given fan to that function as the cooling
> device's parent.  That will cause the cooling device's sysfs directory
> to be created under the parent's sysfs directory (among other things).
>
> Since creating a class device under a parent causes a "device" symbolic
> link from the sysfs directory of the class device to the sysfs directory
> of the parent to appear automatically, remove the code creating that
> symbolic link manually.
>
> Moreover, since the cooling device is now located in sysfs under its
> parent and it can be easily identified as a cooling device, there is
> no need to create a "thermal_cooling" symbolic link from its parent
> to it.  Accordingly, also remove the code creating that symbolic link.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/fan_core.c | 24 +-----------------------
>   1 file changed, 1 insertion(+), 23 deletions(-)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index a31d7beca5d0..29ca97503deb 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -564,8 +564,7 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   	else
>   		name =3D acpi_device_bid(device);
>  =20
> -	cdev =3D thermal_cooling_device_register(name, device,
> -						&fan_cooling_ops);
> +	cdev =3D thermal_cooling_device_create(&pdev->dev, name, device, &fan_=
cooling_ops);
>   	if (IS_ERR(cdev)) {
>   		result =3D PTR_ERR(cdev);
>   		goto err_end;
> @@ -574,28 +573,9 @@ static int acpi_fan_probe(struct platform_device *p=
dev)
>   	dev_dbg(&pdev->dev, "registered as cooling_device%d\n", cdev->id);
>  =20
>   	fan->cdev =3D cdev;
> -	result =3D sysfs_create_link(&pdev->dev.kobj,
> -				   &cdev->device.kobj,
> -				   "thermal_cooling");
> -	if (result) {
> -		dev_err(&pdev->dev, "Failed to create sysfs link 'thermal_cooling'\n"=
);
> -		goto err_unregister;
> -	}
> -
> -	result =3D sysfs_create_link(&cdev->device.kobj,
> -				   &pdev->dev.kobj,
> -				   "device");
> -	if (result) {
> -		dev_err(&pdev->dev, "Failed to create sysfs link 'device'\n");
> -		goto err_remove_link;
> -	}
>  =20
>   	return 0;
>  =20
> -err_remove_link:
> -	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
> -err_unregister:
> -	thermal_cooling_device_unregister(cdev);
>   err_end:
>   	if (fan->has_fst)
>   		acpi_fan_delete_attributes(device);
> @@ -612,8 +592,6 @@ static void acpi_fan_remove(struct platform_device *=
pdev)
>  =20
>   		acpi_fan_delete_attributes(device);
>   	}
> -	sysfs_remove_link(&pdev->dev.kobj, "thermal_cooling");
> -	sysfs_remove_link(&fan->cdev->device.kobj, "device");
>   	thermal_cooling_device_unregister(fan->cdev);
>   }
>  =20
