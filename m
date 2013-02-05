From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2] cpufreq: cpufreq_driver_lock is hot on large systems
Date: Tue, 05 Feb 2013 11:03:13 +0100
Message-ID: <3480441.gCEh0J5edK@vostro.rjw.lan>
References: <1360017913-25667-1-git-send-email-nzimmer@sgi.com> <2765418.Ft0GYkgNgL@vostro.rjw.lan> <CAOh2x=n+ASeLpGHexxDvPGrN6ia+bLnNUNCb-covGDoABVk_wQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAOh2x=n+ASeLpGHexxDvPGrN6ia+bLnNUNCb-covGDoABVk_wQ@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nathan Zimmer <nzimmer@sgi.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 05, 2013 01:58:20 PM Viresh Kumar wrote:
> On Tue, Feb 5, 2013 at 6:37 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Monday, February 04, 2013 04:45:11 PM Nathan Zimmer wrote:
> >> I am noticing the cpufreq_driver_lock is quite hot.
> >> On an idle 512 system perf shows me most of the system time is spent on this
> >> lock.  This is quite signifigant as top shows 5% of time in system time.
> >> My solution was to first convert the lock to a rwlock and then to the rcu.
> >>
> >>
> >> Nathan Zimmer (2):
> >>   cpufreq: Convert the cpufreq_driver_lock to a rwlock
> >>   cpufreq: Convert the cpufreq_driver_lock to use the rcu
> >>
> >>  drivers/cpufreq/cpufreq.c | 139 ++++++++++++++++++++++++++--------------------
> >>  1 file changed, 79 insertions(+), 60 deletions(-)
> >
> > I like these changes.
> >
> > Viresh, anyone, any comments?
> 
> Hi Nathan/Rafael,
> 
> Even i liked the basic idea behind the patchset, but didn't like the way it
> is divided into patches. For me, it is highly discouraged to undo something
> that you added in the same patchset. And you did exactly the same thing.
> 
> Patch 2 is revert of 1 + rcu stuff.
> 
> So, i would expect a single patch, i.e. merge of both patches + rebased
> on latest stuff.

I actually don't agree with that, becuase the Nathan's apprach shows the
reasoning that leads to the RCU introduction quite clearly.  So if you
don't have technical problems with the patchset, I'm going to take it as is.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
