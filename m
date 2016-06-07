From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 1/6] power: Introduce Broadcom kona reset driver
Date: Tue, 7 Jun 2016 03:50:17 +0200
Message-ID: <20160607015017.GA25073@earth>
References: <1463002582-6875-1-git-send-email-chris.brand@broadcom.com>
 <1463002582-6875-2-git-send-email-chris.brand@broadcom.com>
 <57409633.8060605@gmail.com>
 <20160603023853.GD8921@earth>
 <CAMsMSK8ZX=nmJs9d2txRsk2gLa0duy3Qpp805ztYzow=OiTB8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:57385 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751294AbcFGBuW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 Jun 2016 21:50:22 -0400
Content-Disposition: inline
In-Reply-To: <CAMsMSK8ZX=nmJs9d2txRsk2gLa0duy3Qpp805ztYzow=OiTB8w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chris Brand <chris.brand@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-arm-kernel@lists.infradead.org, BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 06, 2016 at 09:42:03AM -0700, Chris Brand wrote:
> On Thu, Jun 2, 2016 at 7:38 PM, Sebastian Reichel <sre@kernel.org> wrote:
> > Feel free to queue it via arm-soc with
> >
> > Acked-By: Sebastian Reichel <sre@kernel.org>
> >
> > If I didn't overlook it, it's missing DT documentation, though.
>=20
> Thanks, Sebastian. Because this is effectively a move of code from
> arch/arm rather than new code, there's already dt documentation in
> Documentation/devicetree/bindings/reset/brcm,bcm21664-resetmgr.txt

Ok. That directory is usually used for periphal reset controller.
Board/System reset controllers are usually documented in
=2E../bindings/power/reset (following kernel strucuture
[drivers/reset and drivers/power/reset]).

-- Sebastian

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXVihWAAoJENju1/PIO/qaanIQAKnOe1A/p6OwhjMii4vw+1bR
n8LrJHJ2wWjI0yylc0t46f643685updep5UhcfXTk8FaZnGnQtJGc49selG75YQs
Y7RoOeOkvb1utwvMA1MzwjRHKiInv4WvpBnbEhftEzpaK7fEScFFJV+x1idF5JjN
wHEx1IcCTEZGFbHzIphhghyjq0yPrkemsp/3+spZcwiNFinsR9g5MTf+x8cbwFQm
MaWxnRhMwaTqdiigIFtRMSrDrI/HlQlkVgGh6h2L8tzwub6bjp11sqDsiE7UgfAB
69gZvUNtu6qLcznJ6jkAlfNAv0fELIafVur7hDaqwB2mxukjfJAGFyL/X+92KvFI
+KvUQyZVOLFvoCplXvUn9m1IrjplTDWjacRcBceTu7DQI/UT/uczGzHc80YB3/mq
UtvKUPcNipZS4oo/Px+XUEi2euAy1IdvGrnIpu+1E5Lcdyny3P9jWn+G/pd3geNS
N5FCzc+AJAmAerSb4N5D5ejdswe8Ws+wz/JqnziiWkIJxX94hNRRP34/tvAMS82a
4ptXl8K0UVpNmL8b1CyS61COdfvfGs6/bDHkHkVSlgJM6QMckdi/YEhWf4Ymhgji
6P0dCVlUla+L5L+0vzn3SyzcpJoAd9Ie4y6nLBvAfU1cGC1OHqlbHP41jnJXXEKZ
lh3hKbg0xFatKVsd4jMD
=PScD
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
