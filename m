Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6E1FB1;
	Mon, 20 Apr 2026 16:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702171; cv=none; b=jnIXgxuSkwwNjczuGpq3qAp62MBMbIqta21V3wiVFDAiEqyfYoVDAYr+YsFKw2/b8syZTswaCP/gfMPsk12G7N5Q4lydBkeBmKAWXWBj/t7TqZtC+W8Wzb1dIHC55V7/x1P1fJ4BUlj/DbPfVYSAOF0E58FqcSEbaViyEe9TjfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702171; c=relaxed/simple;
	bh=YEdo/V0QTAr+NW2dlqYidtGFQZDQxJkbLKbUxoyQ7yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0qKrWSMhNNqWnJzk5CRJb/XmWW+dGnqeykOZguqyU7663ZhP1KmjF3/KZhG11N7aheE1Z79r2wsZmmwfOMFPaKaKoFIzIsfvpUUV4qJluBZVkluTehpQUbZwwhYK9RC3+E0/SuoqU1fWShW613WM4QUycY7UWmWRWlOCom/kt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxTKj7Pl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxTKj7Pl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2870EC19425;
	Mon, 20 Apr 2026 16:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776702171;
	bh=YEdo/V0QTAr+NW2dlqYidtGFQZDQxJkbLKbUxoyQ7yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxTKj7PlWluEqHuKTzEen462dAfrv0zZY9/iW/KTchxzdbie0xAcn49tOEIN3vpM5
	 aGzG0ZJn1mUsntJEkhTrtI3/I5Dz7AvBultI6l5O9IapBABCmY+15Cnw7cVQIQjn2B
	 uA9xZr93tge3LmcQ+Dz/swtlU+pjx44PshwqpOyyyHC8qWN1NSXlRQXv54p58pOwlZ
	 1hAXJgHCOBRBt921Q/hIosqWUL1VxjxxrAyohHXLmZ9/EP8WAd3oFDvfXgyWo/AgJ8
	 hhjg/J1tsBpcEJeSnJfk97FV7kmABYjkdDcVFhmJ1OEGlYpXuP2DYoKnfJkEnwiqjq
	 nSpyLSq0InXRw==
Date: Mon, 20 Apr 2026 17:22:44 +0100
From: Conor Dooley <conor@kernel.org>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Beniamino Galvani <b.galvani@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: mfd: khadas: Add new compatible for
 Khadas VIM4 MCU
Message-ID: <20260420-viable-plot-862e0c545837@spud>
References: <20260417-add-mcu-fan-khadas-vim4-v3-0-a6a7f570b11b@aliel.fr>
 <20260417-add-mcu-fan-khadas-vim4-v3-1-a6a7f570b11b@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EN5NAUw4RNBry5U5"
Content-Disposition: inline
In-Reply-To: <20260417-add-mcu-fan-khadas-vim4-v3-1-a6a7f570b11b@aliel.fr>


--EN5NAUw4RNBry5U5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 06:27:17PM +0200, Ronald Claveau wrote:
> The Khadas VIM4 MCU register is slightly different
> from previous boards' MCU.
> This board also features a switchable power source for its fan.
>=20
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  Documentation/devicetree/bindings/mfd/khadas,mcu.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml b/Docu=
mentation/devicetree/bindings/mfd/khadas,mcu.yaml
> index 084960fd5a1fd..a80718f7595ce 100644
> --- a/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> +++ b/Documentation/devicetree/bindings/mfd/khadas,mcu.yaml
> @@ -18,6 +18,7 @@ properties:
>    compatible:
>      enum:
>        - khadas,mcu # MCU revision is discoverable
> +      - khadas,vim4-mcu # Different MCU variant, not discoverable
> =20
>    "#cooling-cells": # Only needed for boards having FAN control feature
>      const: 2
> @@ -25,6 +26,10 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  fan-supply:
> +    description: Phandle to the regulator that powers the fan.
> +    $ref: /schemas/types.yaml#/definitions/phandle

Can you limit this by compatible please?
pw-bot: changes-requested

> +
>  required:
>    - compatible
>    - reg
>=20
> --=20
> 2.49.0
>=20

--EN5NAUw4RNBry5U5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeZS1AAKCRB4tDGHoIJi
0rq6AQCyNe1h3KXPOtFS9t3ntlaZUO80Ck84GL+I6mmU6358DQEA0hx/x6pQ5aO7
RXk37eL/R10YB9DDqs+wJN/2TnZoxgw=
=ak6Z
-----END PGP SIGNATURE-----

--EN5NAUw4RNBry5U5--
