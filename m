From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3 0/6] BQ24190 charger fixes
Date: Tue, 17 Jan 2017 18:06:39 +0100
Message-ID: <20170117170639.uoy6ulpnbilg35pz@earth>
References: <CAKvHMgQvmjBpaoT-2icVe9xfKWhW9tVOiHDei2jKxDOvSs15Tg@mail.gmail.com>
 <20170117032646.lf7hfrjsektfsxpk@earth>
 <CAKvHMgSEimsV7+VbqQi8Ex-ztqLCJbKQ7DD_NucyRB0bP5L4+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="f6ut7bi5tmjle7ie"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750952AbdAQRG4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 17 Jan 2017 12:06:56 -0500
Content-Disposition: inline
In-Reply-To: <CAKvHMgSEimsV7+VbqQi8Ex-ztqLCJbKQ7DD_NucyRB0bP5L4+g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Mark A . Greer" <mgreer@animalcreek.com>, Liam Breck <kernel@networkimprov.net>, Matt Ranostay <matt@ranostay.consulting>


--f6ut7bi5tmjle7ie
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 16, 2017 at 10:01:34PM -0800, Liam Breck wrote:
> On Mon, Jan 16, 2017 at 7:26 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > On Mon, Jan 16, 2017 at 06:28:28PM -0800, Liam Breck wrote:
> >> These are misc fixes, tested on a custom OMAP3 board.
> >>
> >> Changes in v3
> >>
> >> #1 fixes figure ID to 37
> >> #5 fixes line over 80 chars
> >> #* adds Acked-by Tony & Mark
> >
> > You forgot to fix the whitespace issues Mark mentioned, also
> > please use "git send-mail" or make sure, that your patchset
> > is threaded (patch 1-6 are replies to "patch" 0) and the
> > actual patch is inline and can be applied using "git am"
> > (which currently complains).
>=20
> Hi, would you accept the v3 patches as-is were I the module
> maintainer? Because I am the de facto maintainer :-)
>=20
> I contracted Mark to write this driver, and he hasn't had hardware on
> which to test it for a few years...

So I mentioned three issues:

- Mail Threading
  Please *always* do this on kernel mailinglists. Otherwise
  other unrelated patches might be in between your patch series.

- MIME Patches
  Your patches do not apply. See also Section 6 in
  in Documentation/process/submitting-patches.rst

- Whitespace Issue
  If you do style changes, do them in a separate patch. If you
  move this new patch to the end of the series, I can apply the
  other ones directly.
 =20
-- Sebastian

--f6ut7bi5tmjle7ie
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlh+TxwACgkQ2O7X88g7
+pozrg/+J8u6mR8IlrAac1Afpq1w3kRn049eFpsprEe7/obuMKnPiKlnZMTMhNx2
V37gc4SfHYF8jvHOgutGc0jFy3vPhp+OfYjzbX3jhIgpGZhPMKBgS5xb4PZRGuy2
q1E5VThnSAHCIgvQRdTEYEWbX/1JCkAkTJagQfDR59rzzYune62qELaX1PGHsiuL
V5nTB+g+5v3y6TLHsJkU7y1ubGIx4Mu8x1iw1SecgsnMDdsXJem6sTXKH+l3Kreh
X8DgcMyy9d6JWvd8pI+VJ50Vv8gflP0HObJJFLBqydjWxxeNIGjfw9K+WQYqkuRL
HdFXywYEtL9Iv/S7rgMbLHL14HxpbAfaX6UkpKez9ZkG70HovjSvbzXjuu+o3n5L
CqSc/PbHcb/FRgTX7XZjfWiEQZmMJvU1PkW1MX53+cWspgGyooCswDHLXUDpg9sc
cVYk9eN3qWj6sEUnJEUDKDcD6dEq6nZ2ft/7B/4fUcsMXkoO+cPwML3xd0vcaZJ6
HUS86ZP3PUJ4y8X6L+cEw35cHzIGVnLexhZg36LpXJ2tAKUIb9DucHGy7lUojYyx
ePoSEtSQBhaa6QkePlxYtPyO5qU5TEuto7MosS97RX7aSDQjRRlKaCx4Yt0z3DbH
DUB+T3FNHUNymojF20YWFspqlllcVVreC99jiy4kKWk3X25/NOU=
=LK2q
-----END PGP SIGNATURE-----

--f6ut7bi5tmjle7ie--
