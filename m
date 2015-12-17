From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 0/4] Raspberry Pi power domains
Date: Thu, 17 Dec 2015 11:03:47 -0800
Message-ID: <878u4sx5gs.fsf@eliezer.anholt.net>
References: <1450215622-27394-1-git-send-email-eric@anholt.net> <CAPDyKFp=ykY4dFTxeq+et6z5ek-UYGnBOFG7Po0pSUL7jSYc8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:44495 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbLQTDu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Dec 2015 14:03:50 -0500
In-Reply-To: <CAPDyKFp=ykY4dFTxeq+et6z5ek-UYGnBOFG7Po0pSUL7jSYc8g@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-rpi-kernel@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>

--=-=-=
Content-Type: text/plain

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On 15 December 2015 at 22:40, Eric Anholt <eric@anholt.net> wrote:
>> Since the pm_genpd_exit() patch is still going through review, and
>> other drivers in the tree just ignore the error cases, Ulf offered to
>> merge the series as a builtin driver not depending on that interface.
>> We still avoid dangling pointer references, by just continuing with
>> probing if of_genpd_add_provider_onecell() fails.  We can easily go
>> back and update the driver when a pm_genpd_exit() lands.
>>
>> Alexander Aring (3):
>>   ARM: bcm2835: add rpi power domain driver
>>   dt-bindings: add rpi power domain driver bindings
>>   ARM: bcm2835: Add the Raspberry Pi power domain driver to the DT.
>>
>> Eric Anholt (1):
>>   ARM: bcm2835: Define two new packets from the latest firmware.
>>
>>  .../bindings/arm/bcm/raspberrypi,bcm2835-power.txt |  47 ++++
>>  arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  11 +
>>  arch/arm/boot/dts/bcm2835.dtsi                     |   2 +-
>>  arch/arm/mach-bcm/Kconfig                          |  10 +
>>  arch/arm/mach-bcm/Makefile                         |   1 +
>>  arch/arm/mach-bcm/raspberrypi-power.c              | 247 +++++++++++++++++++++
>>  include/dt-bindings/arm/raspberrypi-power.h        |  41 ++++
>>  include/soc/bcm2835/raspberrypi-firmware.h         |   2 +
>>  8 files changed, 360 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-power.txt
>>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>>  create mode 100644 include/dt-bindings/arm/raspberrypi-power.h
>>
>> --
>> 2.6.2
>>
>
> Besides a nitpick for patch2, I would also reverse the order of patch3
> and patch2. DT docs should go in before the actual parsing of the new
> bindings/compatibles.
>
> Anyway, for the hole series, you may add my:
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Would your tree be pulling the series (since it's power domains), or
should I (since it's SOC stuff)?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcwcTAAoJELXWKTbR/J7oiygP/A1NUbzjgZaDiVUGl9alRcQj
AncL5FQt67qKpC3KMug+OkttV8tjDtoVrS4Ygcr7sZwDm9LoTHJi9ljmrFoXvuI8
FG27XRShoOWSf1NS5NRmw5b6WAJIVQalDEVz5YtgGZ6ayrO/16VjIcMqBmVIiRvx
ACNGTCyGDu3rTH18/FZOuKTX/m7YCI+sJ5gXugB8LaIHjrsvaOilv3WGrZEtdTKz
fie+hnZnQsHKnm0VVw+mpoXQJEVe8obPoPFxu23pw0wCax+s/i+So0gvR88aw7hw
5wXQIXGgVn/RBUNAeKusbTn1gHgtLuWGZ7Wckdb7BSSbG9epEXucOPDNqpLSZVSw
OTWng9qHluuWTBlyJ8GoNHbBpuBswRfA/4ymoY2CoNhpQ5orgWx/MZWq7N1Am4vV
0X9hpEcya8tAwJWJk/IOspuC7+HVuyFMYs5efzq5ZzfT0O2oLKvrWsu08cUNJ5wA
P3SNII/jg75LAtlcuaU7yPA28f6GHSvazq9XCSQkoEOkuIT59vRkn1TkQGbj4mIE
/cSJnDYNcpXR0zvCSVvUzg2hWy6dVMZAQIROc9S/5f687Ef+TKLvemHS8EOng+6a
d+DfheR1Vx+TmNie1drwenPcJgHXq8JWObg6WlHlWwMTEduDBwMNmJAjD+p7qGt2
UIxmvex0Y9vj7Alwiz5G
=+v9T
-----END PGP SIGNATURE-----
--=-=-=--
