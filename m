From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v12 3/4] cpuidle: Export the next timer/tick expiration
 for a CPU
Date: Tue, 26 Mar 2019 11:36:29 +0100
Message-ID: <CAJZ5v0gHpX0=Urwj5z+FS=PKibM1VO0B5ZEQvwnvqXbUV_=fpg@mail.gmail.com>
References: <20190227195836.24739-1-ulf.hansson@linaro.org>
 <20190227195836.24739-4-ulf.hansson@linaro.org> <2942111.nn8VVVUCAL@aspire.rjw.lan>
 <CAPDyKFr-zjhvQr-2FtiNyDig60zM=raY7+=G_dtA+H9g49RV8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFr-zjhvQr-2FtiNyDig60zM=raY7+=G_dtA+H9g49RV8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>Linux
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 25, 2019 at 3:24 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 25 Mar 2019 at 13:21, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Wednesday, February 27, 2019 8:58:35 PM CET Ulf Hansson wrote:
> > > To be able to predict the sleep duration for a CPU that is entering idle,
> > > knowing when the next timer/tick is going to expire, is extremely useful.
> > > Both the teo and the menu cpuidle governors already makes use of this
> > > information, while selecting an idle state.
> > >

[cut]

> >
> > > +
> > >       if (cpuidle_state_is_coupled(drv, index))
> > >               return cpuidle_enter_state_coupled(dev, drv, index);
> > >       return cpuidle_enter_state(dev, drv, index);
> >
> > Also I would clear next_hrtimer here to avoid dragging stale values
> > around.
>
> Right, I can do that.
>
> However, at least in my case it would be an unnecessary update of the
> variable, as I am never in a path where the value can be "stale".

It easily can AFAICS.  After all, cpu_power_down_ok() need not run on
the same CPU that is setting next_hrtimer here.

> Even if one theoretically could use a stale value, it's seems likely to not
> be an issue, don't you think?

That would be because of the locking in the ->enter() callback I
suppose?  But is it actually universally guaranteed that setting
next_hrtimer will never be reordered with acquiring the lock?

Also, there is some overhead to be avoided if cpu_power_down_ok()
checked the next_hrtimer of the other CPUs against 0 explicitly, isn't
it?
