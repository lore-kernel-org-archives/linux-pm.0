From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 3/3] dt-bindings: thermal: add binding document for h6
 thermal controller
Date: Fri, 17 May 2019 09:38:15 +0200
Message-ID: <20190517073815.e5h7obnzyaljj4xn@flea>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-4-tiny.windzz@gmail.com>
 <20190512134152.yrletgtiglxncyo4@flea>
 <CAEExFWvkM86ajB4io8yopkKEOfRE3UObRpqoi=Sq0RtDnuaRWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fxtyg6m4voydyy57"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEExFWvkM86ajB4io8yopkKEOfRE3UObRpqoi=Sq0RtDnuaRWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Lee <tiny.windzz@gmail.com>
Cc: rui.zhang@intel.com, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, catalin.marinas@arm.com, will.deacon@arm.com, David Miller <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan.Cameron@huawei.com, Nicolas Ferre <nicolas.ferre@microchip.com>, paulmck@linux.ibm.com, Andy Gross <andy.gross@linaro.org>, olof@lixom.net, bjorn.andersson@linaro.org, Jagan Teki <jagan@amarulasolutions.com>, marc.w.gonzalez@free.fr, stefan.wahren@i2se.com, enric.balletbo@collabora.com, Linux PM <linux-pm@vger.kernel.org>, devicetree@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infra>
List-Id: linux-pm@vger.kernel.org


--fxtyg6m4voydyy57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 17, 2019 at 02:13:58AM +0800, Frank Lee wrote:
> On Sun, May 12, 2019 at 9:41 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > Hi,
> >
> > On Sun, May 12, 2019 at 04:26:14AM -0400, Yangtao Li wrote:
> > > This patch adds binding document for allwinner h6 thermal controller.
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  .../bindings/thermal/sun50i-thermal.txt       | 32 +++++++++++++++++++
> > >  1 file changed, 32 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/thermal/sun50i-thermal.txt
> >
> > We're starting to convert to YAML for binding descriptions that will
> > allow to validate that all DT are properly using the binding. It would
> > be great if you could use it as well.
>
> What have been changed to this now?

This needs a YAML file instead of the text file you introduced.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--fxtyg6m4voydyy57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN5k5wAKCRDj7w1vZxhR
xVi+AQDjoz3LrnnFNDvlVcYVt1sSrswPkuViJuQuLmCuUtaAxAD/elWxrmZ+1PF9
BqQU0LtypLWGmBgeF++P6OPWQT10YQQ=
=3mNs
-----END PGP SIGNATURE-----

--fxtyg6m4voydyy57--
