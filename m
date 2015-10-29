From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFD] Functional dependencies between devices
Date: Thu, 29 Oct 2015 09:18:02 +0900
Message-ID: <20151029001802.GK28319@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <2204663.4WkHk8MHL7@vostro.rjw.lan>
 <CAAObsKBDTLA2VWfxN2gKjuqWt2Z6r59_vdSHLG43nOQtorBKeA@mail.gmail.com>
 <1486032.sTaAs3EPXc@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fyA1p1RlO9nWxe3v"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:39872 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751526AbbJ2ASN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 20:18:13 -0400
Content-Disposition: inline
In-Reply-To: <1486032.sTaAs3EPXc@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--fyA1p1RlO9nWxe3v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2015 at 04:54:04PM +0100, Rafael J. Wysocki wrote:

> Information that is already available at the device registration time should
> be used at that time or it makes things harder to follow.

> But that really is a tradeoff.  If collecting that information requires too
> much effort, it may not be worth it.

For DT it's going to be a lot eaiser to reliably collect everything in
driver specific code, the property names to look at do follow
conventions but are driver defined.

--fyA1p1RlO9nWxe3v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMWW5AAoJECTWi3JdVIfQkJcH/2QDrdlRAHAlbzumxIn+zWCn
s63KhAngajvcDIQyN7iz0c7CciGg77TzwYv0vgozI1q2BfA8bfcXaXze6kWbr3vT
T9Qt23v2LBFLJCbZyixpmHdArMDfmeCyw93//7k59fi6PfzVdqfKbjF/EBA4PuS8
HeF0jKH3H5ykwyaPGP7D5aqGS4iyY139Dv145GxTHjgoMNAAFKlgHlRnSNOiMDum
eRZoQ1LDf+CeXQ4dJFUMlvLvFbeCYaiCAfMk8q3A5WqA76hlCOh9cM+JnWOGGapq
a+dGIPvVYjDBs65Q14EFdTebtzTDH2GQq3GZghBfB3Hm9g4Sa8zteeTAwpvDJjQ=
=BKxb
-----END PGP SIGNATURE-----

--fyA1p1RlO9nWxe3v--
