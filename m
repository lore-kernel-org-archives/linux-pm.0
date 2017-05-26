From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4] Introduce regmap infrastructure over Maxim/Dalas
 OneWire (W1) bus
Date: Fri, 26 May 2017 10:56:44 +0100
Message-ID: <20170526095644.ncud2aa67s4ur3pe@sirena.org.uk>
References: <20170525174639.3191-1-minimumlaw@rambler.ru>
 <20170525174639.3191-2-minimumlaw@rambler.ru>
 <20170525185136.GA17588@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gyoyafrulppgbhm6"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35830 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758757AbdEZJ5B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 May 2017 05:57:01 -0400
Content-Disposition: inline
In-Reply-To: <20170525185136.GA17588@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Alex A. Mihaylov" <minimumlaw@rambler.ru>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org


--gyoyafrulppgbhm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2017 at 08:51:36PM +0200, Greg Kroah-Hartman wrote:
> On Thu, May 25, 2017 at 08:46:36PM +0300, Alex A. Mihaylov wrote:

> > Signed-off-by: Alex A. Mihaylov <minimumlaw@rambler.ru>

> I just said I can ont take patches without any changelog text.  Why did
> you resend these without fixing that up?

Please don't take regmap patches without my review!  Though that's going
to be a lot faster if the subject line matches the style for the
subsystem...

--gyoyafrulppgbhm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkn+9wACgkQJNaLcl1U
h9DEMwf/Qmj5/gzSdG8HYAcbaGsfKWhTAS/VR7j2O2fvf1Hr2i3RdeWmTM7+wYzU
1tuflXWyRxsI7PCDawu3UZfzlFkZDSJsTtXxT28tTXS7JVm4ItmMe23PH6me3FtA
2n1AdMYdoPskE/0kzTz9j9WyKFtf61202iyufo2gm9fy3qC6mD2dYbbo3rWGnDAC
angL5d6LnwYFpphPWLJXBq5Sp2G3zsmY2Z/ZeThwNDOlH65YqjIWKcCp1RhIPL7/
l53cyAR+yBpZLrag0q5h+e5Ypq2d25GrbYf9X02uEEBHEQ7QGsnxk5ymowoseQiZ
rq72CPrg8FvlsvcX4qmo0XaTcMHJEg==
=dMwv
-----END PGP SIGNATURE-----

--gyoyafrulppgbhm6--
