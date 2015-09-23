From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v5 01/11] dt: power: bq24257-charger: Cover additional
 devices
Date: Wed, 23 Sep 2015 02:34:15 +0200
Message-ID: <20150923003414.GB4359@earth>
References: <1442612399-341-1-git-send-email-dannenberg@ti.com>
 <1442612399-341-2-git-send-email-dannenberg@ti.com>
 <20150922162448.GE4235@earth>
 <20150922215823.GA30297@beast>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JYK4vJDZwFMowpUq"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33760 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759757AbbIWAeT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 20:34:19 -0400
Content-Disposition: inline
In-Reply-To: <20150922215823.GA30297@beast>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Laurentiu Palcu <laurentiu.palcu@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Ramakrishna Pallala <ramakrishna.pallala@intel.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org


--JYK4vJDZwFMowpUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 22, 2015 at 04:58:24PM -0500, Andreas Dannenberg wrote:
> On Tue, Sep 22, 2015 at 06:24:48PM +0200, Sebastian Reichel wrote:
> > On Fri, Sep 18, 2015 at 04:39:49PM -0500, Andreas Dannenberg wrote:
> > > Extend the bq24257 charger's device tree documentation to cover the
> > > bq24250 and bq24251 devices as well feature additions.
> >=20
> > The binding looks fine to except for:
> >=20
> > > +- stat-gpios: GPIO used for the devices STAT_IN pin. Alternatively t=
he pin can
> > > +    also be defined through the standard interrupt definition proper=
ties (see
> > > +    optional properties section below). Only use one method.
> >=20
> > Why do you expose two ways for this?
>=20
> Hi Sebastian. The original driver exposed this - it just didn't
> document it in the DT binding doc. I'm not sure why this was introduced
> in the first place (Laurentiu?). I know we can't change the API but
> since it was never documented maybe we can remove it?

It seems this is neither documented, nor used. So I guess it can be
removed. Let's wait for feedback from Laurentiu, though.

-- Sebastian

--JYK4vJDZwFMowpUq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWAfOGAAoJENju1/PIO/qaXPMP/iornNTJzenD7SJfS6LNVP8d
p+E/DRV4eVPseBR836b8gy+UnCYADIwyWOFPJ8uPVs2ZX5J46hcDDUTZcgfc1Lap
5e0vFYg76Epzybti5v4m8Q+R9sgbnDlE2bXJ6rxpXKueVEMW9NA06C2KvpU0apxP
dGe7CI7/SIqwIdjjdK8eEp2h2qtDNGkWnGiOOS+nhhoOfCygyfZAWKqjj1o0+PZs
sFbZr3B5mpuE6BbxdkJPORI8Hjoodyd/4iExiM4FdFB4j+BO/eDBdAnQ1rSV5znt
XKKaryr0Y2pTkZ2jOS3d1MELSQGq8inVCH8xtGKwU04hZMTvfhGWHCnE/VGBrj2W
8YQhcV9Ci++t538gJZTQCDt3OQw8z/b/rfhwvMupIY+OOoA94EscB+RUPh1sIc0/
w4bHrm+lRguZpKcRyi+w2WY+GEZEsBIjk9acU+g97xDmVThKFXhARZlffN57rbss
otXpVi3fC1cyvWu8AXuwgwdYx2z3YjdjQ8h8DzMp15y7rFO9ktznUBU4PVlrApaL
capDvf3A8SzVFsSmCXT1rjvcEO9+OiARWxnqsUaAxQUrmzFfC5pF02MCs3QQQbe+
dRO8nfgeHf1qRDI9sEfsaSiCK0F18VOK3zZ7u3sS3iaK4IJb7Zn4q0N+bTMoDJpS
w9Z7WrDTUBP6t4Pu0MZi
=jXa4
-----END PGP SIGNATURE-----

--JYK4vJDZwFMowpUq--
