From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v12 2/4] gadget: Support for the usb charger framework
Date: Tue, 21 Jun 2016 14:49:52 +0300
Message-ID: <87twgmn4m7.fsf@linux.intel.com>
References: <cover.1466497505.git.baolin.wang@linaro.org> <f7bae2566824a5e1da14c1a19dee6af5f250262f.1466497506.git.baolin.wang@linaro.org> <87bn2uomzd.fsf@linux.intel.com> <CAMz4ku+t66t+E3dCysfE9yNkKRCYwv7mXpJs4ShGbZWSZO_B9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38334 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752268AbcFUOm2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 21 Jun 2016 10:42:28 -0400
In-Reply-To: <CAMz4ku+t66t+E3dCysfE9yNkKRCYwv7mXpJs4ShGbZWSZO_B9g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, robh@kernel.org, Jun Li <jun.li@nxp.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Ruslan Bilovol <ruslan.bilovol@gmail.com>, Peter Chen <peter.chen@freescale.com>, Alan Stern <stern@rowland.harvard.edu>, r.baldyga@samsung.com, grygorii.strashko@ti.com, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Linux PM list <linux-pm@vger.kernel.org>, USB <linux-usb@vger.kernel.org>, device-mainlining@lists.linuxfoundation.org, LKML <linux-kernel@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Baolin Wang <baolin.wang@linaro.org> writes:
>> Can't you just tie a charger to a UDC and avoid the charger class
>> completely?
>
> Yeah, I also hope so. But we really want something to manage the
> charger devices, do you have any good suggestion to avoid the 'class'
> but also can manage the charger devices?

manage in what way? It seems to me that they don't need to be real
devices, just a handle as part of struct usb_gadget, no?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXaSngAAoJEIaOsuA1yqREI4IP/0v8yDkNUQefnP1aefswOOiF
H5iOFp1LYuSE/HgufeWQRmGxxftYf5iZfKEMnhObaVAGTOfFa2yv17wEfoXzJuYx
tfN2FGEI1nzhc0gDFHq6hFAsJz7w8sgWv2ya+pVw9oc/TrUoIXHTj6GCJvJ5uYNM
Ol/5fBGtPGkjow3md0rJx+GeXTJfcFwunBaPgkfGp7m6iQym22RrB3+zQT61Ld09
OZlMczieKGx/MKfp2M1sVq6DRMUMIjSSP5vx9+H2xewmxWsX81lyoPuwbk9SGN0P
qYmvrZEze7KWAe4sUCC60a6HUeBJBh+BFvFUlpwbvagIw2lFYMh9SbqU873WpjwV
TPf66dXR778EB53L51SWKr/EG5TuAmVFzBLOWPaokiOWGe3nqYaQRUIk80pNz4uW
T8MXS2HnWE5LhvNVf+oiZshZZzdPM3/Yqbnzirb9pU7VJzrB3SyjwgdaF5kp77zD
xsv7JNDOw8mxoOXrnmEAgNA4v9S0wmD/mWGBKzJ8vdtQ6di67K/u5e4KTLqbKNXg
Mwfl4cdUX4uSAjH220X8eoHddhaeRqLdbgkygAn0OcXawHVsPJWZu+E5VMB0c0ty
EtKNmdUr++9kPF9sgN7dGQEod2JRUmtMf+vMbx3ivgDajko8hr5Zwa4efvw7gsUF
TG91VBJl3a8dNANnDtI8
=TsPh
-----END PGP SIGNATURE-----
--=-=-=--
