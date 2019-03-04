From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Date: Mon, 4 Mar 2019 22:57:40 +0100
Message-ID: <CAJZ5v0jzRyz4gZFwJ36feppeEMEzOPJ5Y8weV3pz=+S5ijnEVw@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
 <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
 <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
 <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com>
 <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
 <CAJZ5v0iCVhj-HmToGnSBuYE99LMn0BZpB-Ax48Aqh9hVc1+qwQ@mail.gmail.com> <9099672e17ea9fc7711b34e92ce5a016afb43a0c.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9099672e17ea9fc7711b34e92ce5a016afb43a0c.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 4, 2019 at 7:06 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> [...]
> > > There are other methods like PL1 budget limit for such cases. FW
> > > can
> > > just change the config TDP level.
> >
> > OK, but that would be done without notification I suppose?
>
> There is a notification via processor PCI device (B0D4). This is passed
> to user space to change the power limits. The new element is called
> PPCC and it is exposed via sysfs.

What do you mean by "new element" and how exactly is it exposed?

> Disabling turbo is not very interesting as there can be more turbo than
> non turbo. So you loose lots of performance. So instead you can control
> power in turbo region to give you more control. _PPC is even less
> interesting as you can't control uncore power.

I guess that designers should know about that.  The kernel is on the
receiving end here. :-)

> >
> > > > That's fair enough, but the point is that the driver doesn'dev_t
> > > > do
> > > > the right thing even if the platform does send a _PPC
> > > > notification.
> > >
> > > _PPC notification is to indicate levels in _PSS not to
> > > disable/enable
> > > turbo via IA32_MISC_*.
> >
> > I was not talking about notifications, but about what the driver does
> > when MSR_IA32_MISC_ENABLE_TURBO_DISABLE is set or unset by FW on the
> > fly: this only really works if the change is from unset to set,
> > because the range of frequencies to use is restricted then, even
> > though user-visible policy limits are not updated.  However, if the
> > change is from set to unset, the update of policy limits is actually
> > necessary for the change to really take effect (otherwise the user
> > policy max prevents turbo frequencies from being requested).  HWP
> > seems to be affected too, for that matter, because the upper limit in
> > the MSR is not updated too then AFAICS.
> >
> > > The platform could have just set _PPC to 1 or to TAR-1. Here _PPC
> > > is sent for somthing more than just changing _PSS max
> > > level. Do we have bug in if _PPC just changes performance level?
> >
> > I think that we just need to live with the fact that _PPC may be
> > triggered for something more than changing _PSS max.
>
> I understand the reason why you are doing the change. I investigated
> this bugzilla before. I was thinking can udev rules should be enough to
> address this issue. But it was not a requirement.
>
> The change itself is fine. Except may be hide the policy->rwsem in some
> header file instead of directly exposing to clients to use.

I'm not sure what you mean.

I guess that you are talking about intel_pstate_update_max_freq()
which acquires policy->rwsem.  If so, what exactly is the problem with
it?
