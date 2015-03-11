From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2 1/2] power: reset: Add generic SYSCON register mapped
 poweroff.
Date: Thu, 12 Mar 2015 00:48:40 +0100
Message-ID: <20150311234839.GA21023@earth>
References: <1426113145-2921-1-git-send-email-moritz.fischer@ettus.com>
 <1426113145-2921-2-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55992 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751257AbbCKXtA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Mar 2015 19:49:00 -0400
Content-Disposition: inline
In-Reply-To: <1426113145-2921-2-git-send-email-moritz.fischer@ettus.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: dbaryshkov@gmail.com, dwmw2@infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Moritz,

On Wed, Mar 11, 2015 at 03:32:24PM -0700, Moritz Fischer wrote:
> [...]
> +static struct platform_driver syscon_poweroff_driver = {
> +	.probe = syscon_poweroff_probe,
> +	.remove = syscon_poweroff_remove,
> +	.driver = {
> +		.name = "syscon-poweroff",
> +		.of_match_table = of_match_ptr(syscon_poweroff_of_match),

Sorry if it was unclear from my previous message - of_match_ptr() is
only needed for optional OF support. Since you removed the #ifdef
around syscon_poweroff_of_match, of_match_ptr() is not needed.

> [...]

-- Sebastian

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVANRUAAoJENju1/PIO/qaGs4P/ihBCjKBr8eJpYk7WDSEL8cy
yu7iBSUMhTUaqVX0GX0GRd/iT51wdlY2Mz/bm9wtqepvsDHPo9dW5zey+d1vOmTQ
8mYoLMVI3pebO/fXdD06TEMFx5uAulnxz12jKYYPivHHy5NDYi0v+4hphzdQt+ED
MbatH3IHPUUYDm6/ifc5t3iAxR7QKulw4BgIp5JUxl7SVrv+zcVXD0aFXQbhe7uk
urfNG6A+58qE80aB9xPCvaVYzH/cQXNR7CzE1Q01X5xWFyU2KgUKHX7xdBA7Hu9U
2jgjbGI4wNrTfAhv9Yf50BNxKB3/DNyyolTuc4Tr5w+xJorslxBrkI6E0gVBaAL6
EbdBA66XTn4cSYNscLWAPLJoadkRHqA2939PXlkmhrkeJWDeOjH3c+jg+YmEMmzM
p6JigZuBTHQPuMwjqvbY9x9ihXT4GRPRz7wdo/qwALF09ENPPcJOZG0zZU4R6183
kiCyLtNHPbLnskONq8n45TctPO4Yt/ZFbH7KFM3R7m4bFlVQT9PgwtWsLcE4sxIE
aWKow4cJNbLeAsoWcYoYwS+MG6PU+QBlszonGVTAJwusQle2Ek1eQO3EKSFClyoC
XFb6+LR7YgXoF3D4wJFt9dxbWlYYRG2l+yVP3CxyAlm0nd2BkwkLC8Jbc3M2TTw/
j7XgLsGrodG4Oiys8p8u
=hZtH
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
