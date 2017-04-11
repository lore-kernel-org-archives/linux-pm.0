From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] cpupower: Fix turbo frequency reporting for pre-Sandy
 Bridge cores
Date: Tue, 11 Apr 2017 15:17:34 +0100
Message-ID: <1491920254.2409.70.camel@decadent.org.uk>
References: <20170410232944.GA4152@decadent.org.uk>
         <22617475.I35FT52FBz@skinner>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-1WhfsZYgKuh/cCzd+wjj"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53868 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751396AbdDKORn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Apr 2017 10:17:43 -0400
In-Reply-To: <22617475.I35FT52FBz@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: 859978@bugs.debian.org, GSR <gsr.bugs@infernal-iceberg.com>, linux-pm@vger.kernel.org, Rafael Wysocki <rafael@kernel.org>


--=-1WhfsZYgKuh/cCzd+wjj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-04-11 at 14:36 +0200, Thomas Renninger wrote:
> Hi Ben,
>=20
> good catch, thanks!
> Could you resubmit adding my Signed-off-by, please.
> Rafael could directly pick it up then?

That doesn't make sense.  You should add a Signed-off-by if *you* send
it on.  Otherwise Rafael or I can add an Acked-by.

> > Reported-by: GSR <gsr.bugs@infernal-iceberg.com>
> > Tested-by: GSR <gsr.bugs@infernal-iceberg.com>
>=20
> These seem not to make much sense, at least not in the kernel
> changelog?

I don't see why not.

Ben.

--=20
Ben Hutchings
73.46% of all statistics are made up.


--=-1WhfsZYgKuh/cCzd+wjj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAljs5X4ACgkQ57/I7JWG
EQkJyRAAzTDnsyS954+4q1Khr76JlIC8pQhTC0WvUJ57B2EDPHsiOElKRK3OWy1C
PLWe2/2zvZ4cZKMsYC+uoSTr/urrdyb2QsUSCVYKsxTDl0mjHNnZGNUiccGnYSYi
lqacn2xNQGU9uJRT1GaUWdhbeQbdc/B5S4eKuaF1kttUzp/CBtJm4Sio1mKTjcJq
uAabdj9TCMBJzrrsf9v6RnMYbM83jDuF4t50zHhKH6D0LbHvgjlBVzLMRXjloTLC
cdulpE4Bs2zb7cZthVEoX7yTcaKNTWVqrrCO9RIMPx5sTvG9R7sCh/qowQZA59Ug
m6NfPTJo94gjSoUbBYD9UgxWNI75wIE+n6Awl+j/dzG15jJ9kdvOPZ/8HFFj+nJD
P9EoLDSrCnD0nFFGqpdT2yFwlvcCTvkcy29/1LLTG/mUesAZhIOt8o55+c6B6tC6
bpMSC2p84Opl64/XYwOAB2PNko6murP3eiZP9co2pHkh3qwT9A4QR2oW7kWJxcUa
R18Kdv95mIE4Y0jaegDUALIjdy/kbWlx2FN9X/hT2+nnlWad/kaqgSwdkDced4V0
QgJGuAVDSBUEoRgpPszf/SXn2tSKcnpQ3R0sKEyF9yvqBCYUgzFgR9kA03nriEfQ
25Ibjtn7eYvr2+gZz+WPNt1iWfiupYi6zILhUhT557CaBaugtOE=
=SDuC
-----END PGP SIGNATURE-----

--=-1WhfsZYgKuh/cCzd+wjj--
