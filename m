From: Patrick Bellasi <patrick.bellasi@arm.com>
Subject: Re: [PATCH v2 12/12] sched/core: uclamp: use percentage clamp values
Date: Tue, 24 Jul 2018 18:17:39 +0100
Message-ID: <20180724171739.GC3162@e110439-lin>
References: <20180716082906.6061-1-patrick.bellasi@arm.com>
 <20180716082906.6061-13-patrick.bellasi@arm.com>
 <CAJuCfpEwRtXoa_tnWTFP8CuyPMHsLAXky14K_jyphEeo2d32qg@mail.gmail.com>
 <20180724164303.GB3162@e110439-lin>
 <CAJuCfpHddNKXNVBs21sCADcHjW7zxxue8jg1B4KbPh-QLNe46g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuCfpHddNKXNVBs21sCADcHjW7zxxue8jg1B4KbPh-QLNe46g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Paul Turner <pjt@google.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Morten Rasmussen <morten.rasmussen@arm.com>, Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@google.com>, Joel Fernandes <joelaf@google.com>, Steve Muckle <smuckle@google.com>
List-Id: linux-pm@vger.kernel.org

On 24-Jul 10:11, Suren Baghdasaryan wrote:
> On Tue, Jul 24, 2018 at 9:43 AM, Patrick Bellasi
> <patrick.bellasi@arm.com> wrote:
> > On 21-Jul 21:04, Suren Baghdasaryan wrote:
> >> On Mon, Jul 16, 2018 at 1:29 AM, Patrick Bellasi
> >> <patrick.bellasi@arm.com> wrote:
> >
> > [...]
> >
> >> > +static inline unsigned int scale_from_percent(unsigned int pct)
> >> > +{
> >> > +       WARN_ON(pct > 100);
> >> > +
> >> > +       return ((SCHED_FIXEDPOINT_SCALE * pct) / 100);
> >> > +}
> >> > +
> >> > +static inline unsigned int scale_to_percent(unsigned int value)
> >> > +{
> >> > +       unsigned int rounding = 0;
> >> > +
> >> > +       WARN_ON(value > SCHED_FIXEDPOINT_SCALE);
> >> > +
> >> > +       /* Compensate rounding errors for: 0, 256, 512, 768, 1024 */
> >> > +       if (likely((value & 0xFF) && ~(value & 0x700)))
> >> > +               rounding = 1;
> >>
> >> Hmm. I don't think ~(value & 0x700) will ever yield FALSE... What am I missing?
> >
> > So, 0x700 is the topmost 3 bits sets (111 0000 0000) which different
> > configuration corresponds to:
> >
> >  001 0000 0000 =>  256
> >  010 0000 0000 =>  512
> >  011 0000 0000 =>  768
> >  100 0000 0000 => 1024
> >
> > Thus, if 0x700 matches then we have one of these values in input and
> > for these cases we have to add a unit to the percentage value.
> >
> > For the case (value == 0) we translate it into 0% thanks to the check
> > on (value & 0xFF) to ensure rounding = 0.
> >
> 
> I think just (value & 0xFF) is enough to get you the right behavior.
> ~(value & 0x700) is not needed, it's effectively a NoOp which always
> yields TRUE. For any *value* (value & 0x700) == 0x...00 and ~(value &
> 0x700) == 0x...FF == TRUE.

And you are actually right! ;)

> > Here is a small python snippet I've used to check the conversion of
> > all the possible percentage values:
> >
> > ---8<---
> > values = range(0, 101)
> > for pct in xrange(0, 101):
> >         util = int((1024 * pct) / 100)
> >         rounding = 1
> >         if not ((util & 0xFF) and ~(util & 0x700)):

... it works also by patching the line above!


> >             print "Fixing util_to_perc({:3d} => {:4d})".format(pct, util)
> >             rounding = 0
> >         pct2 = (rounding + ((100 * util) / 1024))
> >         if pct2 in values:
> >                 values.remove(pct2)
> >         if pct != pct2:
> >             print "Convertion failed for: {:3d} => {:4d} => {:3d}".format(pct, util, pct2)
> > if values:
> >     print "ERROR: not all percentage values converted"
> > ---8<---

Good catch, thanks!

-- 
#include <best/regards.h>

Patrick Bellasi
