From: =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@gmail.com>
Subject: Re: [PATCH v2 01/47] kernel: Add support for poweroff handler call
 chain
Date: Wed, 22 Oct 2014 10:02:57 +0200
Message-ID: <544764B1.9020303@gmail.com>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net> <1413864783-3271-2-git-send-email-linux@roeck-us.net> <54460140.50805@gmail.com> <54465FBA.8070007@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54465FBA.8070007@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>
List-Id: linux-pm@vger.kernel.org

Le 21/10/2014 15:29, Guenter Roeck a =C3=A9crit :
> On 10/20/2014 11:46 PM, Philippe R=C3=A9tornaz wrote:
>> Hello
>>
>> [...]
>>> - Use raw notifiers protected by spinlocks instead of atomic notifi=
ers
>> [...]
>>
>>> +/**
>>> + *    do_kernel_power_off - Execute kernel poweroff handler call c=
hain
>>> + *
>>> + *    Calls functions registered with register_power_off_handler.
>>> + *
>>> + *    Expected to be called from machine_power_off as last step of
>>> + *    the poweroff sequence.
>>> + *
>>> + *    Powers off the system immediately if a poweroff handler func=
tion
>>> + *    has been registered. Otherwise does nothing.
>>> + */
>>> +void do_kernel_power_off(void)
>>> +{
>>> +    spin_lock(&power_off_handler_lock);
>>> +    raw_notifier_call_chain(&power_off_handler_list, 0, NULL);
>>> +    spin_unlock(&power_off_handler_lock);
>>> +}
>>
>> I don't get it. You are still in atomic context inside the poweroff
>> callback
>> since you lock it with a spinlock.
[...]
>>
>> Why not using the blocking_notifier_* family ?
>> It will lock with a read-write semaphore under which you can sleep.
>>
>> For instance, twl4030_power_off will sleep, since it is doing I2C ac=
cess.
>> So you cannot call it in atomic context.
>>
>
> Learning something new all the time. I assumed that spin_lock (unlike
> spin_lock_irqsafe) would not run in atomic context.
>
> I did not want to use a sleeping lock because I am not sure if that
> works for all architectures; some disable (local) interrupts before
> calling the function (eg arm and arm64), and I don't want to change
> that semantics.

You're right and it even disable all others CPUs (if any).
I don't understand why it needs to disable local interrupts since the
code path to pm_power_off is simply doing:

syscall -> migrate to reboot cpu -> disable local interrupt -> disable=20
others cpu -> pm_power_off().

I don't understand why we cannot re-enable interrupts right before=20
pm_power_off().
And it looks like that all pm_power_off callbacks which can sleep are=20
broken.
I still wonder how i2c communication can works without local interrupts=
=20
=2E.. it looks
like somebody is re-enabling them (or the code was never run)

> I have another idea how to get there without changing the lock situat=
ion
> while executing the call chain - just set a flag indicating that it i=
s
> running and execute it without lock. Would that work ?

I don't think inventing a new locking mechanism is a good solution.
We need first to know for sure if we can sleep or not in pm_power_off.
If yes then we need to re-enable local interrupts and we can use a mute=
x.
If not then the atomic notifier is fine and a lots of drivers are wrong=
=2E

Thanks,

Philippe
