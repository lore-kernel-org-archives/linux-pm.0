Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282D2485519;
	Tue,  1 Sep 2026 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284285; cv=none; b=ZBBLwauqKv54h8k3yF9Is4aYaF4x8DdHAeAmwucIcTf+qZeHp+Cpky+5AdsW9cPlmOkLdifLraiCxDVGyS6uQcQTG3/Y/rcDxv+qunRurzh6Qv8n45Pz5av2sy8VKcJQ5WpoCU8E5ivaiZXXrzFC0JXTsu2T3Uf3SHAFsKLPyLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284285; c=relaxed/simple;
	bh=ubf1OxEe06uyzGEC/cOjl7d/Do0ud50R7/4dta55KQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJQRUBydJLrDe3ZTFdV5/ct+V9UhR7ClzgY3OS5LuTvoAvew1gZjvdyXxJBjRfuhzt1mKvsKHN9QfJ/ewUQDEoiGRcpzXwZZ6poHMsFKWcbLjnn53FY32KZnIwilHgBFxfQDRLSbNqgXzsqTgcRTNiIWsWIo51BlZGeoE2gwEOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+fwOVPJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+fwOVPJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EBF1F00A3A;
	Tue,  1 Sep 2026 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284284;
	bh=vCYhuXOz7zaCGF4EZ/ixTSz3zqWOEhxCIlP+os0E6Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+fwOVPJjIfkv1huM/c/4YYoFwB8QR/ecoIX0KUj+FtDKfNQozr+Csva/pvKojs3u
	 voPaS64uTx4t1OArXmd6AcsrWnorunogJwNWw2Qs6U3+ZATGvtIxeg1fA+1Q9Xzny5
	 f+dWW3cYeJbQ/7LuTQ3PNeAG3sW7KUxxnDLw17s9zTOgrEQvfTkKYEUTlc/VcgUCR7
	 oTd+GemTWoxT0fuj7iY73mriMN8G6MZSzHMD4Kjf0KbqmRJkzZCiW2vvG/y8F0tXG8
	 7k/hBITaovOzRXsVoQiOh5jQk3AFpLEBuzdPJBWorWOzU7/YcgJ3p64yQc490YvL75
	 /hAvg428dn/Kw==
Date: Tue, 1 Sep 2026 18:37:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: tmp102: Document TMP113
Message-ID: <20260901-untimely-wake-578b1a86b9fe@spud>
References: <20260901161008.46948-1-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/nSXeNTLuhB53XBA"
Content-Disposition: inline
In-Reply-To: <20260901161008.46948-1-marex@nabladev.com>

--/nSXeNTLuhB53XBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 06:09:20PM +0200, Marek Vasut wrote:
> The TMP113 temperature sensor part is register compatible with TMP102,
> document it using a fallback compatible. Unlike TMP102 and TMP110, the
> TMP113 does have additional unique ID registers, it is up to the driver
> to handle those.
>=20
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> V2: Rebase on current next and resend, resolve a conflict with commit
>     d67ec24d3f07 ("dt-bindings: hwmon: tmp102: move ti,tmp103 out of triv=
ial-devices.yaml")
>     Note that the TMP102,110,113 are backward compatible, therefore the
>     valid compatible strings are:
>     - "ti,tmp110", "ti,tmp102"
>     - "ti,tmp113", "ti,tmp102"
>     - "ti,tmp102"
>     The TMP103 is not backward compatible, it only shares bindings now,
>     therefore the only valid compatible string for the TMP103 should be:
>     - "ti,tmp103"
>     And that is all, no other compatible strings are acceptable here.
> ---
>  .../devicetree/bindings/hwmon/ti,tmp102.yaml          | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Doc=
umentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> index 55d9f106465d7..c0b747a9ce0de 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/hwmon/ti,tmp102.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: TMP102/TMP103/TMP110 temperature sensor
> +title: TMP102/TMP103/TMP110/TMP113 temperature sensor
> =20
>  maintainers:
>    - Krzysztof Kozlowski <krzk@kernel.org>
> @@ -13,11 +13,12 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> +          - enum:
> +              - ti,tmp110
> +              - ti,tmp113
>            - const: ti,tmp102
> -          - const: ti,tmp103
> -          - const: ti,tmp110
> -      - enum:
> -          - ti,tmp102
> +      - const: ti,tmp102
> +      - const: ti,tmp103

Should this not be two patches, one fixing the existing stuff and one
adding the 113?

> =20
>    interrupts:
>      maxItems: 1
> --=20
> 2.53.0
>=20

--/nSXeNTLuhB53XBA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapcNdwAKCRB4tDGHoIJi
0oODAQCVZ0/6ac4473ygypFVJUWZG398AaFYO7YxHbouyDOBuAEA9p76IL/7Tjnn
C8jcrdckOMnfbrFsfsB2dqMCtwJyEAg=
=zi4w
-----END PGP SIGNATURE-----

--/nSXeNTLuhB53XBA--
