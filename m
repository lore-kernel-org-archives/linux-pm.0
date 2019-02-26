From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Date: Tue, 26 Feb 2019 22:52:35 +0100
Message-ID: <CAJZ5v0gHZ5OiMGxpagp5X-LfShc_3AX=fgBPxf=PQ9p4cMQV8Q@mail.gmail.com>
References: <20190226145415.19411-1-ulf.hansson@linaro.org>
 <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com> <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 26, 2019 at 10:31 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v11:
> > >  - This version contains only the infrastructure changes that is needed for
> > > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > > post them separately. Still, to provide completeness, I have published a branch
> > > containing everything to a git tree [1], feel free to have a look and test.
> > >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > > which has been replaced by a couple of new patches, whom reworks the existing
> > > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > > instead of the duration.
> > >  - More changelogs are available per patch.
> >
> > NAK for patches [4-6/8].
> >
> > The code as is specifically avoids calling ktime_get() from the
> > governors as that can be quite expensive, so these patches potentially
> > make things worse.
>
> Yeah, good point! What do you think about folding in a patch into the
> series, like below, and then let the cpuidle governors use it?

It is not objectionable as it stands, but that also depends on what
the new function is used for.

In particular, I don't really think that the menu and teo governors
need to call it at all.

> One questions about when CONFIG_NO_HZ_COMMON is unset for the below
> suggested code, does it make sense to "return -1" for that case, or
> should I return ktime_get()? Does it matter?

Again, it may or may not matter depending on what the caller is going
to do with the value returned by it.
