From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power_supply: Adjust devm usage
Date: Fri, 24 Jul 2015 15:01:59 +0200
Message-ID: <20150724130158.GB25447@earth>
References: <20150724115813.GA3004@vaishali-Ideapad-Z570>
 <20150724122622.GA22105@earth>
 <CAH6sp9ODe9EQjYgkjUr8P-bhhtgshqJovEcOVwKSP_FiuTo8Fw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rS8CxjVDS/+yyDmU"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55928 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752654AbbGXNCD (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 09:02:03 -0400
Content-Disposition: inline
In-Reply-To: <CAH6sp9ODe9EQjYgkjUr8P-bhhtgshqJovEcOVwKSP_FiuTo8Fw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Frans Klaver <fransklaver@gmail.com>
Cc: Vaishali Thakkar <vthakkar1994@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--rS8CxjVDS/+yyDmU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 24, 2015 at 02:39:12PM +0200, Frans Klaver wrote:
> On Fri, Jul 24, 2015 at 2:26 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > On Fri, Jul 24, 2015 at 05:28:13PM +0530, Vaishali Thakkar wrote:
> >> Use devm_kasprintf instead of kasprintf. Also, remove various
> >> gotos by direct returns and drop unneeded label err_free_name.
> >
> > Please also use devm_power_supply_unregister() instead
> > of power_supply_unregister() to further simplify the driver.
>=20
> Sounds like a separate patch.

I would be fine with either one or two patches. It's common, that
devm conversion happens in one commit instead of one patch per
function change.

-- Sebastian

--rS8CxjVDS/+yyDmU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVsjdGAAoJENju1/PIO/qavX4QAKQGTqPeWtFDsYtgj4wJMVhR
F8ON93wwWwRlPd0KhGjknpnm8Gs1aFE4VCTyOCrFkAWGsE+X3YZROkGOmAyQYCIS
Kqa3pM8bEPLD4Meaklsf2NEBrAc8NvOwuFQ9LIFuy4frN11qiLTA4Vlgo6V2AW8+
1Wo7LEAWbNmrqScuQ36DRUbMSRYgU2kcEdxsiAxx1ePFuQNWIfV0o2IvhCmqhvae
FYAxZ7vyLe1RpsBSr3wHxjfpNsPqXwg+8vgnwULqk5iuYQJ02x1xY5uMbZVnQLXF
2ISNyj9T/8/ceT7sVFdiHfwUjToibbQJaRZfJEjp4+kJVZVBo9Nm48Hr+Lo+uTHi
YtpkcTH5rXhjGXW9L8xMdmVMjXLkX6qE/y6vdcPFu3T5Ihk0mTvHeGC1s1SKjjrR
IyZOS/uklhyzoLs1g6CypZ7EEM8XI5QOVmPcmOqdsuwuej/61FWh1tw137DntM1g
d3tWYmxyJBHXpevnmrchoERLqAfO2jltE8zFXEr+zkhQuFh42nu+CztkZwJFeylG
LHAZ/QAn7IEMRXZ8pHzwtuSkWuzdr6m3gvs8iX8JC+KhAt5EgZ8pht1HXg2dEyGK
guDSCK9tYqbUhqfg+xaCrwlqFDrOVqZqQpjUX+xkaakeoyL4QOhH9+dplK/WcFmH
LzuGYFAt4ThV3+p8c2YG
=c0dL
-----END PGP SIGNATURE-----

--rS8CxjVDS/+yyDmU--
