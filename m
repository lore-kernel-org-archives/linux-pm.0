From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: s3c2410: remove superfluous runtime PM calls
Date: Sat, 19 Dec 2015 11:50:31 +0100
Message-ID: <20151219105030.GA2571@katana>
References: <1450203249-4873-1-git-send-email-wsa@the-dreams.de>
 <56716CC3.50309@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:49222 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932688AbbLSKuh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 19 Dec 2015 05:50:37 -0500
Content-Disposition: inline
In-Reply-To: <56716CC3.50309@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> > Since commit 6ada5c1e1b077a ("i2c: Mark adapter devices with
> > pm_runtime_no_callbacks"), runtime PM on adapters turned into a no-op.
> > So, we can remove these calls.
>=20
> Won't this break i2c client devices that use runtime PM? Not sure
> if any cases of such client exist now, I'll try to find some time
> to test this change.

Thanks, much appreciated.

> IIRC client's pm_runtime* calls return error if their parent device's
> runtime PM is not enabled. Also enabling runtime PM on the i2c adapter
> allows propagating runtime PM calls up to its parent - the i2c
> controller platform device.

I was thinking the PM core would take care of that. Grepping for
other users of pm_runtime_no_callbacks(), I see that most but not all
use pm_runtime_enable() on the device, too.

Asking linux-pm for help here: If we want to support RuntimePM for I2C
clients, do we need to enable RuntimePM on the logical I2C adapter
device (the bus master) which is already marked using
pm_runtime_no_callbacks?

> Perhaps we could just enable/disable adapter's runtime PM in i2c core.

That would be the proper place to do it, as I see it.

Thanks,

   Wolfram


--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWdTZ2AAoJEBQN5MwUoCm2x7QP/1zHaz1Pk6LXZuDS/+U2rZnx
AtWQloAwOKicFMPNrhnNp2GQvd/Tpg4OXohem6zdSJ3wZ939uze7rq73tLMR67cw
nWPviVHOIH1IGJbtg99MrrnJD1HUeLG43zfDiS1cH2PpOzr30f8/4kEovTPhUh+l
Fy9zgZ6kRUH4jYpaZmrUWfZ8JP3Ken4CYaNZ1V9bwMAuWgF1j/yMSMTl0WKMkh1G
fRR5se4ZbfKbApOCTIrwdjwXbX51AYqwmpQpn12cPtS/s9bT2xr98qhQAy9vOi+V
gM6HXcu2pLlBVEutFhzXbnh2sWCYBxxkAISsE4FlJhS71Jzutb/pNlSmwdOqPFEa
QJoCKWYEY68L7jStKzzm0omkaR3pnCRuKM2m/OeYceMdFqPNW7QAUuHP7KccIrzr
h7KdDb6tB45ZPQMJVqv9f34655SZSdN0qgNUXDRsgpw777fyURJr8jaX/yBtlq97
0GKFC95mR2bCH0GUKoeZreEcI+7+i1jQr+4/BTmDNi/OICZpBuj63nXRXWs5MWeg
TzhxamYDnjfqz+quKJTyChilhLbExyj7dvbPXONUlu4nkXKUW5koZMhXMjzMK1Vz
Olf4G+nNHqfXIS8gu3LkcRZblw9Yxvycn3Yt/bXw4aOUBrln44Rx5j9PMDjuoQmo
vhcP1c50iDn+NdIzNxEh
=d/NC
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
