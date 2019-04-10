From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v13 0/4] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Date: Wed, 10 Apr 2019 10:25:42 +0200
Message-ID: <CAPDyKFpjpLaYSqj23YV_HdNG9Tp485Omn4pVQQH_Cj8_k_E8WQ@mail.gmail.com>
References: <20190327143548.25305-1-ulf.hansson@linaro.org>
 <CAPDyKFqc9OeaCGrSu7toMcgZesN2xBqqWNQfqUt+4+FvQ4kmDw@mail.gmail.com> <CAJZ5v0g57V=tHdTJ2THLfTH_CbHQyS8xpNaeZUojPiHp=+gS4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0g57V=tHdTJ2THLfTH_CbHQyS8xpNaeZUojPiHp=+gS4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Linux PM <linux-pm@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>Linux
List-Id: linux-pm@vger.kernel.org

On Tue, 9 Apr 2019 at 17:01, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Apr 9, 2019 at 1:57 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Wed, 27 Mar 2019 at 15:35, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > Changes in v13:
> > >  - Use WRITE|READ_ONCE when reading/writing the "next_hrtimer" variable in the
> > > struct cpuidle_device. Also reset the same variable after resumed from idle to
> > > avoid it from containing a stale value.
> > >  - Added acks from Daniel Lezcano.
> > >  - The entire v13 series, including the PSCI/ARM changes are available in a
> > > git branch [3].
> >
> > Rafael, I have address the received comments on this version $subject
> > series, is there anything that is holding you back from queuing it?
> >
> > If you like I can send a pull-request, to simplify for you.
>
> I will get to this one shortly.  I've been waiting for possible
> comments on patch [3/4], but since no one has commented so far, it
> seems to be non-controversial. :-)
>
> I'm going to add this material to the cpuidle branch rather than genpd.

Sound good to me, thanks!

>
> > Moreover, there is another series which I have pinged you about
> > earlier, which I would appreciate to queue via your tree. It's acked
> > by PSCI maintainers and is ready to go. "[PATCH v2 0/5] drivers:
> > firmware: psci: Some cleanup and refactoring".
>
> If you want me to merge the PSCI series, please resent it with a
> request to that end in the cover letter.  Also please let me know
> whether or not it depends on the $subject series.

No dependency, but I am using it as a base for a future series that I
will post as soon as you have queued it.

So, I have just resent the series, as per your request. If there is
anything else, just let me know.

Kind regards
Uffe
