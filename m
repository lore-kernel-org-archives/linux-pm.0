From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v3] sbs-battery: add option to always register battery
Date: Wed, 10 Jun 2015 16:52:05 +0200
Message-ID: <20150610145205.GE11618@earth>
References: <1433938616-18503-1-git-send-email-frans.klaver@xsens.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53082 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933347AbbFJOwJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 10 Jun 2015 10:52:09 -0400
Content-Disposition: inline
In-Reply-To: <1433938616-18503-1-git-send-email-frans.klaver@xsens.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Frans Klaver <frans.klaver@xsens.com>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frans,

On Wed, Jun 10, 2015 at 02:16:56PM +0200, Frans Klaver wrote:
> Commit a22b41a31e53 ("sbs-battery: Probe should try talking to the
> device") introduced a step in probing the SBS battery, that tries to
> talk to the device before actually registering it, saying:
>=20
>     this driver doesn't actually try talking to the device at probe
>     time, so if it's incorrectly configured in the device tree or
>     platform data (or if the battery has been removed from the system),
>     then probe will succeed and every access will sit there and time
>     out. The end result is a possibly laggy system that thinks it has a
>     battery but can never read status, which isn't very useful.
>=20
> Which is of course reasonable. However, it is also very well possible
> for a device to boot up on wall-power and be connected to a battery
> later on. This is a scenario that the driver supported before said patch
> was applied, and even easily achieved by booting up with the battery
> attached and removing it later on. sbs-battery's 'present' sysfs file
> can be used to determine if the device is available or not.
>=20
> So with automated device detection lacking for now, in some cases it is
> possible that one wants to register a battery, even if none are attached
> at the moment. To facilitate this, add a module parameter that can be
> used to configure forced loading module loading time. If set, the battery
> will always be registered without checking the sanity of the connection.

Thanks, queued.

Please make sure to send patches based upon the correct branches
though. Your branch did not yet contain 297d716.

-- Sebastian

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVeE8VAAoJENju1/PIO/qapyAP/jg8t3ylTx7hyzxcgDf+Cd4K
gaeyFoh+vd/Sf+dSJ7aeZnzqzihyF+RxaeBdEOYkY3+bHtMN6uTEbFmyMXQQalby
ewb+Pt3kgqKFdWgh88WWtgku3hv4uIdFLV2TwfIRVXDOhNsLII91VnGcnFf//EXp
8kya+puVAMsT0E4i4lvo7QMya8Pb7fJZIoaxStWcRiFC1zXCsrmiGCDdjMGc6XRc
dRWT7G8eZc/vD4WDiiKpLXe71UuFtB5VXrHKuSo6iEL1W+VmOVj1YNOsHFl2Dso3
5/MZ7iqVhPQbS0pO8IqMNlNGEpHcjy02qu8AGXKgrv1BzRxa1QR+1aUhi7EhDjXN
CNpxzMIsaVUsCMWmrWHA1ZuOCcK2bNVDTMpPnBeK1EWZHyPSeLHhr3/g93l+UnUB
gQpLPVx4Ve9mc5sHx63y/kEGecsQhOuK3jjHc6XONH0clNgnAr7VUGt6OQBUt4RJ
6OZUkNoNnnkMESYCZZQMObxIT4wYwP9btvZigK0TbXcLdS0ORBZ1kR53Reurb/nJ
5mpBaVFtI/aHseI+/+XA/hORelGzU/XU8psL20mw1DpOTYLXeJAPAzLddVHLFr0p
34+ciL9Za/Mi9MXeujG1rSO9ZxF5PZCWsNc7tSfWNDlwJMoeZS/qZBnwWqRjFWtj
5j1i0VdSWlm8U5Mb3hym
=Y31a
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
