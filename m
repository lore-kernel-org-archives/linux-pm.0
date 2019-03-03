From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT][PATCH 0/2] cpufreq: intel_pstate: Handle _PPC updates on
 global turbo disable/enable
Date: Sun, 3 Mar 2019 18:03:52 +0100
Message-ID: <CAJZ5v0ik6oHCXD23tURsRXRj1-C-Z=S6y+KEiRxe0zJpGrKa+Q@mail.gmail.com>
References: <9956076.F4luUDm1Dq@aspire.rjw.lan> <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fa5e3e09eb32f5197bef2a50ced952850bf70748.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen Yu <yu.c.chen@intel.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 1, 2019 at 6:39 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2019-03-01 at 13:43 +0100, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > This is how I would fix the issue reported in BZ 200759 (see this
> > patch series
> > from Yu too: https://marc.info/?l=linux-pm&m=155137672924029&w=2).
> >
> > Patch [1/2] causes intel_pstate to update all policies if it gets a
> > _PPC change
> > notification and sees a global turbo disable/enable change.
> >
> > Patch [2/2] makes it update cpuinfo.max_freq for all policies in
> > those cases.
> >
> > The patches here have not been tested yet, so testing would be much
> > appreciated.
> >
> > Of course, comments are welcome too!
>
> This is the only platform, someone reported such issue.

I don't think this matters.

First, it doesn't mean that no other problems have this problem.

Second, the current handling of MSR_IA32_MISC_ENABLE_TURBO_DISABLE
changes in intel_pstate is not sufficient if the changes is from set
to unset anyway.
