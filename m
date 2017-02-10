From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: alarm timer/timerfd expiration does not abort suspend
 operation
Date: Fri, 10 Feb 2017 10:43:22 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1702101041240.4036@nanos>
References: <CAOdF7nu5WXw54oN0-jK+2A78q8aDwOa8D7QmeaejBJSRi7DEiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOdF7nu5WXw54oN0-jK+2A78q8aDwOa8D7QmeaejBJSRi7DEiw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriel Beddingfield <gabe@nestlabs.com>
Cc: LKML <linux-kernel@vger.kernel.org>, John Stultz <john.stultz@linaro.org>, Harpreet Sangha <eliptus@google.com>, Andrew LeCain <alecain@google.com>, John Thompson <jthomp@nestlabs.com>, Paul Trautrim <paultrautrim@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 3 Feb 2017, Gabriel Beddingfield wrote:

Cc'ing the PM folks

> Hi Thomas and John,
> 
> TL;DR: if an alarmtimer-backed timerfd expires just prior to
> alarmtimer_suspend() begin called, the system will continue to go into
> suspend (with possibly no future wakeups scheduled). The expected behavior
> is that the timer expiration would cause the suspend operation to abort. I
> see several ways to fix it and want to know your preference.
> 
> When using an alarmtimer-backed timerfd (i.e. CLOCK_BOOTTIME_ALARM or
> CLOCK_REALTIME_ALARM) we have observed the following race condition:
> 
> 1. Userspace commands the system to go into suspend (echo mem >
> /sys/power/state)
> 2. The alarmtimer for a timerfd expires, making the timer inactive until
> someone reads from the file descriptor.
> 3. alarmtimer_suspend() does not find any pending timers, and therefore
> does not schedule a wakeup.
> 4. device goes into suspend.
> 
> However, if steps 2 and 3 are swapped, alarmtimer_suspend() would have seen
> that an expiration was "soon" and cause an abort of the suspend. This can
> be reproduced on an idle system by having a process aggressively doing
> `echo mem > /sys/power/state' while another process sets a 4-sec repeating
> timerfd backed by CLOCK_BOOTTIME_ALARM. Eventually the system will go to
> sleep and not wake up.
> 
> I see a few ways to fix it:
> 
> 1. Create a wakeup_source for each timerfd, and if it's an alarm timer call
> __pm_stay_awake() in timerfd_triggered() and __pm_relax() in timerfd_read().
> 2. call pm_system_wakeup() in alarmtimer_fired()
> 3. call `if (isalarm(ctx)) pm_system_wakeup();' in timerfd_triggered()
> 4. call __pm_wakeup_event(ws, 2 * MSECS_PER_SEC) in alarmtimer_fired()
> 5. call `if (isalarm(ctc)) __pm_wakeup_event(ws, 2 * MSECS_PER_SEC);' in
> timerfd_triggered() (using a static struct wakeup_source).
> 
> I think #1 is right, followed by #2. They all have pros/cons:
> 
> * #1 Can eliminate race conditions (rather than an arbitrary 2-sec
> timeout)... but is effectively holding a hard-to-trace block on all PM
> operations (e.g. read/write of /sys/power/wakeup_count blocks until someone
> reads from the file descriptor).
> * #2 Matches the current behavior of the "happy case"... but bypasses the
> userspace policy system provided by wakeup.
> * #3 same pro/con as #2... but solution is specific to timerfd's.
> * #4 Matches the current behavior of the "happy case" if and only if
> userspace is using the 'wakeup' system, otherwise doesn't change any
> behavior. But, I wonder how many people think the current behavior is a bug.
> * #5 Same pro/con as #4... but solution is specific to timerfd's.
> 
> I've attached a patch that implements #1.
> 
> -gabe
> 
