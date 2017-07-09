From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [RFC v1 3/6] power: supply: bq27xxx: Enable data memory update for certain chips
Date: Sun, 9 Jul 2017 17:12:34 +0200
Message-ID: <201707091712.34705@pali>
References: <20170709021700.14354-1-liam@networkimprov.net> <201707091107.44653@pali> <CAKvHMgQ0D6DRz8Ckk4st+5uYZybXfAQtGq=wZ3Bgz4RuaNZV_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2326916.yd0Wru5mQ7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f170.google.com ([209.85.128.170]:36247 "EHLO
        mail-wr0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750910AbdGIPMh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 9 Jul 2017 11:12:37 -0400
Received: by mail-wr0-f170.google.com with SMTP id c11so106837424wrc.3
        for <linux-pm@vger.kernel.org>; Sun, 09 Jul 2017 08:12:37 -0700 (PDT)
In-Reply-To: <CAKvHMgQ0D6DRz8Ckk4st+5uYZybXfAQtGq=wZ3Bgz4RuaNZV_g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, Paul Kocialkowski <contact@paulk.fr>, Liam Breck <kernel@networkimprov.net>

--nextPart2326916.yd0Wru5mQ7
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 09 July 2017 16:13:59 Liam Breck wrote:
> Hi Pali,
>=20
> On Sun, Jul 9, 2017 at 2:07 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>
> wrote:
> > On Sunday 09 July 2017 04:16:57 Liam Breck wrote:
> >> From: Liam Breck <kernel@networkimprov.net>
> >>=20
> >> Support data memory update on BQ27500, 545, 425, 421, 441, 621.
> >> With exception of BQ27425, these are only enabled #ifdef DEBUG,
> >> as they are not tested.
> >>=20
> >> Signed-off-by: Liam Breck <kernel@networkimprov.net>
> >> ---
> >>=20
> >>  drivers/power/supply/bq27xxx_battery.c | 164
> >=20
> > Why under #ifdef DEBUG? Seems that this is misusing DEBUG which is
> > used for other things.
>=20
> This is a temporary measure, as those definitions are not tested on
> their chips. Nothing new happens in debug mode unless
> monitored-battery is set in driver's DT config, and it's either a
> ram-only chip or the dt_updates_nvm config option is set.
>=20
> If DEBUG isn't ok in this case, alternative suggestions?
>=20
> Thanks for your input!

DEBUG can be enabled by other kernel option and should provide just more=20
debugging functionality. But you are adding non-debug functionality=20
under #ifdef DEBUG, which basically is "new experimental untested=20
feature".

Better way for "experimental feature" would be introduction of other=20
kconfig switch or probably runtime module option...

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2326916.yd0Wru5mQ7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlliR+IACgkQi/DJPQPkQ1LodgCfRxLkj/9w0SJvG3jC59LjiFe1
1tIAn0qqpwvOKmMVzPxNecNKKNS94n4o
=nZVj
-----END PGP SIGNATURE-----

--nextPart2326916.yd0Wru5mQ7--
