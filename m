From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH v2 10/14] power: max17042_battery: mAh readings depend on
 r_sns value
Date: Mon, 1 May 2017 13:39:57 +0200
Message-ID: <20170501113957.2mak67eu65zadkg7@earth>
References: <20170414183259.24382-1-hdegoede@redhat.com>
 <20170414183259.24382-10-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umlzcjnoqnvvypmf"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57733 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbdEALkB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 May 2017 07:40:01 -0400
Content-Disposition: inline
In-Reply-To: <20170414183259.24382-10-hdegoede@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-pm@vger.kernel.org


--umlzcjnoqnvvypmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 14, 2017 at 08:32:55PM +0200, Hans de Goede wrote:
> The PROP_CHARGE_FULL code was hardcoded for the default sense
> resistor of 0.010 Ohm, make it use r_sns which contains the
> actual sense resistor value in micro-Ohms instead.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Thanks, queued.

-- Sebastian

--umlzcjnoqnvvypmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkHHo0ACgkQ2O7X88g7
+poLZBAAkhhb6ewtSn3MtqFA1Cfo1sfQkr14PXa6cHzbK6xNLFg3NlMcrUCE8NB7
L45YYWE/Qkw39osafyb0IQ2FT49TXOi+22qGb+XxWOZHwkORU/PIqa7FJUGsz+J0
7czkBlouXd7MjezkYMJjAQFd2gsQKopbv2Rl7vievihru1CRUFHHqovqDN7hYPQL
OBY1lH5bs7AtLGOB09hHoUbnld7wYe3pyC6KSu2fHOdKZ1fWT8SWESkV94reiqMP
t6J8yNke6lunY01nUOHT8ilbaKICfaMGeYRJa1Qmo/vKkWHSRwbZtHlMoU4Kimb0
5x+AeQa2W6N17NGVlDXT2JmiaE+M9bb6BX5SVNYN/gK1biqWF9Ey00vHt+BjxDUG
/WxvX0rb1fVgz4/4FQa7CNVbFvl0aU491x+d8VHi3qDh3ttlRlK81l01R0mjvV/q
V1g/WoUI+/r72cJPSAIbHUfqLTV8Zv8Df2t7l5sySuEhW5d/HLo0YW7SewEsqqnA
v5vRVjyWaejEjPy6luO2KLsCj/3YHiUP57/BOIpjYxJbol83sO0ShSt6B8kiNYvp
GFUgXWCswTYqm8R79+ry24qIqpsuIiruWzw6+3ArfAKSB/7CGp0rmznarKRg3bUl
woPa5EJNhyfviXwEsvfnlfa/bSq8ZFoamYE6XSRfmtzgjzdi1Ls=
=GNVJ
-----END PGP SIGNATURE-----

--umlzcjnoqnvvypmf--
