From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/3] thermal: sun50i: add thermal driver for h6
Date: Fri, 17 May 2019 09:31:51 +0200
Message-ID: <20190517073151.mz6hcmzubk7iqfre@flea>
References: <20190512082614.9045-1-tiny.windzz@gmail.com>
 <20190512082614.9045-3-tiny.windzz@gmail.com>
 <20190512133930.t5txssl7mou2gljt@flea>
 <20190512214128.qjyys3vfpwdiacib@core.my.home>
 <20190516150252.hf4u3bloo37chy6q@flea>
 <CAEExFWu-T2mGQ9Teo7TQOcJsEzXi_dB=S8CFv7MiwHyu5z4-ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lfvwzxrwqixjwfma"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAEExFWu-T2mGQ9Teo7TQOcJsEzXi_dB=S8CFv7MiwHyu5z4-ow@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Frank Lee <tiny.windzz@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, catalin.marinas@arm.com, will.deacon@arm.com, bjorn.andersson@linaro.org, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, paulmck@linux.ibm.com, stefan.wahren@i2se.com, Linux PM <linux-pm@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jagan Teki <jagan@amarulasolutions.com>, Andy Gross <andy.gross@linaro.org>, rui.zhang@intel.com, devicetree@vger.kernel.org, marc.w.gonzalez@free.fr, Eduardo Valentin <edubezval@gmail.com>, enric.balletbo@collabora.com, robh+dt@kernel.org, Jonathan.Cameron@huawei.com, Linux ARM <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, olof@lixom.n
List-Id: linux-pm@vger.kernel.org


--lfvwzxrwqixjwfma
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2019 at 02:10:47AM +0800, Frank Lee wrote:
> > On Sun, May 12, 2019 at 11:41:28PM +0200, Ond=C5=99ej Jirman wrote:
> > > > > +static int tsens_get_temp(void *data, int *temp)
> > > > > +{
> > > > > + struct tsensor *s =3D data;
> > > > > + struct tsens_device *tmdev =3D s->tmdev;
> > > > > + int val;
> > > > > +
> > > > > + regmap_read(tmdev->regmap, tmdev->chip->temp_data_base +
> > > > > +             0x4 * s->id, &val);
> > > > > +
> > > > > + if (unlikely(val =3D=3D 0))
> > > > > +         return -EBUSY;
> > > >
> > > > I'm not sure why a val equals to 0 would be associated with EBUSY?
> > >
> > > Thermal zone driver can (will) call get_temp before we got the
> > > first interrupt and the thermal data. In that case val will be 0.
> > >
> > > Resulting in:
> > >
> > >  (val + offset) * scale =3D (-2794) * -67 =3D 187198
> > >
> > > 187=C2=B0C and immediate shutdown during boot - based on cirtical
> > > temperature being reached.
> > >
> > > Busy here means, get_temp does not yet have data. Thermal zone
> > > driver just reports any error to dmesg output.
> >
> > Ah, that makes sense.
> >
> > I guess if we're switching to an interrupt-based driver, then we can
> > just use a waitqueue, or is get_temp supposed to be atomic?
>
> I think get_temp should not be bloacked.

Why not?

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--lfvwzxrwqixjwfma
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXN5jZwAKCRDj7w1vZxhR
xRjwAQCF+RoytL/Gdpf15Jq+KQoPxEwYs/XaBIKW6ehF38tr0QD/T1i40/vfptIH
f1vUZGQCwcHvI4eTbggzXinFNG1BsAM=
=UQjS
-----END PGP SIGNATURE-----

--lfvwzxrwqixjwfma--
