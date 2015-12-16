From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v3 2/4] ARM: bcm2835: add rpi power domain driver
Date: Tue, 15 Dec 2015 16:53:31 -0800
Message-ID: <87mvtbkyd0.fsf@eliezer.anholt.net>
References: <1450215622-27394-1-git-send-email-eric@anholt.net> <1450215622-27394-3-git-send-email-eric@anholt.net> <567093CD.1020208@gmail.com> <87oadrmfmi.fsf@eliezer.anholt.net> <5670AAB2.1080102@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:34502 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbbLPAxg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Dec 2015 19:53:36 -0500
In-Reply-To: <5670AAB2.1080102@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Florian Fainelli <f.fainelli@gmail.com> writes:

> On 15/12/15 15:55, Eric Anholt wrote:
>> Florian Fainelli <f.fainelli@gmail.com> writes:
>>=20
>>> On 15/12/15 13:40, Eric Anholt wrote:
>>>> From: Alexander Aring <alex.aring@gmail.com>
>>>>
>>>> This patch adds support for several power domains on Raspberry Pi,
>>>> including USB (so it can be enabled even if the bootloader didn't do
>>>> it), and graphics.
>>>>
>>>> This patch is the combined work of Eric Anholt (who wrote USB support
>>>> inside of the Raspberry Pi firmware driver, and wrote the non-USB
>>>> domain support) and Alexander Aring (who separated the original USB
>>>> work out from the firmware driver).
>>>>
>>>> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
>>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>>> ---
>>>>
>>>> v2: Add support for power domains other than USB, using the new
>>>>     firmware interface, reword commit message (changes by Eric)
>>>>
>>>> v3: Restructure as a builtin driver, and drop
>>>>     of_genpd_add_provider_onecell error handling to avoid
>>>>     pm_genpd_exit() dependency until that API can be settled.  Clean
>>>>     up copyright header, add missing ISP initialization, and fix typo
>>>>     in transposer's name.
>>>>
>>>>  arch/arm/mach-bcm/Kconfig                   |  10 ++
>>>>  arch/arm/mach-bcm/Makefile                  |   1 +
>>>>  arch/arm/mach-bcm/raspberrypi-power.c       | 247 +++++++++++++++++++=
+++++++++
>>>>  include/dt-bindings/arm/raspberrypi-power.h |  41 +++++
>>>>  4 files changed, 299 insertions(+)
>>>>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>>>
>>> What motivated the location of this power domain driver in
>>> arch/arm/mach-bcm? Should not we have this in drivers/power/ or
>>> somewhere in drivers/ at the very least?
>>=20
>> ls stronly suggests that power contains drivers for power supplies and
>> batteries, not power domains.  There are 6 power domain drivers in
>> arch/arm, 3 in drivers/clk, and 3 in drivers/soc.
>
> If we ever have to support a different architecture which happens to use
> a similar power domain, then we want it to be in a location which makes
> it easy for sharing it in the first place. As it stands today, it does
> not seem useful to me to have this code in arch/arm/mach-bcm/ at all.
>
> Maybe there is room from a drivers/power/domains/ of some kind?

The great thing about git is that moving code is easy, even after it's
first committed.

The subsystem maintainer didn't comment on the code's location in v1 or
v2, and I think they probably have the final say on that.  Whatever they
want, where there is currently a genpd driver, is fine with me.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcLYMAAoJELXWKTbR/J7oFWkP/AysmMpnZbd/TmvxChALCmgp
8uIOntF3rdz7pezsudgDsq3dByptvfvHhKStYFoTBssYbn23KfYj5ceKMfySWV9j
GW4XjqRkx9j66xa6jFY8/6QsxasCTGqHGJp0qgFLCOT5MxTh6eJD0AQH3BW1ckdX
sY2LHy9OrYRaT21czYgMMj0NuFKlAOeJV4G5Rmmh3QYQPdoisIQxPU51W/mDMqDg
+dZk1AUoSo3YMHgpJw8tVxAqo+jslDfERy7j9m5eEBPNHcNw/d3R5mrYUpH/T65L
WqrLMADTZrvtd2BrsrzgXVHaOmVgcQFFB5KhJLvT7CCLrapyitJtqklV4nOnPuV3
+QxWVvjCGAKlXDEFSK157CsoI2O575y9RZP1iNRrUp0+hGwzbmwJZm4Ms0St6PRu
6qiR3V+4A4gAWijKnEipfY84mfsSg+JlHZvMu8gig8hjpoKxqHn3LjRo5tWj9qrE
XZH/q3NvHhylGbNGT+0dYKgRxrxBnR32YhPD0GAUgKdZ1CEIl2XfKkpWJ2hPHv3Z
zzsIz7gtEwZxgfcKNRB2wzWz55XgQ7Ljz0NXhzK/5taV8Qgy1RDUTe8253A/dS+e
lxz/R8z+B0OXdtmDGjlDUSWSr7u9CXnmwwFp7JPtJSYY7VfUJOdlcd9XFngayj9W
dEcd4nUnRq33YygLpoXK
=AsRa
-----END PGP SIGNATURE-----
--=-=-=--
