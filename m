From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] Introduce regmap infrastructure over Maxim/Dalas
 OneWire (W1) bus
Date: Fri, 26 May 2017 12:06:02 +0100
Message-ID: <20170526110602.jtvxf76abks4v3xf@sirena.org.uk>
References: <20170525174639.3191-1-minimumlaw@rambler.ru>
 <20170525174639.3191-2-minimumlaw@rambler.ru>
 <404871495743279@web24o.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zb4eob3qhd77w2li"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36132 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753457AbdEZLGU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2017 07:06:20 -0400
Content-Disposition: inline
In-Reply-To: <404871495743279@web24o.yandex.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--zb4eob3qhd77w2li
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2017 at 11:14:39PM +0300, Evgeniy Polyakov wrote:

> Frankly saying, your non-regmap version was so much simpler, smaller and cleaner.
> I wonder why did people force you to use regmap.

> Guys, please speak up, if you want driver authors to use THIS, it is really flawed.

> Sebastien, iirc it was your idea to use regmaps, what was the reason for this?

So, this is the first I've seen of this series but in general the main
reason for using regmap is that it allows best practice to be factored
out into common code both in terms of the I/O itself and also in terms
of framework code being able to provide regmap based helpers for common
operations so drivers need less code.  The cache code is also really
useful for a lot of devices, it's a performance boost for reads and is
well optimized for restoring device state if you don't care about
sequencing (this is where some of the MMIO users come from).  You also
get a bunch of debug support for free, things like the tracepoints and
debugfs files (those do work better if you describe the register map).

Looking at the code in the regmap patch I have to say I'm very surprised
if this is adding much complexity, usually moving to regmap is basically
a sed.

--zb4eob3qhd77w2li
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkoDBkACgkQJNaLcl1U
h9Acogf9Fa8zCh00TCsT+nLIpvX7xNlE0+QZrszLg5vmWNA8DK6TV5OQJoU84bzj
+4fPME7LbuZ6quWZEjjjd8/DUml+mKE9J+iVNlscqZm8M2GoRHZjpzQEaoZLWAxS
czB0kriwlxDDNcOpH7Kw4mKFeEFOGw8FmBgcgDq94DUVVQ2nW/+dTO/O2fIe8bIC
qRSAZT4YqZkGBJ+th0/KRIJrC7UPKgRdMH18g5Xftzq4kzXdLvkE+jB0PNgiE2ki
UGO5FS3B+0/J0cKaiP6nCyAYpL8NfWjFLhh4cRA+11m0KCXLFjUTkCR4gw+jP+5Y
Fh86ELLPsc2UPOg0Zz6ly7OXQfIiRg==
=Hc+E
-----END PGP SIGNATURE-----

--zb4eob3qhd77w2li--
