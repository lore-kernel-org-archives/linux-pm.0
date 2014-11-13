From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the
 need_restore flag
Date: Thu, 13 Nov 2014 17:54:49 +0000
Message-ID: <20141113175449.GK3815@sirena.org.uk>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org>
 <20141107215751.GA4439@dtor-ws>
 <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com>
 <2882656.Dm8xnxDtKM@vostro.rjw.lan>
 <5464EF7B.6080402@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eT1ysk9TsGa0MHPp"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36867 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933383AbaKMR4b (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Nov 2014 12:56:31 -0500
Content-Disposition: inline
In-Reply-To: <5464EF7B.6080402@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


--eT1ysk9TsGa0MHPp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2014 at 07:50:51PM +0200, Grygorii Strashko wrote:

> I've checked few folders and below few drivers i found which rely or may =
rely on their
> .runtime_resume callback to be executed (It very hard to identify depende=
ncy for some of drivers):=20

> arizona-core.c

No, it doesn't - probe() leaves the device powered (you can see the
driver interacting with the device before it enables runtime PM).

--eT1ysk9TsGa0MHPp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUZPBoAAoJECTWi3JdVIfQeCsH/1ipgdws97zzVlInxBDRAzZV
mz+1KdzGwD5VfddJ/3CNbXNCfHi7uswSHgGDiXsfeF+NGiqwlYmcy3lD8hYIVdid
0Yflbv2CABvMeIFmZYs5atWl8DYFICBe7CVWhw4woBU5FLzCsiuuRjf8+6FII2Gd
l0tsDl+P9aFxzDk/MrJa19r7LmLCNWoP9vBYLK54ubkC6p+twlwsgHt5h7AJpImj
i61VRYcxDn1Dza0B8O6fZQ5JSFN20Ej7Wb7eJ+ypYDxX8HN9fJHfejUMdkCEMtap
Rj+puIQTcrguHk41BJmndaO0nUUa7EvHE6VjwY8NV4iO3YYAvPUwL+nnoF2859Q=
=h4OQ
-----END PGP SIGNATURE-----

--eT1ysk9TsGa0MHPp--
