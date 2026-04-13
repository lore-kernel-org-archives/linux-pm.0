Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF1E3E1CF0;
	Mon, 13 Apr 2026 15:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094942; cv=none; b=hvb/WrzHzVCAcQToRaCvx/3ou7opcxLPeW/F8V8KtAa2W0ApHSNZczVtJfc0/pl7wr5OmbwgeQSj9lGxIXYvUukJVMBp1H9mMCu8Ff8r6rpLrRew7c+IHDKGpR0D/q16lT5Xnbzue1wNhdGrCC2s18SYy4pFWKMTXVh0zaLJ9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094942; c=relaxed/simple;
	bh=NZiRtuusNFRQ9ALDsb7+X0+Un3wKAtS+hdSBSZf6dFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9Rb+95VwjLhQGLX974SMxxabwJ0YmwqgXgMS2+2wpqup6eV6yx0wFSMQGTN+K5LMkS1Xw4S5I2C6SaNb0ExOZjlx7NlrdNWPuERa+uCueiqpgaNbg0vsf9nzqsznmJq/Zspf3EotnfHON0SiITRjVDilL4Vfo8FsdwumEVdRXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr43Nkbv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr43Nkbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F5FC2BCAF;
	Mon, 13 Apr 2026 15:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776094941;
	bh=NZiRtuusNFRQ9ALDsb7+X0+Un3wKAtS+hdSBSZf6dFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jr43NkbvAeO28DfZVQX8WcSGLw3Sv46TmveO6Ji8/02wIzyHVvM4aAj8OAfxdfSIo
	 5g6GJidKvGlxbtC21BQUWzWeJjQSINytASVO76dZaFiFAEmN+gH73KVIWatrarViGK
	 PWNWZyNphAHyoSW0zpjfwcU0+ZmC7a26QvhCs2knO7pKuoeUhOkSvzY/xiDyScCxmD
	 V1ikFkFwhj/TALOgXN3hr8I75LeMcmHEm4R8+PUot5ndePdhi91Kd6a9aZ6wuhOTdw
	 EUK9tk3ZgcFdv4q/tIPqHCYMcdxXmRV8rqg5FqlpBCINYzjAibABu4N6Q6ZUmksHpY
	 +O9jAG0bZ31Lw==
Date: Mon, 13 Apr 2026 16:42:16 +0100
From: Conor Dooley <conor@kernel.org>
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Guillaume La Roque <glaroque@baylibre.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/8] dt-bindings: thermal: amlogic: Add support for T7
Message-ID: <20260413-impose-cartel-bd7d18f91a24@spud>
References: <20260413-add-thermal-t7-vim4-v2-0-1002d90a0602@aliel.fr>
 <20260413-add-thermal-t7-vim4-v2-1-1002d90a0602@aliel.fr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dTC3gs8s/Z9bvL6x"
Content-Disposition: inline
In-Reply-To: <20260413-add-thermal-t7-vim4-v2-1-1002d90a0602@aliel.fr>


--dTC3gs8s/Z9bvL6x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 12:52:42PM +0200, Ronald Claveau wrote:
> Add the amlogic,t7-thermal compatible for the Amlogic T7 thermal sensor.
>=20
> Unlike existing variants which use a phandle to the ao-secure syscon,
> the T7 relies on a secure monitor interface described by a phandle and
> a sensor index argument.
>=20
> The T7 integrates multiple thermal sensors, all accessed through the
> same SMC call. The sensor index argument is required to identify which
> sensor's calibration data the secure monitor should return, as a single
> SM_THERMAL_CALIB_READ command serves all of them.
>=20
> Introduce the amlogic,secure-monitor property as a phandle-array and
> make amlogic,ao-secure or amlogic,secure-monitor conditionally required
> depending on the compatible.
>=20
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
>  .../bindings/thermal/amlogic,thermal.yaml          | 42 ++++++++++++++++=
++++--
>  1 file changed, 40 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/thermal/amlogic,thermal.ya=
ml b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> index 70b273271754b..1c096116b2dda 100644
> --- a/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/amlogic,thermal.yaml
> @@ -21,7 +21,9 @@ properties:
>                - amlogic,g12a-cpu-thermal
>                - amlogic,g12a-ddr-thermal
>            - const: amlogic,g12a-thermal
> -      - const: amlogic,a1-cpu-thermal
> +      - enum:
> +          - amlogic,a1-cpu-thermal
> +          - amlogic,t7-thermal
> =20
>    reg:
>      maxItems: 1
> @@ -42,12 +44,39 @@ properties:
>    '#thermal-sensor-cells':
>      const: 0
> =20
> +  amlogic,secure-monitor:
> +    description: phandle to the secure monitor
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to the secure monitor
> +          - description: sensor index to get specific calibration data
> +
>  required:
>    - compatible
>    - reg
>    - interrupts
>    - clocks
> -  - amlogic,ao-secure
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amlogic,a1-cpu-thermal
> +              - amlogic,g12a-thermal
> +    then:
> +      required:
> +        - amlogic,ao-secure
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: amlogic,t7-thermal

This can just be replaced by a else I think.

> +    then:
> +      required:
> +        - amlogic,secure-monitor
> =20
>  unevaluatedProperties: false
> =20
> @@ -62,4 +91,13 @@ examples:
>          #thermal-sensor-cells =3D <0>;
>          amlogic,ao-secure =3D <&sec_AO>;
>      };
> +  - |
> +    a73_tsensor: temperature-sensor@20000 {

Can drop the label here, it has no users.

Otherwise, seems fine.

Cheers,
Conor.

pw-bot: changes-requested

> +        compatible =3D "amlogic,t7-thermal";
> +        reg =3D <0x0 0x20000 0x0 0x50>;
> +        interrupts =3D <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&clkc_periphs CLKID_TS>;
> +        #thermal-sensor-cells =3D <0>;
> +        amlogic,secure-monitor =3D <&sm 1>;
> +    };
>  ...
>=20
> --=20
> 2.49.0
>=20

--dTC3gs8s/Z9bvL6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCad0O2AAKCRB4tDGHoIJi
0sbSAP4nORffFzPK6NFPJTU1MrhZS0mvUDhBdgSXCaZqTS1+vQEAxha0GIdwWfXQ
95JymSDVjHiQlz/NE/rfhqyIzCy/AQg=
=maw2
-----END PGP SIGNATURE-----

--dTC3gs8s/Z9bvL6x--
