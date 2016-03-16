From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH v7 0/4] Introduce usb charger framework to deal with the usb gadget power negotation
Date: Wed, 16 Mar 2016 13:48:32 +0200
Message-ID: <87wpp2hcdr.fsf@intel.com>
References: <cover.1458128215.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:30046 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964895AbcCPLti (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 16 Mar 2016 07:49:38 -0400
In-Reply-To: <cover.1458128215.git.baolin.wang@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: gregkh@linuxfoundation.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: peter.chen@freescale.com, stern@rowland.harvard.edu, r.baldyga@samsung.com, yoshihiro.shimoda.uh@renesas.com, lee.jones@linaro.org, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, baolin.wang@linaro.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, device-mainlining@lists.linuxfoundation.org, linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi Baolin,

Baolin Wang <baolin.wang@linaro.org> writes:
> [ text/plain ]
> Currently the Linux kernel does not provide any standard integration of t=
his
> feature that integrates the USB subsystem with the system power regulation
> provided by PMICs meaning that either vendors must add this in their kern=
els
> or USB gadget devices based on Linux (such as mobile phones) may not beha=
ve
> as they should. Thus provide a standard framework for doing this in kerne=
l.
>
> Now introduce one user with wm831x_power to support and test the usb char=
ger,
> which is pending testing. Moreover there may be other potential users wil=
l use
> it in future.
>
> Changes since v5:
>  - Remove the notifier chain things from the gadget and introduce one cal=
lback
>  function to report to the usb charger when the gadget state is changed.
>  - Flesh out the port type detection which combines the USB negotiation a=
nd
>  PMICs detection.
>  - Supply the notification mechanism to userspace when charger state is c=
hanged.
>  - Integrate with the vbus staff in the gadget API.
>  - Spilt up the functionality for userspace with one file per USB charger=
 type.
>  - Rebase on "4.5-rc4".
>
> Baolin Wang (4):
>   gadget: Introduce the usb charger framework
>   gadget: Support for the usb charger framework
>   gadget: Integrate with the usb gadget supporting for usb charger
>   power: wm831x_power: Support USB charger current limit management

Thank you for resending this. I'll review it ASAP (probably tomorrow
when I get to the office. If I have time, still today)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW6UgRAAoJEIaOsuA1yqREt+IQAJxQOW2gnpn47y+iW+E7XE97
f+aDomgiLBrzxrBEkG3iPR6ikfbecxs04bFXhSSZHnb75CJOLd4x39HBCkN4kNZm
cBfPHDjFz0OCd1DfTPSGQvJwbsWynqom9tqyP7qTU/2skaULLrC8551ZouGonEyE
buKHcJpATdwW88zjBe1v3PHWFOD8b+UmopXat44SM/LN7dAfjSqTjEeyGov/fC5N
byqaYMYs97OSBaOq8sA8g32jZn/g1FhgjGxw2KGRHasb2CpxYlRCHDsIMVmIv9dF
kdK9pdz1PHM5hir6X5HYnqkSvckecJdkK75iOZENHEJDQtBaKUXN9CurPHBJeE/P
ryEvjUu+kFgGJUDnAC245+T3//PECssVH7pwSEiSqpRmXfyxWK+8Q4nB07d4tLQV
D0kGJ8zTewlHw6IQfcjv+esfHsQoH6ock//4Z38tCLNybnBJIMZleZutYSIp+amN
MNMJ5PSDv7OzsL6xc/wJ1bizyvflOptdKsfOSL9kPNkpebicO8y4gi3p4vYSAwtq
AD+8QqqV+IgM2SfafHIfiJ2iwPZpzhhtQpr4SdjmSJObOuhO7XOLYwJgV1ow5XZi
BEoSKs7D9PSPNVv8WCdyyjPqh/mVnYJ2iwrEsvXt4F9tLcCPsno6x0wKkOuF8kRt
4OC4SKL9UI3oDWBw0kqD
=THyC
-----END PGP SIGNATURE-----
--=-=-=--
