From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: [PATCH 5/8] power: bq27x00_battery: Renaming for consistency
Date: Thu, 23 Jul 2015 23:36:24 +0200
Message-ID: <CAAfyv35qsZzfWuJxgLbii_05Za6X3zcPgrt9hhHDoGnAoeWKpw@mail.gmail.com>
References: <1437601920-13045-1-git-send-email-afd@ti.com>
	<201507232215.35603@pali>
	<CAAfyv342rHGazCqZ19oYfwR5E2NO65VhhstXBHdDVfjd7USbFQ@mail.gmail.com>
	<201507232315.16467@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:33777 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753682AbbGWVgZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Jul 2015 17:36:25 -0400
In-Reply-To: <201507232315.16467@pali>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: "Andrew F. Davis" <afd@ti.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Jul 23, 2015 at 11:15 PM, Pali Roh=C3=A1r <pali.rohar@gmail.com=
> wrote:
> On Thursday 23 July 2015 22:56:26 Belisko Marek wrote:
>> Hi Pali,
>>
>> On Thu, Jul 23, 2015 at 10:15 PM, Pali Roh=C3=A1r <pali.rohar@gmail.=
com>
>> wrote:
>> > On Thursday 23 July 2015 19:03:08 Andrew F. Davis wrote:
>> >> >> -#ifdef CONFIG_BATTERY_BQ27X00_I2C
>> >> >> -MODULE_ALIAS("i2c:bq27000-battery");
>> >> >> +#ifdef CONFIG_BATTERY_BQ27XXX_I2C
>> >> >> +MODULE_ALIAS("i2c:bq27xxx-battery");
>> >> >>
>> >> >>  #endif
>> >> >
>> >> > Why is this MODULE_ALIAS needed? Some lines upper there is
>> >> >
>> >> >  MODULE_DEVICE_TABLE(i2c, bq27xxx_id);
>> >> >
>> >> > which add proper i2c: module alias...
>> >>
>> >> Not sure, looks like it was added in commit
>> >> 8ebb7e9c1a502cfc300618c19c3c6f06fc76d237 which claims that the
>> >> "module won't get loaded automatically" without it, but I have no=
t
>> >> had this problem, so I'm not sure why it's there.
>> >
>> > git grep bq27000-battery show me that only one driver uses that
>> > name: drivers/w1/slaves/w1_bq27000.c
>> >
>> > And more over, it is platform device, not i2c device. So that
>> > commit 8ebb7e9c1a502cfc300618c19c3c6f06fc76d237 is wrong! CCing
>> > Marek.
>>
>> If you look to power/bq27x00 driver then there is I2C part and
>> platform part only
>> both selectable by config. In
>> 8ebb7e9c1a502cfc300618c19c3c6f06fc76d237 was added MODULE_ALIAS to
>> have this driver working as module for both buses. Even if I2C isn't
>> used anywhere
>> I add MODULE_ALIAS also for that.
>>
>> > MODULE_ALIAS("platform:bq27000-battery") is really needed for
>> > w1_bq27000.c but MODULE_ALIAS("i2c:bq27000-battery") should be
>> > removed. It is not used by any board platform code or DT.
>>
>> Not sure if it's good idea to remove it. Somebody outside can use it=
=2E
>>
>> > Marek, correct me if I'm wrong.
>> >
>> > --
>> > Pali Roh=C3=A1r
>> > pali.rohar@gmail.com
>>
>> BR,
>>
>> marek
>
> Who, where any why is using alias i2c:bq27000-battery??
>
> It is obviously wrong to add that alias. MODULE_DEVICE_TABLE(i2c, ...
> macro automatically adds all MODULE_ALIASes for all i2c devices.
Hmm are you sure? I think it's not true if you look to include/linux/mo=
dule.h
Those 2 macros have completely other purposes.
>
> If there is such device with needs i2c:bq27000-battery is should be
> fixed to use i2c:bq27??? identifier exported by MODULE_DEVICE_TABLE.
Look if you don't like it remove i2c part from driver and post patch.
But as I said
somebody can use it (not talking about vanilla tree).
>
> git grep on kernel tree did not return anything, so there is no usage=
=2E
>
> Of course alias for platform:bq27000-battery is needed.
>
> --
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

BR,

marek



--=20
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
=46reelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
