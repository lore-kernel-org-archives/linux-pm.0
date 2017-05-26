From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] Introduce regmap infrastructure over Maxim/Dalas
 OneWire (W1) bus
Date: Fri, 26 May 2017 18:18:34 +0100
Message-ID: <20170526171834.uq4ke5cm5qtobxgl@sirena.org.uk>
References: <20170525174639.3191-1-minimumlaw@rambler.ru>
 <20170525174639.3191-2-minimumlaw@rambler.ru>
 <404871495743279@web24o.yandex.ru>
 <20170526110602.jtvxf76abks4v3xf@sirena.org.uk>
 <3411811495806312@web49j.yandex.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hcnrwalju5b6haa5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39786 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S940112AbdEZRSv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2017 13:18:51 -0400
Content-Disposition: inline
In-Reply-To: <3411811495806312@web49j.yandex.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Evgeniy Polyakov <zbr@ioremap.net>
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


--hcnrwalju5b6haa5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 26, 2017 at 04:45:12PM +0300, Evgeniy Polyakov wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> I wonder what is 'cache' argument about? If I know that some read can be cached,
> since underlying hardware never changes these values, I can store it into local variable
> and use it. If I do not know in advance whether given register can be cached,
> how can regmap determine it for me? How to debug cases when register
> was erroneously considered to be cached?

regmap will only cache registers if it was explicitly told to cache, if
the driver gets that wrong it's just your bog standard bug that can be
debugged in the usual ways one might debug things.  By default nothing
will be cached.

> What is the reason to use regmap besides caching?

There's the other reasons I mentioned in the message you're replying
to for a start...

--hcnrwalju5b6haa5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkoY2kACgkQJNaLcl1U
h9Agqwf9HqMvfmompSKzQnuTnsi1ZkoDwZXm/+cXnxALlGZJALZ/e/SC3pEqC82U
oxcBsO+V3tNO/Y3+N0sNRvDsEvX+wcdal6q/U4w1362PjYqdONztfOtt2ASNACjL
WsaiqCXSuoJBk87Q2oqdGACVXfy0xbPXeal2TZtExrH21a6HHjJMZfZF4H+NatkJ
n0Qa6Vz7H3+2nphkupnI9CFwx1r4fE2QL9ANISiYP7VPAxfd4vmiyWZ4o0cTXCaA
qMafKCNURLYjGFnG88nryZ9YQjaZCkNF6VG2ARWareNc9i2hb8M+FHiqDqlRc4cI
PBXxnv1sOXkt2kgpX3c+prblmZQTVw==
=X3Qw
-----END PGP SIGNATURE-----

--hcnrwalju5b6haa5--
