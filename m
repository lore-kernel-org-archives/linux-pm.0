From: jonghwa3.lee@samsung.com
Subject: Re: [PATCH 0/8] power_supply: Add API for safe access of
 get_property-like function attrs
Date: Wed, 15 Oct 2014 11:22:05 +0900
Message-ID: <543DDA4D.2060103@samsung.com>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:17070 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536AbaJOCWP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 14 Oct 2014 22:22:15 -0400
In-reply-to: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Anton Vorontsov <anton@enomsg.org>, Guenter Roeck <linux@roeck-us.net>, Pavel Machek <pavel@ucw.cz>, Myungjoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Hi,
On 2014=EB=85=84 10=EC=9B=94 14=EC=9D=BC 21:20, Krzysztof Kozlowski wro=
te:

> Hi,
>=20
>=20
> After fixing issue with referencing old power supply after driver
> unbind in charger manager [1] I noticed that the race condition in su=
ch
> case may still exist. It would be harder to trigger but still possibl=
e.
>=20
> The race is between using a reference to power supply (obtained
> with power_supply_get_by_name()) and removing the driver.
>=20
> This patchset aims to fix the race by introducing wrappers for
> accessing the power supply function attributes.
>=20
> Patch 1 introduces new API. Other patches replace direct calls in
> drivers.
>=20
> Rebased on next-20141007.
> Tested on Trats2 board (max77693 + charger manager).
>=20
>=20
> Kindly asking for reviewing/testing the drivers, although the changes
> are straightforward.
>=20


Looks good to me, but need someone to comment on this.

Acked-by : Jonghwa Lee <jonghwa3.lee@samusng.com>

Thanks,
Jonghwa

>=20
> Best regards,
> Krzysztof
>=20
>=20
> [1] https://lkml.org/lkml/2014/10/13/272
>=20
>=20
>=20
> Krzysztof Kozlowski (8):
>   power_supply: Add API for safe access of power supply function attr=
s
>   power_supply: sysfs: Use power_supply_*() API for accessing functio=
n
>     attrs
>   power: 88pm860x_charger: Use power_supply_*() API for accessing
>     function attrs
>   power: ab8500: Use power_supply_*() API for accessing function attr=
s
>   mfd: ab8500: Use power_supply_*() API for accessing function attrs
>   power: apm_power: Use power_supply_*() API for accessing function
>     attrs
>   power: bq2415x_charger: Use power_supply_*() API for accessing
>     function attrs
>   power: charger-manager: Use power_supply_*() API for accessing
>     function attrs
>=20
>  drivers/mfd/ab8500-sysctrl.c       |  7 +++--
>  drivers/power/88pm860x_charger.c   | 13 +++++----
>  drivers/power/ab8500_btemp.c       |  2 +-
>  drivers/power/ab8500_charger.c     |  2 +-
>  drivers/power/ab8500_fg.c          |  2 +-
>  drivers/power/abx500_chargalg.c    |  4 +--
>  drivers/power/apm_power.c          |  4 +--
>  drivers/power/bq2415x_charger.c    |  3 +-
>  drivers/power/charger-manager.c    | 37 +++++++++++++------------
>  drivers/power/power_supply_core.c  | 57 ++++++++++++++++++++++++++++=
++++++++--
>  drivers/power/power_supply_sysfs.c |  6 ++--
>  include/linux/power_supply.h       | 16 +++++++++++
>  12 files changed, 115 insertions(+), 38 deletions(-)
>=20


