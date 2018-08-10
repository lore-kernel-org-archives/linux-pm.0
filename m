From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 03/14] PM: Introduce an Energy Model management framework
Date: Fri, 10 Aug 2018 13:13:22 +0200
Message-ID: <8482157.ZqyaK8WryI@aspire.rjw.lan>
References: <20180724122521.22109-1-quentin.perret@arm.com> <2467271.WAtZ4Z8dKT@aspire.rjw.lan> <20180810091216.nieosjtu7l33z4ap@queper01-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180810091216.nieosjtu7l33z4ap@queper01-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <quentin.perret@arm.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joel@joelfernandes.org, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, juri.lelli@redhat.com, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net, javi.merino@kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, August 10, 2018 11:12:18 AM CEST Quentin Perret wrote:
> On Friday 10 Aug 2018 at 10:41:56 (+0200), Rafael J. Wysocki wrote:
> > On Friday, August 10, 2018 10:15:39 AM CEST Quentin Perret wrote:

[cut]

> Agreed. EAS and IPA don't care about the absolute real power values, all
> they care about is relative correctness. But what I really want to avoid
> is having IPA getting the power of the GPUs in mW, and the power of CPUs
> in an abstract scale without unit. That _will_ create problems eventually
> IMO, because the behaviour is undefined. Specifying a unit everywhere is
> an easy way to enforce a consistent design across sub-systems, that's
> all.

OK

> > > What I am currently proposing is to keep the unit (mW) in the EM
> > > framework so that migrating IPA to using it can be done in a (relatively)
> > > painless way. On a system where drivers  don't know the exact wattage,
> > > then they should just 'lie' to the EM framework, but it's their job to
> > > lie coherently to all subsystems and keep things consistent, because all
> > > subsystems have specified power in comparable units.
> > 
> > Alternatively, there could be a translation layer between EM and IPA.
> 
> Hmm, interesting... What do you have in mind exactly ? What would you
> put in that layer ?

Something able to say how the numbers used by EM and IPA are related. :-)

Do you think that IPA and EM will always need to use the same set of data for
the CPU?

> > From my experience, if you want people to come up with some numbers,
> > they will just choose them to game the system this way or another
> > unless those numbers can be measured directly or are clearly documented.
> > 
> > And if that happens and then you want to make any significant changes,
> > you'll need to deal with "regressions" occuring because someone chose
> > the numbers to make the system behave in a specific way and your changes
> > break that.
> > 
> > As a rule, I rather avoid requesting unknown numbers from people. :-)
> > 
> > > Another solution to solve this problem could be to extend the EM
> > > framework introduced by this patch and make it manage the EM of any
> > > device, not just CPUs. Then we could just specify that all power costs
> > > must be in the same scale, regardless of the actual unit, and register
> > > the EM of CPUs, GPUs, ...
> > > However, I was hoping that this patch as-is was enough for a first step,
> > > and that this extension of the framework could be done in a second step ?
> > > Thoughts ?
> > > 
> > > In any case, if we decide to keep the mW unit for now, I should at least
> > > explain clearly why in the commit message.
> > 
> > Right.
> > 
> > Actually, the unit is as good as any other, but you need to bear in mind that
> > the numbers provided may not be realistic.
> 
> As long as they're all correct in a relative way, that's fine by me :-)

OK

Thanks,
Rafael
