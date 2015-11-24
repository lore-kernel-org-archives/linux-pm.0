From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
Date: Tue, 24 Nov 2015 13:43:56 -0800
Message-ID: <87bnajrs2r.fsf@eliezer.anholt.net>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com> <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:47796 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbbKXVoA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 Nov 2015 16:44:00 -0500
In-Reply-To: <1447956490-22930-3-git-send-email-alex.aring@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, swarren@wwwdotorg.org, lee@kernel.org, linux@arm.linux.org.uk, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, rjw@rjwysocki.net, khilman@kernel.org, ulf.hansson@linaro.org, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org, kernel@pengutronix.de, Alexander Aring <alex.aring@gmail.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alexander Aring <alex.aring@gmail.com> writes:

> This patch adds support for RPi several Power Domains and enable support
> to enable the USB Power Domain when it's not enabled before.
>
> This patch based on Eric Anholt's patch to support Power Domains. He had
> an issue about -EPROBE_DEFER inside the power domain subsystem, this
> issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> if we fail to init or turn-on domain").

Glad to see you pick this up!

> It was tested with barebox and the following scripts before booting
> linux:
>
> /env/a_off:
>
>  # cat /env/a_off
>  #turn off which are enabled by default
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>
> /env/a_on:
>
>  # cat /env/a_on
>  #turn off which are enabled by default
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>
>  regulator -n bcm2835_mci0 -s enable
>  regulator -n uart0-pl0110 -s enable
>  regulator -n uart0-pl0111 -s enable
>  regulator -n bcm2835_usb -s enable
>  regulator -n bcm2835_i2c0 -s enable
>  regulator -n bcm2835_i2c1 -s enable
>  regulator -n bcm2835_i2c2 -s enable
>  regulator -n bcm2835_spi -s enable
>  regulator -n bcm2835_ccp2tx -s enable
>  regulator -n bcm2835_dsi -s enable
>
> /env/b:
>
>  # cat /env/b
>  sh /env/a_on
>
>  regulator -n bcm2835_mci0 -s disable
>  regulator -n uart0-pl0110 -s disable
>  regulator -n uart0-pl0111 -s disable
>  regulator -n bcm2835_usb -s disable
>  regulator -n bcm2835_i2c0 -s disable
>  regulator -n bcm2835_i2c1 -s disable
>  regulator -n bcm2835_i2c2 -s disable
>  regulator -n bcm2835_spi -s disable
>  regulator -n bcm2835_ccp2tx -s disable
>  regulator -n bcm2835_dsi -s disable
>
> /env/c:
>
>  # cat /env/c
>  sh ./env/b
>
>  regulator -n bcm2835_mci0 -s enable
>  regulator -n uart0-pl0110 -s enable
>  regulator -n uart0-pl0111 -s enable
>  regulator -n bcm2835_usb -s enable
>  regulator -n bcm2835_i2c0 -s enable
>  regulator -n bcm2835_i2c1 -s enable
>  regulator -n bcm2835_i2c2 -s enable
>  regulator -n bcm2835_spi -s enable
>  regulator -n bcm2835_ccp2tx -s enable
>  regulator -n bcm2835_dsi -s enable
>
> These scripts enables/disable all regulators inside the bootloader. It
> was running with a "hard" and "soft" reset without any issues. These
> testcases should fit to Stephen Warren suggestions:
>
> "(a) before having explicitly turned the power domain on or off at all (b)
> after having turned it on (c) after having turned it off, and for all
> power domains."

I would drop this whole block from the commit message.  It doesn't seem
worth keeping associated with this code (though thanks for testing it!).

> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>

If I'm going to be credited as an author, we should probably keep my:

Signed-off-by: Eric Anholt <eric@anholt.net>

It looks like you've mostly rewritten things, and there's not a whole
lot of meat to this driver so I don't care about getting credit myself,
but best not to give people reasons to be suspicious.

> ---
>  arch/arm/boot/dts/bcm2835-rpi.dtsi          |  11 ++
>  arch/arm/boot/dts/bcm2835.dtsi              |   2 +-
>  arch/arm/mach-bcm/Kconfig                   |  10 ++
>  arch/arm/mach-bcm/Makefile                  |   1 +
>  arch/arm/mach-bcm/raspberrypi-power.c       | 180 ++++++++++++++++++++++=
++++++
>  include/dt-bindings/arm/raspberrypi-power.h |  14 +++
>  6 files changed, 217 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>  create mode 100644 include/dt-bindings/arm/raspberrypi-power.h

To merge the patch, the .dtsi changes need to be in a separate commit
which I would pick up in the dt branch.  I'm hoping Ulf or another PM
domains maintainer would be able to pick up the Kconfig/Makefile/.c
patch in their tree, so it can be queued after the uninit function
change.  If they won't, then it would go through my tree, but still on a
different branch from DT changes.

This is the only thing I see needing to change before I can Ack.

> diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
> index 8c53c55..20479d7 100644
> --- a/arch/arm/mach-bcm/Kconfig
> +++ b/arch/arm/mach-bcm/Kconfig
> @@ -134,6 +134,16 @@ config ARCH_BCM2835
>  	  This enables support for the Broadcom BCM2835 SoC. This SoC is
>  	  used in the Raspberry Pi and Roku 2 devices.
>=20=20
> +config RASPBERRYPI_POWER
> +	bool "Raspberry Pi power domain driver"
> +	depends on ARCH_BCM2835
> +	depends on RASPBERRYPI_FIRMWARE
> +	select PM_GENERIC_DOMAINS if PM
> +	select PM_GENERIC_DOMAINS_OF if PM
> +	help
> +	  This enables support for the RPi power domains which can be enabled
> +	  or disabled via the RPi firmware.
> +
>  config ARCH_BCM_63XX
>  	bool "Broadcom BCM63xx DSL SoC" if ARCH_MULTI_V7
>  	depends on MMU

I'd love to have this be "depends on ARCH_BCM2835 || COMPILE_TEST" --
that gets us better coverage from automated builders in -next.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWVNocAAoJELXWKTbR/J7ots8P/i3h/1KYeHe4fosHcD5LDGe3
/+AzggB2PXmdfXULMSg+GU2ZIpySNzcnpTUiQUf5f6DokI3rZv0mgMt4AkHVm32F
DD27vPuVmJpJOh/idxDL5Chz4LLxU5vT/D9S/TixBGqbG/8SjMEJFlT3+amsKIMK
pVlGvdbYvzk1fWKq8TMFAo/NyZRKaJApT+3W3lqdP6Kl1p50lm8u+n6LLgVqsUl9
GERWfwjFuJ2PJplZJO51wdqKVhZX9PRqz+jyJ0E8ujzJbR0qcDFezITmmPSxGgEH
xuwIRuAOs7xS6zippJ2mrX1WRAKE3oaPUEWhDaApz/MeUq+nxh/Jy8oobaGUy8q8
qypIiNPdG2NAHXe7rp9hf9zjN/3h2J0rT5Qj7+hKhoiG+UGMO8iR1mwlXq4XoPVO
IkaIoK74WlCAzkj/cT/fHkfEqiM0mRT+aM8ZDMs1ZY5gHAvgYX4VRXAvdD0Ay6gZ
cH5nz+96MlZ8HItmYPBFvBkE0Z0JIcesujQdni9LsIrowS2bXO8WdcXk3k1Ny3mE
n00NyELTpalFEUZC9/ha45L/zx6f1hzifUZ1JYu+aCcr4g7RQnYex8zEds5SCVey
e5iFcfA6Ysw8AkJQAWhpNKavvXdVjRXVFsZBYl4l9YCNxjVmDO3nV7Wr31U5lRcH
FhCfmDNGlasJMsKdC8K3
=cI6Y
-----END PGP SIGNATURE-----
--=-=-=--
