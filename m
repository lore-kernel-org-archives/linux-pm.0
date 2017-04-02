From: Andres Oportus <andresoportus@android.com>
Subject: Re: [RFC/RFT][PATCH] cpufreq: schedutil: Reduce frequencies slower
Date: Sat, 1 Apr 2017 21:38:12 -0700
Message-ID: <CAFEhuF=n9+LkQoMVLsNCo9peLNUo5XRBX8NTmcsuuJwYJwUtGw@mail.gmail.com>
References: <1514608.eWxQqcMBcc@aspire.rjw.lan> <20170331102223.GS19929@e106622-lin>
 <6978951.cfP8K2rCI0@aspire.rjw.lan> <CAFEhuF=sWvuC3Q1NsqdRuiGzK4uD8ie5zbEnVsuGMdJK3y9e3Q@mail.gmail.com>
 <CAFEhuFnf=N3z2fvajqGT4mN7NtU3fAeGq1CUa_WRQj-PBonwUQ@mail.gmail.com> <CAJZ5v0h=+XM6ZP62n_M8zq2mNGm6o8j0XxWehz3jam8Cgdo=vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f177.google.com ([209.85.216.177]:36803 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750780AbdDBEiN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Apr 2017 00:38:13 -0400
Received: by mail-qt0-f177.google.com with SMTP id r45so91474488qte.3
        for <linux-pm@vger.kernel.org>; Sat, 01 Apr 2017 21:38:13 -0700 (PDT)
In-Reply-To: <CAJZ5v0h=+XM6ZP62n_M8zq2mNGm6o8j0XxWehz3jam8Cgdo=vg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Juri Lelli <juri.lelli@arm.com>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Patrick Bellasi <patrick.bellasi@arm.com>, Joel Fernandes <joelaf@google.com>, Morten Rasmussen <morten.rasmussen@arm.com>, John <john.ettedgui@gmail.com>

On Sat, Apr 1, 2017 at 7:03 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Sun, Apr 2, 2017 at 1:29 AM, Andres Oportus
> <andresoportus@android.com> wrote:
>> On Sat, Apr 1, 2017 at 1:39 PM, Andres Oportus
>> <andresoportus@android.com> wrote:
>>> Hi Rafael, Juri,
>
> [cut]
>
>>>>
>>>> > As we discussed at the last LPC, having an energy model handy and use
>>>> > that to decide how quickly to ramp up or slow down seems the desirable
>>>> > long term solution, but we probably need something (as you are
>>>> > proposing) until we get there.
>>>>
>>>> Well, we definitely need something to address real use cases, like the one
>>>> that
>>>> I responded to with this patch. :-)
>>>
>>> I don't know the history/intent behind schedutil rate limiting, but if we
>
> Basically, the hardware cannot be requested to change the frequency
> too often as that would be too expensive in general.
Expensiveness of changing the frequency too often is one of the
reasons we need to have down throttle in Android, but we can't have
this value also slow down the frequency increases (so up throttle
being equal to down throttle is bad for us) which would affect
interactivity/response-time.

>
>>> make it to be only "down" as Juri mentioned we would not be adding a new
>>> tunable but rather changing the current one to be more restricted (maybe
>>> some renaming would be in order if this is done), this would provide
>>> hysteresis to reduce this problem without locking the amount of the
>>> hysteresis which may not work for all platforms.  I also agree that "it is
>>> difficult to imagine that the same values will always be suitable for every
>>> workload", but without any value to control the whole system, we get nothing
>>> in between.  Ultimately I also think we should solve the hysteresis problem
>>> at the root, i.e. the input to the governor in the form of util/load that
>>> has not only hysteresis and energy model, but also any other behavioral
>>> inputs built-in.
>
> That's long-term, though, and besides knobs only help if users change
> the defaults.  From my experience they usually don't do that.
Agreed that it is long term.  Regarding knobs, we are already tuning
the down throttle value for Android (we currently do 50ms down for the
similar knob in schedfreq).

>
> Thanks,
> Rafael

Thanks,
Andres
