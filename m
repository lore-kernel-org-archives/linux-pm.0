From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM domains
Date: Thu, 20 Dec 2018 22:37:43 +0100
Message-ID: <CAPDyKFqdeSm56hVB+9dwJekNhZU10DE+-WaWa4m=wdUmjAdAdw@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org> <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
 <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com> <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 20 Dec 2018 at 19:06, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 20/12/2018 16:49, Ulf Hansson wrote:
>
> [ ... ]
>
> >>> +#ifdef CONFIG_CPU_IDLE
> >>
> >> It would be nicer if you can remove the CONFIG_CPU_IDLE by replacing it
> >> with a specific one (eg. CONFIG_PSCI_IDLE) and make it depend on
> >> CONFIG_CPU_IDLE, so the config options stay contained in their
> >> respective subsystems directory.
> >
> > I am all for simplifying the Kconfig options in here, as indeed it's
> > rather messy. However, I would rather avoid folding in additional
> > cleanup changes to this series, is already extensive enough.
> >
> > Would you be okay if we deal with that on top?
>
> IMO, there are patches in this series which can be grouped into a
> cleanup + set the scene patchset and merged immediately. An option
> similar to ARM_SCMI_POWER_DOMAIN can be part of it.

I certainly agree to that. The tricky is, to know what pieces people
are happy with to go in. :-)

Earlier, in v9 I tried your suggested approach (kind of), but then
Lorenzo stated that it's kind of all or nothing. Maybe we can bring up
that discussion again with him and see what we can figure out.

>
> However, if you swear you will do the change after and sign with your
> blood, I'm fine with that 0:)
>

Whatever it takes!

Anyway, as stated, the reason why I want to tackle that on top, is
that I don't want to make the series more extensive than it already
is.

Agree?

Kind regards
Uffe
