From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC][PATCH 2/5] driver core: Functional dependencies tracking
 support
Date: Wed, 8 Jun 2016 23:24:02 +0100
Message-ID: <20160608222402.GQ7510@sirena.org.uk>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
 <2576341.476ZsjkPgF@vostro.rjw.lan>
 <1816598.SuJvGrVRJK@vostro.rjw.lan>
 <20160608124844.GH7510@sirena.org.uk>
 <CAJZ5v0ipDXrgx3=cFuxzofkXLMzErETuqSSnf8ugo5jnB0ynNA@mail.gmail.com>
 <20160608183535.GP7510@sirena.org.uk>
 <CAJZ5v0hmkX53N519oATHMx7V2uUbiZYWcQ=Fvc1TW__Kw2nbhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fTD7sGci972winw4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51594 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422636AbcFHWYa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jun 2016 18:24:30 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hmkX53N519oATHMx7V2uUbiZYWcQ=Fvc1TW__Kw2nbhA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>


--fTD7sGci972winw4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 08, 2016 at 10:48:23PM +0200, Rafael J. Wysocki wrote:
> On Wed, Jun 8, 2016 at 8:35 PM, Mark Brown <broonie@kernel.org> wrote:

> > A parent (especially a MFD) may create a child to fulfil a role that
> > could also be filled by a non-parent device, if that happens then
> > depending on what ends up creating these links (it's not 100% clear from
> > this series) it's likely that the link creation will also end up
> > registering a dependency unless we do something special.  Now I think
> > about it this does depend on how we create the children though, it's
> > less likely to be an issue if the dependencies are created by firmware
> > code.

> If that's a non-child device, I would expect it to exist beforehand

No, it's an actual child.

--fTD7sGci972winw4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXWJsAAAoJECTWi3JdVIfQ8bgH/1HZg7hwOBXyYUJOZ4+eOSL6
P3CV86Og7IuUcrHJ0JQBXL5uJmb000hgbFKv9AGhw4HLHyivn5iAU1SOgEMt2D4g
wPXSxYytGNGU9a2Q6i+2a/I0AAsLwIKSzAtvmRbTjVVbtMyfbmTUeyKE6+JFhzz7
z6q+iEEnb7OMmPlgDUbalKn6/lh1mnnqym/+52hLMfSgGRa/8fbhO2juRcj9GP9i
WgGTffpP9VFLBIKBPcBJAUdqeq/Cw/IXB29tYqygCeW4u1Jf/oqGTCV6k9g6tyao
n79y4JyHQAGw0miYDcmr2IrknRjCOF6SC2CFiOXGdgq2z86dObec/Am/xHgEs6E=
=Q9u4
-----END PGP SIGNATURE-----

--fTD7sGci972winw4--
