From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [RFC Patch 1/4] mfd: AXP20x: Add power supply bindings
 documentation
Date: Tue, 21 Oct 2014 22:10:42 +0200
Message-ID: <20141021201042.GB7893@lukather>
References: <20141020221959.2f312906@neptune.home>
 <20141020223314.0484f795@neptune.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:51345 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932520AbaJUUPV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 16:15:21 -0400
Content-Disposition: inline
In-Reply-To: <20141020223314.0484f795@neptune.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org, lee.jones@linaro.org, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, Olliver Schinagl <oliver+list@schinagl.nl>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2014 at 10:33:14PM +0200, Bruno Pr=E9mont wrote:
>=20
> ---

You're missing a commit log, and your signed-off-by.

You should go through Documentation/SubmittingPatches, and make sure
to run checkpatch.pl, and fix the warning and errors.

> Note: the OCV values seem to have some defaults build into the
> PMIC though may need adjustment if the used battery has a different
> open circuit voltage curve.
> As far as understood (these values are set in vendor driver but not
> mentioned in chip documentation) they represent charge percentage
> for some predefined voltages.
>=20
> If prefixing these values with "x-power," is preferred the following
> patch should becomes a dependency:
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267606.=
html

Feel free to fold that patch into your serie, since it seems to have
been forgotten.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJURr3CAAoJEBx+YmzsjxAgf8IP/3P26r7Z6A5RIRs08Q4hrSCE
QF6W4a7yw9t/ZCBXWHyzGG6/wlm+vRx/dbdxSsNP4eYQ/hgw9Ee2gKhLFKMHd7mw
rKVT00DA8Kh/aABUXjtDANNUcWGOTMwsHumyYvG98Tsp9k46Odd082CZIW2qnCo2
eDC6JXFiSliQ+Dg2wZ3UtjhqBSDAY6sq3hcb4GeX0DYBKo2fPv1OM19kaCUylpyN
f7/WMHNBv6gHV6XARAsTdNxmoEDW6RrTOSk1oFyOeyxLmDt3njjfCA+2hpPzHa2u
aeg6AY3mcrJ3qQ5D2JK6gX2KK/VDLm728/xTd9BdLV51gKvOJTbqSQU8NGIwmL7x
NqH5m7VZJwp8gomd50/cPOtxPa3aeV+H8Whs07YtNpP8Fdtkm6M/zeOjwCMnKy/7
mWER9xpTGk/LfrLCj427AiAhXYyu9OZW1dGquhZ/twYdU6FsRjQLqHBlUuuJBBRz
RXJFSK/UoiSEZ8SaNA2LPLHLeqbtqyhJZzEzXi5StUc9ibr/25ip0HbtHJkiXGsg
0TXKsx4PU9LAwybkHU4kiOZrBrPG3sz/+ncjqkfnIXuU7L8S9oTStLxQQ4XncJoj
VA+zVFc679lquJHubANTXYdkbmvqO38PawxKUJ5nxSd0VvJEXoODo8zbX+XQx9fI
UOYoCBesDaLq0IQcna6d
=1Xaf
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
