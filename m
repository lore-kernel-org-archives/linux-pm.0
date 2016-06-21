From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v12 4/4] power: wm831x_power: Support USB charger current
 limit management
Date: Tue, 21 Jun 2016 12:03:32 +0100
Message-ID: <20160621110332.GC26099@sirena.org.uk>
References: <cover.1466497505.git.baolin.wang@linaro.org>
 <7dc384248d51b1de0df54909f3c5550584b31357.1466497506.git.baolin.wang@linaro.org>
 <878txyomue.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U58U7wle/RT11wuz"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <878txyomue.fsf@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, robh@kernel.org, jun.li@nxp.com, m.szyprowski@samsung.com, ruslan.bilovol@gmail.com, peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--U58U7wle/RT11wuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 21, 2016 at 01:30:49PM +0300, Felipe Balbi wrote:
> Baolin Wang <baolin.wang@linaro.org> writes:
> > @@ -607,8 +647,31 @@ static int wm831x_power_probe(struct platform_device *pdev)
> >  		}
> >  	}

> > +	if (wm831x_pdata && wm831x_pdata->usb_gadget) {
> > +		power->usb_charger =
> > +			usb_charger_find_by_name(wm831x_pdata->usb_gadget);

> the fact that you rely on strings and pass them via pdata is an
> indication that you don't have enough description of the HW. Seems like
> we need to come up with a set of DT properties which tie a charger to a
> UDC.

> I'm thinking a phandle would be enough?

The wm831x has no DT support currently.

--U58U7wle/RT11wuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXaR8CAAoJECTWi3JdVIfQjU8H/jog/hL42HAeCq/gDhwKrem0
+/uk7Vu/Vh6AWNkU9w4V0hX9++iLy5mlgBd24RYl9n5plu4DzpyJf/lwVUBGbDC4
CjOVb+LjQyG6deQU6R/SFHwSwHglNNn4Xe+2DrLeGZzgGkSdujcIj9cqIKQ9y+CW
tFzOS83/KEaS4FNYSFiF9YwycsCjL6wo6/oO4Mnwt2HmSb8zi2UrKaV5iKU0XY0g
2NgazRPqnMh2x50zeo2pO9IY1Scjd4hDWVDeG2VKwtmanKFd3w3oa2nG9IWWl67/
1s+xe6HgzzMWF2eee/54ErOhn8t7NS8aVyT/ESy8OuMKuqXE90qDWL8ZrfFxguU=
=BVSD
-----END PGP SIGNATURE-----

--U58U7wle/RT11wuz--
