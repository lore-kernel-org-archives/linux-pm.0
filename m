From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 02/14] power: max17042_battery: Use sign_extend32
 instead of DIY code
Date: Mon, 1 May 2017 13:36:37 +0200
Message-ID: <20170501113637.tcfc742a3kx4pyd4@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sdj7lojz2mjmf2jv"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57705 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1166508AbdEALgr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:36:47 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-2-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--sdj7lojz2mjmf2jv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:47PM +0200, Hans de Goede wrote:
> Use sign_extend32 to sign-extend variables where necessary instead of
> DIY code.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks, queued.

-- Sebastian

--sdj7lojz2mjmf2jv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHcUACgkQ2O7X88g7
+pruvw/+Mqw0/7ENjAkAa1Jr1Cd6MpvWlqgVEcfLZYhaSQkSbkvMq1opRpklwURK
0nEQhNaKSBxno08JFQONwOL+8Fw/5iVyrgnuZVkAL0Y0DxSD5+6QH3qvRruzWJut
rSF3sbIGL1ZFmHGJ3sJgdYc68m7xK6PxQmBi4pS6uOZ4amhjCOWv3jFtOZAtL+vZ
iBOxJCBJxVBAlsPHIT9BJKVjZel1fwSGeZd5TJ2RWIoG3mw+R3WM12GnQNxG0Lmk
8fDfX7T0vc/26pqGCH3RViCFd6esfznNu+7hvMZQW3FSScOCI765rwnpEnHW2ZLx
q9PtxEDSAXaogDCq2Qx7wScGrxlCAC2WtLaZeSN4ptCrWMPlUXwwOtU+k/Zlsl8K
DBZrSKYiN+MiXNuSH8SVSlFRtUqv4uxJB3QEQY6bFVfEK5BrS1oyTaoO3LDCmEik
4uNQN2iqB03jfs2X1m0E2g2lqtlbHSqX2xdqYHp+U2/NsmA7jMduIXLDFtQppgNx
b+Xi9hVikFbVgbWgRqW1wZxLfsR6qZtvE34/EwY7KlcsGJJ2zsaXNGXxrCPuiavj
fFPiIP1IcSnPwa4zXgBlqVQQJS5GDv4Lb4S0CYKAfvg79ZySCMxOahqbV1p6dORv
T8CudkfMA85eoYxcOIJGG2SIaAWcq0jwphoLnh8zEK/Qte00M5I=
=glQX
-----END PGP SIGNATURE-----

--sdj7lojz2mjmf2jv--
