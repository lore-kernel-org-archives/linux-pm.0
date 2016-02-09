From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH 0/3] randconfig warning fixes for thermal
Date: Tue, 9 Feb 2016 14:18:16 -0800
Message-ID: <20160209221815.GE28102@localhost.localdomain>
References: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33817 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512AbcBIWSV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 9 Feb 2016 17:18:21 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp3so689335pab.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Feb 2016 14:18:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1453740264-1972562-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, spear-devel@list.st.com


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 25, 2016 at 05:44:09PM +0100, Arnd Bergmann wrote:
> These are three simple fixes for ARM randconfig builds:
>=20
>  [PATCH 1/3] thermal: spear: use __maybe_unused for PM functions
>  [PATCH 2/3] thermal: allow spear-thermal driver to be a module
>  [PATCH 3/3] thermal: allow u8500-thermal driver to be a module
>=20
> All three bugs are on configurationsn that are not important and
> that rarely happen even with randconfig builds.
>=20
> 	Arnd

Thanks a lot for your cleanups Arnd,
queueing all three.

Eduardo Valentin


--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJWumWlAAoJEMLUO4d9pOJWvC4H/0joKNhCC0IO7g0RNbDUhSDr
oOsLpPZf1G6hGEREmhbBjqY2eE6PhFlPVotka+RjijDBpAXz50qt2eXxbqD+67C7
/ClbljN795UvshnKcBy+Pdsld2s+fHLcLZ8pc06RCm2yhiZBjeViVejuGjhaAVm5
4pxHVPw8EFUkn9wkApzA6C0FTTgzY8fS3gk+yPK2s2fY9cXruI7l2R+2+Y5HMHMb
Ek1CEg+S2pvBld7wq4AC6eov7ebHTlF27rN1iZIifkn2f88JWXTElJj+e2vaisGb
n8T7CrGq2lImKSuyRpJa2Xidh+ZJ4pNExsUdz/EVcoBdgq86q/hXhxDFqJVC27k=
=qoLj
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
