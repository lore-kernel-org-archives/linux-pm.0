From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH] power: Remove unnecessary MODULE_ALIAS() for I2C drivers
Date: Mon, 31 Aug 2015 10:17:11 +0200
Message-ID: <55E40D87.8030405@osg.samsung.com>
References: <1440976715-23588-1-git-send-email-javier@osg.samsung.com>
 <20150831071710.GA14484@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:33027 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750960AbbHaIRQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 04:17:16 -0400
In-Reply-To: <20150831071710.GA14484@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: linux-kernel@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>

[adding cc list again]

Hello Pali,

On 08/31/2015 09:17 AM, Pali Roh=C3=A1r wrote:
> On Monday 31 August 2015 01:18:35 Javier Martinez Canillas wrote:
>> These drivers already have an I2C device id table that is used to cr=
eate
>> module aliases and the used MODULE_ALIAS() was either already in the=
 I2C
>> table so it was redundant or wasn't a valid I2C id so it was never u=
sed.
>>
>> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>>
>> ---
>>
>> diff --git a/drivers/power/bq27x00_battery.c b/drivers/power/bq27x00=
_battery.c
>> index 8287261fd978..d0b2f3b47b8f 100644
>> --- a/drivers/power/bq27x00_battery.c
>> +++ b/drivers/power/bq27x00_battery.c
>> @@ -1120,10 +1120,6 @@ module_exit(bq27x00_battery_exit);
>>  MODULE_ALIAS("platform:bq27000-battery");
>>  #endif
>> =20
>> -#ifdef CONFIG_BATTERY_BQ27X00_I2C
>> -MODULE_ALIAS("i2c:bq27000-battery");
>> -#endif
>> -
>>  MODULE_AUTHOR("Rodolfo Giometti <giometti@linux.it>");
>>  MODULE_DESCRIPTION("BQ27x00 battery monitor driver");
>>  MODULE_LICENSE("GPL");
>=20
> Hi! This part of patch is already in queue list. So then your patch w=
ill
> conflict with other pending patches...
>

Sorry, with which patch it will conflict? It applies cleanly on top of
the power supply git tree next branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git=
/log/?h=3Dnext

Best regards,
--=20
Javier Martinez Canillas
Open Source Group
Samsung Research America
