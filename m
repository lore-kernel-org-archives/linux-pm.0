From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 2/3] power: mxs_power: add driver for mxs power
 subsystem
Date: Tue, 27 Jan 2015 19:43:46 +0000
Message-ID: <20150127194346.GN21293@sirena.org.uk>
References: <1416514477-19190-1-git-send-email-stefan.wahren@i2se.com>
 <1416514477-19190-3-git-send-email-stefan.wahren@i2se.com>
 <20150121230148.GJ13715@earth.universe>
 <54C0AFE4.3020701@i2se.com>
 <20150125150431.GE2719@earth.universe>
 <1719204322.245040.1422301605670.JavaMail.open-xchange@oxbaltgw03.schlund.de>
 <20150127001629.GP21293@sirena.org.uk>
 <1954124242.301697.1422383709733.JavaMail.open-xchange@oxbaltgw09.schlund.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9S80siGrzvaEFf+2"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1954124242.301697.1422383709733.JavaMail.open-xchange-h4m1HHXQYNE54XbDmwzAWMgmgJlYmuWJ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--9S80siGrzvaEFf+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 27, 2015 at 07:35:09PM +0100, Stefan Wahren wrote:
> > Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> hat am 27. Januar 2015 um 01:16 geschrieben:

> > > okay i understand. But doesn't it need a extra driver to set the switching
> > > frequency because of the new compatible string?

> > I don't understand this bit at all, sorry.

> Sebastian suggested a new sub-node in the devicetree:

>     powerpll {
>         compatible = "fsl,imx28-power-pll"
>         #clock-cells = <0>;
>         clock-frequency = <12345>;
>     }

> and i think that the new compatible string needs a separate driver to take care
> of the switching frequency.

I can see that this has been suggested, what I can't understand is why
we would wish to do this but I am missing some context here which may
make it all perfectly clear.

> Or is it okay to leave the handling of the switching frequency in the mxs-power
> driver?

Unless the clock is exposed externally to the regulator either as an
input or an output I'm not sure I see any benefit but I'm possibly
missing something here.  It does sound like there might be a separate
clock IP or something?

> Btw if we add a new node to set switching frequency, i think it would be better
> to describe the dc-dc convertor and not the pll:

>     dcdc {
>        compatible = "fsl,imx28-dcdc"
>        frequency = <12345>;
>     }

> What do you think?

Yes, just adding a new property on the regulator node with all the other
properties seems sensible (we've just gained some helpers which make it
fairly straightforward to do this).

--9S80siGrzvaEFf+2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUx+pxAAoJECTWi3JdVIfQufsH/2nL+BdexM7wi7TiGYWV1r9h
0/WHg4o+XtCHjs67ojegIUBQH2JHBVBjdl1ER1qoBLr1ZvP4z0wbYwcdse58EzUB
MHUOM4xYY1q3MNh/I/er+aQ+q/iOAf7nBKU8nAdfgsOjtQA2uwBiLqEO/z/E3tB3
2NVYKem2mGvqKsSz5Yg+saZvwATlrgJgNkxNwW686xQX3qKgEaJKMgTaxi+P6XPw
ui9yVyOSqD6cF6xhr5NAxsixM5/r8qVaFus/g+V913uK8lvAuUzhT3YQ43u+Qksw
GEm2n/IGdafwsg7irU5kfwTvziVwy8xc+IjLj7mbqWtjMmqzE3eJM9D+g0VKGP8=
=5LyK
-----END PGP SIGNATURE-----

--9S80siGrzvaEFf+2--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
