From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] kernel/power/suspend: use CONFIG_HAVE_SET_MEMORY for
 include condition
Date: Sat, 3 Jun 2017 15:27:48 +0200
Message-ID: <20170603132747.GA18185@amd>
References: <20170603105232.6436-1-bsingharora@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="0F1p//8PRICkK4MW"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:58237 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdFCN1u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jun 2017 09:27:50 -0400
Content-Disposition: inline
In-Reply-To: <20170603105232.6436-1-bsingharora@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Laura Abbott <labbott@redhat.com>, Andrew Morton <akpm@linux-foundation.org>


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2017-06-03 20:52:32, Balbir Singh wrote:
> Kbuild reported a build failure when CONFIG_STRICT_KERNEL_RWX was
> enabled on powerpc. We don't yet have ARCH_HAS_SET_MEMORY and ppc32
> saw a build failure.
>=20
> fixes(50327dd kernel/power/snapshot.c: use set_memory.h header)
>=20
> I've only done a basic compile test with a config that has
> hibernation enabled.
>=20
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <len.brown@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--0F1p//8PRICkK4MW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlkyuVMACgkQMOfwapXb+vKqiACgsMSxufg1wAVvLohzPAZfSlB9
NYsAoL/FZU1kYxaCMvv+3mNf5hazTohM
=zEhb
-----END PGP SIGNATURE-----

--0F1p//8PRICkK4MW--
