From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v4 0/2] cpufreq: Add sunxi nvmem based CPU scaling driver
Date: Wed, 17 Apr 2019 10:31:16 +0200
Message-ID: <20190417083116.xgwglxogy2zqdghh@flea>
References: <20190416155209.24216-1-tiny.windzz@gmail.com>
 <20190417020830.f5empr3rr3ifbstl@vireshk-mac-ubuntu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ctpou35gd6hfomxj"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190417020830.f5empr3rr3ifbstl@vireshk-mac-ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yangtao Li <tiny.windzz@gmail.com>, vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, rjw@rjwysocki.net, davem@davemloft.net, mchehab+samsung@kernel.org, gregkh@linuxfoundation.org, nicolas.ferre@microchip.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--ctpou35gd6hfomxj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 17, 2019 at 07:38:30AM +0530, Viresh Kumar wrote:
> On 16-04-19, 11:52, Yangtao Li wrote:
> > Add sunxi nvmem based CPU scaling driver, refers to qcom-cpufreq-kryo.
> >
> > Yangtao Li (2):
> >   cpufreq: Add sunxi nvmem based CPU scaling driver
> >   dt-bindings: cpufreq: Document allwinner,sun50i-h6-operating-points
> >
> >  .../bindings/opp/sun50i-nvmem-cpufreq.txt     | 167 +++++++++++++
> >  MAINTAINERS                                   |   7 +
> >  drivers/cpufreq/Kconfig.arm                   |  12 +
> >  drivers/cpufreq/Makefile                      |   1 +
> >  drivers/cpufreq/cpufreq-dt-platdev.c          |   2 +
> >  drivers/cpufreq/sun50i-cpufreq-nvmem.c        | 226 ++++++++++++++++++
> >  6 files changed, 415 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/opp/sun50i-nvmem-cpufreq.txt
> >  create mode 100644 drivers/cpufreq/sun50i-cpufreq-nvmem.c
> >
> > ---
> > v4:
> > -I removed this sunxi_cpufreq_soc_data structure for now.
>
> Why this change ?

It's used on a single SoC for now, so it's impossible to know at this
point what to put in that structure in the first place.

Of course, that would need to be brought back if we ever have two SoCs
to support and that we know which differences there is.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--ctpou35gd6hfomxj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXLbkVAAKCRDj7w1vZxhR
xQuXAP9pgWjpdSjA5KIXPG6IT9T+tbepvXBNmEhSWg7XEt34TAD9EkkRr/+OKOJe
gGXx9J8+DZeXBERfyeRaRvOAbZdrKw0=
=91iH
-----END PGP SIGNATURE-----

--ctpou35gd6hfomxj--
