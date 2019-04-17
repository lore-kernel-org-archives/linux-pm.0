From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 0/2] fix leaked of_node references in drivers/power
Date: Wed, 17 Apr 2019 23:33:39 +0200
Message-ID: <20190417213339.dcfie6ufix4udnb4@earth.universe>
References: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vzrgbwwcfimkcmbu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
To: Wen Yang <wen.yang99@zte.com.cn>
Cc: linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


--vzrgbwwcfimkcmbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 17, 2019 at 10:43:01AM +0800, Wen Yang wrote:
> The call to of_get_cpu_node/of_find_compatible_node/of_parse_phandle...
> returns a node pointer with refcount incremented thus it must be
> explicitly decremented after the last usage.
>=20
> We developed a coccinelle SmPL to detect drivers/power code and
> found some issues.
> This patch series fixes those issues.
>=20
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>=20
> Wen Yang (2):
>   power: supply: fix leaked of_node refs in ab8500_bm_of_probe
>   power: supply: fix leaked of_node refs in
>     power_supply_get_battery_info
>=20
>  drivers/power/supply/ab8500_bmdata.c     |  1 +
>  drivers/power/supply/power_supply_core.c | 24 ++++++++++++++++--------
>  2 files changed, 17 insertions(+), 8 deletions(-)

Thanks, queued.

-- Sebastian

--vzrgbwwcfimkcmbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAly3m7MACgkQ2O7X88g7
+poPjg/+L8blp16+dARwSFccWIVeweTaBD1RP61hvO58sYDQ/ia+dy+TTzFFhQy8
rmNO/NvpHrJT+bdD5er2Qt1vJ8GE87H+v6l6jMB+p92P5/YAAj32MFDPJZvsQsZU
SDrEkcIO/mRLSu0r2Dr7odIq9hQya06a/P2Mx26QSOw+wv5vyzbI+CFjkDjA8YQt
rYKQ0YA62yKF8R8PlncnIWRjQDlzYlE0NGGP/FpDyMzrxQTYKWeK14LfpJDTcJYn
Q+jVwrSBVhcYvIErXdn0HcEHPEHH3RJatmTkh+rzh8JULz6ZxQdhW0uQl6RQZQTK
0IMHcXc3XCl5J6XhBIwBBb7y/A5Wr1JsCfB4L0yCOvV+8nkiDiEZSYc1lS75NflG
Xkn/TZG5gIco9nAzrZ4eonwPeUFCFwJNwUSE6cCdcfJr5KK1pQAiNo7AaRzMcy6P
XN9wExf52y4EsqOvHBOl/CqzSW92WLXBLdPRt33428Z2O9ggcE2RUoH3GiCmzirH
SXKDrwMJV+z9lWBCjhCaIg+eOqlEg+mtDxflH30DNn1cHz1zMZ6WYdCBeRKzBE/Z
YHVeBPqxWLFjbQmxFcVtknpXFaqSD0oedqujtq13NHQx6NY5RmttIIAEJq+XkPgY
GCi8VTs/J59RZdttY0NyKRm+j4vdDOcodQoTT4TP88Xh4pyKHRw=
=k6Zl
-----END PGP SIGNATURE-----

--vzrgbwwcfimkcmbu--
