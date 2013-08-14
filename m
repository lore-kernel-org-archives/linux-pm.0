From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/2] time: allow changing the timekeeper clock frequency
Date: Wed, 14 Aug 2013 11:17:50 -0700
Message-ID: <CALAqxLX8zkzofgGSdEVsP4wdnejd25iSFHyhBwp7nRVgEnqNrA@mail.gmail.com>
References: <201308081953.r78Jrt0Z029523@farm-0021.internal.tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <201308081953.r78Jrt0Z029523@farm-0021.internal.tilera.com>
Sender: cpufreq-owner@vger.kernel.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: lkml <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 8, 2013 at 12:34 PM, Chris Metcalf <cmetcalf@tilera.com> wrote:
> On the tile architecture, we use the processor clock tick as the time
> source.  However, when we perform dynamic frequency adjustment and
> modify the clock rate of the core, we have to update the timekeeper
> state to account for the new frequency, as well as for the time it took
> to actually modify the frequency across the chip as a whole.
>
> This change introduces two new functions, timekeeping_chfreq(), which
> changes the frequency, plus timekeeping_chfreq_prep(), used to put the
> timekeeping system in a state that is ready for a frequency change.
> More information is in the comments for the new functions.

So a long while back we had tried to adapt for clock frequency changes
on things like the TSC, but it resulting in *terrible* timekeeping as
the latency between the frequency change and the handling of the
notifications caused lots of clock drift, making it impossible for NTP
or other synchronization methods to work properly. So early on we made
a requirement that all clocksources have a constant frequency and
provided a way to disqualify any clocksources that change frequency.

So I'd be very hesitant to try to add any such behavior into the
timekeeping core. You may want to try to add some logic in the
clocksource driver itself to allow for the variable freq clocksource
to output what seems to be a fixed freq, and if we get some time on it
to prove that it can be made to work well, then we can see about
making it more generic.

Does that sound ok?

thanks
-john
