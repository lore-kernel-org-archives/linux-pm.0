From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [RFD] Functional dependencies between devices
Date: Sat, 31 Oct 2015 03:13:09 +0100
Message-ID: <5035713.rI4RnBEDVM@vostro.rjw.lan>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan> <20151029001509.GJ28319@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1670638.4s65Cm8fSG"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63635 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751054AbbJaBoR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 21:44:17 -0400
In-Reply-To: <20151029001509.GJ28319@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--nextPart1670638.4s65Cm8fSG
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, October 29, 2015 09:15:09 AM Mark Brown wrote:
> On Tue, Oct 27, 2015 at 04:24:14PM +0100, Rafael J. Wysocki wrote:
> 
> > So, the question to everybody is whether or not this sounds reasonable or there
> > are concerns about it and if so what they are.  At this point I mostly need to
> > know if I'm not overlooking anything fundamental at the general level.
> 
> This seems like a good plan to me however I am concerned that only
> allowing links to be created at device registration time will prove
> restrictive - it means we're going to ignore anything we figure out
> later on in the boot sequence.

That's not the plan, though. :-)

I'm talking about device registration time or device probe time (for
dependencies that aren't known at the registration time).

> I would be very surprised if we didn't
> need that, either from things that get missed or from things that get
> allocated dynamically at runtime on systems with flexible hardware, and
> it'd also mean that systems can start to benefit from this for suspend
> and resume without needing the updates to the firmware parsing support.

The reason why I think it should be restricted to the probe/remove and
registration/unregistration times is because of PM.  More specifically,
adding a link to a "supplier" causes additional actions to be taken during
PM operations (eg. if the supplier device is suspended at the consumer device
resume time, it needs to be resumed in the runtime PM case or waited for in
the system resume case) which may be regarded as a change in a way PM is
handled.  Such changes are only expected to happen at the points I mentioned
and may lead to rather undesirable outcomes if made elsewhere.

Thanks,
Rafael

--nextPart1670638.4s65Cm8fSG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJWNCPAAAoJEILEb/54YlRx/9EP/RoL2UWZINaGrkDNrjV3ugvq
PHgS6z9wpzvy5jhSJ2aj4O/y1BeB0qZw6xszgMRNqhjluZJA/Cy54fSGUYRg2SQ1
Yp7ojrMjW+KBsLRqN5uHxcwH0srIb0nSLBeDVM27KeTe6Ax9gfCC3HO4RWata08R
nVXbDc4l/+khyxOzvXLGVQHRx9LYGt4zkFjJ/ace81SmYHORqMyf/K7izcL8neYO
h8g8u4qgaPSDBG/9PnJbkFGnE0eFtsw3945YLSvsitHGuWjIY+Bi9AfuP7aunaSb
Qx4ut53pNCtVQmFNHxLGpKdcDhA8obWTlW8pyHjnNJuo2Pl7ampX3FDS+g9mvruE
eFbHe0bkSrYMeNeo6qT9YJeq9qrAmxDt6JgAWvy1dqLPnsynZVF99Atimz3yJfVu
fMrTUYRMowBpJztaWVMOhLFrJUgyx/LEAuaeuwlysVh2nUFAY8l6V68ZAyvTT9Zl
YPSGYbQkvC5QVE3tltVkPeM4per7YINLFndHP6+zHWSReDybxWaumwhllXxP5kZd
w3BK7HP6OFkSZ/FDBXXx7rjAhV4Cp6Ph3if21aCkYiHdIftJR2XOX4KJJ7LAyO2x
d84KGlyA7bown+wn8SatIj/TTjepd6Pb5QM4F4Ue4WnvKGu52x4Q9+l9ke5wbVzp
u/E+UrNifeanSNZAu6ZU
=cvz2
-----END PGP SIGNATURE-----

--nextPart1670638.4s65Cm8fSG--

