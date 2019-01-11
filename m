From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)
Date: Fri, 11 Jan 2019 12:08:32 +0100
Message-ID: <2260944.bWjCqvLuxn@aspire.rjw.lan>
References: <20181129174700.16585-1-ulf.hansson@linaro.org> <CAPDyKFpV0uQhZnJhSg79RxmCq+0PFUeaXCgmBgRU5aNF8WNoDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpV0uQhZnJhSg79RxmCq+0PFUeaXCgmBgRU5aNF8WNoDw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, December 17, 2018 5:12:54 PM CET Ulf Hansson wrote:
> Rafael, Sudeep, Lorenzo, Mark,
> 
> On Thu, 29 Nov 2018 at 18:47, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Over the years this series have been iterated and discussed at various Linux
> > conferences and LKML. In this new v10, a quite significant amount of changes
> > have been made to address comments from v8 and v9. A summary is available
> > below, although let's start with a brand new clarification of the motivation
> > behind this series.
> >
> > For ARM64/ARM based platforms CPUs are often arranged in a hierarchical manner.
> > From a CPU idle state perspective, this means some states may be shared among a
> > group of CPUs (aka CPU cluster).
> >
> > To deal with idle management of a group of CPUs, sometimes the kernel needs to
> > be involved to manage the last-man standing algorithm, simply because it can't
> > rely solely on power management FWs to deal with this. Depending on the
> > platform, of course.
> >
> > There are a couple of typical scenarios for when the kernel needs to be in
> > control, dealing with synchronization of when the last CPU in a cluster is about
> > to enter a deep idle state.
> >
> > 1)
> > The kernel needs to carry out so called last-man activities before the
> > CPU cluster can enter a deep idle state. This may for example involve to
> > configure external logics for wakeups, as the GIC may no longer be functional
> > once a deep cluster idle state have been entered. Likewise, these operations
> > may need to be restored, when the first CPU wakes up.
> >
> > 2)
> > Other more generic I/O devices, such as an MMC controller for example, may be a
> > part of the same power domain as the CPU cluster, due to a shared power-rail.
> > For these scenarios, when the MMC controller is in use dealing with an MMC
> > request, a deeper idle state of the CPU cluster may needs to be temporarily
> > disabled. This is needed to retain the MMC controller in a functional state,
> > else it may loose its register-context in the middle of serving a request.
> >
> > In this series, we are extending the generic PM domain (aka genpd) to be used
> > for also CPU devices. Hence the goal is to re-use much of its current code to
> > help us manage the last-man standing synchronization. Moreover, as we already
> > use genpd to model power domains for generic I/O devices, both 1) and 2) can be
> > address with its help.
> >
> > Moreover, to address these problems for ARM64 DT based platforms, we are
> > deploying support for genpd and runtime PM to the PSCI FW driver - and finally
> > we make some updates to two ARM64 DTBs, as to deploy the new PSCI CPU topology
> > layout.
> >
> > The series has been tested on the QCOM 410c dragonboard and the Hisilicon Hikey
> > board. You may also find the code at:
> >
> > git.linaro.org/people/ulf.hansson/linux-pm.git next
> 
> It's soon been three weeks since I posted this and I would really
> appreciate some feedback.
> 
> Rafael, I need your feedback on patch 1->4.

Sorry for the delay, I've replied to the patches.

The bottom line is that the mechanism introduced in patch 3 and used
in patch 4 doesn't look particularly clean to me.

Cheers,
Rafael
