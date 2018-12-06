From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: Add 'high' and 'low' idle state metrics
Date: Thu, 6 Dec 2018 10:08:44 +0100
Message-ID: <CAJZ5v0jVJVFExmGexnaP2RZYWXDVLHYDTtK3O3vNGM1F122+7A@mail.gmail.com>
References: <006901d48cef$5bb88a00$13299e00$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <006901d48cef$5bb88a00$13299e00$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Giovanni Gherdovich <ggherdovich@suse.cz>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 6, 2018 at 12:08 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Hi Rafael,
>
> On 2018.12.03 04:32 Rafael J. Wysocki wrote:
>
> > Add two new metrics for CPU idle states, "high" and "low", to count
> > the number of times the given state had been asked for (or entered
> > from the kernel's perspective), but the observed idle duration turned
> > out to be too high or too low for it (respectively).
>
> I wonder about the "high" "low" terminology here.

I took these names, because they are concise and simple.  I could use
"below" and "above" respectively I guess.  What about these?

> > These mertics help to estimat the quality of the CPU idle governor
> > in use.
>
> Yes, very useful. Thanks.
>
> Here the terms are mixed with "deep" and "shallow"
>
> > +     unsigned long long      high; /* Number of times it's been too deep */
> > +     unsigned long long      low;  /* Number of times it's been too shallow */
>
> > +``high``
> > +     Total number of times this idle state had been asked for, but the
> > +     observed idle duration was too short to match its target residency.
> > +
>
> O.K. To avoid ambiguity, how about naming them "too_short" and "too_long"?

Well, I guess the "too_" prefix may be skipped, so "short" and "long"
could be used, but that's about the state, not about the idle
duration.  The state cannot be "too long" or "too short", arguably.
It might be "too deep" or "too shallow".

> > +``low``
> > +     Total number of times this idle state had been asked for, but a deeper
> > +     idle state would have been a better match for the observed idle duration.
>
> Even though I read the patch, by the time I actually looked at the numbers I had
> forgotten the meaning. I had look at idle state 0 and 4 (the deepest for my computer)
> to figure it out:
>
> doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state0/low
> 259871
> doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state0/high
> 0
> doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state4/low
> 0
> doug@s15:~/c$ cat /sys/devices/system/cpu/cpu0/cpuidle/state4/high
> 5584
>
> Because state 0 can not be too short and state 4 can not be too long.

Where "state" actually means "the target residency of state" I suppose? :-)
