From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Date: Mon, 4 Mar 2019 10:41:22 +0100
Message-ID: <CAJZ5v0iCVhj-HmToGnSBuYE99LMn0BZpB-Ax48Aqh9hVc1+qwQ@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
 <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
 <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
 <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com> <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 4, 2019 at 5:06 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Sun, 2019-03-03 at 22:51 +0100, Rafael J. Wysocki wrote:
> > On Sun, Mar 3, 2019 at 10:20 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > On Sun, 2019-03-03 at 18:03 +0100, Rafael J. Wysocki wrote:
> > > > On Fri, Mar 1, 2019 at 6:39 PM Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > > >
> > > > > On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > > > > > Hi All,
> > > > > >
> > > > > > This is how I would fix the issue reported in BZ 200759 (see
> > > > > > thisdev
> > > > > > patch series
> > > > > > from Yu too:
> > > > > > https://marc.info/?l=linux-pm&m=155137672924029&w=2)
> > > > > > .
> > > > > >
> > > > > > Patch [1/2] causes intel_pstate to update all policies if it
> > > > > > gets
> > > > > > a
> > > > > > _PPC change
> > > > > > notification and sees a global turbo disable/enable change.
> > > > > >
> > > > > > Patch [2/2] makes it update cpuinfo.max_freq for all policies
> > > > > > in
> > > > > > those cases.
> > > > > >
> > > > > > The patches here have not been tested yet, so testing would
> > > > > > be
> > > > > > much
> > > > > > appreciated.
> > > > > >
> > > > > > Of course, comments are welcome too!
> > > > >
> > > > > This is the only platform, someone reported such issue.
> > > >
> > > > I don't think this matters.
> > > >
> > > > First, it doesn't mean that no other problems have this problem.
> > > >
> > > > Second, the current handling of
> > > > MSR_IA32_MISC_ENABLE_TURBO_DISABLE
> > > > changes in intel_pstate is not sufficient if the changes is from
> > > > set
> > > > to unset anyway.
> > >
> > > Any platform with HWP, you can't even notify of this change. So any
> > > platform beyond SKL is not useful.
> >
> > Do you mean that HWP platforms don't supply _PPS (as a rule) and so
> > they don't send _PPC notifications?  Is there anything they do
> > instead
> > of it?
>
> There are other methods like PL1 budget limit for such cases. FW can
> just change the config TDP level.

OK, but that would be done without notification I suppose?

> > That's fair enough, but the point is that the driver doesn'dev_t do
> > the right thing even if the platform does send a _PPC notification.
>
> _PPC notification is to indicate levels in _PSS not to disable/enable
> turbo via IA32_MISC_*.

I was not talking about notifications, but about what the driver does
when MSR_IA32_MISC_ENABLE_TURBO_DISABLE is set or unset by FW on the
fly: this only really works if the change is from unset to set,
because the range of frequencies to use is restricted then, even
though user-visible policy limits are not updated.  However, if the
change is from set to unset, the update of policy limits is actually
necessary for the change to really take effect (otherwise the user
policy max prevents turbo frequencies from being requested).  HWP
seems to be affected too, for that matter, because the upper limit in
the MSR is not updated too then AFAICS.

> The platform could have just set _PPC to 1 or to TAR-1. Here _PPC is sent for somthing more than just changing _PSS max
> level. Do we have bug in if _PPC just changes performance level?

I think that we just need to live with the fact that _PPC may be
triggered for something more than changing _PSS max.

Note that the driver could trigger policy updates on
MSR_IA32_MISC_ENABLE_TURBO_DISABLE changes even without _PPC
notifications, but that would require more intrusive changes, because
work items cannot be queued up from scheduler context.  It would need
to use irq_work for that and with some extra synchronization etc, and
for the time being it looks like we can piggy back on the _PPC change
notification mechanism.
