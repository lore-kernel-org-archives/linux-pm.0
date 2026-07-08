Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC453E5EF8;
	Wed,  8 Jul 2026 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541009; cv=none; b=VMmGhWJaeR8HxwLwFF/iFlnaVUBnhuzyKHM6ll95cN1Pko5WFCHW00MAeg099ySKFBK+2lqpuntGAZZYsBQrgA9EnuxSdJAlrhFkDmrKh8AcYKxFRyDerpz/AXpZrX+iQbx4uiS+AhnqloLPyNzS/PPtMB1ov+r3ckj5johtdns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541009; c=relaxed/simple;
	bh=lQZ1VL5UXQOVqeoMXllH6Ymm1as9ffvgph7H4WgbKVQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiwPM1TNxKh8P7K5C0MLgkfArWQnRi48w6g4qm1bgTAUor5Jd3RONFFDnjGc1C54tXFifzOFrBCdoJt3KTYUzwXN0aU3rLR8V6TrW+Qae2i0QoOItJ1ZNjyObnjhbytVzTPOqBAdsXD+cnbgHzE9sPw21bJpdBXdTvCnY8ZYBOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Oh5n9jkR; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Oh5n9jkR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783540994; x=1784145794; i=w_armin@gmx.de;
	bh=q5X/MRTaHLCbQt+WKq7xq0q6VawSFVGKZP4WU7vKtP0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Oh5n9jkRXdfj1z3Rv5S5BUlztYmMeUqBc0QpQQq4DZMhAFu2ToHU8GQGTC3ua2pd
	 KhYkaetihnCSl2Pyw1MHduLusNYC9lxpkkDE9EP11pcy/1xJDRkSCiBMctEanpoWA
	 T8UnDAp+lM0Q3kjH446iwT8g8nJDFReksxjvkbjRR1sYLboY6h8u3+FUB+iUUuhLn
	 /zBAi1EggxnfcRR3TpY1OlLPEYc4z88CtRgQQPA4X0ISzaH6tDzIq9Tu3zeXVDNgZ
	 Hb5l6GTpVQXMeBWdyIgFoDQml1JxkUOA2/t/2DG83TDKJJcHTLmoYqFXvsUN0wG53
	 selRLi4pEeN5stIs3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0FxV-1x27oT04iV-011yag; Wed, 08
 Jul 2026 22:03:14 +0200
Message-ID: <f035da8c-4de6-4985-9401-1dd74a730dff@gmx.de>
Date: Wed, 8 Jul 2026 22:03:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ACPI: fan: Use devm_acpi_install_notify_handler()
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
References: <2866967.mvXUDI8C0e@rafael.j.wysocki>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <2866967.mvXUDI8C0e@rafael.j.wysocki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7bxARe5lRfNj6OUTN31P+1HFm24nTv5VTK/QfOx7rP/0XjKuzYA
 7++IBxifTjRU2y/7ktGUOQJksOT9IZQZqUjo+ZVyXBUSuz2FssmkEt8GRvLs7NoNyKQImth
 QSyu4mKVLWrw5zPGMzJkgYCejvloS6uFV7qTGQ1Bb/8GVCshGTYm2fd9ls1DRmK31EqdVH4
 OjCBPSn3Lq9FIjlXzNpwA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:p5MZcZVQvPw=;U/l9axy9kp1hCZdUR5VOAcLBRd6
 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

Am 08.07.26 um 20:35 schrieb Rafael J. Wysocki:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Replace the custom open-coded devres-based management of an ACPI notify
> handler with devm_acpi_install_notify_handler().
>
> No intentional functional impact.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>   drivers/acpi/fan_core.c |   25 ++++---------------------
>   1 file changed, 4 insertions(+), 21 deletions(-)
>
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -489,26 +489,6 @@ static void acpi_fan_notify_handler(acpi
>   	}
>   }
>  =20
> -static void acpi_fan_notify_remove(void *data)
> -{
> -	struct acpi_fan *fan =3D data;
> -
> -	acpi_remove_notify_handler(fan->handle, ACPI_DEVICE_NOTIFY, acpi_fan_n=
otify_handler);
> -}
> -
> -static int devm_acpi_fan_notify_init(struct device *dev)
> -{
> -	struct acpi_fan *fan =3D dev_get_drvdata(dev);
> -	acpi_status status;
> -
> -	status =3D acpi_install_notify_handler(fan->handle, ACPI_DEVICE_NOTIFY=
,
> -					     acpi_fan_notify_handler, dev);
> -	if (ACPI_FAILURE(status))
> -		return -EIO;
> -
> -	return devm_add_action_or_reset(dev, acpi_fan_notify_remove, fan);
> -}
> -
>   static int acpi_fan_probe(struct platform_device *pdev)
>   {
>   	int result =3D 0;
> @@ -556,7 +536,10 @@ static int acpi_fan_probe(struct platfor
>   		if (result)
>   			return result;
>  =20
> -		result =3D devm_acpi_fan_notify_init(&pdev->dev);
> +		result =3D devm_acpi_install_notify_handler(&pdev->dev,
> +							  ACPI_DEVICE_NOTIFY,
> +							  acpi_fan_notify_handler,
> +							  &pdev->dev);
>   		if (result)
>   			return result;
>  =20
>
>
>
