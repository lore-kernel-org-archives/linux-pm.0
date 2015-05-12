From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH RESEND v4 0/2] 96boards: add thermal senor support to
 hikey board
Date: Mon, 11 May 2015 18:31:09 -0700
Message-ID: <20150512013107.GE4810@localhost.localdomain>
References: <1430707940-14468-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:33811 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932349AbbEKSbL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 14:31:11 -0400
Content-Disposition: inline
In-Reply-To: <1430707940-14468-1-git-send-email-kong.kongxinwei@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Cc: rui.zhuang@intel.com, amit.kucheria@linaro.org, punit.agrawal@arm.com, Javi.Merino@arm.com, jorge.ramirez-ortiz@linaro.org, haojian.zhuang@linaro.org, linux-pm@vger.kernel.org, linuxarm@huawei.com, devicetree@vger.kernel.org, dan.zhao@hisilicon.com, liguozhu@hisilicon.com, mporter@konsulko.com, gongyu@hisilicon.com, guodong.xu@linaro.org, robh@kernel.org, leo.yan@linaro.org, zhenwei.wang@hisilicon.com, zhangfei.gao@linaro.org, z.liuxinliang@huawei.com, xuwei5@hisilicon.com, w.f@huawei.com, yuanzhichang@hisilicon.com, mark.rutland@arm.com


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 04, 2015 at 10:52:18AM +0800, Xinwei Kong wrote:
> From: kongxinwei <kong.kongxinwei@hisilicon.com>
>=20
> The Linaro connect introduce 96boards series in Hong Kong,The HiKey board
> is the first board to be certified 96Boards Consumer Edition compatible.
> This board is based on the HiSilicon SoC. you can get more information
> from https://www.96boards.org.
>=20
> The hisilicon SoC contains thermal module, this thermal module has 4 sens=
ors,
>=20
> 	- sensor 0: local sensor;
> 	- sensor 1: remote sensor for ACPU cluster 1;
> 	- sensor 2: remote sensor for ACPU cluster 2;
> 	- sensor 3: remote sensor for GPU;
>=20
> It can obtain this device temperature by operating this hardware. The new
> sensor driver satisfies thermal framework and to realize the ACPU ,GPU and
> so on to cool function.
>=20
> Changes v0->v1;
> * Delete this hi6220 dtsi.
> * Fix documentation and error checks.
> * Modify this driver which makes use of kernel to decide how to dynamical=
ly
>   bind the interrupt to hottest sensor.
> * Delete "sensor-thres-temp" property and read thermal_zone trips points
>   replace of it.
> * Delete "sensor-reset-temp" property and define the fixed value replace
>   of it.
>=20
> Changes v1->v2;
> * change patch's position between binding document and driver file
> * clean up some regiser for enabling thermal sensor
> * use mutex lock to replace the spin lock
>=20
> Changes v2->v3;
> * delete sensor id property in binding document=20
> * fix sensor driver to satisfy sensor register after deleting sensor id
>   property
>=20
> Changes v3->v4;
> * using "usleep_range" function instead of "msleep" function
> * delete code detail error
>=20
> kongxinwei (2):
>   dt-bindings: Document the hi6220 thermal sensor bindings
>   thermal: hisilicon: add new hisilicon thermal sensor driver
>=20
>  .../bindings/thermal/hisilicon-thermal.txt         |  23 ++
>  drivers/thermal/Kconfig                            |   8 +
>  drivers/thermal/Makefile                           |   1 +
>  drivers/thermal/hisi_thermal.c                     | 437 +++++++++++++++=
++++++

Can you please include a patch adding the DT bindings for a board in you
next version? Even if the patches don't go in one single tree, it is
good to review all patches (DT and drivers) in one single patch series.

>  4 files changed, 469 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/hisilicon-t=
hermal.txt
>  create mode 100644 drivers/thermal/hisi_thermal.c
>=20
> --=20
> 1.9.1
>=20
>=20

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQEcBAEBAgAGBQJVUVfWAAoJEMLUO4d9pOJW1d0IAJhVOf7+7Ip3hSGbZGHpkW0c
7qLfMYrPXbYYfxGFz9I2oehSY0kk5bhjXx5z5HIK2uo/RCaYlbpR65AjSN0ymfxx
F0MaldAQ8o1ER1Hwtu7eeYbEmS5acj+WEI6i5U/zROwI8pGv84bH+U0M5A/KbbZi
uzhUgzcOHXjNzfNkEjb7+v8CM+nlTCR7GJjv5kR1A3A8z01nIdGQm+Sg8+gIbP9G
rqUspTdC6qRyMAXvdBwwzvD9XoSwt3e3fOjLaBkhRrtEFodmZPNafiuv9MG59hhh
+AE+sXDL5M9cCK+I0TSJf3ijYMkEyVJLFosuqQuJWeBAeqSAxwEBGN3CeEFHeqE=
=dEIj
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
