From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] regulator: Add brcm,bcm63xx-regulator device tree
 binding
Date: Fri, 4 Dec 2015 14:31:17 +0000
Message-ID: <20151204143117.GB26072@sirena.org.uk>
References: <20151202125325.GI1929@sirena.org.uk>
 <565F53FC.5080309@simon.arlott.org.uk>
 <20151203000631.GM1929@sirena.org.uk>
 <565FF9E9.1090503@simon.arlott.org.uk>
 <20151203150528.GG5727@sirena.org.uk>
 <5660D274.7000402@simon.arlott.org.uk>
 <20151203234548.GJ5727@sirena.org.uk>
 <5660D574.7030803@simon.arlott.org.uk>
 <20151204110018.GU26072@sirena.org.uk>
 <d7609dc97ddd988876e4efefaec2c18a4b7161bd@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zUOaI4FcYSvHUUu9"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d7609dc97ddd988876e4efefaec2c18a4b7161bd@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Sender: linux-kernel-owner@vger.kernel.org
To: Simon Arlott <simon@fire.lp0.eu>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Jonas Gorski <jogo@openwrt.org>
List-Id: linux-pm@vger.kernel.org


--zUOaI4FcYSvHUUu9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 04, 2015 at 12:26:58PM -0000, Simon Arlott wrote:
> On Fri, December 4, 2015 11:00, Mark Brown wrote:

> > OK, so the power domains should be being represented and managed as such
> > rather than using regulators - it's a better fit (doing things like
> > support atomic context) and it also sidesteps this.  For the things that
> > you say are clearly regulators should we have more information about
> > those?

> I'd prefer to handle them all as power domains since it fits better. Even
> if some of them are regulators there's no extra control or status interface
> and they're used like power domains to disable unused functionality.

OK, great - runtime PM is just generally a more idiomatic interface for
this.

--zUOaI4FcYSvHUUu9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWYaOwAAoJECTWi3JdVIfQz9wH/RjTLwdynlZ/Ld3Rm2GVn8C+
E0KR525dqjvEsKyKeCF6P6ql8liKWI8+ec4X72inJ/156H9h2XqLDVbpGnq/yRk1
JwNGjyqwCfjbiJhG0UJILR3A0rL/1NJGEHHEXY+oQ3D+rS8Iy9UpTvzlgXxWNYYS
OZR8RYVauO98xITXHRth0R+PgaAfSjwe/OxL+Kfzcwnkvo0pnddoys9cDbSNBteq
5mBT3qIuXeXanhJesZs377DXdGgIVMyGdBcq6eNvrsilPE6QKyiZ4mCQcVU3Im/u
N1YWPR33ipClFk9GTYC487PdWS/Tm0XXCFm2vagk87VLmkEgT/o+Ewa+oQRwCFY=
=TQsh
-----END PGP SIGNATURE-----

--zUOaI4FcYSvHUUu9--
