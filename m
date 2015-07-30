From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v2 5/6] power: bq27xxx_battery: Add support for additional
 bq27xxx family devices
Date: Thu, 30 Jul 2015 12:07:18 -0500
Message-ID: <55BA59C6.4010604@ti.com>
References: <1438112353-19704-1-git-send-email-afd@ti.com> <1438112353-19704-6-git-send-email-afd@ti.com> <201507282159.30013@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201507282159.30013@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?UGFsaSBSb2jDoXI=?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Dan Murphy <dmurphy@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 07/28/2015 02:59 PM, Pali Roh=C3=A1r wrote:
> On Tuesday 28 July 2015 21:39:12 Andrew F. Davis wrote:
>> Add support for additional devices and register equivalent family
>> devices including the bq27010, bq27210, bq272500, bq27510, bq27520,
>                                              ^^^^^^
>                                              maybe incorrect number?

Yeah, that's what I get for not copy/pasting :)

>> bq27530, bq27531, bq27541, bq27542, bq27546, bq27545, bq27441,
>> bq27421, and the bq27641.
>>
>> To facilitate this process the register mapings have been moved to
>> tables and other small cleanups have been made.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>
>>   static const struct i2c_device_id bq27xxx_id[] =3D {
>> -	{ "bq27200", BQ27000 },	/* bq27200 is same as bq27000, but with i2=
c
>> */ +	{ "bq27200", BQ27000 },
>> +	{ "bq27210", BQ27010 },
>>   	{ "bq27500", BQ27500 },
>> -	{ "bq27425", BQ27425 },
>> -	{ "bq27742", BQ27742 },
>> -	{ "bq27510", BQ27510 },
>> +	{ "bq27510", BQ27500 },
>> +	{ "bq27520", BQ27500 },
>> +	{ "bq27530", BQ27530 },
>> +	{ "bq27531", BQ27530 },
>> +	{ "bq27541", BQ27541 },
>> +	{ "bq27542", BQ27541 },
>> +	{ "bq27546", BQ27541 },
>> +	{ "bq27742", BQ27541 },
>> +	{ "bq27545", BQ27545 },
>> +	{ "bq27421", BQ27421 },
>> +	{ "bq27425", BQ27421 },
>> +	{ "bq27441", BQ27421 },
>> +	{ "bq27621", BQ27421 },
>>   	{},
>>   };
>
> I'm trying to understand comparator which you used for sorting these
> values... but I do not see any logic here. What about sorting list by
> first value? Now it is long list of device names and for better abili=
ty
> to read it, it would be better to have it in some order.
>

It is sorted first by the family release date, then numerically within=20
family. The BQ27421 family seems out of order but it appears to be the=20
newest line.

>> -enum bq27xxx_chip { BQ27000, BQ27500, BQ27425, BQ27742, BQ27510 };
>> +enum bq27xxx_chip {
>> +	BQ27000, /* bq27000, bq27200 */
>> +	BQ27010, /* bq27010, bq27210 */
>> +	BQ27500, /* bq27500, bq27510, bq27520 */
>> +	BQ27530, /* bq27530, bq27531 */
>> +	BQ27541, /* bq27541, bq27542, bq27546, bq27742 */
>> +	BQ27545, /* bq27545 */
>> +	BQ27421, /* bq27421, bq27425, bq27441, bq27621 */
>> +};
>>
>
> Maybe same here? Putting BQ27421 before BQ27500?
>

--=20
Andrew F. Davis
