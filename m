From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
Date: Fri, 14 Sep 2018 13:30:37 +0100
Message-ID: <20180914123037.GA22926@e107981-ln.cambridge.arm.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
 <20180809153925.GA20329@red-moon>
 <5398488.CyAMIAYSYI@aspire.rjw.lan>
 <20180914104431.GA20567@e107981-ln.cambridge.arm.com>
 <CAJZ5v0j27p9XHsLsJ+Eg9PGh1bbF5CRNFOrVW8qvNx1Am6W-2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j27p9XHsLsJ+Eg9PGh1bbF5CRNFOrVW8qvNx1Am6W-2A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Frederic Weisbecker <fweisbec@>
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 14, 2018 at 01:34:14PM +0200, Rafael J. Wysocki wrote:

[...]

> > > So for example, if your logical CPU has an idle state A that may trigger an
> > > idle state X at the cluster level (if the other logical CPUs happen to be in
> > > the right states and so on), then the worst-case exit latency for that
> > > is the one of state X.
> >
> > I will provide an example:
> >
> > IDLE STATE A (affects CPU {0,1}): exit latency 1ms, min-residency 1.5ms
> >
> > CPU 0 is about to enter IDLE state A since its "next-event" fulfill the
> > residency requirements and exit latency constraints.
> >
> > CPU 1 is in idle state A (given that CPU 0 is ON, some of the common
> > logic shared between CPU {0,1} is still ON, but, as soon as CPU 0
> > enters idle state A CPU {0,1} can enter the "full" idle state A
> > power savings mode).
> >
> > The current CPUidle governor does not check the "next-event" for CPU 1,
> > that it may wake up in, say, 10us.
> 
> Right.
> 
> > Requesting IDLE STATE A is a waste of power (if firmware or hardware
> > does not demote it since it does peek at CPU 1 next-event and actually
> > demote CPU 0 request).
> 
> OK, I see.
> 
> That's because the state is "collaborative" so to speak.  But was't
> that supposed to be covered by the "coupled" thing?

The coupled idle states code was merged because on some early SMP
ARM platforms CPUs must enter cluster idle states orderly otherwise
the system would break; "coupled" as-in "syncronized idle state entry".

Basically coupled idle code fixed a HW bug. This series code instead
applies to all arches where an idle state may span multiple CPUs (x86
inclusive, but as I mentioned it is probably not needed since FW/HW
behind mwait is capable of detecting whether that's wortwhile to shut
down, say, a package. PSCI, whether OSI or PC mode can work the same way).

Entering an idle state spanning multiple cpus need not be synchronized
but a sort of cpumask aware governor may help optimize idle state
selection.

I hope this makes the whole point clearer.

Cheers,
Lorenzo
