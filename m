Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B0346E70;
	Fri, 11 Sep 2026 21:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160496; cv=none; b=niWSGma3zkjWAQaN0jn5INfZtxTAhHkt3D1ib2Hmb97JFOX5zUGiyezklViA4JKELarbQvBN8QojkdFHPqu/VuAd/Krz+nk1pjWimYP4kyfw9ahXXiFXuZ+AV8gK+ZvOX5gLDCj9Y+V052UlkFSKfRSS/dqRiO3DfNN74/ddTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160496; c=relaxed/simple;
	bh=wXkaaTxAPz6NjC6EldseN4H58jlV00ztxvu0OGAzYuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hT0g4VvTs06tjRXIhM+bnysrKD7ErUNe8e9uu08QfkUHKIVmhc9XRJgu+p4z4eTEQdPFnzUi7Q0U5VHNTR4zZWYdF25H0rDU0/btajp2s1VeI6z3B6/QmC25j7SLXjgDu5bOOD/ezS/UUI6L7zynfd6xIbMtahRsAHFRCOrUqdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=JCuIavzY; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="JCuIavzY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789160487; x=1789765287; i=w_armin@gmx.de;
	bh=BAfcP5PUJFui3JMXOMKjR4qbRLsKE02XtJJxZRjxvTg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=JCuIavzYVvGKseFKRyl36aj7xSUxu1RT6wHziPFmXoiGL8VpN2nhJ1bM3/vHVXCh
	 UoMXqbXrwhInF8/prtY7qk1HJ9ML3qGClcDRDJuroWuka9EWDbO9r89l+KbRHeTNh
	 +eBXD/n7e7oxhUX/IvDHnhiMuLa/zp0RbssfMFyDBB/awSF4fa3jJuMxsoTKZgpfA
	 4c2OwQRBH9/+54tzLDCeG/YdnZZEjzLy8v8RrD0osHwQyWpoH8bK9aqTQMt7Ezome
	 xjzZaBJtP90Ns0Zouad6oNM/iuGECy8nT/nBXAuZ1nQ9VXMMtRvpv1JJex6Ld6EJ6
	 XRu+ZfOz+m6S2+u8wA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M6UZv-1xC1CY1rDd-004kM5; Fri, 11
 Sep 2026 23:01:27 +0200
Message-ID: <17f7af67-7d8f-467f-bab4-46d6624459ee@gmx.de>
Date: Fri, 11 Sep 2026 23:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/10] ACPI: fan: Fix memory leak due to leftover
 devm_kcalloc() argument
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <1965933.tdWV9SEqCh@rafael.j.wysocki>
 <14089663.uLZWGnKmhe@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <14089663.uLZWGnKmhe@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eEyZ4d8IqsuQRDRKjBG8ZqfkmLBW99yCkpnQW2CmtsYrtR8G5T0
 BFNPqsQGfo79SBRgb7kHF67IQ0c3p/thh26JQi1eBWiBhacRU8DKT+K4PVuC89aLKti8YYL
 TF2dgRWsXKYeinGMvstItwhrec5CW0ywfa8zRFHamR3F3kVscF9gISwNQuXxINjuATYIrPx
 fIctpg6kDTt1hM4rBshVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qTUnYmol0sI=;oEy9DAJzb5SmlcE5yXFBnYlxp19
 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

Am 11.09.26 um 15:00 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> An ACPI device object's dev field in passed as the first argument to
> devm_kcalloc() in acpi_fan_get_fps() which is incorrect and leads to
> a memory leak on driver probe errors and removal because the driver
> is not bound to that ACPI device.
>
> Address this by replacing that pointer with a pointer to the device the
> driver is actually bound to.
>
> While at it, drop a redundant error message after a memory allocation
> failure (that also gets printed relative to the ACPI device).

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Fixes: d91a1d129b63 ("ACPI: fan: Use platform device for devres-related =
actions")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/fan_core.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 624d0736b581..a31d7beca5d0 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -284,7 +284,7 @@ static int acpi_fan_speed_cmp(const void *a, const v=
oid *b)
>   	return fps1->speed - fps2->speed;
>   }
>  =20
> -static int acpi_fan_get_fps(struct acpi_device *device)
> +static int acpi_fan_get_fps(struct device *dev, struct acpi_device *dev=
ice)
>   {
>   	struct acpi_fan *fan =3D acpi_driver_data(device);
>   	struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> @@ -304,11 +304,8 @@ static int acpi_fan_get_fps(struct acpi_device *dev=
ice)
>   	}
>  =20
>   	fan->fps_count =3D obj->package.count - 1; /* minus revision field */
> -	fan->fps =3D devm_kcalloc(&device->dev,
> -				fan->fps_count, sizeof(struct acpi_fan_fps),
> -				GFP_KERNEL);
> +	fan->fps =3D devm_kcalloc(dev, fan->fps_count, sizeof(*fan->fps), GFP_=
KERNEL);
>   	if (!fan->fps) {
> -		dev_err(&device->dev, "Not enough memory\n");
>   		status =3D -ENOMEM;
>   		goto err;
>   	}
> @@ -522,7 +519,7 @@ static int acpi_fan_probe(struct platform_device *pd=
ev)
>   		if (result)
>   			return result;
>  =20
> -		result =3D acpi_fan_get_fps(device);
> +		result =3D acpi_fan_get_fps(&pdev->dev, device);
>   		if (result)
>   			return result;
>   	}
