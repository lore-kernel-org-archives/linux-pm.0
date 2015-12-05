From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] drivers: power: set IRQF_ONESHOT if no primary handler
 is specified
Date: Sat, 5 Dec 2015 01:43:10 +0100
Message-ID: <20151205004310.GE22936@earth>
References: <1447917179-9333-1-git-send-email-saurabh.truth@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:34537 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094AbbLEAnP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Dec 2015 19:43:15 -0500
Content-Disposition: inline
In-Reply-To: <1447917179-9333-1-git-send-email-saurabh.truth@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Saurabh Sengar <saurabh.truth@gmail.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Thu, Nov 19, 2015 at 12:42:59PM +0530, Saurabh Sengar wrote:
> If no primary handler is specified for threaded_irq then a
> default one is assigned which always returns IRQ_WAKE_THREAD.
> This handler requires the IRQF_ONESHOT, because the source of
> interrupt is not disabled.

Thanks, queued.

-- Sebastian

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWYjMeAAoJENju1/PIO/qam3MP/R6ORSvt1fXgHnS0WGers6Qz
M860fc24TdqFBGRwZIt7LWq8d1+FBE+YVorzjlsMUeIMbOyK74TCnO+1klIQANVF
R/Dv8LDt7kGKC1O5uLFutscjT9py7TkBAIogSKa8Pg+7vBxnmhvM6ZCnqvOIn/Ha
XggHh5AYWXVFbr15UiXW06ZmG+34EK7WQcxnIdvsVGa8Mh4HBcmTlZxuy8tjdHH9
282rQy6VA9RpaccavqP2klqe6aOxaFMPgtDLlJHiaxMKp2u+sy3eMo2CUbfwCcD1
H4g1JUQ4c0HT4WnolE3KYKwN5Si8BdZKqOOMVE/hTI5iZA/P0IkUdiBOCVQmvWTC
Y+DKbKtRoIHzOBEn8pGJzAjqFwA7r4zoA6/XoiMbdc2bBxFr9QLjWqooWhp1xKLy
5d+zt08IjYJAgnOvBNC/LRphhlTPtCKHQOxNAAJa3db8zeoEtAHrPDdcEnXW8zBy
HNhzcUuc5pYFXkpxRbd7VeZ00+OzKSv6AiyxItNP/rWoKjjhhPmhB3WPlBWsQay8
DSVy44/hdRsFwZAVigl4MghZcR52cnBA2RoAxhyEkusERjAg0ZH8oZn7NRvNUaI/
F/R/vo3dr1JZPQgMvc2zdB2xLqbrEu/905J/9P/6REPnBPKcmTvUGzBpU1pC3BRL
fKjLuMXIZkK7MyRZMopg
=pc9F
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
