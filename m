From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
Date: Fri, 24 Aug 2018 11:38:28 +0100
Message-ID: <20180824103828.GA11491@red-moon>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-8-ulf.hansson@linaro.org>
 <3574880.GjmnMm1lMq@aspire.rjw.lan>
 <10360149.m4MlxDWZY5@aspire.rjw.lan>
 <CAPDyKFonHYSq32WxvB1x5PXissXZvraqazgU_ZyLR=tsyD9vAA@mail.gmail.com>
 <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
 <20180809153925.GA20329@red-moon>
 <CAPDyKFp=AuqEPHKYgi-+DAhejQZSHixmtLORj_Rkn3m8fUoqJw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFp=AuqEPHKYgi-+DAhejQZSHixmtLORj_Rkn3m8fUoqJw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <fweisb>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 24, 2018 at 11:26:19AM +0200, Ulf Hansson wrote:

[...]

> > That's a good question and it maybe gives a path towards a solution.
> >
> > AFAICS the genPD governor only selects the idle state parameter that
> > determines the idle state at, say, GenPD cpumask level it does not touch
> > the CPUidle decision, that works on a subset of idle states (at cpu
> > level).
> >
> > That's my understanding, which can be wrong so please correct me
> > if that's the case because that's a bit confusing.
> >
> > Let's imagine that we flattened out the list of idle states and feed
> > CPUidle with it (all of them - cpu, cluster, package, system - as it is
> > in the mainline _now_). Then the GenPD governor can run-through the
> > CPUidle selection and _demote_ the idle state if necessary since it
> > understands that some CPUs in the GenPD will wake up shortly and break
> > the target residency hyphothesis the CPUidle governor is expecting.
> >
> > The whole idea about this series is improving CPUidle decision when
> > the target idle state is _shared_ among groups of cpus (again, please
> > do correct me if I am wrong).
> 
> Absolutely, this is one of the main reason for the series!
> 
> >
> > It is obvious that a GenPD governor must only demote - never promote a
> > CPU idle state selection given that hierarchy implies more power
> > savings and higher target residencies required.
> 
> Absolutely. I apologize if I have been using the word "promote"
> wrongly, I realize it may be a bit confusing.
> 
> >
> > This whole series would become more generic and won't depend on
> > PSCI OSI at all - actually that would become a hierarchical
> > CPUidle governor.
> 
> Well, to me we need a first user of the new infrastructure code in
> genpd and PSCI is probably the easiest one to start with. An option
> would be to start with an old ARM32 platform, but it seems a bit silly
> to me.

If the code can be structured as described above as a hierarchical
(possibly optional through a Kconfig entry or sysfs tuning) idle
decision you can apply it to _any_ PSCI based platform out there,
provided that the new governor improves power savings.

> In regards to OS-initiated mode vs platform coordinated mode, let's
> discuss that in details in the other email thread instead.

I think that's crystal clear by now that IMHO PSCI OS-initiated mode is
a red-herring, it has nothing to do with this series, it is there just
because QC firmware does not support PSCI platform coordinated suspend
mode.

You can apply the concept in this series to _any_ arch provided
the power domains representation is correct (and again, I would sound
like a broken record but the series must improve power savings over
vanilla CPUidle menu governor).

> > I still think that PSCI firmware and most certainly mwait() play the
> > role the GenPD governor does since they can detect in FW/HW whether
> > that's worthwhile to switch off a domain, the information is obviously
> > there and the kernel would just add latency to the idle path in that
> > case but let's gloss over this for the sake of this discussion.
> 
> Yep, let's discuss that separately.
> 
> That said, can I interpret your comments on the series up until this
> change, that you seems rather happy with where the series is going?

It is something we have been discussing with Daniel since generic idle
was merged for Arm a long while back. I have nothing against describing
idle states with power domains but it must improve idle decisions
against the mainline. As I said before, runtime PM can also be used
to get rid of CPU PM notifiers (because with power domains we KNOW
what devices eg PMU are switched off on idle entry, we do not guess
any longer; replacing CPU PM notifiers is challenging and can be
tackled - if required - in a different series).

Bottom line (talk is cheap, I know and apologise about that): this
series (up until this change) adds complexity to the idle path and lots
of code; if its usage is made optional and can be switched on on systems
where it saves power that's fine by me as long as we keep PSCI
OS-initiated idle states out of the equation, that's an orthogonal
discussion as, I hope, I managed to convey.

Thanks,
Lorenzo
