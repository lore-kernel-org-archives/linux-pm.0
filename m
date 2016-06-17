From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 3/3] power_supply: bq27xxx_battery: Group register
 mappings into one table
Date: Fri, 17 Jun 2016 17:00:34 -0500
Message-ID: <57647302.1080205@ti.com>
References: <20160531184500.10871-1-afd@ti.com>
 <20160531184500.10871-3-afd@ti.com> <20160610012934.GA5848@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([198.47.19.11]:60408 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000AbcFQWBE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 17 Jun 2016 18:01:04 -0400
In-Reply-To: <20160610012934.GA5848@earth>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 06/09/2016 08:29 PM, Sebastian Reichel wrote:
> Hi,
>=20
> On Tue, May 31, 2016 at 01:45:00PM -0500, Andrew F. Davis wrote:
>> Currently for each device with a unique register map we have a named
>> array that we then merge into a multidimensional array. Skip this
>> middle step and apply the register arrays directly to the multi-arra=
y.
>=20
> I applied the first two patches, but the third (this one) does not
> compile for me:
>=20
>   CC [M]  drivers/power/bq27xxx_battery.o
> drivers/power/bq27xxx_battery.c:108:2: warning: braces around scalar =
initializer
>   [BQ27000] =3D {
>   ^
> drivers/power/bq27xxx_battery.c:108:2: note: (near initialization for=
 =E2=80=98bq27xxx_regs[1]=E2=80=99)
> drivers/power/bq27xxx_battery.c:109:4: error: array index in non-arra=
y initializer
>    [BQ27XXX_REG_CTRL] =3D 0x00,
>     ^
> drivers/power/bq27xxx_battery.c:109:4: note: (near initialization for=
 =E2=80=98bq27xxx_regs[1]=E2=80=99)
> drivers/power/bq27xxx_battery.c:110:4: error: array index in non-arra=
y initializer
>    [BQ27XXX_REG_TEMP] =3D 0x06,
>     ^
> ...
>=20

That's odd, I looks like I was attempting a jagged array in C, oops :)
I'll post v2 with this fixed.

Thanks,
Andrew
