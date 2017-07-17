From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] power: supply: act8945a_charger: fix of_irq_get() error
 check
Date: Mon, 17 Jul 2017 12:50:04 +0200
Message-ID: <20170717105003.riv7fe44jzmkffg3@earth>
References: <20170716175244.300670810@cogentembedded.com>
 <c0a5fce5-4185-249b-e206-4964d41ab05a@cogentembedded.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wy6gog4xm2jpreja"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbdGQKuH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 17 Jul 2017 06:50:07 -0400
Content-Disposition: inline
In-Reply-To: <c0a5fce5-4185-249b-e206-4964d41ab05a@cogentembedded.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-pm@vger.kernel.org, Wenyou Yang <wenyou.yang@atmel.com>


--wy6gog4xm2jpreja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Sun, Jul 16, 2017 at 08:55:13PM +0300, Sergei Shtylyov wrote:
> Forgot to mention that this patch is against Linus' repo as Sebastian's repo
> lags behind at 4.10-rc1...

You are supposed to use my for-next branch [0] and not master :) That
one was 4.12-rc1 + power supply patches until a few hours ago and
now is 4.13-rc1. So if you based on current master from Linus it
should be ok. I will start reviewing patches for the v4.14 cycle
shortly.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next

-- Sebastian

--wy6gog4xm2jpreja
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllsllkACgkQ2O7X88g7
+projQ//QhaYxk915L8U2K6ujStQDbUxgqXZtAfq86R24UhWTxGcrB+GdUChM4K5
tF6kEu4qO9Nrg53K12qP4gMv9tBxbOagW/Bk2YxYsZ18hMHPfCflEmTUUl9UdvUx
YtU2wfcTefXyDvLgsIft/1KdAr2RfDwowJuqDuf+T6v0gs307PNYf+oIP8Sl9yOC
Ac6W45vp/689s94HVCAlK0b076PyYtXvpDaGZ+FXHju1SnLYTKJlO7lD/GQFv+BP
4bN80Dd3MJwOAF0JA4GOLQfPDqcNC5QRl5/rjpI4QE+eXg3Ujrz3LtANHs+KzXVm
pd303nq6fgElr75+S5kwiKmg3aMJPYNawDab9VpQRDFtUCRe5q/g7DhUgI9aULq6
9JZPOgt82Wq0qTaczivSRdE9+8k7LeuXeDhkexlOApjpSMzUtK+2JJ5cCS4gXXf3
my0TIuxVaBcHtUnJCMp3n0jcRYxPCcySB4tX8m6pTusHaBLlhsYQeroSacMclBHB
6V027wrBGMmXkhEBUqY6CWkU6757NgPXswRpAmYyXNfFw/opIulhXfD647ln+egN
LeqKcyZZ4Cb75jLfnWa2lLIc6QnwDfEtW000jGtNJ97DvjZAQlkVSLNg5+zXa9yS
IIQiVGgr2BuWBkJ9xARCOQB2P2TycmwGhz8zwM/W3rs88l9VRvM=
=sPvC
-----END PGP SIGNATURE-----

--wy6gog4xm2jpreja--
