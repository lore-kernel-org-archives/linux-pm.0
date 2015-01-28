From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Wed, 28 Jan 2015 23:59:38 +0100
Message-ID: <20150128225937.GA12749@earth.universe>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe> <54C0AFE4.3020701@i2se.com>
 <20150125150431.GE2719@earth.universe>
 <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150127001629.GP21293@sirena.org.uk>
 <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de>
 <20150127194346.GN21293@sirena.org.uk>
 <443299280.47516.1422483725178.JavaMail.open-xchange@oxbaltgw03.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1666247968187865887=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <443299280.47516.1422483725178.JavaMail.open-xchange@oxbaltgw03.schlund.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Marek Vasut <marex@denx.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Kumar Gala <galak@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org


--===============1666247968187865887==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 28, 2015 at 11:22:05PM +0100, Stefan Wahren wrote:
> > Mark Brown <broonie@kernel.org> hat am 27. Januar 2015 um 20:43 geschri=
eben:
> > On Tue, Jan 27, 2015 at 07:35:09PM +0100, Stefan Wahren wrote:
> > > > Mark Brown <broonie@kernel.org> hat am 27. Januar 2015 um 01:16
> > > > geschrieben:
> >
> > > > > okay i understand. But doesn't it need a extra driver to set the
> > > > > switching
> > > > > frequency because of the new compatible string?
> >
> > > > I don't understand this bit at all, sorry.
> >
> > > Sebastian suggested a new sub-node in the devicetree:
> >
> > > powerpll {
> > > compatible =3D "fsl,imx28-power-pll"
> > > #clock-cells =3D <0>;
> > > clock-frequency =3D <12345>;
> > > }
> >
> > > and i think that the new compatible string needs a separate driver to=
 take
> > > care
> > > of the switching frequency.
> >
> > I can see that this has been suggested, what I can't understand is why
> > we would wish to do this but I am missing some context here which may
> > make it all perfectly clear.
>=20
> The relevant register DC-DC Miscellaneous Register (HW_POWER_MISC) is des=
cribed
> in chapter 11.12.10 of the reference manual [1].
>
> [1] - http://cache.freescale.com/files/dsp/doc/ref_manual/MCIMX28RM.pdf

Having a look at the datasheet my suggestion for the sub-node
doesn't make sense. I missunderstood how the hardware architecture
looks like, sorry for the noise :(

> changing the switching frequency is not a common feature for this IC. In =
most
> cases the clock for the DC-DC switching frequency runs at 24 MHz (ref_xta=
l).
> Unfortunatelly this could cause interferences for example in UHF band. So
> switching to ref_pll and changing clock divider is a option to avoid such
> interferences without changing hardware.
>
> I decided to implement it as a module parameter, because i see it's a
> configuration option.

I think its best to use a DT property then. That way it can be set
appropiatly for boards known to use a band, which could have
interference problems.

So just add a simple property (without a subnode). If I understand
Mark correctly, there's a high chance more drivers will need to
describe the switching frequency, so I suggest to use a vendor
independent property name:

switching-frequency =3D <12345>;

-- Sebastian

--wac7ysb48OaltWcw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUyWnXAAoJENju1/PIO/qaQ9YP/j8+hSDHXuHvx895UVtcA3Qx
Cv2JE3LZchHgubIt/VL9yB65Qz8HxwafsG/94N9Ry3ZTnBCMGZiBtcBY3TH4jkcC
qunliXVgu5IRYav5diQIgZjmuh0nsWelAkefmbWclDmdtPX5qX4LtkjWQ9ZxPjF6
2lnC0wf8WYra5QKAOxC1MhzcuuizF8vrshagjT08m7z+YlX9Pz+SXvVOOi/Bi+3l
g2P8SBrgbUq7uRXDbMHG+WoTPC0rkjqrIrvkVW8T0pUlpjyRKIWPZ9bVqCeQ8RJT
iwvTlTPKl6qjSLmedvdaLmMiBLhngY6nbbF0J48PGK57/0P6PnUn0szsmG5w4/bh
T58U2mCmHWD0fUMCUbB6JrgN4tzkWRQ6x7Py7hWzZQ41htihUXWFvU8vYt0zlyQE
/cmGD5C5ep0HUUEJYpZDntpvY6VsuYDUM6BiaI1qgqEQc0bU8UoVMzavkrKwbi3w
l7tWdYetlZC233IynmmK6kRhQ88O9cENVidwqmKiWWKHRm6oofkHUBlbncoLnnTu
svPAbLD3HCVnfQ17khG5PwNXhIFd2TDnQKNZvVNrSsesBpuujASKWoI1PNawqYEJ
yAnOVVYRMRaxe/2TeRYEjUWU3OaG0ZwAosKnpDVcfeUWsZ7J+46xYA6u5tQADaup
w6JDCBL5LNE6ZregTUcB
=vbXr
-----END PGP SIGNATURE-----

--wac7ysb48OaltWcw--


--===============1666247968187865887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============1666247968187865887==--
