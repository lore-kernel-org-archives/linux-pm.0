From: Eric Anholt <eric@anholt.net>
Subject: Re: [PATCH v2 3/5] ARM: bcm2835: add rpi power domain driver
Date: Mon, 07 Dec 2015 17:04:58 -0800
Message-ID: <87fuzdiwcl.fsf@eliezer.anholt.net>
References: <1449251148-19344-1-git-send-email-eric@anholt.net> <1449251148-19344-4-git-send-email-eric@anholt.net> <7hmvtln87l.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:56286 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932114AbbLHBFM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2015 20:05:12 -0500
In-Reply-To: <7hmvtln87l.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>

--=-=-=
Content-Type: text/plain

Kevin Hilman <khilman@kernel.org> writes:

> Eric Anholt <eric@anholt.net> writes:
>
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
>
> [...]
>
>> +/*
>> + * Firmware indices for the old power domains interface.  Only a few
>> + * of them were actually implemented.
>> + */
>> +#define RPI_OLD_POWER_DOMAIN_USB		3
>> +#define RPI_OLD_POWER_DOMAIN_V3D		10
>> +
>
> Is "old" the right word here?  Are there firmware versions that could be
> used instead?  What happens when the firwmware is updated next time?

Old is a good word.  It's the old interface.

As for what happens when the firmware is updated: Nothing.  The firmware
is updated all the time, and it maintains backwards compatibility.
Unless you mean "what happens when a newer, fancier power domain
interface is created and we need a name for the newer one" and the
answer is "this is a define entirely within the driver, and we can just
rename it when we want to."

> [...]
>
>> +	/*
>> +	 * Use the old firmware interface for USB power, so that we
>> +	 * can turn it on even if the firmware hasn't been updated.
>> +	 */
>> +	rpi_init_old_power_domain(rpi_domains, RPI_POWER_DOMAIN_USB,
>> +				  RPI_OLD_POWER_DOMAIN_USB, "USB");
>
> This seems a bit restrictive.
>
> To me, it seems that determining "old" or "new" (or revision of fw
> interface to use) should be described in DT, not hard-coded in the power
> domain driver.
>
> What about an additional DT property to describe that? or possibly
> another cell in the domain which could be used to optionally set
> old/legacy.

As the author and maintainer of the code, I don't feel it's restrictive.
The firmware protocol is defined and is guaranteed to continue to exist,
it's only useful for this platform, and defining a new set of custom
devicetree properties for it would only obfuscate the implementation.
DT is a useful tool for separating out the between-board differences for
the same piece of hardware across multiple implementations at different
addresses, while this is neither hardware nor in multiple
implementations at different addresses.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWZiy6AAoJELXWKTbR/J7ov6IP/1FajlbsOFQaVWZuQ3ndn7Q3
vGuRb4SL3jmILSc0nCd6Cdx5G7eOJE2CQniPrq/Aoo8PPaLQsjm5jZGblqT7z5w9
WeS48sWyGIoCXFO+ehFRrL5POovuTyGm21CB34JJChOSC5JIoufmtzS2T5DJDh3M
rXgzPbMB77L/i+5CvWod5/vZrIV7mugZIxcii5tdZJqE8x0kz6SMFxMrimix8NDq
cmHMx7ZHRzdGajTNurAWhNC/tUJF/mkxujTokG2HLW6p19pmajZFXeZrLGyVcR9W
9Q0EypqQXsM76XSFhO3wqWwLai0QZAQdIMrzJWsYo3RfVvK8yg6xC/gn9RajBzwR
Xhbh/kUUkz1LC33e/FlsfzBosCk1pSPg6XstnN8qnewq0jGEGLuKLSsKGkY4Mgi2
5F+lHfp3wyDWVaCcRQH42gFrwI+sVpK+FS6f7KUQtUZL9L8C2RZXdGQAdOpnWKS1
kN8U2c5ZEGmz8DLxtLkLoBcokYE15KfgQbjXGyWqUMsjO0wXQbXDkt6u0c/UJ0L8
KE5vVIXaAYHtG2KjvUTYojSKXP3dJ6ELUGNpsnq8BhKqOpIqaGaI/nN0hrdymL0H
mcNH4opuIQIHYbEj9F+ZIwkZ2ASjE6gkSBiNXJJxUHO5/A8BADCqYaVIkXk5iHrj
M7v3hqZn7P612Iu1jLWd
=Cwec
-----END PGP SIGNATURE-----
--=-=-=--
