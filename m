From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] power: bq27x00_battery: Destroy battery_id IDR on module exit
Date: Thu, 09 Jul 2015 09:07:40 +0200
Message-ID: <mqdwpy9stab.fsf@c203.arch.suse.de>
References: <1436368700-30852-1-git-send-email-jthumshirn@suse.de>
	<201507081810.14511@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201507081810.14511@pali> ("Pali \=\?utf-8\?Q\?Roh\=C3\=A1r\=22's\?\=
 message of "Wed, 8 Jul
	2015 18:10:14 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>
List-Id: linux-pm@vger.kernel.org

Pali Roh=C3=A1r <pali.rohar@gmail.com> writes:

> On Wednesday 08 July 2015 17:18:20 Johannes Thumshirn wrote:
>> Destroy battery_id IDR on module exit, reclaiming the allocated
>> memory.
>>=20
>> This was detected by the following semantic patch (written by Luis
>> Rodriguez <mcgrof@suse.com>)
>> <SmPL>
>> @ defines_module_init @
>> declarer name module_init, module_exit;
>> declarer name DEFINE_IDR;
>> identifier init;
>> @@
>>=20
>> module_init(init);
>>=20
>> @ defines_module_exit @
>> identifier exit;
>> @@
>>=20
>> module_exit(exit);
>>=20
>> @ declares_idr depends on defines_module_init && defines_module_exit
>> @ identifier idr;
>> @@
>>=20
>> DEFINE_IDR(idr);
>>=20
>> @ on_exit_calls_destroy depends on declares_idr &&
>> defines_module_exit @ identifier declares_idr.idr,
>> defines_module_exit.exit;
>> @@
>>=20
>> exit(void)
>> {
>>  ...
>>  idr_destroy(&idr);
>>  ...
>> }
>>=20
>> @ missing_module_idr_destroy depends on declares_idr &&
>> defines_module_exit && !on_exit_calls_destroy @ identifier
>> declares_idr.idr, defines_module_exit.exit;
>> @@
>>=20
>> exit(void)
>> {
>>  ...
>>  +idr_destroy(&idr);
>> }
>> </SmPL>
>>=20
>> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>> ---
>>  drivers/power/bq27x00_battery.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/power/bq27x00_battery.c
>> b/drivers/power/bq27x00_battery.c index b6b9837..99180d2 100644
>> --- a/drivers/power/bq27x00_battery.c
>> +++ b/drivers/power/bq27x00_battery.c
>> @@ -1106,6 +1106,7 @@ static void __exit bq27x00_battery_exit(void)
>>  {
>>  	bq27x00_battery_platform_exit();
>>  	bq27x00_battery_i2c_exit();
>> +	idr_destroy(&battery_id);
>>  }
>>  module_exit(bq27x00_battery_exit);
>
> Hello, I see that none power supply kernel driver is calling=20
> idr_destroy() at module exit time. So if this patch is needed for=20
> bq27x00_battery module, then it is needed also for other charger/batt=
ery=20
> modules...

You're right. I'll post a follow up for this with (this time hopefully)
all battery drivers included.

--=20
Johannes Thumshirn                                       Storage
jthumshirn@suse.de                             +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
