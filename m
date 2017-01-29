From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Sun, 29 Jan 2017 23:43:52 +0100
Message-ID: <20170129224352.awzvwt2pzitovapu@earth>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth>
 <20170119122357.GF30182@ulmo.ba.sec>
 <20170119230036.sjfqvqxgxutis6xs@earth>
 <20170119232934.GA18102@roeck-us.net>
 <20170120083804.GF4894@ulmo.ba.sec>
 <20170129200239.x2rwx23xjj57flus@earth>
 <0447204d-34c6-aa62-d82b-ee064f1e79bb@roeck-us.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eovxp67napvj5kof"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:59974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750745AbdA2Wq0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 29 Jan 2017 17:46:26 -0500
Content-Disposition: inline
In-Reply-To: <0447204d-34c6-aa62-d82b-ee064f1e79bb@roeck-us.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Thierry Reding <thierry.reding@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--eovxp67napvj5kof
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 29, 2017 at 12:47:57PM -0800, Guenter Roeck wrote:
> On 01/29/2017 12:02 PM, Sebastian Reichel wrote:
>=20
> > >=20
> > > To keep things simple, I think it would be okay to allow only one of
> > > each type of controller in any running system. It's very unlikely that
> > > board designers would devise two different ways of powering off or
> > > restarting a system, while in a similar way an SoC or CPU would only
> > > ever provide one way to do so. Even if theoretically multiple
> > > possibilities exist, I think the board code should pick which ones are
> > > appropriate.
> >=20
> > Using that logic we may also advice, that board-code should only
> > register the board-level reset/poweroff and it's enough to have
> > a callback again... I wonder if that is really feasible.
> >=20
>=20
> FWIW, it is also not true.

It seems this was misunderstood. I do not expect this to work.

> There is a reason why many of the restart handlers used to have
> code saying "install restart handler, but only if none is
> installed yet". Which of course is racy, and gets more interesting
> if the restart handler installed first is unloaded at a later
> time, leaving the system with no restart handler. Or both are
> unloaded, leaving the system with a pointer to a no longer
> existing handler.
>
> One could then argue that anything implementing a restart handler must
> not unload. Which results in more restrictions. And drivers loaded
> on hardware which don't need it. And more corner cases to deal with.
> And more inconsistencies.
>=20
> In reality, many systems or system variants will have more than one means
> to restart it. Yes, board designers do devise multiple ways of powering o=
ff
> or restarting a system. There may be and likely are valid reasons for doi=
ng
> so; I would not want to claim or suggest that board designers would design
> such hardware without reason. Even "standard" PCs tend to have have more
> than one means to reset it. There _was_ a reason for introducing that
> framework; I didn't just do it for fun.
>=20
> However, as I had mentioned before, I am not really interested in this
> topic anymore. Just treat this as my final word of caution, or feel free
> to ignore it. I hope you'll find a much better solution than mine
> to implement "the board code should pick which ones are appropriate".

In case I was unclear: I'm fine with the current state of reboot
code using notifier chain and really thankful for the work. IMHO
it improved the status-quo a lot.

However I'm not fine with the current poweroff stuff and if somebody
offers to implement a solution compatible with Linus (and other people,
which disliked the notifier chain approach): Thanks, please do!

-- Sebastian

--eovxp67napvj5kof
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAliOcCUACgkQ2O7X88g7
+pqHExAAny6ndr+1GCiUB6KKqMp4fh/W/USdP1BovICQW92hu7f4sjE/64EUX1N3
noTRaKEKF7gyUiulf5uBdjDsnPk/iZvWeIfYYp+6hkmrisPC5DedUFh+V21NYt1R
KG8YVn90wrR9hIrNI1v+dcg1kOf+ZOtnS6NPNGFvE6pGrh+7Tnh0YOD2Q7SkwkP7
L2NpHfxbQQ+7mdOoYLCYRri560w/FAcda74Jc2/8uw+ELfRkgxmMiYB74HzveI7l
2SkwMMwnU04x3NyHAjc59G4d4AD0x2YncZ2uPQMycGTFCztai3NUpDrrCeSCc+Pi
VhWSWfyhYWgjD+Fayq0maN+DpJeGgl/SIaJg+DoHgAuC2otLDYuSe2GIWpQcgLpI
c1frArwLW3q1Py8haMr0OdDITcWVBedUumMS3fg6FkwQygEra5InBn2I5twyxf3o
mhRRqwhbFuRofkIv0neUzg8vLT/oP3nIn10/MXxs4jjUyMjBNtCscqWxmzjqXMQh
aOg/a7Q7ziaa52VxhdCe9ZonZyMhrkp78sok+sZ5G2juunXM7F7OP27MG97qrq2t
9ND5A1x681dogLgLRw7RUUF7Rs/wVnfwpdrdmjAXqO4XzwRIZTVTx2I4c60ah6Be
VIEk0HSiRfiGoxAKgervNDXnrOwgDcN4USh8f/vgX0WiM1bO9Rk=
=4loB
-----END PGP SIGNATURE-----

--eovxp67napvj5kof--
