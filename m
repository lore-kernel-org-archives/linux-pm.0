Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12C4BA1E4;
	Fri, 11 Sep 2026 21:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789161979; cv=none; b=FRr7SoLY38jrOMGU8jeas+aKc2tgAglQtz+5dkzSV9XrBb4ww3Ma5o9nzRsklGmlYEzCyS+Qb0z9dlNs94AvRXY2UE7qvem8FawdVVk8C3Jamp82+wdg+CUcCs1lPd1NtAcHryM8cmRT+2Iy1WJvx8e5fO3flKZHZ55+J3xvGGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789161979; c=relaxed/simple;
	bh=wgL3MrD6bdFH+UEqPWvucihDxaa8s+4KDhrJqUU3pIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PovT/Oal3081ZBbJZMT1QDhhuQgeXTwuekBtPw9zKdkiQSAIXZQKtkmVrGyWTnjfOhC/tWk763VzAbZkb75ne+/AaTc/CZMqjLzXAk3upSWD++SdxGoS8P3J0N2OUI7/tRRes8eJtzU9iIug2IR1/zbh9iU+iJAalv2YdSja6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gtKZo/FW; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gtKZo/FW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789161969; x=1789766769; i=w_armin@gmx.de;
	bh=35v6LAu/jRWN6vx0RDDZMQjd2RmaP9sVXxC7YgZc6ZU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gtKZo/FWOb6gxRaXeeTJ5FLNtN03OdHueN5FvYVJssrWhHzN2OxuBJ0oxlnI+o2s
	 A30Z0SO1WG8EXuzx0o81+oYqGC8MzN5yHzZjI7AHu7/Mu3cGor18BuGdkxKDNIAMf
	 /gx/fOE0oJfIcGf+OsrlgC6XYByT0fOpE5lFqI5dxwDGSM8PlkuTO3+fG6wseTrNR
	 TbbPvtIhByggvf0UqT5ypzpDQrVj391a9S7KNHhX0iX5Ku1jD/9croPMmrn95k/By
	 D3yES+wKKxjNSvOKMypAWao4m44ZqKqBz/v2Gx+rkUY0guu104tNKzO+aUUnykK4j
	 C8tzhguQ2pbIdaiMZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1xHOfk2EQ1-00Uvhe; Fri, 11
 Sep 2026 23:26:09 +0200
Message-ID: <10085066-c512-405f-a675-bcf1e166a29a@gmx.de>
Date: Fri, 11 Sep 2026 23:26:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/10] ACPI: fan: Use more suitable cooling device data
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <3631084.QJadu78ljV@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <3631084.QJadu78ljV@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rS/S3rY+HLIvlzd1HNdQ9tno1KeLQYywTcfPZ16u5R/O9AZEiy0
 rLxR/SvfNvNiReNmDhKb7Tiw6Ida28LZmYxln3BTjjGseJkTIDytPgrn6lOSdWlJBhOi6H6
 7RkYbc0eOss5xJb4nJv/jtx+cGKLvfqTF+VlBpl7iezD2TaZouMF7fbe9t1BP5DoxzaVl1Q
 0IUwftaJSxU0OqNBm46WQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VdoxG2PsdtI=;HpKz62ZnGfSJo/9iKgU8P/GuYxr
 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
 3iiqpY2yiZZ8mkYVIRXBZ6P9WFQ5vSz0sBA==

Am 11.09.26 um 15:07 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Instead of passing an ACPI device object pointer as devdata to
> thermal_cooling_device_create(), make acpi_fan_probe() pass a pointer
> to struct acpi_fan to it, which allows the callback functions in
> fan_cooling_ops to be simplified.
>
> Also avoid using acpi_driver_data() in two functions invoked by the
> cooling device callbacks by passing struct acpi_fan pointers instead
> of struct acpi_device pointers to them.
>
> No intentional functional impact.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/fan_core.c | 27 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 8b20b8a55c13..5ad65975fbb4 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -54,8 +54,7 @@ MODULE_DEVICE_TABLE(acpi, fan_device_ids);
>   static int fan_get_max_state(struct thermal_cooling_device *cdev, unsi=
gned long
>   			     *state)
>   {
> -	struct acpi_device *device =3D cdev->devdata;
> -	struct acpi_fan *fan =3D acpi_driver_data(device);
> +	struct acpi_fan *fan =3D cdev->devdata;
>  =20
>   	if (fan->acpi4) {
>   		if (fan->fif.fine_grain_ctrl)
> @@ -105,9 +104,9 @@ int acpi_fan_get_fst(acpi_handle handle, struct acpi=
_fan_fst *fst)
>   	return ret;
>   }
>  =20
> -static int fan_get_state_acpi4(struct acpi_device *device, unsigned lon=
g *state)
> +static int fan_get_state_acpi4(struct acpi_fan *fan, unsigned long *sta=
te)
>   {
> -	struct acpi_fan *fan =3D acpi_driver_data(device);
> +	struct acpi_device *device =3D fan->adev;
>   	struct acpi_fan_fst fst;
>   	int status, i;
>  =20
> @@ -159,13 +158,12 @@ static int fan_get_state(struct acpi_device *devic=
e, unsigned long *state)
>   static int fan_get_cur_state(struct thermal_cooling_device *cdev, unsi=
gned long
>   			     *state)
>   {
> -	struct acpi_device *device =3D cdev->devdata;
> -	struct acpi_fan *fan =3D acpi_driver_data(device);
> +	struct acpi_fan *fan =3D cdev->devdata;
>  =20
>   	if (fan->acpi4)
> -		return fan_get_state_acpi4(device, state);
> +		return fan_get_state_acpi4(fan, state);
>   	else
> -		return fan_get_state(device, state);
> +		return fan_get_state(fan->adev, state);
>   }
>  =20
>   static int fan_set_state(struct acpi_device *device, unsigned long sta=
te)
> @@ -177,9 +175,9 @@ static int fan_set_state(struct acpi_device *device,=
 unsigned long state)
>   				     state ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD);
>   }
>  =20
> -static int fan_set_state_acpi4(struct acpi_device *device, unsigned lon=
g state)
> +static int fan_set_state_acpi4(struct acpi_fan *fan, unsigned long stat=
e)
>   {
> -	struct acpi_fan *fan =3D acpi_driver_data(device);
> +	struct acpi_device *device =3D fan->adev;
>   	acpi_status status;
>   	u64 value =3D state;
>   	int max_state;
> @@ -213,13 +211,12 @@ static int fan_set_state_acpi4(struct acpi_device =
*device, unsigned long state)
>   static int
>   fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long s=
tate)
>   {
> -	struct acpi_device *device =3D cdev->devdata;
> -	struct acpi_fan *fan =3D acpi_driver_data(device);
> +	struct acpi_fan *fan =3D cdev->devdata;
>  =20
>   	if (fan->acpi4)
> -		return fan_set_state_acpi4(device, state);
> +		return fan_set_state_acpi4(fan, state);
>   	else
> -		return fan_set_state(device, state);
> +		return fan_set_state(fan->adev, state);
>   }
>  =20
>   static const struct thermal_cooling_device_ops fan_cooling_ops =3D {
> @@ -565,7 +562,7 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   	else
>   		name =3D acpi_device_bid(device);
>  =20
> -	cdev =3D thermal_cooling_device_create(&pdev->dev, name, device, &fan_=
cooling_ops);
> +	cdev =3D thermal_cooling_device_create(&pdev->dev, name, fan, &fan_coo=
ling_ops);
>   	if (IS_ERR(cdev)) {
>   		result =3D PTR_ERR(cdev);
>   		goto err_end;
