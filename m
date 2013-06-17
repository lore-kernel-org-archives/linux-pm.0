From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH v3 1/3] cpufreq: Add boost frequency support in core
Date: Mon, 17 Jun 2013 11:58:09 +0200
Message-ID: <20130617115809.5206c42c@amdc308.digital.local>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371195540-2991-1-git-send-email-l.majewski@samsung.com>
 <1371195540-2991-2-git-send-email-l.majewski@samsung.com>
 <CAKohpokQAsuAqWi7rNx9RaFz8KVRNXVkBD22KC5_Qh05k66qqA@mail.gmail.com>
 <20130617091549.398b865f@amdc308.digital.local>
 <CAKohpo=nfuqwCoQJRczmNRNXCOTL5FSJQEzjKpVdXU+wu-KJ1g@mail.gmail.com>
 <20130617110811.1e1805d2@amdc308.digital.local>
 <CAKohpo=oy3SQXgvNvOydggZ5NZu9yyVtKrdFQjNOGVmzhSaQUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <CAKohpo=oy3SQXgvNvOydggZ5NZu9yyVtKrdFQjNOGVmzhSaQUw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocky" <rjw@sisk.pl>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 17 Jun 2013 14:48:51 +0530, Viresh Kumar wrote:
> On 17 June 2013 14:38, Lukasz Majewski <l.majewski@samsung.com> wrote:
> > On Mon, 17 Jun 2013 09:43:27 +0200, Viresh Kumar wrote:
> 
> >> Many cpus share same policy structure and so iterating over all of
> >> them isn't a very good idea. Either keep a mask of cpus already
> >> iterated, copy policy->cpus to it on each iteration. If a cpu is
> >> already done skip loop for it.
> >
> > This is the situation, which I wanted to avoid. Policy has the
> > policy->cpus mask already implemented, but we don't know how/where
> > to hook to them (one solution would be to start from cpu0, but for
> > some reason I'm reluctant to do it in this way).
> 
> We could have started from any cpu. Result and performance would have
> been same.

Yes. But I don't want to hardcode anything. Especially starting CPU
number.

> 
> >> OR keep a list of policies. I would prefer the later (do it in a
> >> separate patch), as this can be used later too.
> >
> > I will declare a boost_policy list at cpufreq.c. Then I will add
> > policy to it, when cpufreq_add_dev() is called.
> 
> This list doesn't have anything to do with boost. Its just a list of
> all policies.

Ok, I see.
> 
> >> >> Again, I couldn't see how boost freqs are getting used? You have
> >> >> probably made them part of normal freq range here and so they
> >> >> might be used during normal operations. But we wanted it to be
> >> >> used only when we have few cpus on... etc.. Where is that logic?
> >> >
> >> > The logic is as follow:
> >> > - cpufreq_driver exports .attr field. When driver supports boost
> >> > then two attributes are exported (even when boost is not enabled,
> >> > but supported):
> >> >         - scaling_available_frequencies (only normal frequencies
> >> > - this attribute is unchanged)
> >> >         - scaling_boost_frequencies - list possible boost
> >> > frequencies.
> >> >
> >> > When boost is not supported - then only
> >> > scaling_available_frequencies is exported (as it is done now).
> >>
> >> You are missing the whole point behind keeping this patchset. Its
> >> not about how to expose boost freqs to sysfs (that's what you are
> >> talking about) but to use these frequencies on the fly.
> >
> > Two separate things:
> >
> > 1. I think, that scaling_available_frequencies [*] attribute has to
> >    stay unchanged (this is how userspace sees the API). Linus would
> >    we very unhappy :-) if we had changed public API.
> 
> I never asked to modify it. :)

:-)

> 
> >    x86 guys, please correct me, but I think that [*] will be not
> >    changed (expanded) when Intel's HW boost is enabled at
> > acpi-cpufreq.c code.
> >
> >    The scaling_boost_frequencies is only visible when driver (and
> >    probably soc maintainer) is ready to handle boosting. It shows
> > over clocked frequencies.
> 
> Correct.

Ok.

> 
> > 2. How we would control boost?
> >    - To enable this you must mark IDs for some freqs as
> >      CPUFREQ_BOOST_FREQ.
> >    - The cpufreq_boost.boost_supported flag needs to be true (set at
> >      cpufreq driver code)
> >    - One needs to enable boosting by sysfs or call
> >      cpufreq_boost_trigger_state(1); The latter will not work when
> >      cpufreq_driver->boost_supported is not set.
> >
> > I assume that when somebody takes those three above steps, then he
> > is aware that boost is working on his machine.
> 
> All good until now.

Ok.

> 
> > How one can control the boost? I'm now (on my setup) using thermal
> > subsystem. I set proper trip points and when one of them is met,
> > then boost is disabled. Moreover the thermal governor (stepwise)
> > also reduces frequency.
> >
> > It works stable with v3.10 (with 3.8 there were some bugs - now they
> > are fixed).
> >
> >
> > The core acpi-cpufreq.c code hadn't been changed by me, so I assume
> > that it will work as before.
> 
> That should adapt your patch in your patchset.
> 
> >> Some part of kernel
> >> code would be setting these frequencies in real hardware. Who will
> >> set these frequencies?
> >
> > Those freqs are set by ->target() callback (when allowed)

The ->target() [*] is called when governor calls it. I didn't change any
of this behaviour. 

> 
> From sysfs?? I thought we are going to have some automatic control
> of this stuff from inside kernel. 

>From sysfs I just enable the boost. I do not order from userpace the
cpufreq to run with a particular (boosted) frequency.

When I enable boost - I ask (politely) the cpufreq core to reevaluate
policies and when applicable increase policy->max.

Then governor can use this new frequencies for normal operation.

> Userspace can't control when to run
> on boost freqs.

The control, if boost frequency shall be used or not, is done by
governor when load is appropriate.

> 
> >> On what basis? How do we ensure we don't
> >> burn your chip?
> >
> > Thermal subsystem is a good example here. Another may be a
> > governor, or even scheduler.
> 
> So, you are enabling boost from sysfs when your thermal framework
> says, you can do it?

No. I'm enabling boost from sysfs (modify policies). This does not mean
that boost frequency is run.

If governor decides, that it shall use boost freq - then it will use
it. 
When during heavy workload (and running boost freq), the trip point for
thermal is being passed, the boost shall be disabled. 
Moreover stepwise will also reduce frequency with which SoC runs.

> 
> That's not going to work. There should be something inside kernel to
> take care of this stuff. Otherwise a user may switch on boost
> accidentally and may burn his chip.

User can by mistake enable boost. But then she/he needs to load SoC to
the maximum (to enable policy->max). After heating up the SoC - the
thermal goes in and disables boost and reduces frequency to cool down
the device.

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
