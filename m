Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52634F6495;
	Thu,  3 Sep 2026 17:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456093; cv=none; b=hddXZHEzQAd0zNCO3obCqMs851rclaDy84ETBYUtTAqvSwHYR6tkMRiKw0gJbNtUngZ4D5MYbuLXyCvMI19QynB6JclyftNEc6zVwkAzVOc6AW+hZsGha39sT+1RlNdmKVF47qMq2V6qsBajJSNz56C4/52KbggsQ9S4QGVE1r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456093; c=relaxed/simple;
	bh=F6kUvWhv2fOaTEzKqeV70A1DwKuIIXd90xpkbwhm3Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PX7niUhLhG0z4RE9jveHnLOcRlEKUy4UPN4k98MefnEt4aH9MQoptM582wYYevffU4QHQmZCYUwfs3D3pz0KcrCXDVWpBUoGildNreZyACwYC/0/euRfv6Y/onlu8paAHaUPHciRRAJ2PSkNsKV+hfmGpVqD3Ui38dJ/dZV/bE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZDC/fxN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZDC/fxN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8111F000E9;
	Thu,  3 Sep 2026 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788456091;
	bh=CQ/Ioi8cg1Z9spDgaEucJfTVU5rzPGYaoYnxsdutm8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nZDC/fxNM989gXl0VuKe/fr+wc1C2pAx7LT3r+dD2o3EF2TbegtWJD1TXgZLcyBvT
	 /sRQV7aSLxV1GEBJouj0/jWY/6+G7gPIje2CGB0fsFzCPCIZsSVgnkbYDSylCCobUf
	 eBAR+3EZsFwUrCp0lJBDEYZQ/0aJiGWwRbYDESieo3pkCkAbC7S3dRqqDDj5ceSHwe
	 T8vmlgQZfAZRYP6gMkPFNxfbuI1+CVW9uClA5dFdGbfDRMp/F1Sxd8E+hDud12efCy
	 dzxO7ykPzTx0CClT3093JqyyuokhWnw4VxHTXK6i/uT30pRqpJgBWsbk7Np7dlIl7a
	 bpTXWnXXgmMew==
Date: Thu, 3 Sep 2026 18:21:27 +0100
From: Conor Dooley <conor@kernel.org>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, robh@kernel.org, sre@kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: power: supply: add adi,lt8491.yaml
Message-ID: <20260903-tapered-subsoil-a3ade82e1253@spud>
References: <20250110080235.54808-1-johnerasmusmari.geronimo@analog.com>
 <cover.1788432152.git.johnerasmusmari.geronimo@analog.com>
 <4cf7fe04accbd558c4f0aa3da2f648b8144993be.1788432152.git.johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jL9kMH2DoInsHVgP"
Content-Disposition: inline
In-Reply-To: <4cf7fe04accbd558c4f0aa3da2f648b8144993be.1788432152.git.johnerasmusmari.geronimo@analog.com>

--jL9kMH2DoInsHVgP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026 at 06:46:36PM +0800, John Erasmus Mari Geronimo wrote:
> Add documentation for devicetree bindings for LT8491
>=20
> Signed-off-by: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analo=
g.com>
> ---
>  .../bindings/power/supply/adi,lt8491.yaml     | 92 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/adi,lt=
8491.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/power/supply/adi,lt8491.ya=
ml b/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
> new file mode 100644
> index 0000000000000..bb364b48fee58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
> @@ -0,0 +1,92 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/adi,lt8491.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology (Analog Devices) LT8491 Battery Charger
> +
> +maintainers:
> +  - John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> +
> +description: |
> +  The LT8491 is a buck-boost switching regulator battery charger that im=
plements
> +  a constant-current constant-voltage (CCCV) charging profile used for m=
ost
> +  battery types, including sealed lead-acid (SLA), flooded, gel and lith=
ium-ion.
> +
> +  Specifications about the charger can be found at:
> +    https://www.analog.com/en/products/lt8491.html
> +
> +allOf:
> +  - $ref: power-supply.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,lt8491
> +
> +  reg:
> +    maxItems: 1
> +
> +  adi,rsense1-micro-ohms:
> +    description: Resistance value of RSENSE1 in micro ohms.
> +
> +  adi,rimon-out-ohms:
> +    description: Resistance value of RIMON_OUT in ohms.
> +
> +  adi,rsense2-micro-ohms:
> +    description: Resistance value of RSENSE2 in micro ohms.
> +
> +  adi,rdaco-ohms:
> +    description: Resistance value of RDACO1 + RDACO2 in ohms.
> +
> +  adi,rfbout1-ohms:
> +    description: Resistance value of RFBOUT1 in ohms.
> +
> +  adi,rfbout2-ohms:
> +    description: Resistance value of RFBOUT2 in ohms.
> +
> +  adi,rdaci-ohms:
> +    description: Resistance value of RDACI1 + RDACI2 in ohms.
> +
> +  adi,rfbin2-ohms:
> +    description: Resistance value of RFBIN2 in ohms.
> +
> +  adi,rfbin1-ohms:
> +    description: Resistance value of RFBIN1 in ohms.
> +
> +required:
> +  - compatible
> +  - reg
> +  - adi,rsense1-micro-ohms
> +  - adi,rimon-out-ohms
> +  - adi,rsense2-micro-ohms
> +  - adi,rdaco-ohms
> +  - adi,rfbout1-ohms
> +  - adi,rfbout2-ohms
> +  - adi,rdaci-ohms
> +  - adi,rfbin2-ohms
> +  - adi,rfbin1-ohms
> +
> +additionalProperties: false

Valid point here from Sashiko.
pw-bot: changes-requested

Thanks,
Conor.

> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        battery-charger@10 {
> +            compatible =3D "adi,lt8491";
> +            reg =3D <0x10>;
> +            adi,rsense1-micro-ohms =3D <5000>;
> +            adi,rimon-out-ohms =3D <124000>;
> +            adi,rsense2-micro-ohms =3D <3000>;
> +            adi,rdaco-ohms =3D <64900>;
> +            adi,rfbout1-ohms =3D <113000>;
> +            adi,rfbout2-ohms =3D <10000>;
> +            adi,rdaci-ohms =3D <7000>;
> +            adi,rfbin2-ohms =3D <3480>;
> +            adi,rfbin1-ohms =3D <102000>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2fb1c75afd163..d79187312f789 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15170,6 +15170,12 @@ F:	Documentation/devicetree/bindings/hwmon/pmbus=
/adi,lt3074.yaml
>  F:	Documentation/hwmon/lt3074.rst
>  F:	drivers/hwmon/pmbus/lt3074.c
> =20
> +LT8491 BATTERY CHARGER DRIVER
> +M:	John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>
> +L:	linux-pm@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/power/supply/adi,lt8491.yaml
> +
>  LTC1660 DAC DRIVER
>  M:	Marcus Folkesson <marcus.folkesson@gmail.com>
>  L:	linux-iio@vger.kernel.org
> --=20
> 2.34.1
>=20

--jL9kMH2DoInsHVgP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCapmslwAKCRB4tDGHoIJi
0p/wAP4y5ail7sdOr5N6o2ugaHKRzKPdUSzremMHTa2PyJV+kwD+Phc227sqVBwr
LCjYWc0OIsWOLsNIpNHfZeVBnrLEnQg=
=gZI8
-----END PGP SIGNATURE-----

--jL9kMH2DoInsHVgP--
