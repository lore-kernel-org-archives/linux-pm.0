From: Gabriel Beddingfield <gabe@nestlabs.com>
Subject: Re: alarm timer/timerfd expiration does not abort suspend operation
Date: Fri, 10 Feb 2017 11:23:45 -0800
Message-ID: <CAOdF7nsiGsPWzcnUVoKPLpT4kfZC3b4VEF=HfExU3FCfsvhKsw@mail.gmail.com>
References: <CAOdF7nu5WXw54oN0-jK+2A78q8aDwOa8D7QmeaejBJSRi7DEiw@mail.gmail.com>
 <alpine.DEB.2.20.1702101041240.4036@nanos> <CALAqxLVsC6ogzSA1E4egOYXMXH4Vqrxd8YS8NE=atona-cz=6w@mail.gmail.com>
 <CAOdF7nvBknCHHk2i3ZONKvnbaCFwEVogM8fVhXnx8FyykU3n_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:35995 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbdBJTYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Feb 2017 14:24:45 -0500
Received: by mail-ot0-f169.google.com with SMTP id 32so35781249oth.3
        for <linux-pm@vger.kernel.org>; Fri, 10 Feb 2017 11:23:46 -0800 (PST)
In-Reply-To: <CAOdF7nvBknCHHk2i3ZONKvnbaCFwEVogM8fVhXnx8FyykU3n_A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>, Harpreet Sangha <eliptus@google.com>, Andrew LeCain <alecain@google.com>, John Thompson <jthomp@nestlabs.com>, Paul Trautrim <paultrautrim@google.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Eric Caruso <ejcaruso@google.com>, Greg Hackmann <ghackmann@google.com>, Todd Poynor <toddpoynor@google.com>, Rom Lemarchand <romlem@google.com>

Hi John,

Re-sending because VGER rejected my hipster HTML mail... sorry!

On Fri, Feb 10, 2017 at 10:49 AM, John Stultz <john.stultz@linaro.org> wrote:
>> I see a few ways to fix it:
>>
>> 1. Create a wakeup_source for each timerfd, and if it's an alarm timer
>> call
>> __pm_stay_awake() in timerfd_triggered() and __pm_relax() in
>> timerfd_read().
>> 2. call pm_system_wakeup() in alarmtimer_fired()
>> 3. call `if (isalarm(ctx)) pm_system_wakeup();' in timerfd_triggered()
>> 4. call __pm_wakeup_event(ws, 2 * MSECS_PER_SEC) in alarmtimer_fired()
>> 5. call `if (isalarm(ctc)) __pm_wakeup_event(ws, 2 * MSECS_PER_SEC);'
>> in
>> timerfd_triggered() (using a static struct wakeup_source).
[snip]
>> * #4 Matches the current behavior of the "happy case" if and only if
>> userspace is using the 'wakeup' system, otherwise doesn't change any
>> behavior. But, I wonder how many people think the current behavior is a
>> bug.
[snip]
> The approach you took in your patch looks basically ok to me, though I
>
> think the __pm_wakeup_event() method in #4 sounds safer, just to avoid
> the problematic issue if no one is waiting on the fd.
>
> Though I worry I'm not quite understanding the con for that case
> properly, so maybe you can clarify what concerns you there?

The concern is born of my personal experience: I was ignorant of the
"wakeup_count" protocol, and so I wasn't using it. Because of this
__pm_wakeup_event() would not block a suspend because I never wrote to
wakeup_count. On the other hand, method #2 will work unconditionally.

-gabe
