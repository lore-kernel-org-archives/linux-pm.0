From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH v10 02/15] sched/cpufreq: Prepare schedutil for Energy
 Aware Scheduling
Date: Tue, 11 Dec 2018 12:17:45 +0000
Message-ID: <20181211121742.d6ujfyccwn7t63b3@queper01-lin>
References: <20181203095628.11858-1-quentin.perret@arm.com>
 <20181203095628.11858-3-quentin.perret@arm.com>
 <CAJZ5v0iygh1Kh4FnOE=2GzcUHW+FBV+9ZrotAfmXtgdk==6tNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iygh1Kh4FnOE=2GzcUHW+FBV+9ZrotAfmXtgdk==6tNg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Chris Redpath <chris.redpath@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Valentin Schneider <valentin.schneider@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Thara Gopinath <thara.gopinath@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joel@joelfernandes.org>, Steve Muckle <smuckle@google.com>, adharmap@codeaurora.org, Saravana Kannan <skann>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Tuesday 11 Dec 2018 at 13:01:24 (+0100), Rafael J. Wysocki wrote:
> On Mon, Dec 3, 2018 at 10:56 AM Quentin Perret <quentin.perret@arm.com> wrote:
> 
> [cut]
> 
> >  #ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
> > +/**
> > + * enum schedutil_type - CPU utilization type
> > + * @FREQUENCY_UTIL:    Utilization used to select frequency
> > + * @ENERGY_UTIL:       Utilization used during energy calculation
> > + *
> > + * The utilization signals of all scheduling classes (CFS/RT/DL) and IRQ time
> > + * need to be aggregated differently depending on the usage made of them. This
> > + * enum is used within schedutil_freq_util() to differentiate the types of
> > + * utilization expected by the callers, and adjust the aggregation accordingly.
> > + */
> > +enum schedutil_type {
> > +       FREQUENCY_UTIL,
> > +       ENERGY_UTIL,
> > +};
> 
> Why not to use bool instead of this?  Do you expect to have more than
> just two values in the future?  If so, what would be the third one?

Indeed, the only reason is that an enum is easier to extend, if need be.
I think you mentioned some time ago that CPUIdle could be, in principle,
interested in having access to aggregated utilization signals of CPUs:

https://lore.kernel.org/lkml/CAJZ5v0j=EYnANGAj9bd44eeux1eCfeMtdn9npe5pSAzE8EVKaA@mail.gmail.com/

So yeah, I kept Peter's original enum and went for documenting the type,
as you suggested on v7 :-)

Thanks,
Quentin
