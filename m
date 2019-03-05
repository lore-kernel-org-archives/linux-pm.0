From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Date: Tue, 5 Mar 2019 09:40:45 +0100
Message-ID: <CAJZ5v0gFmzsEZ=KC=6HVn4tVcBaTJri2iw6UXwAdEbRbrBx53A@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
 <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
 <f214b0d82fce14c374aa6b548742c999513d9046.camel@linux.intel.com>
 <CAJZ5v0huRALvfFBeo067dNMyUJn+Oyp8eFR3JRR+C9g7QhaekA@mail.gmail.com>
 <47ce61b9df7701e047ef6f59afd54c854db8a538.camel@linux.intel.com>
 <CAJZ5v0iCVhj-HmToGnSBuYE99LMn0BZpB-Ax48Aqh9hVc1+qwQ@mail.gmail.com>
 <9099672e17ea9fc7711b34e92ce5a016afb43a0c.camel@linux.intel.com>
 <CAJZ5v0jzRyz4gZFwJ36feppeEMEzOPJ5Y8weV3pz=+S5ijnEVw@mail.gmail.com> <edab7c9f77e682c701c58a02e7b6af70a57abf25.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <edab7c9f77e682c701c58a02e7b6af70a57abf25.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 5, 2019 at 12:04 AM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Mon, 2019-03-04 at 22:57 +0100, Rafael J. Wysocki wrote:
> > On Mon, Mar 4, 2019 at 7:06 PM Srinivas Pandruvada
> > <srinivas.pandruvada@linux.intel.com> wrote:
> > >
> > > [...]
> > > > > There are other methods like PL1 budget limit for such cases.
> > > > > FW
> > > > > can
> > > > > just change the config TDP level.
> > > >
> > > > OK, but that would be done without notification I suppose?
> > >
> > > There is a notification via processor PCI device (B0D4). This is
> > > passed
> > > to user space to change the power limits. The new element is called
> > > PPCC and it is exposed via sysfs.
> >
> > What do you mean by "new element" and how exactly is it exposed?
>
> This is part of DPTF processor ACPI object (INT3401 or B0D4). They are
> exposed in sysfs
> E.g, /sys/bus/platform/devices/INT3401:00/power_limits/
>
> There is a thermal uevent sent when they change. Both dptf daemon and
> thermald listen and use to set rapl power-constraints including step
> sizes for control. Someone can write a udev rule to do the same.

But the measure at hand here is a power one, not a thermal one AFAICS.

> > > Disabling turbo is not very interesting as there can be more turbo
> > > than
> > > non turbo. So you loose lots of performance. So instead you can
> > > control
> > > power in turbo region to give you more control. _PPC is even less
> > > interesting as you can't control uncore power.
> >
> > I guess that designers should know about that.  The kernel is on the
> > receiving end here. :-)
>
> I think they know. Hence you don't see this issue of enable/disable of
> turbo by firmware quite often. This laptop here I guess released in
> beginning of 2014 with Haswell.

In this particular case, the battery is probably to weak to sustain
the currents associated with using high turbo P-states, so turbo needs
to be disabled altogether in order to avoid using turbo P-states at
all.

I guess this still would be the case on a contemporary system with a
sufficiently small battery.

> > > >
> [...]
>
> >
> > I guess that you are talking about intel_pstate_update_max_freq()
> > which acquires policy->rwsem.  If so, what exactly is the problem
> > with
> > it?
> I was suggesting to use an API/define in cpufreq.h which does operation
> on policy->rwsem for better abstraction. This is the first time it was
> used outside core cpufreq.c. As more places it will be used in future,
> common function will help debug, if in some path there is a bug in
> aquire/release of semaphore. But you can ignore this.

Well, I guess I could introduce something like
cpufreq_cpu_acquire/release() that will lock/unlock policy->rwsem in
addition to getting the policy.  That sequence is used in a couple of
places already.
