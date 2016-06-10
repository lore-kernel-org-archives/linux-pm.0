From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH] cpupower: Bump soname version
Date: Fri, 10 Jun 2016 01:56:20 +0100
Message-ID: <20160610005619.GQ7555@decadent.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="O7hm+SMpb/lu0d4d"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44406 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751315AbcFJA42 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 20:56:28 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org


--O7hm+SMpb/lu0d4d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Several functions in the libcpupower API are renamed or removed in
Linux 4.7.  This is an backward-incompatible ABI change, so the
library soname should change from libcpupower.so.0 to
libcpupower.so.1.

Fixes: ac5a181d065d ("cpupower: Add cpuidle parts into library")
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
I have to say the choice of variable names here is rather confusing.
LIB_MIN is used for the soname version, which would normally be the
*major* part of the version.

I'll send a second patch that switches to more conventional library
versioning.

Ben.

 tools/power/cpupower/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 8358863259c5..0b85f5915ce8 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -64,7 +64,7 @@ DESTDIR ?=3D
=20
 VERSION=3D			$(shell ./utils/version-gen.sh)
 LIB_MAJ=3D			0.0.1
-LIB_MIN=3D			0
+LIB_MIN=3D			1
=20
 PACKAGE =3D			cpupower
 PACKAGE_BUGREPORT =3D		linux-pm@vger.kernel.org

--O7hm+SMpb/lu0d4d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV1oQM+e/yOyVhhEJAQoFXxAAuFTS8d/P0fZ6oIyj45IOI+D/8OfGkFZu
aJU2REx75HxvzrH/ozgHNdUwWjRRWuP/DNesiANBQp+2I+MMOJnJYDFZ1ke7YYFz
1KkEsNy9NRoevT3Qk1XBm6W/8tlNNB6Br5SCl4ebggssfNRvfdyUd87d5Yan8Ys5
LlInQ2EJHOUFb5NcpoJO55fBeFnbppdwor8W3TSSUOXdErFh05d0J/XlMLgjj15j
RbFtJBsGdM90GfptTVFte5MVMpo2JmlUZdDabG968U4V4bCu2ftRVZU158nubX/u
LtwdTJfOKx44drGugsL/1AEFu/gTnJWTiYK2ewsDBKFGzMXhiN0w4jsBFMG2g/0t
1k9eAXejzg9XU2+QXYaIvSvmlxjqYjtjXGcxgxixB/Kg+vVxk1BCNsBMc8kJB8D9
k92FTVXL7CFTAaPHfvF1C8Z4yV9F/h6nkMTWdb6J99aFpvfPAxhd1EBgKkz5sQoo
Fhw7wsDYU/HJCdhzEOawU6pEm9t91c1MkmeiK/iNblxYGUQ09FaOivPOhFfv2hyL
hxqacQv0GMbNQZs8cGmj8pceXbCMUNwL66hnyd7CUWRhRZMI4OnAumyeEzG+tLHB
tQJUJID6UicHB4tJzRKyid4KZhErphdDMEuj3VW6E1E3ZE9+GTn2c/5MHu3Drsuu
tTxsGMgVc6c=
=i0qs
-----END PGP SIGNATURE-----

--O7hm+SMpb/lu0d4d--
