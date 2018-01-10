From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [v3 PATCH 2/3] powernv-cpufreq: Fix pstate_to_idx() to handle non-continguous pstates
Date: Wed, 10 Jan 2018 13:00:10 +0100
Message-ID: <8482639.QyQtvhC9hx@aspire.rjw.lan>
References: <1513148261-21097-1-git-send-email-ego@linux.vnet.ibm.com> <CAKTCnznuf1jwWZEqi+og8LyayfzMwGYRUXhK4+zfbSYDfexyRA@mail.gmail.com> <20180110085545.GA13666@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180110085545.GA13666@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: ego@linux.vnet.ibm.com
Cc: Balbir Singh <bsingharora@gmail.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Abhishek <huntbag@linux.vnet.ibm.com>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, January 10, 2018 9:55:45 AM CET Gautham R Shenoy wrote:
> Hi Rafael,
> 
> On Wed, Jan 03, 2018 at 11:47:58PM +1100, Balbir Singh wrote:
> > On Wed, Jan 3, 2018 at 11:07 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Monday, December 18, 2017 9:38:20 AM CET Gautham R Shenoy wrote:
> > >> Hi Balbir,
> > >>
> > >> On Sun, Dec 17, 2017 at 02:15:25PM +1100, Balbir Singh wrote:
> > >> > On Wed, Dec 13, 2017 at 5:57 PM, Gautham R. Shenoy
> > >> > <ego@linux.vnet.ibm.com> wrote:
> > >> > > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> > >> > >
> > >> > > The code in powernv-cpufreq, makes the following two assumptions which
> > >> > > are not guaranteed by the device-tree bindings:
> > >> > >
> > >> > >     1) Pstate ids are continguous: This is used in pstate_to_idx() to
> > >> > >        obtain the reverse map from a pstate to it's corresponding
> > >> > >        entry into the cpufreq frequency table.
> > >> > >
> > >> > >     2) Every Pstate should always lie between the max and the min
> > >> > >        pstates that are explicitly reported in the device tree: This
> > >> > >        is used to determine whether a pstate reported by the PMSR is
> > >> > >        out of bounds.
> > >> > >
> > >> > > Both these assumptions are unwarranted and can change on future
> > >> > > platforms.
> > >> >
> > >> > While this is a good thing, I wonder if it is worth the complexity. Pstates
> > >> > are contiguous because they define transitions in incremental value
> > >> > of change in frequency and I can't see how this can be broken in the
> > >> > future?
> > >>
> > >> In the future, we can have the OPAL firmware give us a smaller set of
> > >> pstates instead of expose every one of them. As it stands today, for
> > >> most of the workloads, we will need at best 20-30 pstates and not
> > >> beyond that.
> > >
> > > I'm not sure about the status here.
> > >
> > > Is this good to go as is or is it going to be updated?
> > >
> > 
> > I have no major objections, except some of the added complexity, but
> > Gautham makes a point that this is refactoring for the future
> 
> I have tested this across POWER8 and POWER9. The additional complexity
> introduced by the second patch is required for the future when we are
> going to reduce the number of pstates.

I have applied the series, thanks!
