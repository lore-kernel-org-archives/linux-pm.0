From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 06/11] i2c: core: Convert to dev_pm_domain_attach|detach()
Date: Sun, 21 Sep 2014 01:48:57 +0200
Message-ID: <2089327.LENgA8tdGF@vostro.rjw.lan>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org> <1411151264-16245-7-git-send-email-ulf.hansson@linaro.org> <20140920122318.GC3850@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20140920122318.GC3850@katana>
Sender: linux-acpi-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Chris Ball <chris@printf.net>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.co>
List-Id: linux-pm@vger.kernel.org

On Saturday, September 20, 2014 02:23:19 PM Wolfram Sang wrote:
> 
> --bAmEntskrkuBymla
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> Content-Transfer-Encoding: quoted-printable
> 
> On Fri, Sep 19, 2014 at 08:27:39PM +0200, Ulf Hansson wrote:
> > Previously only the ACPI PM domain was supported by the i2c bus.
> >=20
> > Let's convert to the common attach/detach functions for PM domains,
> > which currently means we are extending the support to include the
> > generic PM domain as well.
> >=20
> > Cc: linux-i2c@vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> Looks good to me, but I'd like to give Mika a chance to look at it,
> since he does ACPI with I2C. Adding to CC.

It is not applicable without the [4/9] in this series anyway.

> > ---
> >  drivers/i2c/i2c-core.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index 632057a..3cd8f11 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -279,10 +279,13 @@ static int i2c_device_probe(struct device *dev)
> >  	if (status < 0)
> >  		return status;
> > =20
> > -	acpi_dev_pm_attach(&client->dev, true);
> > -	status =3D driver->probe(client, i2c_match_id(driver->id_table, client)=
> );
> > -	if (status)
> > -		acpi_dev_pm_detach(&client->dev, true);
> > +	status =3D dev_pm_domain_attach(&client->dev, true);
> > +	if (status !=3D -EPROBE_DEFER) {
> > +		status =3D driver->probe(client, i2c_match_id(driver->id_table,
> > +					client));
> 
> Very minor: I think it is more readable to keep this in one line.

Agreed.

> > +		if (status)
> > +			dev_pm_domain_detach(&client->dev, true);
> > +	}
> > =20
> >  	return status;
> >  }
> > @@ -302,7 +305,7 @@ static int i2c_device_remove(struct device *dev)
> >  		status =3D driver->remove(client);
> >  	}
> > =20
> > -	acpi_dev_pm_detach(&client->dev, true);
> > +	dev_pm_domain_detach(&client->dev, true);
> >  	return status;
> >  }
> > =20
> > --=20
> > 1.9.1
> >=20
> 
> --bAmEntskrkuBymla
> Content-Type: application/pgp-signature; name="signature.asc"
> Content-Description: Digital signature
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1
> 
> iQIcBAEBAgAGBQJUHXG2AAoJEBQN5MwUoCm2E7EP/1ykOCTRgrozlYwdbXxO9X8Z
> b6ad23VambrSiQJTZcYheydiVW9qrXIsn8TQf1flWChXtkD06odQRy8tGN8Vw3MQ
> MTdhyB19x1Z0TMkdmcrbhohsRchjsaeMgcpCNklW8ul8nASuDjY9KUdhVfUaY07q
> O1zyZxrA5ykPCq/xP2gakHTTOrB6pj0zwOlDe4yQOd1hJcWrhX0/EBxY4DgvvQIr
> o05w2rdr+s6qCCgV3WSY9EJ0JBOqNhvvGpGnpZe6tms8e1RmrEnSil3piBC1nhHP
> LPeZr/ZHdoRbEgUPNnr/otLhufVeE5uMLu7FFhmZi3DTVXXVb+kMjE17C6XYc3mM
> DIumY2ubMBInCIZDjFZa0BvwuodKqkWrG5cmgimDw8VywhDfmCXm7Q1immbKZ0rw
> p9R4YHkBl5ii0KCyTSrf5M4+ksV80iplb4jmIwfmU0kKnOIan1fgkmyHXR/WN67M
> d6sZUpMsuCUNTRj7Axe6LdKuuQe/EbO9GC66umjxtckJIesM/BSHHgGAGqnxQolQ
> q/NnP2JBTVz6sSjoBRb+EMw5cri2Yb2M1Ak24nw+uoveiqBGGMuFFQGoHyV9UXVP
> zA0MaUKKESiwO1RIaqhYe5lRwIwFSUktD5s/yYQqKbSF0zGAeRn79O+U2ei7xI9a
> gv2ABkxPmYxBPoSf9y1B
> =izqF
> -----END PGP SIGNATURE-----
> 
> --bAmEntskrkuBymla--
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
