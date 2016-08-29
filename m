From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: bq24735-charger: Request status GPIO with
 initial input setup
Date: Mon, 29 Aug 2016 02:36:53 +0200
Message-ID: <20160829003652.hs4tk7qmvu25mqhb@earth>
References: <20160828173446.32728-1-contact@paulk.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="63nxqivkmvs6kxf5"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756187AbcH2AhN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 28 Aug 2016 20:37:13 -0400
Content-Disposition: inline
In-Reply-To: <20160828173446.32728-1-contact@paulk.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Kocialkowski <contact@paulk.fr>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org


--63nxqivkmvs6kxf5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Aug 28, 2016 at 07:34:45PM +0200, Paul Kocialkowski wrote:
> This requests the status GPIO with initial input setup. it is required
> to read the GPIO status at probe time and thus correctly avoid sending
> i2c messages when AC is not plugged.
>=20
> When requesting the GPIO without initial input setup, it always reads 0
> which causes probe to fail as it assumes the charger is connected, sends
> i2c messages and fails.

Please convert the driver to devm_gpiod_get instead.

-- Sebastian

--63nxqivkmvs6kxf5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXw4OiAAoJENju1/PIO/qaZ9YP/RwGU9+ivW2Ck8/sAp94Xxir
15FWfvaNWb6EuiVdgoa4btSsdKQYVgFWtDF0H1fJNOHS6zX6sFB/WTQEc2tzEHTK
MzBuQ8FNjSoVGFIcIOLKta5KJ0ndRQn1Q24Aw0BsMHtxVR5rB/LFVtY/KsVzzMvd
6Blg+6ha1K5fYYkYfuQyslxBx3OWfs4axODkLWz+6iFOBImqu3tqKpTPAJQBRNQD
bDgy68esfedzYunnJGQoarS3kgyUZ/v+/FtqI0L24mYuhCtK+6iK7HceDXuE5RLd
D6lbM4PeXicf8jGaT3kHhVmMhAkQFmUuyWu5LoOOeJZjZZ7ybBPgms6hHIQn44+G
B4cXEPYj/+ZpLbRD01roit5p0Cv7DChu4wVJeJRW9WiTQkheD2rp58ui2TXK3c5c
ckW6bYm/CiUiMj/FgwT4r/sIl5PVwWztgVCjsJjWqN2VwGfH8urKBxvHz2nxDnrk
TcttbQOvetUUf6FYRUEKvQ2ju/6weS8m5Qy1T4tMHir1PPa5oNwBte1Oe7dTXPe/
6DGPlesUU9F56iOU2b1oL5bbm1q+XOeOGp0s4I6CNGjfq+RvReSLPzjNA+FbI95G
jIt4S2kkiO7L+tJ7AumCFwHFUFsRcgksPDXcTQgWbD6JBfpScLSyQhV5Wk4O5Hfw
TREQtsJA8Xa2ddBGMr72
=YLUL
-----END PGP SIGNATURE-----

--63nxqivkmvs6kxf5--
