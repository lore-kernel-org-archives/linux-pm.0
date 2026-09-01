Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0630568B;
	Tue,  1 Sep 2026 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285808; cv=none; b=RekcCAcHrdMz5fmidrE/UFU3JkCRcihxBsZPPkarFdpdGIbdUuPXHv9S+Wu8j6X4h+dr38cwCL13kXeepEUfsP+AmpEbcjyl940eLbXLfL2P2CHEGdAhW2lKgVfWtk83vub5u6ho8hJwlhwnA9yXatP+BKNJjEO612A8dTZYFSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285808; c=relaxed/simple;
	bh=R7e/IBn/MoL7lJe8oghnQL7wF76YSxVCRI13UyomvrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXLd0m+e1LJ27qnqbgA5w2wmxn64dwsv/dfaknHCDkSvku2D1PlOgn6d47ss2WMTun/XgYCD0eyDltUSOkUMyjCrNwnyvlt5U/dHZPiGhywf5Bujlb4NU9RwHAZkJEScnByD6p1gBfw/GFpJbjy/2kf+wKE+AWmVredf5rNEIy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hI/M9o0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hI/M9o0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5556A1F000E9;
	Tue,  1 Sep 2026 18:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285807;
	bh=BGdCke1gdYZmTRvdYBv/QrBVWXwaeGTEuvRYhdWqqhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hI/M9o0eT3znCKapplcHQPyRupL1CutSB0e1nb43UNKTAvdu/h24P3BD1fQb83qIP
	 AXFao1DYsHNJ6t7VeICwnHvrfqOlim1p6C2WoYPDLJ9akg5lkluyv3VXv/QsbYYpbT
	 OhQHL1vTwoi1fB5jJrwojHPPU0iIgMUiMwMISW/YCYui/L4M+pwrityttjq1tHi/Qt
	 knUATiKrfabBuWluMFa3SoFc2+gZqojdq+HtclK2g/Bm0e8Z2NF/IK4EU3FbUeNtwa
	 ik2ASsC8GW1Q01DxQrKdPbLvGF1zAExh67DVPYdtGS/oJGUbBnb0S73sI0v/w7pcfi
	 8bCO+7ofwi4Cg==
Date: Tue, 1 Sep 2026 19:03:23 +0100
From: Conor Dooley <conor@kernel.org>
To: Marek Vasut <marex@nabladev.com>
Cc: linux-pm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	Flaviu Nistor <flaviu.nistor@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: hwmon: tmp102: Document TMP113
Message-ID: <20260901-cover-tissue-96ce1e29736f@spud>
References: <20260901174847.97261-1-marex@nabladev.com>
 <20260901174847.97261-2-marex@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HXcYKxFLGrnoCBeY"
Content-Disposition: inline
In-Reply-To: <20260901174847.97261-2-marex@nabladev.com>

--HXcYKxFLGrnoCBeY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 07:47:55PM +0200, Marek Vasut wrote:
> The TMP113 temperature sensor part is register compatible with TMP102,
> document it using a fallback compatible. Unlike TMP102 and TMP110, the
> TMP113 does have additional unique ID registers, it is up to the driver
> to handle those.
>=20
> Signed-off-by: Marek Vasut <marex@nabladev.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

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
> V3: Rebase on top of 1/2 dt-bindings: hwmon: tmp102: Fix up TMP103 bindin=
gs
> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp102.yaml b/Doc=
umentation/devicetree/bindings/hwmon/ti,tmp102.yaml
> index 477f478b9dd0f..c0b747a9ce0de 100644
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
> @@ -13,7 +13,9 @@ properties:
>    compatible:
>      oneOf:
>        - items:
> -          - const: ti,tmp110
> +          - enum:
> +              - ti,tmp110
> +              - ti,tmp113
>            - const: ti,tmp102
>        - const: ti,tmp102
>        - const: ti,tmp103
> --=20
> 2.53.0
>=20

--HXcYKxFLGrnoCBeY
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapcTawAKCRB4tDGHoIJi
0opdAQDs8r44wN5rerpFHGFXaBJvoTMFYv2HtSzfN75/tE9PVwD/USCXYbnUAnCa
H1xMucrcNvrizPTnMT7eJO2loeQgDgM=
=iZuW
-----END PGP SIGNATURE-----

--HXcYKxFLGrnoCBeY--
