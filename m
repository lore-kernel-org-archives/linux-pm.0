From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2] pda_power: move from timer to delayed_work
Date: Mon, 1 May 2017 13:33:12 +0200
Message-ID: <20170501113312.mhm4rliuxoiqtkwu@earth>
References: <1493126285-24695-1-git-send-email-anthony@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kszgu56h6f4aebxe"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57687 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3000375AbdEALdQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:33:16 -0400
Content-Disposition: inline
In-Reply-To: <1493126285-24695-1-git-send-email-anthony@amarulasolutions.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Anthony Brandon <anthony@amarulasolutions.com>
Cc: linux-pm@vger.kernel.org, Michael Trimarchi <michael@amarulasolutions.com>


--kszgu56h6f4aebxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 25, 2017 at 03:18:05PM +0200, Anthony Brandon wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
>=20
> This changed is needed to avoid locking problem during
> boot as shown:
>=20
> BUG: sleeping function called from invalid context
> [...]
>=20
> Fixes: b2998049cfae ("[BATTERY] pda_power platform driver")
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>

Thanks, queued.

-- Sebastian

--kszgu56h6f4aebxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHPgACgkQ2O7X88g7
+ppwKhAAgOELVQ8u4fXqhaRPewpxY80IXl8hLV9yYDHYq/HLOkp/UU1fTRF/wxtR
cTrlewhQejw73M4Ujo/8chZ3iZJa6la00gpoXVXXz0AeSWTnGtzxfzrQiqAjEwQS
BTMa2/hd+5WsYz/OU+cjIyvkIPetxsxAGGdrTn9fcqMc5NtXsb5qL7T8Ddl0S3KO
vHYOfG09VfTvIEBZ0CL/cxm5fNlNc0DNqIDcZVwkI8rL2u2sJGRZ/M+PJ0QquQJv
zWFMmZ4ovgN2MAMd6Y1PAlOGN/BHTrzafRPBb1shIR81ogFQC2nLcMkVVNrkKT2u
9JzLrHWl3wIBvFNmc0HImqHII1wg7k3PFnbQfjprNIJHX3Vzal99zDikg4N6wYaN
gRDLA7p6jGwX1CJGu2BQOZuWbyoD9QHFrtOFogDRxzoWVEjtUmnnc6FbG2pV4gaQ
QJmTuEzkR8uvDtMQ11up6XA7gm3MGrhVuyjn2LmnM4BaShUc9x3a/hKj8oEPA91q
964nv0mdt6ICUP5a4N3IPpN3THTme2gEkFd9x2EGOAbARHfQFxXxmFFDe7vTLlew
AiQZWoi1BTbuZpbK7t3T5AMSC13HmmhB+7ArvDDWg7+C8bVcYGLHbUy9t2jLbftm
OYohmngbRRigmJiIinDTDE3sioJzrOcXfe1j7QMiI5Dy9LtQ6Qg=
=DDOC
-----END PGP SIGNATURE-----

--kszgu56h6f4aebxe--
