From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 6/7][Resend] cpufreq: Support for fast frequency switching
Date: Tue, 29 Mar 2016 14:10:45 +0200
Message-ID: <2395635.E95YnUO5Qt@vostro.rjw.lan>
References: <7262976.zPkLj56ATU@vostro.rjw.lan> <CAJZ5v0inp178MJ=vxN-Qss1cBW5Ogmrq0xpccKfPB5Lky_i-Wg@mail.gmail.com> <56F96039.9070500@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <56F96039.9070500@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Steve Muckle <steve.muckle@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Juri Lelli <juri.lelli@arm.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Ingo Molnar <mingo@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, March 28, 2016 09:47:53 AM Steve Muckle wrote:
> On 03/25/2016 06:46 PM, Rafael J. Wysocki wrote:
> >>> @@ -1726,6 +1810,34 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
> >>> >>   *                              GOVERNORS                            *
> >>> >>   *********************************************************************/
> >>> >>
> >>> >> +/**
> >>> >> + * cpufreq_driver_fast_switch - Carry out a fast CPU frequency switch.
> >>> >> + * @policy: cpufreq policy to switch the frequency for.
> >>> >> + * @target_freq: New frequency to set (may be approximate).
> >>> >> + *
> >>> >> + * Carry out a fast frequency switch from interrupt context.
> >> >
> >> > I think that should say atomic rather than interrupt as this might not
> >> > be called from interrupt context.
> >
> > "Interrupt context" here means something like "context that cannot
> > sleep" and it's sort of a traditional way of calling that.  I
> > considered saying "atomic context" here, but then decided that it
> > might suggest too much.
> > 
> > Maybe something like "Carry out a fast frequency switch without
> > sleeping" would be better?
> 
> Yes I do think that's preferable. I also wonder if it makes sense to
> state expectations of how long the operation should take - i.e. not only
> will it not sleep, but it is expected to complete "quickly." However I
> accept that it is not well defined what that means. Maybe a mention that
> this may be called in scheduler hot paths.

OK

