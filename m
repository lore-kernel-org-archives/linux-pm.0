From: <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH v2 1/3] PM / Suspend: Add support to check if platform's
 power is off in suspend
Date: Thu, 10 Jan 2019 10:24:14 +0000
Message-ID: <126e9fd8-1009-47f7-7299-9e5e93ebfd4d@microchip.com>
References: <1546944944-13911-1-git-send-email-claudiu.beznea@microchip.com>
 <1546944944-13911-2-git-send-email-claudiu.beznea@microchip.com>
 <20190109141417.GA8529@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190109141417.GA8529@amd>
Content-Language: en-US
Content-ID: <96542B4514FC34429CA977BE733673A8@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz
Cc: Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, linux@armlinux.org.uk, lgirdwood@gmail.com, broonie@kernel.org, rjw@rjwysocki.net, len.brown@intel.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 09.01.2019 16:14, Pavel Machek wrote:
> Hi!
>=20
>> Add support to check if platform's power will be cut off in suspend.
>> This will help drivers shared by multiple platforms to take only the
>> necessary actions while suspending/resuming (some platform may not need
>> to save/restore all the registers if platforms remains powered while
>> suspended). In this way suspend/resume time could be improved.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
>> ---
>>  include/linux/suspend.h |  6 ++++++
>>  kernel/power/suspend.c  | 13 +++++++++++++
>>  2 files changed, 19 insertions(+)
>>
>> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
>> index 3f529ad9a9d2..21f19b167fe2 100644
>> --- a/include/linux/suspend.h
>> +++ b/include/linux/suspend.h
>> @@ -173,6 +173,9 @@ static inline void dpm_save_failed_step(enum suspend=
_stat_step step)
>>   *	Called by the PM core if the suspending of devices fails.
>>   *	This callback is optional and should only be implemented by platform=
s
>>   *	which require special recovery actions in that situation.
>> + *
>> + * @off_in_suspend: Returns wether the platform's power will be cut off=
 at
>=20
> wether -- spelling?

Yep, I did it again :), sorry

>=20
>> @@ -185,6 +188,7 @@ struct platform_suspend_ops {
>>  	bool (*suspend_again)(void);
>>  	void (*end)(void);
>>  	void (*recover)(void);
>> +	bool (*off_in_suspend)(suspend_state_t state);
>>  };
>=20
> Dunno, should it be per-regulator? SoCs commonly have more than one
> power supply, with some of them off during suspend...

Every regulator has a suspend state which could be described via device
tree. In our case, besides other regulators, we have core regulator, which
is turned off in suspend at the end of the suspend procedure, when PMIC
detects a level transition on one of its pins, transition which is
triggered the moment the CPU is shut down (we are doing this from software
at the end of suspend procedure).

One aspect is that we map our proprietary power saving modes to Linux power
saving modes (suspend-to-ram and standby) at the system initialization. So,
we could have our backup mode mapped to any of suspend-to-ram or standby so
that when:
echo mem > /sys/power/state or
echo standby > /sys/power/state
the final power saving mode could be or not this backup mode (depending on
the mapping - which is done at system initialization based on kernel
parameters).

And so, depending on the mapped mode (which we currently know only from
arch/arm/mach-at91/) the real core's regulator could be on or off. We need
both these information to know if core's regulator would be off in suspend.

I chose to have it here, in platform_suspend_ops thinking that it is more
related to suspend procedure and that every platform could take use of it
to do whatever the platform specific things are done in suspend.
Also, I had in mind that regulator framework doesn't care (as far as I
know) what every regulator feeds.
It looked to me more proper to have it per platform since in our case we
have the mapping b/w Linux power saving modes (suspend-to-ram, standby) and
SoC specific power saving modes done only in arch/arm/mach-at91/.

I also though that doing so, and having the platform_off_in_suspend()
wrapper, in drivers we could only include linux/suspend.h and make use of
this wrapper and in case we would have had it per regulator we should have
been taken care in drivers or regulator framework which regulator deals
with feeding the core.

Thank you,
Claudiu Beznea

> 									Pavel
>=20
