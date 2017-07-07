From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] Introduce regmap infrastructure over Maxim/Dalas
 OneWire (W1) bus
Date: Fri, 7 Jul 2017 18:11:20 +0100
Message-ID: <20170707171120.vgiw62sobwnq6jbu@sirena.org.uk>
References: <20170525174639.3191-1-minimumlaw@rambler.ru>
 <20170525174639.3191-2-minimumlaw@rambler.ru>
 <404871495743279@web24o.yandex.ru>
 <20170526110602.jtvxf76abks4v3xf@sirena.org.uk>
 <3411811495806312@web49j.yandex.ru>
 <20170526171834.uq4ke5cm5qtobxgl@sirena.org.uk>
 <4265821495830391@web12o.yandex.ru>
 <20170628193750.jh4vbl4x32rzvcng@sirena.org.uk>
 <939401499441188@web18j.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="frpmabkkgdef7gpd"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51168 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdGGRLh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jul 2017 13:11:37 -0400
Content-Disposition: inline
In-Reply-To: <939401499441188@web18j.yandex.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--frpmabkkgdef7gpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 07, 2017 at 06:26:28PM +0300, Evgeniy Polyakov wrote:

> In fact, regmap-w1 brings virtually nothing to w1 from regmap point fo view -
> code is more complex and even a bit more error prone, but we found a nice feature,
> that we do not have to export IO functions anymore, they will be hidden behind
> regmap wrappers.

It's not for the benefit of the bus, it's for the benefit of the devices
on the bus and their subsystems.  From the point of view of the
subsystem it shouldn't have any impact at all, it's a helper library for
the layers above.

--frpmabkkgdef7gpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllfwLcACgkQJNaLcl1U
h9DW5wf/ZrWncYiq0veCK7YaO2BPPZbGsoIXHTbY12kW81LSYWW7qU9kB8RxU4kZ
Sn03vIhASJT8tAZejBhtJgue34KEmMAq7vlQqsqVbVGWUoZuinXlavFj80BDmFeW
g7PltVXkDFeT+1Jhn7USj8X2BIE/qZyb1U1KP+EBzvA1c/KiH/rFEEueTCCqZ2mg
EGHa8bstex7brR1z1mINjDPofhf3dsB1GYpZlR4pGtfVVkSDiduPQf3kyyUWdcBv
75zX+PKx+dGEphmv01bOOvNL+GfOhLqEQdVzn21geJsP/FPgCVhWk9gYlg1ybxk8
XBBb3q7ClEX0lFVYwEFH+0G3SlVqSQ==
=OiDz
-----END PGP SIGNATURE-----

--frpmabkkgdef7gpd--
