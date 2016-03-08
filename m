From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering utilization
 update callbacks
Date: Tue, 08 Mar 2016 11:24:00 -0800
Message-ID: <20160308192400.4103.71868@quark.deferred.io>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
 <CAJZ5v0gs3bddvskseh58q+0d+KqXYt=4SYGuiR3vdhdOyhoKmA@mail.gmail.com>
 <20160223110118.GJ27380@e106622-lin> <5947930.P2W8Baqyau@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5947930.P2W8Baqyau@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

Quoting Rafael J. Wysocki (2016-02-23 18:01:06)
> On Tuesday, February 23, 2016 11:01:18 AM Juri Lelli wrote:
> > On 22/02/16 22:26, Rafael J. Wysocki wrote:
> > > On Mon, Feb 22, 2016 at 10:32 AM, Juri Lelli <juri.lelli@arm.com> wrote:
> > > > On 19/02/16 23:14, Rafael J. Wysocki wrote:
> > > >> On Friday, February 19, 2016 08:09:17 AM Juri Lelli wrote:
> > > >> > Hi Rafael,
> > > >> >
> > > >> > On 18/02/16 21:22, Rafael J. Wysocki wrote:
> > > >> > > On Mon, Feb 15, 2016 at 10:47 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > >> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >> > > >
> > > 
> > > [cut]
> > > 
> > > >> That said, if the concern is that there are plans to change the way the
> > > >> scheduler computes the utilization numbers and that may become difficult to
> > > >> carry out if cpufreq starts to depend on them in their current form, then I
> > > >> may agree that it is valid, but I'm not aware of those plans ATM.
> > > >>
> > > >
> > > > No, I don't think there's any substantial discussion going on about the
> > > > utilization numbers.
> > > 
> > > OK, so the statement below applies.
> > > 
> > > >> However, if the numbers are going to stay what they are, I don't see why
> > > >> passing them to cpufreq may possibly become problematic at any point.
> > > >
> > > > My concern was mostly on the fact that there is already another RFC
> > > > under discussion that uses the same numbers and has different hooks
> > > > placed in scheduler code (Steve's sched-freq); so, additional hooks
> > > > might generate confusion, IMHO.
> > > 
> > > So this is about the hooks rather than about their arguments after
> > > all, isn't it?
> > > 
> > > I fail to see why it is better to drop the arguments and leave the hooks, then.
> > > 
> > 
> > It's about where we place such hooks and what arguments they have.
> > Without the schedutil governor as a consumer the current position makes
> > sense, but some of the arguments are not used. With schedutil both
> > position and arguments make sense, but a different implementation
> > (sched-freq) might have different needs w.r.t. position and arguments.
> 
> And that's fine.  If the current position and/or arguments are not suitable,
> they'll need to be changed.  It's not like things introduced today are set
> in stone forever.
> 
> Peter has already shown how they may be changed to make everyone happy,
> so I don't really see what the fuss is about.

I see this patch in linux-next now. Did it ever get Peter's or Ingo's
Ack?

Also it seems weird to me that this patch touching sched code is going
through the pm tree.

When it comes times to experiment more with the interfaces and make the
"future changes" that everyone keeps talking about, who is the
maintainer? Who has the last word?

Regards,
Mike

> 
> > > OTOH, I see reasons for keeping the arguments along with the hooks,
> > > but let me address that in my next reply.
> > > 
> > > Now, if the call sites of the hooks change in the future, it won't be
> > > a problem for me as long as the new hooks are invoked on a regular
> > > basis or, if they aren't, as long as I can figure out from the
> > > arguments they pass that I should not expect an update any time soon.
> > > 
> > 
> > OK.
> > 
> > > If the arguments change, it won't be a problem either as long as they
> > > are sufficient to be inserted into the frequency selection formula
> > > used by the schedutil governor I posted and produce sensible
> > > frequencies for the CPU.
> > > 
> > 
> > Right, I guess this applies to any kind of governor.
> 
> Sure, but this particular formula is very simple.  It just assumes that
> util <= max so dividing the former by the latter will always yield a number
> between 0 and 1.  [And the interpretation of util > max is totally arbitrary
> today and regarded as temporary anyway, so that's just irrelevant.]
> 
> Thanks,
> Rafael
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
