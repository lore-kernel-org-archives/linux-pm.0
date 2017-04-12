From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v2 2/3] power: supply: New driver for LEGO MINDSTORMS EV3
 battery
Date: Wed, 12 Apr 2017 16:53:43 +0200
Message-ID: <20170412145343.2bexmzmpovjvgoml@earth>
References: <1491944723-32174-1-git-send-email-david@lechnology.com>
 <1491944723-32174-3-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ghggnffabxt3fu3"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754004AbdDLOxs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Apr 2017 10:53:48 -0400
Content-Disposition: inline
In-Reply-To: <1491944723-32174-3-git-send-email-david@lechnology.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org


--7ghggnffabxt3fu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Apr 11, 2017 at 04:05:22PM -0500, David Lechner wrote:
> This adds a new driver for the LEGO MINDSTORMS EV3 battery. The EV3 is
> an embedded ARM device that can use 6 AA batteries or a special rechargea=
ble
> Li-ion battery pack. The rechargeable battery pack presses a special key
> switch in the battery compartment to indicate that it is present.
>=20
> The EV3 is only capable of monitoring battery voltage and current. The
> charging circuit is built into the rechargeable battery pack and there is
> no way to communicate with is, so we can't provide any information about
> charging status.
>=20
> When not using the rechargeable battery pack, it is most common to use
> alkaline batteries to power the device, but it is also common for people =
to
> use rechargeable NiMH batteries. Since there is not a way to automatically
> differentiate between these, the technology property is made writable.
>=20
> Signed-off-by: David Lechner <david@lechnology.com>

Thanks, queued.

-- Sebastian

--7ghggnffabxt3fu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljuP3cACgkQ2O7X88g7
+ppf6A//QpmnYWnE6+PBAWU6sfXe72bp6aq1eONL7yN8YwosZ6b7X+tsBfuu1HrJ
YDOgAc/E1XCQ+Ny0ov1j967y+qiTw5OtfKPhnEjG17COh2B32HwXe6j0/tfrbLC3
StSaq9P3ADlzp2orIFWroGMPJ83Nm6EU22G/pnwI8NaA2dvscK+b9rFiuQy7YYpO
A77n5zErjeyVJj7EjGnNCQVFAcojr852OCCPwGO0IjGTqVb02LJA7cYPT7COSC5d
V8EMDOeejzl1t4AR0s1KPCJELVw3TceXrJjshtWqSs1oXpfJhlOFpS3Vk8Bs1RkX
t463I9cEVIAoO6x5p69n1cWXat0cuJoeIjDnUTHUVy11AALvDZOpJQCgGYhyH2U3
1CBjydGVArUJMRFZJiUqeyyZ5EgR6ai62AaCyhzQIDjyUS2qodBduH3dBWixSLOC
7BkQlefUu4syUfOXudMR3S74yZHQNYu6h/hTKnzyHk8RMwE0gd5DQ9ZYVOryAOwp
bXkujYRjCIoMJXtvl+AnVi7wkGcndlltBa9BXaaYIwOUQt8Se29+SJIyexaDGdvK
DDo1bAjXNljwuLJbxBwlg5Xamrq6ZJ0N1qYnkf7+QPVnDo5H8av8nsT/2idHYmPQ
UJT/d9WuSWu0ss1dc8HYuu9JEcQlMzxi8qDAZPK033UlylAeaQ8=
=QmcQ
-----END PGP SIGNATURE-----

--7ghggnffabxt3fu3--
