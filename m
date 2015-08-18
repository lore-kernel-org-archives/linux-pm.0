From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 18 Aug 2015 09:07:18 -0500
Message-ID: <20150818140718.GA9143@saruman.tx.rr.com>
References: <cover.1439519412.git.baolin.wang@linaro.org>
 <f3bfd04bc157e97e2d0632b7ed2452f366f66488.1439519413.git.baolin.wang@linaro.org>
 <20150817010707.GC1864@shlinux2>
 <20150817172623.GO10748@sirena.org.uk>
 <20150817235816.GA5621@saruman.tx.rr.com>
 <20150818050405.GE10748@sirena.org.uk>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150818050405.GE10748@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Peter Chen <peter.chen@freescale.com>, Baolin Wang <baolin.wang@linaro.org>, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2015 at 10:04:05PM -0700, Mark Brown wrote:
> On Mon, Aug 17, 2015 at 06:58:16PM -0500, Felipe Balbi wrote:
> > On Mon, Aug 17, 2015 at 10:26:23AM -0700, Mark Brown wrote:
> > > On Mon, Aug 17, 2015 at 09:07:08AM +0800, Peter Chen wrote:
> > > > On Fri, Aug 14, 2015 at 05:47:46PM +0800, Baolin Wang wrote:
>=20
> > > > > +	if (wm831x_pdata && wm831x_pdata->usb_gadget) {
>=20
> > > > Where the wm831x_pdata->usb_gadget is initialized?
>=20
> > > It's platform data, it will be initialised by whatever registers the
> > > platform data.
>=20
> > passing pointers through pdata ?
>=20
> It's a char * to a name, not a pointer to struct.

aha, fair enough.

--=20
balbi

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0zwWAAoJEIaOsuA1yqREQ7EP/RdQUIYRs81mewGq2+rKgACC
SMbaAM10m/yizNBH045hRv97eUsg2VoOxVHQ3XA7R0ApvfaFwZiLu+D5dbXGJUem
pXA8FX8l12dUqyAoxPBjfkcLfXOpOF965J8e6Xhaptcn/Yb9O2rwBGsPRoM6o8Xk
nWb9ReLYHgLes634C/4FTSPyGGT3P40UbQMALCO/uHdncbjaEhg60XoSma2jaySI
OLfLiTeyDAPvb7xmMk4XxG97SvSV624J5XrWUlSyBFDlR2YxvAtfgoonhGclbMuu
EGdr7tPZz1Bj4YoFUIulzADnO15+6WQzDuVonf9YzlWGRIQV1/to420w8w4yHH4q
dsRNg1urzU5lG+/pNHIbqXr95atPSkMuVbwHz25zlMlX+gU9AwAX/6Wb41Vl0DkZ
BIgLZjkND2AwStviIk4ylXdo53gRfjMoVb0tKpluJ7qK021tEa/P6EPRwCQIQQOo
3sLkiP7U/micU0cn4Mcg+6J3t5M8HywsLlStGm4/xXLqpXTFj5RKxFTb3b3ASt9u
gmxrh/BYGmKxYd0qboAN7+7KOGisuk2rRYYbuI4anrRSF7sLMj9FacVm+w1K1mHk
bbqJquDVmgX+VYTzYUBc4NwD0uLtvIJW2GdXKxB7d6tHacm8Jg9TiFUEeU3EmtCY
2WLpQ+EAUeyjcIMgsTHJ
=1PCQ
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
