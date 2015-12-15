From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v3 2/4] ARM: bcm2835: add rpi power domain driver
Date: Tue, 15 Dec 2015 15:55:17 -0800
Message-ID: <87oadrmfmi.fsf@eliezer.anholt.net>
References: <1450215622-27394-1-git-send-email-eric@anholt.net> <1450215622-27394-3-git-send-email-eric@anholt.net> <567093CD.1020208@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <567093CD.1020208-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> writes:

> On 15/12/15 13:40, Eric Anholt wrote:
>> From: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>=20
>> This patch adds support for several power domains on Raspberry Pi,
>> including USB (so it can be enabled even if the bootloader didn't do
>> it), and graphics.
>>=20
>> This patch is the combined work of Eric Anholt (who wrote USB support
>> inside of the Raspberry Pi firmware driver, and wrote the non-USB
>> domain support) and Alexander Aring (who separated the original USB
>> work out from the firmware driver).
>>=20
>> Signed-off-by: Alexander Aring <alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
>> ---
>>=20
>> v2: Add support for power domains other than USB, using the new
>>     firmware interface, reword commit message (changes by Eric)
>>=20
>> v3: Restructure as a builtin driver, and drop
>>     of_genpd_add_provider_onecell error handling to avoid
>>     pm_genpd_exit() dependency until that API can be settled.  Clean
>>     up copyright header, add missing ISP initialization, and fix typo
>>     in transposer's name.
>>=20
>>  arch/arm/mach-bcm/Kconfig                   |  10 ++
>>  arch/arm/mach-bcm/Makefile                  |   1 +
>>  arch/arm/mach-bcm/raspberrypi-power.c       | 247 +++++++++++++++++++++=
+++++++
>>  include/dt-bindings/arm/raspberrypi-power.h |  41 +++++
>>  4 files changed, 299 insertions(+)
>>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c
>
> What motivated the location of this power domain driver in
> arch/arm/mach-bcm? Should not we have this in drivers/power/ or
> somewhere in drivers/ at the very least?

ls stronly suggests that power contains drivers for power supplies and
batteries, not power domains.  There are 6 power domain drivers in
arch/arm, 3 in drivers/clk, and 3 in drivers/soc.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcKhlAAoJELXWKTbR/J7oUFoQAJDrZ706sJWLuIqRUwoQmxUP
KJAB/9iUdeIeHJVtVGpOo6Fce9WyHcMYM98t5ZdKt3/ZD4GUA3HY1QAsoFB/op/z
/ZsjzDPFi7LlgWPRJb/ZD7vrYku7MYlHsHNGaHR1JjPaYTBH4g7UnfJD4BaUG6Ct
4Jm0jReNKdIhbBcSsqkE8LDqNNeTqAC64tFjcN6S7esIuNdjbA49BWP0rpglsDvN
wmequkyXs9kG8GpTwdlvOxuZB1kZWIlMFcDAPsY5uUkb8d9mhrXmfoKaRmYLiQZe
PDFQvsvByR3S1iBczGK5z83hN4imeBmvTZ/WURgQSmxYn85l5NbQsSKNR+Vvu8uM
ZBxsrRnnt1ZKzk2wFzOpKAJli0vXwX8m3f52Wo51XfRz1XFRJH+msxDpXwuJzsYC
fhuhF8iWufpj1Jvk7ZOBNuX/mTzpPH7n1tllXFRrTqAAGADT/wtqAmoxa5lqxKrL
sQ3EdyWojNoH5bMsfxsPT/O9+WBjFl6EGJ1iT/OLkJgxptSQ14MjNyyDcwjj8Luc
91jkBgEHIhabTjovjBlrc1QR1Mb7PPlHeE2zeq5dnYHV/BmTWDLXW5Kzq+isrR5B
tMq2W2C1VYwujQqjNBsDXj5ar70ve4PUyjcigvhJdjRDukJkCtHOBNRzFG87k4EQ
inJcYnrpO82zf0b91saf
=sX4c
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
