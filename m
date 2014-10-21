From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 01/47] kernel: Add support for poweroff handler call
 chain
Date: Tue, 21 Oct 2014 06:29:30 -0700
Message-ID: <54465FBA.8070007@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net> <1413864783-3271-2-git-send-email-linux@roeck-us.net> <54460140.50805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:34417 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933656AbaJUVwR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Oct 2014 17:52:17 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XghLk-002Fhv-A8
	for linux-pm@vger.kernel.org; Tue, 21 Oct 2014 21:52:16 +0000
In-Reply-To: <54460140.50805@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?UGhpbGlwcGUgUsOpdG9ybmF6?= <philippe.retornaz@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>

On 10/20/2014 11:46 PM, Philippe R=C3=A9tornaz wrote:
> Hello
>
> [...]
>> - Use raw notifiers protected by spinlocks instead of atomic notifie=
rs
> [...]
>
>> +/**
>> + *    do_kernel_power_off - Execute kernel poweroff handler call ch=
ain
>> + *
>> + *    Calls functions registered with register_power_off_handler.
>> + *
>> + *    Expected to be called from machine_power_off as last step of
>> + *    the poweroff sequence.
>> + *
>> + *    Powers off the system immediately if a poweroff handler funct=
ion
>> + *    has been registered. Otherwise does nothing.
>> + */
>> +void do_kernel_power_off(void)
>> +{
>> +    spin_lock(&power_off_handler_lock);
>> +    raw_notifier_call_chain(&power_off_handler_list, 0, NULL);
>> +    spin_unlock(&power_off_handler_lock);
>> +}
>
> I don't get it. You are still in atomic context inside the poweroff c=
allback
> since you lock it with a spinlock.
>
> It does not change much from the atomic notifier which was doing exac=
tly the
> same thing but with RCU:
>
>     rcu_read_lock();
>     ret =3D notifier_call_chain(&nh->head, val, v, nr_to_call, nr_cal=
ls);
>     rcu_read_unlock();
>
> Why not using the blocking_notifier_* family ?
> It will lock with a read-write semaphore under which you can sleep.
>
> For instance, twl4030_power_off will sleep, since it is doing I2C acc=
ess.
> So you cannot call it in atomic context.
>

Learning something new all the time. I assumed that spin_lock (unlike
spin_lock_irqsafe) would not run in atomic context.

I did not want to use a sleeping lock because I am not sure if that
works for all architectures; some disable (local) interrupts before
calling the function (eg arm and arm64), and I don't want to change
that semantics.

I have another idea how to get there without changing the lock situatio=
n
while executing the call chain - just set a flag indicating that it is
running and execute it without lock. Would that work ?

Guenter

