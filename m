Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D5831064B;
	Mon,  2 Mar 2026 17:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772473666; cv=none; b=L5dmTAy+6OE3SO428JZkTol93ywMTvGJrI9cuzkFHrU59GFOUVrZYrMVKjLSJiYBiBlY7neC63Ax5tXKLcFTk00Mqs3ag4PTs2uAm8Z1c0NeuaLttQ0+NLaSHw90KFrVFYJcyr71kSJ7QhTFzb+hituwZZH1GFocoX7TrWZbSrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772473666; c=relaxed/simple;
	bh=Niv3Eaz4uVC7uCy+cG0AL/rcskdWHCjnFqA4TLgIip8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jd9wMy6V6bcb6zGGlu+JBVIemCtjZ9HZrOsnDad+pyE596XowpNWhbg+kfM9BJueUYE73BUaU4ByhvRaS5Mi6RDLQxx3MJim38GC/drR+ZqHy6hpswpXMyFBhvEOdAfsdp57uQT+yMaPXXc6egkW+rVslv0tZN3L22SdDQU6du8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mb6qLmtL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mb6qLmtL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB58C19423;
	Mon,  2 Mar 2026 17:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772473666;
	bh=Niv3Eaz4uVC7uCy+cG0AL/rcskdWHCjnFqA4TLgIip8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mb6qLmtL5pRYwv6aOvjHdd73oti7/ImZtG+ffVKd4xYSNwzcKH5+XJdhcvvAQcyTl
	 b3zUBVhk39HkMGnQfoFKz/1hDd5dbmd2t23mCHm56iKG31Q82GTP5rO6pGIPDHwY19
	 bDynPFvXc0MXPnQBbnc26W0/bGgn6jmi1nvDijj3JOrZ30+ZX9RTu/qyHNPl1eFMwB
	 UwC92w0Csf1d7RhigD5tG3z7gxvd+0zykx3BBVgbJdhsmGl+FAse6UCP0rbh5ZcE8J
	 eZATwketQRbPNxtHdipXuOsDl5zm98bpH82Vbjm9KAn5qboRfOszDWo/A2uibtpIOg
	 bHoV9r7PBDa8Q==
Date: Mon, 2 Mar 2026 17:47:41 +0000
From: Conor Dooley <conor@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@axis.com,
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] dt-bindings: power: supply: Add TI BQ25630
 charger
Message-ID: <20260302-removing-fidgeting-ea8909e3f407@spud>
References: <cover.1772201049.git.waqar.hameed@axis.com>
 <65f55d19b4bcf8f07300df5922ba1605bb669138.1772201049.git.waqar.hameed@axis.com>
 <20260227-percolate-armful-ac15f947b2ff@spud>
 <pnd8qcawdl8.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qajiq+IID00FtEWh"
Content-Disposition: inline
In-Reply-To: <pnd8qcawdl8.a.out@axis.com>


--qajiq+IID00FtEWh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 02:44:19PM +0100, Waqar Hameed wrote:
> On Fri, Feb 27, 2026 at 17:31 +0000 Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Fri, Feb 27, 2026 at 04:35:33PM +0100, Waqar Hameed wrote:
> >> Add devicetree bindings for the TI BQ25630 battery charger. It's I2C
> >> controlled and sends interrupts.
> >>=20
> >> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
> >> ---
> >>  .../bindings/power/supply/bq25630.yaml        | 68 +++++++++++++++++++
> >>  1 file changed, 68 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/power/supply/bq2=
5630.yaml
> >>=20
> >> diff --git a/Documentation/devicetree/bindings/power/supply/bq25630.ya=
ml b/Documentation/devicetree/bindings/power/supply/bq25630.yaml
> >> new file mode 100644
> >> index 0000000000000..57e4286dac7e9
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/power/supply/bq25630.yaml
> >
> > Filename is missing "ti," to match the compatible.
>=20
> The majority of TI devices in this folder do not contain the `ti,`
> prefix, so I just followed that. But I'll make sure to add it in the
> next version then!
>=20
> [...]
>=20
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/interrupt-controller/irq.h>
> >> +
> >> +    bat: battery {
> >> +        compatible =3D "simple-battery";
> >> +        voltage-min-design-microvolt =3D <1800000>;
> >> +        constant-charge-current-max-microamp =3D <1344000>;
> >> +        constant-charge-voltage-max-microvolt =3D <3700000>;
> >> +        charge-term-current-microamp =3D <128000>;
> >> +        precharge-current-microamp =3D <1000000>;
> >> +    };
> >
> > This whole battery node can go,=20
>=20
> Alright, will remove in the next version!
>=20
> > the tooling will falsify the phandle.
>=20
> I'm guessing you mean that when extracting the example, the insertion of
> `/plugin/` to the `*.example.dts`-file will "falsify the phandle"?

I'll be honest, I don't know exactly what the mechanism is that fakes
the phandles, but it means that any sort of generic device doesn't need
to be included in the example.

> There are some other examples in this folder that include this node. Not
> sure if it's worth the churn to fix those as well to help the next
> person?

Probably isn't worth the churn /shrug

--qajiq+IID00FtEWh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaaXNPQAKCRB4tDGHoIJi
0hNSAQCpPoe+HoJ436qh4ST/5365KSW/hZoOQxYKjKdj4tVatgEAtftuQL4x38Ep
TrnTKaNjCzyZ3gCklv+/TnUSDXV7lgw=
=GuCb
-----END PGP SIGNATURE-----

--qajiq+IID00FtEWh--
