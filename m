From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 17/32] greybus: power supply driver
Date: Fri, 7 Oct 2016 15:49:02 +0200
Message-ID: <20161007134902.GC19976@amd>
References: <20160914100949.GA6179@kroah.com>
 <20160916064058.GA17821@kroah.com>
 <20160916141058.GE1252@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:49404 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbcJGNtG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 09:49:06 -0400
Content-Disposition: inline
In-Reply-To: <20160916141058.GE1252@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Johan Hovold <johan@hovoldconsulting.com>, Rui Miguel Silva <rmfrfs@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sandeep Patil <sspatil@google.com>, Matt Porter <mporter@kernel.crashing.org>, John Stultz <john.stultz@linaro.org>, Rob Herring <robh@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Alex Elder <elder@linaro.org>, David Lin <dtwlin@google.com>, Bryan O'Donoghue <pure.logic@nexus-software.ie>, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, Mark Greer <mgreer@animalcreek.com>


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri 2016-09-16 16:10:58, Greg KH wrote:
>=20
> This driver implements the Greybus power supply class protocol.

Probably

POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
M:      Sebastian Reichel <sre@kernel.org>
M:      Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
M:      David Woodhouse <dwmw2@infradead.org>
L:      linux-pm@vger.kernel.org

should be cc-ed?

> +static int is_cache_valid(struct gb_power_supply *gbpsy)
> +{
=2E..
> +	if (gbpsy->last_update &&
> +	    time_is_after_jiffies(gbpsy->last_update +
> +				  msecs_to_jiffies(cache_time)))
> +		return 1;

Are you sure?
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlf3p84ACgkQMOfwapXb+vLClwCgiXOe0Kt+kJRvGN13QD6ImiYz
viQAnApIEi3DRy/A9EI+KAZQthMQFC6x
=tXru
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
