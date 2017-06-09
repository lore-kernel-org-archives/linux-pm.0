From: Paul Kocialkowski <contact@paulk.fr>
Subject: Re: [PATCH 5/5] power: supply: bq27xxx: Correct supply status with
 current draw
Date: Fri, 09 Jun 2017 09:16:01 +0300
Message-ID: <1496988961.1319.1.camel@paulk.fr>
References: <20170430182727.24412-5-contact@paulk.fr>
         <20170528191619.GA20159@xo-6d-61-c0.localdomain>
         <1496249719.1774.1.camel@paulk.fr> <20170531173207.GA10763@amd>
         <1496258936.2038.8.camel@paulk.fr> <1496819733.927.16.camel@paulk.fr>
         <20170607075218.GA6268@amd> <1496848839.5534.7.camel@paulk.fr>
         <20170607195023.GA4083@amd> <1496916532.12882.2.camel@paulk.fr>
         <20170608192733.pry6ydf5auyaepyw@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/UD5T+arvtez3zasbxVc"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gagarine.paulk.fr ([109.190.93.129]:55906 "EHLO
        gagarine.paulk.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbdFIGQR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Jun 2017 02:16:17 -0400
In-Reply-To: <20170608192733.pry6ydf5auyaepyw@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, "Andrew F . Davis" <afd@ti.com>, Chris Lapa <chris@lapa.com.au>, Matt Ranostay <mranostay@gmail.com>


--=-/UD5T+arvtez3zasbxVc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeudi 08 juin 2017 =C3=A0 21:27 +0200, Sebastian Reichel a =C3=A9crit :
> Hi,
>=20
> On Thu, Jun 08, 2017 at 01:08:52PM +0300, Paul Kocialkowski wrote:
> > > > On Wed, 2017-06-07 at 09:52 +0200, Pavel Machek wrote:
> > > > > > [0]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.
> > > > > > git/
> > > > > > comm
> > > > > > it/?
> > > > > > h=3Dv4.12-rc4&id=3D7f93e1fa032bb5ee19b868b9649bc98c82553003
> > > > >=20
> > > > > Is there some documentation that explains what different power su=
pply
> > > > > statuses mean? Because without that, we can have long and useless
> > > > > discussions.
> > > >=20
> > > > Well, I couldn't really find much except the following from
> > > > Documentation/
> > > > (which is not that helpful, and the BATTERY_STATUS_* don't seem to =
exist
> > > > anymore):
> > > >=20
> > > > " STATUS - this attribute represents operating status (charging, fu=
ll,
> > > > discharging (i.e. powering a load), etc.). This corresponds to
> > > > BATTERY_STATUS_* values, as defined in battery.h. "
> > > >=20
> > > > Generally speaking, I think the question to be asked is what inform=
ation
> > > > users
> > > > will be interested in in each scenario we have to consider.
> > >=20
> > > Hmm. We really should add some documentation :-(.
> >=20
> > Maybe we should start a new thread about this to give it more visibilit=
y.
> > That way, PM maintainers could weigh-in and share thoughts.
> >=20
> > I definitely agree there is a need to clarify what we want to report to
> > userspace given the various scenarios we've been discussing.
>=20
> +1 for extension and update of documentation. If its known, that
> the battery is trickle charged, it should report FULL. No need
> to annoy people by constantly updating the status. Think of it
> being mapped directly to a status LED. Of course the CURRENT/ENERGY
> properties should still be updated, so that anyone interested in
> the details can see them.

Agreed. Do ou think there is a need to start a specific discussion about
various scenarios and how to handle them or do shall we just use common sen=
se
here?

--=20
Paul Kocialkowski, developer of free digital technology and hardware suppor=
t

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
--=-/UD5T+arvtez3zasbxVc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEAbcMXZQMtj1fphLChP3B6o/ulQwFAlk6PSIACgkQhP3B6o/u
lQwzug/+NspBxPrBPMQXkj1tlhKVQefu+3pfTSVSXtWQ4xqotbEAyYpp/njgN6dt
iNN6UrsJttVfcZSdsFP+6lC/ey63bH6wZMLpEyq8kLhUlJ289Xs8jHIjsqso7oMC
L6BpCSyvotPb2jzigsq+EAECrFbCckQm7S4Rrp50WjpJFpOSwWEq3hV5IL4nNjti
gC5fCNW0/4UneI5c2zYZRIbQMP5ehyKpx+e/VQ8iY4y8LQyWpsSJToVjeBJH8pdW
SMUmb1MAa/sDD4F6lFsH2b6b/dSj0uWmstvyZlgue3Wcv051MLmy8AUq0kEEOvXl
hzy8Jg5mcY1uwjdnysdrxS/MzGM6s91fPQHnNBd9EEy//oPmodtLF5ymPcvAd12R
9vP99Q7tDbVzwOPG86PPFDIme3o/c1CcIx83oDyvg5YCHVAe5qJSA7g1OchDlFzH
YgyIDEip+yl4PllbbTSbqPe2DFAJ6nF8IrRBkgQOFHEabhPQrohttY58uAVR5tA1
Vx8xol7twAYBYz7pBXTnzzcnmCFQmpT5cSL2IPF2FcJHDCuPe0t94rsssNRdL9Gh
QTdX27key8WM3ZBPwlNZvwycVe7DhKPVZED9HwbNLobgweUCpZ8bKQL0b67FI0HB
A/EmFt9qenNNqcO1Wlo5HnAzW8n1tbFYyL6gSWlE7SRhy6rkJSQ=
=OI69
-----END PGP SIGNATURE-----

--=-/UD5T+arvtez3zasbxVc--
