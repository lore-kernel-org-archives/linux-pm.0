From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH 2/3] ARM: bcm2835: add rpi power domain driver
Date: Wed, 25 Nov 2015 11:33:26 -0800
Message-ID: <8737vt27sp.fsf@eliezer.anholt.net>
References: <1447956490-22930-1-git-send-email-alex.aring@gmail.com> <1447956490-22930-3-git-send-email-alex.aring@gmail.com> <CAPDyKFqiGe+E6WRELduZJoKwFRkgnFxBvPjEa3jX04EAC3vXrA@mail.gmail.com> <20151124210249.GA4270@omega>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:45224 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752159AbbKYTdb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Nov 2015 14:33:31 -0500
In-Reply-To: <20151124210249.GA4270@omega>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alexander Aring <alex.aring@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-rpi-kernel@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, =?utf-8?Q?Pawe=C5=82?= Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, bcm-kernel-feedback-list@broadcom.com, "linux-pm@vger.kernel.org" <linux-pm@vge>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Alexander Aring <alex.aring@gmail.com> writes:

> Hi,
>
> On Tue, Nov 24, 2015 at 09:44:59PM +0100, Ulf Hansson wrote:
>> [...]
>>=20
>> > diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
>> > index 8c53c55..20479d7 100644
>> > --- a/arch/arm/mach-bcm/Kconfig
>> > +++ b/arch/arm/mach-bcm/Kconfig
>> > @@ -134,6 +134,16 @@ config ARCH_BCM2835
>> >           This enables support for the Broadcom BCM2835 SoC. This SoC =
is
>> >           used in the Raspberry Pi and Roku 2 devices.
>> >
>> > +config RASPBERRYPI_POWER
>>=20
>> You don't need a new Kconfig option I think. If you fold in the below
>> "select" under ARCH_BCM2835, that should work as well, right?
>>=20
>> select PM_GENERIC_DOMAINS if (RASPBERRYPI_FIRMWARE && PM && OF)
>>=20
>
> I think this depends on what the maintainers like to have here.
>
> The raspberrypi firmware isn't BCM2835 specific, when some SoC which is
> BCM2835 and enabled the RASPBERRYPI_FIRMWARE (for what reason ever) it wi=
ll
> enable also the power domain driver for the RPi.
>
> When some BCM2835 enable it, then it will do nothing because the
> devicetree entries should not match then.

As far as I'm concerned, using the firmware is a stopgap to get other
drivers working, until we can get a native power domain driver written.
I think it makes sense for this code to be under its own menu entry, so
it can be flipped back off when we get the real thing in place.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWVg0GAAoJELXWKTbR/J7oDN0P/0CdHpZSd1npNgjJkMM7IBVs
rf7J1nmfoShoZfkRb/v0t9PwWSlonfEWMLg4uN37JP9mEgHqVi+vmVO0lyZGh43k
rtyfjJQMFXa4U3cS6N2ATiTl+dpaPgbAET5wH8ZMyNyaSKjItfPSbyrUBQtLgZ1P
KoSFl9/96xiuyeMuHBNxZsYDLaTkJjgdn0kcSrfbYHUy4RlX8a/GSb8CystHZ4Vc
42JMj/rXU/sPGU9L6LtBcfdWWmnk0eSSW5i+Imz+nK1Q6t5OaKDLa17ib/J9Ky6f
5U1JQHjbA4fa4XYHfUm9hZvY6VzST5GGNCVQ80FaoBbjWrcUYLJO99nryRbrMrpt
NUP5LuMELsFkeGqohtLg/wfFNDsPkbFevYhUHpoLf0fJIyICf+Ep+dVBHk36dDA5
FFF0xTrvNOYKH7wX7rgK7ZMmly6wa0OlLP7WA6qGp1Ib1h8YJUuBdP1Nl7d6pWbW
3ZX9mB4hDjZkFhxkrtiX7L2xHIlr6sal5bBHcLh3yWPv/kXbWjiu52xo78tXZqra
Ct/DtOxPEZ8VjnOFDNEWClU6fG4EEtZrLmkEgXF+rQosUVBb4cMnTIZB91HwIXQM
ZLOLf3K8RGBOLl7J0bR+0QAW+mgwrTOs6+pKNDUSxg6CZuT/NETIqQUl5wq0vofa
rwbbdCK7+O072QTgg69b
=kgnB
-----END PGP SIGNATURE-----
--=-=-=--
