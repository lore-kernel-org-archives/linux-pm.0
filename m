From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Functional dependencies between devices
Date: Tue, 17 Nov 2015 13:55:49 +0000
Message-ID: <20151117135549.GR31303@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <564B224D.3050904@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Hw0FrjWlp+qkNlJP"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35981 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbbKQN4K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 08:56:10 -0500
Content-Disposition: inline
In-Reply-To: <564B224D.3050904@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--Hw0FrjWlp+qkNlJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 17, 2015 at 01:49:17PM +0100, Andrzej Hajda wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> On 10/27/2015 04:24 PM, Rafael J. Wysocki wrote:

> this scenario:
> - many clock providers, irq domains are not provided by devices,

That seems like something we can and possibly should change if we want.

> - there are also dependencies between clock providers, ie. some clock provider
> requires clocks provided by another clock provider, so the entity is also not a
> device driver,

This is going to be really common but I'm not sure I see a problem with
it in terms of what Raphael is proposing - could you go into more detail
on the problem you see here?

> - another case are requests for some additional/optional resources after device
> driver probe, for example phone usually does not require HDMI related resources
> until user attach HDMI cable,

Normally the drivers we need would all be loaded based on the hardware
we have in the system, it would be very unusual to dynamically request
new resources at runtime to deal with a reconfiguration.  Doing so seems
likely to result in fragility.

--Hw0FrjWlp+qkNlJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWSzHlAAoJECTWi3JdVIfQG98H/AlBGek2liCuZXCrV1V8bOGO
ZgOJdaj7BBmXIfWl9Y69RdTw6Z/UgrIzXQZRy9GnnoX3maxom6CCNNLvBcv7d0oP
6pjGz7Y4hv0QikCaQebb3aFukx+BfYf5uPXV98LX3PsCclNgvcQYB8MkaFOswciY
oI3ReDJcDIUmOhICGqqzaXy+NI0fQSgJ3AxBFSRNRTh5UgKgFNrgt32v3uNrI2kT
jkJngbdp8r9X/3azUJJvEVTKgTWacOubVXpZeNDDD82vjTmJrt5yLCcW4YIxFftg
dv3nz/Jat/B0FJlStiQk3PyP/TLq79t6I6in7oi5Y/+g3X7FueCHzvtzbpTtcz4=
=ZIg9
-----END PGP SIGNATURE-----

--Hw0FrjWlp+qkNlJP--
