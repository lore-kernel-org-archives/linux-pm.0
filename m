From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Functional dependencies between devices
Date: Sat, 31 Oct 2015 11:40:34 +0900
Message-ID: <20151031024034.GX28319@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <20151029001509.GJ28319@sirena.org.uk>
 <5035713.rI4RnBEDVM@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NEtstXYywuKat6/o"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42180 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbbJaCkq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 22:40:46 -0400
Content-Disposition: inline
In-Reply-To: <5035713.rI4RnBEDVM@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--NEtstXYywuKat6/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 31, 2015 at 03:13:09AM +0100, Rafael J. Wysocki wrote:
> On Thursday, October 29, 2015 09:15:09 AM Mark Brown wrote:

> > This seems like a good plan to me however I am concerned that only
> > allowing links to be created at device registration time will prove
> > restrictive - it means we're going to ignore anything we figure out
> > later on in the boot sequence.

> That's not the plan, though. :-)

> I'm talking about device registration time or device probe time (for
> dependencies that aren't known at the registration time).

Oh, so I think allowing things to be added at probe time addresses my
concerns - for some reason I'd parsed your mail as talking about
registration time only.

--NEtstXYywuKat6/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWNCoeAAoJECTWi3JdVIfQFuIH/3LA0Nul1W5cT2CkgrUv7OrG
w7i8A4xHUointl4TNntHErAbO2+JdPfNeZeNubDlEW2AYHMkhVEbTJX3N9f0bnU1
wlma3Qhl6RWyJ7KrDhEK9Euqic1EnsA1aCGjmNkf41xG3G5JGUJf/78EO7mQ2dTN
ubZ5Dng3/h3JEZnICChLlRTxRiithF+azRxhZOlibS/ViaGzEL0OXsYOVHL+PDOc
zQ6whwJskLllxZ209j/t2dE8KvzAYHr3ZuvwrWE1nip8ARY1OHrTHSnDoLFomXO8
/DIxQnoqwpP4p6QB8fvHtb9ZyXWM7SQ8NSlCnBKO7qQHlumTU7re35VlSw4JrkY=
=ZkTX
-----END PGP SIGNATURE-----

--NEtstXYywuKat6/o--
