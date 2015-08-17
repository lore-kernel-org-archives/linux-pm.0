From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/3] gadget: Introduce the usb charger framework
Date: Mon, 17 Aug 2015 10:24:16 -0700
Message-ID: <20150817172416.GN10748@sirena.org.uk>
References: <cover.1439519412.git.baolin.wang@linaro.org>
 <0c41e21239f69c4e1aa89aba020c91edfc17c4e8.1439519413.git.baolin.wang@linaro.org>
 <20150814152723.GA17892@kroah.com>
 <CAMz4kuL=6mGjNHcKHA9RYbabYqn3Lgu=rK6s8WkH5YGeV1T2+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Gtf2ElYKiUa3nI7m"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuL=6mGjNHcKHA9RYbabYqn3Lgu=rK6s8WkH5YGeV1T2+w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Felipe Balbi <balbi@ti.com>, Linus Walleij <linus.walleij@linaro.org>, LKML <linux-kernel@vger.kernel.org>, Peter Chen <peter.chen@freescale.com>, sojka@merica.cz, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, sameo@linux.intel.com, Lee Jones <lee.jones@linaro.org>, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--Gtf2ElYKiUa3nI7m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2015 at 11:03:26AM +0800, Baolin Wang wrote:
> On 14 August 2015 at 23:27, Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Aug 14, 2015 at 05:47:45PM +0800, Baolin Wang wrote:

> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.

> > I have to ask, do you really mean "any later version"?

> I think I did not get your point, could you explain it detailedly?

Unlike a lot of userspace projects the kernel is normally just licensed
under GPLv2 without the option to relicense with a later version so the
"...or any later version" is a bit unusual.  There is some controversy
about some of the changes in GPLv3.

--Gtf2ElYKiUa3nI7m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0hi8AAoJECTWi3JdVIfQuxAH/j5dwlDhPL0T8Xl752bQ0uph
MveUIVTv9mrFzX6B2Ld5PInhWVogcC+cGXyMCwmsBQqyP2sFe/qizvjyX5p16ZCY
KV215jP5Q7pn/1Htt5Q1eFs4Dw0EWEdiq9xi2tltq/FfRdHQxPYFzeNB8M5B7Dmg
1jTqtIUTtDvEKt4CihIc65X51AT1T+FgSTDb2jMgo8M/r2V5eFcFJaB6bdoSvONG
wiGiNvrVPQXIdABPYdNggT3blqXzU2uscV5NY2uiS/PF0l7JuQoVsY3mbVRJ2/pM
xvAZX4dHpsS+zKRw53mCJF/NCf7CpHtX/No20Ac7aqT2vGmJqc1yIU8LHsbrV7o=
=KGRN
-----END PGP SIGNATURE-----

--Gtf2ElYKiUa3nI7m--
