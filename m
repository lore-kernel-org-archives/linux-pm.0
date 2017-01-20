From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] power: reset: Add MAX77620 support
Date: Fri, 20 Jan 2017 14:11:16 +0100
Message-ID: <20170120131116.GA26505@ulmo.ba.sec>
References: <20170112161507.23774-1-thierry.reding@gmail.com>
 <20170113034425.7ttvc73aewtbitrk@earth>
 <20170119122357.GF30182@ulmo.ba.sec>
 <20170119230036.sjfqvqxgxutis6xs@earth>
 <20170119232934.GA18102@roeck-us.net>
 <20170120124404.wmlpiuqyizi7uhyi@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33594 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750893AbdATNOL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 20 Jan 2017 08:14:11 -0500
Content-Disposition: inline
In-Reply-To: <20170120124404.wmlpiuqyizi7uhyi@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Laxman Dewangan <ldewangan@nvidia.com>, Martin Michlmayr <tbm@cyrius.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Chaitanya Bandi <bandik@nvidia.com>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 01:44:04PM +0100, Sebastian Reichel wrote:
> Hi,
>=20
> On Thu, Jan 19, 2017 at 03:29:34PM -0800, Guenter Roeck wrote:
> > On Fri, Jan 20, 2017 at 12:00:36AM +0100, Sebastian Reichel wrote:
> > I actually have a set of patches somewhere which transforms the remaini=
ng
> > direct users of arm_pm_restart to use the framework (unless I removed it
> > from my trees - I don't really recall). I just never got around to subm=
it
> > it, and then [2] happened and I lost interest.
>=20
> I found a patchset from you from 2016. I see a few Acks and no
> negative feedback. Looks like they only need to be uploaded at
> Russel's patch system?
>=20
> arch/arm/mach-prima2/rstc.c			https://patchwork.kernel.org/patch/8844441/
> arch/arm/xen/enlighten.c			https://patchwork.kernel.org/patch/8844481/
> drivers/firmware/psci.c				https://patchwork.kernel.org/patch/8844411/
> arch/arm/kernel/setup.c				https://patchwork.kernel.org/patch/8844451/
> removal of ARM64 arm_pm_restart		https://patchwork.kernel.org/patch/88444=
71/
> removal of ARM32 arm_pm_restart		https://patchwork.kernel.org/patch/88443=
91/

Nice, those would be excellent preparatory work for my earlier framework
proposal.

Do you want me to pick those up and run with them a bit?

Thierry

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAliCDHEACgkQ3SOs138+
s6Fh6g/9FbL0/fnRgrih9AV+jp+ZV72gBwXFqTqt8pDjlWhAuSBEWMVhmOEN3ZlL
JiGpunNQHw+3kCtgqaRRb/wCzlSgrj4Ao2RdIPJen9L+l7h0cBI134A2WLsoyFHC
ydg3T+LjMoT/8XkLLl+kmDcA0qIWM+U1As8k0oGFzuXfeZ9CmUkXpntzOjcMGto9
OiEHr3nlPJJLNHp2aX9Sx66YDUQ/q2Fc3nHfIbfcdtrh4DVHfGJL4OShx3+iZHQe
oiI8Hv9Oq1KRh7kKD2jOhPwFZolot49aMuGJaStzgDaUygF7B7dxovtLpZdIuKcF
aFzO8xRnGWQappr/JMfiG5d6FcG+JcvSBe2OqrpEnkd+Xz8TvVktbjj85Rr1YcJh
uOnhsv5H1ZZuq6OYuYH+mjB6uep692dxjISm5Lk/TnKreWEA3d7/azmZG6Sbod6T
/DdacPKyCubCobcS1tCZADyPgEn50X1HZoqrl1vJqGsBhEtJ2FBF2rkeJWD8ACfE
8PieNokw/9Kp3F9Rk/Sa1smH7nXgoaw/RjXvQ03z/h63Ah4+JgVV5gQUwv9Hk0cU
Yi/Q1Du6hEyP1Gnt/BLW8YEzUsT62WDWJ0pa2r3zeZmsfrByv3RFNA9Ey1LTAPwd
LfXcOYcMjOo3pK2ZMCoZcK8GSs8Qb+sSUOiOMuMK/gEZVWM9028=
=RTJw
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
