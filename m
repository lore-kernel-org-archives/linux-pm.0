From: Sebastian Reichel <sre@kernel.org>
Subject: Re: generic-adc-battery volatge-to-percent formula
Date: Mon, 22 Feb 2016 18:20:09 +0100
Message-ID: <20160222172009.GA7393@earth>
References: <CAAfyv37rjchL=FtvgGhjrfXnCvhfbYCext48QmSuOgJ5RjTwAQ@mail.gmail.com>
 <20160212085157.GA16326@amd>
 <CAAfyv34=C5NSTuqR9Pf4MT2Z42XvT_1Gw+kyjZZh12zC2cBoFA@mail.gmail.com>
 <20160215115304.GA5014@amd>
 <20160221200653.GD15242@earth>
 <0BD7A329-A8BE-4B3E-B98F-CAB7A25F643F@goldelico.com>
 <20160221211257.GA26418@amd>
 <7720041C-DFEC-4592-A5AE-0C2BEEFB6049@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47012 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213AbcBVRUN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 22 Feb 2016 12:20:13 -0500
Content-Disposition: inline
In-Reply-To: <7720041C-DFEC-4592-A5AE-0C2BEEFB6049@goldelico.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Pavel Machek <pavel@ucw.cz>, Belisko Marek <marek.belisko@gmail.com>, Linux PM mailing list <linux-pm@vger.kernel.org>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Feb 22, 2016 at 06:58:13AM +0100, H. Nikolaus Schaller wrote:
> >> static inline int fuel_level_LiIon(int mV, int mA, int mOhm) {
> >> ...
> >> }
>=20
> To which header file should this go?

I think it should get its own header file in include/linux/power/.
Maybe something like "generic-fuel-gauge.h". I'm open to other
solutions, though.

-- Sebastian

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWy0NGAAoJENju1/PIO/qa7q0P/jSwFmyrmfL4HBXz4DHiMMmo
FH76FM+zKCdi0PZDxKGU6OaJVuTNIk5z1FSixSWdXsCWc39+YbgPlZCJC/RJqJfx
dKctWI9L2uhEhElHioNtDx/pqxnH0uG3IDmSTYZyKJwABHiqpuD8ROqPq2jQgud+
qudOFM63Z6Xv2+g0l+KMf6uqGTLkRvStAEsOwpTAc35gBDbXZ02cIlJvYPScnMzG
SskCq9MfhN5ceV95qSKv9qIr8smHhd+X303OqSibFvCfa86NZo54D5QA7iMvm7i4
kUryfILhGEMcdFVZOYSYSGArLNktNkRHJ8jHyxLLzEePV4TI6sE3wKljuyIWC23/
5IHOzduESBBYqRb6qMBXPPaJc2WtTtVhD7q6bNoZelQaQPyYuGOWap6xbjHsOaX0
ONwh3WCa+x3q3gUVMt6NWi/U8WcxspkzrvQHllTtfIfpWVDM2mp+jB09xVuXs6c+
Nfn0pL+ILqzd3+O800LfDwydTH/5OqPqwFYnMJQa+DkBWGu8eCrkA5lYnYek8lrN
NGcN2IXTex7TKBu9rshYph8vQi3R6BN3mBee54NWV8YeHQxQQ4YwViSYYWegvDq3
j0fd+1clnLOKc2iATOyQxQUwiAnLMYVEwK0TXLfW0TMt96azH7njfVz9xc8XyOAN
CmyEXeJg3TZZ2TYF/pz6
=k7/T
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
