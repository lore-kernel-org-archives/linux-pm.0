From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Date: Wed, 16 Jan 2019 10:10:08 +0100
Message-ID: <CAPDyKFp-JB85TZOs+oso0iidaAsm1A=UDrg=gv+QZ4VJ9gW=fA@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org> <20190103120612.GC23511@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103120612.GC23511@e107155-lin>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Jan 2019 at 13:06, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Thu, Nov 29, 2018 at 06:46:33PM +0100, Ulf Hansson wrote:
> > Over the years this series have been iterated and discussed at various Linux
> > conferences and LKML. In this new v10, a quite significant amount of changes
> > have been made to address comments from v8 and v9. A summary is available
> > below, although let's start with a brand new clarification of the motivation
> > behind this series.
>
> I would like to raise few points, not blockers as such but need to be
> discussed and resolved before proceeding further.
> 1. CPU Idle Retention states
>         - How will be deal with flattening (which brings back the DT bindings,
>           i.e. do we have all we need) ? Because today there are no users of
>           this binding yet. I know we all agreed and added after LPC2017 but
>           I am not convinced about flattening with only valid states.

Not exactly sure I understand what you are concerned about here. When
it comes to users of the new DT binding, I am converting two new
platforms in this series to use of it.

Note, the flattened model is still a valid option to describe the CPU
idle states after these changes. Especially when there are no last man
standing activities to manage by Linux and no shared resource that
need to prevent cluster idle states, when it's active.

>         - Will domain governor ensure not to enter deeper idles states based
>           on its sub-domain states. E.g.: when CPUs are in retention, so
>           called container/cluster domain can enter retention or below and not
>           power off states.

I have tried to point this out as a known limitation in genpd of the
current series, possibly I have failed to communicate that clearly.
Anyway, I fully agree that this needs to be addressed in a future
step.

Note that, this isn't a specific limitation to how idle states are
selected for CPUs and CPU clusters by genpd, but is rather a
limitation to any hierarchical PM domain topology managed by genpd
that has multiple idle states.

Do note, I already started hacking on this and intend to post patches
on top of this series, as these changes isn't needed for those two
ARM64 platforms I have deployed support for.

>         - Is the case of not calling cpu_pm_{enter,exit} handled now ?

It is still called, so no changes in regards to that as apart of this series.

When it comes to actually manage the "last man activities" as part of
selecting an idle state of the cluster, that is going to be addressed
on top as "optimizations".

In principle we should not need to call cpu_pm_enter|exit() in the
idle path at all, but rather only cpu_cluster_pm_enter|exit() when a
cluster idle state is selected. That should improve latency when
selecting an idle state for a CPU. However, to reach that point
additional changes are needed in various drivers, such as the gic
driver for example.

>
> 2. Now that we have SDM845 which may soon have platform co-ordinated idle
>    support in mainline, I *really* would like to see some power comparison
>    numbers(i.e. PC without cluster idle states). This has been the main theme
>    for most of the discussion on this topic for years and now we are close
>    to have some platform, we need to try.

I have quite recently been talking to Qcom folkz about this as well,
but no commitments are made.

Although I fully agree that some comparison would be great, it still
doesn't matter much, as we anyway need to support PSCI OSI mode in
Linux. Lorenzo have agreed to this as well.

>
> 3. Also, after adding such complexity, we really need a platform with an
>    option to build and upgrade firmware easily. This will help to prevent
>    this being not maintained for long without a platform to test, also
>    avoid adding lots of quirks to deal with broken firmware so that newer
>    platforms deal those issues in the firmware correctly.

I don't see how this series change anything from what we already have
today with the PSCI FW. No matter of OSI or PC mode is used, there are
complexity involved.

Although, of course I agree with you, that we should continue to try
to convince ARM vendors about moving to the public version of ATF and
avoid proprietary FW binaries as much as possible.

Kind regards
Uffe
