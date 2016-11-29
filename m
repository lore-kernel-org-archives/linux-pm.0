From: Wolfram Sang <wsa-dev@sang-engineering.com>
Subject: Re: [PATCH v3 2/4] thermal: rcar_gen3_thermal: Add R-Car Gen3
 thermal driver
Date: Tue, 29 Nov 2016 09:32:42 +0100
Message-ID: <20161129083241.GA1458@katana>
References: <20161128210924.2921-1-wsa+renesas@sang-engineering.com>
 <20161128210924.2921-3-wsa+renesas@sang-engineering.com>
 <20161129020652.GA3701@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:39584 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754940AbcK2Icq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 29 Nov 2016 03:32:46 -0500
Content-Disposition: inline
In-Reply-To: <20161129020652.GA3701@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Eduardo,

> No commit message ? :-( generally speaking here, it is a good practice
> to describe what you are doing, what you have considered, and what you
> have tested, just for the sake of code history/documentation.

OK, can do.

> > +	spin_lock_irqsave(&tsc->lock, flags);
>=20
> Why do you need a full blown spin lock irqsave? Can this locking be
> solved by a simple mutex?

Currently, it can be a mutex, yes. This is a "left-over" from the
version which had interrupt support. I am not fully done with
refactoring the irqs, but I thought it is likely we need this lock then
again, so I chose to leave it. I can use a mutex for now if you prefer.

>=20
> > +static void r8a7795_thermal_init(struct rcar_gen3_thermal_tsc *tsc)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&tsc->lock, flags);
> > +
> > +	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  CTSR_THBGR);
> > +	rcar_gen3_thermal_write(tsc, REG_GEN3_CTSR,  0x0);
> > +
> > +	udelay(1000);
>=20
> Why do you disable irqs, then busyloop for 1ms?

Uh yes, this is ugly. I don't think we need to lock during init, but
I'll double check later.

> > +	/* default values if FUSEs are missing */
> > +	int ptat[3] =3D { 2351, 1509, 435 };
> > +	int thcode[TSC_MAX_NUM][3] =3D {
> > +		{ 3248, 2800, 2221 },
> > +		{ 3245, 2795, 2216 },
> > +		{ 3250, 2805, 2237 },
> > +	};
>=20
> are these fuses valid for both? 7796 and 7797? or would you need a
> different array for each version?

According to the information I have today, it is the same array. And all
later versions are promised to have fuse registers. This is already
documented, but such HW is not available to me currently.

Thanks for the quick review, very much appreciated!

   Wolfram


--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYPT0pAAoJEBQN5MwUoCm2rfYQAIK/VcjG6s31xxNCVyaV+Tqb
gXNSoj0GBYeu8qPbzoAgBY13NN6Qkh3hcHZ8Fm5eTuJbMhm9B/V+fQKq3k7YqK6z
CWcBqQDQdBCsUgl81e2BgGYvKYXM4CapIbUBvBkSIStpOSbVIlM/Cf/k3Z4Hxlzm
43d+w6NOw/4o41wu+xfChyTbuXvUWWPvlUtMZ598LnwkEhG+AmSlMKVlYGO2lGjk
lf7lNcv0tFsx7AooPYIheKmvnathzWBkZtYnWusJ2FtgkJ8DQAqeCyJleULT2fcz
Clw6qysmTwfnPLawsZ6Lq3Slfw/AZvLRgU/OoEdstILhND7Ci7TpZ7eQQGfA68Cr
AHoAB+B0/97LN+cM+D8lMbAbLlWEecDbgBLllDPnEhRrbrMOY0rcU81bwR7caY6j
2vZJvrD8w+M67fIvMzoIDmwUYDZfXBTRD7heQULgcnoy4laEDqmZxdlciUSuhfm4
wyzIKvIgxYnLkJiB/viyZ8nDeDupfzVgoyuESbxW2Pe3Xh6J+TpnxNsjDnThNn9c
qiMOsXhp3yiF1r4mGHSL6ZkF/enFxHe9WBijlX2rsbJX4nYkzwGT+TP6UmKj+aoZ
w8LtMODMzyYEn8EY07IxXiFZGdh/6249Y2d0rPF5b9mnphS6QQTMTjw0S5STyRgi
A9qasfkqhS9xxqhDRpg4
=qlvS
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
