From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Functional dependencies between devices
Date: Tue, 17 Nov 2015 22:47:58 +0000
Message-ID: <20151117224758.GE31303@sirena.org.uk>
References: <564B224D.3050904@samsung.com>
 <Pine.LNX.4.44L0.1511171521000.1680-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rZRBnaF0gvoyXYbn"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:36526 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbbKQWsO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 17:48:14 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1511171521000.1680-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrzej Hajda <a.hajda@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--rZRBnaF0gvoyXYbn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2015 at 03:31:29PM -0500, Alan Stern wrote:

> Also, there's a real problem that needs to be solved concerning how=20
> resources are identified in the absence of DT (or ACPI or something=20
> similar).

So long as we can add new dependencies at probe time we should always be
able to figure things out when the driver figures out it needs the
resources.  Realistically we'll always have some information - if we
don't have firmware we'll have a board file.

--rZRBnaF0gvoyXYbn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS66dAAoJECTWi3JdVIfQobkH/j3YKiBCNqzwEnzvMHXPfo9k
01McWD+PEQf6Z8HEb4wvSyP0fBJpnrRwV5TzjLmrLnSnckOHS6nG+OqMImlcRziC
AIugyJNOq2lSIdMsYAep/gnWYRpXRgCm1izRYemb7q9Uml82qWF3cAyxw7ewu8nn
io8LLAHa4vqPmFIo684zPUPN8mHeNfB+l0lcPd1iNEJZjF5hcqm94e1vssyOPhU5
UMMSay5+SHKZbMTeOq3ovO6OWwBKy17qU+ngltYJj96IJCWRb8hT0HCfnQip1ZTM
00fuhYTfdn0OaByWzFeurkwRlvzThbcgK9ha4gkRm4xv1XVBbf+R3L2qxACAFhM=
=jtbL
-----END PGP SIGNATURE-----

--rZRBnaF0gvoyXYbn--
