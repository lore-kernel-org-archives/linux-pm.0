Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BF38CFED
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784787920; cv=none; b=GiX855Tw1U240QdAsTebdWDqv9d5tlc/Fu1VxsDYmSIWSb4Q7dY6gGDMUuyZEc3LN+zI7iX7xUx83WX6RqZ11+Yjm3nNefMvZojNdCd6NQ9+V4EBHAz1Km/U3vvmxrIqfZN8Is7TjqsK2FVpP+WNM43b050L7gKPOoQmR5CwBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784787920; c=relaxed/simple;
	bh=lR4BrEKUWwFUgV5r/hY0SmpZYAvqTCmveLJxkUYJjco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFhnuFNIcQ+X/l1io9GbTIYfjChJUoYyMh3D7iXHz72OBhHBhTA3y/5X6/ja+fjwl3JBfFRGNEE8i7HMC3A8W5VX0yuYu81UOZcio1DsvR1cW6Ol4ENY7CrtqsjW+ul3U2jc7y+gIaPiIjPUWXS6EpzqUn8qnbCjgVi71MjWQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=EbSO3bwx; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="EbSO3bwx"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f7854678bso59857f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 23:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784787915; x=1785392715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rY35TAUlD5S7ktpUnfbUq2XEBmoTSaPuxjiwa+138dw=;
        b=EbSO3bwxvI+2nmAxICX4zeRqbAsg2kMl/e2dR3cbMAVLVsPoeguIg8TtU6k8y2Qo+T
         mdPhKrw1sNBlySFpfgpqejlNKxtnoDAhfzr61hfvB0mFc/wkNCAnloURPSxM1eI0/gB6
         N2mnyIlcBRVejMB87U/beyiogkWg8LbHcRvRjGUBJOd63kjTToRqnhatqpDx6KJpwZkW
         bv/1wY9kKqvFarDvo+pHhuntl5RAC7nIinKoHMIr35dz4Lb7R9PB16yIW82Fa0EX6KXf
         mBDf34RABR6x0W0KbcSIS5EhrEVONSXArH7mYZghNodTmvxAH34fUT4ROLPdQot417Xm
         ukMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784787915; x=1785392715;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rY35TAUlD5S7ktpUnfbUq2XEBmoTSaPuxjiwa+138dw=;
        b=ZRQO6UUS1R28DgksxEQ9whcEFLBp6LhbnTKA74i//s3o9W2D8NFnvfgYPpMf9DDEH0
         5/+hLQA3IQawqDCry7R7JIBZuIM+MfXSBybeN4xn1nVNuZOJV9whcSmTpnjnXQNUM90u
         jSCuhqDU6oHyKKMHIBUhZxh5rIslUTjtqh7Tsn2+qB6MGW0pneF70bH/oxaWiz4qhyqU
         PsG//OckNrTwLw9+hU4cLQSDpKEghLqMnDaDbe5qaDGH+qonH735AYnDnFQqB4JQ14Wj
         jce6S4WkXY5QUsWiCYArl7Fw3SEagHa2VEOgLGcMUv9X/67WLyBVV/o0UElheb4WgXIT
         y4Vg==
X-Forwarded-Encrypted: i=1; AHgh+Rox0OvAm0iMFAgfZOspca8naqhLGN8Mny67sPBm7nBxSFDtBsgDgQ39ALABMM7tI/hB7fTUdbo60Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvHWgIXoHy6zQp4IIe2yFDUpe1upgAIFpXBtNvK/furoAIOrJ
	XWJD+fqm5GBK6M3j4SXKbfvznAr//MKAYiinvqdFiyABMMp/YT0PgDdZjT6gQtFsMZ8=
X-Gm-Gg: AR+sD10xJefilC9Yrq9J4xxcYhARsHv99ivtY5GpftidG7ouNobXmetegfVdPddmsVR
	N+o1g8k9lF6l78r/vfj1gAwHH7s+xp8rXViZyeyKGUUTTXXdWD9Q4U3w9W/y0VIYkYN9lhWBJTE
	/icL8DeSn1UH1mhaBFAPNOmF4yMfsknE5Ue0T181dqtwuKwYQAj/vLCjnYfQDjl2bWLPrDd1Crn
	o8H0dLwrRXcKQN92TWxQ7NcJsZxzODzsm4e82U3uMvGBtOeKHz+whm1qWuaGBXtwxyX+VjIpTLu
	PcqWBgM3I2TcED2KwbCY6icO6oAyvRqLbs/HH9bGBxJaRdW6hhdPsSmy7MkvTW3qjIhr4lvJGQS
	JUuhICzQA+3AbTcfeJzy12UVqfDmwhMoZ2hCbIZtmmGI0h81Ni77+gjXo3rET6hBggJfwtuRrAq
	62JaEWNOQ0al0IHAAFtA==
X-Received: by 2002:a05:6000:46db:b0:47f:91e3:3cbf with SMTP id ffacd0b85a97d-47f91e33d93mr526287f8f.19.1784787915407;
        Wed, 22 Jul 2026 23:25:15 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-47f85c6f076sm12633187f8f.34.2026.07.22.23.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:25:14 -0700 (PDT)
Date: Thu, 23 Jul 2026 08:25:13 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Ion Agorria <ion@agorria.com>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
Message-ID: <amGx2fJCUB4_XW1M@monoceros>
References: <20260721095233.420823-1-clamor95@gmail.com>
 <20260721095233.420823-3-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hohtbe7p7bme7m4a"
Content-Disposition: inline
In-Reply-To: <20260721095233.420823-3-clamor95@gmail.com>


--hohtbe7p7bme7m4a
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v10 2/7] mfd: Add driver for ASUS Transformer embedded
 controller
MIME-Version: 1.0

Hello,

On Tue, Jul 21, 2026 at 12:52:28PM +0300, Svyatoslav Ryhel wrote:
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>=20
> Support Nuvoton NPCE795-based ECs as used in Asus Transformer TF201,
> TF300T, TF300TG, TF300TL and TF700T pad and dock, as well as TF101 dock
> and TF600T, P1801-T and TF701T pad. This is a glue driver handling
> detection and common operations for EC's functions.
>=20
> Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Documentation/process/submitting-patches.rst has:

	[...] the ordering of Signed-off-by: tags should reflect the
	chronological history of the patch insofar as possible [...]

So your S-o-b should be last when you submit a patch.

> +#include <linux/i2c.h>
> [...]
> +#include <linux/mod_devicetable.h>

<linux/mod_devicetable.h> will go away soon. Please rely on
<linux/i2c.h> to provide a definition of struct of_device_id and drop
the #include of mod_devicetable.h.

> +static const struct of_device_id asus_ec_match[] =3D {
> +	{
> +		.compatible =3D "asus,sl101-ec-dock",
> +		.data =3D &asus_ec_sl101_dock_data
> +	}, {
> +		.compatible =3D "asus,tf101-ec-dock",
> +		.data =3D &asus_ec_tf101_dock_data
> +	}, {
> +		.compatible =3D "asus,tf201-ec-pad",
> +		.data =3D &asus_ec_tf201_pad_data
> +	}, {
> +		.compatible =3D "asus,tf600t-ec-pad",
> +		.data =3D &asus_ec_tf600t_pad_data
> +	},
> +	{ /* sentinel */ }
> +};

Trailing comma after the assignments to .data please.

Best regards
Uwe

--hohtbe7p7bme7m4a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmphs8YACgkQj4D7WH0S
/k5hUggAntVLl+JSiaF4SxkXV/Dfehd2NCWtfs+cUwmB6WJFteJP+BcAhhOkk+1E
ttUWLQylbkdzFp3xbddXPZWpS5IFjn4vqMbpPOZvtx/sWiA+m4vBqFCozSGwu8/F
9UNUZa3I0cptOeMgAnAVDApboD4tQ3pZlKAF31EzAJnDEz9mFj+5IgedjpVENEeN
5bDcmqTS8xRqlkYuBDphF6wxnp1epbtkJ7knefFwNEqHz/B4ZQc1gtAWgJyIMklZ
fasfEq+2cwMArlqDN/bb6iJTIXh9QxBHHuVUqCCHuI4QgEI+QijDdeXmUN56PebB
UR+136xjTmkYxJ2dIDxPAY7dj/DVaw==
=58oj
-----END PGP SIGNATURE-----

--hohtbe7p7bme7m4a--
