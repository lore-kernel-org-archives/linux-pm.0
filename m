From: John Stultz <john.stultz@linaro.org>
Subject: Re: alarm timer/timerfd expiration does not abort suspend operation
Date: Fri, 10 Feb 2017 10:49:25 -0800
Message-ID: <CALAqxLVsC6ogzSA1E4egOYXMXH4Vqrxd8YS8NE=atona-cz=6w@mail.gmail.com>
References: <CAOdF7nu5WXw54oN0-jK+2A78q8aDwOa8D7QmeaejBJSRi7DEiw@mail.gmail.com>
 <alpine.DEB.2.20.1702101041240.4036@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34202 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752351AbdBJStq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2017 13:49:46 -0500
Received: by mail-wr0-f179.google.com with SMTP id o16so114662471wra.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2017 10:49:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1702101041240.4036@nanos>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Gabriel Beddingfield <gabe@nestlabs.com>, LKML <linux-kernel@vger.kernel.org>, Harpreet Sangha <eliptus@google.com>, Andrew LeCain <alecain@google.com>, John Thompson <jthomp@nestlabs.com>, Paul Trautrim <paultrautrim@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Eric Caruso <ejcaruso@google.com>, Greg Hackmann <ghackmann@google.com>, Todd Poynor <toddpoynor@google.com>, Rom Lemarchand <romlem@google.com>

On Fri, Feb 10, 2017 at 1:43 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 3 Feb 2017, Gabriel Beddingfield wrote:
>> Hi Thomas and John,
>>
>> TL;DR: if an alarmtimer-backed timerfd expires just prior to
>> alarmtimer_suspend() begin called, the system will continue to go into
>> suspend (with possibly no future wakeups scheduled). The expected behavior
>> is that the timer expiration would cause the suspend operation to abort. I
>> see several ways to fix it and want to know your preference.
>>
>> When using an alarmtimer-backed timerfd (i.e. CLOCK_BOOTTIME_ALARM or
>> CLOCK_REALTIME_ALARM) we have observed the following race condition:
>>
>> 1. Userspace commands the system to go into suspend (echo mem >
>> /sys/power/state)
>> 2. The alarmtimer for a timerfd expires, making the timer inactive until
>> someone reads from the file descriptor.
>> 3. alarmtimer_suspend() does not find any pending timers, and therefore
>> does not schedule a wakeup.
>> 4. device goes into suspend.
>>
>> However, if steps 2 and 3 are swapped, alarmtimer_suspend() would have seen
>> that an expiration was "soon" and cause an abort of the suspend. This can
>> be reproduced on an idle system by having a process aggressively doing
>> `echo mem > /sys/power/state' while another process sets a 4-sec repeating
>> timerfd backed by CLOCK_BOOTTIME_ALARM. Eventually the system will go to
>> sleep and not wake up.
>>
>> I see a few ways to fix it:
>>
>> 1. Create a wakeup_source for each timerfd, and if it's an alarm timer call
>> __pm_stay_awake() in timerfd_triggered() and __pm_relax() in timerfd_read().
>> 2. call pm_system_wakeup() in alarmtimer_fired()
>> 3. call `if (isalarm(ctx)) pm_system_wakeup();' in timerfd_triggered()
>> 4. call __pm_wakeup_event(ws, 2 * MSECS_PER_SEC) in alarmtimer_fired()
>> 5. call `if (isalarm(ctc)) __pm_wakeup_event(ws, 2 * MSECS_PER_SEC);' in
>> timerfd_triggered() (using a static struct wakeup_source).
>>
>> I think #1 is right, followed by #2. They all have pros/cons:
>>
>> * #1 Can eliminate race conditions (rather than an arbitrary 2-sec
>> timeout)... but is effectively holding a hard-to-trace block on all PM
>> operations (e.g. read/write of /sys/power/wakeup_count blocks until someone
>> reads from the file descriptor).
>> * #2 Matches the current behavior of the "happy case"... but bypasses the
>> userspace policy system provided by wakeup.
>> * #3 same pro/con as #2... but solution is specific to timerfd's.
>> * #4 Matches the current behavior of the "happy case" if and only if
>> userspace is using the 'wakeup' system, otherwise doesn't change any
>> behavior. But, I wonder how many people think the current behavior is a bug.
>> * #5 Same pro/con as #4... but solution is specific to timerfd's.
>>
>> I've attached a patch that implements #1.

Sorry for not getting back to you earlier (been traveling this week).

I'm surprised this issue hasn't bitten any of the android folks, as I
believe they have been making use of this for some time now. CC'ing a
few just to make sure we're all on the same page.

The approach you took in your patch looks basically ok to me, though I
think the __pm_wakeup_event() method in #4 sounds safer, just to avoid
the problematic issue if no one is waiting on the fd.

Though I worry I'm not quite understanding the con for that case
properly, so maybe you can clarify what concerns you there?

thanks
-john
