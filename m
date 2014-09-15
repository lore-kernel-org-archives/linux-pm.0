From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 3/7 v6] power: reset: driver for the Versatile syscon
 reboot
Date: Mon, 15 Sep 2014 18:06:31 +0200
Message-ID: <20140915160630.GA19960@earth.universe>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
 <1410176286-32533-4-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbE8z3N_7FQzooVsd=UvUeoRhPqO5=foTGn7U=ag0ML9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:37576 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbaIOQGn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 15 Sep 2014 12:06:43 -0400
Content-Disposition: inline
In-Reply-To: <CACRpkdbE8z3N_7FQzooVsd=UvUeoRhPqO5=foTGn7U=ag0ML9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh@kernel.org>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 12, 2014 at 10:55:19AM +0200, Linus Walleij wrote:
> On Mon, Sep 8, 2014 at 1:38 PM, Linus Walleij <linus.walleij@linaro.org> =
wrote:
> > This driver enabled us to drive the reboot of the Versatile family
> > of ARM reference boards. Even though only the RealView boards are
> > supported initially, these boards all have the same procedure for
> > reboot:
> >
> > - Write a magic value into an unlocking register
> > - Write another magic value into a reset control register
> >
> > The driver will be reusable for Versatile and possibly also the
> > Integrator family of reference boards.
> >
> > Cc: Sebastian Reichel <sre@kernel.org>
> > Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v1->v2:
> > - Do not probe from a platform device, instead use a device_initcall()
> >   and look up the syscon device from its node. If that device is
> >   not yet registered, the call will be deferred. This is done so that
> >   the Linux driver model is not reflected into the device tree, as
> >   the reboot property of the syscon is not a separate device.
>=20
> Can any of the power maintainers please ACK this patch if it
> looks OK, so it can be pulled in through ARM SoC?

Sorry for the delay:

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUFw6GAAoJENju1/PIO/qa/5gP/1/mANjT74n6efoS/vG6+U2n
vr/wC9rIvN3x2yXf86wNusjguMjOZgo/C9u27KzCPM+peyCBqqi1GDA+/4eWpSw+
ygGelfGAUcLKhUGNa+RTltUFXIbReu/SOfjNllZzGjCRa9H36Cho6z/7FlleMGxj
TtNlQcDQwqYqIOHnEQVu2JiXRIZ4d26ZGRKCtXoJnL2ZzvjAUyrCCoMUaYC6j/eU
ctzzkW6nQpVUAWTKmxo8sjSkbe9T9ZybaDF7tIEE+E2xRHN2gfRuUK8a6nHiiqiO
3mw3y+jzvaHDlsFlQIXlnNxlsKiS/0XxwMwys1wCPcxgoeWeb59/6PSGA5eIBlvX
IFigLYaPWFn54GDbEm9joX8jN1NDy6TNwybei0b58PD/x3sce3JzzasZUAmcF5i2
y8DAsJTE1v4PLTl5A/gUGV6vbRU7aD8ZA5RcIMs0/mRCf3Au5ND9O5yk18tXAe5x
X2TB5mV0srcgplfYz/PrByH8mBSZM1m/R8yF3WpbM5GfrCU/Q1izN94jBorttZ+P
eQTsX9UE4Z8RCYWx3LVZdbho30fYstxyz8u58xXhNj3omdnMYtmHa8aKgpBaH/Bv
NY7AwxKPjAwmZXNPiIkszdN5mhLr9AN4x2Few+ulK53Y2pjhuuYd1G0KWKdpf5+0
7M7hDKRuDmTWVAFGYcbQ
=xt/A
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
