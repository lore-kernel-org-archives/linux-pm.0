From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v3 1/2] Documentation: Add sbs-manager device tree node
 documentation
Date: Tue, 19 Jul 2016 06:14:32 +0200
Message-ID: <20160719041432.GB1640@katana>
References: <1bIiDr-0004G1-0P>
 <1468349295-4935-1-git-send-email-karl-heinz@schneider-inet.de>
 <1468349295-4935-2-git-send-email-karl-heinz@schneider-inet.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1468349295-4935-2-git-send-email-karl-heinz@schneider-inet.de>
Sender: linux-acpi-owner@vger.kernel.org
To: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
List-Id: linux-pm@vger.kernel.org


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> +batman@0a {
> +    compatible = "lltc,ltc1760";
> +    reg = <0x0a>;
> +    #address-cells = <1>;
> +    #size-cells = <0>;
> +
> +    i2c@1 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;

Rob, aren't those two lines inherited from above?


--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXjakoAAoJEBQN5MwUoCm2qhQP/2aFO0ch+wWVsRAHz84bU2d6
VYYB7jzAunwZIbBhRUZDdycApy1PWqLI0Fiq2QFise7OFqvCFuDB5HxvM5Dt8qHq
rnpg2b5jKtjbWfhXp+QGUDyoWdI9qv5irPHXzilnwkBmK8BkLZ1khFpJ1NsIuqbW
6tmjBjFDr7WOYq3nkAREKTRRBHJM43usFHTVS0WWqbGMHouVBsgCPHp2IVn0gnk8
ng6UUsORBrYziM83V4upbIYRrlcrGHQd1sTnJYd0y6O/otD0WA/RqgWrK6eI5Ifx
PwpwgARRcYzkZ0FX3fRNI7EOezwfSH3+Le1Tr3d4WyDmSoDxsJH1cpGe0Sx2pLEx
/UEYTLiYYeS7UFctrFIn3VnF5AIZJQZvzuDVEnwAGY+qHFbsuYAAEJQ0R9dL8cwT
0w/e/VNnSE/W5bPeIySVQepBPUwOpm4TsS0kYnpBkbP+T3bhw/Fru0y6g0EzfSqA
74Foy1+t5z3P0XLQLkPKEkJqUkrH5LbaXiP5sookZqWEtzkybiq/tPrDbsmXW2o+
Dee5am5dukowJgiSyrpv5A78cMX9yP7j9HWHMOwuBLDJBO3ZbNbowpHnNRpNQvkr
AQI92E8pjZrQQJmDepb/V+ImntvvkN0r6CcLSEBk5R9yoFFGjK9EDQNTRDmqFV2S
kM2sjycRi1a8aNjdVj61
=29jR
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--
