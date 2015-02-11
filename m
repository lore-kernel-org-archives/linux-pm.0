From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] Add LTC2941/LTC2943 Battery Gauge Driver
Date: Wed, 11 Feb 2015 18:01:52 +0100
Message-ID: <20150211170151.GB26774@earth.universe>
References: <20141027163842.GB20765@earth.universe>
 <1414479912-3545-1-git-send-email-mike.looijmans@topic.nl>
 <20150122022426.GP13715@earth.universe>
 <54DB3B50.7020902@topic.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50892 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbbBKRBx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 11 Feb 2015 12:01:53 -0500
Content-Disposition: inline
In-Reply-To: <54DB3B50.7020902@topic.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2015 at 12:21:52PM +0100, Mike Looijmans wrote:
> =EF=BB=BFOn 22-01-15 03:24, Sebastian Reichel wrote:
> >Hi,
> >
> >On Tue, Oct 28, 2014 at 08:05:12AM +0100, Mike Looijmans wrote:
> >>Both the LTC2941 and LTC2943 measure battery capacity.
> >>The LTC2943 is compatible with the LTC2941, it adds voltage and
> >>temperature monitoring, and uses a slightly different conversion
> >>formula for the charge counter.
> >>
> >>To avoid confusion with e.g. the LTC2945, the driver is called
> >>LTC2941 instead of LTC294X.
> >
> >Applied with .owner field removed.
> >
> >-- Sebastian
> >
>=20
> Hello,
>=20
> We found a bug in the LTC2941 driver (typo, it says "58" in the formula
> which should be "85") just yesterday. I couldn't find it in mainline yet,
> I'll post a patch to fix it.

pull request has already been sent:

https://lkml.org/lkml/2015/2/9/373

I will send your patch as fix during -rc cycle.

-- Sebastian

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJU24r8AAoJENju1/PIO/qag5YQAIEQJa6YwyRCB1UIaVbqsamD
0OqnZ4aL+QL3wAA0H86Bm4b3KIFE5ko9OsCiUfWtXghRIW8ApfNT6UpvPDGe9Mz4
BMnRlP+pH56IoIq/T3zEtITFH3L86Onz0cjFtkYKb8tHsS0RIO1AaGRBzFigO/ui
Oe1yRGWlXphnn7Rd3EXK1vBuSMzK0SE+O5v1ODa1AIAcN8BbU1q5hig4PfrkBXHh
zLRdrUYUhgAmO3LSEaE0dhf9AgkRBP24SCU28DU17T1+5kTbFG1a/8Ra0CRbO0HY
DeeX9ybR0EJKnW+XVmiakPweGAIYdRC1Vl+4hyJhVFSJZ0hOGycol/cU88P5JYlJ
h1rwGSXd5gjEBw/p4aQKW4+whBOq1rXBLS4wXuUoPQqsVEFZBJ0pPG60BtNLdjC9
yIVhdIJjhUjxXZIOpjTcGSied6fSfJHzk5u+6gNiaf7qzSo4W0Kyc+3hWskcB4x9
+LdD8Itkw9q/TkxWxXhTf6j2idtciUf5Iy0VScp1GMERnFeS2r23+9r6WMmBz2MT
rZVF1iPXQ4vCp+/4eTiG59k3V3I1oCskzL0OKYtYK6oktM9WLeOUzf+z9YoZ9igX
lbG2Paeq/ongf+KK8qS+a5p0MJkvd0+ByBYx6MXt7Vm+4yclKGURX8+OpWUA37ja
7x/UwxX27n/p3XSTfQY4
=+QgJ
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
