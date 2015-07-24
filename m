From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2] power: max17042_battery: add HEALTH and TEMP_*
 properties support
Date: Fri, 24 Jul 2015 16:46:51 +0200
Message-ID: <20150724144651.GE27569@earth>
References: <1432438918-31002-1-git-send-email-ramakrishna.pallala@intel.com>
 <CAJKOXPeUvdC5LwRLgsFfxz2=SZwkjq2soGius+j6kb76Ea940A@mail.gmail.com>
 <CAJKOXPepZ9gKtnKk7Z4BFjUk=_kv6j010dZWhhu9bf_OuVmrgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yb+qhiCg54lqZFXW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33902 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151AbbGXOq4 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 24 Jul 2015 10:46:56 -0400
Content-Disposition: inline
In-Reply-To: <CAJKOXPepZ9gKtnKk7Z4BFjUk=_kv6j010dZWhhu9bf_OuVmrgQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ramakrishna Pallala <ramakrishna.pallala@intel.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, MyungJoo Ham <myungjoo.ham@samsung.com>


--Yb+qhiCg54lqZFXW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 23, 2015 at 09:58:41AM +0900, Krzysztof Kozlowski wrote:
> 2015-06-08 10:22 GMT+09:00 Krzysztof Kozlowski <k.kozlowski@samsung.com>:
> > 2015-05-24 12:41 GMT+09:00 Ramakrishna Pallala <ramakrishna.pallala@int=
el.com>:
> >> This patch adds the support for following battery properties
> >> to max17042 fuel gauge driver.
> >>
> >> POWER_SUPPLY_PROP_TEMP_ALERT_MIN
> >> POWER_SUPPLY_PROP_TEMP_ALERT_MAX
> >> POWER_SUPPLY_PROP_TEMP_MIN
> >> POWER_SUPPLY_PROP_TEMP_MAX
> >> POWER_SUPPLY_PROP_HEALTH
> >
> > I wonder, have you tested the patch? After booting on Trats2 device
> > (max77693 which identifies itself as 17047-like) the values are:
> > POWER_SUPPLY_TEMP_ALERT_MIN=3D1280
> > POWER_SUPPLY_TEMP_ALERT_MAX=3D1270
> > POWER_SUPPLY_TEMP=3D257
> > This is okay, datasheet says that register after booting will have
> > value of 0x7f80.
> >
> > However setting them to some value which should trigger interrupts
> > (like 300 for MIN or 200 for MAX) does not trigger the interrupt. I
> > added a printk in max17042_thread_handler().
> >
> > Is the temperature alert feature working?
>=20
> Can you reply to my question above?
> If this feature is not working, then it should be removed.

What's the status of this? I cannot test the feature, since
I don't have the hardware. I agree, that this should be
removed, if it's not working.

-- Sebastian

--Yb+qhiCg54lqZFXW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVsk/bAAoJENju1/PIO/qannoQAJjO7qym/hthTLsEEzuw3FbU
xaOcorXwfaXWZCdYSYXe2SUCnoYCNy0PnDszrBgap1GIe8dpICVuK0lICddSpi+u
K/7WEnBEd3sMubHckNLsQJ2wKFHawC+MAtYNvsFBj/8OGeQ/1+qxlm+NpGZ1WNiE
d0nPa6TckJPyiCfnsvjrwdudrvW41rHOQLyyuxLHQS6+ZHFMrxaSdtZdGNKvMgYA
P5sEjFU6n6WYGgdlMY3WF2oL7/dI8Sb7X4DqwwkC7VpjnR3hqXILRsClJ9QnFcwu
lF8fzwunQeohK5TD2Ho5x8+T6qB8d6XArpMDjtBuUiKdt4lJdj/MaIVqS/hozN4y
h2eUBt/mpxHmoxpybXrgZf29Xovop25svt3pPiIBXoWNg+GJ/vX1zwspfAQ3sW+O
IQD/nslirOr8Cw8Y87uMoa6pD14NRAxWvJOnA3aUloh/EyLZiBN3tfnl1mK3kPKd
5qVkzQmhX+YkFoibn6o5ossy6j5DrUz29NmYJ+xMnT8dsWzhDBFT+p2sdXhq+3Xk
L3i4wc38HAv7bkiKEPo8c8jdKY5EFrbY5q+6ItJS3aemAakUSNE9NRlPs9YU08hb
fZxTO4zY++WUshMrPqsFPcJW5AhgC07Q9BpOLVapGBucgeDmE2fmuh1xbi/1X3Bi
HltBoDCjo8stCGJFujZs
=rI7H
-----END PGP SIGNATURE-----

--Yb+qhiCg54lqZFXW--
