From: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] power: reset: add linkstation-reset driver
Date: Thu, 22 Dec 2016 15:49:24 +0100
Message-ID: <20161222144924.gidgzk2ujpvlti3t@earth>
References: <20161207172415.9776-1-rogershimizu@gmail.com>
 <20161216100501.18173-1-rogershimizu@gmail.com>
 <20161219153802.vhcish35qyjbpevj@earth>
 <CAEQ9gEnQEHdcA4ox3teOXKcrdf2AAqUMp=A6W6c7nXhk4VrKiw@mail.gmail.com>
 <20161221155929.o4ihvqezbuqx2stl@earth>
 <20161221164136.GM30952@lunn.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7xihjzukwrsipi7j"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161221164136.GM30952-g2DYL2Zd6BY@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Cc: Roger Shimizu <rogershimizu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ryan Tandy <ryan-pRYBVO4bdZ33fQ9qLvQP4Q@public.gmane.org>, Martin Michlmayr <tbm-R+vWnYXSFMfQT0dZR+AlfA@public.gmane.org>, Sylver Bruneau <sylver.bruneau-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>, Herbert Valerio Riedel <hvr-mXXj517/zsQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--7xihjzukwrsipi7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Wed, Dec 21, 2016 at 05:41:36PM +0100, Andrew Lunn wrote:
> > These models can just be added to qnap-poweroff, which handles
> > exactly this special case as far as I can see.
>=20
> Nope, qnap is much, much simpler. The configuration of the serial port
> is simpler, and it only needs to send a single byte. Here we have all
> sorts of checksums to calculate, stuff coming back from the
> microcontroller, etc. The complexity is much higher.
>=20
> V1 of this patchset did extend the qnap driver. But in fact, very
> little of the original code was left afterwards, and lots of new code
> was added. So i requested a new driver be written, rather than extend
> my qnap driver.
>=20
> I would not like to see the nice and simple qnap driver get all this
> code added to it, making it much harder to maintain, for very little
> gain.

I'm talking about the special case, where it also sends only a
single byte:

> +     /* send the power-off command to PIC */
> +     if(cfg->cmd[0][0] =3D=3D 1 && cfg->cmd[1][0] =3D=3D 0) {
> +             /* if it's simply one-byte command, send it directly */
> +             writel(cfg->cmd[0][1], UART1_REG(TX));
> +     }

The configuration is different, but

a) probably it can just use the config from the qnap driver, since
   it just sends a single byte.
b) making the 4 config registers configurable in the qnap driver does
   not add much complexity.

So this case should be removed from the linkstation-reset driver. If
any board needs it, it should use the qnap-poweroff driver instead.

-- Sebastian

--7xihjzukwrsipi7j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlhb5/EACgkQ2O7X88g7
+ppFSA/6AqEACcYm11SCQZ1b0wi7YK54i8yiZes2kRNN5d9ehekA77cMO1IF1o+K
+SSAsQRmW97wJsw3LewX/Br7hIl7aC0hYhYvgcsl0sd/CxyIAvpF4WtRCQPRCMzv
uZX8n7g70x4PiDQfmGHrOz2nehjPJzhm8bZIabPWIdf4WvJxPurkNmkOoOhZBDIS
4WpdQxEg/6+nd2wjKFgWw2En4XM16YZTFX/wH+LBEVy++jmOQVWk1xPS3qoc/Kge
Z+T4VdaIzXd0AuXWGdJA1yw0d9CYuUvP6ZBdZCAVyik3UjwrdOQbEjnJqEzaEkWr
/EWf2YWaBAc+7frO3vBXtdFgZUoafSTfYx6Lp5fswajxoqNUMJzIPHSCb+5vG+P5
k85WoixXIvsvzcjPXcZY5OTwkdaxFm+mUcqTABLX5pTQKev7Sw+qfGz/KVzSZ4iP
VXtgk/Twyp+HloZqGrEEJdnfhReblCbPiPYWXCpaaF5bqtdDqC2ePToDhD+Coaq4
FEgY6DA6YOs3+u8RH1GsnnM+YNpBxyQg+Ba21LT6PUAtCvLY5lI21zqS5t1ixTty
KedQT0nlCeUdWT1jj5Lnu8jT9BD13gKIQX/hFJiWxW4yyyZMtRZNdFjP4DcNfHEc
b63nfhOzzQXVQgPQeszhD9XtOu3o86kT0GwQi9RNYfbAS9V8qPE=
=0jPP
-----END PGP SIGNATURE-----

--7xihjzukwrsipi7j--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
