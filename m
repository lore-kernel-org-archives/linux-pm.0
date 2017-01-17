From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 0/6] BQ24190 charger fixes
Date: Tue, 17 Jan 2017 01:25:35 +0100
Message-ID: <20170117002534.nbvtq2s347biuaci@earth>
References: <CAKvHMgTZsiALaWqgwO0NjACi_smHtPUomd6PnbW-TQfG8jnFkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ufzhjprql7gigxsv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750728AbdAQAZj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 16 Jan 2017 19:25:39 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgTZsiALaWqgwO0NjACi_smHtPUomd6PnbW-TQfG8jnFkQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>


--ufzhjprql7gigxsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Liam,

On Sun, Jan 15, 2017 at 10:05:26PM -0800, Liam Breck wrote:
> Changes in v2:
>=20
> #1 reorders:            Fix irq triggering to IRQF_TRIGGER_FALLING
> #2 factors out part of: Call power_supply_changed() only for relevant com=
ponent
> #3 replaces:            Call enable_irq() only at the end of probe()
> #4 reorders:            Call power_supply_changed() only for relevant com=
ponent
> #5 unscrambles:         Don't read fault register outside irq_handle_thre=
ad()
> #6 factors out part of: Don't read fault register outside irq_handle_thre=
ad()
>=20
> These are dropped; Tony will resubmit them in new patchset:
>   Check the interrupt status on resume
>   Use PM runtime autosuspend

I have no additional review comments to the ones you already
received. When you resend the patch series with Mark's comments
fixed, please don't forget to add the Acks to your patches.

-- Sebastian

--ufzhjprql7gigxsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh9ZHwACgkQ2O7X88g7
+pr76g//cox9PsaSrTU4fhBMQHChJVCs11ZxKJYZ6sNqEQUR5qu3tUXIoTiHk3il
CPPs2HIXL+eOy448I1jZQmjjbRLXNGWL10V31uaue2/Ea35H5jyXlNyMKL8QuI5J
dCeqNOx88YhRhWuf7C57I4QzopwMkPfPgjVUyNZ/7z6Dmqd0wUi3nmRPdaNJxlNw
Yn3yp7ADib91LauAopahfcUI4ThZMqqcmJHrS+Puw7RVLDkD6thcaNl642Z4rPrx
1zvwY8ln27rPv8vKJmN5HpMIn05BaL3Pm8F6leIA+CFYme+GJcJj/5Zx9SJJZwOU
ZPvqZy0Hf5pmY8wmIbndscrWYQW5w1U0gRcmJe+gbNrwQEV+LaLvtXoJs8/MQSH0
3vXfUKKYz8RpMh3elWQrZGwsgxzqHRIcjzcsCgaeVD9wtZEMpQbJdxrd7lMQYONK
W+mFLA4rXknrak+LwuVMxKZVYUjaUgZvgxUbk4m2by6lAxwmROXxeFbeVOxgtJZ0
fHJpPqfOr2DfNxAo11CG7CgnkQjHYHwl73Fj1PD0PdOX8iu3tQVZ//Gvg2CGEFGB
Ey3nEFdJvj01OvGvWKg4H8EAPr/RDC1eawUo8QRhTihCV/ED5dZ6jKR55YuNFT+6
fcXg/5QQ3to+0JRnxiYUXk9wG+IpkN83esfy5dVQ4MKC/Ft/cCo=
=B/A+
-----END PGP SIGNATURE-----

--ufzhjprql7gigxsv--
