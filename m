From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
Date: Thu, 13 Nov 2014 19:11:29 +0000
Message-ID: <20141113191129.GP3815@sirena.org.uk>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
 <20141107215751.GA4439@dtor-ws>
 <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
 <2882656.Dm8xnxDtKM@vostro.rjw.lan>
 <5464EF7B.6080402@ti.com>
 <20141113175449.GK3815@sirena.org.uk>
 <5465017F.5070303@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vrfVfoepbxkgzrHH"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36979 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933614AbaKMTNM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Nov 2014 14:13:12 -0500
Content-Disposition: inline
In-Reply-To: <5465017F.5070303@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


--vrfVfoepbxkgzrHH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 13, 2014 at 09:07:43PM +0200, Grygorii Strashko wrote:
> On 11/13/2014 07:54 PM, Mark Brown wrote:

> > No, it doesn't - probe() leaves the device powered (you can see the
> > driver interacting with the device before it enables runtime PM).

> What I've found there is:
> arizona_dev_init()
>  |- arizona_clk32k_enable()
>     |-pm_runtime_get_sync() if arizona->pdata.clk32k_src == ARIZONA_32KZ_MCLK1

> so it's added as "may rely"

No, that's adding a reference to stop it power down under runtime PM -
if runtime PM is inactive it will have no effect.

--vrfVfoepbxkgzrHH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZQJgAAoJECTWi3JdVIfQoZUH/2yAUFI4fzvH0DisLdPzURGQ
I767qdCLqc/EW5Jg42Gd8MNrPWvOvtatP10QOmHQqYwuSu3cdJlT4YTtWVJ9aLrS
wd4AAGIO5/7+/HBmSGhZ0v2uYFpiuLVEf06fBra7QW1GwVzK6rtdkqt20ZuUDadZ
OGxUuh6Bp7jf6MkGWiBSFGdviMKqu8eba+0G7K/EXnrbOfAR5cB+0IHrntAxY2fW
Qm22maal0uZFze9QiOEEfxYo1K4gafaGGySTQ7NUC3cb2gL2XfQtDpP4+extXpet
NuGXB8kK/wgdyM1XteIQZYQRafknKLhLjxcth8cqtY91k1JLzterO9FqDrjk1kY=
=UXIG
-----END PGP SIGNATURE-----

--vrfVfoepbxkgzrHH--
