From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH 0/5] Functional dependencies between devices
Date: Wed, 8 Jun 2016 18:33:23 +0100
Message-ID: <20160608173323.GN7510@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <2576341.476ZsjkPgF@vostro.rjw.lan>
 <20160608121517.GG7510@sirena.org.uk>
 <CAJZ5v0ggk6433uM2Xx=0krgjvVrr28tPg1a+LSs6bW0M_t_rFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2CW6+cughRlDaKZr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ggk6433uM2Xx=0krgjvVrr28tPg1a+LSs6bW0M_t_rFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org


--2CW6+cughRlDaKZr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 08, 2016 at 07:24:15PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2016 at 2:15 PM, Mark Brown <broonie@kernel.org> wrote:
> > On Thu, Jan 14, 2016 at 02:52:11AM +0100, Rafael J. Wysocki wrote:

> >> What follows is my prototype implementation of this.  It took some time
> >> to develop (much more than I was hoping for), but here it goes at last.

> > Might be worth posting this outside the thread with CCs to people
> > working on system integration like SoC maintainers - I'd completely
> > missed this as it was buried and looked like the middle of an old
> > discussion.

> OK

> I can resend it afresh, but need to do some rework due to some changes
> that happened in the meantime.

Yeah, it looks like the actual patches didn't get much comment but
there's the constant grumbling about deferred probe which it'd be good
to resolve.

--2CW6+cughRlDaKZr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWFbiAAoJECTWi3JdVIfQ7BYH/j9q2v/m4k4WRx9xd/Rkt1di
9Joyx6tRZuW9Bj76Clsiov/iafgB46+oYnYsUTZYIf12aAqzErGrtrbHH05qzAzp
QDkfHYQarPDgilZKllD/N8iz9kcRIa6APUCXnAOILRocMBadk3xxaS5MjkDiKwyb
hDkxPcvkoXogTbJYF7HWQfecbQv6Bv1JJdK0eH2NdKkBzCP2He1MTPKCYzJJyMGv
WrpfkoVELTdp2n8/za63ZymEYQEJ1VcGcA6urRd8fjy/Ptj0Tk4xLI5DaFQY0C6Z
vEsx0R8fBEf8TLh7PVS+wJ8OYNMijQYP5DkzTruDrqvpq/jW/GXSDiYRA++b2ws=
=2Nb7
-----END PGP SIGNATURE-----

--2CW6+cughRlDaKZr--
