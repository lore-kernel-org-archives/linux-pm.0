From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [RFC/RFT v2 0/2] power_supply: Fix NULL pointer dereference from uevent
Date: Tue, 19 May 2015 10:28:39 +0200
Message-ID: <77C4D085-96E6-4874-BD7A-AC4BDFAC3A58@goldelico.com>
References: <1432019582-27612-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:59365 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635AbbESI2t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 04:28:49 -0400
In-Reply-To: <1432019582-27612-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

Am 19.05.2015 um 09:13 schrieb Krzysztof Kozlowski <k.kozlowski@samsung=
=2Ecom>:

> Hi,
>=20
>=20
> Changes since v1:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. Patch 2: fix invalid member used for container_of().
> 2. Patch 2: Replace WARN with pr_warn() in __power_supply_register()
>   if parent is missing.
>=20
>=20
> Description:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> This is an idea to fix issue in bq27x00 driver (and probably in other=
s)
> reported by H. Nikolaus Schaller [0].
>=20
> The fixes are marked RFC/RFT because:
> 1. I do not have bq27x00-like device. I confirmed this and tested on
>   modified drivers (max77693, ACPI AC). These drivers are not
>   impacted by the issue but one can easily adjust them to reproduce
>   the problem.
> 2. The first uevent coming from power_supply_register() is now
>   different because it won't contain device properties. I am
>   not sure how this impacts userspace.
>=20
> Comments are welcomed.

appears to work! bq27000 is coming up now without hickups.

What I can=92t test is if the uevent is reasonable because we do not
have a specific rule triggered by it in our system.

So from my side we are now happy with the solution.

Thanks and BR,
Nikolaus

>=20
>=20
> [0] https://lkml.org/lkml/2015/5/18/152
>=20
>=20
> Best regards,
> Krzysztof
>=20
> Krzysztof Kozlowski (2):
>  power_supply: Fix NULL pointer dereference during bq27x00_battery
>    probe
>  power_supply: Fix possible NULL pointer dereference on early uevent
>=20
> drivers/power/power_supply_core.c | 61 ++++++++++++++++++++++++++++++=
+++++----
> include/linux/power_supply.h      |  1 +
> 2 files changed, 56 insertions(+), 6 deletions(-)
>=20
> --=20
> 1.9.1
>=20

