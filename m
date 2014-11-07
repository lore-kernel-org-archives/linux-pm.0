From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 01/48] kernel: Add support for power-off handler call
 chain
Date: Thu, 06 Nov 2014 19:00:03 -0800
Message-ID: <545C35B3.30902@roeck-us.net>
References: <1415292213-28652-1-git-send-email-linux@roeck-us.net> <3183593.9HaIZKjCKr@vostro.rjw.lan> <20141106222703.GA6377@roeck-us.net> <6901931.ThbbTy3BuF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38490 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751051AbaKGDBU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 6 Nov 2014 22:01:20 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XmZnI-000gni-4L
	for linux-pm@vger.kernel.org; Fri, 07 Nov 2014 03:01:00 +0000
In-Reply-To: <6901931.ThbbTy3BuF@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@gmail.com>, Romain Perier <romain.perier@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 11/06/2014 04:16 PM, Rafael J. Wysocki wrote:
> On Thursday, November 06, 2014 02:27:03 PM Guenter Roeck wrote:
>> On Thu, Nov 06, 2014 at 11:30:59PM +0100, Rafael J. Wysocki wrote:
>>> On Thursday, November 06, 2014 08:42:45 AM Guenter Roeck wrote:
>>>> Various drivers implement architecture and/or device specific mean=
s to
>>>> power off the system.  For the most part, those drivers set the gl=
obal
>>>> variable pm_power_off to point to a function within the driver.
>>>>
>>>> This mechanism has a number of drawbacks.  Typically only one sche=
me
>>>> to remove power is supported (at least if pm_power_off is used).
>>>> At least in theory there can be multiple means remove power, some =
of
>>>> which may be less desirable. For example, some mechanisms may only
>>>> power off the CPU or the CPU card, while another may power off the
>>>> entire system.  Others may really just execute a restart sequence
>>>> or drop into the ROM monitor. Using pm_power_off can also be racy
>>>> if the function pointer is set from a driver built as module, as t=
he
>>>> driver may be in the process of being unloaded when pm_power_off i=
s
>>>> called. If there are multiple power-off handlers in the system, re=
moving
>>>> a module with such a handler may inadvertently reset the pointer t=
o
>>>> pm_power_off to NULL, leaving the system with no means to remove p=
ower.
>>>>
>>>> Introduce a system power-off handler call chain to solve the descr=
ibed
>>>> problems.  This call chain is expected to be executed from the arc=
hitecture
>>>> specific machine_power_off() function.  Drivers and architeceture =
code
>>>> providing system power-off functionality are expected to register =
with
>>>> this call chain.  When registering a power-off handler, callers ca=
n
>>>> provide a priority to control power-off handler execution sequence
>>>> and thus ensure that the power-off handler with the optimal capabi=
lities
>>>> to remove power for a given system is called first.
>>>>
>>>> Cc: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
>>>> Cc: Alexander Graf <agraf@suse.de>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>>> Cc: Heiko Stuebner <heiko@sntech.de>
>>>> Cc: Lee Jones <lee.jones@linaro.org>
>>>> Cc: Len Brown <len.brown@intel.com>
>>>> Cc: Pavel Machek <pavel@ucw.cz>
>>>> Cc: Philippe R=C3=A9tornaz <philippe.retornaz@gmail.com>
>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>> Cc: Romain Perier <romain.perier@gmail.com>
>>>> Acked-by: Pavel Machek <pavel@ucw.cz>
>>>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> v5:
>>>> - Rebase to v3.18-rc3
>>>> v4:
>>>> - Do not use notifiers but internal functions and data structures =
to manage
>>>>    the list of power-off handlers. Drop unused parameters from cal=
lbacks, and
>>>>    make the power-off function type void.
>>>>    Code to manage and walk the list of callbacks is derived from n=
otifier.c.
>>>> v3:
>>>> - Rename new file to power_off_handler.c
>>>> - Replace poweroff in all newly introduced variables and in text
>>>>    with power_off or power-off as appropriate
>>>> - Replace POWEROFF_PRIORITY_xxx with POWER_OFF_PRIORITY_xxx
>>>> - Execute power-off handlers without any locks held
>>>> v2:
>>>> - poweroff -> power_off
>>>> - Add defines for default priorities
>>>> - Use raw notifiers protected by spinlocks instead of atomic notif=
iers
>>>> - Add register_poweroff_handler_simple
>>>> - Add devm_register_power_off_handler
>>>>
>>>>   include/linux/pm.h               |  28 ++++
>>>>   kernel/power/Makefile            |   1 +
>>>>   kernel/power/power_off_handler.c | 293 +++++++++++++++++++++++++=
++++++++++++++
>>>>   3 files changed, 322 insertions(+)
>>>>   create mode 100644 kernel/power/power_off_handler.c
>>>>
>>>> diff --git a/include/linux/pm.h b/include/linux/pm.h
>>>> index 383fd68..a4d6bf8 100644
>>>> --- a/include/linux/pm.h
>>>> +++ b/include/linux/pm.h
>>>> @@ -35,6 +35,34 @@ extern void (*pm_power_off)(void);
>>>>   extern void (*pm_power_off_prepare)(void);
>>>>
>>>>   struct device; /* we have a circular dep with device.h */
>>>> +
>>>> +/*
>>>> + * Data structures and callbacks to manage power-off handlers
>>>> + */
>>>> +
>>>> +struct power_off_handler_block {
>>>> +	void (*handler)(struct power_off_handler_block *);
>>>> +	struct power_off_handler_block __rcu *next;
>>>> +	int priority;
>>>> +};
>>>> +
>>>> +int register_power_off_handler(struct power_off_handler_block *);
>>>> +int devm_register_power_off_handler(struct device *,
>>>> +				    struct power_off_handler_block *);
>>>> +int register_power_off_handler_simple(void (*function)(void), int=
 priority);
>>>> +int unregister_power_off_handler(struct power_off_handler_block *=
);
>>>> +void do_kernel_power_off(void);
>>>> +bool have_kernel_power_off(void);
>>>> +
>>>> +/*
>>>> + * Pre-defined power-off handler priorities
>>>> + */
>>>> +#define POWER_OFF_PRIORITY_FALLBACK	0
>>>> +#define POWER_OFF_PRIORITY_LOW		64
>>>> +#define POWER_OFF_PRIORITY_DEFAULT	128
>>>> +#define POWER_OFF_PRIORITY_HIGH		192
>>>> +#define POWER_OFF_PRIORITY_HIGHEST	255
>>>
>>> I'm not sure why we need these gaps in the priority space.
>>>
>>> I guess it might be possible to use
>>>
>>> enum power_off_priority {
>>> 	POWER_OFF_PRIORITY_FALLBACK =3D 0,
>>> 	POWER_OFF_PRIORITY_LOW,
>>> 	POWER_OFF_PRIORITY_DEFAULT,
>>> 	POWER_OFF_PRIORITY_HIGH,
>>> 	POWER_OFF_PRIORITY_HIGHEST,
>>> 	POWER_OFF_PRIORITY_LIMIT,
>>> };
>>
>> I retained the large number space on purpose, specifically to permit=
 in-between
>> priorities. In other words, I want people to be able to say "priorit=
y for this
>> handler is higher than low but lower than default". After all, the d=
efines were
>> intended as hints, not as a "Thou shall use those and only those pri=
orities".
>
> Problem with that is how they are supposed to know what priority to u=
se then.
>
> How do I know if my priority is between DEFAULT and HIGH and whether =
it is
> closer to HIGH or closer to DEFAULT?  What are the rules?
>
Guess there is too much of a Libertarian in me to make up such rules.
Or, in other words, I didn't think that more explicit rules than the on=
es
provided were needed.

> The only rule that seems to be there is "this handler should be tried=
 before
> that one, so it needs to have a higher priority".  But now the questi=
on is
> how people are going to know which handlers they are competing with a=
nd whether
> or not they are more "important".
>
Keep in mind those are power-off handlers. The "rule", if one is needed=
,
would be that the power-off handler which powers off more parts of the =
system
should get higher priority. Which one that is is depends on the platfor=
m.
I would think that it is in people's interest not to shoot themselves
into the foot, but maybe I am wrong.

>> Having said that, the important part is to get the series accepted, =
so I won't
>> argue if that is what it takes to get an Ack. Let me know.
>
> This isn't worth fighting over in my view, so I won't if everyone els=
e is fine
> with it.
>

Linus raised pretty much the same or a similar concern. Everyone else, =
as far
as I can see, doesn't seem to care. Given that, and since I don't have =
a strong
opinion either, I'll change it to an enum in the next version. If there=
 is anyone
who disagrees with that, the time to speak up is now.

Please let me know if you have any other concerns.

Thanks,
Guenter

