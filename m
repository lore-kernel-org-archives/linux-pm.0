From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 24/26] cpu_cooling: Store frequencies in descending order
Date: Wed, 3 Dec 2014 10:00:32 -0400
Message-ID: <20141203140030.GA4451@developer>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
 <ecb90bfbe1dd69ad73210630ce0a2f988d6210f1.1417167599.git.viresh.kumar@linaro.org>
 <20141202232128.GA3645@developer>
 <CAKohpo=ew8wUeJ4Mf567BNP70AS8uHDWmBEFzL4Uo_ze0UtJ+A@mail.gmail.com>
 <20141203134157.GB4325@developer>
 <CAKohponw7E9yyvjhP97CzjtcFcq3N+5ysde7DR5q+Nm0s=bKAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f45.google.com ([209.85.216.45]:55878 "EHLO
	mail-qa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaLCOAm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 09:00:42 -0500
Received: by mail-qa0-f45.google.com with SMTP id x12so10380161qac.32
        for <linux-pm@vger.kernel.org>; Wed, 03 Dec 2014 06:00:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAKohponw7E9yyvjhP97CzjtcFcq3N+5ysde7DR5q+Nm0s=bKAw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 03, 2014 at 07:26:17PM +0530, Viresh Kumar wrote:
> On Wednesday, December 3, 2014, Eduardo Valentin <edubezval@gmail.com>
> wrote:
>=20
> >
> > Well, passing -1 to unsigned int will make it max unsigned int, your
>=20
>=20
> Yeah, that's what I want.
>=20
>=20
> > function will return the first freq, which in the scenario I gave, it
> > would be the min freq, not the first max, right?
> >
>=20
> Are you sure you are reading the code correctly? Try one more
> time :)

Yeah, the code is correct. I need more coffee probably. :-)


--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUfxd3AAoJEMLUO4d9pOJWpjQIAIczfcH6CFLkv9FCUB73YJBa
Q4J5VJ8IJ3UIxpWTTR5uz3jY7srV5PiCdjzDbwCslS3B0bWl4FlN5o9j3CWwKlGV
7CkXOwKP1vaRsYBKvAYPKD60fiKCXrawdTngqzoUEL51SF4yagji7CzjpP6Pebxt
rJNTQozyJZv6HPWvtQQBjnlSS6dK287hypkCAhkDg+CQkWwwHW14zUiLTqYgVVZP
f2AresH4jbOJnQqk6lBsYfJVQ55KvxPyZkfWy9i9YyLvy9lg4s2imYoN8+O0tDLT
NUn2dFabRhi5OyFOvwEQ+3OcY1Ww7xVx6ZypdqoMA2KJXFbsyEV2sbhuX0AzH+o=
=LS3f
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
