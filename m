Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA03E5A1E
	for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 14:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064483; cv=none; b=fb7QpqUHjmymW8KSZDlEPHwnmkMDKC+uhBiDtq10oSrGJuwP+A55cWFJ8AUnfSNy2A4hXuP229KMAkYv2CVO3nhY/XxUARyz0pgc6JWYWt3t4O/0fHMfDyVymvOn08/UU9+cWDLu/zOH3IvT/l65N+flWpkRUXSNmV9Y3hLB1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064483; c=relaxed/simple;
	bh=hESVbJACyblaJlrUMY1eyLPKjg7CBrGuIX3Otmap2vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKNjk1HBbzSV1uS7fx7p43FP/7od4UlxJPXnkchDzKvnkofoHyuGg7vyjmGLB27CG0aqJpqCgjHAFXhkW2h6ROz4fwTPhuW5Lysv/mfAp2ygO2FGIsZL/3eDO63hqE2lkPjQvGp6iqRkdzQ6cvPqmc43BWw6z4uxghHEVJr0pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TpUyCmu2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TpUyCmu2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso50604255e9.1
        for <linux-pm@vger.kernel.org>; Fri, 29 May 2026 07:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780064479; x=1780669279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k3f1+tMQGwLXzsSYabzCfoVFpvrrhjPGWm1QbdMP034=;
        b=TpUyCmu2c8OpiKNElvkzy3vW9G2zLbmnCPYw6mZAqaSqMHWO42PJYTMgBOlNEKRv58
         +4WcdRPq35FLAqHRVg9XRPnZciHmttVaTQTwNrfKns97zAwjtEPnhRcPbCYAuxOJWIrV
         4eNaHJUvKKbvaHyE/WmIxnBhRFCqujuD9wenIvn+9G++biAj2xEMQ1ba7J6JFDD9uolO
         5EakEbUZuo+mqLoatmc5hQAUTucwl6Xdq7ConQwUI8R0M1NiGoSrr6hAgBlM/9GAk0wX
         +Dot4zrwmSluta1INsi/wEHIqDaDSx/5UKXuSgrLYESQxGoAZDhN/07CLLa629880F9A
         GVgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780064479; x=1780669279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3f1+tMQGwLXzsSYabzCfoVFpvrrhjPGWm1QbdMP034=;
        b=HqlluPBzk0XsoDlW3wk3bDueFJaGB47YYtECjmi778FZdQYyuxQJCgbqm5AjCCh+cv
         iNEoYcIJJoViLJYIcoNSKUeU0c00mdvpybiBhGg+3YBmG9itKyXulBW/l9RFhrVOzmRw
         6Nf9bazw/a1l5F1nJmSr03e54/wg9ob8jSFQkpmNKB7X5w49JCLVByeCiXmKpFqHwJCs
         KzwCljZV6UrxInOMu9/HXTg4JRv1oxqnESR3XXZrcvrxBMO58Lhulau7v/KlffJWj0xc
         Nn96NO293//bpoLiXVls/6x7P7Bys7kKhGlOfBZ23ReWqU+Q8WJP32/EPyGqwfSOIUvi
         c+0g==
X-Forwarded-Encrypted: i=1; AFNElJ9/m1CYPzjsXOKBrfQQPjtPnboXivzEDTxnkxSsEslkRiRvQG12l1OlpNUzxuXlYhTPWykYGvqesQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwLmCjrqOeWFw0u4w4Qjthrk5tiJXjsJkzfdJqZ0yjy1pc6Z6y3
	9Dt5nRRqBBdI8U8t2n7eUOgTsFApPAfNgG4psxe0tvm9R7DXnC3swST6Tdlx2wy8g/M=
X-Gm-Gg: Acq92OES3bXobFUecw6MxXWt8QPXLH36ylBmHVQ8Yoki4t6ni47Nxev2EVz1WCFQovz
	q3UyM3KOzlwUg4Pg9kZVOQkTnWHCen/Bph+Xtnbmx64gS1dPm3BsIV1dq1KXbpnm6S5ToZwgp6q
	Aux/220Vh2VIw5BdSnWG59O4P3quKn0jRZSFosjJw/oA4+3IkXqxVBiSSkpYZX6hniEnG5FhCgQ
	kHNIyVGWnZVlqMSNLavZMd8mM3BUE4s+AaByQCIrmkNgmKZbCVwaw7hsXYnT3db2ZJrLAtKPTIQ
	L7O0TyKiXS9cs+PStTsiEFgct7NI2aZie/dpd5o6DHW2++8MOWy27+axz217Ef6JH+62yqbKYYP
	eZsKP72vRXwQlYMUU3ClR1PaEaonESUx2DogHw5JotQZOXSfaaaqhRO9Qjvb7wogMjLMftxjiLX
	8lD2F/c4YtD3fuubSetBXakWcB28dwm93HyRvwyrTdcuc0GhwdwgmE9AZ2NnuCZthKmP+Irh3Rn
	j7KmtTzAxO586TabT9EKtL53g==
X-Received: by 2002:a05:600c:4504:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-4909c0b33fcmr56687305e9.19.1780064479241;
        Fri, 29 May 2026 07:21:19 -0700 (PDT)
Received: from localhost (p200300f65f47db04848b3ff9767d897c.dip0.t-ipconnect.de. [2003:f6:5f47:db04:848b:3ff9:767d:897c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4909c0ec5f8sm22350115e9.3.2026.05.29.07.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 07:21:18 -0700 (PDT)
Date: Fri, 29 May 2026 16:21:17 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: Hans de Goede <hansg@kernel.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, 
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/6] power: supply: max17042: Drop driver data in of
 and platform device id arrays
Message-ID: <ahmf5Ii22AAktbcW@monoceros>
References: <cover.1780048925.git.u.kleine-koenig@baylibre.com>
 <c4703f00d5a4d1debe51f1ce82afa11d2fdf04e0.1780048925.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="edex4f2r2m32r46h"
Content-Disposition: inline
In-Reply-To: <c4703f00d5a4d1debe51f1ce82afa11d2fdf04e0.1780048925.git.u.kleine-koenig@baylibre.com>


--edex4f2r2m32r46h
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 3/6] power: supply: max17042: Drop driver data in of
 and platform device id arrays
MIME-Version: 1.0

On Fri, May 29, 2026 at 12:18:18PM +0200, Uwe Kleine-K=F6nig (The Capable H=
ub) wrote:
> These values are not used, the relevant distinction happens in the mfd
> parent driver. So they can be dropped.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig (The Capable Hub) <u.kleine-koenig@bayl=
ibre.com>
> ---
>  drivers/power/supply/max17042_battery.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supp=
ly/max17042_battery.c
> index 167fb3fb3732..3c50f5ba0591 100644
> --- a/drivers/power/supply/max17042_battery.c
> +++ b/drivers/power/supply/max17042_battery.c
> @@ -1298,7 +1298,7 @@ static SIMPLE_DEV_PM_OPS(max17042_pm_ops, max17042_=
suspend,
> =20
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id max17042_acpi_match[] =3D {
> -	{ "MAX17047", MAXIM_DEVICE_TYPE_MAX17047 },
> +	{ "MAX17047" },

This part is wrong. I missed that max17042_acpi_match is also used for
the i2c driver where the data is queried. Thanks to sashiko[1] for
noticing.

So please don't apply this patch.

As of now I assume the other patches are fine. I will check which parts
of the series didn't make it into next and/or the mainline later,
probably around the next merge window and resend accordingly.

Thanks
Uwe

[1] https://sashiko.dev/#/patchset/cover.1780048925.git.u.kleine-koenig%40b=
aylibre.com

--edex4f2r2m32r46h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoZoNMACgkQj4D7WH0S
/k6eVggAmj6P8YdZ2stqouXBwpDjZTOYSJJSRqcCak5ha6YQXcppg9kz4rkh0pU4
cEYbzJCnnH26Ucpuc1DWPcBqUIhRMn7kw+7NIqsuEmt/YL0LJv5yvSFHX+VmTBdY
/inH6fgyuyUIP9Xl+RFO41QouaK31zDDBcvRtdth4Qx/PIx23S2cks2+zF+sAI3A
ZJB8cqs2Mn3TTe7zcRybz+AKOqsN2wsC34dW/awsW/+VJYjnqRWhkIa6G5g/X5Nc
2zH/sJ8WZgPRY1eWQOCEibUo60Z0yA2qL2of5vQgZnsKBu1KzIyzTj18ufqBUGiV
Y2tVhzrTlvtoKcR+S2HCOSmCru05wQ==
=ZSMC
-----END PGP SIGNATURE-----

--edex4f2r2m32r46h--
