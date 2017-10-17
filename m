From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v7 2/3] eeprom: at24: add support to fetch eeprom device
 property "size"
Date: Tue, 17 Oct 2017 23:36:02 +0200
Message-ID: <20171017213602.r52nkxgaqtgntbjn@ninjato>
References: <1507615237-21744-1-git-send-email-divagar.mohandass@intel.com>
 <1507615237-21744-3-git-send-email-divagar.mohandass@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pjtstpantw4zdngp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507615237-21744-3-git-send-email-divagar.mohandass@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Divagar Mohandass <divagar.mohandass@intel.com>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, sakari.ailus@iki.fi, tfiga@chromium.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, rajmohan.mani@intel.com, mika.westerberg@linux.intel.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--pjtstpantw4zdngp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2017 at 11:30:36AM +0530, Divagar Mohandass wrote:
> Obtain the size of the EEPROM chip from DT if the "size" property is
> specified for the device.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Signed-off-by: Divagar Mohandass <divagar.mohandass@intel.com>

Applied to for-next, thanks!


--pjtstpantw4zdngp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmd8IACgkQFA3kzBSg
Kbbp0w//Wio3Wiori0EGFhNlN7kDZR2ekbOvD6kna6Zs5owdHXSxWEmDbG5vxMTu
GtkrdaeY+8cYAWZYF22lS1epr2LX2zvVPKKGv/NBW3pfwjv4xxG5kXoUGzoAehAJ
E9ddZqgjw9IDFkdO/kghR+GBpkDsR003lxw/mrk8LkaYhT1z/m9hK4/Z696b25K5
/KnfPAtDCnLJmBwTIDDAKOiMMYEHsfqSH2Iz3TgpaBWtS4ni63hPaIBq4rNPh9v1
HIRUhY+ZBhxUIhSyXKxhSKQjNamQvp1Jo+kTPCyR1v50LYk3Z+JHXHIDTSQ4Ls1+
9AGriL376mtXaRQKYnwZjOCxWSLprrQY3W/l27NTtHvGGb+afnN+dvnoYQxtprnR
Jiab/oRgvoXGMzgmvcLmr82GOHadYZrkeTehddQ8ffBzwCMuZc4sZN49yUtMdE6t
gcqKx3fqaUIjRwn/QgYjxIe2k1d6ulueqC+5rsBP1QTDGyzO4BJGjjcFs7xQN7Es
xG/hlqgrLyRrhN5EJjWpu6dOl+yxVsUBbEDf6c3CxGJJL9jaIccgKFWIMN4ZJn6d
TM7dvUbc38rUrLU0bT03+KxD0krBluqfzb/Ur8m8986ayBASAegzYPFxCYSt74RB
/5VJ1sEqegD5qIyZr+kgnD8CrQIozk/47boB/P335NWAbxIpul4=
=Xvzu
-----END PGP SIGNATURE-----

--pjtstpantw4zdngp--
