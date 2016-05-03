From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v10 4/4] power: wm831x_power: Support USB charger
 current limit management
Date: Tue, 3 May 2016 11:57:18 +0100
Message-ID: <20160503105718.GL6292@sirena.org.uk>
References: <cover.1462245638.git.baolin.wang@linaro.org>
 <80aa73ffd5c8e9ae8cd280d37f5141067e79c11f.1462245638.git.baolin.wang@linaro.org>
 <CAKDJKT46cJQbjdObUxBpWsciG1FjcL8CdV7iAeMefjNQPGicKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xjamM5M9kpPM/bcu"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44282 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbcECK6E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 May 2016 06:58:04 -0400
Content-Disposition: inline
In-Reply-To: <CAKDJKT46cJQbjdObUxBpWsciG1FjcL8CdV7iAeMefjNQPGicKA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Manish Badarkhe <badarkhe.manish@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, balbi@kernel.org, gregkh@linuxfoundation.org, sre@kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, Lee Jones <lee.jones@linaro.org>, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


--xjamM5M9kpPM/bcu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2016 at 09:30:48AM +0530, Manish Badarkhe wrote:
> On Tue, May 3, 2016 at 9:00 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> > +static const unsigned int wm831x_usb_limits[] = {
> > +       0,
> > +       2,
> > +       100,
> > +       500,
> > +       900,
> > +       1500,
> > +       1800,
> > +       550,
> > +};

> Just for curiosity, How these current limits are getting decided?
> Can we have some proper defines over here so that it can be grasped easily?

They're in the silicon, it's just a table of values that were put into
the silicon at design time.  The defines would just be TABLE_ENTRY_1 or
whatever.

--xjamM5M9kpPM/bcu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXKIQJAAoJECTWi3JdVIfQBIoH/2xbZ/KEd4BBBQSDs6mOswQg
hjYS5DKEeK1zYDl1U1Cq5QA5FfAZePuMldRIsUr3FR5adlMfB3FatmYPjjW6AHnO
HAP38pIanV2ZQapc0PMOl9b0989FKZnJjUT6p03XI92km0COjKaw7JW3F8/id5kQ
nuaH2UBXYY5wy2P7wbVsI+Zm7wk5V/lNL9j+tDgU5xTMrgdR0o47PBySYpViqApP
WjrhfI4lXXvH5PfW/nZaznoPQCrzHc0hAZYJj/GiSSWbQbiuuZqjeyP7I7aTPAyK
/8cp8UIbXT8kX1P2Bhk6l461ivoy69LQGII0SXphRvH+rWARzA6mNqksuf16GtA=
=xc3b
-----END PGP SIGNATURE-----

--xjamM5M9kpPM/bcu--
