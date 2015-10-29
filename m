From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Functional dependencies between devices
Date: Thu, 29 Oct 2015 09:15:09 +0900
Message-ID: <20151029001509.GJ28319@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O2lvLMQR9k8T/RyB"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39844 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbbJ2AP1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 20:15:27 -0400
Content-Disposition: inline
In-Reply-To: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--O2lvLMQR9k8T/RyB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2015 at 04:24:14PM +0100, Rafael J. Wysocki wrote:

> So, the question to everybody is whether or not this sounds reasonable or there
> are concerns about it and if so what they are.  At this point I mostly need to
> know if I'm not overlooking anything fundamental at the general level.

This seems like a good plan to me however I am concerned that only
allowing links to be created at device registration time will prove
restrictive - it means we're going to ignore anything we figure out
later on in the boot sequence.  I would be very surprised if we didn't
need that, either from things that get missed or from things that get
allocated dynamically at runtime on systems with flexible hardware, and
it'd also mean that systems can start to benefit from this for suspend
and resume without needing the updates to the firmware parsing support.

--O2lvLMQR9k8T/RyB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMWUMAAoJECTWi3JdVIfQOa4H/1TFoVSdnRFQ5HrVuT65XGjd
yw17ytbmzyiySQeE3jVBjO/v5CV8ZNm8f2Eyqr/M1Cf1SoDTTDSb+CGhonJTTKzG
+Fyd/tPq/ZuU6YRp+iBhOhDO6HPPeFknegruUC6lSTNPEIzArdzkvY8tChd34kGX
VLgTFHvPRr+b5g0JL4VeJcLRFMiFiunHljIgVmLqMlstxOo5vCj0f5eWoX1zUrjl
Vj9NM5xnen/EixmTuP8cBr0uuhYFgq0362+yu+OLd0i/w8sWP2B5h22NLQ7NE/35
Kf2igmLiaxiqM+gGQe22bDnpahr309JQLH1hV6iJWVqtfpq+gziBcB209Mh28h4=
=SLaX
-----END PGP SIGNATURE-----

--O2lvLMQR9k8T/RyB--
