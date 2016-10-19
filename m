From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 08/15] power: improve function-level documentation
Date: Wed, 19 Oct 2016 04:59:30 +0200
Message-ID: <20161019025930.2gwxpcf4w7dduhju@earth>
References: <1475351192-27079-1-git-send-email-Julia.Lawall@lip6.fr>
 <1475351192-27079-9-git-send-email-Julia.Lawall@lip6.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7tms4a7ug3sdfyep"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475351192-27079-9-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--7tms4a7ug3sdfyep
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Julia,

On Sat, Oct 01, 2016 at 09:46:25PM +0200, Julia Lawall wrote:
> In drivers/power/supply/ab8500_fg.c, fix two typos and adjust the function
> name in two cases to correspond to the names of the defined functions.
>=20
> In drivers/power/supply/power_supply_core.c, change two variable names to
> the names of the corresponding parameters.
>=20
> Issue detected using Coccinelle (http://coccinelle.lip6.fr/)
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>=20
> ---
>  drivers/power/supply/ab8500_fg.c         |    8 ++++----
>  drivers/power/supply/power_supply_core.c |    4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)

Thanks, queued to for-next.

-- Sebastian

--7tms4a7ug3sdfyep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJYBuGSAAoJENju1/PIO/qavtoP/28YsmoivfY/bpENA/cLlWes
C8I3W/iJRBPR5ohhMK0zaW81gFSb5mxZv6s5FEa0gSXWxi0Iw+gltzOcRnj7jsBS
hqLK81Ecwian5emqrmi+Wq8qvqCNWA+TdDdhE22nrsoJehNBcKzJvj65wwDzqQA8
B7yu1DQFD8G4NttHtFiVGZkTTm3HZCYOmYbw0w8v3Ja6CKmYDNfhuszEhtLLKJgm
8cNtFBJqKb1dKzc/Ewu2qnTXaxlICaCBVhhAc2a7iLbEruSu+snhE90b5/82qs7L
zjvMVOjpu7iD5/tcp7H2RUx20mQ1UaZ0TrNrlZentZ32rVbjBWtfgLioBXCC5HE5
T7R5ZAMfpXSs8NZZaBaYuT3rp01IIJ/+SL3h/za6TCNjdvaZvNm2NbuydH0CpEnF
8j9G01zGN2TyJis49PludlnLYZNDTI4WQPjgBrsIZPcWns+gNH/RQ+ZCqTjoVb/5
aS+3o0iapldBg2PGN5pJH5wzZCMZvHTzWK3vuX2f8Uk8MYo+qYhjaqC2D1wLs+Y0
00JFvKxphY8UsXQNYsH8RPGoWGtpsk4T9uSl2G7JbDLTDKwWhfF/wHO37UpSi94H
+U/+OVv9HLXrPkjww+gjjDQGVRbKJRuKRMrwmZyp1oMowVElJnMGX38rj9Z08fcj
1CHl4NvwqNYPatbzdh6W
=S3gU
-----END PGP SIGNATURE-----

--7tms4a7ug3sdfyep--
