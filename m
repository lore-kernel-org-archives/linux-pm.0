From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v1 1/1] power: bq24190_charger: Deprecate battery class
 and replicate its features in charger
Date: Mon, 1 May 2017 13:29:22 +0200
Message-ID: <20170501112922.zmpb4v3v5kawu223@earth>
References: <20170416230626.30022-1-liam@networkimprov.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cxibxnrzdpy6yqhk"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57641 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755256AbdEAL30 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:29:26 -0400
Content-Disposition: inline
In-Reply-To: <20170416230626.30022-1-liam@networkimprov.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Liam Breck <liam@networkimprov.net>
Cc: linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Hans de Goede <hdegoede@redhat.com>, Liam Breck <kernel@networkimprov.net>


--cxibxnrzdpy6yqhk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 16, 2017 at 04:06:26PM -0700, Liam Breck wrote:
> From: Liam Breck <kernel@networkimprov.net>
>=20
> The driver was registering two classes, bq24190-battery & -charger.
> Because the power supply framework cannot surface features from multiple
> drivers in a single class, a fuel gauge driver would create a third class,
> which some power management utilities cannot see.
>=20
> Deprecate the -battery class for future removal and replicate its features
> in -charger. Set /sys/class...-charger/online =3D pg_stat && !batfet_disa=
ble.
> If device_property "omit-battery-class" is set, don't register -battery.
>=20
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Liam Breck <kernel@networkimprov.net>

Thanks, queued.

-- Sebastian

--cxibxnrzdpy6yqhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHBIACgkQ2O7X88g7
+poGzA//Vw3HbahHg6Bo31Tc0PdkdqV4cnvxaskYEjebbcTYS5LFdwWkReTRbIcs
oHpQB035jOhTfCs8T6V2Q8n1Ree8IgfspR5S73hOdC7aXbd/Ln8mVFkfW5Tk/o25
6ru9DaSCbD0tGctigTv7BjIxtBXDmemgNahaKZ2qtERl2GmDM/1TcovIJ3XDH79j
h80UCMVatnMOeKNXdInw3pw4FILK6kf72ikEJkDYf5j0N3KR2I0CiKOZI9YeTLl6
KU/4WxrN0RO/Q/9syX72KkYidc7CUBVMeEm++8/yJOGrd1HrDhwdBDuY3um/HsS3
/IBaWHYmvF4/V2AFem2NMsNi/2GfnM4M+xecg/1CAC4t7jtICYJIRzQhko21g0+b
N9vruZ5hAssPNeZIg3RbAfZs5m8KjJHV3bIU6+6mnWI+4a2+DrKsUHcU2QWxM7ez
+BM/TfYtC5/QayqUwJG7P5ph1wtprqn1P0/iKfw4TUaHNCZvpmRE6e4GXzew3exZ
EGHprLTwIbHtdEaUKEf7XqXRw5/iEKzMj4yzqqZvBZJDnt6TyY23ED6/rEDfFQnh
GmpWFZpHzGXtSsADwLaCe9Zr+R4imyHabpkn36w4UMRxVqVVAIQi7BwO/XgIELMI
BhVSPdmPq1hKuAWeFHPBomvKfn8zcfFb3cmLRA57iLknvqN8rCc=
=A1Rh
-----END PGP SIGNATURE-----

--cxibxnrzdpy6yqhk--
