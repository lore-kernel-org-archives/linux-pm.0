Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E666136BCD7;
	Fri, 11 Sep 2026 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160569; cv=none; b=tH/5pNe8PGt6ydbtyOKVHjb+ztN+/2krfaRB7eDhKFB6gOJtwnI1iQ8k5gdsD+y4ez8gMf8l9ITeFpZVPX8eqmeV+OpYUrtYg3ae85VW3gL+bxWsGOuMxGrzbYtZtHlwOTakYpAa1JXm38xdCG9gudMGhZqV8hxHfm8MPEpxkQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160569; c=relaxed/simple;
	bh=Ymr8+/fF92UT2ce9OK2oNWvZe487g61atZ8K4aGyUNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W5TXjU3xLGqt+rqt2ZdNTtpwSY0ucd/+3pHRz7K/uR1B4K7KkmH1eoWpQ8e+JIjK2IRyRDjcygw3KEdX9yKmdggoj70YJCESEhx9LzV0MGAj60RMJHXCDCMDD3h2xeO35+1M/W0K5LZeZRziOp/2NnxjdGNVQ7OQU5Pk1BSNcYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=knU2p+D0; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="knU2p+D0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789160565; x=1789765365; i=w_armin@gmx.de;
	bh=HQkGQWmeGpGaLDzmx9YYLLOx8T11gt9MJQNvb2qVFmk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=knU2p+D0fzGTkq4LX4wIqJzLGPhj5tD38XFRbKps4e2TOeoFLCmP8RrF+CfVAMYy
	 rsPsZl3N5GRs+TvdCOra2mmkhC64laeH/vw5Z0m7wU5pU3tuTizrfl2nAkM70TD5P
	 QT5eH1C4RmxAgwm0J2HlH9rrcW0G+m6AjnKi1+zSCJViL9Tu0zXiNigdRprSL93s3
	 bXGtQvkVp1p+Fa04A402VyNXx5EHi1z+aND2VSYwqFuyPJ/4Fbs9BQg8gBhwQb47r
	 +zBINc3PTpzv3B2WPflZVTQwQe+UjUYEqQM6FvCA718vBO4fQnyW92gDUCcFEzB1R
	 Xv2p2B0SoNCtbkjbTw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MqJqD-1wSUB43HEZ-00oDhn; Fri, 11
 Sep 2026 23:02:45 +0200
Message-ID: <e90b4b8a-46e6-4d81-83d7-35d7e2da3114@gmx.de>
Date: Fri, 11 Sep 2026 23:02:45 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 02/10] ACPI: video: Fix backlight unregistration
 ordering
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <3429468.aeNJFYEL58@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3429468.aeNJFYEL58@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:e7kA/mB4wRr3lHr6lWvZQqJqxDQjN+w4SnqSv0+Vkvt9Dp0QR3a
 RinQX0kSfmBamQLpzFERhC0vVje5wq4Z5HaRELkLmVsnITHaNsd3DgunrR3mDLWZ3vQ89eV
 BJkw7h4UWd6ZtfZSSm6SXeOG9j1CUx4aEBFZLk3nnziKSKvcpVXukmuLcrciDRoqYCt91hI
 mvftzxR9m85/4ivuV8dng==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UYo8gQS6qTs=;i68ybwESbcnhnm/h+3mdJRD3+Zl
 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
 qEif6kttce7RO

Am 11.09.26 um 15:01 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> In acpi_video_dev_unregister_backlight(), the sysfs interface of the
> cooling class device may access the brightness object under the
> backlight device's ACPI companion, so that object cannot be freed
> before unregistering the cooling class device.
>
> Adjust the code to take that into account.

Ignoring the broken fixes tag already found by Andy:

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Fixes:
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/acpi_video.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> index 4d6fd9f6e9ad..6cfe390411c1 100644
> --- a/drivers/acpi/acpi_video.c
> +++ b/drivers/acpi/acpi_video.c
> @@ -1825,6 +1825,12 @@ static int acpi_video_bus_register_backlight(stru=
ct acpi_video_bus *video)
>  =20
>   static void acpi_video_dev_unregister_backlight(struct acpi_video_devi=
ce *device)
>   {
> +	if (device->cooling_dev) {
> +		sysfs_remove_link(&device->dev->dev.kobj, "thermal_cooling");
> +		sysfs_remove_link(&device->cooling_dev->device.kobj, "device");
> +		thermal_cooling_device_unregister(device->cooling_dev);
> +		device->cooling_dev =3D NULL;
> +	}
>   	if (device->backlight) {
>   		backlight_device_unregister(device->backlight);
>   		device->backlight =3D NULL;
> @@ -1834,12 +1840,6 @@ static void acpi_video_dev_unregister_backlight(s=
truct acpi_video_device *device
>   		kfree(device->brightness);
>   		device->brightness =3D NULL;
>   	}
> -	if (device->cooling_dev) {
> -		sysfs_remove_link(&device->dev->dev.kobj, "thermal_cooling");
> -		sysfs_remove_link(&device->cooling_dev->device.kobj, "device");
> -		thermal_cooling_device_unregister(device->cooling_dev);
> -		device->cooling_dev =3D NULL;
> -	}
>   }
>  =20
>   static int acpi_video_bus_unregister_backlight(struct acpi_video_bus *=
video)
