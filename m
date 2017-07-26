From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/4 v2] x86: use common aperfmperf_khz_on_cpu() to
 calculate KHz using APERF/MPERF
Date: Wed, 26 Jul 2017 13:23:50 -0400
Message-ID: <CAJvTdKmymtO99fAcjzjC4Rp0bWdOiH4vGzr_kOFoM4mNr6ihuA@mail.gmail.com>
References: <1498281114-3868-1-git-send-email-lenb@kernel.org> <006201d30595$e0a23870$a1e6a950$@net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <006201d30595$e0a23870$a1e6a950$@net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <dsmythies@telus.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Doug,

Clearly you are a "discerning user", who understands the limitations
of the kernel sysfs interface,
both new and old, for communicating frequency.  With the limitations
of the (old and new)
sysfs interfaces, why are you using it, rather than turbostat?

>> As with previous methods of calculating MHz,
>> idle time is excluded.
>
> Which makes the response time to a correct answer
> asymmetric. i.e. removal of a load on a CPU will
> linger much much longer that adding a load on a CPU.

If the measurement interval is not defined, then a "correct answer"
is also no defined.

Users now have the capability to define the measurement interval.
Before they didn't, they just could observe it was "short enough
that it looks current".  Others may want to measure frequency over
a longer (or even known) interval, and the previous code made
that impossible.

Also, you may be interested to know that in HWP mode, intel_pstate
used to have a periodic timer who's _only_ job was to wake up the
CPU so that the driver could update the frequency statistic for sysfs.
(now it is a scheduler callback)
Sure, a "discerning user" may have noticed that they have "fresh" data
in sysfs, but most users were better served by not having a timer
fire to refresh data that they'll never consume...  The new code
never runs at all, unless the user asks it to.

> Somehow, somewhere along the way, turbostat no longer seems
> to use base_MHz based on the actual TSC. It used to.

True, though not directly related to this thread...
On current and future Intel hardware, base_mhz and TSC rate
are not in the same clock domain.  Only on very specific configurations
are those clock rates now equal.

>> +     /* Don't bother re-computing within 10 ms */
>> +     if (time_before(jiffies, s->jiffies + HZ/100))
>> +             return;
>
> The above condition would be 8 mSec on a 250 Hertz kernel,
> wouldn't it?
> (I don't care, I'm just saying.)

True.  We could replace the "10ms" comment with "typically 10ms", or "recently".
Note that the value here isn't precise, it is there just to prevent
wasted overhead.
The previous version of this patch was equally valid with a value 10x larger.

> Summary:
>
> . There no longer seems to be a way to check the CPU frequency without affecting the processor (i.e. forcing a wakeup),
> thereby potentially influencing the system under test.

This has always been true, just that the wakeups used to happen inside
the kernel -- whether you consumed the answer or not.

> . Yes, the old way might have been a "lie", but in some situations it was much much less of a "lie", and took data that
> was already available (and at the very maximum 4 seconds old), and didn't force a wakeup, thus monitoring CPU frequency
> was a negligible perturbation to the system.

Frequency data isn't "already available", it has to be measured.
A measurement is not valid unless it is made over a known measurement interval.

> . Now the data is as old as the time the command was run, which might be hours.

True, under controlled conditions, the sysfs measurement interval
could be days or months long.

If a known interval is desired, than something need to provoke a read
of the attribute
at the start of the interval of interest.

Yes, we could do this inside the kernel, but then that would add
overhead  to the
system for the vast majority of users who never even read this attribute,
and it would also take control of the interval away from the user.

Making this interface more complex inside the kernel doesn't seem like
a prudent path to go down
when turbostat already exists and can already measure
concurrent/overlapping intervals of arbitrary length
in user-space.

While I still haven't gleaned exactly what you are trying to measure,
I'm very much interested to know if/why you can't measure it using
the new sysfs attribute semantics, or better yet, using turbostat.

thanks,
Len Brown, Intel Open Source Technology Center
