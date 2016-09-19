From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] power: bq27xxx_battery: add configurable
 poll_interval by sysfs
Date: Mon, 19 Sep 2016 21:46:03 +0200
Message-ID: <20160919194602.isutlr2thnyxck6m@earth>
References: <1474083775-30185-1-git-send-email-matt@ranostay.consulting>
 <1474083775-30185-2-git-send-email-matt@ranostay.consulting>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="akgwchrvnz5crz5n"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751817AbcISTqK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 19 Sep 2016 15:46:10 -0400
Content-Disposition: inline
In-Reply-To: <1474083775-30185-2-git-send-email-matt@ranostay.consulting>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: "Andrew F . Davis" <afd@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Matt Ranostay <matt@ranostay.consulting>


--akgwchrvnz5crz5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 16, 2016 at 08:42:54PM -0700, Matt Ranostay wrote:
> Allow the poll_interval to be runtime configurable via an sysfs
> entry.  This is needed for udev control of the poll interval.
>=20
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
> ---
>  drivers/power/supply/bq27xxx_battery.c | 48 ++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)

New sysfs attributes should be documented in Documentation/ABI.

Also I'm not too keen to add this, as there is already the sysfs
entry for the module parameter. I don't see any reason why udev
should not be able to change that value, so fix udev instead of
duplicating functionality in the kernel.

-- Sebastian

--akgwchrvnz5crz5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJX4EB3AAoJENju1/PIO/qaXekP/jAzTFIxn3ljhkNHEgemNkSZ
UTfLbLp0kTdcoYuB7wtyMAbSie1NUCdKtexYz6MaqHC3nwMDJcAFK2lL/2/dLGWf
eyZlYatHsyr3oVQR6dbLUyEY0TGG6Qi7fULvkdBrXfNA4tqqSvtwlDeprpsbnq/b
T0/Zr4aBUvgLYZHQACjCVHlo4dkCw0b90uX5k4f36hB57KrHXSNuDU5S7lxgZS3d
xBwX0ikQ9Hx+42sCLrSXfyZl+oyy85khZMKrrG4u+k7kbtHkAHXcDsULszzbuDlU
1rI2zr6QAD+VW9hP6abepifCWxUTHJdVWQrgqfIRyFawR7rKN3ulk5qEi+EwvmxU
62Durm8+Vyqd8+lCQp9sHRWnLjE+HRqke4Uhkw+L+OanPtCm3ZhVQMqR2dyCnSuc
Hfdi0ysdvtemmofVtWxx81llbsP6ClW2PVpYw/qh3XXMxfr1ZgWvlMiL6k/Duv9l
MI6LKno6xpUaNq7vOMa4t4J/msTimzzT5SDZlNwSxbIwI3+EZQ3FiKp35tJKuphA
dcB8Lr+/z4Q4dGuYz2LPXUOy92iPVYIYSmhbnipmFAOFJOUw8t2cgWZ3HfukGO5M
nR+3dJkHsC6s3nKeC5Oj1S5rdWJ0hoxfc7Hqs2CMWFVJr7AxBK9Tt/aSTq/eH8pA
9h+UaFafhQ9G300UNniR
=zC4D
-----END PGP SIGNATURE-----

--akgwchrvnz5crz5n--
