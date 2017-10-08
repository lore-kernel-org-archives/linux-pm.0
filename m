From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 0/2] detect identical chip data arrays
Date: Sun, 8 Oct 2017 23:26:10 +0200
Message-ID: <20171008212610.kdnsr7bcuitvmedc@earth>
References: <1507490321-24900-1-git-send-email-Julia.Lawall@lip6.fr>
 <20171008203258.y7kqx7ipondxlsix@earth>
 <alpine.DEB.2.20.1710082243140.2160@hadrien>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fsh4555bxuekk5ei"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45686 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbdJHV0P (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Oct 2017 17:26:15 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1710082243140.2160@hadrien>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Liam Breck <liam@networkimprov.net>, pali.rohar@gmail.com, Linux PM mailing list <linux-pm@vger.kernel.org>, kernel-janitors@vger.kernel.org, Joe Perches <joe@perches.com>, Gilles Muller <Gilles.Muller@lip6.fr>, Nicolas Palix <nicolas.palix@imag.fr>, Michal Marek <mmarek@suse.com>, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, kbuild test robot <fengguang.wu@intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>


--fsh4555bxuekk5ei
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Oct 08, 2017 at 10:44:50PM +0200, Julia Lawall wrote:
> On Sun, 8 Oct 2017, Sebastian Reichel wrote:
> > Hi,
> >
> > On Sun, Oct 08, 2017 at 09:18:39PM +0200, Julia Lawall wrote:
> > > Rename battery.cocci as check_bq27xxx_data.cocci and adjust the warni=
ng
> > > messages to indicate that some structures are the same, in response to
> > > feedback from Liam Breck.
> > >
> > > Although check_bq27xxx_data.cocci says is requires Coccinelle 1.0.7, =
which
> > > is not yet released, it actually works with the version currently ava=
ilable
> > > on Github, eg from Coccinelle commit 3ba77b3a0f91.
> >
> > I think the rename makes sense, but I would expect the move to
> > happen in one go with "git send-email -M", so that it detects the
> > rename.
>=20
> I'm not actually sure what is the status of the previous version.
> Masahiro said applied, but I downloaded his tree and it was not there.  So
> I thought this way would be easier.
>=20
> julia

Ok. In that case it makes sense to just apply the one with better
name of course :) Thanks for the script!

-- Sebastian

--fsh4555bxuekk5ei
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlnal/EACgkQ2O7X88g7
+pr6rQ/8DI5O5Up9d3GlgJ1eAm5gCaZTb80pYTxHYS/oxnfjZN93zoh7IJTLr5CF
2ZCMrh5WREyPSr945NOngGEUqSwIllAGdARadwC/smjbLAu+s/+xB53zsWXaiZTH
DmEW6KYs1cHqASjwdkZi8gg1kLJ1TINDIVAe3XpMsvV5U5NpOejnBRx/rDi8ORtJ
tTBiRL1MK+iiAa6aXMlpduqxTbrVhoT9T8JQg2W2S+uFbuwRGL/puor6J+7wh24N
NiL7AnRhofIbzYRgTxxFYgXX5gq4Wxvnkf93HF2q84zVDMW5E0U7I4oZbHyU/n56
9HyTC391xHysdDR4YTzq9ozh5qVb/NB4olHCZmK4j6hCjbBlEErtF1kGmnK4KRJO
ke4SpGYO9EaEG/2QdDPLGdpI+BHVpGybeJTc+gMZUiBvBVwYSbnZztidiIcZTVN/
cAbrL9yLLX+lnef+MbaG5rQgkOZLRaHOihjGHoOBZHgcwrBdo514ZVO2aScCEpsI
54Jo/1yu7Dxpc3r0WQzIIkKBz8sVwWa7B/Yqrya91oiPZZg5a0bJgaAnLtpF77WE
TNaa0XMy2M0jv9DjQAFB+erHwk2rOJH0sZgEboBl/uWN6L8vYhuCZ31FQ+oPgNlw
/K4u9DEw/I83Lk0igPNtZG79NE/mu6ha9Icn+X9pcRZhxIUHAhs=
=i+ea
-----END PGP SIGNATURE-----

--fsh4555bxuekk5ei--
