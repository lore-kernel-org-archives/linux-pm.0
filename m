From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] On-demand device probing
Date: Mon, 19 Oct 2015 17:04:00 +0100
Message-ID: <20151019160400.GD32054@sirena.org.uk>
References: <561E1378.6000906@collabora.com>
 <20151017065750.GA18607@kroah.com>
 <20151018192931.GY14956@sirena.org.uk>
 <20151018193757.GA9147@kroah.com>
 <20151018195330.GB14956@sirena.org.uk>
 <1445247881.53393.146.camel@infradead.org>
 <CAL_JsqKehmSobpbdeXGo=-1pAbtrhCHovyyCWya_MNOhGCi8CQ@mail.gmail.com>
 <1445258870.53393.173.camel@infradead.org>
 <20151019145048.GI14956@sirena.org.uk>
 <1445268580.53393.183.camel@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1445268580.53393.183.camel@infradead.org>
Sender: linux-clk-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Russell King <linux@arm.linux.org.uk>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@linux.ie>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Wolfram Sang <wsa@the-dreams.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Kishon Vijay Abraham I <kishon@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Felipe Balbi <balbi@ti>
List-Id: linux-pm@vger.kernel.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2015 at 04:29:40PM +0100, David Woodhouse wrote:
> On Mon, 2015-10-19 at 15:50 +0100, Mark Brown wrote:
> > > But the point I'm making is that we are working towards *fixing* that,
> > > and *not* using DT-specific code in places where we should be using t=
he
> > > generic APIs.

> > What is the plan for fixing things here?  It's not obvious (at least to
> > me) that we don't want to have the subsystems having knowledge of how
> > they are bound to a specific firmware which is what you seem to imply
> > here.=20

> I don't know that there *is* a coherent plan here to address it all.

> Certainly, we *will* need subsystems to have firmware-specific
> knowledge in some cases. Take GPIO as an example; ACPI *has* a way to
> describe GPIO, and properties which reference GPIO pins are intended to
> work through that =E2=80=94 while in DT, properties which reference GPIO =
pins
> will have different contents. They'll be compatible at the driver
> level, in the sense that there's a call to get a given GPIO given the
> property name, but the subsystems *will* be doing different things
> behind the scenes.

I'd expect that to be the norm rather than the exception.

> > It seems like we're going to have to refactor these bits of code when
> > they get generalised anyway so I'm not sure that the additional cost
> > here is that big.

> That's an acceptable answer =E2=80=94 "we're adding legacy code here but =
we
> know it's going to be refactored anyway". If that's true, all it takes
> is a note in the commit comment to that effect. That's different from
> having not thought about it :)

Given the above I'm not even sure it's legacy code, it's just as likely
we're going to get some parallel ACPI code added to the subsystems for
parsing their bindings.

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJRRvAAoJECTWi3JdVIfQ94UH/3aeK5/TtlRVjiyNRBStuDIK
YfKZ694j90Jc2zzqmDGj9oSxEhaJ/7TRVwTUiMOAhqWA0CSbf3cBs/DIs+g+Az8V
3zxpk3/tyo8IAPXq1K5jH0JZ4CHE5ZYFB4m1svX16yAqq8zfcHY5EHj9wzBgxguX
uch4SsAk/SXtkQLxcvQnGhoetpBixwvtRB2V9rjc1BfDL5Gg9+swKsJT7gO/ijcX
hPLmFKwf7HJQ/7epPIr4b2wyN++CTrknboN0Mzkh+OaWgL8mMrbXhLLe+EqXshyc
4EubfdtrFtdMq1Yu2UqgQzS/QjMU3pO7X1QZG02th+w09YzWFy7TlFOUpU9O2X4=
=VsPa
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
