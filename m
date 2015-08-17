From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] power: wm831x_power: Support USB charger current
 limit management
Date: Mon, 17 Aug 2015 10:26:23 -0700
Message-ID: <20150817172623.GO10748@sirena.org.uk>
References: <cover.1439519412.git.baolin.wang@linaro.org>
 <f3bfd04bc157e97e2d0632b7ed2452f366f66488.1439519413.git.baolin.wang@linaro.org>
 <20150817010707.GC1864@shlinux2>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NbUNL4d9A9kY58qh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150817010707.GC1864@shlinux2>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Chen <peter.chen@freescale.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, balbi@ti.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, sojka@merica.cz, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, sameo@linux.intel.com, lee.jones@linaro.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--NbUNL4d9A9kY58qh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2015 at 09:07:08AM +0800, Peter Chen wrote:
> On Fri, Aug 14, 2015 at 05:47:46PM +0800, Baolin Wang wrote:

> > +	1500,
> > +	1800,
> > +	550,
> > +};

> Why 550 is the last, but not 1800?

You'd have to ask the hardware engineers who designed the chip.  I
suspect it's because 550 was added at a late stage in the design process
but I'm basically just guessing there.

> >   *********************************************************************/
> > @@ -606,8 +646,31 @@ static int wm831x_power_probe(struct platform_device *pdev)
> >  		}
> >  	}

> > +	if (wm831x_pdata && wm831x_pdata->usb_gadget) {

> Where the wm831x_pdata->usb_gadget is initialized?

It's platform data, it will be initialised by whatever registers the
platform data.

--NbUNL4d9A9kY58qh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV0hk+AAoJECTWi3JdVIfQ+UsH+wbg5YAcmiwGvgK5ha7iBYv3
X/tf8J+VEfeEz/MPEzgtFWpTAjOYL6ZrIfODxbh9LJvrzdazSUXBokSuywc/SWk3
1JZbKtJwDiv0OS5OziKFnJVf+iMmLVh3rsaUFaga3gU+3yjtSRjw5fCKM5aq1vmd
vLQqiaXQS7kYUb2gJbgYb7IwpbklzCjuogVgxmSfkxnySuTICNusAZmR6SZwpLdr
y7q9X2MNu3gaTKjO3Lj0ZFvvGOqxv026CAa16cqHWfOjlf4kmQ0oBuaH/HAEfy3U
CWJr+uQVEC3nYbu5t1k6aAveFm1p4JqkaDWMjjvOUsGkkopFlQ4rd9dSSywA1fI=
=ZWNJ
-----END PGP SIGNATURE-----

--NbUNL4d9A9kY58qh--
