Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB69416871;
	Thu, 24 Sep 2026 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270694; cv=none; b=jRFyrylIBKJybjYlFAAxmEX4F58u9jAHIb10RZJn6NK8gyeIKxpTJenmXejDkuwwgAjlS4/UHiaFuBnfJJOkr/wCbWFoBr2qOymbgUbqHJ1wOkxwUF1lwyxKeWcd/UfcJPOfXS9/VcoxMeHbH6kd72gMfOaLyMM484jP65xA4+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270694; c=relaxed/simple;
	bh=IOWa3Zy6/h4l8mN+8DIj4HUEcITPYhdd+jN76DZq/es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BUkk67baO3Ayioz1Ox+b/Hh9zp4EIu1UIUC3qNOUXP+ce+q/1v70ILw3fRw0Y6Jjvyc0efKwVHD/O35KfVw4qwe2zVDXEypi2p6vJq93sI9yjcbY34qbaQYv9Vr5zTlMPrm8BRn03JZJ+ZajULts2zP5nW/pMJp6KxXOF7av1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7wqFNgd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7wqFNgd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D031F000FF;
	Thu, 24 Sep 2026 17:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790270692;
	bh=iXdfBzIG23WVnYOZ3J6MBdTWX4EJD1WXr/slVqBDt9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E7wqFNgd8F4+MRXK4pqj23sfJnWtO73Gt1zxOuURqOGPwF/zbvsa0CW3+JzizMX/Q
	 A5vdZGwJkfBbNdxtFcBgPmSDzCfTpbaX8xy5YiWfsXAE4LYQvG7iq0tXJGmx76BnDe
	 Mb8x3l2rTinuU9kquyM9HnSMtGvabtNES5c0vug6Wh6NaL7Lnr1R9p16/DTK5yyNZE
	 h4vc1U+/oBVxAku3YPZ95DsBl1dNybmxwqXmiHQS5VaYLHXJbMkvRN2ywcL3mYX3VP
	 0vh3NIwK8zJFhuXgJTIJroviqvfbiW8zZumLP5EP+3ao+dWmWOO9oRwKtbMqJdwgJw
	 TJEqRiNr2X9AA==
Date: Thu, 24 Sep 2026 18:24:48 +0100
From: Conor Dooley <conor@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Grimler <henrik.grimler@axis.com>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: power: supply: battery: allow 101
 ocv-capacity points
Message-ID: <20260924-reaffirm-mop-49234cf37e9a@spud>
References: <20260923-rbrue-suez-upstreaming-battery-ocv-table-128-v2-1-b827406d768d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MASWJ+kKZJOO4rBH"
Content-Disposition: inline
In-Reply-To: <20260923-rbrue-suez-upstreaming-battery-ocv-table-128-v2-1-b827406d768d@gmail.com>

--MASWJ+kKZJOO4rBH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:15:35PM -0500, Ryan Brue wrote:
> ocv-capacity-table-N is capped at 100 points, while the capacity percent
> in each point may be anything from 0 to 100. A table with a point for
> every percent, both ends included, needs 101 and does not fit. Raise the
> cap to 101.
>=20
> power_supply_get_battery_info() sizes each table from the property, so
> no kernel change is needed.
>=20
> Assisted-by: LLM

Crazy what people seem to need LLMs to help with.
Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> ---
> As discussed with Henrik on v1: rather than a larger cap for one vendor's
> tables, which fit in 100 points once resampled, allow the one extra point
> that a table at every percent from 0 to 100 needs, and say so in the
> binding.
> ---
> Changes in v2:
> - Raise the cap to 101 instead of 128, with a comment saying why (Henrik)
> - Drop the justification from the vendor's tables; the figures in v1
>   were for a different cell, and resampled tables fit in 100 points
> - Rebase on v7.3-rc4
> - Link to v1: https://patch.msgid.link/20260918-rbrue-suez-upstreaming-ba=
ttery-ocv-table-128-v1-1-f477ef39ef0d@gmail.com
> ---
>  Documentation/devicetree/bindings/power/supply/battery.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/battery.yaml =
b/Documentation/devicetree/bindings/power/supply/battery.yaml
> index 8ebf05d9497c..9575ee1491bb 100644
> --- a/Documentation/devicetree/bindings/power/supply/battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/battery.yaml
> @@ -154,7 +154,8 @@ patternProperties:
>        of the battery and corresponding battery capacity percent, which i=
s used
>        to look up battery capacity according to current OCV value. And th=
e open
>        circuit voltage unit is microvolt.
> -    maxItems: 100
> +    # One point for each capacity percent from 0 to 100
> +    maxItems: 101
>      items:
>        items:
>          - description: open circuit voltage (OCV) in microvolts
>=20
> ---
> base-commit: 93f51579e7df248780214094418f205253383cc5
> change-id: 20260917-rbrue-suez-upstreaming-battery-ocv-table-128-9ba83f93=
13bb
>=20
> Best regards,
> -- =20
> Ryan Brue <ryanbrue.dev@gmail.com>
>=20

--MASWJ+kKZJOO4rBH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarVc4AAKCRB4tDGHoIJi
0jZJAP4gtTTsKAbT0TVfl/1PezdiTG14pgjRZpv3bc0Xl1rUJQD+KM2NCz0+CTUH
/0p4//2D6RNKcnQAYFKJb6nNb4If8QA=
=0BBA
-----END PGP SIGNATURE-----

--MASWJ+kKZJOO4rBH--
