From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v4 2/4] ARM: bcm2835: add rpi power domain driver
Date: Mon, 21 Dec 2015 20:02:21 -0800
Message-ID: <877fk7167m.fsf@eliezer.anholt.net>
References: <1450312009-1791-1-git-send-email-eric@anholt.net> <1450312009-1791-3-git-send-email-eric@anholt.net> <CAPDyKFp5JfHmNw+ryoAnu-0XANcxW_pyNL_GUFUw7sBQmU+WDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:52476 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196AbbLVECX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Dec 2015 23:02:23 -0500
In-Reply-To: <CAPDyKFp5JfHmNw+ryoAnu-0XANcxW_pyNL_GUFUw7sBQmU+WDA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rpi-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>

--=-=-=
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 17 December 2015 at 01:26, Eric Anholt <eric@anholt.net> wrote:
>> From: Alexander Aring <alex.aring@gmail.com>
>>
>> This patch adds support for several power domains on Raspberry Pi,
>> including USB (so it can be enabled even if the bootloader didn't do
>> it), and graphics.
>>
>> This patch is the combined work of Eric Anholt (who wrote USB support
>> inside of the Raspberry Pi firmware driver, and wrote the non-USB
>> domain support) and Alexander Aring (who separated the original USB
>> work out from the firmware driver).
>>
>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>
>> v2: Add support for power domains other than USB, using the new
>>     firmware interface, reword commit message (changes by Eric)
>>
>> v3: Restructure as a builtin driver, and drop
>>     of_genpd_add_provider_onecell error handling to avoid
>>     pm_genpd_exit() dependency until that API can be settled.  Clean
>>     up copyright header, add missing ISP initialization, and fix typo
>>     in transposer's name.
>>
>> v4: Move to drivers/soc/bcm/, move include to dt-bindings/soc/, set up
>>     Makefile for the drivers/soc/bcm following clk/'s model.
>>
>>  drivers/soc/Kconfig                         |   1 +
>>  drivers/soc/Makefile                        |   1 +
>>  drivers/soc/bcm/Kconfig                     |   9 +
>>  drivers/soc/bcm/Makefile                    |   1 +
>>  drivers/soc/bcm/raspberrypi-power.c         | 247 ++++++++++++++++++++++++++++
>>  include/dt-bindings/soc/raspberrypi-power.h |  41 +++++
>
> There is currently a directory which I think may be better.
> include/dt-bindings/power/*
>
> Besides this nitpick, I think this looks good. You may add my:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks!  I'll be sending my pull requests with the two r-bs added and
these nitpicks fixed.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWeMtNAAoJELXWKTbR/J7oV/MP/jY90i5XfExEzuffj9QFInLa
T+oSu0R8epjxq00hUP92DPBFe6qPRDtWV0MjiV3Li2+OYxbsqEMJRdEEX+VS5Uw6
jS712lNLQYx9seI4gvDzZzlz9Th8sWqflnXbb8TI232LzWSMu6PQJ7eLEcTaPgaX
4osiAba2DIMY0DOJ5HIb2XbGhFibTu0z2Vkb1ByXhCjNY/aeqcGLTBSyXMBP/G3c
RiOwrZ4ER3uhjMQFFRGjA7gmI/OM1GrGTepFz7Icja+ipO/URS7WPYNXLfM5HNCN
EJV9ZA/WQJECW1I/BmPjMY4INxdd205Ap1aSGu7DxgH3UDHNTORNaY0C2jfKZNMw
gktkxxVMuMQY1GSnV05xl0n9AC0XYgXHAhlfn/E2seOUKgTgTsglXMtezuoro9yY
vrjRl+Xec7Bh8Kj06CzdvlwWWqJeceRXOMuL6cKZl/hRhiL6omBbe2fR7mAT2a0j
x3aNeWunRsVi/V91FEHqfmRLej+f+efDh3xNVYmmavkg56HEZuVljrg9aSXmgwNj
ljRv4/o8q9BOw54Yf2+PwXeJH3tN8zmomFyxkAyu3T+nN2EJLdKMxe08mJZIl2R5
9X6WdVRyWlPweNlgNKNS1QxGdtblY0/C0LJLTZoAXDKiAZFyuBKrtV3VGR732f4M
XlLgRgJ57WvTLmdgSWyO
=k9S/
-----END PGP SIGNATURE-----
--=-=-=--
