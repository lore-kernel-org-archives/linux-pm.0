From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 1/4] power: supply: axp288_fuel_gauge: Fix
 fuel_gauge_reg_readb return on error
Date: Wed, 14 Dec 2016 18:01:32 +0100
Message-ID: <20161214170131.GA2302@katana>
References: <20161214163853.454-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2fHTh5uZTiUOsy+g"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161214163853.454-1-hdegoede@redhat.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Sebastian Reichel <sre@kernel.org>, Chen-Yu Tsai <wens@csie.org>, "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>, linux-pm@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 14, 2016 at 05:38:50PM +0100, Hans de Goede wrote:
> If reading the register fails, return the actual error code, instead
> of the uninitialized val variable;

Please don't CC the linux-i2c list for i2c client drivers unless you
have specific i2c related questions. It makes focussing on the core
parts harder.

Thanks,

   Wolfram


--2fHTh5uZTiUOsy+g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJYUXrrAAoJEBQN5MwUoCm2WEgP/15bWIyigtUWGkdQXGP3Jbh/
9wsilztQstY+hQkUz4g7JDJ+jIXxIEpYpKdl/9fXKICCIm7AORktnF/18aosFr0t
265IGZEkIGfePxm9aXoCbe/7kjfxmShzmy7ARWg5Q9E/ZB8l+MGGE9uDfPuvzItN
1w0g4M9e1JileiA8yKyjHvJjJADdxc8em8ISeHLmCC+n08hMaxtkaC3OE32h7aOb
8IoubRLCzMzdn/pGb5vPACbhdxrKpRhXoyWhiEUuCjp0j9nZCRExOsWH3eNdcrI4
7FNi+Ofq8K5i8usD+oPhw0E6JN27aqkbck2oK0TI6VTmWUa1fyqRaxR0lrW9HRDX
uKnL0574ZJcdxUaKQ35HOaL0vF9u718SwsxH+EA0mcCtpIn5J8FUAygmwMzbSuPz
TbgFU3QqsUO4PHyGtw/JI8R7ZPxVoWyaJJNApDL8NBTWEpkOLhjpRkzdSgu3x49O
GaY/NRMrnRQZidkD2ctqUmbd0ax+nHwoT13wYsNgESmk589G46vP8LMkAHYWPl2i
DJ9Syv98UFiznUCE86rRk80Ynlj3zqJqI3XM2hO1XOievNOFGlfxTf5fpKpvCUHZ
0WhBPw9AhcbMsTSbNNvZwSgjBERDqoDQNQ0MnZZhpwRfpTy1N3xlLpFPuTC4l94g
xnN8sY+MbWxjCcxcRQnR
=ge4N
-----END PGP SIGNATURE-----

--2fHTh5uZTiUOsy+g--
