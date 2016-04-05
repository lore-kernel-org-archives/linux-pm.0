From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v9 0/4] Introduce usb charger framework to deal with the
 usb gadget power negotation
Date: Tue, 5 Apr 2016 10:01:53 -0700
Message-ID: <20160405170153.GE1924@sirena.org.uk>
References: <cover.1459494743.git.baolin.wang@linaro.org>
 <20160405064637.GA31351@shlinux2.ap.freescale.net>
 <CAMz4kuKWpFLbYJM+m3syT+aMNVxjBipU_3=qwz=X0L_oB5bR0w@mail.gmail.com>
 <20160405081222.GC31351@shlinux2.ap.freescale.net>
 <CAMz4kuJAq0RGsqz5XoKOft_DKGTDXscwenPp97Drbm79ON49=w@mail.gmail.com>
 <20160405094320.GA6301@shlinux2.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45468 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbcDERCU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2016 13:02:20 -0400
Content-Disposition: inline
In-Reply-To: <20160405094320.GA6301@shlinux2.ap.freescale.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Felipe Balbi <balbi@kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 05, 2016 at 05:43:20PM +0800, Peter Chen wrote:
> On Tue, Apr 05, 2016 at 05:34:02PM +0800, Baolin Wang wrote:

> > Mark, could you please address Peter's comments about if the the
> > wm831x can charge more than 1500mA for DCP? (I have no environment to
> > test wm831x) Thanks.

> I don't want you or Mark to test at hardware, I just would like to see
> some code that how PMIC, wm831x, and USB gadget driver work together.

If you want to see this running it's going to be easier for you to just
write an equivalent driver that just does a print instead of writing to
a register (which is all that the wm831x driver boils down to) and test
on hardware you have in front of you.

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXA++AAAoJECTWi3JdVIfQda4H/in01TtmiEra/8YzHOWYWRan
VpI/CJet5JgWzhirBht56L1rpFqY+wOk/C95JqMIWu1xdqvUVvS6b+WLb98ynsDx
+wVdt7gs8TzIulcqJFg08yyIzMqwm7lMcoAlIWhceEl3FrEkvUFdtyKeMJcYMhWp
f1aeoGpKj9OzGemkF0Y+JmoIzrpc+eBgLoJm9/z/T2QdCL6z1Y7E1T3LtbWgrxlJ
JJh+a4psfYh+G1tIDmxbpf/lG1f/Vh/aBpHum781/8m5R7XhY4WFkrPAe7u9iyv9
SkXg0ga4H8xsGyaTQJr+fb8pn7ILHkch9RjeL2n9WS9vqUKQaD6lnQIfX6IiNKQ=
=9WW+
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
