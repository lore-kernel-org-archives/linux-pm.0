From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 1/4] gadget: Introduce the usb charger framework
Date: Thu, 31 Mar 2016 10:06:35 -0700
Message-ID: <20160331170635.GH2350@sirena.org.uk>
References: <cover.1458128215.git.baolin.wang@linaro.org>
 <11ce6df3eb8a95cfed26f3321f15c98a934db642.1458128215.git.baolin.wang@linaro.org>
 <87h9foqnur.fsf@intel.com>
 <CAMz4kuJ=StEMsdHgX6n6wi13bs3CZ+9GYXBvdZ5mu+giSmnWdg@mail.gmail.com>
 <87poubgnbh.fsf@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cvGDtX8LmIpY177y"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87poubgnbh.fsf@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Felipe Balbi <balbi@kernel.org>
Cc: Baolin Wang <baolin.wang@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


--cvGDtX8LmIpY177y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 31, 2016 at 09:42:58AM +0300, Felipe Balbi wrote:
> Baolin Wang <baolin.wang@linaro.org> writes:

> > I want to use bus structure to manage the charger device. Maybe choose
> > class to manage them?

> I guess a class would fit better in this case.

IIRC Greg didn't want new classes?

--cvGDtX8LmIpY177y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW/VkXAAoJECTWi3JdVIfQl7gH/1s/PaRrULTRDmeJo4GQGrje
04wdHfe7x67qLUEs/qn+sWPXNHcCV2pfr1+aBJPI+zugIFsA5yeH3bs2CfwzMo3r
sDCULmbSEmY958A3J5SgyX3MdXABklwKBZx9aPyEwNHK2EonW22FjPla1GTYsMtA
bOMIQ5UztDXLS3DxNNs5V53Ykp6HQuCcYg2AlfOESbHV6hEJ1vFjxh3gK7QKTPj+
WRmMsHkBkGStq/01ClE6I3jzh27U5PGkPeb3Gz+Fpn7a+FS7/f7ooAJZFqVSF9tL
E4Q9GO17dWsw7ErDTGTTpyiQEGh+oOSM9sYMssUXpFsYuNTYTmeDDfFCW89V2Uo=
=YJIq
-----END PGP SIGNATURE-----

--cvGDtX8LmIpY177y--
